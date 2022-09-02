fx_version "adamant"
game "gta5"

-- niso-bank from eSX to vRPeX by mel0
-- CYBERLiFERP - https://discord.gg/FFtQbb3

ui_page 'web-side/index.html'

files {
    'web-side/*'
}

client_scripts {
	"@vrp/lib/utils.lua",
    "config.lua",
    "client-side/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
    "config.lua",
    "server-side/*.lua"
}