-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local hoverCoords = {}
local hoverNumbers = 0
local hoverLocates = {}
local hoverInsert = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- GRIDCHUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function gridChunk(x)
	return math.floor((x + 8192) / 128)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOCHANNEL
-----------------------------------------------------------------------------------------------------------------------------------------
function toChannel(v)
	return (v["x"] << 8) | v["y"]
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETGRIDZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function getGridzone(x,y)
	local gridChunk = vector2(gridChunk(x),gridChunk(y))
	return toChannel(gridChunk)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		-- if not IsPedInAnyVehicle(ped) then
			if not hoverInsert then
				local coords = GetEntityCoords(ped)
				local gridZone = getGridzone(coords["x"],coords["y"])

				if hoverLocates[gridZone] then
					for k,v in pairs(hoverLocates[gridZone]) do
						local distance = #(coords - vector3(v["x"],v["y"],v["z"]))
						if distance < v["distance"] then
							SendNUIMessage({ show = true, key = v["key"], title = v["title"], legend = v["legend"] })
							hoverCoords = { v["x"],v["y"],v["z"],v["distance"] }
							hoverInsert = true
						end
					end
				end
			end
		-- end

		if hoverInsert then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(hoverCoords[1],hoverCoords[2],hoverCoords[3]))
			if distance > hoverCoords[4] then
				SendNUIMessage({ show = false })
				hoverInsert = false
				timeDistance = 100
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOVERFY:INSERTTABLE
-- 	TriggerEvent("hoverfy:insertTable",{{ 254.01,225.21,101.87, 1.5, "E","Porta do Cofre","Pressione para abrir/fechar" }})
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hoverfy:insertTable")
AddEventHandler("hoverfy:insertTable",function(innerTable)
	for k,v in pairs(innerTable) do
		local gridZone = getGridzone(v[1],v[2])

		if hoverLocates[gridZone] == nil then
			hoverLocates[gridZone] = {}
		end

		hoverNumbers = hoverNumbers + 1
		hoverLocates[gridZone][hoverNumbers] = { x = v[1], y = v[2], z = v[3], distance = v[4], key = v[5], title = v[6], legend = v[7] }
	end
end)

RegisterNetEvent("hoverfy:hidden")
AddEventHandler("hoverfy:hidden",function(bool)
	SendNUIMessage({ show = false })
	-- hoverInsert = true
end)