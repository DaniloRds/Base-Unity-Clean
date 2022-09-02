local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
fclient = Tunnel.getInterface("nav_contrabandista")
func = {}
Tunnel.bindInterface("nav_contrabandista", func)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "algemas", quantidade = 1, compra = 2000 },
	{ item = "c4", quantidade = 1, compra = 2000 },
	{ item = "capuz", quantidade = 1, compra = 2000 },
	{ item = "furadeira", quantidade = 1, compra = 2000 },
    { item = "lockpick", quantidade = 1, compra = 2000 },
	{ item = "placa", quantidade = 1, compra = 2000 },
	{ item = "pendrive", quantidade = 1, compra = 2000 },
	{ item = "keycard", quantidade = 1, compra = 2000 },
    { item = "serra", quantidade = 1, compra = 2000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ COMPRAR ]----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("contrabandista-comprar")
AddEventHandler("contrabandista-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)

function func.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"contrabando.permissao") then
        return true
    else
        TriggerClientEvent("Notify",source,"negado","Acho que você está no lugar errado...",8000)
    end
end