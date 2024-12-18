-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("vrp_vehCustom",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,perm) then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não possui permissão.",5000)
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPVEHICLEREPAIR
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkVehicleRepair(body)
	local source = source
	local user_id = vRP.getUserId(source)
	-- print(body)
	local valor
	if body > 900 and body < 1000 then
		 valor = 500
	elseif body > 800 and body < 900 then
		 valor = 800
	elseif body > 600 and body < 800 then
		 valor = 1200
	else
		 valor = 1500
	end
	if user_id then
		if vRP.request(source,"Você deseja arrumar o veículo pelo valor de <b>"..valor.."$</b> ?",30) then
			vRP.tryFullPayment(user_id,valor)
			return true
		else
			return false
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_vehCustom:attemptPurchase")
AddEventHandler("vrp_vehCustom:attemptPurchase",function(type,mod)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if type == "engines" or type == "brakes" or type == "transmission" or type == "suspension" or type == "shield" then
			if vRP.tryFullPayment(user_id,parseInt(vehicleCustomisationPrices[type][mod])) then
				TriggerClientEvent("vrp_vehCustom:purchaseSuccessful",source)
			else
				TriggerClientEvent("vrp_vehCustom:purchaseFailed",source)
			end
		else
			if vRP.tryFullPayment(user_id,parseInt(vehicleCustomisationPrices[type])) then
				TriggerClientEvent("vrp_vehCustom:purchaseSuccessful",source)
			else
				TriggerClientEvent("vrp_vehCustom:purchaseFailed",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_vehCustom:updateVehicle")
AddEventHandler("vrp_vehCustom:updateVehicle",function(custom,vehPlate,vehName)
	local userPlate = vRP.getUserByRegistration(vehPlate)
	-- print(vehName,userPlate)
	if userPlate then
		vRP.setSData("custom:u"..parseInt(userPlate).."veh_"..vehName,json.encode(custom))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local inVehicle = {}
RegisterServerEvent("vrp_vehCustom:inVehicle")
AddEventHandler("vrp_vehCustom:inVehicle",function(vehNet,vehPlate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vehNet == nil then
			if inVehicle[user_id] then
				inVehicle[user_id] = nil
			end
		else
			inVehicle[user_id] = { vehNet,vehPlate }
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if inVehicle[user_id] then
		Citizen.Wait(1000)
		TriggerEvent("garages:deleteVehicle",inVehicle[user_id][1],inVehicle[user_id][2])
		inVehicle[user_id] = nil
	end
end)