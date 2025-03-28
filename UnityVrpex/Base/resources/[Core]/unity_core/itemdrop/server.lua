local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local markers_ids = Tools.newIDGenerator()
local items = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookpegaritem = ""
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

AddEventHandler('DropSystem:create',function(item,count,px,py,pz,tempo)
	local id = markers_ids:gen()
	if id then
		items[id] = { item = item, count = count, x = px, y = py, z = pz, name = vRP.itemNameList(item), tempo = tempo }
		TriggerClientEvent('DropSystem:createForAll',-1,id,items[id])
	end
end)

RegisterServerEvent('DropSystem:drop')
AddEventHandler('DropSystem:drop',function(item,count)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,item,count)
		TriggerClientEvent('DropSystem:createForAll',-1)
	end
end)

RegisterServerEvent('DropSystem:take')
AddEventHandler('DropSystem:take',function(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if items[id] ~= nil then
			local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(items[id].item)*items[id].count
			if new_weight <= vRP.getInventoryMaxWeight(user_id) then
				if items[id] == nil then
					return
				end
				local d = items[id]
				items[id] = nil

				vRP.giveInventoryItem(user_id,d.item,d.count)
				vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
				local identity = vRP.getUserIdentity(user_id)
				SendWebhookMessage(webhookpegaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..d.name.." \n[QUANTIDADE]: "..d.count.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				markers_ids:free(id)
				TriggerClientEvent('DropSystem:remove',-1,id)
			else
				TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(items) do
			if items[k].tempo > 0 then
				items[k].tempo = items[k].tempo - 1
				if items[k].tempo <= 0 then
					items[k] = nil
					markers_ids:free(k)
					TriggerClientEvent('DropSystem:remove',-1,k)
				end
			end
		end
	end
end)