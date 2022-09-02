-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_chest",src)
vSERVER = Tunnel.getInterface("vrp_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestTimer = 0
local chestOpen = ""
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("chestClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	vSERVER.chestClose(tostring(chestOpen))
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	vSERVER.takeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	vSERVER.storeItem(tostring(chestOpen),data.item,data.amount)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("Creative:UpdateChest")
AddEventHandler("Creative:UpdateChest",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestChest",function(data,cb)
	local inventario,inventario2,peso,maxpeso,peso2,maxpeso2 = vSERVER.openChest(tostring(chestOpen))
	if inventario then
		cb({ inventario = inventario, inventario2 = inventario2, peso = peso, maxpeso = maxpeso, peso2 = peso2, maxpeso2 = maxpeso2 })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCALIDADE DOS BAÚS
-----------------------------------------------------------------------------------------------------------------------------------------
local chest = {
    { "Policia",472.16, -1006.73, 34.22 },
	{ "Advogados",-129.92, -633.67, 168.83 },
	{ "Paramedico",310.37,-599.71,43.3 }, 
	{ "Ballas",1910.74, 6448.62, 79.84 },
	{ "Vagos",1853.7, 3467.17, 45.96 },
	{ "Grove",1600.9, -112.87, 219.07 },
	{ "Blood",-1061.8854980469,-1663.0401611328,4.5639290809631 },
	{ "Serpentes",3568.04,3699.59,28.13 },
	{ "Motoclub",977.22912597656,-104.02346038818,74.845184326172 },
	{ "Yakuza",-898.67,-1444.63,7.52 }, 
	{ "Tequilala",-575.94, 291.36, 79.18 },
	{ "Mafia",-2670.1950683594,1335.7496337891,140.88139343262 },
	{ "Bloods",2120.36, 4782.57, 40.98 },
	{ "Vanilla",106.61, -1299.44, 28.77 },
	{ "Bennys",-344.15, -157.58, 44.59 },
	{ "PoliciaSOG",-1078.2,-815.84,11.04 },
	{ "Bratva",-1870.26,2059.2,135.44 },
	{ "bahamas",-596.53, 50.4, 93.64 },
	{ "Bennys2",-348.76, -170.73, 39.02	},
	{ "Elements",98.88, 6621.04, 32.44},
	{ "BurgerShot",-631.84, 227.99, 81.89},
	{ "Piloto",-1563.44, -570.18, 108.53 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		if chestTimer > 0 then
			chestTimer = chestTimer - 3
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("chest",function(source,args)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	for k,v in pairs(chest) do
		local distance = Vdist(x,y,z,v[2],v[3],v[4])
		if distance <= 2.0 and chestTimer <= 0 then
			chestTimer = 3
			if vSERVER.checkIntPermissions(v[1]) then
				TriggerEvent('Notify','sucesso','Abrindo baú...')
				SetNuiFocus(true,true)
				SendNUIMessage({ action = "showMenu" })
				chestOpen = v[1]
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        timeDistance = 1000
        for k,v in pairs(chest) do
            distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),v[2],v[3],v[4])
            if distance < 5 then
                timeDistance = 5
                draw3DText(v[2],v[3],v[4],"~b~[Bau]\n~w~Pressione ~b~[E]~w~ para acessar")
                if distance < 2 then
                    if IsControlJustPressed(0,38) and chestTimer < 1 then
                        chestTimer = 3
                        if vSERVER.checkIntPermissions(v[1]) then
                            SetNuiFocus(true,true)
                            SendNUIMessage({ action = "showMenu" })
                            chestOpen = tostring(v[1])
                        end
                    end
                end
            end
        end
        Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function draw3DText(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
  end