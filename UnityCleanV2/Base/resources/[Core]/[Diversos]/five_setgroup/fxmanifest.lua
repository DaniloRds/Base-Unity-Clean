fx_version 'bodacious'
game 'gta5'

dependency 'vrp'

client_scripts {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"@vrp/lib/utils.lua",
	"client/client.lua"
}

server_scripts {
	'@vrp/lib/utils.lua',
	'server/server.lua'
}

ui_page("html/index.html")

files {
    "html/index.html",
    "html/adminescobar.js",
    "html/styles.css",
	"html/sweetalert2.all.min.js",
}