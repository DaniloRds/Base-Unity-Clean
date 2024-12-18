local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

kPT = {}
Tunnel.bindInterface("vrp_barbershop",kPT)
Proxy.addInterface("vrp_barbershop",kPT)
kPTclient = Tunnel.getInterface("vrp_barbershop")

local startado = ""
local ladraowebhook = ""
pegou = false

function SendWebhookMessage(webhook,message)
    if webhook ~= nil and webhook ~= "" then
        PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
    end
end

RegisterCommand('pegar',function(source)
    kPT.setPedServer(source)
end)

function kPT.Save()
    local source = source    
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    local currentCharacterMode = kPTclient.getCharacter(player)
    vRP.setUData(user_id,"currentCharacterMode", json.encode(currentCharacterMode))
end

function kPT.openBarber()
local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    kPT.setPedServer(source)
    kPTclient.open(source)
    pararloop = false
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
    pararloop = true
    while pararloop do
        SetTimeout(5000, function() -- tunnel/proxy delay
            kPT.setPedServer(source)
        end)
        Wait(500)
    end
end)

RegisterServerEvent('vrp_barber:setPedClient')
AddEventHandler('vrp_barber:setPedClient',function()
    local source = source
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            kPTclient.setCharacter(player,custom)
        end
    end
end)

RegisterServerEvent('vrp_barber:setPedServer')
AddEventHandler('vrp_barber:setPedServer',function(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            kPTclient.setCharacter(player,custom)
        end
    end
end)

function kPT.setPedServer(source)
    local user_id = vRP.getUserId(source)
    local player = vRP.getUserSource(user_id)
    if player then
        local value = vRP.getUData(user_id,"currentCharacterMode")
        if value ~= "" then
            local custom = json.decode(value) or {}
            kPTclient.setCharacter(player,custom)
        end
    end
end

function kPT.checkAuth()
    return auth
end