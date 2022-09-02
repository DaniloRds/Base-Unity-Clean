local recoils = {
	[453432689] = 0.4,
	[3219281620] = 0.4,
	[1593441988] = 0.3,
	[584646201] = 0.4,
	[2578377531] = 0.6,
	[324215364] = 0.5,
	[736523883] = 0.2,
	[2024373456] = 0.1,
	[4024951519] = 0.6,
	[3220176749] = 0.8,
	[961495388] = 0.2,
	[2210333304] = 0.8,
	[4208062921] = 0.1,
	[2937143193] = 0.1,
	[2634544996] = 0.1,
	[2144741730] = 0.1,
	[3686625920] = 0.1,
	[487013001] = 0.4,
	[1432025498] = 0.35,
	[2017895192] = 0.7,
	[3800352039] = 0.4,
	[2640438543] = 0.2,
	[911657153] = 0.9,
	[177293209] = 0.6,
	[856002082] = 1.2,
	[2726580491] = 1.0,
	[1305664598] = 1.0,
	[2982836145] = 0.0,
	[1752584910] = 0.0,
	[1119849093] = 0.01,
	[3218215474] = 0.4,
	[1627465347] = 0.6,
	[3231910285] = 0.2,
	[-1768145561] = 0.15,
	[3523564046] = 0.5,
	[2132975508] = 0.2,
	[-2066285827] = 0.15,
	[137902532] = 0.4,
	[2828843422] = 0.7,
	[984333226] = 0.2,
	[3342088282] = 0.3,
	[1785463520] = 0.25,
	[1672152130] = 0,
	[1198879012] = 0.9,
	[171789620] = 0.1,
	[3696079510] = 0.9,
	[1834241177] = 2.4,
	[3675956304] = 0.3,
	[3249783761] = 0.6,
	[-879347409] = 0.6,
	[4019527611] = 0.7,
	[1649403952] = 0.3,
	[317205821] = 0.2,
	[125959754] = 0.5,
	[3173288789] = 0.1
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(),wep)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				repeat
					Citizen.Wait(10)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1,0.2)
					end
					tv = tv + 0.1
				until tv >= recoils[wep]
			end
		end

		if IsPedArmed(PlayerPedId(),6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
		end
	end
end)