-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("unity_inventory",cRP)
vSERVER = Tunnel.getInterface("unity_inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	TriggerEvent('hudOff',false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSEINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("unity_inventory:Close")
AddEventHandler("unity_inventory:Close",function(	)
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	TriggerEvent('hudOff',false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSED BUTTON "
-----------------------------------------------------------------------------------------------------------------------------------------                                                
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		if IsControlJustPressed(0,243) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) >= 102 and not vRP.isHandcuff() then
			SetNuiFocus(true,true)
			TransitionToBlurred(1000)
			TriggerEvent('hudOff',true)
			SetCursorLocation(0.5,0.5)
			local carteira,banco,coin,nome,sobrenome,idade,user_id,registro,telefone,job,vip,vipDays,multas = vSERVER.Identidade()
			local imagem_player, ok = vSERVER.fotoPerfil()
			SendNUIMessage({ action = "showMenu", slot = slots, mochila = vSERVER.Mochila(), nome = nome, sobrenome = sobrenome, registro = registro, idade = idade, telefone = telefone, multas = multas, coin = coin, banco = banco, carteira = carteira, job = job, vip = vip,vipDays = vipDays, id = user_id,imagem_player = imagem_player,ok = ok})
			local identity = false
		end
		Citizen.Wait(5)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem",function(data)
	vSERVER.useItem(data.item,data.type,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dropItem",function(data)
	vSERVER.dropItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem",function(data)
	vSERVER.sendItem(data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(data.item,data.amount,data.vehname)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso = vSERVER.Mochila()
	local inventario2, peso2, maxpeso2, vehicleName = vSERVER.portaMalas();
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, veiculo = vehicleName, peso2 = peso2, maxpeso2 = maxpeso2, peso = peso, maxpeso = maxpeso })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
local inRadio = false
function cRP.startFrequency(frequency)
	TriggerEvent("radio:outServers")
	exports.tokovoip_script:addPlayerToRadio(frequency)
	inRadio = true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local plateX = -1133.31
local plateY = 2694.2
local plateZ = 18.81
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ORTiming = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(x,y,z,plateX,plateY,plateZ,true)
			if distance <= 50.0 then
				ORTiming = 4
				DrawMarker(23,plateX,plateY,plateZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,50,0,0,0,0)
			end
		end
		Citizen.Wait(ORTiming)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = GetDistanceBetweenCoords(x,y,z,plateX,plateY,plateZ,true)
			if distance <= 3.0 then
				FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - COLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.plateApply(plate)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.repairVehicle(index,status)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			local fuel = GetVehicleFuelLevel(v)
			if status then
				SetVehicleFixed(v)
				SetVehicleFuelLevel(v,fuel)
				SetVehicleDeformationFixed(v)
				SetVehicleUndriveable(v,false)
			else
				SetVehicleEngineHealth(v,1000.0)
				SetVehicleBodyHealth(v,1000.0)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIRVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.repairTires(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			for i = 0,8 do
				SetVehicleTyreFixed(v,i)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCKPICKVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.lockpickVehicle(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,true,true)
			if GetVehicleDoorsLockedForPlayer(v,PlayerId()) == 1 then
				SetVehicleDoorsLocked(v,false)
				SetVehicleDoorsLockedForAllPlayers(v,false)
			else
				SetVehicleDoorsLocked(v,true)
				SetVehicleDoorsLockedForAllPlayers(v,true)
			end
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
			Wait(200)
			SetVehicleLights(v,2)
			Wait(200)
			SetVehicleLights(v,0)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
function cRP.blockButtons(status)
	blockButtons = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ORTiming = 500
		if blockButtons then
			ORTiming = 4
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,20,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,105,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,327,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,243,true)
		end
		Citizen.Wait(ORTiming)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARACHUTECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.parachuteColors()
	GiveWeaponToPed(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
	SetPedParachuteTintIndex(PlayerPedId(),math.random(7))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkObjects(prop)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	if DoesObjectOfTypeExistAtCoords(x,y,z,0.7,GetHashKey(prop),true) then
		return true
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
local cowCoords = {
	{ 2519.27,4737.13,34.31 },
	{ 2511.97,4746.31,34.31 },
	{ 2503.51,4754.91,34.31 },
	{ 2494.99,4762.82,34.38 },
	{ 2472.8,4761.66,34.31 },
	{ 2464.73,4770.15,34.38 },
	{ 2457.19,4777.66,34.5 },
	{ 2448.75,4786.42,34.64 },
	{ 2441.27,4793.63,34.67 },
	{ 2432.51,4802.7,34.83 },
	{ 2400.45,4777.87,34.55 },
	{ 2409.17,4767.99,34.31 },
	{ 2416.74,4761.18,34.31 },
	{ 2424.82,4752.49,34.31 },
	{ 2433.06,4745.04,34.31 },
	{ 2440.76,4736.46,34.31 }
}

function cRP.checkFountain()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	if DoesObjectOfTypeExistAtCoords(x,y,z,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(x,y,z,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CASHREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function cRP.cashRegister()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(registerCoords) do
		local distance = GetDistanceBetweenCoords(x,y,z,v[1],v[2],v[3],true)
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(x,y,z,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		local x2,y2,z2 = table.unpack(GetEntityCoords(object))
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		SetPedComponentVariation(ped,5,45,0,2)
		return true,x2,y2,z2
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateRegister(status)
	registerCoords = status
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADFISH
-----------------------------------------------------------------------------------------------------------------------------------------
local fishingX = -1306.9
local fishingY = 5823.34
local fishingZ = 2.31
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingStatus()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local distance = GetDistanceBetweenCoords(x,y,z,fishingX,fishingY,fishingZ,true)
	if distance <= 400 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMAÇÃO DE RECARREGAR ARMA AO USAR AS MUNIÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("recarregar:animacao")
AddEventHandler("recarregar:animacao", function()
    local ped = PlayerPedId() 
    TaskReloadWeapon(ped)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Inventory:Update")
AddEventHandler("Inventory:Update",function(action)
    SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ USO REMÉDIO ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local usandoRemedios = false
RegisterNetEvent("remedios")
AddEventHandler("remedios",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
    SetPedArmour(ped,armour)
    
    if GetEntityHealth(ped) <= 239 then
        TriggerEvent("Notify","negado","<b>O remédio não fara feito, pois você precisa de tratamento</b>.",8000)
    else
        if usandoRemedios then
            return
        end

        usandoRemedios = true

        if usandoRemedios then
            repeat
                Citizen.Wait(600)
                if GetEntityHealth(ped) > 239 then
                    SetEntityHealth(ped,GetEntityHealth(ped)+1)
                end
            until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 240
                TriggerEvent("Notify","sucesso","O medicamento acabou de fazer efeito.",8000)
                usandoRemedios = false
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRATAMENTO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tratamento = false
RegisterNetEvent("bandagemnova")
AddEventHandler("bandagemnova",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
	--SetPedArmour(ped,armour)
	TriggerEvent("alt666",armour)
	
	if tratamento then
			--return
	end

		tratamento = true
		TriggerEvent("Notify","sucesso","Bandagem Utilizada com Sucesso!",8000)
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if tratamento then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 300 or GetEntityHealth(ped) <= 101
				--TriggerEvent("Notify","sucesso","Bandagem terminou de fazer efeito.",8000)
				tratamento = false
		end
	--end
end)