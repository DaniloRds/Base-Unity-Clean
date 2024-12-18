-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vCLIENT = {}
Tunnel.bindInterface("dynamic",vCLIENT)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER:PRESETFUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("player:outfitFunctions")
AddEventHandler("player:outfitFunctions",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if mode == "aplicar" then
			local data = vRP.getUData(user_id,"vRP:saveClothes")
			local result = json.decode(data) or 0
			local model = vRP.modelPlayer(source)
			-- print(json.encode(result))
			if result ~= nil then
				TriggerClientEvent("updateRoupas",source,result)
				
				-- vRPclient.setCustomization(source,json.encode(result))
				TriggerClientEvent("Notify",source,"verde","Roupas aplicadas.",3000)
			else
				TriggerClientEvent("Notify",source,"amarelo","Roupas não encontradas.",3000)
			end
		elseif mode == "salvar" then
			-- local checkBackpack = vSKINSHOP.checkBackpack(source)
			-- if not checkBackpack then
				local custom = vRPclient.getCustomization(source)
				local model = vRP.modelPlayer(source)
				-- print(custom)
				if custom then
					vRP.setUData(user_id,"vRP:saveClothes",json.encode(custom))
					TriggerClientEvent("Notify",source,"sucesso","Roupas salvas.",3000)
				end
			-- else
				-- TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
			-- end
		elseif mode == "presalvar" then
			if vRP.getVipActive(user_id) then
				-- local checkBackpack = vSKINSHOP.checkBackpack(source)
				-- if not checkBackpack then
					local custom = vRP.getCustomization(source)
					if custom then
						vRP.setSData("premClothes:"..user_id,custom)
						TriggerClientEvent("Notify",source,"verde","Roupas salvas.",3000)
					end
				-- else
					-- TriggerClientEvent("Notify",source,"amarelo","Remova do corpo o acessório item.",5000)
				-- end
			end
		end
	end
end)

function vCLIENT.paramedicPerm()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		return true
	end
end

function vCLIENT.policePerm()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		return true
	end
end

function vCLIENT.mechanicPerm()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"mec.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		return true
	end
end

