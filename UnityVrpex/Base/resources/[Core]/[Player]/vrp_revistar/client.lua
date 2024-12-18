local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPNserver = Tunnel.getInterface("vrp_revistar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local invOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data)
	FreezeEntityPosition(PlayerPedId(),false)
	StopScreenEffect("MenuMGSelectionIn")
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	invOpen = false
	vRPNserver.chestClose()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ REVISTAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revista',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
		if vRPNserver.verifyPlayerPerto() then
			if not invOpen then
				FreezeEntityPosition(PlayerPedId(),true)
				vRPNserver.progress()
				SetTimeout(5000,function()
                	StartScreenEffect("MenuMGSelectionIn", 0, true)
                	invOpen = true
                	SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu"})
				end)
       	 	end
		end
	end
end)

RegisterNetEvent("player:revistar")
AddEventHandler("player:revistar",function(p1)
	local user_id = vRP.getUserId(source)
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 and not vRP.isHandcuffed() and not IsPedBeingStunned(ped) and not IsPlayerFreeAiming(ped) then
		if vRPNserver.verifyPlayerPerto() then
			if not invOpen then
				FreezeEntityPosition(PlayerPedId(),true)
				vRPNserver.progress()
				TriggerEvent("dynamic:closeSystem")
				SetTimeout(5000,function()
					StartScreenEffect("MenuMGSelectionIn", 0, true)
					invOpen = true
					SetNuiFocus(true,true)
					SendNUIMessage({ action = "showMenu"})
				end)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CARREGAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
other = nil
drag = false
carregado = false

RegisterNetEvent("segurarrevistar")
AddEventHandler("segurarrevistar",function(p1)
    other = p1
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(1)
		if drag and other then
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),ped,4103,11816,0.48,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
			carregado = true
        else
        	if carregado then
				DetachEntity(PlayerPedId(),true,false)
				carregado = false
			end
        end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,inventario2,peso,maxpeso = vRPNserver.Mochila()
	local money = vRPNserver.moneyPlayer() 
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, money = money })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateTrunk")
AddEventHandler("Creative:UpdateTrunk",function(action)
	SendNUIMessage({ action = action })
end)