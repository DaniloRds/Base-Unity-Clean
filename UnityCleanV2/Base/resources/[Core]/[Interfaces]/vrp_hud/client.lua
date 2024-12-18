local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface('vrp_hud')
src = {}
Tunnel.bindInterface('vrp_hud', src)

local sBuffer = {}
local vBuffer = {}
local CintoSeguranca = false
local ExNoCarro = false
local hunger = 100
local thirst = 100
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATIVAR/DESATIVAR FOME E SEDE
-----------------------------------------------------------------------------------------------------------------------------------------
local fomeSede = config_fomeSede

-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusFome")
AddEventHandler("statusFome",function(number)
	hunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("statusSede")
AddEventHandler("statusSede",function(number)
	thirst = parseInt(number)
end)

Citizen.CreateThread( function()
	while true do
		thirst,hunger = vSERVER.getStats()
		Citizen.Wait(500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DATA E HORA
-----------------------------------------------------------------------------------------------------------------------------------------
function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDateToDisplay()
	month = GetClockMonth()
	dayOfMonth = GetClockDayOfMonth()
	if month == 0 then
		month = "Janeiro"
	elseif month == 1 then
		month = "Fevereiro"
	elseif month == 2 then
		month = "Março"
	elseif month == 3 then
		month = "Abril"
	elseif month == 4 then
		month = "Maio"
	elseif month == 5 then
		month = "Junho"
	elseif month == 6 then
		month = "Julho"
	elseif month == 7 then
		month = "Agosto"
	elseif month == 8 then
		month = "Setembro"
	elseif month == 9 then
		month = "Outubro"
	elseif month == 10 then
		month = "Novembro"
	elseif month == 11 then
		month = "Dezembro"
	end
end

inCar = false
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		inCar = IsPedInAnyVehicle(ped, false)
		if inCar then 
			sleep = 300
			local x,y,z = table.unpack(GetEntityCoords(ped,false))
			vehicle = GetVehiclePedIsIn(ped, false)
			local vida = (GetEntityHealth(GetPlayerPed(-1))-100)/config_vida*100
			local armour = GetPedArmour(ped)
			CalculateTimeToDisplay()
			CalculateDateToDisplay()
			local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
			local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))
			SendNUIMessage({
				action = "inCar",
				health = vida,
				street = street,
				day = dayOfMonth, 
				fomeSede = fomeSede,
				month= month,
				hour = hour,
				minute = minute,
				armour = armour,
				stamina = stamina,
				logo = config_logo,
				cupom = config_cupom,
				fome = parseInt(hunger),
				sede = parseInt(thirst),		
				inCar = inCar,	
			})	
		
		end

		Citizen.Wait(sleep)	
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		if inCar then 
			sleep = 50
			local speed = math.ceil(GetEntitySpeed(vehicle) * 3.605936)
			local fuel = GetVehicleFuelLevel(vehicle)
			
			rpm = GetVehicleCurrentRpm(vehicle)
            rpm = math.ceil(rpm * 10000, 2)
			gear = GetVehicleCurrentGear(vehicle)

            if speed == 0 then 
                gear = 'N'
            elseif gear == 0 then 
                gear = 'R'
            end 

			locked = GetVehicleDoorLockStatus(vehicle)

            vehicleNailRpm = 280 - math.ceil( math.ceil((rpm-2000) * 140) / 10000)
			SendNUIMessage({
				only = "updateSpeed",
				speed = speed,
				fuel = parseInt(fuel),
				fomeSede = fomeSede,
				rpmnail = vehicleNailRpm,
				fome = parseInt(hunger),
				sede = parseInt(thirst),
                rpm = rpm/100,
				gear = gear,
				locked = locked,
				cinto = CintoSeguranca,
				inCar = inCar,
			})			
		end
		Citizen.Wait(sleep)	
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		if not inCar then 
			sleep = 250
			DisplayRadar(false)
					
			CalculateTimeToDisplay()
			CalculateDateToDisplay()

			local ped = PlayerPedId()
			local vida = (GetEntityHealth(GetPlayerPed(-1))-100)/config_vida*100
			local armour = GetPedArmour(ped)
			local stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId())
			local x,y,z = table.unpack(GetEntityCoords(ped,false))
			local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(x,y,z))

			-- print(GetEntityHealth(ped))
	

			SendNUIMessage({
				action = "update",
				health = vida,
				day = dayOfMonth, 
				month= month,
				street = street,
				fomeSede = fomeSede,
				hour = hour,
				minute = minute,
				armour = armour,
				logo = config_logo,
				cupom = config_cupom,
				fome = parseInt(hunger),
				sede = parseInt(thirst),
				inCar = inCar,
				stamina = stamina
			})			

		else
			DisplayRadar(true)
		end
		Citizen.Wait(sleep)	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)

		if car ~= 0 and (ExNoCarro or IsCar(car)) then
			ExNoCarro = true
			if CintoSeguranca then
				DisableControlAction(0,75)
			end

			timeDistance = 4
			sBuffer[2] = sBuffer[1]
			sBuffer[1] = GetEntitySpeed(car)

			if sBuffer[2] ~= nil and not CintoSeguranca and GetEntitySpeedVector(car,true).y > 1.0 and sBuffer[1] > 10.25 and (sBuffer[2] - sBuffer[1]) > (sBuffer[1] * 0.255) then
				SetEntityHealth(ped,GetEntityHealth(ped)-10)
				TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
			end

			if IsControlJustReleased(1,47) then
				if CintoSeguranca then
					TriggerEvent("vrp_sound:source","unbelt",0.5)
					CintoSeguranca = false
				else
					TriggerEvent("vrp_sound:source","belt",0.5)
					CintoSeguranca = true
				end
			end
		elseif ExNoCarro then
			ExNoCarro = false
			CintoSeguranca = false
			sBuffer[1],sBuffer[2] = 0.0,0.0
		end
		Citizen.Wait(timeDistance)
	end
end)
--
RegisterCommand("cr",function(source,args)
	local veh = GetVehiclePedIsIn(PlayerPedId(),false)
	local maxspeed = GetVehicleMaxSpeed(GetEntityModel(veh))
	local vehspeed = GetEntitySpeed(veh)*3.605936
	if GetPedInVehicleSeat(veh,-1) == PlayerPedId() and math.ceil(vehspeed) >= 0 and GetEntityModel(veh) ~= -2076478498 and not IsEntityInAir(veh) then
		if args[1] == nil then
			SetEntityMaxSpeed(veh,maxspeed)
			TriggerEvent("Notify","sucesso","Limitador de Velocidade desligado com sucesso.")
		else
			SetEntityMaxSpeed(veh,0.45*args[1]-0.45)
			TriggerEvent("Notify","sucesso","Velocidade máxima travada em <b>"..args[1].." KM/H</b>.")
		end
	end
end)

--[ATIVAR/DESATIVAR HUD]

RegisterNetEvent("hudOff")
AddEventHandler("hudOff",function(status)
	local booleano = status
	SendNUIMessage({ hudoff = booleano })
end)


RegisterCommand("hud",function(source,args)
    hudoff = not hudoff
	SendNUIMessage({hudoff = hudoff})			
end)

-- Alerta e dano da fome e sede
alertmaxfome = false
alertmaxsede = false
alertfome = false
alertsede = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        local ped = GetPlayerPed(-1)
        local health = GetEntityHealth(ped)
        local newhealth = health - 1

        if thirst >= 95 then
            -- TransitionToBlurred(1000)
            alertmaxfome = true
            SetEntityHealth(ped, newhealth)
			Citizen.Wait(20000)
			TriggerEvent("Notify","sede","Você está com muita SEDE, beba algo!")
        end
        if hunger >= 95 then 
            -- TransitionToBlurred(1000)
            alertmaxsede = true
            SetEntityHealth(ped, newhealth)
			Citizen.Wait(20000)
			TriggerEvent("Notify","fome","Você está com muita FOME, coma algo!")
        end
            
        if hunger <= 95 and thirst <= 95 and GetEntityHealth(PlayerPedId()) >= 102 then
            -- TransitionFromBlurred(1000)
            alertmaxsede = false
            alertmaxfome = false
        end

    end
end)

-- Eventos da HUD (Não mexer se não souber o que está fazendo)

AddEventHandler("hud:talkingState", function(number)
    SendNUIMessage({action = "proximity", number = number})
end)

RegisterNetEvent("hud:talknow")
AddEventHandler("hud:talknow", function(boolean)
    SendNUIMessage({action = "talking", falando = boolean})
end)

RegisterNetEvent("hud:radio")
AddEventHandler("hud:radio", function(freq)
    SendNUIMessage({action = "connect-radio", freq = freq})
end)

RegisterNetEvent("hud:talk-radio")
AddEventHandler("hud:talk-radio", function(boolean)
    SendNUIMessage({action = "talking-radio", radio = boolean})
	--print(radio)
end)

RegisterNetEvent("hud:channel")
AddEventHandler("hud:channel", function(text)
    SendNUIMessage({action = "channel", text = text})
end)

RegisterNetEvent("progress")
AddEventHandler("progress",function(time,text)
	SendNUIMessage({ type = "ui", display = true, time = time, text = text})
end)