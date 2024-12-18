config = {}

-- utilize os icones disponiveis em > https://fonts.google.com/icons

config['myID'] = { -- abrir ID pessoal
    ['command'] = 'vermeuid', -- comando a ser usado no chat
    ['button'] = 'F11' -- botão para keybind
}

config['sing'] = "admin.permissao" -- permissao para trocar a assinatura

config['otherID'] = { -- abrir ID de outra pessoa
    ['permission'] = "admin.permissao", -- deixe falso caso não precise, ou insira a permissão
    ['command'] = 'passaporte'
}

config['webhook'] = "https://discord.com/api/webhooks/1291881022157488239/mHJiTenv3gyWpebLRHhuTQjn19tgiDvgTcIHi4EabqeZ1X1imFrEbKqZQJQAHgV50Sys"

config['types'] = {
    ['policia.permissao'] = {
        ['mainColor'] = '#939effe3', -- Utilize somente cores em HEX
        ['gradientColor'] = '#000026', -- Utilize somente cores em HEX
        ['icon'] = 'local_police' 
    },
    ['hospital.permissao'] = {
        ['mainColor'] = '#ff9398e3', -- Utilize somente cores em HEX
        ['gradientColor'] = '#30000f', -- Utilize somente cores em HEX
        ['icon'] = 'favorite_border' 
    },
    ['mecanico.permissao'] = {
        ['mainColor'] = '#ffe693e3', -- Utilize somente cores em HEX
        ['gradientColor'] = '#2e2500', -- Utilize somente cores em HEX
        ['icon'] = 'construction' 
    },
    ['justica.permissao'] = {
        ['mainColor'] = '#ffe693e3', -- Utilize somente cores em HEX
        ['gradientColor'] = '#2e2500', -- Utilize somente cores em HEX
        ['icon'] = 'gavel' 
    },
}

config['default'] = {
    ['mainColor'] = '#ffffffea', -- Utilize somente cores em HEX
    ['gradientColor'] = '#2e2e2e', -- Utilize somente cores em HEX
    ['icon'] = 'person' 
}

config['needItem'] = false -- checa se precisa de algum item para usar a ID, defina os items em functions.lua

config['item'] = false -- checa se precisa de algum item para usar a ID, defina os items em functions.lua