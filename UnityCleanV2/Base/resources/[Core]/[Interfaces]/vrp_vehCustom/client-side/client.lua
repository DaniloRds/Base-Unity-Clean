-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("vrp_vehCustom")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local activeBennys = false
local originalCategory = nil
local originalMod = nil
local originalPrimaryColour = nil
local originalSecondaryColour = nil
local originalPearlescentColour = nil
local originalWheelColour = nil
local originalDashColour = nil
local originalInterColour = nil
local originalWindowTint = nil
local originalWheelCategory = nil
local originalWheel = nil
local originalWheelType = nil
local originalCustomWheels = nil
local originalNeonLightState = nil
local originalNeonLightSide = nil
local originalNeonColourR = nil
local originalNeonColourG = nil
local originalNeonColourB = nil
local originalXenonColour = nil
local originalPoliceLivery = nil
local originalPlateIndex = nil
local attemptingPurchase = false
local isPurchaseSuccessful = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local bennysLocations = {
	["mechanic01"] = {
		pos = vector3(450.4,-975.81,25.7),
		heading = 90.00
	},
	["mechanic02"] = {
		pos = vector3(435.28,-975.86,25.7),
		heading = 90.00
	},
	["mechanic03"] = {
		pos = vector3(333.34,-574.76,28.80),
		heading = 340.00
	},
	["mechanic04"] = {
		pos = vector3(-339.15,-136.66,39.01),
		heading = 87.88
	},
	["mechanic05"] = {
		pos = vector3(-1155.12,-2005.7,13.18),
		heading = 334.49,
		permission = "Owner"
	},
	["mechanic06"] = {
		pos = vector3(1174.98,2640.4,37.74),
		heading = 1.0
	},
	["mechanic07"] = {
		pos = vector3(1182.14,2639.94,37.74),
		heading = 1.0
	},
	["mechanic08"] = {
		pos = vector3(110.63,6626.54,31.78),
		heading = 224.94
	},
	["mechanic09"] = {
		pos = vector3(105.26,6621.59,31.78),
		heading = 223.94
	},
	["mechanic10"] = {
		pos = vector3(731.7,-1088.84,21.84),
		heading = 87.88
	},
	["mechanic11"] = {
		pos = vector3(-1178.37,-2845.97,13.93),
		heading = 331.66
	},
	["mechanic12"] = {
		pos = vector3(-222.63,-1330.03,30.57),
		heading = 272.13
	},
	["mechanic13"] = {
		pos = vector3(-32.76,-1065.91,27.77),
		heading = 339.5
	},
	["mechanic14"] = {
		pos = vector3(135.97,-3030.56,6.71),
		heading = 178.59,
		permission = "Mechanic"
	},
	["mechanic15"] = {
		pos = vector3(144.91,-3030.35,6.71),
		heading = 0.0,
		permission = "Mechanic"
	},
	["mechanic16"] = {
		pos = vector3(-1423.62,-450.23,35.28),
		heading = 32.00
	},
	["mechanic17"] = {
		pos = vector3(-1417.29,-446.25,35.28),
		heading = 32.00
	},
	["mechanic18"] = {
		pos = vector3(936.6,-970.85,38.91),
		heading = 273.00
	},
	["thelost01"] = {
		pos = vector3(959.41,-113.15,73.73),
		permission = "TheLost",
		heading = 223.00,
		bikes = true
	},
	["thelost02"] = {
		pos = vector3(964.82,-108.0,73.73),
		permission = "TheLost",
		heading = 223.00,
		bikes = true
	},
	["thelost03"] = {
		pos = vector3(2518.66,4113.51,38.13),
		permission = "TheLost",
		heading = 61.00,
		bikes = true
	},
	["thelost04"] = {
		pos = vector3(2520.06,4116.33,38.13),
		permission = "TheLost",
		heading = 61.00,
		bikes = true
	},
	["thelost05"] = {
		pos = vector3(2521.38,4118.97,38.13),
		permission = "TheLost",
		heading = 61.00,
		bikes = true
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
local function saveVehicle()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
	local vehicleMods = {
		neon = {},
		colors = {},
		extracolors = {},
		dashColour = -1,
		interColour = -1,
		lights = {},
		tint = GetVehicleWindowTint(vehicle),
		wheeltype = GetVehicleWheelType(vehicle),
		platestyle = GetVehicleNumberPlateTextIndex(vehicle),
		mods = {},
		var = {},
		smokecolor = {},
		xenonColor = -1,
		liverys = 24,
		extras = {},
		plateIndex = 0
	}

	vehicleMods["xenonColor"] = GetCurrentXenonColour(vehicle)
	vehicleMods["lights"][1],vehicleMods["lights"][2],vehicleMods["lights"][3] = GetVehicleNeonLightsColour(vehicle)
	-- vehicleMods["colors"][1],vehicleMods["colors"][2],vehicleMods["colors"][3] = GetVehicleColours(vehicle)
	-- vehicleMods["extracolors"][1],vehicleMods["extracolors"][2] = GetVehicleExtraColours(vehicle)
	vehicleMods["smokecolor"][1],vehicleMods["smokecolor"][2],vehicleMods["smokecolor"][3] = GetVehicleTyreSmokeColor(vehicle)
	vehicleMods["dashColour"] = GetVehicleInteriorColour(vehicle)
	vehicleMods["interColour"] = GetVehicleDashboardColour(vehicle)
	vehicleMods["liverys"] = GetVehicleLivery(vehicle)
	vehicleMods["plateIndex"] = GetVehicleNumberPlateTextIndex(vehicle)

	for i = 0,3 do
		vehicleMods["neon"][i] = IsVehicleNeonLightEnabled(vehicle,i)
	end

	for i = 0,16 do
		vehicleMods["mods"][i] = GetVehicleMod(vehicle,i)
	end

	for i = 17,22 do
		vehicleMods["mods"][i] = IsToggleModOn(vehicle,i)
	end

	for i = 23,48 do
		vehicleMods["mods"][i] = GetVehicleMod(vehicle,i)

		if i == 24 or i == 23 then
			vehicleMods["var"][i] = GetVehicleModVariation(vehicle,i)
		end
	end

	for i = 1,12 do
		local ison = IsVehicleExtraTurnedOn(vehicle,i)
		if 1 == tonumber(ison) then
			vehicleMods["extras"][i] = 1
		else
			vehicleMods["extras"][i] = 0
		end
	end

	TriggerServerEvent("vrp_vehCustom:updateVehicle",vehicleMods,GetVehicleNumberPlateText(vehicle),vehName)  
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTEMPTPURCHASE
-----------------------------------------------------------------------------------------------------------------------------------------
function AttemptPurchase(type,upgradeLevel)
	if upgradeLevel ~= nil then
		upgradeLevel = upgradeLevel + 2
	end

	TriggerServerEvent("vrp_vehCustom:attemptPurchase",type,upgradeLevel)

	attemptingPurchase = true

	while attemptingPurchase do
		Citizen.Wait(1)
	end

	if not isPurchaseSuccessful then
		PlaySoundFrontend(-1,"ERROR","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
	end

	return isPurchaseSuccessful
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentMod(id)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local mod = GetVehicleMod(vehicle,id)
	local modName = GetLabelText(GetModTextLabel(vehicle,id,mod))

	return mod,modName
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentWheel()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local wheel = GetVehicleMod(vehicle,23)
	local wheelName = GetLabelText(GetModTextLabel(vehicle,23,wheel))
	local wheelType = GetVehicleWheelType(vehicle)

	return wheel,wheelName,wheelType
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTCHUSTOMWHEELSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentCustomWheelState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local state = GetVehicleModVariation(vehicle,23)

	if state then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETORIGINALWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetOriginalWheel()
	return originalWheel
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETORIGINALCUSTOMWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function GetOriginalCustomWheel()
	return originalCustomWheels
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentWindowTint()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return GetVehicleWindowTint(vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTVEHICLEWHEELSMOKECLOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentVehicleWheelSmokeColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local r,g,b = GetVehicleTyreSmokeColor(vehicle)

	return r,g,b
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTNEONSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentNeonState(id)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsVehicleNeonLightEnabled(vehicle,id)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentNeonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local r,g,b = GetVehicleNeonLightsColour(vehicle)

	return r,g,b
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTXENONSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentXenonState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsToggleModOn(vehicle,22)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentXenonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return GetVehicleHeadlightsColour(vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTTURBOSTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentTurboState()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local isEnabled = IsToggleModOn(vehicle,18)

	if isEnabled then
		return 1
	else
		return 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCURRENTEXTRASTATE
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCurrentExtraState(extra)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	return IsVehicleExtraTurnedOn(vehicle,extra)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVALIDMODS
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckValidMods(category,id,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local tempMod = GetVehicleMod(vehicle,id)
	local tempWheel = GetVehicleMod(vehicle,23)
	local tempWheelType = GetVehicleWheelType(vehicle)
	local tempWheelCustom = GetVehicleModVariation(vehicle,23)
	local amountValidMods = 0
	local validMods = {}
	local hornNames = {}

	if wheelType ~= nil then
		SetVehicleWheelType(vehicle,wheelType)
	end

	if id == 14 then
		for k,v in pairs(vehicleCustomisation) do 
			if vehicleCustomisation[k]["category"] == category then
				hornNames = vehicleCustomisation[k]["hornNames"]
				break
			end
		end
	end

	local modAmount = GetNumVehicleMods(vehicle,id)
	for i = 1,modAmount do
		local label = GetModTextLabel(vehicle,id,(i - 1))
		local modName = GetLabelText(label)

		if modName == "NULL" then
			if id == 14 then
				if i <= #hornNames then
					modName = hornNames[i]["name"]
				else
					modName = "Horn "..i
				end
			else
				modName = category.." "..i
			end
		end

		validMods[i] = { id = (i - 1), name = modName }

		amountValidMods = amountValidMods + 1
	end

	if modAmount > 0 then
		table.insert(validMods,1,{ id = -1, name = "Original" })
	end

	if wheelType ~= nil then
		SetVehicleWheelType(vehicle,tempWheelType)
		SetVehicleMod(vehicle,23,tempWheel,tempWheelCustom)
	end

	return validMods,amountValidMods
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalMod()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleMod(vehicle,originalCategory,originalMod)
	SetVehicleDoorsShut(vehicle,true)

	originalCategory = nil
	originalMod = nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalWindowTint()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleWindowTint(vehicle,originalWindowTint)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALCOLOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalColours()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleColours(vehicle,originalPrimaryColour,originalSecondaryColour)
	SetVehicleExtraColours(vehicle,originalPearlescentColour,originalWheelColour)
	SetVehicleDashboardColour(vehicle,originalDashColour)
	SetVehicleInteriorColour(vehicle,originalInterColour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALWHEELS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalWheels()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	SetVehicleWheelType(vehicle,originalWheelType)

	if originalWheelCategory ~= nil then
		SetVehicleMod(vehicle,originalWheelCategory,originalWheel,originalCustomWheels)
		
		if GetVehicleClass(vehicle) == 8 then
			SetVehicleMod(vehicle,24,originalWheel,originalCustomWheels)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALNEONSTATES
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalNeonStates()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNeonLightEnabled(vehicle,originalNeonLightSide,originalNeonLightState)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALNEONCOLOURS
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalNeonColours()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNeonLightsColour(vehicle,originalNeonColourR,originalNeonColourG,originalNeonColourB)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREORIGINALXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function RestoreOriginalXenonColour()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleHeadlightsColour(vehicle,originalXenonColour)
	SetVehicleLights(vehicle,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function RestorePoliceLivery()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleLivery(vehicle,originalPoliceLivery)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESTOREPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function RestorePlateIndex()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNumberPlateTextIndex(vehicle,originalPlateIndex)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewMod(categoryID,modID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalMod == nil and originalCategory == nil then
		originalCategory = categoryID
		originalMod = GetVehicleMod(vehicle,categoryID)
	end

	if categoryID == 39 or categoryID == 40 or categoryID == 41 then
		SetVehicleDoorOpen(vehicle,4,false,true)
	elseif categoryID == 37 or categoryID == 38 then
		SetVehicleDoorOpen(vehicle,5,false,true)
	end

	SetVehicleMod(vehicle,categoryID,modID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewWindowTint(windowTintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleWindowTint(vehicle,windowTintID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewColour(paintType,paintCategory,paintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	SetVehicleModKit(vehicle,0)

	if originalDashColour == nil and originalInterColour == nil and originalPrimaryColour == nil and originalSecondaryColour == nil and originalPearlescentColour == nil and originalWheelColour == nil then
		originalPrimaryColour,originalSecondaryColour = GetVehicleColours(vehicle)
		originalPearlescentColour,originalWheelColour = GetVehicleExtraColours(vehicle)
		originalDashColour = GetVehicleDashboardColour(vehicle)
		originalInterColour = GetVehicleInteriorColour(vehicle)
	end

	if paintType == 0 then
		if paintCategory == 1 then
			SetVehicleColours(vehicle,paintID,originalSecondaryColour)
			SetVehicleExtraColours(vehicle,originalPearlescentColour,originalWheelColour)
		else
			SetVehicleColours(vehicle,paintID,originalSecondaryColour)
		end
	elseif paintType == 1 then
		SetVehicleColours(vehicle,originalPrimaryColour,paintID)
	elseif paintType == 2 then
		SetVehicleExtraColours(vehicle,paintID,originalWheelColour)
	elseif paintType == 3 then
		SetVehicleExtraColours(vehicle,originalPearlescentColour,paintID)
	elseif paintType == 4 then
		SetVehicleDashboardColour(vehicle,paintID)
	elseif paintType == 5 then
		SetVehicleInteriorColour(vehicle,paintID)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewWheel(categoryID,wheelID,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	if originalWheelCategory == nil and originalWheel == nil and originalWheelType == nil and originalCustomWheels == nil then
		originalWheelCategory = categoryID
		originalWheelType = GetVehicleWheelType(vehicle)
		originalWheel = GetVehicleMod(vehicle,23)
		originalCustomWheels = GetVehicleModVariation(vehicle,23)
	end

	SetVehicleWheelType(vehicle,wheelType)
	SetVehicleMod(vehicle,categoryID,wheelID,doesHaveCustomWheels)

	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,wheelID,doesHaveCustomWheels)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWNEON
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewNeon(side,enabled)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalNeonLightState == nil and originalNeonLightSide == nil then
		if IsVehicleNeonLightEnabled(vehicle,side) then
			originalNeonLightState = 1
		else
			originalNeonLightState = 0
		end

		originalNeonLightSide = side
	end

	SetVehicleNeonLightEnabled(vehicle,side,enabled)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewNeonColour(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalNeonColourR == nil and originalNeonColourG == nil and originalNeonColourB == nil then
		originalNeonColourR,originalNeonColourG,originalNeonColourB = GetVehicleNeonLightsColour(vehicle)
	end

	SetVehicleNeonLightsColour(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewXenonColour(colour)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if originalXenonColour == nil then
		originalXenonColour = GetVehicleHeadlightsColour(vehicle)
	end

	SetVehicleLights(vehicle,2)
	SetVehicleHeadlightsColour(vehicle,colour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewPoliceLivery(liv)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleLivery(vehicle,tonumber(liv))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVIEWPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function PreviewPlateIndex(index)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleNumberPlateTextIndex(vehicle,tonumber(index))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYMOD
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyMod(categoryID,modID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	if categoryID == 18 then
		ToggleVehicleMod(vehicle,categoryID,modID)
	elseif categoryID == 11 or categoryID == 12 or categoryID== 13 or categoryID == 15 or categoryID == 16 then
		originalCategory = categoryID
		originalMod = modID

		SetVehicleMod(vehicle,categoryID,modID)
	else
		originalCategory = categoryID
		originalMod = modID

		SetVehicleMod(vehicle,categoryID,modID)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYEXTRA
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyExtra(extraID)
	local ped = PlayerPedId()
	local Vehicle = GetVehiclePedIsUsing(ped)

	local engine = GetVehicleEngineHealth(Vehicle)
	local body = GetVehicleBodyHealth(Vehicle)
	local vehWindows = {}
	local vehTyres = {}
	local vehDoors = {}

	for i = 0,7 do
		local Status = false

		if GetTyreHealth(Vehicle,i) ~= 1000.0 then
			Status = true
		end

		vehTyres[i] = Status
	end

	for i = 0,5 do
		vehDoors[i] = IsVehicleDoorDamaged(Vehicle,i)
	end

	for i = 0,5 do
		vehWindows[i] = IsVehicleWindowIntact(Vehicle,i)
	end

	local isEnabled = IsVehicleExtraTurnedOn(Vehicle,extraID)
	if isEnabled == 1 then
		SetVehicleExtra(Vehicle,tonumber(extraID),1)
		SetVehiclePetrolTankHealth(Vehicle,4000.0)
	else
		SetVehicleExtra(Vehicle,tonumber(extraID),0)
		SetVehiclePetrolTankHealth(Vehicle,4000.0)
	end

	SetVehicleEngineHealth(Vehicle,engine)
	SetVehicleBodyHealth(Vehicle,body)

	for Tyre,Burst in pairs(vehTyres) do
		if Burst then
			SetVehicleTyreBurst(Vehicle,Tyre,true,1000.0)
		end
	end

	for k,v in pairs(vehWindows) do
		if not v then
			SmashVehicleWindow(Vehicle,k)
		end
	end

	for k,v in pairs(vehDoors) do
		if v then
			SetVehicleDoorBroken(Vehicle,k,v)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYWINDOWTINT
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyWindowTint(windowTintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalWindowTint = windowTintID

	SetVehicleWindowTint(vehicle,windowTintID)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyColour(paintType,paintCategory,paintID)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehPrimaryColour,vehSecondaryColour = GetVehicleColours(vehicle)
	local vehPearlescentColour,vehWheelColour = GetVehicleExtraColours(vehicle)

	if paintType == 0 then
		if paintCategory == 1 then
			SetVehicleColours(vehicle,paintID,vehSecondaryColour)
			SetVehicleExtraColours(vehicle,originalPearlescentColour,vehWheelColour)
			originalPrimaryColour = paintID
		else
			SetVehicleColours(vehicle,paintID,vehSecondaryColour)
			originalPrimaryColour = paintID
		end
	elseif paintType == 1 then
		SetVehicleColours(vehicle,vehPrimaryColour,paintID)
		originalSecondaryColour = paintID
	elseif paintType == 2 then
		SetVehicleExtraColours(vehicle,paintID,vehWheelColour)
		originalPearlescentColour = paintID
	elseif paintType == 3 then
		SetVehicleExtraColours(vehicle,vehPearlescentColour,paintID)
		originalWheelColour = paintID
	elseif paintType == 4 then
		SetVehicleDashboardColour(vehicle,paintID)
		originalDashColour = paintID
	elseif paintType == 5 then
		SetVehicleInteriorColour(vehicle,paintID)
		originalInterColour = paintID
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyWheel(categoryID,wheelID,wheelType)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local doesHaveCustomWheels = GetVehicleModVariation(vehicle,23)

	originalWheelCategory = categoryID
	originalWheel = wheelID
	originalWheelType = wheelType

	SetVehicleWheelType(vehicle,wheelType)
	SetVehicleMod(vehicle,categoryID,wheelID,doesHaveCustomWheels)
	
	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,wheelID,doesHaveCustomWheels)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYCUSTOMWHEEL
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyCustomWheel(state)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	SetVehicleMod(vehicle,23,GetVehicleMod(vehicle,23),state)

	if GetVehicleClass(vehicle) == 8 then
		SetVehicleMod(vehicle,24,GetVehicleMod(vehicle,24),state)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYNEON
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyNeon(side,enabled)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalNeonLightState = enabled
	originalNeonLightSide = side

	SetVehicleNeonLightEnabled(vehicle,side,enabled)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYNEONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyNeonColour(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalNeonColourR = r
	originalNeonColourG = g
	originalNeonColourB = b

	SetVehicleNeonLightsColour(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYXENONLIGHTS
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyXenonLights(category,state)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	ToggleVehicleMod(vehicle,category,state)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYXENONCOLOUR
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyXenonColour(colour)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalXenonColour = colour

	SetVehicleHeadlightsColour(vehicle,colour)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYPOLICELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyPoliceLivery(liv)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalPoliceLivery = liv

	SetVehicleLivery(vehicle,liv)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYPLATEINDEX
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyPlateIndex(index)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	originalPlateIndex = index

	SetVehicleNumberPlateTextIndex(vehicle,index)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- APPLYTYRESMOKE
-----------------------------------------------------------------------------------------------------------------------------------------
function ApplyTyreSmoke(r,g,b)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)

	ToggleVehicleMod(vehicle,20,true)
	SetVehicleTyreSmokeColor(vehicle,r,g,b)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXITBENNYS
-----------------------------------------------------------------------------------------------------------------------------------------
function ExitBennys()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			FreezeEntityPosition(vehicle,false)
			saveVehicle()
		end
	end

	TriggerServerEvent("vrp_vehCustom:inVehicle",nil)
	TriggerEvent("player:inBennys",false)
	DisplayMenuContainer(false)
	activeBennys = false
	DestroyMenus()
	TriggerEvent('hudOff',false)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPAIR VEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function RepairVehicle(body)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local hoodOpen = GetVehicleDoorAngleRatio(vehicle,4)
	if vSERVER.checkVehicleRepair(body) then
		if IsEntityAVehicle(vehicle) then
			if hoodOpen == 0 then
				SetVehicleDoorOpen(vehicle,4,0,0)
			end
			FreezeEntityPosition(vehicle,true)
			SetVehicleIndicatorLights(vehicle,0,true)
			SetVehicleIndicatorLights(vehicle,1,true)
			SetVehicleEngineOn(vehicle, false, false, true)
			TriggerEvent("progress",10000,"reparando veículo")
			SetTimeout(10000,function()
				TriggerServerEvent("tryreparar",VehToNet(vehicle))
				SetVehicleDoorShut(vehicle,4,0)
				SetVehicleIndicatorLights(vehicle,0,false)
				SetVehicleIndicatorLights(vehicle,1,false)
				FreezeEntityPosition(vehicle,false)
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISABLECONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
function disableControls()
	activeBennys = true

	CreateThread(function()
		while activeBennys do
			DisableControlAction(1,38,true)
			DisableControlAction(1,172,true)
			DisableControlAction(1,173,true)
			DisableControlAction(1,177,true)
			DisableControlAction(1,176,true)
			DisableControlAction(1,71,true)
			DisableControlAction(1,72,true)
			DisableControlAction(1,34,true)
			DisableControlAction(1,35,true)
			DisableControlAction(1,75,true)
			
			if IsDisabledControlJustReleased(1,172) then
				MenuScrollFunctionality("up")
				PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,173) then
				MenuScrollFunctionality("down")
				PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,176) then
				MenuManager(true)
				PlaySoundFrontend(-1,"OK","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end
			
			if IsDisabledControlJustReleased(1,177) then
				MenuManager(false)
				PlaySoundFrontend(-1,"NO","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
			end

			Citizen.Wait(0)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURCHASESUCCESFUL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_vehCustom:purchaseSuccessful")
AddEventHandler("vrp_vehCustom:purchaseSuccessful",function()
	isPurchaseSuccessful = true
	attemptingPurchase = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PURCHASEFAILED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_vehCustom:purchaseFailed")
AddEventHandler("vrp_vehCustom:purchaseFailed",function()
	isPurchaseSuccessful = false
	attemptingPurchase = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		if not activeBennys then
			local ped = PlayerPedId()
			-- if IsPedInAnyVehicle(ped) then
				local coords = GetEntityCoords(ped)
				local vehicle = GetVehiclePedIsUsing(ped)
				if GetPedInVehicleSeat(vehicle,-1) == ped then
					local body = GetVehicleBodyHealth(vehicle)
					for k,v in pairs(bennysLocations) do
						local distance = #(coords - v["pos"])
						if distance <= 3.5 then
							timeDistance = 1
							DrawMarker(27,v.pos['x'], v.pos['y'], v.pos['z']-0.9,0,0,0,0.0,0,0,2.0,2.0,2.0, 255,255,255, 196,0,0,0,10)
							
							-- TriggerEvent("hoverfy:insertTable",{{ v.pos['x'], v.pos['y'], v.pos['z'], 1.5, "E","Iniciar Customização","Pressione para abrir/fechar o menu" }})

							if IsControlJustPressed(1,38) and vSERVER.checkPermission() then
								if body > 995 then
									local isMotorcycle = false
									TriggerEvent('hudOff',true)
									if v["bikes"] then
										if GetVehicleClass(vehicle) == 8 then
											isMotorcycle = true
										else
											goto skipBennys
										end
									else
										if GetVehicleClass(vehicle) == 8 then
											isMotorcycle = true
										else
											isMotorcycle = false
										end
									end

									SetVehicleModKit(vehicle,0)
									SetEntityCoords(vehicle,v["pos"])
									-- SetEntityHeading(vehicle,v["heading"])
									SetVehicleEngineOn(vehicle, false, false, true)
									FreezeEntityPosition(vehicle,true)
									SetVehicleOnGroundProperly(vehicle)

									originalCategory = nil
									originalMod = nil
									originalPrimaryColour = nil
									originalSecondaryColour = nil
									originalPearlescentColour = nil
									originalWheelColour = nil
									originalDashColour = nil
									originalInterColour = nil
									originalWindowTint = nil
									originalWheelCategory = nil
									originalWheel = nil
									originalWheelType = nil
									originalCustomWheels = nil
									originalNeonLightState = nil
									originalNeonLightSide = nil
									originalNeonColourR = nil
									originalNeonColourG = nil
									originalNeonColourB = nil
									originalXenonColour = nil
									originalPoliceLivery = nil
									originalPlateIndex = nil

									InitiateMenus(isMotorcycle)

									DisplayMenuContainer(true)
									DisplayMenu(true,"mainMenu")
									TriggerEvent("player:inBennys",true)
									PlaySoundFrontend(-1,"OK","HUD_FRONTEND_DEFAULT_SOUNDSET",1)
									TriggerServerEvent("vrp_vehCustom:inVehicle",VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))

									disableControls()

									::skipBennys::
								else
									RepairVehicle(body)
								end
							end
						end
					end
				end
			-- end
		end

		Citizen.Wait(timeDistance)
	end
end)