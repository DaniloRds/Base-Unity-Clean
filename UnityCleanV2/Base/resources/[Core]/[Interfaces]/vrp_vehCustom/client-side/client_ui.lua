local currentMenuItemID = 0
local currentMenuItem = ""
local currentMenuItem2 = ""
local currentMenu = "mainMenu"
local currentCategory = 0
local currentResprayCategory = 0
local currentResprayType = 0
local currentWheelCategory = 0
local currentNeonSide = 0

local function roundNum(num,numDecimalPlaces)
	return tonumber(string.format("%."..(numDecimalPlaces or 0).."f",num))
end

local function toggleMenuContainer(state)
	SendNUIMessage({ toggleMenuContainer = true, state = state })
end

local function createMenu(menu,heading,subheading)
	SendNUIMessage({ createMenu = true, menu = menu, heading = heading, subheading = subheading })
end

local function destroyMenus()
	SendNUIMessage({ destroyMenus = true })
end

local function populateMenu(menu,id,item,item2)
	SendNUIMessage({ populateMenu = true, menu = menu, id = id, item = item, item2 = item2 })
end

local function finishPopulatingMenu(menu)
	SendNUIMessage({ finishPopulatingMenu = true, menu = menu })
end

local function updateMenuHeading(menu)
	SendNUIMessage({ updateMenuHeading = true, menu = menu })
end

local function updateMenuSubheading(menu)
	SendNUIMessage({ updateMenuSubheading = true, menu = menu })
end

local function updateMenuStatus(text)
	SendNUIMessage({ updateMenuStatus = true, statusText = text })
end

local function toggleMenu(state,menu)
	SendNUIMessage({ toggleMenu = true, state = state, menu = menu })
end

local function updateItem2Text(menu,id,text)
	SendNUIMessage({ updateItem2Text = true, menu = menu, id = id, item2 = text })
end

local function updateItem2TextOnly(menu,id,text)
	SendNUIMessage({ updateItem2TextOnly = true, menu = menu, id = id, item2 = text })
end

local function scrollMenuFunctionality(direction,menu)
	SendNUIMessage({ scrollMenuFunctionality = true, direction = direction, menu = menu })
end

local function playSoundEffect(soundEffect,volume)
	SendNUIMessage({ playSoundEffect = true, soundEffect = soundEffect, volume = volume })
end

local function isMenuActive(menu)
	local menuActive = false

	if menu == "modMenu" then
		for k,v in pairs(vehicleCustomisation) do 
			if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	-- elseif menu == "ResprayMenu" then
	-- 	for k,v in pairs(vehicleResprayOptions) do
	-- 		if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
	-- 			menuActive = true

	-- 			break
	-- 		else
	-- 			menuActive = false
	-- 		end
	-- 	end
	elseif menu == "WheelsMenu" then
		for k,v in pairs(vehicleWheelOptions) do
			if (v["category"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	elseif menu == "NeonsSideMenu" then
		for k,v in pairs(vehicleNeonOptions["neonTypes"]) do
			if (v["name"]:gsub("%s+","").."Menu") == currentMenu then
				menuActive = true

				break
			else
				menuActive = false
			end
		end
	end

	return menuActive
end

local function updateCurrentMenuItemID(id,item,item2)
	currentMenuItemID = id
	currentMenuItem = item
	currentMenuItem2 = item2

	if isMenuActive("modMenu") then
		if currentCategory ~= 18 then
			PreviewMod(currentCategory,currentMenuItemID)
		end
	-- elseif isMenuActive("ResprayMenu") then
	-- 	PreviewColour(currentResprayCategory,currentResprayType,currentMenuItemID)
	elseif isMenuActive("WheelsMenu") then
		if currentWheelCategory ~= -1 and currentWheelCategory ~= 20 then
			PreviewWheel(currentCategory,currentMenuItemID,currentWheelCategory)
		end
	elseif isMenuActive("NeonsSideMenu") then
		PreviewNeon(currentNeonSide,currentMenuItemID)
	elseif currentMenu == "WindowTintMenu" then
		PreviewWindowTint(currentMenuItemID)
	elseif currentMenu == "NeonColoursMenu" then
		local r = vehicleNeonOptions["neonColours"][currentMenuItemID]["r"]
		local g = vehicleNeonOptions["neonColours"][currentMenuItemID]["g"]
		local b = vehicleNeonOptions["neonColours"][currentMenuItemID]["b"]

		PreviewNeonColour(r,g,b)
	elseif currentMenu == "XenonColoursMenu" then
		PreviewXenonColour(currentMenuItemID)
	elseif currentMenu == "PoliceLiveryMenu" then
		PreviewPoliceLivery(currentMenuItemID)
	elseif currentMenu == "PlateIndexMenu" then
		PreviewPlateIndex(currentMenuItemID)
	end
end

function InitiateMenus(isMotorcycle)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	local vehclass = GetVehicleClass(vehicle)

	createMenu("mainMenu","Menu de Personalização Veícular","Escolha a Categoria")

	for k,v in ipairs(vehicleCustomisation) do 
		local validMods,amountValidMods = CheckValidMods(v["category"],v["id"])

		if amountValidMods > 0 or v["id"] == 18 then
			populateMenu("mainMenu",v["id"],v["category"],"none")
		end
	end

	-- populateMenu("mainMenu",-1,"Respray","none")

	if not isMotorcycle then
		populateMenu("mainMenu",-2,"Window Tint","none")
		populateMenu("mainMenu",-3,"Neons","none")
	end

	populateMenu("mainMenu",22,"Xenons","none")
	populateMenu("mainMenu",23,"Wheels","none")

	if vehclass == 18 or GetEntityModel(vehicle) == 347619240 then
		populateMenu("mainMenu",24,"Police Livery","none")
	end

	populateMenu("mainMenu",26,"Vehicle Extras","none")

	populateMenu("mainMenu",25,"Plate Index","none")

	finishPopulatingMenu("mainMenu")

	for k,v in ipairs(vehicleCustomisation) do 
		local validMods,amountValidMods = CheckValidMods(v["category"],v["id"])
		local currentMod,currentModName = GetCurrentMod(v["id"])

		if amountValidMods > 0 or v["id"] == 18 then
			if v["id"] == 11 or v["id"] == 12 or v["id"] == 13 or v["id"] == 15 or v["id"] == 16 then
				local tempNum = 0

				createMenu(v["category"]:gsub("%s+","").."Menu",v["category"],"Escolha o Upgrade")

				for m,n in pairs(validMods) do
					tempNum = tempNum + 1

					populateMenu(v["category"]:gsub("%s+","").."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices[v["type"]][tempNum])

					if currentMod == n["id"] then
						updateItem2Text(v["category"]:gsub("%s+","").."Menu",n["id"],"Instalado")
					end
				end

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			elseif v["id"] == 18 then
				local currentTurboState = GetCurrentTurboState()
				createMenu(v["category"]:gsub("%s+","").."Menu",v["category"].." Customisation","Ativar / Desativar turbo")

				populateMenu(v["category"]:gsub("%s+","").."Menu",0,"Desativado","$7500")
				populateMenu(v["category"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["turbo"])

				updateItem2Text(v["category"]:gsub("%s+","").."Menu",currentTurboState,"Instalado")

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			else
				createMenu(v["category"]:gsub("%s+","").."Menu",v["category"].." Customisation","Escolha o Mod")

				for m,n in pairs(validMods) do
					populateMenu(v["category"]:gsub("%s+","").."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["cosmetics"])

					if currentMod == n["id"] then
						updateItem2Text(v["category"]:gsub("%s+","").."Menu",n["id"],"Instalado")
					end
				end

				finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
			end
		end
	end

	createMenu("ResprayMenu","Respray","Choose a Colour Category")

	populateMenu("ResprayMenu",0,"Primary Colour","none")
	populateMenu("ResprayMenu",1,"Secondary Colour","none")
	populateMenu("ResprayMenu",2,"Pearlescent Colour","none")
	populateMenu("ResprayMenu",3,"Wheel Colour","none")
	populateMenu("ResprayMenu",4,"Interior Colour","none")
	populateMenu("ResprayMenu",5,"Dashboard Colour","none")

	finishPopulatingMenu("ResprayMenu")

	createMenu("ResprayTypeMenu","Respray Types","Escolha um tipo de cor")

	for k,v in ipairs(vehicleResprayOptions) do
		populateMenu("ResprayTypeMenu",v["id"],v["category"],"none")
	end

	finishPopulatingMenu("ResprayTypeMenu")

	for k,v in ipairs(vehicleResprayOptions) do 
		createMenu(v["category"].."Menu",v["category"],"Escolha uma cor")

		for m,n in ipairs(v["colours"]) do
			populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["respray"])
		end

		finishPopulatingMenu(v["category"].."Menu")
	end

	createMenu("WheelsMenu","Personalização de Rodas","Escolha a Categoria")

	for k,v in ipairs(vehicleWheelOptions) do 
		if isMotorcycle then
			if v["id"] == -1 or v["id"] == 20 or v["id"] == 6 then
				populateMenu("WheelsMenu",v["id"],v["category"],"none")
			end
		else
			populateMenu("WheelsMenu",v["id"],v["category"],"none")
		end
	end

	finishPopulatingMenu("WheelsMenu")

	for k,v in ipairs(vehicleWheelOptions) do 
		if v["id"] == -1 then
			local currentCustomWheelState = GetCurrentCustomWheelState()
			createMenu(v["category"]:gsub("%s+","").."Menu",v["category"],"Ativar / Desativar rodas")

			populateMenu(v["category"]:gsub("%s+","").."Menu",0,"Desativado","$0")
			populateMenu(v["category"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["customwheels"])

			updateItem2Text(v["category"]:gsub("%s+","").."Menu",currentCustomWheelState,"Instalado")

			finishPopulatingMenu(v["category"]:gsub("%s+","").."Menu")
		elseif v["id"] ~= 20 then
			if isMotorcycle then
				if v["id"] == 6 then
					local validMods,amountValidMods = CheckValidMods(v["category"],v.wheelID,v["id"])

					createMenu(v["category"].."Menu",v["category"].." Wheels","Escolha a Roda")

					for m,n in pairs(validMods) do
						populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["wheels"])
					end

					finishPopulatingMenu(v["category"].."Menu")
				end
			else
				local validMods,amountValidMods = CheckValidMods(v["category"],v.wheelID,v["id"])

				createMenu(v["category"].."Menu",v["category"].." Wheels","Escolha a Roda")

				for m,n in pairs(validMods) do
					populateMenu(v["category"].."Menu",n["id"],n["name"],"$"..vehicleCustomisationPrices["wheels"])
				end

				finishPopulatingMenu(v["category"].."Menu")
			end
		end
	end

	local currentWheelSmokeR,currentWheelSmokeG,currentWheelSmokeB = GetCurrentVehicleWheelSmokeColour()
	createMenu("TyreSmokeMenu","Personalize a Fumaça dos Pneus","Escolha uma cor")

	for k,v in ipairs(vehicleTyreSmokeOptions) do
		populateMenu("TyreSmokeMenu",k,v["name"],"$"..vehicleCustomisationPrices["wheelsmoke"])

		if v["r"] == currentWheelSmokeR and v["g"] == currentWheelSmokeG and v["b"] == currentWheelSmokeB then
			updateItem2Text("TyreSmokeMenu",k,"Instalado")
		end
	end

	finishPopulatingMenu("TyreSmokeMenu")

	local currentWindowTint = GetCurrentWindowTint()
	createMenu("WindowTintMenu","Defina o Nível do Insufilm","Escolha um Papel")

	for k,v in ipairs(vehicleWindowTintOptions) do
		populateMenu("WindowTintMenu",v["id"],v["name"],"$"..vehicleCustomisationPrices["windowtint"])

		if currentWindowTint == v["id"] then
			updateItem2Text("WindowTintMenu",v["id"],"Instalado")
		end
	end

	finishPopulatingMenu("WindowTintMenu")

	if vehclass == 18 or GetEntityModel(vehicle) == 347619240 then
		local livCount = GetVehicleLiveryCount(vehicle)
		if livCount > 0 then
			local temporaryLivery = GetVehicleLivery(vehicle)
			createMenu("PoliceLiveryMenu","Police Livery Customisation","Escolha o Livery")
			for i = 0,livCount - 1 do
				populateMenu("PoliceLiveryMenu",i,"Livery 0"..i + 1,"$100")

				if temporaryLivery == i then
					updateItem2Text("PoliceLiveryMenu",i,"Instalado")
				end
			end

			finishPopulatingMenu("PoliceLiveryMenu")
		end
	end

	local temporaryPlate = GetVehicleNumberPlateTextIndex(vehicle)
	createMenu("PlateIndexMenu","Plate Colour","Escolha o tipo")

	local plateTypes = {
		"San Andreas Cosmo",
		"San Andreas Supermesh",
		"San Andreas Outsider",
		"San Andreas Slicer",
		"San Andreas Elquatro",
		"San Andreas Dubbed"
	}

	for i = 0,#plateTypes - 1 do
		populateMenu("PlateIndexMenu",i,plateTypes[i+1],"$1000")

		if temporaryPlate == i then
			updateItem2Text("PlateIndexMenu",i,"Instalado")
		end
	end
	finishPopulatingMenu("PlateIndexMenu")

	createMenu("VehicleExtrasMenu","Escolha Customizações Extras","Válido para Veículos de Serviço")

	for i = 1,12 do
		if DoesExtraExist(vehicle,i) then
			if IsVehicleExtraTurnedOn(vehicle,i) then
				populateMenu("VehicleExtrasMenu",i,"Extra 0"..i,"Ativado")
			else
				populateMenu("VehicleExtrasMenu",i,"Extra 0"..i,"Destivado")
			end
		end
	end

	finishPopulatingMenu("VehicleExtrasMenu")

	createMenu("NeonsMenu","Personalização de Neon","Escolha a Categoria")

	for k,v in ipairs(vehicleNeonOptions["neonTypes"]) do
		populateMenu("NeonsMenu",v["id"],v["name"],"none")
	end

	populateMenu("NeonsMenu",-1,"Neon Colours","none")
	finishPopulatingMenu("NeonsMenu")

	for k,v in ipairs(vehicleNeonOptions["neonTypes"]) do
		local currentNeonState = GetCurrentNeonState(v["id"])
		createMenu(v["name"]:gsub("%s+","").."Menu","Neon Customisation","Ativar / Desativar Neon")

		populateMenu(v["name"]:gsub("%s+","").."Menu",0,"Desativado","$0")
		populateMenu(v["name"]:gsub("%s+","").."Menu",1,"Ativado","$"..vehicleCustomisationPrices["neonside"])

		updateItem2Text(v["name"]:gsub("%s+","").."Menu",currentNeonState,"Instalado")

		finishPopulatingMenu(v["name"]:gsub("%s+","").."Menu")
	end

	local currentNeonR,currentNeonG,currentNeonB = GetCurrentNeonColour()
	createMenu("NeonColoursMenu","Neon Colours","Escolha uma cor")

	for k,v in ipairs(vehicleNeonOptions["neonColours"]) do
		populateMenu("NeonColoursMenu",k,vehicleNeonOptions["neonColours"][k]["name"],"$"..vehicleCustomisationPrices["neoncolours"])

		if currentNeonR == vehicleNeonOptions["neonColours"][k]["r"] and currentNeonG == vehicleNeonOptions["neonColours"][k]["g"] and currentNeonB == vehicleNeonOptions["neonColours"][k]["b"] then
			updateItem2Text("NeonColoursMenu",k,"Instalado")
		end
	end

	finishPopulatingMenu("NeonColoursMenu")

	createMenu("XenonsMenu","Personalização de Xenon","Escolha a categoria")

	populateMenu("XenonsMenu",0,"Headlights","none")
	populateMenu("XenonsMenu",1,"Xenon Colours","none")

	finishPopulatingMenu("XenonsMenu")

	local currentXenonState = GetCurrentXenonState()
	createMenu("HeadlightsMenu","Headlights Customisation","Ativar / Desativar Xenons")

	populateMenu("HeadlightsMenu",0,"Desativado","$0")
	populateMenu("HeadlightsMenu",1,"Ativado","$"..vehicleCustomisationPrices["headlights"])

	updateItem2Text("HeadlightsMenu",currentXenonState,"Instalado")

	finishPopulatingMenu("HeadlightsMenu")

	local currentXenonColour = GetCurrentXenonColour()
	createMenu("XenonColoursMenu","Xenon Colours","Escolha uma cor")

	for k,v in ipairs(vehicleXenonOptions["xenonColours"]) do
		populateMenu("XenonColoursMenu",v["id"],v["name"],"$"..vehicleCustomisationPrices["xenoncolours"])

		if currentXenonColour == v["id"] then
			updateItem2Text("XenonColoursMenu",v["id"],"Instalado")
		end
	end

	finishPopulatingMenu("XenonColoursMenu")
end

function DestroyMenus()
	destroyMenus()
end

function DisplayMenuContainer(state)
	toggleMenuContainer(state)
end

function DisplayMenu(state,menu)
	if state then
		currentMenu = menu
	end
	toggleMenu(state,menu)
	updateMenuHeading(menu)
	updateMenuSubheading(menu)
end

function MenuManager(state)
	if state then
		if currentMenuItem2 ~= "Instalado" then
			if isMenuActive("modMenu") then
				if currentCategory == 18 then
					if AttemptPurchase("turbo") then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentCategory == 11 then
					if AttemptPurchase("engines",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentCategory == 12 then
					if AttemptPurchase("brakes",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentCategory == 13 then
					if AttemptPurchase("transmission",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentCategory == 15 then
					if AttemptPurchase("suspension",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentCategory == 16 then
					if AttemptPurchase("shield",currentMenuItemID) then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				else
					if AttemptPurchase("cosmetics") then
						ApplyMod(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				end
			-- elseif isMenuActive("ResprayMenu") then
			-- 	if AttemptPurchase("respray") then
			-- 		ApplyColour(currentResprayCategory,currentResprayType,currentMenuItemID)
			-- 		playSoundEffect("respray",1.0)
			-- 		updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
			-- 		updateMenuStatus("Comprado")
			-- 	else
			-- 		updateMenuStatus("Dinheiro insuficiente.")
			-- 	end
			elseif isMenuActive("WheelsMenu") then
				if currentWheelCategory == 20 then
					if AttemptPurchase("wheelsmoke") then
						local r = vehicleTyreSmokeOptions[currentMenuItemID]["r"]
						local g = vehicleTyreSmokeOptions[currentMenuItemID]["g"]
						local b = vehicleTyreSmokeOptions[currentMenuItemID]["b"]

						ApplyTyreSmoke(r,g,b)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				else
					if currentWheelCategory == -1 then
						local currentWheel = GetCurrentWheel()

						if currentWheel == -1 then
							updateMenuStatus("Can't Apply Custom Tyres to Stock Wheels")
						else
							if AttemptPurchase("customwheels") then
								ApplyCustomWheel(currentMenuItemID)
								playSoundEffect("wrench",0.25)
								updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
								updateMenuStatus("Comprado")
							else
								updateMenuStatus("Dinheiro insuficiente.")
							end
						end
					else
						local currentWheel = GetCurrentWheel()
						local currentCustomWheelState = GetOriginalCustomWheel()

						if currentCustomWheelState and currentWheel == -1 then
							updateMenuStatus("Can't Apply Stock Wheels With Custom Tyres")
						else
							if AttemptPurchase("wheels") then
								ApplyWheel(currentCategory,currentMenuItemID,currentWheelCategory)
								playSoundEffect("wrench",0.25)
								updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
								updateMenuStatus("Comprado")
							else
								updateMenuStatus("Dinheiro insuficiente.")
							end
						end
					end
				end
			elseif isMenuActive("NeonsSideMenu") then
				if AttemptPurchase("neonside") then
					playSoundEffect("wrench",0.25)
					ApplyNeon(currentNeonSide,currentMenuItemID)
					updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
					updateMenuStatus("Comprado")
				else
					updateMenuStatus("Dinheiro insuficiente.")
				end 
			else
				if currentMenu == "mainMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentCategory = currentMenuItemID

					toggleMenu(false,"mainMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "ResprayMenu" then
					currentMenu = "ResprayTypeMenu"
					currentResprayCategory = currentMenuItemID

					toggleMenu(false,"ResprayMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "ResprayTypeMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentResprayType = currentMenuItemID

					toggleMenu(false,"ResprayTypeMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "WheelsMenu" then
					local currentWheel,currentWheelName,currentWheelType = GetCurrentWheel()

					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentWheelCategory = currentMenuItemID

					if currentWheelType == currentWheelCategory then
						updateItem2Text(currentMenu,currentWheel,"Instalado")
					end

					toggleMenu(false,"WheelsMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "NeonsMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"
					currentNeonSide = currentMenuItemID

					toggleMenu(false,"NeonsMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "XenonsMenu" then
					currentMenu = currentMenuItem:gsub("%s+","").."Menu"

					toggleMenu(false,"XenonsMenu")
					toggleMenu(true,currentMenu)
					updateMenuHeading(currentMenu)
					updateMenuSubheading(currentMenu)
				elseif currentMenu == "WindowTintMenu" then
					if AttemptPurchase("windowtint") then
						ApplyWindowTint(currentMenuItemID)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentMenu == "NeonColoursMenu" then
					if AttemptPurchase("neoncolours") then
						local r = vehicleNeonOptions["neonColours"][currentMenuItemID]["r"]
						local g = vehicleNeonOptions["neonColours"][currentMenuItemID]["g"]
						local b = vehicleNeonOptions["neonColours"][currentMenuItemID]["b"]

						ApplyNeonColour(r,g,b)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentMenu == "HeadlightsMenu" then
					if AttemptPurchase("headlights") then
						ApplyXenonLights(currentCategory,currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentMenu == "XenonColoursMenu" then
					if AttemptPurchase("xenoncolours") then
						ApplyXenonColour(currentMenuItemID)
						playSoundEffect("respray",1.0)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentMenu == "PoliceLiveryMenu" then
					if AttemptPurchase("policelivery") then
						ApplyPoliceLivery(currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")   
					end
				elseif currentMenu == "PlateIndexMenu" then
					if AttemptPurchase("plateindex") then
						ApplyPlateIndex(currentMenuItemID)
						playSoundEffect("wrench",0.25)
						updateItem2Text(currentMenu,currentMenuItemID,"Instalado")
						updateMenuStatus("Comprado")
					else
						updateMenuStatus("Dinheiro insuficiente.")
					end
				elseif currentMenu == "VehicleExtrasMenu" then
					ApplyExtra(currentMenuItemID)
					playSoundEffect("wrench",0.25)

					local ped = PlayerPedId()
					local vehicle = GetVehiclePedIsUsing(ped)
					if IsVehicleExtraTurnedOn(vehicle,currentMenuItemID) then
						updateItem2TextOnly(currentMenu,currentMenuItemID,"Ativado")
						updateMenuStatus("Ativado")
					else
						updateItem2TextOnly(currentMenu,currentMenuItemID,"Desativado")
						updateMenuStatus("Desativado")
					end
				end
			end
		else
			if currentMenu == "VehicleExtrasMenu" then
				ApplyExtra(currentMenuItemID)
				playSoundEffect("wrench",0.25)

				local ped = PlayerPedId()
				local vehicle = GetVehiclePedIsUsing(ped)
				if IsVehicleExtraTurnedOn(vehicle,currentMenuItemID) then
					updateItem2TextOnly(currentMenu,currentMenuItemID,"Ativado")
					updateMenuStatus("Ativado")
				else
					updateItem2TextOnly(currentMenu,currentMenuItemID,"Desativado")
					updateMenuStatus("Desativado")
				end
			end
		end
	else
		updateMenuStatus("")

		if isMenuActive("modMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "mainMenu"

			if currentCategory ~= 18 then
				RestoreOriginalMod()
			end

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("ResprayMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "ResprayTypeMenu"

			RestoreOriginalColours()

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("WheelsMenu") then            
			if currentWheelCategory ~= 20 and currentWheelCategory ~= -1 then
				local currentWheel = GetOriginalWheel()

				updateItem2Text(currentMenu,currentWheel,"$"..vehicleCustomisationPrices["wheels"])

				RestoreOriginalWheels()
			end

			toggleMenu(false,currentMenu)

			currentMenu = "WheelsMenu"

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		elseif isMenuActive("NeonsSideMenu") then
			toggleMenu(false,currentMenu)

			currentMenu = "NeonsMenu"

			RestoreOriginalNeonStates()

			toggleMenu(true,currentMenu)
			updateMenuHeading(currentMenu)
			updateMenuSubheading(currentMenu)
		else
			if currentMenu == "mainMenu" then
				ExitBennys()
			elseif currentMenu == "ResprayMenu" or currentMenu == "WindowTintMenu" or currentMenu == "WheelsMenu" or currentMenu == "NeonsMenu" or currentMenu == "XenonsMenu" or currentMenu == "PoliceLiveryMenu" or currentMenu == "PlateIndexMenu" or currentMenu == "VehicleExtrasMenu" then
				toggleMenu(false,currentMenu)

				if currentMenu == "WindowTintMenu" then
					RestoreOriginalWindowTint()
				end

				if currentMenu == "PoliceLiveryMenu" then
					RestorePoliceLivery()
				end

				if currentMenu == "PlateIndexMenu" then
					RestorePlateIndex()
				end

				currentMenu = "mainMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "ResprayTypeMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "ResprayMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "NeonColoursMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "NeonsMenu"

				RestoreOriginalNeonColours()

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "HeadlightsMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "XenonsMenu"

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			elseif currentMenu == "XenonColoursMenu" then
				toggleMenu(false,currentMenu)

				currentMenu = "XenonsMenu"

				RestoreOriginalXenonColour()

				toggleMenu(true,currentMenu)
				updateMenuHeading(currentMenu)
				updateMenuSubheading(currentMenu)
			end
		end
	end
end

function MenuScrollFunctionality(direction)
	scrollMenuFunctionality(direction,currentMenu)
end

RegisterNUICallback("selectedItem",function(data,cb)
	updateCurrentMenuItemID(tonumber(data["id"]),data["item"],data["item2"])
	cb("ok")
end)

RegisterNUICallback("updateItem2",function(data,cb)
	currentMenuItem2 = data["item"]
	cb("ok")
end)