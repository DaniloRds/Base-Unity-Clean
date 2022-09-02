local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nation_concessionaria")

vGARAGE = Tunnel.getInterface("vRP_garages")

func = {}
Tunnel.bindInterface("nation_concessionaria", func)

local conceVehicles = {}
local userVehicles = {}

function func.getConfig()
    return config
end

RegisterServerEvent('nationConce:getConfig')
AddEventHandler('nationConce:getConfig', function()
    local source = source
    TriggerClientEvent("nationConce:setConfig", source, config)
end)

vRP._prepare("getVehicles", "SELECT * FROM nation_concessionaria")

function getDbVehicles()
    conceVehicles = {}
    local vehicles = vRP.query("nation_conce/getConceVehicles") or {}
    for k,v in ipairs(vehicles) do
        local vehInfo = config.getVehicleInfo(v.vehicle)
        if vehInfo then
            conceVehicles[#conceVehicles+1] = { 
                vehicle = v.vehicle, price = vehInfo.price, modelo = vehInfo.modelo, 
                capacidade = vehInfo.capacidade, name = vehInfo.name, estoque = v.estoque
            }
            if vehInfo.class then
                conceVehicles[#conceVehicles].class = vehInfo.class
            end
        end
    end
end

function checkRentedVehicles()
    vRP.execute("nation_conce/deleteRentedVehicles", { data_alugado = os.date("%d/%m/%Y")})
    Wait(60 * 1000 * 60 * 6)
    checkRentedVehicles()
end

Citizen.CreateThread(function()
    if not config.customMYSQL then
        vRP._prepare("nation_conce/createDB",[[
            CREATE TABLE IF NOT EXISTS `nation_concessionaria` (
            `vehicle` TEXT,
            `estoque` INT(11) NOT NULL DEFAULT 0,
            PRIMARY KEY (`vehicle`(765))
            )
            COLLATE='utf8mb4_general_ci'
            ENGINE=InnoDB
            ;
            ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS alugado TINYINT(4) NOT NULL DEFAULT 0;
            ALTER TABLE vrp_user_vehicles ADD IF NOT EXISTS data_alugado TEXT;
        ]])
        vRP._prepare("nation_conce/isVehicleInConce","SELECT * FROM nation_concessionaria WHERE vehicle = @vehicle")

        vRP.prepare("nation_conce/addVehicle","INSERT IGNORE INTO nation_concessionaria(vehicle,estoque) VALUES(@vehicle,@estoque)")
        vRP.prepare("nation_conce/removeVehicle","DELETE FROM nation_concessionaria WHERE vehicle = @vehicle")

        vRP._prepare("nation_conce/addEstoque","UPDATE nation_concessionaria SET estoque = @estoque WHERE vehicle = @vehicle")
        vRP._prepare("nation_conce/removeEstoque","UPDATE nation_concessionaria SET estoque = @estoque WHERE vehicle = @vehicle")

        vRP._prepare("nation_conce/addCustomEstoque","UPDATE nation_concessionaria SET estoque = @estoque WHERE vehicle = @vehicle")
        vRP._prepare("nation_conce/removeCustomEstoque","UPDATE nation_concessionaria SET estoque = estoque - 1 WHERE vehicle = @vehicle")
    end
    vRP.execute("nation_conce/createDB")
    getDbVehicles()
    checkRentedVehicles()
end)

function getVehicleInfo(vehicle,list)
    for k,v in ipairs(list) do 
        if v.name == vehicle then
            return list[k]
        end
    end
    return false
end

function func.getVehInfo(veh)
    if veh then
        return config.getVehicleInfo(veh)
    end
end

function func.getConceVehicles()
    return conceVehicles
end

function func.getTopVehicles()
    local list = {}
    if config.topVehicles and type(config.topVehicles == "table") then
        for _,veh in ipairs(config.topVehicles) do 
            local vehInfo = getTopVehicleInfo(veh)
            if vehInfo then
                list[#list+1] = vehInfo
            end
        end
    end
    return list
end

function func.getDiscount(id)
    local source = source
    local user_id = id or vRP.getUserId(source)
    for _, i in pairs(config.descontos) do 
        if vRP.hasPermission(user_id,i.perm) then
            if i.porcentagem > 100 or i.porcentagem < 0 then
                return 0
            end
            return i.porcentagem
        end
    end
    return 0
end

function getTopVehicleInfo(vehicle)
    if vehicle and conceVehicles then
        for k,v in ipairs(conceVehicles) do 
            if (v.name == vehicle) then
                return conceVehicles[k]
            end
        end 
    end
    return false
end

function getVehicleEstoque(vehicle)
    if vehicle then
        for _,veh in ipairs(conceVehicles) do 
            if veh.vehicle == vehicle then
                return veh.estoque
            end
        end
    end
    return 0
end

function getVehiclePrice(vehicle)
    if vehicle then
        for _,veh in ipairs(conceVehicles) do 
            if veh.vehicle == vehicle then
                return veh.price
            end
        end
    end
    return 0
end

function func.buyVehicle(vehicle,color)
    local source = source
    local user_id = vRP.getUserId(source)
    local estoque = getVehicleEstoque(vehicle)
    if estoque <= 0 then
        return false, "veículo fora de estoque"
    elseif hasVehicle(user_id,vehicle) then
        return false, "veículo já possuído"
    elseif not  func.checkVagasGaragem(user_id,0) then
        return false, "Sem vagas na garagem."
    end
    local desconto = func.getDiscount(user_id) / 100
    local price = getVehiclePrice(vehicle)
    price = parseInt(price - (price * desconto))
    local mods = fclient.getVehicleMods(source,vehicle)
    local state, message = config.tryBuyVehicle(source,user_id,vehicle,color,price,mods)
    if state then
        removeEstoque(vehicle)
        local vehInfo = config.getVehicleInfo(vehicle)
        if vehInfo then
            addUserVehicle(user_id,vehInfo)
        end
    end
    return state, message
end

function func.sellVehicle(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local state, message = false, "erro inesperado"
    local vehInfo = config.getVehicleInfo(vehicle)
    if hasVehicle(user_id,vehicle) and vehInfo then
        local price = vehInfo.price * (config.porcentagem_venda / 100)
        state, message = config.trySellVehicle(source,user_id,vehicle,price)
        if state then
            removeUserVehicle(user_id,vehicle)
            addEstoque(vehicle)
        end
    end
    return state, message
end

function hasVehicle(user_id,vehicle)
    if user_id and vehicle and userVehicles[user_id] then
        for _,veh in ipairs(userVehicles[user_id]) do 
            if veh.vehicle == vehicle then
                return true
            end
        end
    end
    return false
end

function addUserVehicle(user_id,vehInfo)
    if user_id and userVehicles[user_id] then
        local veh = { 
            vehicle = vehInfo.name, price = vehInfo.price * (config.porcentagem_venda / 100),
            modelo = vehInfo.modelo, capacidade = vehInfo.capacidade,
        }
        table.insert(userVehicles[user_id], veh)
    end
end

function removeUserVehicle(user_id,vehicle)
    if user_id and vehicle and userVehicles[user_id] then
        for i,veh in ipairs(userVehicles[user_id]) do
            if veh.vehicle == vehicle then
                table.remove(userVehicles[user_id], i)
                return
            end
        end
    end
end

function removeEstoque(vehicle,qtd)
    if vehicle then
        local qtd = qtd or 1
        for i,veh in ipairs(conceVehicles) do 
            if vehicle == veh.vehicle then
                conceVehicles[i].estoque = conceVehicles[i].estoque - qtd
                qtd = conceVehicles[i].estoque
                if conceVehicles[i].estoque <= 0 then
                    table.remove(conceVehicles, i)
                    qtd = 0
                end
                Citizen.CreateThread(function()
                    vRP.execute("nation_conce/removeEstoque", { vehicle = vehicle, estoque = qtd })
                end)
                return true
            end
        end
    end
    return false
end

function addEstoque(vehicle,qtd)
    if vehicle then
        local qtd = qtd or 1
        for i,veh in ipairs(conceVehicles) do 
            if vehicle == veh.vehicle then
                conceVehicles[i].estoque = conceVehicles[i].estoque + qtd
                qtd = conceVehicles[i].estoque
                Citizen.CreateThread(function()
                    vRP.execute("nation_conce/addEstoque", { vehicle = vehicle, estoque = qtd })
                end)
                return true
            end
        end
        local vehInfo = config.getVehicleInfo(vehicle)
        if vehInfo then
            conceVehicles[#conceVehicles+1] = { 
                vehicle = vehicle, price = vehInfo.price, modelo = vehInfo.modelo, 
                capacidade = vehInfo.capacidade, name = vehInfo.name, estoque = qtd
            }
            Citizen.CreateThread(function()
                local isVehicleInConce = #vRP.query("nation_conce/isVehicleInConce",{ vehicle = vehicle }) > 0
                if isVehicleInConce then
                    vRP.execute("nation_conce/addEstoque", { vehicle = vehicle, estoque = qtd })
                else
                    vRP.execute("nation_conce/addVehicle", { vehicle = vehicle, estoque = qtd })
                end
            end)
            return true
        end
    end
    return false
end

function func.getMyVehicles(force)
    local source = source
    local user_id = vRP.getUserId(source)
    local myVehicles = {}
    if force or not userVehicles[user_id] then
        local data = vRP.query("nation_conce/getMyVehicles", {user_id = user_id})
        for _,veh in ipairs(data) do 
        
            local vehInfo = config.getVehicleInfo(veh.vehicle)
            if vehInfo then
                myVehicles[#myVehicles+1] = { 
                    vehicle = vehInfo.name, price = vehInfo.price * (config.porcentagem_venda / 100),
                    modelo = vehInfo.modelo, capacidade = vehInfo.capacidade, 
                }
            end
        end
    else
        return userVehicles[user_id]
    end
    userVehicles[user_id] = myVehicles
    return myVehicles
end

function func.testDrive(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local state, message, vehInfo = false, "erro inesperado", {}
    vehInfo = config.getVehicleInfo(vehicle)
    if vehInfo then
        state, message = config.tryTestDrive(source,user_id,vehInfo)
    end
    return state, message
end

function func.payTest(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local state, message, vehInfo, price = false, "erro inesperado", {}, 0
    vehInfo = config.getVehicleInfo(vehicle)
    if vehInfo then
        state, message, price = config.payTest(source,user_id,vehInfo)
    end
    return state, message, price
end

function func.rentVehicle(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local state, message, vehInfo = false, "erro inesperado", {}
    local estoque = getVehicleEstoque(vehicle)
    if estoque <= 0 then
        return false, "veículo fora de estoque"
    elseif hasVehicle(user_id,vehicle) then
        return false, "veículo já possuído"
    end
    vehInfo = config.getVehicleInfo(vehicle)
    if vehInfo then
        state, message = config.tryRentVehicle(source,user_id,vehInfo)
    end
    return state, message
end

function func.payRent(vehicle)
    local source = source
    local user_id = vRP.getUserId(source)
    local state, message, vehInfo = false, "erro inesperado", {}
    vehInfo = config.getVehicleInfo(vehicle)
    if vehInfo then
        state, message = config.tryPayRent(source,user_id,vehInfo)
    end
    return state, message
end

function func.hasPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if config.openconce_permission then
        return vRP.hasPermission(user_id, config.openconce_permission)
    end
    return true
end

function func.chargeBack(price)
    local source = source
    local user_id = vRP.getUserId(source)
    if config.chargeBack then
        config.chargeBack(source,user_id,parseInt(price))
    end
end

function showNotify(source,mode,message,time)
    local time = time
    if not time then
        time = 3000
    end
    if config.notify then
        config.notify(source,mode,message,time)
    else
        TriggerClientEvent("Notify",source,mode,message,time) 
    end
end

local manages = {
    ["update"] = function(source) 
        getDbVehicles()
        showNotify(source,"sucesso","Concessionária atualizada com sucesso!") 
    end,
    ["add"] = function(source,vehicle,qtd)
        local qtd = parseInt(qtd)
        if qtd and qtd > 0 then
            local vehInfo = config.getVehicleInfo(vehicle)
            if vehInfo then
                if addEstoque(vehicle,qtd) then
                    showNotify(source,"sucesso","Adicionado(s) <b>"..qtd.." "..vehInfo.modelo.."</b> à concessionária!") 
                else
                    showNotify(source,"negado","Erro inesperado.")
                end
            else
                showNotify(source,"negado","Veículo não identificado.")
            end
        else
            showNotify(source, "negado", "Quantidade inválida.")
        end
    end,
    ["remove"] = function(source,vehicle,qtd)
        local qtd = parseInt(qtd)
        if qtd and qtd > 0 then
            local vehInfo = config.getVehicleInfo(vehicle)
            if vehInfo then
                if removeEstoque(vehicle,qtd) then
                    showNotify(source,"sucesso","Removido(s) <b>"..qtd.." "..vehInfo.modelo.."</b> da concessionária!") 
                else
                    showNotify(source,"negado","Erro inesperado.")
                end
            else
                showNotify(source,"negado","Veículo não identificado.")
            end
        else
            showNotify(source, "negado", "Quantidade inválida.")
        end
        
    end
}

function func.manageConce(mode,vehicle,qtd)
    local source = source
    local user_id = vRP.getUserId(source)
    if mode and vehicle and qtd and vRP.hasPermission(user_id,config.updateconce_permission) then
        if manages[mode] then
            manages[mode](source,vehicle,qtd)
        end
    end 
end

function func.checkVagasGaragem(user_id,index)
	local source = vRP.getUserSource(user_id)
	local maxvehs = vRP.query("creative/con_maxvehs",{ user_id = user_id })
	local maxgars = vRP.query("creative/get_users",{ user_id = user_id })
	
	local adicional;
	if vRP.hasPermission(user_id,"owner.permissao") then
		adicional = 20 
	elseif vRP.hasPermission(user_id,"admin.permissao") then
		adicional = 5
	elseif vRP.hasPermission(user_id,"mod.permissao") then
		adicional = 2
    else
        adicional = 0;
    end

	if vRP.hasPermission(user_id,"bronze.permissao") then
		adicional = adicional + 2
	elseif vRP.hasPermission(user_id,"prata.permissao") then
		adicional = adicional + 5
	elseif vRP.hasPermission(user_id,"ouro.permissao") then
		adicional = adicional + 999
	elseif vRP.hasPermission(user_id,"platina.permissao") then
		adicional = adicional + 999
    else
        adicional = adicional + 0;
    end

	if parseInt(maxvehs[1].qtd) < (parseInt(maxgars[1].garagem) + adicional) then
		return true
	else
		return false
	end
end

RegisterCommand('conce',function(source)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,config.updateconce_permission) then
        fclient.showAdminMenu(source)
    end
end)

function func.checkAuth()
    return true 
end