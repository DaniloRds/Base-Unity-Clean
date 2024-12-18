local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_revistar",vRPN)
Proxy.addInterface("vrp_revistar",vRPN)


-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaucarro = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local uchests = {}
local vchests = {}
local actived = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local data = vRP.getUserDataTable(nuser_id)
		local weapons = vRPclient.getWeapons(nplayer)
		local money = vRP.getMoney(nuser_id)
		local inventario = {}
		local inventario2 = {}
		if data and data.inventory then
			for k,v in pairs(data.inventory) do
				if vRP.itemBodyList(k) then
					table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
				end
			end
			if money > 0 then
				table.insert(inventario,{ amount = vRP.format(parseInt(money)), name = vRP.itemNameList("carteira"), index = vRP.itemIndexList("carteira"), key = "carteira", type = vRP.itemTypeList("carteira"), peso = vRP.getItemWeight("carteira") })
			end
			for k,v in pairs(weapons) do
				if v.ammo < 1 then
					table.insert(inventario2,{ amount = 1, name = vRP.itemNameList("wbody|"..k), index = vRP.itemIndexList("wbody|"..k), key = k, type = vRP.itemTypeList("wbody|"..k), peso = vRP.getItemWeight("wbody|"..k) })
				else
					table.insert(inventario2,{ amount = 1, name = vRP.itemNameList("wbody|"..k), index = vRP.itemIndexList("wbody|"..k), key = k, type = vRP.itemTypeList("wbody|"..k), peso = vRP.getItemWeight("wbody|"..k) })
					table.insert(inventario2,{ amount = v.ammo, name = vRP.itemNameList("wammo|"..k), index = vRP.itemIndexList("wammo|"..k), key = k, type = vRP.itemTypeList("wammo|"..k), peso = vRP.getItemWeight("wammo|"..k) })
				end
			end
			return inventario,inventario2,vRP.getInventoryWeight(nuser_id),vRP.getInventoryMaxWeight(nuser_id)
		end
	end
end

function vRPN.moneyPlayer()
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local money = vRP.getMoney(nuser_id)
	if nuser_id then
		local money = vRP.getMoney(nuser_id)
		return money
	end
end

function vRPN.progress()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRPclient.isInComa(nplayer) then
		vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		SetTimeout(5000,function()
			vRPclient._stopAnim(source,false)
		end)
	else
		TriggerClientEvent('segurarrevistar',nplayer,source)
		vRPclient.playAnim(source,false,{{"misscarsteal4@director_grip","end_loop_grip"}},true)
		vRPclient.playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
		TriggerClientEvent("progress",source,5000,"revistando")
		TriggerClientEvent("progress",nplayer,5000,"sendo revistado")
		SetTimeout(5000,function()
			vRPclient._stopAnim(source,false)
			vRPclient._stopAnim(nplayer,false)
			TriggerClientEvent('segurarrevistar',nplayer,source)
			TriggerClientEvent("Notify", nplayer, "aviso","Você foi revistado!")
		end)
	end
end

function vRPN.verifyPlayerPerto()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		if not vRP.hasPermission(user_id,"admin.permissao") or not vRP.hasPermission(user_id,"polpar.permissao") then
			if vRP.request(nuser_id,"Você aceita ser revistado?",30) then
				return true
			end
		else
			return true
		end
	else
		TriggerClientEvent("Notify", source, "negado","Não há ninguém perto de você para ser revistado!")
		return false
	end
end