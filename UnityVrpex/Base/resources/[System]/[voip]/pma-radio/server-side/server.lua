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
Tunnel.bindInterface(GetCurrentResourceName(),cnVRP)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function cnVRP.activeFrequency(freq)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if parseInt(freq) >= 1 and parseInt(freq) <= 999 then
			if parseInt(freq) == 911 then
				if vRP.hasPermission(user_id,"policia.permissao") then
					vCLIENT.startFrequency(source,911)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 912 then
				if vRP.hasPermission(user_id,"policia.permissao") then
					vCLIENT.startFrequency(source,912)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 112 then
				if vRP.hasPermission(user_id,"paramedico.permissao") then
					vCLIENT.startFrequency(source,112)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			elseif parseInt(freq) == 443 then
				if vRP.hasPermission(user_id,"mecanico.permissao") then
					vCLIENT.startFrequency(source,443)
					TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
				end
			else
				vCLIENT.startFrequency(source,parseInt(freq))
				TriggerClientEvent("Notify",source,"sucesso","Rádio <b>"..parseInt(freq)..".0Mhz</b>.",5000)
			end
			TriggerClientEvent("hud:radio",source,parseInt(freq))
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
		return false
	end
end