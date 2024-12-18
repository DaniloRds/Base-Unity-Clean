-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local carrosvip1 = {} 
local carrosvip2 = {} 
local carrosvip3 = {}
local motosvip = {}
local adicionaisvip = {}
local pacotesvip = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VEÍCULOS VIPS SYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(vRP.vehicleGlobal()) do 
		if v.tipo == "carrosvip1" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = vRP.vehicleMala(k) or 50
				table.insert(carrosvip1,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "carrosvip2" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = vRP.vehicleMala(k) or 50
				table.insert(carrosvip2,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "carrosvip3" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = vRP.vehicleMala(k) or 50
				table.insert(carrosvip3,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
		if v.tipo == "motosvip" then
			local vehicle = vRP.query("creative/get_estoque",{ vehicle = k })
			if vehicle[1] ~= nil then
				local bau = vRP.vehicleMala(k) or 50
				table.insert(motosvip,{ k = k, nome = v.name, price = v.price2, chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMS VIPS SYNC
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for k,v in pairs(vRP.itemVip()) do 
		if v.tipo == "adicionaisvip" then
			table.insert(adicionaisvip,{ k = k, nome = v.name, price = v.preco})
		end
		if v.tipo == "pkgvips" then
			table.insert(pacotesvip,{ k = k, nome = v.name, price = v.preco})
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEVEHICLES
-----------------------------------------------------------------------------------------------------------------------------------------
function src.updateVehicles(vname,vehtype)
	if vehtype == "carrosvip1" then
		for k,v in pairs(carrosvip1) do
			if v.k == vname then
				table.remove(carrosvip1,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = vRP.vehicleMala(vname) or 50
					table.insert(carrosvip1,{ k = vname, nome = vRP.vehicleName(vname), price = (vRP.vehiclePrice2(vname)), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "carrosvip2" then
		for k,v in pairs(carrosvip2) do
			if v.k == vname then
				table.remove(carrosvip2,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = vRP.vehicleMala(vname) or 50
					table.insert(carrosvip2,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "carrosvip3" then
		for k,v in pairs(carrosvip3) do
			if v.k == vname then
				table.remove(carrosvip3,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = vRP.vehicleMala(vname) or 50
					table.insert(carrosvip3,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	elseif vehtype == "motosvip" then
		for k,v in pairs(motosvip) do
			if v.k == vname then
				table.remove(motosvip,k)
				local vehicle = vRP.query("creative/get_estoque",{ vehicle = vname })
				if vehicle[1] ~= nil then
					local bau = vRP.vehicleMala(vname) or 50
					table.insert(motosvip,{ k = vname, nome = vRP.vehicleName(vname), price = vRP.vehiclePrice2(vname), chest = parseInt(bau), stock = parseInt(vehicle[1].quantidade)})
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 1
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip1()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip1
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 2
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip2
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARROS VIP 3
-----------------------------------------------------------------------------------------------------------------------------------------
function src.CarrosVip3()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return carrosvip3
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOTOS VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.MotosVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return motosvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADICIONAIS VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.AdicionaisVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return adicionaisvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PACOTES VIP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.PacotesVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return pacotesvip
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDAS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.PossuidosVip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local veiculos = {}
		local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
		for k,v in pairs(vehicle) do
			if vRP.vehicleType(v.vehicle) == "carrosvip1" then
				local bau =vRP.vehicleMala(v.vehicle) or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "carrosvip2" then
				local bau =vRP.vehicleMala(v.vehicle) or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "carrosvip3" then
				local bau =vRP.vehicleMala(v.vehicle) or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
			if vRP.vehicleType(v.vehicle) == "motosvip" then
				local bau =vRP.vehicleMala(v.vehicle) or 50
				table.insert(veiculos,{ k = v.vehicle, nome = vRP.vehicleName(v.vehicle), price = parseInt(vRP.vehiclePrice(v.vehicle)), chest = parseInt(bau)})
			end
		end
		return veiculos
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.buyShop(name)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if vRP.itemVipType(name) == "adicionaisvip" then
			if name == "valemansao" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
					vRP.giveInventoryItem(user_id,"valemansao",1)
					TriggerClientEvent("Notify",source,"compras","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			elseif name == "valefone" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
					vRP.giveInventoryItem(user_id,"valefone",1)
					TriggerClientEvent("Notify",source,"compras","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			elseif name == "valeplaca" then
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
					vRP.giveInventoryItem(user_id,"valeplaca",1)
					TriggerClientEvent("Notify",source,"compras","Você comprou <b> 1x "..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			else -- Aqui é referente ao adicional DINHEIRO
				if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
					vRP.giveBankMoney(user_id,parseInt(vRP.itemVipPrice2(name)))
					TriggerClientEvent("Notify",source,"compras","Você comprou $ <b>"..vRP.format(parseInt(vRP.itemVipPrice2(name))).." Dólares</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
				end
			end


-- DAQUI PARA BAIXO VOCÊ PODE CONFIGURAR OS ITENS QUE CADA VIP VÃO DAR. ITENS | CARROS | DINHEIRO |

-- PARA DAR UM CARRO: vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "NOMESPAWN", ipva = os.time() })
-- PARA DAR ITEM: vRP.giveInventoryItem(user_id,"NOMEITEM",QUANTIDADE)
-- PARA DAR DINHEIRO: vRP.giveBankMoney(user_id,parseInt(QUANTIDADE))

-- PARA ADICIONAR ESSES COMANDOS BASTA COLOCALOS ABAIXO DE vRP.insertNewVip NO VIP QUE DESEJA.


		elseif vRP.itemVipType(name) == "pkgvips" then
			if name == "pacoteVip1" then 
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
						vRP.addUserGroup(user_id,"standart") -- grupo do vip (vrp/cfg/groups.lua)
						vRP.insertNewVip(user_id,"standart")
						-- vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "panto", ipva = os.time() }) -- veículo que o player vai receber
						-- vRP.giveBankMoney(user_id,parseInt(100000)) -- valor em dinheiro
						TriggerClientEvent("Notify",source,"compras","Você se tornou <b>VIP STANDART</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			elseif name == "pacoteVip2" then
				-- local dinheiro = vRP.vipsConfig(user_id,"dinheiro")
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
						vRP.addUserGroup(user_id,"premium")
						vRP.insertNewVip(user_id,"premium")
						-- vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						-- vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() }) 
						vRP.giveInventoryItem(user_id,"valemansao",2)
						TriggerClientEvent("Notify",source,"compras","Você se tornou <b>VIP PREMIUM</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			elseif name == "pacoteVip3" then
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
						vRP.addUserGroup(user_id,"elite")
						vRP.insertNewVip(user_id,"elite")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "porsche992", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "yzfr6", ipva = os.time() })
						vRP.giveBankMoney(user_id,parseInt(350000))
						vRP.giveInventoryItem(user_id,"valemansao",2)
						vRP.giveInventoryItem(user_id,"valefone",1)
						TriggerClientEvent("Notify",source,"compras","Você se tornou <b>VIP ELITE</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			elseif name == "pacoteVip4" then
				if not vRP.getVipActive(user_id) then
					if vRP.tryPaymentCoin(user_id,parseInt(vRP.itemVipPrice(name))) then
						vRP.addUserGroup(user_id,"ultimate")
						vRP.insertNewVip(user_id,"ultimate")
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "amggtr", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "19ftype", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "porsche992", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "yzfr6", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "lamborghinihuracan", ipva = os.time() })
						vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = "swift2", ipva = os.time() })
						vRP.giveBankMoney(user_id,parseInt(550000))
						vRP.giveInventoryItem(user_id,"valemansao",2)
						vRP.giveInventoryItem(user_id,"valefone",1)
						vRP.giveInventoryItem(user_id,"valeplaca",1)

						TriggerClientEvent("Notify",source,"compras","Você se tornou <b>VIP ULTIMATE</b> por <b> "..vRP.format(parseInt(vRP.itemVipPrice(name))).." Moedas</b>.",10000)
					else
						TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
					end
				else
					TriggerClientEvent("Notify",source,"importante","Você já possuí um VIP ativo",10000)
				end
			end
		else -- Aqui é para a compra de veículos, não é necessário configurar
			if not vRP.checkVagasGaragem(user_id,0) then
				TriggerClientEvent("Notify",source,"importante","Atingiu o número máximo de veículos em sua garagem.",8000)
				return
			end

			local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
			if vehicle[1] then
				TriggerClientEvent("Notify",source,"importante","Você já possui um <b>"..vRP.vehicleName(name).."</b> em sua garagem.",10000)
				return
			else
				local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
				if parseInt(rows2[1].quantidade) <= 0 then
					TriggerClientEvent("Notify",source,"aviso","Estoque de <b>"..vRP.vehicleName(name).."</b> indisponivel.",8000)
					return
				end
				if vRP.tryPaymentCoin(user_id,vRP.vehiclePrice2(name)*1) then
					vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) - 1 })
					vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = name, ipva = os.time() })
					TriggerClientEvent("Notify",source,"compras","Você comprou um <b>"..vRP.vehicleName(name).."</b> por <b> "..vRP.format(parseInt(vRP.vehiclePrice2(name)*1)).." moedas</b>.",10000)
					src.updateVehicles(name,vRP.vehicleType(name))
					if vRP.vehicleType(name) == "carrosvip1" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip1')
					elseif vRP.vehicleType(name) == "carrosvip2" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip2')
					elseif vRP.vehicleType(name) == "carrosvip3" then
						TriggerClientEvent('shopvip:Update',source,'updateCarrosvip3')
					elseif vRP.vehicleType(name) == "motosvip" then
						TriggerClientEvent('shopvip:Update',source,'updateMotosvip')
					end
				else
					TriggerClientEvent("Notify",source,"negado","Moedas Insuficiente.",10000)
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function src.sellShop(name)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
		local rows2 = vRP.query("creative/get_estoque",{ vehicle = name })
		if vehicle[1] then
			vRP.execute("creative/rem_vehicle",{ user_id = parseInt(user_id), vehicle = name })
			vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..name })
			vRP.execute("creative/set_estoque",{ vehicle = name, quantidade = parseInt(rows2[1].quantidade) + 1 })
			vRP.giveBankMoney(user_id,parseInt(vRP.vehiclePrice(name)))
			TriggerClientEvent("Notify",source,"sucesso","Você vendeu um <b>"..vRP.vehicleName(name).."</b> por <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*1)).." $</b>.",10000)
			src.updateVehicles(name,vRP.vehicleType(name))
			TriggerClientEvent('dealership:Update',source,'updatePossuidosvip')
		end
	end
end
--
function src.permissao()
    local source = source
    local user_id = vRP.getUserId(source)
    return
end
