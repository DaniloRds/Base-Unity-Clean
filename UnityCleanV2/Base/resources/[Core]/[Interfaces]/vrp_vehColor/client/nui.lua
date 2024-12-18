
local stop = false
RegisterCommand('testezss', function()
    local ped = PlayerPedId()
    openNui(GetVehiclePedIsIn(ped, false), 'Compacts', 100)
end)
function totalzin()
    local full = 100
    return full
end

function openNui(veh, vehType, playerMoney)
    menuIsOpen = true
    stop = false
    local instParts = {}
    buyOut = nil
    if IsEntityAVehicle(veh) then
        SetVehicleEngineOn(veh, true, true, false)
        SetVehicleLights(veh,2)
        SetVehicleModKit(veh,0)        
        DisplayRadar(false)
        SendNUIMessage({ action = 'load' })
        SetNuiFocus(true, true)

        local previousWheelType = GetVehicleWheelType(veh)
        local previousWheelMod = GetVehicleMod(veh, 23)

        for index, part in pairs(partMods) do
            if stop then
                break
            end
            -- preciso parar esse load
            local haveItem
            local available = GetNumVehicleMods( veh, index )
            if itemPrices[index].item ~= false then
                haveItem = itemPrices[index].item
            else
                haveItem = true
            end
                if available > 0 then
                    table.insert(instParts, {
                        part = part.name,
                        label = part.label,
                        index = index,
                        availableMods = available,
                        img = part.img,
                        installed = GetVehicleMod(veh, index),
                        type = part.type,
                        haveItem = haveItem
                    })
                end
        end
        SendNUIMessage({ action = 'open', vehType = vehType, mods = instParts, toggle = partToogle, playerMoney = playerMoney})
        init(veh)
        local custom = src.getVehicleMods(veh)
        SetVehicleWheelType(veh, tonumber(previousWheelType))
        SetVehicleMod(veh, 23, tonumber(previousWheelMod))
    end
end

function closeNui()
    SetNuiFocus(false, false)
    menuIsOpen = false
    DisplayRadar(true)
    stop = true
    if vehSelected then
        SetVehicleDoorShut(vehSelected,0,0)
        SetVehicleDoorShut(vehSelected,1,0)
        SetVehicleDoorShut(vehSelected,4,0)
        SetVehicleDoorShut(vehSelected,5,0)
        SetVehicleEngineOn(vehSelected, false, true, false)
        SetVehicleLights(vehSelected, 0)
        RenderScriptCams(0,0,cam,0,0)
        DestroyCam(cam, true)
        SetFocusEntity(PlayerPedId())
    end
    TriggerEvent('hudOff',false)
    buyOut = nil
    local _, custom = getVehicleMods(GetVehiclePedIsIn(PlayerPedId(),false))
end

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Callbacks
----------------------------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(data, cb)
    closeNui()
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        closeNui()
    end
end)

RegisterNUICallback("changeItem", function(data, cb)
    local before = data.before
    local modType = data.type
    local veh = vehSelected
    local playerMoney = 0
    if data.value then
        local value = data.value
    end

    local part = data.part

    if modType == 'color' or modType == 'Scolor' or modType == 'smoke' or modType == 'neon' or modType == 'customcolor' or colorP == 'primary' or colorP == 'secundary' or colorP == 'extra1' or colorP == 'extra2' then
        if modType == 'color' then 
            SetVehicleCustomPrimaryColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.colour.custom.primary = {data.r,data.g,data.b}
            cb(true)
        elseif modType == 'Scolor' then
            -- print("Color Secundar1y")
            SetVehicleCustomSecondaryColour(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.colour.custom.secondary = {data.r,data.g,data.b}
            cb(true)

        elseif modType == 'smoke' then
            ToggleVehicleMod(veh, 20 , true)
            SetVehicleTyreSmokeColor(veh, tonumber(data.r), tonumber(data.g), tonumber(data.b))
            custom.smoke = true
            custom.colour.smoke = {data.r,data.g,data.b}
            cb(true)
           
        elseif modType == 'customcolor' then 
            local customColor = data.customColor
            local colorP = data.colorP
            local op = data.op
            local colorTable 
            if customColor == 'metalic' then 
                colorTable = Metalic 
            elseif customColor == 'matte' then 
                colorTable = Matte 
            elseif customColor == 'metal' then 
                colorTable = Metal 
            elseif customColor == 'smetalic' then
                colorTable = Metalic 
            elseif customColor == 'smatte' then 
                colorTable = Matte 
            elseif customColor == 'smetal' then 
                colorTable = Metal 
            elseif customColor == 'pearlescent' then 
                colorTable = Pearlescent 
            elseif customColor == 'wheel' then 
                colorTable = Wheel 
            end
            if op == '+' then
                if selectedColors[customColor] == #colorTable then
                    selectedColors[customColor] = 1
                else
                    selectedColors[customColor] = selectedColors[customColor] + 1
                end
            else
                if selectedColors[customColor] == 1 then
                    selectedColors[customColor] = #colorTable
                else
                    selectedColors[customColor] = selectedColors[customColor] - 1
                end
            end
            if colorP == 'primary' then 
                SetVehicleModKit(veh,0)
                ClearVehicleCustomPrimaryColour(veh)
                SetVehicleColours(veh, colorTable[selectedColors[customColor]].id, custom.colour.secondary)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true) 
            elseif colorP == 'secundary' then
                -- print("Color Secundary2")
                SetVehicleModKit(veh,0)
                ClearVehicleCustomSecondaryColour(veh)
                SetVehicleColours(veh, custom.colour.primary, colorTable[selectedColors[customColor]].id)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            elseif colorP == 'extra1' then
                SetVehicleModKit(veh,0)
                custom.colour.pearlescent = colorTable[selectedColors[customColor]].id
                SetVehicleExtraColours(veh,colorTable[selectedColors[customColor]].id,custom.colour.wheel)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            elseif colorP == 'extra2' then
                SetVehicleModKit(veh,0)
                custom.colour.wheel = colorTable[selectedColors[customColor]].id
                SetVehicleExtraColours(veh, custom.colour.pearlescent, colorTable[selectedColors[customColor]].id)
                SendNUIMessage({ action = 'changeColorName', cName = colorTable[selectedColors[customColor]].name, type = customColor })
                cb(true)  
            end
        end
        SendNUIMessage({ action = "update", totalPrice = 0, playerMoney = playerMoney })
    end
end)

RegisterNUICallback("changeCamera", function(data, cb)
    if data.type then
        -- print(data.type)
        if data.type  == 'color' or data.type  == 'Scolor' or data.type  == 'smoke' or data.type  == 'neon' or data.type  == 'customcolor' then
            MoveVehCam('back',0.5,-1.6,1.3)
        elseif data.type == "reset" then
            defaultCam()
        end
    end
end)

function src.updateCustoms(veh)
    _, custom = getVehicleMods(veh)
    updateColors(custom,veh)
end

function updateColors(custom,veh)
    local smokeR, smokeG, smokeB = table.unpack(custom['colour']['smoke'])
    local primaryR, primaryG, primaryB = table.unpack(custom['colour']['custom']['primary'])
    local secondaryR, secondaryG, secondaryB = table.unpack(custom['colour']['custom']['secondary'])
    SendNUIMessage({ 
        action = 'updateColors',  
        primary = {r = primaryR, g = primaryG, b = primaryB},
        secondary = {r = secondaryR, g = secondaryG, b = secondaryB},
        smoke = { r = smokeR, g = smokeG, b = smokeB}
    }) 
end

function src.updateTotalPrice(price)
    totalPrice = 0
    SendNUIMessage({ action = 'updatePrice', totalPrice = totalPrice })
end

RegisterNUICallback("acceptMod", function(data, cb)
    local valor = tonumber(data.price)
    local prices = sv.getTotal()
    if sv.updateMoney() then
        sv.savedbcar(custom)
        sv.updateOld(custom)
        local playerMoney = sv.getPlayerTotalMoney()
        SendNUIMessage({ action = "update", totalPrice = prices, playerMoney = playerMoney })
    end
end)

RegisterNUICallback("declineMod", function(data, cb)
    local prices = sv.getTotal()
    local playerMoney = sv.getPlayerTotalMoney()
    sv.savedbcar(sv.getCustoms())
    updateCar(vehSelected,sv.getCustoms())
    SendNUIMessage({ action = "update", totalPrice = prices, playerMoney = playerMoney })
end)

function updateCar(veh,saves)
    local customs = {}
    customs.colorp = saves.colour.custom.primary
    customs.colors = saves.colour.custom.secondary
    customs.smokecolor = saves.colour.smoke
    customs.tyresmoke = saves.fumaca
    customs.extracolor = {saves.colour.pearlescent,saves.colour.wheel}
    customs.wheeltype = saves.wheel
	if customs and veh then
		SetVehicleModKit(veh,0)
        if customs.colorp then
            -- print("Color Primary")
			SetVehicleCustomPrimaryColour(veh,tonumber(customs.colorp[1]),tonumber(customs.colorp[2]),tonumber(customs.colorp[3]))
		end

		if customs.extracolor then
			SetVehicleExtraColours(veh,tonumber(customs.extracolor[1]),tonumber(customs.extracolor[2]))
		end

		if customs.colors then
            -- print("Color Secundary")
            -- print("aa",customs.colors[1])
			SetVehicleCustomSecondaryColour(veh,tonumber(customs.colors[1]),tonumber(customs.colors[2]),tonumber(customs.colors[3]))
		end

		if customs.smokecolor then
			SetVehicleTyreSmokeColor(veh,tonumber(customs.smokecolor[1]),tonumber(customs.smokecolor[2]),tonumber(customs.smokecolor[3]))
		end
	end
end



