local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("shops",src)
local cfg = module("shops","config")

function src.openShop(shop)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
       -- print("teste")
        local playerCoords = GetEntityCoords(GetPlayerPed(source))
        local shopInfos = cfg.shops[shop]
        for k,v in pairs(shopInfos.locs) do
            local x,y,z = table.unpack(v)
            local distance = #(playerCoords.xy - vector3(x,y,z).xy)
            --if distance <= 1.5 then
               -- print("teste")
                TriggerClientEvent("mpr_shops:openShopCL", source, shopInfos,shop)
           -- end
        end
    end
end

function src.buyProduct(product)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        for k,v in pairs(cfg.shops) do
            for k2,v2 in pairs(v.products) do
                if v2.itens[product] then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v2.itens[product].itemname)*1 <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryPayment(user_id,v2.itens[product].price) then
							vRP.giveInventoryItem(user_id,v2.itens[product].itemname,1)
							TriggerClientEvent("Notify", source, "compras", "Você comprou "..v2.itens[product].name.." em "..k.." com sucesso!")
						else
							TriggerClientEvent("Notify", source, "negado", "Você não tem dinheiro o suficiente")
						end
					else
						TriggerClientEvent("Notify", source, "negado", "Sem espaço na mochila")
					end
                end
            end
        end
    end
end
