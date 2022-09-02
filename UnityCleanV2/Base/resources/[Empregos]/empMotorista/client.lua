local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local Tools = module("vrp", "lib/Tools")
vRP = Proxy.getInterface("vRP")

src = {}
Tunnel.bindInterface("empMotorista",src)
vSERVER = Tunnel.getInterface("empMotorista")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local dinheiro_ganho = 0

Citizen.CreateThread(function()
	while true do
		local msec = 400
		if not emservico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				if distance <= 3 then
					msec = 3
	
					DrawMarker(21, v.x,v.y,v.z-0.7,0,0,0,0,0,0,0.2,0.2,0.3,255, 255, 255,255,0,0,0,1)
					DrawMarker(27, v.x,v.y,v.z-1,0,0,0,0,0,0,0.4,0.4,0.5,66, 245, 84,255,0,0,0,1)
					drawText2D("PRESSIONE ~y~E~w~ PARA ACESSAR O ~y~EMPREGO~w~",1,0.5,0.93,0.55,255,255,255,180)
					if distance <= 1.2 then
						msec = 3
						if IsControlJustPressed(0,38) then

							local rc,level,exp = vSERVER.CheckLevel()
							local money = vSERVER.return_dinheiro()
							SetNuiFocus(true,true)
							SendNUIMessage({ action = "showMenu", rc = rc, level = level, exp = exp, money = money })
							StartScreenEffect("MenuMGSelectionIn", 0, true)
							
						end
					end
				end
			end
		end
		Wait(msec)
	end
end)

RegisterNUICallback("Close",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	invOpen = false
end)

RegisterNUICallback("iniciartrampo",function(data,cb)
	for _,v in pairs(coordenadas) do

		SetNuiFocus(false,false)
		StopScreenEffect("MenuMGSelectionIn")

		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
		local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
		emservico = true

		destino = 1

		CriandoBlip(entregas,destino)
		TriggerEvent("Notify","sucesso","Você entrou em serviço.")

		local rc,level,exp = vSERVER.CheckLevel()

		cb({retorno = 'iniciou', rc = rc, level = level, exp = exp })
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if emservico then
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
				if distance <= 50 then
					DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
					if distance <= 4 then
						--drawTxt("PRESSIONE  ~b~E~w~  PARA CONTINUAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if GetPedInVehicleSeat(vehicle,-1) == ped then
							if IsControlJustPressed(0,38) then
								if  IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey(carro_emprego)) then
									if vSERVER.checkItem() then
										RemoveBlip(blip)

										local dinheiro_recebido = math.random(premios.Dinheiro_Minimo,premios.Dinheiro_Maximo)
										local exp_ganho = math.random(premios.ExP_Minimo,premios.ExP_Maximo)


										if destino == 54 then
											local dinheiro_total = vSERVER.pagar(dinheiro_recebido)
											vSERVER.GetEXP(exp_ganho)
											vSERVER.addRota()
											destino = 1
											dinheiro_ganho = dinheiro_ganho + dinheiro_total
										else
											local dinheiro_total = vSERVER.pagar(dinheiro_recebido)
											vSERVER.GetEXP(exp_ganho)
											destino = destino + 1
											dinheiro_ganho = dinheiro_ganho + dinheiro_total
										end

										local rc,level,exp = vSERVER.CheckLevel()
										CriandoBlip(entregas,destino)
										SendNUIMessage({ action = "atualizar", rc = rc, level = level, exp = exp, checkpoint = destino, dinheiro_ganho = dinheiro_ganho })
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)




-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if emservico then
			drawTxt('PRESSIONE ~b~F7 ~w~PARA SAIR DE TRABALHO',2,0.23,0.93,0.40,255,255,255,180)
			if IsControlJustPressed(0,168) then
				emservico = false
				RemoveBlip(blip)
				SetNuiFocus(false,false)
				SendNUIMessage({ action = "hideMenu" })
				StopScreenEffect("MenuMGSelectionIn")
				TriggerEvent("Notify","aviso","Você saiu de serviço.")
				TriggerEvent("Notify","aviso","Você recebeu um total de R$"..dinheiro_ganho.." !", 10000)
			end
		end
	end
end)





-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,8)
	SetBlipColour(blip,2)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Emprego Blip")
	EndTextCommandSetBlipName(blip)

end

function drawText2D(text,font,x,y,scale,r,g,b,a)    
    SetTextFont(font)    
    SetTextScale(scale,scale)    
    SetTextColour(r,g,b,a)    
    SetTextOutline()    
    SetTextCentre(1)    
    SetTextEntry('STRING')    
    AddTextComponentString(text)    
    DrawText(x,y)
end

function DrawText3D(x,y,z, text, r,g,b)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end