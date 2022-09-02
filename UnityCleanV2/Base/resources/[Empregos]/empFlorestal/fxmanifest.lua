fx_version 'bodacious'
game 'gta5'

ui_page 'nui/index.html'

client_scripts {
	'@vrp/lib/utils.lua',
	'client.lua',
	'cfg/config.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server.lua',
	'cfg/config.lua'
}

files {
	'nui/index.html',
	'nui/ui.js',
    'nui/style.css',
	'nui/img/*.png',
}