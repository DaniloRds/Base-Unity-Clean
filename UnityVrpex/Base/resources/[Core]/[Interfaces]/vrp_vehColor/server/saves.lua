local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
yRP = {}
Tunnel.bindInterface("vrp_vehColor",yRP)

local oldcustoms = {}
local valorTotal = {}

function yRP.savedbcar(saves)
    local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		--local show = vRP.prompt(source, "copie", ""..json.encode(saves))
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		--print(json.encode(saves.colour.custom.primary))
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			 if puser_id then
			 	local custom = {}
				-- print("OPA",saves.colour.custom.secondary,saves.colour.custom.primary)
				custom.colorp = saves.colour.custom.primary
				custom.colors = saves.colour.custom.secondary
				-- custom.smokecolor = saves.smoke
				-- custom.smokecolor = saves.colour.smoke
				-- custom.tyresmoke = saves.fumaca
			 	custom.extracolor = {saves.colour.pearlescent,saves.colour.wheel}				
				vRP.setSData("color:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))
			end
		end
	end
end

function yRP.getPlayerTotalMoney()
    local source = source
    local user_id = vRP.getUserId(source)
    local fullmoney  = vRP.getMoney(user_id) + vRP.getBankMoney(user_id)
    return fullmoney
end

local valor = {}

function yRP.getValues(type)
    return itemPrices[type].price
end

function yRP.validateBuy(vehSelected)
end

function yRP.resetCustoms(vehSelected)
end

function yRP.verCustoms(table)
end

function yRP.getPrices(type)
	local source = source
    local user_id = vRP.getUserId(source)
	local fullmoney  = vRP.getMoney(user_id) + vRP.getBankMoney(user_id)
	local prices = 0
	if type ~= -1 then
		prices = itemPrices[type].price
	end
	return prices,fullmoney
end

function yRP.saveOldCustom(table)
	local source = source
	local user_id = vRP.getUserId(source)
	oldcustoms[user_id] = table
end

function yRP.updateMoney(index)
	local source = source
	local user_id = vRP.getUserId(source)
	local fullmoney  = vRP.getMoney(user_id) + vRP.getBankMoney(user_id)
	local valorPintura = 2000
	if fullmoney >= valorPintura then
		vRP.tryFullPayment(user_id,valorPintura)
		TriggerClientEvent("Notify",source,"sucesso","A cor foi aplicada e envernizada com sucesso, foi descontado $"..valorPintura.." da sua conta.",5000)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui $"..valorPintura.." em sua conta.",5000)
		return false
	end

end

function yRP.somar(valorItem)
	local source = source
	local user_id = vRP.getUserId(source)
	if valorTotal[user_id] then
		valorTotal[user_id] = valorTotal[user_id] + valorItem
	else
		valorTotal[user_id] = valorItem
	end
end

function yRP.getTotal()
	local source = source
	local user_id = vRP.getUserId(source)
	return valorTotal[user_id]
end

function yRP.startTotal()
	local source = source
	local user_id = vRP.getUserId(source)
	valorTotal[user_id] = 0
end

function yRP.getPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,perm) then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui permissão.",5000)
		return false
	end
end

function yRP.getCustoms()
	local source = source
	local user_id = vRP.getUserId(source)
	return oldcustoms[user_id]
end

function yRP.updateOld(data)
	local source = source
	local user_id = vRP.getUserId(source)
	oldcustoms[user_id] = data
end



