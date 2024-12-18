--------------------------------
-- [ CONEXAO ] --
--------------------------------

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_concessionaria",src)
vCLIENT = Tunnel.getInterface("vrp_concessionaria")

local actived = {}

vRP._prepare("warn/select", "SELECT * FROM vrp_estoque") 
vRP._prepare("warn/select2", "SELECT * FROM vrp_estoque WHERE vehicle = @vehicle") 
vRP._prepare("warn/set_estoque","UPDATE vrp_estoque SET estoque = @estoque WHERE vehicle = @vehicle")
vRP._prepare("warn/update_estoque", "UPDATE vrp_estoque SET estoque = estoque + @estoque WHERE vehicle = @vehicle") 

src.return_nome = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local identity = vRP.getUserIdentity(user_id)
        local infos = vRP.query("database/imgProfile", {user_id = parseInt(user_id)})
        if infos[1] then
            return ""..identity.name.." "..identity.firstname.."",infos[1].foto,true
        else
            return ""..identity.name.." "..identity.firstname.."","https://i.pinimg.com/736x/5c/95/31/5c9531d05f919414e9dff0c974388f67.jpg",false
        end
    end
end

src.consultCarros = function(ConceNumber,carroLista)
    local source = source
    local user_id = vRP.getUserId(source)
    
    listCarros = {}
    if user_id then
        if carroLista == "Possuidos" then
            local vehicle = vRP.query("creative/get_vehicle",{ user_id = user_id })
            for k,v in pairs(vehicle) do
                local veh = v.vehicle
                local vehName = vRP.vehicleName(veh)
                local bau = vRP.vehicleMala(veh)
                if veh then
                    table.insert(listCarros,{ k = veh, carro = vehName, bau = bau })
                end
            end
        else
            local SQL = vRP.query("warn/select")
            for k,v in pairs(SQL) do
                local veh = v.vehicle
                local vehType = vRP.vehicleModel(veh)
                local vehPrice = vRP.vehiclePrice(veh)
                local vehName = vRP.vehicleName(veh)
                local bau = vRP.vehicleMala(veh)
                local seguro = vehPrice/10
                if (veh) then
                    table.insert(listCarros,{k = veh, carro = vehName, bau = bau, seguro = seguro, valor2 = vehPrice, valor = (parseInt(vehPrice)), estoque = v.estoque, tipo = vehType })
                end
            end
        end
        return listCarros
    end
end

src.consultCarrosList = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        return listCarros
    end
end

src.AlterarMundo = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local random = math.random(9000,20000)
        SetPlayerRoutingBucket(source,random)
    end
end

src.VoltarMundo = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
		SetPlayerRoutingBucket(source,0)
    end
end

src.ConfirmTestDrive = function(carro)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.request(source,"Você deseja realizar o teste no carro "..(carro).." ?",30) then
            return true
        else
            return false
        end
    end
end

src.comprarCarro = function(carro,red,green,blue)
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(nuser_id,"vRP:multas")
    local valormultas = json.decode(value) or 0
    local vehName = vRP.vehicleName(carro)
    local vehPrice = vRP.vehiclePrice(carro)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        local custom = {}
        if valormultas > 0 then
            TriggerClientEvent("Notify",source,"aviso","Multas pendentes encontradas.",5000)
            return
        end

        if not vRP.checkVagasGaragem(user_id,0) then
            TriggerClientEvent("Notify",source,"negado","Atingiu o número máximo de veículos em sua garagem.",5000)
            return
        end

        local vehicle = vRP.query("creative/get_vehicles",{ user_id = user_id, vehicle = carro, alugado = 0 })
        if vehicle[1] then
            TriggerClientEvent("Notify",source,"negado","Você já possui um veículo <b>"..vehName.."</b> em seu nome.",5000)
            return
        else
            local SQL = vRP.query("warn/select2", {vehicle = carro })
            if SQL[1].estoque >= 1 then
                    if vRP.request(source,"Você deseja realizar a compra do carro "..vehName.." por "..vehPrice.." $ ?",30) then
                        if vRP.tryFullPayment(user_id,vehPrice) then
                            vRP.execute("creative/add_vehicle",{ user_id = parseInt(user_id), vehicle = carro, ipva = os.time() })
                            custom.colorp = {red,green,blue}
                            custom.colors = {red,green,blue}
                            vRP.setSData("color:u"..parseInt(user_id).."veh_"..vehName,json.encode(custom))
							TriggerClientEvent("Notify",source,"compras","Compra concluída, o veículo já está em sua garagem.",5000)

                            PerformHttpRequest("https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys", function(err, text, headers) end, 'POST', json.encode({
                            embeds = {
                                {     
                                    title = "**Comprou um Veículo**",
                                    fields = {
                                        { 
                                            name = "📝 Author:", 
                                            value = "" ..identity.name.." "..identity.firstname.." **#"..user_id.."** ",
                                        },
                                        { 
                                            name = "🚗 Carro:", 
                                            value = ""..vehName.."",
                                        },
                                        { 
                                            name = "💸 Valor:", 
                                                value = "$"..vehPrice.." \n \n " 
                                        },
                                    }, 
                                    footer = { 
                                        text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                                        icon_url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                    },
                                    thumbnail = { 
                                        url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                    },
                                    color = 5763719  
                                }
                            }
                        }), { ['Content-Type'] = 'application/json' })

                            return true
						else
							TriggerClientEvent("Notify",source,"negado","<b>Dinheiro</b> insuficiente, verifique com seu banco.",5000)
						end
                    end
            end
        end
    end
end

src.venderCarro = function(carro)
    local source = source
	local user_id = vRP.getUserId(source)
    local vehName = vRP.vehicleName(carro)
    local vehPrice = vRP.vehiclePrice(carro)
    local vehType = vRP.vehicleModel(carro)
    local value = vRP.getUData(nuser_id,"vRP:multas")
    local valormultas = json.decode(value) or 0
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        local vehicle = vRP.query("creative/get_vehicles",{ user_id = user_id, vehicle = carro, alugado = 0 })
        local SQL = vRP.query("warn/select2", {vehicle = carro })
        if carro then
            if SQL[1] then
                if SQL[1].estoque > 0 then
                    if vehicle[1] then
                        if parseInt(os.time()) >= parseInt(vehicle[1]["ipva"]+24*15*60*60) then
                            local ipvaPrice = parseInt(vehPrice * 0.10)
                            if vRP.request(source,"Você deseja pagar o ipva atrasado do carro "..vehName.." por "..ipvaPrice.."$ para liberar a venda?",30) then
                                if vRP.tryFullPayment(user_id,vehiclePrice) then
                                    vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = carro, ipva = parseInt(os.time()) })
                                    TriggerClientEvent("tablet:Update",source,"requestPossuidos")
                                else
                                    TriggerClientEvent("Notify",source,"negado","<b>Dinheiro</b> insuficiente, entre em contato com o seu banco.",5000)
                                end
                            end
                        else
                            if carro == "faggio" or carro == "manchez" or carro == "bf400" or carro == "baller6" then
                                TriggerClientEvent("Notify",source,"negado","Esse veículo não pode ser vendido.",3000)
                                actived[user_id] = nil
                                return false
                            elseif valormultas > 0 then
                                TriggerClientEvent("Notify",source,"negado","Multas pendentes encontradas, pague para poder vender seu veículo.",5000)
                                actived[user_id] = nil
                                return false
                            elseif vehType == "work" then
                                TriggerClientEvent("Notify",source,"negado","Veículos de serviço não podem ser vendidos.",5000)
                                actived[user_id] = nil
                                return false
                            else
                                if vRP.request(source,"Você deseja vender o veículo "..vehName.." por "..parseInt(vehPrice * 0.5).."$ ?",30) then
                                    vRP.giveMoney(user_id, parseInt(vehPrice * 0.5))
                                    vRP.execute("creative/rem_vehicle",{ user_id = user_id, vehicle = carro})
                                    vRP.execute("warn/update_estoque",{estoque = 1, vehicle = carro})
                                    vRP.setSData("color:u"..parseInt(user_id).."veh_"..carro,json.encode({}))
                                    vRP.setSData("custom:u"..parseInt(user_id).."veh_"..carro,json.encode({}))
                                    TriggerClientEvent("Notify",source,"sucesso","O veículo "..vehName.." foi vendido e o dinheiro já está em sua conta.",5000)
                                    
                                PerformHttpRequest("https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys", function(err, text, headers) end, 'POST', json.encode({
                                    embeds = {
                                        {     
                                            title = "**Vendeu um Veículo**",
                                            fields = {
                                                { 
                                                    name = "📝 Author:", 
                                                    value = "" ..identity.name.." "..identity.firstname.." **#"..user_id.."** ",
                                                },
                                                { 
                                                    name = "🚗 Carro:", 
                                                    value = ""..vehName.."",
                                                },
                                                { 
                                                    name = "💸 Valor:", 
                                                        value = "$"..parseInt(vehPrice * 0.5).." \n \n " 
                                                },
                                            }, 
                                            footer = { 
                                                text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                                                icon_url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                            },
                                            thumbnail = { 
                                                url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                            },
                                            color = 3447003  
                                        }
                                    }
                                }), { ['Content-Type'] = 'application/json' })

                                end
                            end
                        end
                    end
                else
                    if vehicle[1] then
                        if parseInt(os.time()) >= parseInt(vehicle[1]["ipva"]+24*15*60*60) then
                            local ipvaPrice = parseInt(vehPrice * 0.10)
                            if vRP.request(source,"Você deseja pagar o ipva atrasado do carro "..vehName.." por "..ipvaPrice.."$ para liberar a venda?",30) then
                                if vRP.tryFullPayment(user_id,vehiclePrice) then
                                    vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = carro, ipva = parseInt(os.time()) })
                                    TriggerClientEvent("tablet:Update",source,"requestPossuidos")
                                else
                                    TriggerClientEvent("Notify",source,"negado","<b>Dinheiro</b> insuficiente, entre em contato com o seu banco.",5000)
                                end
                            end
                        else
                            if carro == "faggio" or carro == "manchez" or carro == "bf400" or carro == "baller6" then
                                TriggerClientEvent("Notify",source,"negado","Esse veículo não pode ser vendido.",3000)
                                actived[user_id] = nil
                                return false
                            elseif valormultas > 0 then
                                TriggerClientEvent("Notify",source,"negado","Multas pendentes encontradas, pague para poder vender seu veículo.",3000)
                                actived[user_id] = nil
                                return false
                            elseif vehType == "work" then
                                TriggerClientEvent("Notify",source,"negado","Veículos de serviço não podem ser vendidos.",3000)
                                actived[user_id] = nil
                                return false
                            else
                                if vRP.request(source,"Como não temos o modelo do seu veículo ("..vehName..") em estoque vamos oferecer "..parseInt(vehPrice * 0.65).."$ por ele, deseja vender?",30) then
                                    vRP.giveMoney(user_id, parseInt(vehPrice * 0.65))
                                    vRP.execute("creative/rem_vehicle",{ user_id = user_id, vehicle = carro})
                                    vRP.execute("warn/update_estoque",{estoque = 1, vehicle = carro})
                                    TriggerClientEvent("Notify",source,"sucesso","O veículo "..vehName.." foi vendido e o dinheiro já está em sua conta.",3000)

                                    PerformHttpRequest("https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys", function(err, text, headers) end, 'POST', json.encode({
                                        embeds = {
                                            {     
                                                title = "**Vendeu um Veículo**",
                                                fields = {
                                                    { 
                                                        name = "📝 Author:", 
                                                        value = "" ..identity.name.." "..identity.firstname.." **#"..user_id.."** ",
                                                    },
                                                    { 
                                                        name = "🚗 Carro:", 
                                                        value = ""..vehName.."",
                                                    },
                                                    { 
                                                        name = "💸 Valor:", 
                                                            value = "$"..parseInt(vehPrice * 0.65).." \n \n " 
                                                    },
                                                }, 
                                                footer = { 
                                                    text = os.date('Dia: %d/%m/%Y - Horas: %H:%M:%S'),
                                                    icon_url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                                },
                                                thumbnail = { 
                                                    url = "https://cdn.discordapp.com/attachments/1293036193054982299/1297967065969201153/log.png?ex=6745fe07&is=6744ac87&hm=41aa8298cc5c277a6da2c1bb2eace8ca23c5cdec69b36153fb63e16e9255a205&"
                                                },
                                                color = 3447003  
                                            }
                                        }
                                    }), { ['Content-Type'] = 'application/json' })

                                end
                            end
                        end
                    end
                end
            else
                TriggerClientEvent("Notify",source,"negado","Nossa concessionária não trabalha com este veículo, tente vender em outro lugar.",3000)
            end
        end
    end
end

local plateVehs = {}
function src.startDrive()
	local source = source
	local user_id = vRP.getUserId(source)
    local testPrice = Config.Valor_TesteDrive
	if user_id then
		if actived[user_id] == nil then
			actived[user_id] = true
            TriggerClientEvent("vRP:fecharConce",user_id)
				if vRP.request(source,"Deseja iniciar o teste drive por <b>$"..testPrice.."</b>?",30) then
					if vRP.tryFullPayment(user_id,testPrice) then
						plateVehs[user_id] = "PDMS"..(1000 + user_id)
						TriggerEvent("engine:tryFuel",plateVehs[user_id],100)
						TriggerClientEvent("update:Route",source,user_id)
						TriggerEvent("plateEveryone",plateVehs[user_id])
						SetPlayerRoutingBucket(source,user_id)
						actived[user_id] = nil
						return true,plateVehs[user_id]
					else
                        TriggerClientEvent("Notify",source,"negado","<b>Dinheiro</b> insuficiente, entre em contato com o seu banco.",5000)
					end
				end
			actived[user_id] = nil
		end
	end
	return false
end

function src.removeDrive()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		SetPlayerRoutingBucket(source,0)
	end
end

function src.checkEstoqueVehicle(vehicle)
	local source = source
	local user_id = vRP.getUserId(source)
    local SQL = vRP.query("warn/select2", {vehicle = vehicle })
	if SQL[1].estoque > 0 then
		return true
    else
        vRP.giveMoney(user_id, Config.Valor_TesteDrive)
        return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if actived[user_id] then
		actived[user_id] = nil
	end

	if plateVehs[user_id] then
		plateVehs[user_id] = nil
	end
end)