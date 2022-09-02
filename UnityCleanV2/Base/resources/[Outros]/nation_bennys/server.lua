local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

API = {}
Tunnel.bindInterface("nation_bennys",API)

local using_bennys = {}

-- function API.checkPermission()
--     local source = source
--     return vRP.hasPermission(vRP.getUserId(source), "tunagem.permissao")
-- end
function API.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"tunagem.permissao") then
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Você não tem acesso a <b>TUNAGEM</b>",8000)
    end
end

function API.getSavedMods(vehicle_name, vehicle_plate)
    local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
    return json.decode(vRP.getSData("custom:u" .. vehicle_owner_id .. "veh_" .. tostring(vehicle_name)) or {}) or {}
end

function API.checkPayment(amount)
    if not tonumber(amount) then
        return false
    end

    local source = source
    local user_id = vRP.getUserId(source)
    if not vRP.tryFullPayment(user_id, tonumber(amount)) then
        TriggerClientEvent("Notify",source,"negado","Você não possui dinheiro suficiente.",7000)
        return false
    end
    TriggerClientEvent("Notify",source,"sucesso","Modificações aplicadas com <b>sucesso</b><br>Você pagou <b>$"..tonumber(amount).." dólares<b>.",7000)
    return true
end

function API.repairVehicle(vehicle, damage)

    TriggerEvent("tryreparar", vehicle)
    return true
end

function API.removeVehicle(vehicle)
    using_bennys[vehicle] = nil
    return true
end

function API.checkVehicle(vehicle)
    if using_bennys[vehicle] then
        return false
    end
    using_bennys[vehicle] = true
    return true
end
function API.saveVehicle(vehicle_name, vehicle_plate, vehicle_mods)
    local vehicle_owner_id = vRP.getUserByRegistration(vehicle_plate)
    vRP.setSData("custom:u"..parseInt(vehicle_owner_id).."veh_"..vehicle_name,json.encode(vehicle_mods))
    return true
end


RegisterServerEvent("nation:syncApplyMods")
AddEventHandler("nation:syncApplyMods",function(vehicle_tuning,vehicle)
    TriggerClientEvent("nation:applymods_sync",-1,vehicle_tuning,vehicle)
end)

-- [[!-!]] vcux3MfIy8qDzcrMz8rKycbPzsvKzcnIyM7M [[!-!]] --