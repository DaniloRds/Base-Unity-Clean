

RegisterCommand("painel", function(source, args)
    local id = args[1]
    if (id ~= nil) then
        TriggerServerEvent('five_setgroup:buscarGrupos', id)
    end
end)

RegisterNetEvent('five_setgroup:abrirAdminG')
AddEventHandler('five_setgroup:abrirAdminG',function(sgrupos, pgrupos, playerId)
    local itens = {
        pgrupos,
        sgrupos,
        playerId
    }

    SetNuiFocus(true,true)
    SendNUIMessage({
      conce = true,
      data = itens
    })
end)

RegisterNUICallback('close', function(data, cb)
  limparHTML()
end)

RegisterNUICallback('aceitar', function(data, cb)
    TriggerServerEvent("five_setgroup:aceito", data.valores, data.player)
    limparHTML()
end)

function limparHTML() 
    SetNuiFocus(false)
end