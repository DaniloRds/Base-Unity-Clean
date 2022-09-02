-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("voip",cnVRP)
vCLIENT = Tunnel.getInterface("voip")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 9999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,911)
					TriggerClientEvent("hud:RadioDisplay",source,911)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 912 then
				if vRP.hasPermission(user_id,"Police") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("hud:RadioDisplay",source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"Paramedic") then
					vCLIENT.startFrequency(source,112)
					TriggerClientEvent("hud:RadioDisplay",source,112)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"Mechanic") then
					vCLIENT.startFrequency(source,443)
					TriggerClientEvent("hud:RadioDisplay",source,443)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("hud:RadioDisplay",source,parseInt(freq))
				TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
			end

			TriggerClientEvent("hud:RadioDisplay",source,parseInt(freq))
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKRADIO
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.checkRadio()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"radio") >= 1 then
			return true
		end
		return true
	end
end