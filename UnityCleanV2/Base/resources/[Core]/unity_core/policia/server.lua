local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

policia_tunnel = {}
Tunnel.bindInterface("unity_core",policia_tunnel)
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookprender = ""
local webhookmultas = ""
local webhookocorrencias = ""
local webhookdetido = ""
local webhookparamedico = ""
local webhookmecanico = ""
local webhookre = ""
local webhookpoliciaapreendidos = ""
local webhookpoderes = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDERall
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"wbodyWEAPON_DAGGER",
	"wbodyWEAPON_BAT",
	"wbodyWEAPON_BOTTLE",
	"wbodyWEAPON_CROWBAR",
	"wbodyWEAPON_FLASHLIGHT",
	"wbodyWEAPON_GOLFCLUB",
	"wbodyWEAPON_HAMMER",
	"wbodyWEAPON_HATCHET",
	"wbodyWEAPON_KNUCKLE",
	"wbodyWEAPON_KNIFE",
	"wbodyWEAPON_MACHETE",
	"wbodyWEAPON_SWITCHBLADE",
	"wbodyWEAPON_NIGHTSTICK",
	"wbodyWEAPON_WRENCH",
	"cartaoclonado",
	"cartaodecredito",
	"heroin",
	"eter",
	"cloroformio",
	"wbodyWEAPON_BATTLEAXE",
	"wbodyWEAPON_POOLCUE",
	"wbodyWEAPON_STONE_HATCHET",
	"wbodyWEAPON_PISTOL",
	"wbodyWEAPON_COMBATPISTOL",
	"wbodyWEAPON_CARBINERIFLE",
	"wbodyWEAPON_SMG",
	"wbodyWEAPON_PUMPSHOTGUN_MK2",
	"wbodyWEAPON_STUNGUN",
	"wbodyWEAPON_NIGHTSTICK",
	"wbodyWEAPON_SNSPISTOL",
	"wbodyWEAPON_MICROSMG",
	"wbodyWEAPON_ASSAULTRIFLE",
	"wbodyWEAPON_FIREEXTINGUISHER",
	"wbodyWEAPON_FLARE",
	"wbodyWEAPON_REVOLVER",
	"wbodyWEAPON_PISTOL_MK2",
	"wbodyWEAPON_VINTAGEPISTOL",
	"wbodyWEAPON_MUSKET",
	"wbodyWEAPON_GUSENBERG",
	"wbodyWEAPON_ASSAULTSMG",
	"wbodyWEAPON_COMBATPDW",
	"wbodyWEAPON_COMPACTRIFLE",
	"wbodyWEAPON_CARBINERIFLE_MK2",
 	"wbodyWEAPON_MACHINEPISTOL",
	"wammoWEAPON_DAGGER",
	"wammoWEAPON_BAT",
	"wammoWEAPON_BOTTLE",
	"wammoWEAPON_CROWBAR",
	"wammoWEAPON_FLASHLIGHT",
	"wammoWEAPON_GOLFCLUB",
	"wammoWEAPON_HAMMER",
	"wammoWEAPON_HATCHET",
	"wammoWEAPON_KNUCKLE",
	"wammoWEAPON_KNIFE",
	"wammoWEAPON_MACHETE",
	"wammoWEAPON_SWITCHBLADE",
	"wammoWEAPON_NIGHTSTICK",
	"wammoWEAPON_WRENCH",
	"wammoWEAPON_BATTLEAXE",
	"wammoWEAPON_POOLCUE",
	"wammoWEAPON_STONE_HATCHET",
	"wammoWEAPON_PISTOL",
	"wammoWEAPON_COMBATPISTOL",
	"wammoWEAPON_CARBINERIFLE",
	"wammoWEAPON_SMG",
	"wammoWEAPON_PUMPSHOTGUN",
	"wammoWEAPON_PUMPSHOTGUN_MK2",
	"wammoWEAPON_STUNGUN",
	"wammoWEAPON_NIGHTSTICK",
	"wammoWEAPON_SNSPISTOL",
	"wammoWEAPON_MICROSMG",
	"wammoWEAPON_ASSAULTRIFLE",
	"wammoWEAPON_FIREEXTINGUISHER",
	"wammoWEAPON_FLARE",
	"wammoWEAPON_REVOLVER",
	"wammoWEAPON_PISTOL_MK2",
	"wammoWEAPON_VINTAGEPISTOL",
	"wammoWEAPON_MUSKET",
	"wammoWEAPON_GUSENBERG",
	"wammoWEAPON_ASSAULTSMG",
	"wammoWEAPON_COMBATPDW",
	"wammoWEAPON_MACHINEPISTOL",
	"wammoWEAPON_CARBINERIFLE_MK2",
	"wammoWEAPON_COMPACTRIFLE"
}

RegisterCommand('apreenderall',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local user_id = vRP.getUserId(source)

		local nplayer = vRP.getUsers()
        for k,v in pairs(nplayer) do
			local nplayer = vRP.getUserSource(k)

		--local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local nidentity = vRP.getUserIdentity(nuser_id)
				local itens_apreendidos = {}
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					--vRP.giveInventoryItem(nuser_id,"wbody"..k,1)
					if v.ammo > 0 then
						--vRP.giveInventoryItem(nuser_id,"wammo"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"|")[1] == idname then
								table.insert(sub_items,fidname)

							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
									--vRP.giveInventoryItem(user_id,idname,amount)
									table.insert(itens_apreendidos, "[ITEM]: "..vRP.itemNameList(idname).." [QUANTIDADE]: "..amount)
								end
							end
						end
					end
				end
				local apreendidos = table.concat(itens_apreendidos, "\n")
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APREENDEU DE]:  "..nuser_id.." "..nidentity.name.." "..nidentity.firstname.."\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLACA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('placa',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") then
		if args[1] then
			local user_id = vRP.getUserByRegistration(args[1])
			if user_id then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
					TriggerClientEvent("Notify",source,"sucesso", "Verificação Concluída <br>RG: "..identity.user_id.."<br> Nome: "..identity.name..""..identity.firstname.."<br> Idade: "..identity.age.."<br> Telefone: "..identity.phone.."",15000)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
			end
		else
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			local placa_user = vRP.getUserByRegistration(placa)
			if placa then
				if placa_user then
					local identity = vRP.getUserIdentity(placa_user)
					if identity then
						local vehicleName = vRP.vehicleName(vname)
						vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
						TriggerClientEvent("Notify",source,"sucesso", "Verificação Concluída <br>RG: "..identity.user_id.."<br> Nome: "..identity.name.." "..identity.firstname.."<br> Idade: "..identity.age.."<br> Telefone: "..identity.phone.."",15000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Placa inválida ou veículo de americano.")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- bvida
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('bvida',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
		vRPclient._setCustomization(source,vRPclient.getCustomization(source))
		TriggerEvent('vrp_tattoo:setPedServer',source)
		TriggerEvent('vrp_barber:setPedServer',source)
		vRP.removeCloak(source)			
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CSS
 ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand('css', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local css = vRP.getUsersByPermission("conce.permissao")
	local paramedicos = 0
	local oficiais_nomes = ""
	if user_id then
		for k,v in ipairs(css) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Vendedor(es) da Concessionária</b> estão em serviço.")
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PTR
 ----------------------------------------------------------------------------------------------------------------------------------------
 RegisterCommand('ptr', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local player = vRP.getUserSource(user_id)
	local oficiais = vRP.getUsersByPermission("cpolicia.permissao")
	local paramedicos = 0
	local oficiais_nomes = ""
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		for k,v in ipairs(oficiais) do
			local identity = vRP.getUserIdentity(parseInt(v))
			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
			paramedicos = paramedicos + 1
		end
		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Oficiais</b> em serviço.")
		if parseInt(paramedicos) > 0 then
			TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMS
 ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ems', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local oficiais = vRP.getUsersByPermission("paramedico.permissao")
 	local paramedicos = 0
 	local paramedicos_nomes = ""
 	if user_id then
 		for k,v in ipairs(oficiais) do
 			local identity = vRP.getUserIdentity(parseInt(v))
 			paramedicos_nomes = paramedicos_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
 			paramedicos = paramedicos + 1
 		end
 		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Paramédicos</b> em serviço.")
 		if parseInt(paramedicos) > 0 then
	 		TriggerClientEvent("Notify",source,"importante", paramedicos_nomes)
	 	end
 	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MECS
 ----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mecs', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local oficiais = vRP.getUsersByPermission("mecanico.permissao")
 	local paramedicos = 0
 	local oficiais_nomes = ""
 	if vRP.hasPermission(user_id,"mecanicolider.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
 		for k,v in ipairs(oficiais) do
 			local identity = vRP.getUserIdentity(parseInt(v))
 			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
 			paramedicos = paramedicos + 1
 		end
 		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Mecânicos</b> em serviço.")
 		if parseInt(paramedicos) > 0 then
 			TriggerClientEvent("Notify",source,"importante", oficiais_nomes)
 		end
 	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- P
-----------------------------------------------------------------------------------------------------------------------------------------
local policia = {}
RegisterCommand('p',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	local identity = vRP.getUserIdentity(user_id)
	local x,y,z = vRPclient.getPosition(source)
	if vRPclient.getHealth(source) > 100 then
		if vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
						TriggerClientEvent("NotifyPush",player,{ code = "TH", title = "Localização Recebida de:", x = x, y = y, z = z, badge = ""..identity.name.." "..identity.firstname.."" })
						--vRPclient._playSound(player,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
			vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		elseif vRP.hasPermission(user_id,"policia.permissao") then
			local soldado = vRP.getUsersByPermission("policia.permissao")
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player and player ~= uplayer then
					async(function()
						local id = idgens:gen()
						policia[id] = vRPclient.addBlip(player,x,y,z,153,84,"Localização de "..identity.name.." "..identity.firstname,0.5,false)
						TriggerClientEvent("NotifyPush",player,{ code = "TH", title = "Localização Recebida de:", x = x, y = y, z = z, badge = ""..identity.name.." "..identity.firstname.."" })
						--vRPclient._playSound(player,"Out_Of_Bounds_Timer","DLC_HEISTS_GENERAL_FRONTEND_SOUNDS")
						SetTimeout(60000,function() vRPclient.removeBlip(player,policia[id]) idgens:free(id) end)
					end)
				end
			end
			TriggerClientEvent("Notify",source,"sucesso","Localização enviada com sucesso.")
			vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"cpolicia.permissao") or vRP.hasPermission(user_id,"juiz.permissao") or vRP.hasPermission(user_id,"advogado.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{64,64,255},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pd',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "cpolicia.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{64,179,255},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"paramedico.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,identity.name.." "..identity.firstname,{255,70,135},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "paramedico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,175,175},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('prisioneiro_roupas:roupa')
AddEventHandler('prisioneiro_roupas:roupa', function()
	local source = source
	local user_id = vRP.getUserId(source)
    if user_id then
		vRP.removeCloak(source)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PODERES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('poderes',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	------------------------------------------------------------------------------------------------------------------
	------------------------------------------- -- STAFF -- --------------------------------------------------------
	------------------------------------------------------------------------------------------------------------------

	if vRP.hasPermission(user_id,"owner.permissao") then
		TriggerEvent('eblips:remove',source)
		vRP.addUserGroup(user_id,"paisana_owner")
		vRPclient.setArmour(source,0)
		TriggerClientEvent("Notify",source,"aviso","Seus poderes foram Desativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========| DESATIVOU SEUS PODERES |==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	elseif vRP.hasPermission(user_id,"paisanaowner.permissao") then
		TriggerEvent('eblips:add',{ name = "owner", src = source, color = 47 })
		vRP.addUserGroup(user_id,"owner")
		TriggerClientEvent("Notify",source,"sucesso","Seus poderes foram Ativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[========| ATIVOU SEUS PODERES |=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	elseif vRP.hasPermission(user_id,"adminpoderes.permissao") then
		vRP.addUserGroup(user_id,"paisana_admin")
		TriggerClientEvent("Notify",source,"aviso","Seus poderes foram Desativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========| DESATIVOU SEUS PODERES |==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	
	elseif vRP.hasPermission(user_id,"paisanadmin.permissao") then
		TriggerEvent('eblips:add',{ name = "admin", src = source, color = 61 })
		vRP.addUserGroup(user_id,"Admin")
		TriggerClientEvent("Notify",source,"sucesso","Seus poderes foram Ativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[========| ATIVOU SEUS PODERES |=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	elseif vRP.hasPermission(user_id,"modpoderes.permissao") then
		vRP.addUserGroup(user_id,"paisana_mod")
		TriggerClientEvent("Notify",source,"aviso","Seus poderes foram Desativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========| DESATIVOU SEUS PODERES |==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	
	elseif vRP.hasPermission(user_id,"paisanamod.permissao") then
		TriggerEvent('eblips:add',{ name = "mod", src = source, color = 61 })
		vRP.addUserGroup(user_id,"Mod")
			TriggerClientEvent("Notify",source,"sucesso","Seus poderes foram Ativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[========| ATIVOU SEUS PODERES |=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	elseif vRP.hasPermission(user_id,"suportepoderes.permissao") then
		vRP.addUserGroup(user_id,"paisana_suporte")
		TriggerClientEvent("Notify",source,"aviso","Seus poderes foram Desativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[===========| DESATIVOU SEUS PODERES |==========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	
	elseif vRP.hasPermission(user_id,"paisanasuporte.permissao") then
		TriggerEvent('eblips:add',{ name = "suporte", src = source, color = 61 })
		vRP.addUserGroup(user_id,"Suporte")
		TriggerClientEvent("Notify",source,"sucesso","Seus poderes foram Ativados!")
		SendWebhookMessage(webhookpoderes,"```prolog\n[STAFF]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[========| ATIVOU SEUS PODERES |=========] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
-- MULTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"cpolicia.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		local motivo = vRP.prompt(source,"Motivo:","")
		if id == "" or valor == "" or motivo == "" then
			return
		end
		local value = vRP.getUData(parseInt(id),"vRP:multas")
		local multas = json.decode(value) or 0
		vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(id))
		local nplayer = vRP.getUserSource(parseInt(id))
		SendWebhookMessage(webhookmultas,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============MULTOU==============] \n[PASSAPORTE]: "..id.." "..identity.name.." "..identity.firstname.." \n[VALOR]: $"..vRP.format(parseInt(valor)).." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		randmoney = math.random(300,500)
		vRP.giveMoney(user_id,parseInt(randmoney))
		TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
		TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
		TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(valor)).." dólares</b>.<br><b>Motivo:</b> "..motivo..".")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OCORRENCIA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ocorrencia',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"cpolicia.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local ocorrencia = vRP.prompt(source,"Ocorrência:","")
		if id == "" or ocorrencia == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
		local identity = vRP.getUserIdentity(parseInt(id))
		local nplayer = vRP.getUserSource(parseInt(id))
		SendWebhookMessage(webhookocorrencias,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============| OCORRENCIA |==============] \n[PASSAPORTE]: "..id.." "..identity.name.." "..identity.firstname.."\n[IDENTIDADE]: "..identity.registration.." \n[TELEFONE]: "..identity.phone.." \n[OCORRENCIA]: "..ocorrencia.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

		TriggerClientEvent("Notify",source,"sucesso","Ocorrência registrada com sucesso.")
		TriggerClientEvent("Notify",nplayer,"importante","Sua <b>Ocorrência</b> foi registrada com sucesso.")
		vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DETIDO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('detido',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"cpolicia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
        local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,5)
        local motivo = vRP.prompt(source,"Motivo:","")
        if motivo == "" then
			return
		end
		local oficialid = vRP.getUserIdentity(user_id)
        if vehicle then
            local puser_id = vRP.getUserByRegistration(placa)
            local rows = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
            if rows[1] then
                if parseInt(rows[1].detido) == 1 then
                    TriggerClientEvent("Notify",source,"importante","Este veículo já se encontra detido.",8000)
                else
                	local identity = vRP.getUserIdentity(puser_id)
                	local nplayer = vRP.getUserSource(parseInt(puser_id))
                	SendWebhookMessage(webhookdetido,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[CARRO]: "..vname.." \n[PASSAPORTE]: "..puser_id.." "..identity.name.." "..identity.firstname.." \n[MOTIVO]: "..motivo.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                    vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })

					randmoney = math.random(90,150)
					vRP.giveMoney(user_id,parseInt(randmoney))
					TriggerClientEvent("Notify",source,"sucesso","Carro apreendido com sucesso.")
					TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
					TriggerClientEvent("Notify",nplayer,"importante","Seu Veículo foi <b>Detido</b>.<br><b>Motivo:</b> "..motivo..".")
					vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
                end
            end
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('prender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"administrador.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
		local crimes = vRP.prompt(source,"Crimes:","")
		if crimes == "" then
			return
		end

		local player = vRP.getUserSource(parseInt(args[1]))
		if player then
			vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(args[2])))
			vRPclient.setHandcuffed(player,false)
			TriggerClientEvent('prisioneiro',player,true)
			vRPclient.teleport(player,673.32,90.96,83.95)
			prison_lock(parseInt(args[1]))
			TriggerClientEvent('removealgemas',player)
			TriggerClientEvent("vrp_sound:source",player,'jaildoor',0.7)
			TriggerClientEvent("vrp_sound:source",source,'jaildoor',0.7)

			
			local oficialid = vRP.getUserIdentity(user_id)
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			
			SendWebhookMessage(webhookprender,"```prolog\n[OFICIAL]: "..user_id.." "..oficialid.name.." "..oficialid.firstname.." \n[==============PRENDEU==============] \n[PASSAPORTE]: "..(args[1]).." "..identity.name.." "..identity.firstname.." \n[TEMPO]: "..vRP.format(parseInt(args[2])).." Meses \n[CRIMES]: "..crimes.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			
			randmoney = math.random(90,150)
			vRP.giveMoney(user_id,parseInt(randmoney))
			TriggerClientEvent("Notify",source,"sucesso","Prisão efetuada com sucesso.")
			TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
			TriggerClientEvent("Notify",nplayer,"importante","Você foi preso por <b>"..vRP.format(parseInt(args[2])).." meses</b>.<br><b>Motivo:</b> "..crimes..".")
			vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
		end 
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESPRENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("desprender",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"owner.permissao") then
		if args[1] then
			vRP.setUData(parseInt(args[1]),"vRP:prisao",json.encode(parseInt(-1)))
			TriggerClientEvent('prisioneiro',player,false)
			prison_lock(parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rg',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if args[1] then
		if vRP.hasPermission(user_id,"ticket.permissao") then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer == nil then
				TriggerClientEvent("Notify",source,"aviso","Passaporte <b>"..vRP.format(args[1]).."</b> indisponível no momento.")
				return
			end
			nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 35%; right: 2.5%; position: absolute; border: 1px solid rgba(0,0,0,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #e9700d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	else
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"cpolicia.permissao") or vRP.hasPermission(user_id,"juiz.permissao") then
			local nplayer = vRPclient.getNearestPlayer(source,2)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local value = vRP.getUData(nuser_id,"vRP:multas")
				local valormultas = json.decode(value) or 0
				local identityv = vRP.getUserIdentity(user_id)
				local identity = vRP.getUserIdentity(nuser_id)
				local carteira = vRP.getMoney(nuser_id)
				local banco = vRP.getBankMoney(nuser_id)
				TriggerClientEvent("Notify",nplayer,"importante","Seu documento está sendo verificado por <b>"..identityv.name.." "..identityv.firstname.."</b>.")
				vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 35%; right: 2.5%; position: absolute; border: 1px solid rgba(0,0,0,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #e9700d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Identidade:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
				vRP.request(source,"Você deseja fechar o registro geral?",1000)
				vRPclient.removeDiv(source,"completerg")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ALGEMAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:algemar")
AddEventHandler("vrp_policia:algemar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if not vRPclient.isHandcuffed(source) then
			if vRP.getInventoryItemAmount(user_id,"algemas") >= 1 then
				if vRPclient.isHandcuffed(nplayer) then
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arresting","a_uncuff"}},false)
					SetTimeout(5000,function()
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
						TriggerClientEvent('removealgemas',nplayer)
					end)
				else
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent('cancelando',nplayer,true)
					TriggerClientEvent('carregar',nplayer,source)
					vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
					vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
					SetTimeout(3500,function()
						vRPclient._stopAnim(source,false)
						vRPclient.toggleHandcuff(nplayer)
						TriggerClientEvent('carregar',nplayer,source)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent('cancelando',nplayer,false)
						TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
						TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
						TriggerClientEvent('setalgemas',nplayer)
					end)
				end
			else
				if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"cpolicia.permissao") then
					if vRPclient.isHandcuffed(nplayer) then
						TriggerClientEvent('carregar',nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arresting","a_uncuff"}},false)
						SetTimeout(5000,function()
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,source)
							TriggerClientEvent("vrp_sound:source",source,'uncuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'uncuff',0.1)
							TriggerClientEvent('removealgemas',nplayer)
						end)
					else
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent('cancelando',nplayer,true)
						TriggerClientEvent('carregar',nplayer,source)
						vRPclient._playAnim(source,false,{{"mp_arrest_paired","cop_p2_back_left"}},false)
						vRPclient._playAnim(nplayer,false,{{"mp_arrest_paired","crook_p2_back_left"}},false)
						SetTimeout(3500,function()
							vRPclient._stopAnim(source,false)
							vRPclient.toggleHandcuff(nplayer)
							TriggerClientEvent('carregar',nplayer,source)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent('cancelando',nplayer,false)
							TriggerClientEvent("vrp_sound:source",source,'cuff',0.1)
							TriggerClientEvent("vrp_sound:source",nplayer,'cuff',0.1)
							TriggerClientEvent('setalgemas',nplayer)
						end)
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARREGAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("vrp_policia:carregar")
AddEventHandler("vrp_policia:carregar",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then	
		if nplayer then
			if not vRPclient.isHandcuffed(source) then
				TriggerClientEvent('carregar',nplayer,source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RMASCARA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rmascara',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rmascara',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCHAPEU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rchapeu',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent('rchapeu',nplayer)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RCAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rcapuz',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isCapuz(nplayer) then
				vRPclient.setCapuz(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Capuz colocado com sucesso.")
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa não está com o capuz na cabeça.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('re',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"reviver.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local identity_user = vRP.getUserIdentity(user_id)
				local nuser_id = vRP.getUserId(nplayer)
				local identity_coma = vRP.getUserIdentity(nuser_id)
				local set_user = "Policia"
				if vRP.hasPermission(user_id,"paramedico.permissao") then
					set_user = "Paramedico"
				end
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()
					SendWebhookMessage(webhookre,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.." \n[REVIVEU]: "..nuser_id.." "..identity_coma.name.." "..identity_coma.firstname .. "\n[SET]: "..set_user..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					vRP.giveMoney(user_id,200)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent('cancelando',source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa estar mais próximo de alguém.")
		end
	end
end)

RegisterServerEvent("hospital:re")
AddEventHandler("hospital:re",function(index,extra)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"reviver.permissao") or vRP.hasPermission(user_id,"paramedico.permissao") or vRP.hasPermission(user_id,"policia.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			if vRPclient.isInComa(nplayer) then
				local identity_user = vRP.getUserIdentity(user_id)
				local nuser_id = vRP.getUserId(nplayer)
				local identity_coma = vRP.getUserIdentity(nuser_id)
				local set_user = "Policia"
				if vRP.hasPermission(user_id,"paramedico.permissao") then
					set_user = "Paramedico"
				end
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
				TriggerClientEvent("progress",source,30000,"reanimando")
				SetTimeout(30000,function()
					SendWebhookMessage(webhookre,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.." \n[REVIVEU]: "..nuser_id.." "..identity_coma.name.." "..identity_coma.firstname .. "\n[SET]: "..set_user..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					vRPclient.killGod(nplayer)
					vRPclient._stopAnim(source,false)
					vRP.giveMoney(user_id,200)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent('cancelando',source,false)
				end)
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa estar mais próximo de alguém.")
		end
	end
end)
-------------------------------------------------------------------------------------------
-- CV
-------------------------------------------------------------------------------------------
RegisterCommand('cv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,8)
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if nplayer and vehicle then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa estar mais próximo da pessoa ou do veículo.")
		end
	end
end)

function policia_tunnel.colocarVeiculo()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,8)
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if nplayer and vehicle then
			vRPclient.putInNearestVehicleAsPassenger(nplayer,7)
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa estar mais próximo da pessoa ou do veículo.")
		end
	end
end
-------------------------------------------------------------------------------------------
-- RV
-------------------------------------------------------------------------------------------
RegisterCommand('rv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end)

function policia_tunnel.removerVeiculo()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,10)
		if nplayer then
			vRPclient.ejectVehicle(nplayer)
		end
	end
end
------------------------------------------------------------------------------------------------------------
-- AutoSequestro
------------------------------------------------------------------------------------------------------------
RegisterCommand('autosequestro',function(source,args,rawCommand)
	vRPclient.setMalas(source)
end)

function policia_tunnel.autosequestro()
	local source = source
	vRPclient.setMalas(source)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APREENDER
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	"dinheirosujo",
	"capsula",
	"algemas",
	"capuz",
	"lockpick",
	"masterpick",
	"orgao",
	"etiqueta",
	"pendrive",
	"relogioroubado",
	"pulseiraroubada",
	"anelroubado",
	"colarroubado",
	"brincoroubado",
	"carteiraroubada",
	"tabletroubado",
	"sapatosroubado",
	"armacaodearma",
	"pecadearma",
	"cartaoclonado",
	"heroin",
	"eter",
	"cloroformio",
	"maconha",
	"metanfetamina",
	"cocaina",
	"lsd",
	"tecidor",
	"logsinvasao",
	"acessodeepweb",
	"keysinvasao",
	"pendriveinformacoes",
	"radio",
	"keycard",
	"colete",
	"c4",
	"serra",
	"raceticket",
	"furadeira",
	"wbodyWEAPON_DAGGER",
	"wbodyWEAPON_BAT",
	"wbodyWEAPON_BOTTLE",
	"wbodyWEAPON_CROWBAR",
	"wbodyWEAPON_FLASHLIGHT",
	"wbodyWEAPON_GOLFCLUB",
	"wbodyWEAPON_HAMMER",
	"wbodyWEAPON_HATCHET",
	"wbodyWEAPON_HEAVYPISTOL",
	"wbodyWEAPON_KNUCKLE",
	"wbodyWEAPON_KNIFE",
	"wbodyWEAPON_MACHETE",
	"wbodyWEAPON_SWITCHBLADE",
	"wbodyWEAPON_NIGHTSTICK",
	"wbodyWEAPON_WRENCH",
	"wbodyWEAPON_BATTLEAXE",
	"wbodyWEAPON_POOLCUE",
	"wbodyWEAPON_STONE_HATCHET",
	"wbodyWEAPON_PISTOL",
	"wbodyWEAPON_COMBATPISTOL",
	"wbodyWEAPON_CARBINERIFLE",
	"wbodyWEAPON_SMG",
	"wbodyWEAPON_PUMPSHOTGUN_MK2",
	"wbodyWEAPON_STUNGUN",
	"wbodyWEAPON_NIGHTSTICK",
	"wbodyWEAPON_SNSPISTOL",
	"wbodyWEAPON_MICROSMG",
	"wbodyWEAPON_ASSAULTRIFLE",
	"wbodyWEAPON_FIREEXTINGUISHER",
	"wbodyWEAPON_FLARE",
	"wbodyWEAPON_REVOLVER",
	"wbodyWEAPON_PISTOL_MK2",
	"wbodyWEAPON_VINTAGEPISTOL",
	"wbodyWEAPON_MUSKET",
	"wbodyWEAPON_GUSENBERG",
	"wbodyWEAPON_ASSAULTSMG",
	"wbodyWEAPON_COMBATPDW",
	"wbodyWEAPON_COMPACTRIFLE",
	"wbodyWEAPON_CARBINERIFLE_MK2",
 	"wbodyWEAPON_MACHINEPISTOL",
	"wammoWEAPON_DAGGER",
	"wammoWEAPON_BAT",
	"wammoWEAPON_BOTTLE",
	"wammoWEAPON_CROWBAR",
	"wammoWEAPON_FLASHLIGHT",
	"wammoWEAPON_GOLFCLUB",
	"wammoWEAPON_HAMMER",
	"wammoWEAPON_HATCHET",
	"wammoWEAPON_KNUCKLE",
	"wammoWEAPON_KNIFE",
	"wammoWEAPON_MACHETE",
	"wammoWEAPON_SWITCHBLADE",
	"wammoWEAPON_NIGHTSTICK",
	"wammoWEAPON_WRENCH",
	"wammoWEAPON_BATTLEAXE",
	"wammoWEAPON_POOLCUE",
	"wammoWEAPON_STONE_HATCHET",
	"wammoWEAPON_PISTOL",
	"wammoWEAPON_COMBATPISTOL",
	"wammoWEAPON_CARBINERIFLE",
	"wammoWEAPON_SMG",
	"wammoWEAPON_PUMPSHOTGUN",
	"wammoWEAPON_PUMPSHOTGUN_MK2",
	"wammoWEAPON_STUNGUN",
	"wammoWEAPON_NIGHTSTICK",
	"wammoWEAPON_SNSPISTOL",
	"wammoWEAPON_MICROSMG",
	"wammoWEAPON_ASSAULTRIFLE",
	"wammoWEAPON_FIREEXTINGUISHER",
	"wammoWEAPON_FLARE",
	"wammoWEAPON_REVOLVER",
	"wammoWEAPON_PISTOL_MK2",
	"wammoWEAPON_VINTAGEPISTOL",
	"wammoWEAPON_MUSKET",
	"wammoWEAPON_GUSENBERG",
	"wammoWEAPON_ASSAULTSMG",
	"wammoWEAPON_COMBATPDW",
	"wammoWEAPON_MACHINEPISTOL",
	"wammoWEAPON_CARBINERIFLE_MK2",
	"wammoWEAPON_COMPACTRIFLE"
}

RegisterCommand('apreender',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"cpolicia.permissao") then
		local user_id = vRP.getUserId(source)

		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			local identity = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			if nuser_id then
				local nidentity = vRP.getUserIdentity(nuser_id)
				local itens_apreendidos = {}
				local weapons = vRPclient.replaceWeapons(nplayer,{})
				for k,v in pairs(weapons) do
					vRP.giveInventoryItem(nuser_id,"wbody"..k,1)
					if v.ammo > 0 then
						vRP.giveInventoryItem(nuser_id,"wammo"..k,v.ammo)
					end
				end

				local inv = vRP.getInventory(nuser_id)
				for k,v in pairs(itemlist) do
					local sub_items = { v }
					if string.sub(v,1,1) == "*" then
						local idname = string.sub(v,2)
						sub_items = {}
						for fidname,_ in pairs(inv) do
							if splitString(fidname,"")[1] == idname then
								table.insert(sub_items,fidname)

							end
						end
					end

					for _,idname in pairs(sub_items) do
						local amount = vRP.getInventoryItemAmount(nuser_id,idname)
						if amount > 0 then
							local item_name,item_weight = vRP.getItemDefinition(idname)
							if item_name then
								if vRP.tryGetInventoryItem(nuser_id,idname,amount,true) then
									vRP.giveInventoryItem(user_id,idname,amount)
									table.insert(itens_apreendidos, "[ITEM]: "..vRP.itemNameList(idname).." [QUANTIDADE]: "..amount)
								end
							end
						end
					end
				end
				local apreendidos = table.concat(itens_apreendidos, "\n")
				SendWebhookMessage(webhookpoliciaapreendidos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APREENDEU DE]:  "..nuser_id.." "..nidentity.name.." "..nidentity.firstname.."\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent("Notify",nplayer,"importante","Todos os seus pertences foram apreendidos.")
				TriggerClientEvent("Notify",source,"importante","Apreendeu todos os pertences da pessoa.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('extras',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
        if vRPclient.isInVehicle(source) then
            TriggerClientEvent('extras',source)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYEXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("tryextras")
AddEventHandler("tryextras",function(index,extra)
    TriggerClientEvent("syncextras",-1,index,parseInt(extra))
end)

--------------------------------------------------------------------------------------------------------------------------------------------------
-- DISPAROS
--------------------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('atirando')
AddEventHandler('atirando',function(x,y,z)
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"cpolicia.permissao") then
			local policiais = vRP.getUsersByPermission("cpolicia.permissao")
			for l,w in pairs(policiais) do
				local player = vRP.getUserSource(w)
				if player then
					TriggerClientEvent('notificacao',player,x,y,z,user_id)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- AVISO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('aviso',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"conce.permissao") or vRP.hasPermission(user_id,"news.permissao") then
		local identity = vRP.getUserIdentity(user_id)
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(0,128,192,0.8); font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 45%; right: 1%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 15px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.." "..identity.firstname)
		SetTimeout(30000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- PRISION LOCK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("prison_lock")
AddEventHandler("prison_lock",function(target_id)
	local source = source
	local player = vRP.getUserSource(parseInt(target_id))
	if player then
		SetTimeout(60000,function()
			local value = vRP.getUData(parseInt(target_id),"vRP:prisao")
			local tempo = json.decode(value) or 0
			if parseInt(tempo) >= 1 then
				TriggerClientEvent("Notify",player,"importante","Ainda vai passar <b>"..parseInt(tempo).." meses</b> preso.",8000)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(parseInt(tempo)-1))
				TriggerEvent("prison_lock",parseInt(target_id))
			elseif parseInt(tempo) == 0 then
				TriggerClientEvent('prisioneiro',player,false)
				vRPclient.teleport(player,739.21,131.09,80.43)
				vRP.setUData(parseInt(target_id),"vRP:prisao",json.encode(-1))
				TriggerClientEvent("Notify",player,"importante","Sua sentença terminou, esperamos não ve-lo novamente.",8000)
			end
			vRPclient.killGod(player)
		end)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUIR PENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("diminuirpena")
AddEventHandler("diminuirpena",function()
	local source = source
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
	local tempo = json.decode(value) or 0
	if tempo >= 20 then
		vRP.setUData(parseInt(user_id),"vRP:prisao",json.encode(parseInt(tempo)-3))
		TriggerClientEvent("Notify",source,"importante","Sua pena foi reduzida em <b>3 meses</b>, continue o trabalho.")
	else
		TriggerClientEvent("Notify",source,"importante","Atingiu o limite da redução de pena, não precisa mais trabalhar.")
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- GUARDAR ARMAS POLICIAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('guardara',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"policia.permissao") then
        TriggerClientEvent('limparArmas',source)
        vRPclient.giveWeapons(source,{["WEAPON_COMBATPISTOL"] = { ammo = 50 }})
    end
end)
--------------------------------------------------------------------------------------------------------------------------------------------------
-- PRISÃO
--------------------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local player = vRP.getUserSource(parseInt(user_id))
	if player then
		SetTimeout(30000,function()
			local value = vRP.getUData(parseInt(user_id),"vRP:prisao")
			local tempo = json.decode(value) or -1

			if tempo == -1 then
				return
			end

			if tempo > 0 then
				TriggerClientEvent('prisioneiro',player,true)
				vRPclient.teleport(player,673.32,90.96,3.95)
				prison_lock(parseInt(user_id))
			end
		end)
	end
end)
















-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESET
-----------------------------------------------------------------------------------------------------------------------------------------
local presets = {
	["cadet"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 47,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 15,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 41,0 },
			[5] = { -1,0 },
			[6] = { 59,1 },
			[7] = { -1,0 },			
			[8] = { 35,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 25,0 },			
			["p0"] = { 13,0 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["officer"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 47,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 15,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 106,21 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,0 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,0 },
			["p0"] = { 10,0 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["corporal"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 47,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 15,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 106,22 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 60,0 },
			[4] = { 30,0 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { 7,1 },
			[10] = { -1,0 },
			[11] = { 232,20 },
			["p0"] = { 10,0 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["sargent"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 87,5,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 58,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 41,1 },
			[5] = { -1,0 },
			[6] = { 59,1 },
			[7] = { -1,0 },			
			[8] = { 35,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 25,1 },			
			["p0"] = { 13,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["liutenet"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 87,14,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 58,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,1 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,1 },
			["p0"] = { 10,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["capitain"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 0,0,1 },
			[4] = { 33,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 58,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 93,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,1 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,1 },
			["p0"] = { 10,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["major"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 17,0,1 },
			[4] = { 33,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 74,3,1 },
			[9] = { -1,0,2 },
			[10] = { -1,0,0 },
			[11] = { 64,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,1 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,1 },
			["p0"] = { 10,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["comando"] = {
		[1885233650] = {
			[1] = { 13,7,2 },
			[3] = { 17,0,1 },
			[4] = { 33,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 72,3,1 },
			[9] = { -1,0,2 },
			[10] = { -1,0,0 },
			[11] = { 151,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,1 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,1 },
			["p0"] = { 10,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["tatico"] = {
		[1885233650] = {
			[1] = { 35,0,1 },
			[3] = { 100,9,1 },
			[4] = { 33,0,1 },
			[5] = { 20,0,2 },
			[6] = { 24,0,1 },
			[7] = { 1,0,1 },
			[8] = { 15,0,1 },
			[9] = { 7,0,1 },
			[10] = { -1,0,0 },
			[11] = { 49,0,1 },
			["p0"] = { 10,0 },
			["p1"] = { 5,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 14,0 },
			[4] = { 49,1 },
			[5] = { -1,0 },
			[6] = { 25,0 },
			[7] = { 1,0 },			
			[8] = { 34,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 84,1 },
			["p0"] = { 10,1 },
			["p1"] = { 11,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["6"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[3] = { 74,0 },
			[4] = { 96,0 },
			[5] = { -1,0 },
			[6] = { 56,1 },
			[7] = { 127,0 },
			[8] = { 56,1 },
			[9] = { -1,0 },
			[10] = { 58,0 },
			[11] = { 250,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 96,0 },
			[4] = { 99,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { 97,0 },
			[8] = { 27,1 },
			[9] = { -1,0 },
			[10] = { 66,0 },
			[11] = { 258,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["7"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[3] = { 81,0 },
			[4] = { 10,0 },
			[5] = { -1,0 },
			[6] = { 56,1 },
			[7] = { 127,0 },			
			[8] = { 56,1 },
			[9] = { -1,0 },
			[10] = { 58,0 },
			[11] = { 95,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 0,0 },
			[3] = { 106,1 },
			[4] = { 37,0 },
			[5] = { 0,0 },
			[6] = { 27,0 },
			[7] = { 97,0 },			
			[8] = { 27,1 },
			[9] = { -1,0 },
			[10] = { 66,0 },
			[11] = { 86,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["8"] = {
		[1885233650] = {
			[1] = { 121,0 },
			[3] = { 38,0 },
			[4] = { 96,0 },
			[5] = { -1,0 },
			[6] = { 56,1 },
			[7] = { 126,0 },			
			[8] = { 71,3 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 249,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,1 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { 121,0 },
			[3] = { 18,0 },
			[4] = { 99,0 },
			[5] = { -1,0 },
			[6] = { 27,0 },
			[7] = { 14,3 },
			[8] = { 77,3 },		
			[9] = { -1,0 },
			[10] = { 65,0 },
			[11] = { 257,0 },		
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	--[[
	["9"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 81,0 },
			[4] = { 25,5 },
			[5] = { -1,0 },
			[6] = { 21,9 },
			[7] = { 126,0 },			
			[8] = { 56,1 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 13,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 85,0 },
			[4] = { 37,5 },
			[5] = { -1,0 },
			[6] = { 10,1 },
			[7] = { 14,3 },		
			[8] = { 27,1 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 27,0 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	]]
	["10"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 4,0 },
			[4] = { 25,5 },
			[5] = { -1,0 },
			[6] = { 21,9 },
			[7] = { 126,0 },			
			[8] = { 31,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 31,7 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 1,0 },
			[4] = { 37,5 },
			[5] = { -1,0 },
			[6] = { 0,2 },
			[7] = { 14,3 },		
			[8] = { 64,2 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 57,7 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["11"] = {
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 74,0 },
			[4] = { 3,3 },
			[5] = { -1,0 },
			[6] = { 7,0 },
			[7] = { 126,0 },			
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },
			[11] = { 16,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
		[-1667301416] = {
			[1] = { -1,0 },
			[3] = { 96,0 },
			[4] = { 3,13 },
			[5] = { -1,0 },
			[6] = { 10,1 },
			[7] = { 14,3 },
			[8] = { 15,0 },
			[9] = { -1,0 },
			[10] = { -1,0 },	
			[11] = { 141,1 },		
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		}
	},
	["devil"] = {
		-- male
		[1885233650] = {
			[1] = { 72,2,2 },
			[3] = { 100,9,1 },
			[4] = { 83,0,1 },
			[5] = { 20,0,2 },
			[6] = { 2,2,1 },
			[7] = { 0,0,2 },			
			[8] = { 11,0,1 },
			[9] = { 0,0,1 },
			[10] = { -1,0,0 },
			[11] = { 220,20,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["devil2"] = {
		-- male
		[1885233650] = {
			[1] = { 136,2,1 },
			[3] = { 37,0,0 },
			[4] = { 10,0,1 },
			[5] = { 0,0,1 },
			[6] = { 61,0,1 },
			[7] = { 0,0,0 },			
			[8] = { 11,0,1 },
			[9] = { 0,0,1 },
			[10] = { 0,0,0 },
			[11] = { 254,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { 15,7 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["angel"] = {
		-- male
		[1885233650] = {
			[1] = { 13,0,1 },
			[3] = { 100,8,1 },
			[4] = { 83,2,1 },
			[5] = { 20,0,2 },
			[6] = { 8,0,1 },
			[7] = { 0,0,2 },			
			[8] = { 11,1,1 },
			[9] = { -1,0,2 },
			[10] = { -1,0,2 },
			[11] = { 90,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { 19,9 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["kong"] = {
		-- male
		[1885233650] = {
			[1] = {96,2,1},
			[2] = {21,0,0},
			[3] = {17,0,1},
			[4] = {35,0,1},
			[5] = {0,0,0},
			[6] = {21,0,1},
			[7] = {0,0,1},
			[8] = {34,0,1},
			[9] = {0,0,1},
			[10] = {0,0,0},
			[11] = {35,0,1},
			["p7"] = {-1,0},
			["p2"] = {29,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			["p6"] = {-1,0},
		},
	},
	["urubu"] = {
		-- male
		[1885233650] = {
			[1] = { 25,0,1 },
			[3] = { 18,0,1 },
			[4] = { 107,0,1 },
			[5] = { 20,0,2 },
			[6] = { 84,0,1 },
			[7] = { 0,0,1 },			
			[8] = { 15,0,0 },
			[9] = { -1,0,2 },
			[10] = { 0,0,0 },
			[11] = { 276,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { 0,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["dino"] = {
		-- male
		[1885233650] = {
			[1] = { 93,0,1 },
			[3] = { 77,0,1 },
			[4] = { 20,0,1 },
			[5] = { 20,0,1 },
			[6] = { 19,0,1 },
			[7] = { 31,0,1 },			
			[8] = { 13,0,0 },
			[9] = { -1,0,2 },
			[10] = { -1,0,2 },
			[11] = { 20,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["dog"] = {
		-- male
		[1885233650] = {
			[1] = { 100,1,2 },
			[3] = { 30,0,1 },
			[4] = { 0,0,1 },
			[5] = { 0,0,0 },
			[6] = { 0,1,1 },
			[7] = { 112,2,1 },			
			[8] = { 15,0,1 },
			[9] = { 0,0,0 },
			[10] = { 0,0,0 },
			[11] = { 1,9,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["coruja"] = {
		-- male
		[1885233650] = {
			[1] = { 19,0,2 },
			[3] = { 0,0,1 },
			[4] = { 6,5,1 },
			[5] = { 20,0,2 },
			[6] = { 31,1,1 },
			[7] = { 43,0,2 },			
			[8] = { 130,0,1 },
			[9] = { 0,0,1 },
			[10] = { -1,0,0 },
			[11] = { 113,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["urso"] = {
		-- male
		[1885233650] = {
			[1] = { 21,0,1 },
			[3] = { 1,0,1 },
			[4] = { 22,0,1 },
			[5] = { -1,0,2 },
			[6] = { 20,0,1 },
			[7] = { 69,0,2 },			
			[8] = { 70,0,1 },
			[9] = { -1,0,2 },
			[10] = { -1,0,2 },
			[11] = { 21,3,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["macacob"] = {
		-- male
		[1885233650] = {
			[1] = { 84,0,1 },
			[3] = { 12,0,0 },
			[4] = { 86,10,1 },
			[5] = { 0,0,1 },
			[6] = { 8,0,1 },
			[7] = { 0,0,1 },			
			[8] = { 11,12,1 },
			[9] = { 0,0,1 },
			[10] = { 0,0,0 },
			[11] = { 220,25,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { 4,0 },
			["p7"] = { -1,0 }
		},
	},
	["gatinho"] = {
		-- male
		[1885233650] = {
			[1] = { 17,1,2 },
			[3] = { 14,0,1 },
			[4] = { 79,2,1 },
			[5] = { 56,0,1 },
			[6] = { 2,1,1 },
			[7] = { 0,0,2 },			
			[8] = { 11,1,1 },
			[9] = { -1,0,0 },
			[10] = { 0,0,0 },
			[11] = { 240,1,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { 4,3 },
			["p7"] = { -1,0 }
		},
	},
	["noel"] = {
		-- male
		[1885233650] = {
			[1] = {8,0,1},
			[2] = {12,0,0},
			[3] = {102,8,1},
			[4] = {33,0,1},
			[5] = {45,0,1},
			[6] = {25,0,1},
			[7] = {8,0,1},
			[8] = {56,0,1},
			[9] = {16,2,1},
			[10] = {0,0,0},
			[11] = {254,0,1},
			["p2"] = {14,1},
			["p6"] = {10,2},
			["p7"] = {-1,0},
			["p0"] = {8,0},
			["p1"] = {15,4},
			[0] = {0,0,0}
		},
	},
	["floquinho"] = {
		-- male
		[1885233650] = {
			[1] = { 10,0,1 },
			[3] = { 75,0,1 },
			[4] = { 10,0,1 },
			[5] = { 45,0,1 },
			[6] = { 77,0,1 },
			[7] = { 36,0,1 },			
			[8] = { 10,0,1 },
			[9] = { 0,0,1 },
			[10] = { 0,0,0 },
			[11] = { 10,0,1 },
			["p0"] = { -1,0 },
			["p1"] = { -1,0 },
			["p2"] = { -1,0 },
			["p6"] = { -1,0 },
			["p7"] = { -1,0 }
		},
	},
	["pinguim"] = {
		-- male
		[1885233650] = {
			[1] = {31,0,0},
			[2] = {53,0,0},
			[3] = {134,0,1},
			[4] = {58,8,1},
			[5] = {0,0,1},
			[6] = {77,0,1},
			[7] = {3,0,1},
			[8] = {11,4,1},
			[9] = {-1,0,0},
			[10] = {-1,0,0},
			[11] = {117,8,1},
			[0] = {0,0,0},
			["p2"] = {-1,0},
			["p6"] = {-1,0},
			["p7"] = {-1,0},
			["p0"] = {13,0},
			["p1"] = {-1,0}
		},
	},
	["viado"] = {
		-- male
		[1885233650] = {
			[1] = {9,0,1},
			[2] = {32,0,0},
			[3] = {33,0,1},
			[4] = {10,0,1},
			[5] = {0,0,0},
			[6] = {10,0,1},
			[7] = {112,2,1},
			[8] = {32,0,1},
			[9] = {0,0,0},
			[10] = {0,0,0},
			[11] = {32,0,1},
			["p2"] = {-1,0},
			["p0"] = {-1,0},
			["p1"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0}			
		},
	},
	["macaco"] = {
		-- male
		[1885233650] = {
			[1] = {3,0,2},
			[2] = {17,0,0},
			[3] = {6,0,1},
			[4] = {28,0,1},
			[5] = {20,0,0},
			[6] = {2,2,1},
			[7] = {25,5,1},
			[8] = {4,0,1},
			[9] = {0,0,1},
			[10] = {0,0,0},
			[11] = {10,0,1},
			["p2"] = {-1,0},
			["p0"] = {-1,0},
			["p1"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0}			
		},
	},
	["guaxinim"] = {
		-- male
		[1885233650] = {
			[1] = {20,1,2},
			[2] = {11,0,0},
			[3] = {31,1,1},
			[4] = {87,21,1},
			[5] = {0,0,0},
			[6] = {25,0,1},
			[7] = {0,0,2},
			[8] = {131,17,1},
			[9] = {0,0,1},
			[10] = {-1,0,0},
			[11] = {221,21,1},
			["p2"] = {-1,0},
			["p0"] = {-1,0},
			["p1"] = {-1,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0}			
		},
	},
	["boi"] = {
		-- male
		[1885233650] = {
			[1] = {23,0,2},
			[2] = {19,0,0},
			[3] = {30,0,1},
			[4] = {4,0,1},
			[5] = {20,0,2},
			[6] = {77,8,1},
			[7] = {112,2,1},
			[8] = {11,0,1},
			[9] = {0,0,1},
			[10] = {-1,0,0},
			[11] = {80,1,1},
			["p0"] = {-1,0},
			["p1"] = {-1,0},
			["p2"] = {26,0},
			["p7"] = {-1,0},
			["p6"] = {9,0}
		},
	},
	["cavalo"] = {
		-- male
		[1885233650] = {
			[1] = {97,0,2}, 
			[2] = {11,0,0}, 
			[3] = {1,0,1}, 
			[4] = {28,0,1}, 
			[5] = {0,0,1}, 
			[6] = {2,2,1}, 
			[7] = {0,0,1}, 
			[8] = {4,0,1}, 
			[9] = {0,0,1}, 
			[10] = {-1,0,0}, 
			[11] = {35,0,1}, 
			[0] = {0,0,0}, 
			["p2"] = {8,0}, 
			["p6"] = {-1,0}, 
			["p7"] = {0,0}, 
			["p0"] = {-1,0}, 
			["p1"] = {-1,0}
		},
	},
	["alien"] = {
		-- male
		[1885233650] = {
			[1] = {134,8,2},
			[2] = {3,0,0},
			[3] = {3,0,1},
			[4] = {106,8,1},
			[5] = {0,0,1},
			[6] = {83,8,1},
			[7] = {0,0,2},
			[8] = {15,0,0},
			[9] = {0,0,1},
			[10] = {-1,0,0},
			[11] = {274,8,1},
			["p2"] = {4,0},
			["p6"] = {-1,0},
			["p7"] = {-1,0},
			["p0"] = {104,0},
			["p1"] = {-1,0},
			[0] = {0,0,0}
		}
	},
	["unicornio"] = {
		-- female
		[-1667301416] = {
			[1] = {98,0,2},
			[2] = {8,0,0},
			[3] = {93,0,1},
			[4] = {60,8,1},
			[5] = {-1,0,2},
			[6] = {49,1,1},
			[7] = {0,0,0},
			[8] = {11,3,1},
			[9] = {0,0,1},
			[10] = {-1,0,0},
			[11] = {78,4,1},
			[0] = {0,0,0},
			["p2"] = {-1,0},
			["p6"] = {2,0},
			["p7"] = {10,0},
			["p0"] = {-1,0},
			["p1"] = {-1,0}
		},
	},
	["chupacabra"] = {
		-- male
		[1885233650] = {
			[1] = {131,0,2},
			[2] = {7,0,0},
			[3] = {20,0,1},
			[4] = {59,4,1},
			[5] = {20,0,2},
			[6] = {64,2,1},
			[7] = {0,0,2},
			[8] = {11,0,1},
			[9] = {-1,0,2},
			[10] = {-1,0,2},
			[11] = {281,0,1},
			["p0"] = {-1,0},
			["p2"] = {-1,0},
			["p1"] = {-1,0},
			["p6"] = {-1,0},
			[0] = {0,0,0},
			["p7"] = {-1,0}
		},
	},
	["lobo"] = {
		-- male
		[1885233650] = {
			[1] = {26,1,1},
			[2] = {11,0,0},
			[3] = {49,0,1},
			[4] = {10,0,1},
			[5] = {45,0,1},
			[6] = {77,11,1},
			[7] = {112,2,1},
			[8] = {96,1,1},
			[9] = {0,0,0},
			[10] = {0,0,0},
			[11] = {31,0,1},
			["p6"] = {-1,0},
			["p7"] = {-1,0},
			["p2"] = {11,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			[0] = {0,0,0}
		},
	},
	["aguia"] = {
		-- male
		[1885233650] = {
			[1] = {24,0,1},
			[2] = {11,0,0},
			[3] = {82,0,1},
			[4] = {28,0,1},
			[5] = {44,0,1},
			[6] = {2,3,1},
			[7] = {29,5,2},
			[8] = {32,0,1},
			[9] = {0,0,1},
			[10] = {-1,0,0},
			[11] = {32,0,1},
			["p6"] = {-1,0},
			["p7"] = {0,0},
			["p2"] = {8,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			[0] = {0,0,0}
		},
	},
	["mec2"] = {
		-- male
		[1885233650] = {
			[1] = {0,0,0},
			[2] = {32,0,0},
			[3] = {41,0,0},
			[4] = {98,0,1},
			[5] = {0,0,0},
			[6] = {61,0,1},
			[7] = {0,0,1},
			[8] = {15,0,0},
			[9] = {37,0,1},
			[10] = {0,0,0},
			[11] = {241,0,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			[0] = {0,0,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			["p2"] = {-1,0}			
			},
		-- female
		[-1667301416] = {
			[1] = {0,0,0},
			[2] = {32,0,0},
			[3] = {57,0,1},
			[4] = {101,0,1},
			[5] = {0,0,0},
			[6] = {28,0,1},
			[7] = {0,0,0},
			[8] = {6,0,1},
			[9] = {0,0,0},
			[10] = {0,0,0},
			[11] = {249,0,1},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			["p2"] = {-1,0},
			["p1"] = {-1,0},
			["p0"] = {-1,0},
			[0] = {0,0,0}						
		}
	},
	["mec"] = {
		-- male
		[1885233650] = {
			[1] = { -1,0 },
			[3] = { 12,0 },
			[4] = { 39,0 },
			[5] = { -1,0 },
			[6] = { 24,0 },
			[7] = { 109,0 },
			[8] = { 89,0 },
			[9] = { 14,0 },
			[10] = { -1,0 },
			[11] = { 66,0 }
			},
		-- female
		[-1667301416] = {
			[1] = {-1,0,2},
			[2] = {32,0,0},
			[3] = {44,0,1},
			[4] = {38,0,2},
			[5] = {-1,0,2},
			[6] = {24,0,2},
			[7] = {0,0,1},
			[8] = {56,0,2},
			[9] = {35,0,2},
			[10] = {-1,0,2},
			[11] = {236,0,1},
			[0] = {0,0,0},
			["p7"] = {-1,0},
			["p6"] = {-1,0},
			["p0"] = {-1,0},
			["p2"] = {-1,0},
			["p1"] = {-1,0}			
		}
	}
}

RegisterCommand('preset',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"polpar.permissao") or vRP.hasPermission(user_id,"preset.permissao") then
		if args[1] then
			if args[1] == "cadet" or args[1] == "officer" or args[1] == "corporal"  or args[1] == "sargent" or args[1] == "liutenet" or args[1] == "capitain" or args[1] == "major" or args[1] == "comando" or args[1] == "tatico" then
				if vRP.hasPermission(user_id,"policia.permissao") then
					local custom = presets[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Você precisa ser Policial")
					return false
				end
			elseif args[1] == "devil" then
				if user_id == 2 then
					local custom = presets[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Você não é o Demônio")
					return false
				end
			elseif args[1] == "angel" then
				if user_id == 5 then
					local custom = presets[tostring(args[1])]
					if custom then
						local old_custom = vRPclient.getCustomization(source)
						local idle_copy = {}

						idle_copy = vRP.save_idle_custom(source,old_custom)
						idle_copy.modelhash = nil

						for l,w in pairs(custom[old_custom.modelhash]) do
							idle_copy[l] = w
						end
						vRPclient._setCustomization(source,idle_copy)
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Você não é o Anjo")
					return false
				end
			else
				local custom = presets[tostring(args[1])]
				if custom then
					local old_custom = vRPclient.getCustomization(source)
					local idle_copy = {}

					idle_copy = vRP.save_idle_custom(source,old_custom)
					idle_copy.modelhash = nil

					for l,w in pairs(custom[old_custom.modelhash]) do
						idle_copy[l] = w
					end
					vRPclient._setCustomization(source,idle_copy)
				end
			end
		else
			vRP.removeCloak(source)
		end
	end
end)