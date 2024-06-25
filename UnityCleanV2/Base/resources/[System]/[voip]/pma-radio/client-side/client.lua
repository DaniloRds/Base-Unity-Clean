-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())
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
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("radio",function(source,args)
	if vSERVER.checkRadio() then
		if GetEntityHealth(PlayerPedId()) > 101 and not vRP.isHandcuffed() then
			if args[1] == "s" then
				TriggerEvent("radio:outServers")
				TriggerEvent("Notify","importante","Você saiu de todas as frequências.",8000)
			else
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /TOGGLENUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp_radio:toggleNui')
AddEventHandler('vrp_radio:toggleNui',function(status)
	if status and not vRP.isHandcuffed() then
		SetNuiFocus(true,true)
		SendNUIMessage({ action = "showMenu" })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("activeFrequency",function(data)
	if parseInt(data.freq) >= 1 and parseInt(data.freq) <= 999 then
		vSERVER.activeFrequency(data.freq)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("inativeFrequency",function(data)
	TriggerEvent("radio:outServers")
	TriggerEvent("Notify","importante","Você saiu de todas as frequências.",8000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startFrequency(frequency)
	TriggerEvent("radio:outServers")
	exports["pma-voice"]:setRadioChannel(frequency)
	exports["pma-voice"]:setVoiceProperty('radioEnabled',true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
	exports["pma-voice"]:removePlayerFromRadio()
	exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
	TriggerEvent("hud:radio",parseInt(0))
end)

RegisterCommand("volume",function(source,args)
    if tonumber(args[1]) <= 100 and tonumber(args[1]) >= 10 then
        local volume = tonumber(args[1])
        exports["pma-voice"]:setRadioVolume(volume/100)
        TriggerEvent("Notify","sucesso","<b>Volume:</b> "..volume.."%",5000)
    end
end)