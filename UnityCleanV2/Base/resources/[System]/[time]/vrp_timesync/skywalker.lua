local Tunnel = module('vrp','lib/Tunnel')
local Proxy = module('vrp','lib/Proxy')
vRP = Proxy.getInterface('vRP')
vRPclient = Tunnel.getInterface('vRP')

misc = {}
Tunnel.bindInterface('vrp_timesync',misc)

local hours = config.startHour
local minutes = config.startMinutes
local weather = config.standardWeather

RegisterServerEvent('vrp_timesync:requestSync')
AddEventHandler('vrp_timesync:requestSync',function()
	TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
end)

-- [TIME]
RegisterCommand('time', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"admin.permissao") then
		if #args < 2 then
			TriggerClientEvent("Notify",source,"negado","Use: /time hora minuto")
			return
		end

		hours = tonumber(args[1])
		minutes = tonumber(args[2])

		if not hours or not minutes or hours < 0 or hours > 23 or minutes < 0 or minutes > 59 then
			TriggerClientEvent("Notify",source,"negado","Hora ou minuto inválido. Certifique-se de que 0 ≤ hora ≤ 23 e 0 ≤ minuto ≤ 59.",8000)
			return
		end		
		print(('Hora alterada por %s para %02d:%02d'):format(GetPlayerName(source), hours, minutes))
	end
end, false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		minutes = minutes + 1
		
		if minutes >= 60 then
			minutes = 0
			hours = hours + 1
			if hours >= 24 then
				hours = 0
			end
		end
		TriggerClientEvent('vrp_timesync:syncTimers',-1,hours,minutes)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(600000)
		weather = config.climate[math.random(1)][1]
		TriggerClientEvent('vrp_timesync:updateWeather',-1,weather)
	end
end)

RegisterCommand(config.climateCommand,function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	
	if user_id then
		if vRP.hasPermission(user_id,config.timePermission) then
			TriggerClientEvent('vrp_timesync:updateWeather',-1,args[1])
		end
	end
end)