fx_version 'adamant'
game 'gta5'

dependencies {
    'vrp'
}

ui_page 'nui/ui.html'

files {
    'nui/*',
    'nui/assets/*'
}

client_script {
    "cfg/config.lua",
    "@vrp/lib/utils.lua",
    "client/*"
}
server_scripts{
    "@vrp/lib/utils.lua",
    "server/saves.lua",
    "cfg/config.lua"
}
