local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("shops")
local cfg = module("shops","config")

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(cfg.shops) do
            for k2,v2 in pairs(v.locs) do
                local ped = PlayerPedId()
                local x,y,z = table.unpack(v2)
                local distance = GetDistanceBetweenCoords(x,y,z,GetEntityCoords(ped),true)
                if distance <= 6 then
                    sleep = 1
                    if v.draw.drawmarker.enabled then
                        DrawMarker(v.draw.drawmarker.id,x,y,z-0.4,0,0,0,0.0,0,0,0.4,0.4,0.4,255,255,255,255,0,0,0,1)
                    end
                    if distance <= 1.5 then
                        DrawMarker(v.draw.drawmarker.id,x,y,z-0.4,0,0,0,0.0,0,0,0.4,0.4,0.4,0,255,0,255,0,0,0,1)
                        -- if v.draw.drawtext3d.enabled then
                            -- Draw3DText(x,y,z,v.draw.drawtext3d.text,0.4)
                            if IsControlJustPressed(0,38) then
                                vSERVER.openShop(k)
                            end  
                        -- end
                    end
                end
                
            end
        end
        Citizen.Wait(sleep)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(cfg.shops) do
        for k2,v2 in pairs(v.locs) do
            local x,y,z = table.unpack(v2)
            TriggerEvent("hoverfy:insertTable",{{ x,y,z, 1.5, "E","Loja","Pressione para abrir/fechar o menu" }})
        end
    end
end)


function Draw3DText(x, y, z, text)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
	if onScreen then
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextDropShadow(0, 0, 0, 55)
		SetTextEdge(0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
        local factor = (string.len(text)) / 350
        DrawRect(_x,_y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 68)
	end
end

RegisterNetEvent("mpr_shops:openShopCL")
AddEventHandler("mpr_shops:openShopCL",function(shop,shopName)
    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open", shop = shop, imagesIP = cfg.imagesIp, shopName = shopName })
end)

RegisterNUICallback("close_shop", function(data,cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("buyProduct", function(data,cb)
    vSERVER.buyProduct(data.product)
    cb('ok')
end)