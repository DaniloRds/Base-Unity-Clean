local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
spawnselector = {}
Tunnel.bindInterface("spawnselector",spawnselector)

function spawnselector.ultimaposicao()
    local source = source
    local user_id = vRP.getUserId(source)
    local data = vRP.getUserDataTable(user_id)
    --print(data,data.position)
    if data and data.position then 
        return data.position
    end
    return false
end