local pedlist = {
	{ ['x'] = -1045.05, ['y'] = 4917.87, ['z'] = 212.54, ['h'] = 269.09494018555, ['hash'] = 0x709220C7, ['hash2'] = "u_m_m_prolsec_01" }, -- np7
	{ ['x'] = -1114.4, ['y'] = 4904.5, ['z'] = 218.6, ['h'] = 267.82348632813, ['hash'] = 0x5AA42C21, ['hash2'] = "g_f_y_vagos_01" }, -- np9
	{ ['x'] = -1145.31, ['y'] = 4940.38, ['z'] = 222.27, ['h'] = 145.462890625, ['hash'] = 0x0F9513F1, ['hash2'] = "cs_guadalope" }, -- np10
	{ ['x'] = -1097.48, ['y'] = 4892.96, ['z'] = 216.07, ['h'] = 337.37274169922, ['hash'] = 0x681BD012, ['hash2'] = "a_m_m_og_boss_01" }, -- np11
	{ ['x'] = 2035.45, ['y'] = 4748.33, ['z'] = 41.24, ['h'] = 21.085531234741, ['hash'] = 0x87CA80AE, ['hash2'] = "ig_johnnyklebitz" }, -- np12
	{ ['x'] = -30.62, ['y'] = -1093.97, ['z'] = 26.43, ['h'] = 32.830253601074, ['hash'] = 0x858C94B8, ['hash2'] = "csb_ramp_hic" } -- np13
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--  Text NPC 7
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000 -- -1756.97, ['y'] = -1122.42, ['z'] = 13.02
		local x2,y2,z2 = -1045.05,4917.87,212.54
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),-1045.05,4917.87,212.54,true) 
		local tempo = 15*1000
		if distance <= 5.0 then
			sleep = 5
			--DrawText3D(x2,y2,z2 + 1.25,"Ei ei, é você.. \n está precisando de armas? fiquei sabendo que proximo ao porto você arruma")
			DrawText3D(x2,y2,z2 + 1.0,"O que foi em? \n não é porque tenho só um olho que não posso vigiar...")
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--  Text NPC 12
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000 -- -1756.97, ['y'] = -1122.42, ['z'] = 13.02
		local x2,y2,z2 = 2035.5,4748.18,41.26
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),2035.5,4748.18,41.26,true) 
		local tempo = 15*1000
		if distance <= 2.0 then
			sleep = 5
			--DrawText3D(x2,y2,z2 + 1.25,"Ei ei, é você.. \n está precisando de armas? fiquei sabendo que proximo ao porto você arruma")
			DrawText3D(x2,y2,z2 + 1.0,"Só não vai perder a cabeça eih!")
		end
		Citizen.Wait(sleep)
	end
end)
--[ FUNCTIONS ]----------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.50, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 0
    DrawRect(_x,_y+0.0125, 0.010+ factor, 0.03, 41, 11, 41, 68)
end