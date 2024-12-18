
fx_version 'adamant'
game 'gta5'
lua54 'yes'
author 'Unity Dev & Wn'
description 'Acesse para mais scripts e conteudos - https://discord.gg/pbT5wVp8e9'
version '2.0'
dependencies{
	'vrp',
}
ui_page 'nui/index.html'
files {
	'nui/index.html',
	'nui/*',
	'nui/jquery.js',
	'nui/images/*.jpeg',
	'nui/images/*.webp',
	'nui/images/*.png'
}
client_script {
	"@vrp/lib/utils.lua",
	"cfg/*.lua",
	"client.lua"
}
server_scripts{ 
	"@vrp/lib/utils.lua",
	"cfg/*.lua",
	"server.lua",
}
              