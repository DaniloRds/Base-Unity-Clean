local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP") 
vRPclient = Tunnel.getInterface("vRP") 

dPN = {}
Tunnel.bindInterface("vrp_tattoo",dPN)
Proxy.addInterface("vrp_tattoo",dPN)
dPNclient = Tunnel.getInterface("vrp_tattoo")


local dentrodatattoo = true
local foratatoo = true
local pegouSpawn = {}
function SendWebhookMessage(webhook, message)
    if webhook ~= nil and webhook ~=    "   " then
            PerformHttpRequest(webhook, function(err, text, headers)
        end, 'POST', json.encode({
                content = message
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn)
        pegouSpawn[user_id] = true
        while pegouSpawn[user_id] do
        SetTimeout(5000, function()
            setTattoosPlayers(source)
        end)
        Wait(6000)
    end
end)

function dPN.setFalse()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
            pegouSpawn[user_id] = false
    end
end

function dPN.getAtuaistatto()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
            local value = vRP.getUData(parseInt(user_id),"vRP:tattoos")
            local custom = json.decode(value) or {}
            if custom then
            dPNclient.mandarAtualTatu(source, custom)
        end
    end
end

function setTattoosPlayers(source)
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(user_id,"vRP:tattoos")
    local custom = json.decode(value) or {}
    if custom and json.encode(value) ~= "1" then
        dPNclient.mandarAtualTatu(source, custom)
    end
end

function dPN.verifyPayment(preco)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local oqreotnrou = pagamento(source, user_id, preco)
        if oqreotnrou then
            return oqreotnrou
        else
            return false
        end
    end
end

-- RegisterCommand('limpartatoo', function(source)
--     local user_id = vRP.getUserId(source)
--     if user_id then
--         vRP.setUData(user_id,"vRP:tattoos","")
--     end
-- end)

function dPN.setTatoo(tatoos)
    local source = source
    local user_id = vRP.getUserId(source)
    local tableTatoos = {}
    if tatoos and user_id then
        vRP.setUData(user_id,"vRP:tattoos", json.encode(tatoos))
    end
end

RegisterCommand('forcetattooupdate', function(source)
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),    "vRP:tattoos   ")
    local custom = json.decode(value) or {}
    if value then
        dPNclient.mandarAtualTatu(source, custom)
        dPNclient.setTatoos(source)
    end
end)

RegisterServerEvent('vrp_tattoo:setPedClient')
AddEventHandler('vrp_tattoo:setPedClient', function()
    local source = source
    local user_id = vRP.getUserId(source)
    local value = vRP.getUData(parseInt(user_id),"vRP:tattoos")
    local custom = json.decode(value) or {}
    if custom then
        dPNclient.mandarAtualTatu(source, custom)
    end
end)

RegisterServerEvent('vrp_tattoo:setPedServer')
AddEventHandler('vrp_tattoo:setPedServer', function(source)
    if source then
        local user_id = vRP.getUserId(source)
        if user_id then
            local value = vRP.getUData(user_id,    "vRP:tattoos   ")
            local custom = json.decode(value) or {}
            if custom then
                dPNclient.mandarAtualTatu(source, custom)
            end
        end
    end
end)
