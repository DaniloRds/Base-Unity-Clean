local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("gbz-inventory",vRPN)
Proxy.addInterface("gbz-inventory",vRPN)

local idgens = Tools.newIDGenerator()
local groups = cfg.groups

vCLIENT = Tunnel.getInterface("gbz-inventory")
vGARAGE = Tunnel.getInterface("vrp_garages")
vDIAGNOSTIC = Tunnel.getInterface("vrp_diagnostic")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookequipar = "" 
local webhookenviaritem = ""
local webhookdropar = ""
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}

function vRPN.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local coins = vRP.getCoin(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local job = vRPN.getUserGroupByType(user_id,"job")
		local vip = vRPN.getUserGroupByType(user_id,"vip")
		local vipDays = vRP.getVipDaysRemaining(user_id)
		if vipDays == 0 then
			vRP.removeUserGroup(user_id,vip)
			vRP.deleteVip(user_id)
		end
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),vRP.format(parseInt(coins)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,vip,parseInt(vipDays),mymultas
		end
	end
end

function vRPN.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) and item ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(amount).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								SendWebhookMessage(webhookenviaritem,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[ENVIOU]: "..vRP.format(parseInt(v.amount)).." "..vRP.itemNameList(itemName).." \n[PARA O ID]: "..nuser_id.." "..identitynu.name.." "..identitynu.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			SendWebhookMessage(webhookdropar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			TriggerClientEvent("itensNotify",source,"negado",itemName)
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						SendWebhookMessage(webhookdropar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DROPOU]: "..vRP.itemNameList(itemName).." \n[QUANTIDADE]: "..vRP.format(parseInt(v.amount)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						return true
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
local identidade = false
local bandagem = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(bandagem) do
			if v > 0 then
				bandagem[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
local pick = {}
local blips = {}
function vRPN.useItem(itemName,type,ramount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "usar" then
			if itemName == "valemansao" then
				TriggerClientEvent('gbz_inventory:Close',source)
				local casa = vRP.prompt(source,"Casa:","")
				if not vRP.searchReturn(source,user_id) then
					local homeOwner = vRP.query("homes/get_homeuserowner",{ user_id = parseInt(user_id), home = string.upper(string.gsub(tostring(casa), "%s+", "")) })
					if parseInt(#homeOwner) >= 1 then
						local ok = vRP.request(source,"Essa casa já é sua. Deseja atualizar o IPTU da residência <b>"..string.upper(string.gsub(tostring(casa), "%s+", "")).."</b> por <b> 1x Vale Mansão</b> ?",30)
						if ok then
							if vRP.tryGetInventoryItem(user_id,"valemansao",1) then
								vRP.execute("homes/rem_allpermissions",{ home = string.upper(string.gsub(tostring(casa), "%s+", "")) })
								vRP.execute("homes/buy_permissions",{ home = string.upper(string.gsub(tostring(casa), "%s+", "")), user_id = parseInt(user_id), tax = parseInt(os.time()) })
								TriggerClientEvent("Notify",source,"sucesso","O IPTU da residência <b>"..string.upper(string.gsub(tostring(casa), "%s+", "")).."</b> foi pago com sucesso.",10000)
								TriggerClientEvent("itensNotify",source,"negado","Vale Mansão")
								TriggerClientEvent('Creative:Update',source,'updateMochila')
							end
						end
					else
						local homeResult = vRP.query("homes/get_homeuseridowner",{ home = string.upper(string.gsub(tostring(casa), "%s+", "")) }) 
						if parseInt(#homeResult) < 1 then
							local ok = vRP.request(source,"Deseja efetuar a compra da residência <b>"..string.upper(string.gsub(tostring(casa), "%s+", "")).."</b> por <b> 1x Vale Mansão</b> ?",30)
							if ok then
								if vRP.tryGetInventoryItem(user_id,"valemansao",1) then
									vRP.execute("homes/buy_permissions",{ home = string.upper(string.gsub(tostring(casa), "%s+", "")), user_id = parseInt(user_id), tax = parseInt(os.time()) })
									TriggerClientEvent("Notify",source,"sucesso","A residência <b>"..string.upper(string.gsub(tostring(casa), "%s+", "")).."</b> foi comprada com sucesso.",10000)
									TriggerClientEvent("itensNotify",source,"negado","Vale Mansão")
									TriggerClientEvent('Creative:Update',source,'updateMochila')
								end
							end
						else
							TriggerClientEvent("Notify",source,"negado","A residência já possuí um dono",10000)
						end
					end
				end
			elseif itemName == "valefone" then
				TriggerClientEvent('gbz_inventory:Close',source)
				local fone = vRP.prompt(source,"Telefone(DDD-DDD):","-")
				if #fone ~= 7 or string.sub(fone,4,4) ~= "-" then 
					TriggerClientEvent("Notify",source,"negado","Número fora do padrão.(Ex: 999-999)",10000)
					return
				end
				if not tonumber(string.sub(fone,1,3)) and not tonumber(string.sub(fone,5,7)) then
					TriggerClientEvent("Notify",source,"negado","Número fora do padrão.(Ex: 999-999)",10000)
					return
				end

				if not vRP.getUserByPhone(tostring(fone)) then
					local ok = vRP.request(source,"Deseja trocar o seu telefone para <b>"..tostring(fone).."</b> por <b> 1x Vale Troca Número</b> ?",30)
					if ok then
						if vRP.tryGetInventoryItem(user_id,"valefone",1) then
							vRP.setUserPhone(user_id,tostring(fone))
							TriggerClientEvent("Notify",source,"sucesso","O seu telefone foi alterado para <b>"..tostring(fone).."</b> com sucesso.",10000)
							TriggerClientEvent("itensNotify",source,"negado","Vale Troca Telefone")
							TriggerClientEvent('Creative:Update',source,'updateMochila')
						end
					end	
				else
					TriggerClientEvent("Notify",source,"negado","Esse número já está em uso",10000)
				end
			elseif itemName == "valeplaca" then
				TriggerClientEvent('gbz_inventory:Close',source)
				local placa = vRP.prompt(source,"Placa:","")
				if #placa <= 0 or #placa > 8 then	
					TriggerClientEvent("Notify",source,"negado","A placa deve conter no mínimo 1 e no máximo 8 caracteres",10000)
					return
				end
				
				if not vRP.searchReturn(source,user_id) then
					if not vRP.getUserByRegistration(tostring(placa)) then
						local ok = vRP.request(source,"Deseja trocar a sua placa para <b>"..tostring(placa).."</b> por <b> 1x Vale Troca Placa</b> ?",30)
						if ok then
							if vRP.tryGetInventoryItem(user_id,"valeplaca",1) then
								vRP.setUserRegistration(user_id,tostring(placa))
								TriggerClientEvent("Notify",source,"sucesso","A sua placa foi alterada para <b>"..tostring(placa).."</b> com sucesso.",10000)
								TriggerClientEvent("itensNotify",source,"negado","Vale Troca Placa")
								TriggerClientEvent('Creative:Update',source,'updateMochila')
							end
						end	
					else
						TriggerClientEvent("Notify",source,"negado","Essa placa já está sendo usada",10000)	
					end
				end
			elseif itemName == "dinheiroespecie" then
				if parseInt(ramount) > 0 then
					if vRP.tryGetInventoryItem(user_id,"dinheiroespecie",parseInt(ramount)) then
						vRP.giveMoney(user_id,ramount)
						TriggerClientEvent("Notify",source,"sucesso","Você adicionou <b>$ "..vRP.format(parseInt(ramount)).." Dólares</b> a sua carteira.",10000)
						TriggerClientEvent("itensNotify",source,"negado","Dinheiro em Espécie")
						TriggerClientEvent('Creative:Update',source,'updateMochila')
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Informe um valor",10000)	
				end
			elseif itemName == "bandagem" then
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 300 then
					if bandagem[user_id] == 0 or not bandagem[user_id] then
						if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
							bandagem[user_id] = 120
							actived[user_id] = true
							vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
							TriggerClientEvent('Creative:Update',source,'updateMochila')
							TriggerClientEvent('cancelando',source,true)
							TriggerClientEvent("progress",source,20000,"bandagem")
							SetTimeout(20000,function()
								actived[user_id] = nil
								TriggerClientEvent('bandagemnova',source)
								TriggerClientEvent('cancelando',source,false)
								vRPclient._DeletarObjeto(source)
								TriggerClientEvent("Notify",source,"sucesso","Bandagem utilizada com sucesso.",8000)
								TriggerClientEvent("itensNotify",source,"negado","Bandagem")
								Citizen.Wait(10000)
								--TriggerClientEvent("resetBleeding",source)
							end)
						end
					else
						TriggerClientEvent("Notify",source,"importante","Aguarde "..vRPclient.getTimeFunction(source,parseInt(bandagem[user_id]))..".",8000)
					end
				else
				TriggerClientEvent("Notify",source,"aviso","Você não pode utilizar de vida cheia ou nocauteado.",8000)
				end
			elseif itemName == "dorflex" then
				if vDIAGNOSTIC.getBleeding(source) >= 1 then
					TriggerClientEvent("Notify",source,"importante","Você está com um sangramento, você não pode usar nenhum <b>Remedio</b>, vá até o <b>Hospital</b> mais próximo para receber atendimento.",8000)
					return
				end
				local src = source
				if vRP.tryGetInventoryItem(user_id,"dorflex",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("itensNotify",source,"negado","Dorflex")
					end)
				end

			elseif itemName == "gelol" then
				if vDIAGNOSTIC.getBleeding(source) >= 1 then
					TriggerClientEvent("Notify",source,"importante","Você está com um sangramento, você não pode usar nenhum <b>Remedio</b>, vá até o <b>Hospital</b> mais próximo para receber atendimento.",8000)
					return
				end
				local src = source
				if vRP.tryGetInventoryItem(user_id,"gelol",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"missfbi3_camcrew","final_loop_guy",49,28422)
					TriggerClientEvent("progress",source,10000,"passando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("itensNotify",source,"negado","Gelol")
					end)
				end

			elseif itemName == "agua-oxigenada" then
				if vDIAGNOSTIC.getBleeding(source) >= 1 then
					TriggerClientEvent("Notify",source,"importante","Você está com um sangramento, você não pode usar nenhum <b>Remedio</b>, vá até o <b>Hospital</b> mais próximo para receber atendimento.",8000)
					return
				end
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua-oxigenada",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"missfbi3_camcrew","final_loop_guy",49,28422)
					TriggerClientEvent("progress",source,10000,"passando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("itensNotify",source,"negado","Água-oxigenada")
					end)
				end

            elseif itemName == "coumadin" then
                if vRP.tryGetInventoryItem(user_id,"coumadin",1) then
                	vRPclient._CarregarObjeto(source,"mp_player_intdrink","loop_bottle","ng_proc_drug01a002",49,60309)
                	TriggerClientEvent('Creative:Update',source,'updateMochila')	
					TriggerClientEvent('cancelando',source,true)
                    TriggerClientEvent("progress",source,20500,"coumadin")
                    SetTimeout(20500,function()
                        TriggerClientEvent('cancelando',source,false)
                        TriggerClientEvent("resetBleeding",source)
                        vRPclient._DeletarObjeto(source)
                        TriggerClientEvent("Notify",source,"sucesso","Coumadin utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Coumadin")
                    end)
				end
				
			elseif itemName == "omeprazol" or itemName == "dipirona" or itemName == "paracetamol" or itemName == "decupramim" or itemName == "buscopan" or itemName == "novalgina" or itemName == "alivium" or itemName == "nokusin" or itemName == "sidelnafila" then
				if vDIAGNOSTIC.getBleeding(source) >= 1 then
					TriggerClientEvent("Notify",source,"importante","Você está com um sangramento, você não pode usar nenhum <b>Remedio</b>, vá até o <b>Hospital</b> mais próximo para receber atendimento.",8000)
					return
				end
				local src = source
				if (vRP.tryGetInventoryItem(user_id,"omeprazol",1) or vRP.tryGetInventoryItem(user_id,"dipirona",1) or vRP.tryGetInventoryItem(user_id,"paracetamol",1) or vRP.tryGetInventoryItem(user_id,"decupramim",1) or vRP.tryGetInventoryItem(user_id,"buscopan",1) or vRP.tryGetInventoryItem(user_id,"novalgina",1) or vRP.tryGetInventoryItem(user_id,"alivium",1) or vRP.tryGetInventoryItem(user_id,"nokusin",1) or vRP.tryGetInventoryItem(user_id,"sidelnafila",1)) then
		
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("itensNotify",source,"negado",itemName)
					end)
				end

			elseif itemName == "mochila" then
				if vRP.tryGetInventoryItem(user_id,"mochila",1) then
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRP.varyExp(user_id,"physical","strength",650)
					TriggerClientEvent("Notify",source,"sucesso","Mochila utilizada com sucesso.",8000)
					TriggerClientEvent("itensNotify",source,"negado","Mochila")
				end

			elseif itemName == "cerveja" then
				if vRP.tryGetInventoryItem(user_id,"cerveja",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Cerveja utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Cerveja")
					end)
				end

			elseif itemName == "tequila" then
				if vRP.tryGetInventoryItem(user_id,"tequila",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Tequila utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Tequila")
					end)
				end

			elseif itemName == "vodka" then
				if vRP.tryGetInventoryItem(user_id,"vodka",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Vodka utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Vodka")
					end)
				end
				
			elseif itemName == "whisky" then
				if vRP.tryGetInventoryItem(user_id,"whisky",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","p_whiskey_notop",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Whisky utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Whisky")
					end)
				end

			elseif itemName == "conhaque" then
				if vRP.tryGetInventoryItem(user_id,"conhaque",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Conhaque utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Conhaque")
					end)
				end

			elseif itemName == "absinto" then
				if vRP.tryGetInventoryItem(user_id,"absinto",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_amb_beer_bottle",49,28422)
					TriggerClientEvent("progress",source,30000,"BEBENDO")
					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Absinto utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Absinto")
					end)
				end

			elseif itemName == "identidade" then
				if identidade == false then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					local nplayerId = vRP.getUserId(nplayer)
					if nplayer then
						local identity = vRP.getUserIdentity(user_id)
						if identity then
							if vRP.tryGetInventoryItem(user_id,"identidade",1) then
								vRP.giveInventoryItem(nplayerId,"identidade",1)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								identidade = true;
								local value = vRP.getUData(nuser_id,"vRP:multas")
								local valormultas = json.decode(value) or 0
								local carteira = vRP.getMoney(nuser_id)
								local banco = vRP.getBankMoney(nuser_id)
								vRPclient.setDiv(nplayer,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 13px; font-family: arial; color: #fff; width: 420px; padding: 20px 20px 5px; bottom: 35%; right: 2.5%; position: absolute; border: 1px solid rgba(0,0,0,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 200px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #e9700d; }","<div class=\"local\"><b>Nome:</b> "..identity.name.." "..identity.firstname.." ( "..vRP.format(identity.user_id).." )</div><div class=\"local2\"><b>Placa:</b> "..identity.registration.."</div><div class=\"local\"><b>Idade:</b> "..identity.age.." Anos</div><div class=\"local2\"><b>Telefone:</b> "..identity.phone.."</div><div class=\"local\"><b>Multas pendentes:</b> "..vRP.format(parseInt(valormultas)).."</div><div class=\"local2\"><b>Carteira:</b> "..vRP.format(parseInt(carteira)).."</div>")
								local ok = vRP.request(nplayer,"Você deseja fechar o registro geral?",1000)
								if ok then
									vRPclient.removeDiv(nplayer,"completerg")
									vRP.tryGetInventoryItem(nplayerId,"identidade",1) 
									vRP.giveInventoryItem(user_id,"identidade",1)
									identidade = false;
								else
									vRPclient.removeDiv(nplayer,"completerg")
									vRP.tryGetInventoryItem(nplayerId,"identidade",1) 
									vRP.giveInventoryItem(user_id,"identidade",1)
									identidade = false;
								end
							end
						end
					end
				else
					TriggerClientEvent("Notify",source,"aviso","Aguarde sua Identidade ser devolvida!",8000)
				end
			elseif itemName == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"maconha",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Maconha")
					end)
				end

			elseif itemName == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,10000,"cheirando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						--TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,"sucesso","Cocaína utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Cocaina")
					end)
					--[[SetTimeout(120000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,"aviso","O efeito da cocaína passou e o coração voltou a bater normalmente.",8000)
					end)]]
				end

			elseif itemName == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Metanfetamina utilizada com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Metanfetamina")
					end)
				end	

			elseif itemName == "lsd" then
				if vRP.tryGetInventoryItem(user_id,"lsd",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"tomando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","LSD utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","LSD")
					end)
				end		

			elseif itemName == "rebite" then
				if vRP.tryGetInventoryItem(user_id,"rebite",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,10000,"BEBENDO")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient.playScreenEffect(source,"RaceTurbo",90)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",90)
						TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Rebite utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Rebite")
					end)
					SetTimeout(90000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,"aviso","O efeito do rebite passou e o coração voltou a bater normalmente.",8000)
					end)
				end

			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Capuz")
					end
				end

			elseif itemName == "energetico" then
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent('cancelando',source,true)
					vRPclient._CarregarObjeto(source,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,4000,"BEBENDO")
					SetTimeout(4000,function()
						actived[user_id] = nil
						TriggerClientEvent('energeticos',source,true)
						TriggerClientEvent('cancelando',source,false)
						vRPclient._DeletarObjeto(source)
						TriggerClientEvent("Notify",source,"sucesso","Energético utilizado com sucesso.",8000)
						TriggerClientEvent("itensNotify",source,"negado","Energético")
					end)
					SetTimeout(60000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou e o coração voltou a bater normalmente.",8000)
					end)
				end

			-------------------------------------------------------------------------------------------------------------------------------------------------
			--[ BEBIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "agua" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua",1) then
					--TriggerClientEvent("itensNotify",source,"negado","Água")
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ba_prop_club_water_bottle",49,28422)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						vRP.giveInventoryItem(user_id,"garrafavazia",1)
						--TriggerClientEvent("itensNotify",source,"sucesso","Garrafa Vazia")
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Agua</b>.")	
					end)
				end

			elseif itemName == "leite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"leite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-25)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Leite</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Leite")
					end)

				end

			elseif itemName == "laranja" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"laranja",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_ornge1a",49,28422)
					TriggerClientEvent("progress",source,5000,"comendo")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-20)
						vRP.varyHunger(user_id,-20)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você chupou uma <b>Laranja</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Laranja")
					end)

				end
			elseif itemName == "algodaodoce" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"algodaodoce",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bag1",49,0)
					TriggerClientEvent("progress",source,5000,"comendo")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyHunger(user_id,-30)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Algodão Doce</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Algodão Doce")
					end)

				end	
			elseif itemName == "cafe" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafe",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						TriggerClientEvent('energeticos',source,true)
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-25)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Café</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Café")
					end)
					SetTimeout(40000,function()
						TriggerClientEvent('energeticos',source,false)
						TriggerClientEvent("Notify",source,"aviso","O efeito do <b>cafe<b> passou e o coração voltou a bater normalmente.",5000)
					end)
				end

			elseif itemName == "cafecleite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafecleite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-30)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Café Com Leite</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Café Com Leite")
					end)

				end
			elseif itemName == "cafeexpresso" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafeexpresso",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-30)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cafe Expresso</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Cafe Expresso")
					end)

				end
			elseif itemName == "capuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"capuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-30)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Capuccino</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Capuccino")
					end)

				end
			elseif itemName == "frappuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frappuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-35)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Frappuccino</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Frappuccino")
					end)

				end
			elseif itemName == "cha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Chá")
					end)

				end
			elseif itemName == "icecha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"icecha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá Gelado</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Chá Gelado")
					end)

				end
			elseif itemName == "sprunk" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sprunk",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01b",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-25)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Sprunk</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Sprunk")
					end)

				end
			elseif itemName == "cola" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cola",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01a",49,28422)
					TriggerClientEvent("progress",source,5000,"tomando")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-20)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cola</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Cola")
					end)

				end

			elseif itemName == "uva" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"uva",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bag1",49,1)
					TriggerClientEvent("progress",source,5000,"comendo")

					SetTimeout(5000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-5)
						vRP.varyHunger(user_id,-5)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu <b>Uva</b>.")
					end)

				end

			elseif itemName == "vinhobranco" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"vinhobranco",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_beer_bot_02",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")

					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Vinho Branco</b>.")
					end)

				end

			elseif itemName == "vinhorose" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"vinhorose",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_pissh",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")

					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Vinho Rose</b>.")
					end)

				end

			elseif itemName == "vinhotinto" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"vinhotinto",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_beer_stz",49,28422)
					TriggerClientEvent("progress",source,30000,"bebendo")

					SetTimeout(30000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Vinho Tinto</b>.")
					end)

				end

				--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ COMIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "sanduiche" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sanduiche",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-25)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Sanduiche</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Sanduiche")
					end)

				end
			elseif itemName == "rosquinha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"rosquinha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer3")
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-15)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma <b>Rosquinha</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Rosquinha")
					end)

				end
			elseif itemName == "hotdog" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"hotdog",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer2")
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-30)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>HotDog</b>.")
						TriggerClientEvent("itensNotify",source,"negado","HotDog")
					end)

				end
			elseif itemName == "xburguer" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"xburguer",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-50)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>xBurguer</b>.")
						TriggerClientEvent("itensNotify",source,"negado","xBurguer")
					end)

				end
			elseif itemName == "chips" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"chips",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_chips01b",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-15)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma <b>Batata Chips</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Batata Chips")
					end)

				end
			elseif itemName == "batataf" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"batataf",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bs_chips",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-30)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma caixinha de <b>Batafa Frita</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Batafa Frita")
					end)

				end
			elseif itemName == "pizza" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pizza",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-60)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma <b>Pizza</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Pizza")
					end)

				end
			elseif itemName == "frango" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frango",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_cb_nugets",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Frango Frito</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Frango Frito")
					end)

				end
			elseif itemName == "bcereal" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bcereal",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_pq",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-20)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma <b>Barra de Cereal</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Barra de Cereal")
					end)

				end
			elseif itemName == "bchocolate" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bchocolate",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_meto",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-20)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu uma <b>Barra de Chocolate</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Barra de Chocolate")
					end)

				end
			elseif itemName == "taco" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"taco",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_taco_01",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Taco</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Taco")
					end)

				end
			elseif itemName == "yakisoba" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"yakisoba",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_plate_01",49,28422)
					TriggerClientEvent("progress",source,8000,"comendo")

					SetTimeout(8000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-30)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Yakisoba</b>.")
						TriggerClientEvent("itensNotify",source,"negado","Yakisoba")
					end)

				end

			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("policia.permissao")
				if #policia < 1 then
					TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento para iniciar o roubo.")
					return true
				end
				if vRP.hasPermission(user_id,"policia.permissao") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end
				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					TriggerClientEvent("itensNotify",source,"negado","Lock Pick")
					actived[user_id] = true
					if vRP.hasPermission(user_id,"polpar.permissao") then
						actived[user_id] = nil
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						return
					end

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,30000,"roubando")
					SetTimeout(30000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						if math.random(100) >= 50 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
							
						else
							TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("policia.permissao")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent("NotifyPush",source,{ code = "RU", title = "Roubo a veículo em andamento.", x = x, y = y, z = z, badge = "Verifique o ocorrido." })
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end
					end)
				end

			elseif itemName == "masterpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("policia.permissao")
				if #policia < 5 then
					TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento para iniciar o roubo.")
					return true
				end
				if vRP.hasPermission(user_id,"policia.permissao") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end
				if vRP.getInventoryItemAmount(user_id,"masterpick") >= 1 and vRP.tryGetInventoryItem(user_id,"masterpick",1) and vehicle then
					TriggerClientEvent("itensNotify",source,"negado","Master Pick")
					actived[user_id] = true
					if vRP.hasPermission(user_id,"polpar.permissao") then
						actived[user_id] = nil
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						return
					end

					TriggerClientEvent('cancelando',source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,60000,"roubando")
					SetTimeout(60000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						TriggerClientEvent("Notify",source,"importante","Roubo do veículo concluído e as autoridades foram acionadas.",8000)
						local policia = vRP.getUsersByPermission("policia.permissao")
						local x,y,z = vRPclient.getPosition(source)
						for k,v in pairs(policia) do
							local player = vRP.getUserSource(parseInt(v))
							if player then
								async(function()
									local id = idgens:gen()
									vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
									TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
									pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
									SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
								end)
							end
						end
					end)
				end

			elseif itemName == "militec" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando motor")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararmotor',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								TriggerClientEvent("itensNotify",source,"negado","Militec")
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando motor")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	

			elseif itemName == "repairkit" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"mecanico.permissao") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,10000,"reparando veículo")
							SetTimeout(10000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('reparar',source)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
								TriggerClientEvent("itensNotify",source,"negado","Repair Kit")
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando veículo")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('reparar',source)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	

			elseif itemName == "ouro" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3)
					if vehicle then
						if vRP.hasPermission(user_id,"") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando pneus")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararpneus',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"ouro",1) then
								TriggerClientEvent("itensNotify",source,"negado","Ouro")
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando pneus")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararpneus',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end	

			elseif itemName == "notebook" then
				if vRPclient.isInVehicle(source) then
					local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
					if vehicle and placa then
						actived[user_id] = true
						vGARAGE.freezeVehicleNotebook(source,vehicle)
						TriggerClientEvent('cancelando',source,true)
						TriggerClientEvent("progress",source,59500,"removendo rastreador")
						SetTimeout(60000,function()
							actived[user_id] = nil
							TriggerClientEvent('cancelando',source,false)
							local placa_user_id = vRP.getUserByRegistration(placa)
							if placa_user_id then
								local player = vRP.getUserSource(placa_user_id)
								if player then
									vGARAGE.removeGpsVehicle(player,vname)
								end
							end
						end)
					end
				end

			elseif itemName == "placa" then
                if vRPclient.GetVehicleSeat(source) then
                    if vRP.tryGetInventoryItem(user_id,"placa",1) then
						TriggerClientEvent("itensNotify",source,"negado","Placa")
                        local placa = vRP.generatePlate()
                        TriggerClientEvent('Creative:Update',source,'updateMochila')
                        TriggerClientEvent('cancelando',source,true)
                        TriggerClientEvent("vehicleanchor",source)
                        TriggerClientEvent("progress",source,15000,"clonando")
                        SetTimeout(15000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            --TriggerEvent("setPlateEveryone",placa)
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
				end
				
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,200)
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("itensNotify",source,"negado","Colete")
				end	

			elseif itemName == "morfina" then
				local paramedico = vRP.getUsersByPermission("polpar.permissao")
				if parseInt(#paramedico) < 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						if vRPclient.isComa(nplayer) then
							if vRP.tryGetInventoryItem(user_id,"morfina",1) then
								TriggerClientEvent("itensNotify",source,"negado","Morfina")
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"amb@medic@standing@tendtodead@base","base"},{"mini@cpr@char_a@cpr_str","cpr_pumpchest"}},true)
								TriggerClientEvent("progress",source,30000,"reanimando")
								SetTimeout(30000,function()
									vRPclient.networkRessurection(nplayer)
									vRPclient._stopAnim(source,false)
									TriggerClientEvent('cancelando',source,false)
								end)
							end
						else
							TriggerClientEvent("Notify",source,"importante","A pessoa precisa estar em coma para prosseguir.",8000)
						end
					end
				end
			end

		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)
				SendWebhookMessage(webhookequipar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[EQUIPOU]: "..vRP.itemNameList(itemName).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				TriggerClientEvent('Creative:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
      		local weaponuse = string.gsub(itemName,"wammo|","")
      		local weaponusename = "wammo|"..weaponuse
			local identity = vRP.getUserIdentity(user_id)
      		if uweapons[weaponuse] then
        		local itemAmount = 0
        		local data = vRP.getUserDataTable(user_id)
        		for k,v in pairs(data.inventory) do
         			if weaponusename == k then
            			if v.amount > 250 then
              				v.amount = 250
            			end

						itemAmount = v.amount

            			if vRP.tryGetInventoryItem(user_id, weaponusename, parseInt(v.amount)) then
							local weapons = {}
							weapons[weaponuse] = { ammo = v.amount }
							itemAmount = v.amount
							vRPclient._giveWeapons(source,weapons,false)
							SendWebhookMessage(webhookequipar,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RECARREGOU]: "..vRP.itemNameList(itemName).." \n[MUNICAO]: "..parseInt(v.amount).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							TriggerClientEvent('Creative:Update',source,'updateMochila')
            			end
          			end
        		end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	actived[user_id] = nil
end)