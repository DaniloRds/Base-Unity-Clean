-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
SjR = {}
Tunnel.bindInterface("voip",SjR)
vSERVER = Tunnel.getInterface("voip")
local _info = {}
-- RADIO

local prop = nil

function SjR.Thread(callback, threadDelay)
  CreateThread(function()
      local delay = threadDelay or 0
      while true do
          delay = callback() or delay
          Wait(delay)
      end
  end)
end

function SjR.AttachObjectToBone(attachBoneObject)
  local ped = PlayerPedId()
  local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 0, -5)
  local objectEntity = CreateObject(GetHashKey(attachBoneObject.Prop), coords.x, coords.y, coords.z, true, true, true)
  SetEntityCollision(objectEntity, false, false) -- Fix Prop Colision
  AttachEntityToEntity(objectEntity, ped, GetPedBoneIndex(ped, attachBoneObject.Bone), attachBoneObject.Position[1], attachBoneObject.Position[2], attachBoneObject.Position[3],
      attachBoneObject.Rotation[1], attachBoneObject.Rotation[2], attachBoneObject.Rotation[3], false, false, false, false, 2, true)
  SetEntityAsMissionEntity(objectEntity, true, true)
  return objectEntity
end

function SjR.DeAttachObject(objectId)
  if (DoesEntityExist(objectId) and IsEntityAnObject(objectId)) then
      SetEntityAsMissionEntity(objectId, false, true)
      DetachEntity(objectId, true, true)
      DeleteObject(objectId)
  end
end

function SjR.KeyMapping(callback, commandName, description, mapper, binding, restricted)
  RegisterCommand(commandName, callback, restricted or false)
  RegisterKeyMapping(commandName, description, mapper or "keyboard", binding or "e")
end

function SjR.SendNuiMessage(functionName, functionParameters)
  SendNUIMessage({
      type = functionName,
      detail = functionParameters,
      content = functionParameters
  })
end

local function OpenRadioAnim()
  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Wait(5)
  end
  TaskPlayAnim(PlayerPedId(), "cellphone@", "cellphone_text_in", 8.0, 0.0, -1, 50, 0, 0, 0, 0)
  prop =
    SjR.AttachObjectToBone(
    {
      Bone = 28422,
      Rotation = vector3(0, 0, 0),
      Position = vector3(0, 0, 0),
      Prop = "prop_cs_hand_radio"
    }
  )
end

local function StopRadioAnim()
  if prop then
    StopAnimTask(PlayerPedId(), "cellphone@", "cellphone_text_in", -4.0)
    SjR.DeAttachObject(prop)
    prop = nil
  end
end

local function CloseRadio(_, cb)
  SjR.SendNuiMessage("setShow", false)
  SetNuiFocus(false, false)
  StopRadioAnim()
  if cb then
    cb(true)
  end
end

local function ExitRadio()
  local isInRadio = _info.radioChannel ~= nil and #_info.radioChannel > 0
  _info.radioChannel = ""
  if isInRadio then
    TriggerEvent("hud:RadioDisplay",false)
    TriggerEvent("Notify","successo","Rádio desativado.",5000)
   -- SjR.AddNotification("Alerta", "Rádio desativado.", "info")
  end
  TriggerEvent("radio:outServers")
  CloseRadio()
end

RegisterNUICallback(
  "radioConnect",
  function(frequency, cb)
    if frequency ~= nil and #frequency > 0 then
      if string.lower(frequency) ~= _info.radioChannel then
        vSERVER.activeFrequency(tostring(frequency))
        --TriggerServerEvent("voip:radioSet", tostring(frequency))
      else
        TriggerEvent("Notify","successo","Você já está ná radio" .. " " .. frequency,5000)
        --SjR.AddNotification("Atenção", "Você já está ná radio" .. " " .. frequency, "warning")
      end
    end
    cb(true)
  end
)

RegisterNUICallback("radioDisconnect", ExitRadio)

RegisterNUICallback(
  "radioVolume",
  function(volume, cb)
    _info.radioVolume = tonumber(volume or 10)
    exports["pma-voice"]:setRadioVolume(_info.radioVolume)
   -- exports.tokovoip_script:setRadioVolume(_info.radioVolume) 
    --TriggerEvent("Notify","successo","<b>Volume:</b> "..volume.."%",5000)
    cb(true)
  end,
  false
)



RegisterNUICallback("close", CloseRadio, false)


local function OpenNuiRadio()

  if vSERVER.checkRadio() then
    OpenRadioAnim()
    SjR.SendNuiMessage("setFrequenciaValue", _info.radioChannel)
    SjR.SendNuiMessage("setVolumeRadio", _info.radioVolume or 10)
    SjR.SendNuiMessage("setShow", true)
    SetNuiFocus(true, true)
  else
    TriggerEvent("Notify","successo","Você não possui um radio.</b>.",5000)
    --SjR.AddNotification("Atenção", "Você não possui um rádio", "error")
  end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFREQUENCY
-----------------------------------------------------------------------------------------------------------------------------------------
function SjR.startFrequency(frequency)
	TriggerEvent("radio:outServers")
 -- exports.tokovoip_script:addPlayerToRadio(frequency)
	exports["pma-voice"]:setRadioChannel(frequency)
	exports["pma-voice"]:setVoiceProperty('radioEnabled',true)
  _info.radioChannel = string.lower(frequency)
	TriggerEvent('hud:channel',frequency)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUTSERVERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("radio:outServers")
AddEventHandler("radio:outServers",function()
  --exports["tokovoip"]:removePlayerFromRadio(_info.radioChannel)
  exports["pma-voice"]:removePlayerFromRadio()
	exports["pma-voice"]:setVoiceProperty('radioEnabled',false)
  _info.radioChannel = nil
	--TriggerEvent('hud:channel','N.A')
end)

SjR.KeyMapping(OpenNuiRadio, "radio", "Radio", "keyboard", "F5")


RegisterCommand("volume", function (source, args, raw)
  if args ~= nil and #args > 0 then
    _info.radioVolume = tonumber(args[1])
  end
end)