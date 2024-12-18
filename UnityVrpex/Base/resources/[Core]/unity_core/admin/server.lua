local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookadmin = ""
local webhookfac = ""
local webhookkeys = ""
local webhookcds = ""
local webhookblacklist = ""
local logAdmCorno = ""

local webhookItem = ""

local webhook_addVip = "https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys"
local webhook_remVip = "https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys"

vRP._prepare("admin/rename_id","UPDATE vrp_user_identities SET name = @name, firstname = @firstname, age = @age WHERE user_id = @user_id")

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

RegisterServerEvent("adminLogs:Armamentos")
AddEventHandler("adminLogs:Armamentos",function(weapon)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
    	SendWebhookMessage(webhookblacklist,"```prolog\n[BLACKLIST ARMAS]: "..user_id.." " .. "\n[ARMA]: " .. weapon ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```<@&641048265856647169>")  
    end
end)

-- [PUXAR ITEM]
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] and args[2] then
			if vRP.itemBodyList(args[1]) ~= nil then -- Verifica se o item existe na base. vrp/modules/inventory
				item = args[1]
				quantidade = parseInt(args[2])
				vRP.giveInventoryItem(user_id,item,quantidade)
				SendWebhookMessage(webhookItem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..vRP.format
				(parseInt(args[2])).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Esse item não existe.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você inseriu o comando incorretamente! modelo: /item nome quantia")
		end
	end
end)

-- [VEÍCULOS DE UM PLAYER]
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"admin.permissao") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)

-- [CHAT STAFF]
RegisterCommand("staff",function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "chatstaff.permissao"
		if vRP.hasPermission(user_id,permission) then
			local populacao = vRP.getUsersByPermission(permission)
			for l,w in pairs(populacao) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,140,0},string.sub(rawCommand,6))
						--TriggerClientEvent('chatMessage',-1,"[STAFF] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{255,140,0},rawCommand:sub(4))
					end)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS
-----------------------------------------------------------------------------------------------------------------------------------------
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    if vRP.hasPermission(user_id,"ticket.permissao") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VROUPAS2
-----------------------------------------------------------------------------------------------------------------------------------------
function IsNumber( numero )
    return tonumber(numero) ~= nil
end

RegisterCommand('vroupas2', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local custom = vRPclient.getCustomization(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
          if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
            local content = ""
            for k, v in pairs(custom) do
                if (IsNumber(k) and k <= 11) or k == "p0" or k == "p1" or k == "p2" or k == "p6" or k == "p7" then
                    if IsNumber(k) then
                        content = content .. '[' .. k .. '] = {' 
                    else
                        content = content .. '["' ..k..'"] = {'
                    end
                    local contador = 1
                    for y, x in pairs(v) do
                        if contador < #v then
                            content  = content .. x .. ',' 
                        else
                            content = content .. x 
                        end
                        contador = contador + 1
                    end
                    content = content .. "},\n"
                end
            end
            player_customs[source] = true
            vRPclient.prompt(source, 'vRoupas: ', content)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('status',function(source,args,rawCommand)
    local onlinePlayers = GetNumPlayerIndices()
	local policia = vRP.getUsersByPermission("policia.permissao")
	local adm = vRP.getUsersByPermission("ticket.permissao")
    local paramedico = vRP.getUsersByPermission("paramedico.permissao")
	local mec = vRP.getUsersByPermission("mecanico.permissao")
	local ilegal = vRP.getUsersByPermission("ilegal.permissao")
	local user_id = vRP.getUserId(source)        
	TriggerClientEvent("Notify",source,"aviso","<bold>STATUS</b>: ")
	TriggerClientEvent("Notify",source,"aviso","<bold><b>Jogadores</b> -> "..onlinePlayers.."<br><b>Administração</b> ->  "..#adm.."<br><b>Policiais</b> -> "..#policia.."<br><b>Ilegal</b> -> "..#ilegal.."<br><b>Paramédicos</b> -> "..#paramedico.."<br><b>Mecânicos</b> -> "..#mec.."</b></bold>",9000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR COLOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local vehicle = vRPclient.getNearestVehicle(source,7)
        if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):","")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
            TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
            TriggerClientEvent('Notify',source,"sucesso","Cor Alterada")
        end
    end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- kill
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.setHealth(nplayer,0)
				TriggerClientEvent("Notify", source, "sucesso", "Você matou o ID: "..parseInt(args[1]))
				local identity = vRP.getUserIdentity(user_id)
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MATOU ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		else
			vRPclient.setHealth(source,0)
			vRPclient.setArmour2(source,0)
			TriggerClientEvent("Notify", source, "sucesso", "Você se matou")
			local identity = vRP.getUserIdentity(user_id)
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MATOU ID:]: "..source.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Blips
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
        blips[source] = { source }
       TriggerClientEvent("blips:updateBlips",-1,blips)
        if vRP.hasPermission(user_id,"admin.permissao") then
            TriggerClientEvent("blips:adminStart",source)
        end
     end
 end)

AddEventHandler("playerDropped",function()
	if blips[source] then
		blips[source] = nil
		TriggerClientEvent("blips:updateBlips",-1,blips)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RENAME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rename',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") then
		if user_id then
			local id = vRP.prompt(source, "ID do Player:", "")
			if id then
				local nome1 = vRP.prompt(source, "Sobrenome:", "")
				if nome1 then
					local nome2 = vRP.prompt(source, "Primeiro Nome:", "")
					if nome2 then
						local idade = vRP.prompt(source, "Idade:", "")
						if idade then
							vRP.execute("admin/rename_id",{ user_id = parseInt(id), name = nome2, firstname = nome1, age = parseInt(idade) })
							TriggerClientEvent("Notify",source,"sucesso","Trocou o nome do ID: <b>"..id.."</b> Para: <b>"..nome1.." "..nome2.."</b>.")
						end
					end
				end
			end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADD CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) }) 
            --vRP.execute("creative/set_ipva",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) })
            TriggerClientEvent("Notify",source,"sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ADICIONOU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```") 
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REM CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
    if vRP.hasPermission(user_id,"admin.permissao") then
        if args[1] and args[2] then
            local nuser_id = vRP.getUserId(nplayer)
            local identity = vRP.getUserIdentity(user_id)
            local identitynu = vRP.getUserIdentity(nuser_id)
            vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
            TriggerClientEvent("Notify",source,"sucesso","Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.") 
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNCUFF
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('uncuff',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admcuff",source)
		end
	end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUEL
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('admfuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("admfuel",source)
		end	
	end
end)]]
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNCAREA
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"polpar.permissao") then
        TriggerClientEvent("syncarea",-1,x,y,z)
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- APAGAO
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"admin.permissao") and args[1] ~= nil then
            local cond = tonumber(args[1])
            --TriggerEvent("cloud:setApagao",cond)
            TriggerClientEvent("cloud:setApagao",-1,cond)                    
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RAIOS
------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand('raios', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"admin.permissao") and args[1] ~= nil then
            local vezes = tonumber(args[1])
            TriggerClientEvent("cloud:raios",-1,vezes)           
        end
    end
end)]]
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TROCAR SEXO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
------------------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('debug',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"admin.permissao") then
			TriggerClientEvent("ToggleDebug",player)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETEOBJ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FIX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"wnantis.permissao") or vRP.hasPermission(user_id,"fix.permissao") or vRP.hasPermission(user_id, "mod.permissao") then
			TriggerClientEvent('reparar',source)
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[USOU FIX ]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id, "mod.permissao") then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
				TriggerClientEvent("resetBleeding",nplayer)
                TriggerClientEvent("resetDiagnostic",nplayer)
				local identity = vRP.getUserIdentity(user_id)
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CUROU ID:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		else
			vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)
            TriggerClientEvent("resetBleeding",source)
            TriggerClientEvent("resetDiagnostic",source)
			local identity = vRP.getUserIdentity(user_id)
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CUROU ID:]: Ele mesmo "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVER TODOS DO SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('godall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            vRPclient.killGod(rsource)
			vRPclient.setHealth(rsource, 400)
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[CUROU ID:]: GERAL "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('hash',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('vehash',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Tuning
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('vehtuning',source)
		SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[USOU TUNING]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        if args[1] then
            vRP.setWhitelisted(parseInt(args[1]),true)
            TriggerClientEvent("Notify",source,"sucesso","Voce aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
            SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao")  then
		if args[1] then
			vRP.setWhitelisted(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce retirou o passaporte <b>"..args[1].."</b> da whitelist.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"Você foi expulso da cidade.")
				TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATAR PERSONAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('matarpersonagem',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"owner.permissao") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			if id then
				vRP.kick(id,"A história do seu personagem chegou ao fim! Agora você deve criar um novo personagem e esquecer de toda a sua vida anterior... Boa Sorte na sua nova jornada. (Aguarde 10 minutos para entrar na cidade novamente)")
				TriggerClientEvent("Notify",source,"sucesso","Voce encerrou a história do passaporte <b>"..args[1].."</b> (Lembre-se de resetar todos os pertences do jogador no banco de dados!)")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK ALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kickall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
                vRP.kick(id,"Você foi vitima do terremoto. (Aguarde 30 segundos para entrar na cidade novamente!)")
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),true)
			TriggerClientEvent("Notify",source,"sucesso","Voce baniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('unban',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			vRP.setBanned(parseInt(args[1]),false)
			TriggerClientEvent("Notify",source,"sucesso","Voce desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESBANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			vRP.giveMoney(user_id,parseInt(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCOIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addcoin',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"owner.permissao") then
		if args[1] and args[2] then
			local identity2 = vRP.getUserIdentity(parseInt(args[1]))
			vRP.giveCoin(parseInt(args[1]),parseInt(args[2]))
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COLOCOU]: "..vRP.format(parseInt(args[2])).." Moedas \n[PARA]: "..args[1].." "..identity2.name.." "..identity2.firstname.." \n[DATA]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("Notify",source,"sucesso","Você adicionou <b>"..parseInt(args[2]).."</b> moedas para o ID: <b>"..args[1].."</b>.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCOIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remcoin',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"owner.permissao") then
		if args[1] and args[2] then
			local identity2 = vRP.getUserIdentity(parseInt(args[1]))
			vRP.removeCoin(parseInt(args[1]),parseInt(args[2]))
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..vRP.format(parseInt(args[2])).." Moedas \n[DE]: "..args[1].." "..identity2.name.." "..identity2.firstname.." \n[DATA]: "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("Notify",source,"aviso","Você removeu <b>"..parseInt(args[2]).."</b> moedas do ID: <b>"..args[1].."</b>.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('coins',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"owner.permissao") then
		if args[1] then
			local coin = vRP.getCoin(parseInt(args[1]))
			TriggerClientEvent("Notify",source,"sucesso","<b> O player possuí "..coin.." coins.</b>")
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa digitar o ID do player.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Este comando é restrito a administração.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVER VIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('remvip',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"owner.permissao") then
		-- print(vRP.getVipActive(user_id))
		if vRP.getVipActive(user_id) then
			if args[1] then
				local identity2 = vRP.getUserIdentity(parseInt(args[1]))
				local vip = vRP.getUserGroupByType(parseInt(args[1]),"vip")

				PerformHttpRequest(webhook_remVip, function(err, text, headers) end, 'POST', json.encode({
					embeds = {
						{ 	------------------------------------------------------------
							title = 'REMOÇÃO DE VIP POR COMANDO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
							thumbnail = {
								url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=67188247&is=671730c7&hm=b75bdb641c2dbbc64cb23016282175b198c9fddc579a58ff8aaaac8a4e6047f0&"
							}, 
							fields = {
								{ 
									name = '**STAFF**',
									value = '```fix\n'..identity.name..' '..identity.firstname..' ['..user_id..']```'
								},
								{
									name = '**VIP REMOVIDO**',
									value = '```fix\n'..vip..'```'
								},
								{
									name = '',
									value = '**PLAYER:** ```fix\n'..identity2.name..' '..identity2.firstname..' ['..args[1]..']```'
								}
							}, 
							footer = { 
								text = "Unity Logs | "..os.date('%d/%m/%Y | %H:%M:%S'),
								icon_url = "https://cdn.discordapp.com/attachments/994263910926528532/1149799306182799420/definicoes.png"
							},
							color = "15548997"
						}
					}
				}), { ['Content-Type'] = 'application/json' })

				vRP.vipsConfig(user_id,"del_vip")
				vRP.deleteVip(args[1])

				TriggerClientEvent("Notify",source,"sucesso","Você removeu o VIP do ID <b>["..parseInt(args[1]).."]</b>.")
				TriggerClientEvent("Notify",args[1],"aviso","Seu VIP foi removido pelo staff de ID <b>["..parseInt(user_id).."]</b>.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","O jogador de ID <b>["..parseInt(args[1]).."]</b> não possui um VIP ativo.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAR VIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('addvip',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

	if vRP.hasPermission(user_id,"owner.permissao") then
		if not vRP.getVipActive(user_id) then
			if args[1] and args[2] then
				local vip = vRP.getUserGroupByType(args[1],"vip")
				local checkGroupExists = {"standart","premium"}
				local vipValid = false

				for k,v in pairs(checkGroupExists) do
					if v == args[2] then
						vipValid = true
						break
					end
				end
				
				if vipValid then
					local identity2 = vRP.getUserIdentity(parseInt(args[1]))
					vRP.addUserGroup(parseInt(args[1]),args[2])
					SetTimeout(500,function()
						vRP.insertNewVip(parseInt(args[1]),args[2])
						TriggerClientEvent("Notify",source,"sucesso","Você adicionou um VIP ("..args[2]..") para o <b>ID ["..parseInt(args[1]).."]</b>.")
						TriggerClientEvent("Notify",args[1],"aviso","O STAFF <b>[ID "..parseInt(user_id).."]</b> adicionou um <b>VIP ("..args[2]..")</b> para você.")
					end)

					PerformHttpRequest(webhook_addVip, function(err, text, headers) end, 'POST', json.encode({
						embeds = {
							{ 	------------------------------------------------------------
								title = 'ADIÇÃO DE VIP POR COMANDO⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀',
								thumbnail = {
									url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=67188247&is=671730c7&hm=b75bdb641c2dbbc64cb23016282175b198c9fddc579a58ff8aaaac8a4e6047f0&"
								}, 
								fields = {
									{ 
										name = '**STAFF**',
										value = '```fix\n'..identity.name..' '..identity.firstname..' ['..user_id..']```'
									},
									{
										name = '**VIP**',
										value = '```fix\n'..args[2]..'```'
									},
									{
										name = '',
										value = '**PLAYER:** ```fix\n'..identity2.name..' '..identity2.firstname..' ['..args[1]..']```'
									}
								}, 
								footer = { 
									text = "Unity Logs | "..os.date('%d/%m/%Y | %H:%M:%S'),
									icon_url = "https://cdn.discordapp.com/attachments/994263910926528532/1149799306182799420/definicoes.png"
								},
								color = "5763719"
							}
						}
					}), { ['Content-Type'] = 'application/json' })
										
				else
					TriggerClientEvent("Notify",source,"negado","O VIP que você digitou não existe no cadastro da base. ("..args[2]..")")
				end
			else
				TriggerClientEvent("Notify",source,"negado","O comando está incorreto, digite <b>/addvip ID VIP</b>")
			end
		else
			TriggerClientEvent("Notify",source,"negado","O jogador de <b>ID ["..parseInt(args[1]).."]</b> já possui um <b>VIP ("..vip..")</b> ativo.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		vRPclient.toggleNoclip(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"owner.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"owner.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..", "..tD(y)..", "..tD(z))
	end
end)

RegisterCommand('cds3',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"owner.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","{name='ATM', id=277, x="..tD(x)..", y="..tD(y)..", z="..tD(z).."},")
	end
end)

RegisterCommand('cds4',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"owner.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:","x = "..tD(x)..", y = "..tD(y)..", z = "..tD(z))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDSH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cdsh',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		local lugar = vRP.prompt(source,"Lugar:","")
		if lugar == "" then
			return
		end
	    SendWebhookMessage(webhookcds,"```prolog\n[PASSAPORTE]: "..user_id.." \n[LUGAR]: "..lugar.." \n[CDSH]: ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z)..", ['name'] = "..lugar..", \r```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS CORRIDAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("cds:corridas")
AddEventHandler("cds:corridas",function()
local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		local x,y,z = vRPclient.getPosition(source)
		SendWebhookMessage(webhookcds,"```prolog\n[] = { ['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z).." }, \r```")
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SETOU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args[1]).."</b> do grupo <b>"..args[2].."</b>.")
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[REMOVEU]: "..args[1].." \n[GRUPO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- s
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('s',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permissao = "ticket.permissao"
		if vRP.hasPermission(user_id,permissao) then
			local staff = vRP.getUsersByPermission(permissao)
			for l,w in pairs(staff) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{210,68,182},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTAR TODOS ATÉ VC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpall', function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local rusers = vRP.getUsers()
        for k,v in pairs(rusers) do
            local rsource = vRP.getUserSource(k)
            if rsource ~= source then
                vRPclient.teleport(rsource,x,y,z)
            end
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") or vRP.hasPermission(user_id,"suporte.permissao") then
		TriggerClientEvent('tptoway',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('car',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if args[1] then
			TriggerClientEvent('spawnarveiculo',source,args[1])
			SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[SPAWNOU]: "..(args[1]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('anuncio',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
		local mensagem = vRP.prompt(source,"Mensagem:","")
		if mensagem == "" then
			return
		end
		SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		vRPclient.setDiv(-1,"anuncio",".div_anuncio { background: rgba(15,15,15,0.8); border-bottom: 3px solid#3c9981; font-size: 11px; font-family: arial; color: #fff; padding: 20px; bottom: 30%; right: 1%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Mensagem enviada por: "..identity.name.."")
		SetTimeout(120000,function()
			vRPclient.removeDiv(-1,"anuncio")
		end)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- festinha
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('festinha',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"admin.permissao") then
        local identity = vRP.getUserIdentity(user_id)
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        vRPclient.setDiv(-1,"festinha"," @keyframes blinking {    0%{ background-color: #ff3d50; border: 2px solid #871924; opacity: 1.8; } 25%{ background-color: #d22d99; border: 2px solid #901f69; opacity: 0.8; } 50%{ background-color: #55d66b; border: 2px solid #126620; opacity: 0.8; } 75%{ background-color: #22e5e0; border: 2px solid #15928f; opacity: 0.8; } 100%{ background-color: #222291; border: 2px solid #6565f2; opacity: 0.8; }  } .div_festinha { font-size: 11px; font-family: arial; color: rgba(255, 255, 255,1); padding: 20px; bottom: 45%; right: 1%; max-width: 500px; position: absolute; -webkit-border-radius: 5px; animation: blinking 1s infinite; } bold { font-size: 16px; }","<bold>"..mensagem.."</bold><br><br>Festeiro(a): "..identity.name.." "..identity.firstname)
        SetTimeout(45000,function()
            vRPclient.removeDiv(-1,"festinha")
        end)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"suporte.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPARBOLSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('limparbolsa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao")  then
		if args[1] then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRP.clearInventory(nplayer)
				TriggerClientEvent("Notify",source,"sucesso","Você limpou o inventario do id <b>"..args[1].."</b>.")
			else
				TriggerClientEvent("Notify",source,"negado","O usuário não foi encontrado ou está offline.")
			end
		else
			vRP.clearInventory(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Você limpou o seu <b>Inventario</b>")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		vRPclient.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 100px; padding: 20px 20px 5px; top: 7%; right: 10%; position: absolute; border: 1px solid rgba(0,0,0,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local b { color: #DAA520;}","<div class=\"local\"><b>ID:</b> " ..parseInt(nuser_id).. " </div>")
		vRP.request(source,"Você deseja fechar?",1000)
		vRPclient.removeDiv(source,"completerg")
	else
		TriggerClientEvent('chatMessage', source, "ERROR", {50, 205, 50},"Nenhum Jogador Próximo")
		TriggerClientEvent("Notify",source,"aviso","<b>Nenhum Jogador Próximo</b>")
	end
end)