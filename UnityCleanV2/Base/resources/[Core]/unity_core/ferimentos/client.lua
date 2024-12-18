-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
ferimentos_tunnel = {}
Tunnel.bindInterface("unity_core",ferimentos_tunnel)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DAMAGED
-----------------------------------------------------------------------------------------------------------------------------------------
local damaged = {}
local bleeding = 0
local bleedtype = "Superficial"
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function ferimentos_tunnel.getDiagnostic()
	return damaged
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function ferimentos_tunnel.getBleeding()
	return bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 115 then
			wait = 3
			local hit,bone = GetPedLastDamageBone(ped)
			if hit and not damaged[bone] and bone ~= 0 then
				damaged[bone] = true
				bleeding = bleeding + 1
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 101 then
			if bleeding == 1 then
				bleedtype = "superficial"
			elseif bleeding == 2 then
				bleedtype = "baixo"
			elseif bleeding == 3 then
				bleedtype = "médio"
				SetEntityHealth(ped,GetEntityHealth(ped)-2)
			elseif bleeding == 4 then
				bleedtype = "alto"
				SetEntityHealth(ped,GetEntityHealth(ped)-3)
			elseif bleeding >= 5 then
				bleedtype = "grave"
				SetEntityHealth(ped,GetEntityHealth(ped)-4)
			end
			if bleeding >= 1 and GetEntityHealth(ped) > 101 then
				TriggerEvent("Notify","negado","Sangramento <b>"..bleedtype.."</b> encontrado.",3000)
			end

			if bleeding >= 4 and GetEntityHealth(ped) > 101 then
				SetFlash(0,0,500,100,500)
			end
		end

		Citizen.Wait(15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	damaged = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETWARFARINA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetWarfarina")
AddEventHandler("resetWarfarina",function()
	repeat
		Citizen.Wait(15000)
		bleeding = bleeding - 1
	until bleeding <= 0
		TriggerEvent("Notify","importante","Sangramento paralisado.",8000)
end)