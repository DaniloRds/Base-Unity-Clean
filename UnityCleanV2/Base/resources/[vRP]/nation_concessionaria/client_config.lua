-- RETORNA AS MODIFICACOES DO VEÍCULO
getVehicleMods = function(veh)
	local myveh = {}
	local colors = {
		["cromado"] = {120},
		["metálico"] = {
			0, 147, 1, 11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 27, 28, 29, 150, 30, 31, 32, 33, 34, 
			143, 35, 135, 137, 136, 36, 38, 138, 99, 90, 88, 89, 91, 49, 50, 51, 52, 53, 54, 
			92, 141, 61, 62, 63, 64, 65, 66, 67, 68, 69, 73, 70, 74, 96, 101, 95, 94, 97,
			103, 104, 98, 100, 102, 99, 105, 106, 71, 72, 142, 145, 107, 111, 112
		},
		["fosco"] = {12,13,14,131,83,82,84,149,148,39,40,41,42,55,128,151,155,152,153,154},
		["metal"] = { 117,118,119,158,159 }
	}
	myveh.vehicle = veh
	myveh.model = GetDisplayNameFromVehicleModel(GetEntityModel(veh)):lower()
	myveh.color =  table.pack(GetVehicleColours(veh))
	myveh.customPcolor = table.pack(GetVehicleCustomPrimaryColour(veh))
	myveh.customScolor = table.pack(GetVehicleCustomSecondaryColour(veh))
	myveh.extracolor = table.pack(GetVehicleExtraColours(veh))
	myveh.neon = true
	for i = 0, 3 do 
		if not IsVehicleNeonLightEnabled(veh,i) then 
			myveh.neon = false
			break 
		end 
	end 
	myveh.neoncolor = table.pack(GetVehicleNeonLightsColour(veh))
	myveh.xenoncolor = GetVehicleHeadlightsColour(veh)
	myveh.smokecolor = table.pack(GetVehicleTyreSmokeColor(veh))
	myveh.plateindex = GetVehicleNumberPlateTextIndex(veh)
	myveh.pcolortype = false
	myveh.scolortype = false
	for k,v in pairs(colors) do
		for i,j in pairs(v) do
			if myveh.pcolortype and myveh.scolortype then
				break
			end
			if j == myveh.color[1] then
				myveh.pcolortype = k
			end
			if j == myveh.color[2] then
				myveh.scolortype = k
			end
		end
	end
	myveh.mods = {}
	for i = 0, 48 do
		myveh.mods[i] = {mod = nil}
	end
	for i,t in pairs(myveh.mods) do 
		if i == 22 or i == 18 then
			if IsToggleModOn(veh,i) then
				t.mod = 1
			else
				t.mod = 0
			end
		elseif i == 23 or i == 24 then
			t.mod = GetVehicleMod(veh,i)
			t.variation = GetVehicleModVariation(veh, i)
		else
			t.mod = GetVehicleMod(veh,i)
		end
	end
	if GetVehicleWindowTint(veh) == -1 or GetVehicleWindowTint(veh) == 0 then
		myveh.windowtint = false
	else
		myveh.windowtint = GetVehicleWindowTint(veh)
	end
	if myveh.xenoncolor > 12 or myveh.xenoncolor < -1 then
		myveh.xenoncolor = -1
	end
	myveh.wheeltype = GetVehicleWheelType(veh)
	myveh.bulletProofTyres = GetVehicleTyresCanBurst(veh)
	myveh.damage = (1000 - GetVehicleBodyHealth(vehicle))/100
	return myveh
end


-- MARKER DA CONCE
conceMarker = function(coords)
	DrawMarker(36,coords,0,0,0,0,0,0,1.0,1.0,1.0,153, 102, 255,155,1,1,1,1)
	DrawMarker(27,coords.x,coords.y,coords.z-0.97,0,0,0,0,0,0,1.0,1.0,0.5,102, 0, 255,155,0,0,0,1)
end


-- TEXTO EXIBIDO AO CHEGAR PERTO DO MARKER
conceText = function()
	drawTxt("PRESSIONE  ~p~E~w~  PARA ACESSAR A ~p~CONCESSIONÁRIA",4,0.5,0.93,0.50,255,255,255,180)
end


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