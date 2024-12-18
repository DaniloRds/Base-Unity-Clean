function getVehicleMods(veh)
	if IsEntityAVehicle(veh) then
		local custom = {}
		if DoesEntityExist(veh) then
			local colors = { }
			local toggles = { }
			local mods = {}
			local colours = table.pack(GetVehicleColours(veh))
			local extra_colors = table.pack(GetVehicleExtraColours(veh))

			custom.colour = {}
			custom.colour.primary = colours[1]
			custom.colour.secondary = colours[2]
			custom.colour.pearlescent = extra_colors[1]
			custom.colour.wheel = extra_colors[2]
			colors[1] = custom.colour.primary
			colors[2] = custom.colour.secondary
			colors[3] = custom.colour.pearlescent
			colors[4] = custom.colour.wheel

			custom.colour.smoke = table.pack(GetVehicleTyreSmokeColor(veh))

			custom.colour.custom = {}
			custom.colour.custom.primary = table.pack(GetVehicleCustomPrimaryColour(veh))
			custom.colour.custom.secondary = table.pack(GetVehicleCustomSecondaryColour(veh))

			return veh,custom
		end
	end
	return false,false
end

function setVehicleMods(veh,custom)
	if custom and veh then
		SetVehicleModKit(veh,0)
		if custom.colour then
			SetVehicleColours(veh,tonumber(custom.colour.primary),tonumber(custom.colour.secondary))
			SetVehicleExtraColours(veh,tonumber(custom.colour.pearlescent),tonumber(custom.colour.wheel))
			if custom.colour.smoke then
				SetVehicleTyreSmokeColor(veh,tonumber(custom.colour.smoke[1]),tonumber(custom.colour.smoke[2]),tonumber(custom.colour.smoke[3]))
			end
			if custom.colour.custom then
				if custom.colour.custom.primary then
					SetVehicleCustomPrimaryColour(veh,tonumber(custom.colour.custom.primary[1]),tonumber(custom.colour.custom.primary[2]),tonumber(custom.colour.custom.primary[3]))
				end
				if custom.colour.custom.secondary then
					SetVehicleCustomSecondaryColour(veh,tonumber(custom.colour.custom.secondary[1]),tonumber(custom.colour.custom.secondary[2]),tonumber(custom.colour.custom.secondary[3]))
				end
			end
		end
	end
end