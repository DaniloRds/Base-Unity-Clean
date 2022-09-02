-----------------------------------------------------------------------------------------------------------------------------------------
-- ITENSNOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(mode,mensagem,item)
	SendNUIMessage({ mode = mode, mensagem = mensagem, item = item })
end)