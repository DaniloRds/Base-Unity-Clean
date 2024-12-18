-- [ Variáveis ] --
local items_list = module("cfg/items")
local itemlist = items_list.items
vRP.items = {}
---------------
-- [WEBHOOK] --
---------------
local hook_adm = "" -- verifica o baú setado em cfg/inventory
local hook_monitor = "" -- monitora baus

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

---------------
CreateThread(function()
	for k, v in pairs(itemlist) do
		if v.peso == nil then
			v.peso = 0
		end
		local item = { name = v.name, weight = v.peso }
		vRP.items[k] = item
	end
end)

function vRP.itemList()
	return itemlist
end

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemWeightList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].peso
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

local maxItens = {}

function vRP.giveInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(user_id)
    local amount = parseInt(amount)
    local data = vRP.getInventory(user_id)
    if data and amount > 0 then
        local entry = data[idname]
        if entry then
            entry.amount = entry.amount + amount
        else
            data[idname] = { amount = amount }
        end

        if maxItens[idname] then
            if data[idname].amount > maxItens[idname] then
                data[idname].amount = maxItens[idname]
            end
        end
        TriggerClientEvent("itensNotify",source,"sucesso",""..amount.." "..idname.."",idname)
    end
end

function vRP.tryGetInventoryItem(user_id,idname,amount)
    local source = vRP.getUserSource(user_id)
    local amount = parseInt(amount)
    local data = vRP.getInventory(user_id)
    if data and amount > 0 then
        local entry = data[idname]
        if entry and entry.amount >= amount then
            entry.amount = entry.amount - amount

            if entry.amount <= 0 then
                data[idname] = nil
            end
            
            TriggerClientEvent("itensNotify",source,"negado",""..amount.." "..idname.."",idname)
            return true
        end
    end
    return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

function vRP.clearInventory(user_id)
    local data = vRP.getUserDataTable(user_id)
    if data then
        data.inventory = {}
    end
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        if not vRP.hasPermission(user_id,"mochila.permissao") then
            vRP.setExp(user_id,"physical","strength",20)
        end
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)