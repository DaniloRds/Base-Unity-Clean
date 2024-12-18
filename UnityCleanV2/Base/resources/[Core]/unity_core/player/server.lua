local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

local idgens = Tools.newIDGenerator()

player_tunnel = {}
Tunnel.bindInterface("unity_core",player_tunnel)


-- [WEBHOOK]
local webhookgarmas = ""
local webhookgarmas250 = ""
local webhookequipar = "" 
local webhookenviaritem = ""
local webhookenviardinheiro = ""
local webhookdropar = ""
local webhookpaypal = ""
local webhooksaquear = ""
local webhookchat = ""
local webhookilegal = ""
local webhookCobrar = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-- CHECK ROUPAS 
function player_tunnel.checkRoupas()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"roupas") >= 1 or vRP.hasPermission(user_id,"admin.permissao") or vRP.hasPermission(user_id,"mod.permissao") then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Roupas Secundárias</b> na mochila.")
			return false
		end
	end
end

-- [Reskin]
RegisterCommand('reskin',function(source,rawCommand)
	local user_id = vRP.getUserId(source)		
	vRPclient._setCustomization(vRPclient.getCustomization(source))		
end)

-- [bvida event]
RegisterServerEvent("bvida")
AddEventHandler("bvida",function()
    local source = source
    vRPclient._setCustomization(source,vRPclient.getCustomization(source))
	TriggerEvent('vrp_tattoo:setPedServer',source)
	TriggerEvent('vrp_barber:setPedServer',source)
    vRP.removeCloak(source)
end)

------------------------------------------------------
-- TRYTOW
------------------------------------------------------
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
------------------------------------------------------
-- TRUNK
------------------------------------------------------
RegisterServerEvent("trytrunk")
AddEventHandler("trytrunk",function(nveh)
	TriggerClientEvent("synctrunk",-1,nveh)
end)
------------------------------------------------------
-- PLAYER:WINSFUNCTIONS
------------------------------------------------------
RegisterServerEvent("player:winsFunctions")
AddEventHandler("player:winsFunctions",function(mode)
	local source = source
	local vehicle,vehNet = vRPclient.vehSitting(source)
	if vehicle then
		local activePlayers = vRPclient.activePlayers(source)
		for _,v in ipairs(activePlayers) do
			async(function()
				TriggerClientEvent("player:syncWins",v,vehNet,mode)
			end)
		end
	end
end)
-- ABRE E FECHA OS VIDROS COMANDO
RegisterCommand('vidros',function(source,args,rawCommand)
	local vehicle,vehNet = vRPclient.vehSitting(source)
	if vehicle then
		if args[1] and args[1] == tostring(0) or args[1] == tostring(1) then
			local activePlayers = vRPclient.activePlayers(source)
			for _,v in ipairs(activePlayers) do
				async(function()
					TriggerClientEvent("player:syncWins",v,vehNet,args[1])
				end)
			end
		else
			TriggerClientEvent("Notify",source,"negado","Para abaixar ou levantar os vidros utilize /vidros 0 ou /vidros 1 respectivamente.")	
		end
	end
end)
------------------------------------------------------
-- HOOD
------------------------------------------------------
RegisterServerEvent("tryhood")
AddEventHandler("tryhood",function(nveh)
	TriggerClientEvent("synchood",-1,nveh)
end)
------------------------------------------------------
-- DOORS
------------------------------------------------------
RegisterServerEvent("trydoors")
AddEventHandler("trydoors",function(nveh,door)
	TriggerClientEvent("syncdoors",-1,nveh,door)
end)

-- [cooldown]
local cooldown = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if cooldown > 0 then
			cooldown = cooldown - 1
		end
	end
end)

-- [COBRAR]
RegisterCommand('cobrar',function(source,args,rawCommand)
		local user_id = vRP.getUserId(source)
		local consulta = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(consulta)
		local resultado = json.decode(consulta) or 0
		local banco = vRP.getBankMoney(nuser_id)
		local identity =  vRP.getUserIdentity(user_id)
		local identityu = vRP.getUserIdentity(nuser_id)
		if cooldown < 1 then
			cooldown = 5
			if args[1] then
				if consulta then
					if vRP.request(consulta,"Deseja pagar <b>$"..vRP.format(parseInt(args[1])).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",15) then	
						if banco >= parseInt(args[1]) then
							vRP.setBankMoney(nuser_id,parseInt(banco-args[1]))
							vRP.giveBankMoney(user_id,parseInt(args[1]))
							TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).."</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
							SendWebhookMessage(webhookCobrar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COBROU]: $"..vRP.format(parseInt(args[1])).." \n[DO ID]: "..parseInt(nuser_id).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							local player = nuser_id
							if player == nil then
								return
							else
								local identity = vRP.getUserIdentity(user_id)
								TriggerClientEvent("Notify",player,"importante","<b>"..identity.name.." "..identity.firstname.."</b> transferiu <b>$"..vRP.format(parseInt(args[1])).." $</b> para sua conta.")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","A pessoa negou.")	
					end
				else
					TriggerClientEvent("Notify",source,"negado","Não há ninguém próximo o suficiente.")	
				end
			else
				TriggerClientEvent("Notify",source,"negado","Digite o valor que deseja cobrar.")	
			end
		else
			TriggerClientEvent("Notify",source,"negado","Espere 5 segundos.")
		end
end)

RegisterServerEvent('player:cobrar')
AddEventHandler('player:cobrar',function()
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local banco = vRP.getBankMoney(nuser_id)
	local identity =  vRP.getUserIdentity(user_id)
	local identityu = vRP.getUserIdentity(nuser_id)
	if cooldown < 1 then
		cooldown = 5
		if nuser_id then
			TriggerClientEvent("dynamic:closeSystem",source)
			local cobrar_valor = tonumber(vRP.prompt(source,"Digite o valor a ser cobrado:",""))
			if cobrar_valor > 0 then
				if vRP.request(nuser_id,"Deseja pagar <b>$"..vRP.format(parseInt(cobrar_valor)).."</b> para <b>"..identity.name.." "..identity.firstname.."</b>?",15) then	
					if banco >= parseInt(cobrar_valor) then
						vRP.setBankMoney(nuser_id,parseInt(banco-cobrar_valor))
						vRP.giveBankMoney(user_id,parseInt(cobrar_valor))
						TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..vRP.format(parseInt(cobrar_valor)).."</b> de <b>"..identityu.name.. " "..identityu.firstname.."</b>.")
						SendWebhookMessage(webhookCobrar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[COBROU]: $"..vRP.format(parseInt(cobrar_valor)).." \n[DO ID]: "..parseInt(nuser_id).." "..identityu.name.." "..identityu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						local player = nuser_id
						if player == nil then
							return
						else
							local identity = vRP.getUserIdentity(user_id)
							TriggerClientEvent("Notify",player,"sucesso","<b>Você transferiu "..cobrar_valor.."</b> para "..identity.firstname..".")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","A pessoa negou.")	
				end
			else
				TriggerClientEvent("Notify",source,"negado","Digite o valor que deseja cobrar.")	
			end
		else
			TriggerClientEvent("Notify",source,"negado","Não há ninguém próximo o suficiente.")	
		end
	else
		TriggerClientEvent("Notify",source,"negado","Espere 5 segundos.")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SALÁRIO
-------------------------------------------------------------------------------------------------------------------------------------------
local salarios = {
	-- [vip] --
	{ ['permissao'] = "standart.permissao", ['nome'] = "BRONZE", ['payment'] = 3500 },
	{ ['permissao'] = "premium.permissao", ['nome'] = "PRATA", ['payment'] = 5000 },
	{ ['permissao'] = "elite.permissao", ['nome'] = "OURO", ['payment'] = 8000 },
	{ ['permissao'] = "ultimate.permissao", ['nome'] = "PLATINA", ['payment'] = 12000 },

	--
}

RegisterServerEvent('salario:pagamento')
AddEventHandler('salario:pagamento',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(salarios) do
			if vRP.hasPermission(user_id,v.permissao) then
				TriggerClientEvent("vrp_sound:source",source,'coins',0.5)
				TriggerClientEvent("Notify",source,"importante","Obrigado por colaborar com a cidade, seu salario de <b>$"..vRP.format(parseInt(v.payment)).." dólares</b> foi depositado.")
				vRP.giveBankMoney(user_id,parseInt(v.payment))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCARJACK
-----------------------------------------------------------------------------------------------------------------------------------------
local veiculos = {}
RegisterServerEvent("TryDoorsEveryone")
AddEventHandler("TryDoorsEveryone",function(veh,doors,placa)
	if not veiculos[placa] then
		TriggerClientEvent("SyncDoorsEveryone",-1,veh,doors)
		veiculos[placa] = true
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AFKSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("kickAFK")
AddEventHandler("kickAFK",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.hasPermission(user_id,"admin.permissao") then
        DropPlayer(source,"Voce foi desconectado por ficar ausente.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COR NA ARMA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('cor', function(source, args)
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id, 'admin.permissao')or vRP.hasPermission(user_id, 'mod.permissao') or vRP.hasPermission(user_id, 'cor.permissao') then
        TriggerClientEvent('changeWeaponColor', source, args[1])
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /SEQUESTRO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sequestro',function(source,args,rawCommand)
	local nplayer = vRPclient.getNearestPlayer(source,5)
	if nplayer then
		if vRPclient.isHandcuffed(nplayer) then
			if not vRPclient.getNoCarro(source) then
				local vehicle = vRPclient.getNearestVehicle(source,7)
				if vehicle then
					if vRPclient.getCarroClass(source,vehicle) then
						vRPclient.setMalas(nplayer)
					end
				end
			elseif vRPclient.isMalas(nplayer) then
				vRPclient.setMalas(nplayer)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","A pessoa precisa estar algemada para colocar ou retirar do Porta-Malas.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENVIAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('enviar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	local identity = vRP.getUserIdentity(user_id)
  	local identitynu = vRP.getUserIdentity(nuser_id)
	if nuser_id and parseInt(args[1]) > 0 then
		if vRP.tryPayment(user_id,parseInt(args[1])) then
			vRP.giveMoney(nuser_id,parseInt(args[1]))
			vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",source,"sucesso","Enviou <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
			TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>$"..vRP.format(parseInt(args[1])).." dólares</b>.",8000)
			SendWebhookMessage(webhookenviardinheiro,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: $"..vRP.format(parseInt(args[1])).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			TriggerClientEvent("Notify",source,"negado","Não tem a quantia que deseja enviar.",8000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GARMAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('garmas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local weapons = vRPclient.replaceWeapons(source,{})
        local tempog = math.random(2000,6000)
        Citizen.Wait(tempog)
        for k,v in pairs(weapons) do
            vRP.giveInventoryItem(user_id,"wbody"..k,1)
            if v.ammo > 0 then
                vRP.giveInventoryItem(user_id,"wammo"..k,v.ammo)
            end
        end
        Citizen.Wait(2000)
        TriggerClientEvent("Notify",source,"sucesso","Guardou seu armamento na mochila.")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GCOLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('gcolete',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        local armour = vRPclient.getArmour(source)
        local tempog = math.random(2000,6000)
        Citizen.Wait(tempog)
		if armour == 100 then
			vRPclient.setArmour(source,0)
       		vRP.giveInventoryItem(user_id,"colete",1) 
			TriggerClientEvent("Notify",source,"sucesso","Você guardou seu Colete na mochila.")
        else
			TriggerClientEvent("Notify",source,"sucesso","Seu colete está danificado, não foi possível guardar.")
		end
        Citizen.Wait(2000)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('roubar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		local nuser_id = vRP.getUserId(nplayer)
		local policia = vRP.getUsersByPermission("policia.permissao")
		if #policia > 0 then
			if vRP.request(nplayer,"Você está sendo roubado, deseja passar tudo?",30) then
				local vida = vRPclient.getHealth(nplayer)
				if vida <= 100 then
					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						local ndata = vRP.getUserDataTable(nuser_id)
						if ndata ~= nil then
							if ndata.inventory ~= nil then
								for k,v in pairs(ndata.inventory) do
									if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
										if k ~= "identidade" or k ~= "cartaodedebito" then
											if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
												vRP.giveInventoryItem(user_id,k,v.amount)
											end
										end
									else
										TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
									end
								end
							end
						end
						local weapons = vRPclient.replaceWeapons(nplayer,{})
						for k,v in pairs(weapons) do
							vRP.giveInventoryItem(nuser_id,"wbody"..k,1)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody"..k) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wbody"..k,1) then
									vRP.giveInventoryItem(user_id,"wbody"..k,1)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody"..k).."</b> por causa do peso.")
							end
							if v.ammo > 0 then
								vRP.giveInventoryItem(nuser_id,"wammo"..k,v.ammo)
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,"wammo"..k,v.ammo) then
										vRP.giveInventoryItem(user_id,"wammo"..k,v.ammo)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo"..k).."</b> por causa do peso.")
								end
							end
						end
						local nmoney = vRP.getMoney(nuser_id)
						if vRP.tryPayment(nuser_id,nmoney) then
							vRP.giveInventoryItem(user_id,"dinheirosujo",nmoney)
						end
						vRPclient.setStandBY(source,parseInt(600))
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						TriggerClientEvent("Notify",source,"importante","Roubo concluido com sucesso.")
					end)
				else
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
										vRP.giveInventoryItem(user_id,k,v.amount)
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody"..k,1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo"..k,v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveMoney(user_id,nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					TriggerClientEvent("Notify",source,"sucesso","Roubo concluido com sucesso.")
				end
			else
				TriggerClientEvent("Notify",source,"importante","A pessoa está resistindo ao roubo.")
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Saquear
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('saquear',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	if nplayer then
		if vRPclient.isInComa(nplayer) then
			local identity_user = vRP.getUserIdentity(user_id)
			local nuser_id = vRP.getUserId(nplayer)
			local nidentity = vRP.getUserIdentity(nuser_id)
			local policia = vRP.getUsersByPermission("policia.permissao")
			local itens_saque = {}
			if #policia >= 0 then
				local vida = vRPclient.getHealth(nplayer)
				TriggerClientEvent('cancelando',source,true)
				vRPclient._playAnim(source,false,{{"amb@medic@standing@kneel@idle_a","idle_a"}},true)
				TriggerClientEvent("progress",source,20000,"saqueando")
				SetTimeout(20000,function()
					local ndata = vRP.getUserDataTable(nuser_id)
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(k)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
									if k ~= "identidade" or k ~= "cartaodedebito" then
										if vRP.tryGetInventoryItem(nuser_id,k,v.amount) then
											vRP.giveInventoryItem(user_id,k,v.amount)
											table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList(k).." [QUANTIDADE]: "..v.amount)
										end
									end
								else
									TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(k).."</b> por causa do peso.")
								end
							end
						end
					end
					local weapons = vRPclient.replaceWeapons(nplayer,{})
					for k,v in pairs(weapons) do
						vRP.giveInventoryItem(nuser_id,"wbody"..k,1)
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wbody"..k) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,"wbody"..k,1) then
								vRP.giveInventoryItem(user_id,"wbody"..k,1)
								table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wbody"..k).." [QUANTIDADE]: "..1)
							end
						else
							TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>1x "..vRP.itemNameList("wbody"..k).."</b> por causa do peso.")
						end
						if v.ammo > 0 then
							vRP.giveInventoryItem(nuser_id,"wammo"..k,v.ammo)
							if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo"..k)*v.ammo <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,"wammo"..k,v.ammo) then
									vRP.giveInventoryItem(user_id,"wammo"..k,v.ammo)
									table.insert(itens_saque, "[ITEM]: "..vRP.itemNameList("wammo"..k).." [QTD]: "..v.ammo)
								end
							else
								TriggerClientEvent("Notify",source,"negado","Mochila não suporta <b>"..vRP.format(parseInt(v.ammo)).."x "..vRP.itemNameList("wammo"..k).."</b> por causa do peso.")
							end
						end
					end
					local nmoney = vRP.getMoney(nuser_id)
					if vRP.tryPayment(nuser_id,nmoney) then
						vRP.giveInventoryItem(user_id,"dinheirosujo",nmoney)
					end
					vRPclient.setStandBY(source,parseInt(600))
					vRPclient._stopAnim(source,false)
					TriggerClientEvent('cancelando',source,false)
					local apreendidos = table.concat(itens_saque, "\n")
					TriggerClientEvent("Notify",source,"importante","Saque concluido com sucesso.")
					SendWebhookMessage(webhooksaquear,"```prolog\n[ID]: "..user_id.." "..identity_user.name.." "..identity_user.firstname.."\n[SAQUEOU]: "..nuser_id.." "..nidentity.name.." " ..nidentity.firstname .. "\n" .. apreendidos ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você só pode saquear quem está em coma.")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALL
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
RegisterCommand('call',function(source,args,rawCommand)
	local source = source
	local answered = false
	local user_id = vRP.getUserId(source)
	local uplayer = vRP.getUserSource(user_id)
	vida = vRPclient.getHealth(source)
	vRPclient._CarregarObjeto(source,"cellphone@","cellphone_call_to_text","prop_amb_phone",50,28422)
	if user_id then
		local descricao = vRP.prompt(source,"Descrição:","")
		if descricao == "" then
			vRPclient._stopAnim(source,false)
			vRPclient._DeletarObjeto(source)
			return
		end

		local x,y,z = vRPclient.getPosition(source)
		local players = {}
		vRPclient._stopAnim(source,false)
		vRPclient._DeletarObjeto(source)
		local especialidade = false
		if args[1] == "911" then
			players = vRP.getUsersByPermission("policia.permissao")
			especialidade = "policiais"
		elseif args[1] == "112" then
			players = vRP.getUsersByPermission("paramedico.permissao")
			especialidade = "paramédicos"
		elseif args[1] == "mec" then
			players = vRP.getUsersByPermission("mecanico.permissao")
			especialidade = "mecânicos"
		elseif args[1] == "taxi" then
			players = vRP.getUsersByPermission("taxista.permissao")
			especialidade = "taxistas"
		elseif args[1] == "heli" then
			players = vRP.getUsersByPermission("pilotochefe.permissao")
			especialidade = "taxiaereo"
		elseif args[1] == "adv" then
			players = vRP.getUsersByPermission("advogado.permissao")
			if players[1] == nil then
				players = vRP.getUsersByPermission("juiza.permissao")	
				especialidade = "juizes"
			else
				especialidade = "advogados"
			end
		--[[	
		elseif args[1] == "juiz" then
			players = vRP.getUsersByPermission("juiza.permissao")	
			especialidade = "juizes"
		]]
		elseif args[1] == "css" then
			players = vRP.getUsersByPermission("conce.permissao")	
			especialidade = "vendedores"
		elseif args[1] == "jornal" then
			players = vRP.getUsersByPermission("news.permissao")	
			especialidade = "jornalistas"
		elseif args[1] == "adm" then
			players = vRP.getUsersByPermission("ticket.permissao")	
			especialidade = "Administradores"
		end
		local adm = ""
		if especialidade == "Administradores" then
			adm = "[ADM] "
		end
		
		vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
		if #players == 0  and especialidade ~= "policiais" then
			TriggerClientEvent("Notify",source,"importante","Não há "..especialidade.." em serviço.")
		else
			local identitys = vRP.getUserIdentity(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Chamado enviado com sucesso.")
			for l,w in pairs(players) do
				local player = vRP.getUserSource(parseInt(w))
				local nuser_id = vRP.getUserId(player)
				if player and player ~= uplayer then
					async(function()
						vRPclient.playSound(player,"Out_Of_Area","DLC_Lowrider_Relay_Race_Sounds")
						TriggerClientEvent('chatMessage',player,"CHAMADO",{19,197,43},adm.."Enviado por ^1"..identitys.name.." "..identitys.firstname.."^0 ["..user_id.."], "..descricao)
						local ok = vRP.request(player,"Aceitar o chamado de <b>"..identitys.name.." "..identitys.firstname.."</b>?",30)
						if ok then
							if not answered then
								answered = true
								local identity = vRP.getUserIdentity(nuser_id)
								TriggerClientEvent("Notify",source,"importante","Chamado atendido por <b>"..identity.name.." "..identity.firstname.."</b>, aguarde no local.")
								vRPclient.playSound(source,"Event_Message_Purple","GTAO_FM_Events_Soundset")
								vRPclient._setGPS(player,x,y)
							else
								TriggerClientEvent("Notify",player,"importante","Chamado ja foi atendido por outra pessoa.")
								vRPclient.playSound(player,"CHECKPOINT_MISSED","HUD_MINI_GAME_SOUNDSET")
							end
						end
						local id = idgens:gen()
						blips[id] = vRPclient.addBlip(player,x,y,z,358,71,"Chamado",0.6,false)
						SetTimeout(300000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MEC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"mecanico.permissao") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"Central Mecânica",{255,128,0},rawCommand:sub(4))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mr',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "mecanico.permissao"
		if vRP.hasPermission(user_id,permission) then
			local mec = vRP.getUsersByPermission(permission)
			for l,w in pairs(mec) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,identity.name.." "..identity.firstname,{255,191,128},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARTAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)
-------------------------------------------------------------------------------------------------------------
-- ME
-------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatMe')
AddEventHandler('ChatMe',function(text)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('DisplayMe',-1,text,source)
	end
end)

-------------------------------------------------------------------------------------------------------------
-- ROLL
-------------------------------------------------------------------------------------------------------------
RegisterServerEvent('ChatRoll')
AddEventHandler('ChatRoll',function(text)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent('DisplayRoll',-1,text,source)
	end
end)
-------------------------------------------------------------------------------------------------------------
-- CARD
-------------------------------------------------------------------------------------------------------------
RegisterCommand('card',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local cd = math.random(1,13)
		local naipe = math.random(1,4)
		TriggerClientEvent('CartasMe',-1,source,identity.name,cd,naipe)
	end
end)

-------------------------------------------------------------------------------------------------------------
-- STAFF
-------------------------------------------------------------------------------------------------------------
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
-- PLAYERS ON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('players',function(source,args,rawCommand)
	local onlinePlayers = GetNumPlayerIndices()
	TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Jogadores Online: "..onlinePlayers)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 911
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('911',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'policia.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage',-1,"[911] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{65,130,255},rawCommand:sub(4))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MECANICO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mec',function(source,args,rawCommand)
	if args[1] then
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'mecanico.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		--if user_id then
			TriggerClientEvent('chatMessage',-1,"[MEC] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{237, 153, 0},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LAWYER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('law',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,"[Jurídico] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{150,75,0},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 112
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('112',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, 'paramedico.permissao') then
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage',-1,"[112] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{255,70,135},rawCommand:sub(4))
	end
end)
------------------------------------------------------------------------------------------------------------------------------
-- tw
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('tw',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			TriggerClientEvent('chatMessage',-1,"[Twitter] "..identity.name.." "..identity.firstname.." ["..user_id.."]",{0,206,206},rawCommand:sub(4))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ILEGAL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('ilegal', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[Anônimo]", {000, 000, 000}, rawCommand:sub(7))
		SendWebhookMessage(log_ilegal,"```css\n[ILEGAL]\n[ID]"..user_id.."\n[DISSE]:"..rawCommand:sub(6).."```")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OLX
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('olx', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		local identity = vRP.getUserIdentity(user_id)
		TriggerClientEvent('chatMessage', -1, "[OLX] ".. GetPlayerName(source) .." ("..user_id..") ", {180, 0, 150}, rawCommand:sub(4))
		CancelEvent()
	end
end)