------------------SCRIPT CORRIGIDO POR ANDERSON FABRIS
------------------SUPORTE PELO DISCORD: AndiGame#5670
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_skinshop")
vRPloja = Tunnel.getInterface("vrp_skinshop")

RegisterServerEvent("LojaDeRoupas:Comprar")
AddEventHandler("LojaDeRoupas:Comprar", function(preco)
    local user_id = vRP.getUserId(source)
    if preco then
        if vRP.tryFullPayment(user_id, preco) then
            TriggerClientEvent("Notify",source,"importante","Você pagou R$"..preco.." pelas roupas.",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, true)
        else
            TriggerClientEvent("Notify",source,"importante","Você não tem dinheiro suficiente para pagar.",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, false)
        end
    end
end)

