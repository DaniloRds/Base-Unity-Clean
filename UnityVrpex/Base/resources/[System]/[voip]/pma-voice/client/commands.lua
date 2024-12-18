Citizen.CreateThread(function()
	while true do
		local msec = 400
			for _,v in pairs(susurrando) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
				if distance <= 100 then
					msec = 3
					if distance <= v.distance then
						msec = 3
						local newMode = 1
						voiceMode = (newMode <= #Cfg.voiceModes and newMode) or 1
						local voiceModeData = Cfg.voiceModes[1]
						LocalPlayer.state:set('proximity', {
							index = voiceMode,
							distance =  voiceModeData[1],
							mode = voiceModeData[2],
						}, GetConvarInt('voice_syncData', 1) == 1)
						SendNUIMessage({
							voiceMode = voiceMode - 1
						})
						TriggerEvent('pma-voice:setTalkingMode', voiceMode)
						TriggerEvent("hud:talkingState", voiceMode)
					end
				end
			end
		Wait(msec)
	end
end)


RegisterCommand('setvoiceintent', function(source, args)
	if GetConvarInt('voice_allowSetIntent', 1) == 1 then
		local intent = args[1]
		if intent == 'speech' then
			MumbleSetAudioInputIntent(GetHashKey('speech'))
		elseif intent == 'music' then
			MumbleSetAudioInputIntent(GetHashKey('music'))
		end
	end
end)

local playerMuted = false
RegisterCommand('cycleproximity', function()
	if GetConvarInt('voice_enableProximity', 1) ~= 1 then return end
	if playerMuted then return end
	local voiceMode = mode
	local newMode = voiceMode + 1
	voiceMode = (newMode <= #Cfg.voiceModes and newMode) or 1
	local voiceModeData = Cfg.voiceModes[voiceMode]
	MumbleSetAudioInputDistance(voiceModeData[1] + 0.0)
	mode = voiceMode
	LocalPlayer.state:set('proximity', {
		index = voiceMode,
		distance =  voiceModeData[1],
		mode = voiceModeData[2],
	}, GetConvarInt('voice_syncData', 1) == 1)
	-- make sure we update the UI to the latest voice mode
	SendNUIMessage({
		voiceMode = voiceMode - 1
	})
	TriggerEvent('pma-voice:setTalkingMode', voiceMode)
	TriggerEvent("hud:talkingState", voiceMode)
end, false)
--RegisterKeyMapping('cycleproximity', 'Cycle Proximity', 'keyboard', GetConvar('voice_defaultCycle', 'HOME'))
RegisterKeyMapping('cycleproximity', 'Cycle Proximity', 'keyboard', 'HOME')


function MutePlayer() 
	playerMuted = true
	LocalPlayer.state:set('proximity', {
		index = 0,
		distance = 0.1,
		mode = 'Muted',
	}, GetConvarInt('voice_syncData', 1) == 1)
	MumbleSetAudioInputDistance(0.1)
end
exports('MutePlayer', MutePlayer)
RegisterNetEvent('pma-voice:MutePlayer', MutePlayer)

function DesmutePlayer() 
	playerMuted = false
	local voiceModeData = Cfg.voiceModes[mode]
	LocalPlayer.state:set('proximity', {
		index = mode,
		distance =  voiceModeData[1],
		mode = voiceModeData[2],
	}, GetConvarInt('voice_syncData', 1) == 1)
	MumbleSetAudioInputDistance(Cfg.voiceModes[mode][1])
end
exports('DesmutePlayer', DesmutePlayer)
RegisterNetEvent('pma-voice:DesmutePlayer', DesmutePlayer)