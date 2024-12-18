game 'gta5'
fx_version 'adamant'
author "Hover Studio"
description 'Editado pela Unity Dev | Acesse para mais scripts e conteudos - https://discord.gg/pbT5wVp8e9'
 
ui_page "web/index.html"

shared_scripts {
    "config/config.lua"
}

client_scripts {
	'@vrp/lib/utils.lua',
	"client/client.lua"
}

server_scripts {
	'@vrp/lib/utils.lua',
	-- "server/functions.lua",
	"server/server.lua"
}

files {
	"web/**/*",
}