resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "gui/index.html"

server_scripts { 
	"lib/utils.lua",
	"base.lua",
	"queue.lua",
	"modules/gui.lua",
	"modules/group.lua",
	"modules/player_state.lua",
	"modules/business.lua",
	"modules/map.lua",
	"modules/money.lua",
	"modules/inventory.lua",
	"modules/identity.lua", 
	"modules/survival.lua",
	"modules/vips.lua",
	--"modules/home.lua",
	--"modules/home_components.lua",
	"modules/aptitude.lua",
	"modules/basic_items.lua",
	"modules/basic_skinshop.lua",
	"modules/cloakroom.lua"
}

client_scripts {
	"lib/utils.lua",
	"client/base.lua",
	"client/basic_garage.lua",
	"client/iplloader.lua",
	"client/gui.lua",
	"client/player_state.lua",
	"client/survival.lua",
	"client/map.lua",
	"client/notify.lua",
	"client/identity.lua",
	"client/police.lua"
}

files {
	"loading/index.html",	
    'loading/assets/js/ui.js',
    'loading/assets/img/allstar-loadingscreen.png',
    'loading/assets/img/background.png',
    'loading/assets/fonts/BebasNeue.otf',
    'loading/assets/fonts/BebasNeue.ttf',
    'loading/assets/css/style.css',
    'loading/index.js',
    'loading/musi.mp3',
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Luaseq.lua",
	"lib/Tools.lua",
	"gui/index.html",
	"gui/design.css",
	"gui/main.js",
	"gui/Menu.js",
	"gui/WPrompt.js",
	"gui/RequestManager.js",
	"gui/Div.js",
	"gui/dynamic_classes.js",
	"gui/bebas.ttf"
}

loadscreen "loading/index.html"

-- server_export "AddPriority"
-- server_export "RemovePriority"