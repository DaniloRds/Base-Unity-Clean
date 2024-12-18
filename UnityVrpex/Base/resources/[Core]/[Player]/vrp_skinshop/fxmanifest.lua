fx_version 'adamant'
game 'gta5'
dependencies 'vrp'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js',
    'html/images/*',
    'html/images/**/*',
    'html/images/**/**/*',
    'html/fonts/big_noodle_titling-webfont.woff',
    'html/fonts/big_noodle_titling-webfont.woff2',
    'html/fonts/pricedown.ttf',
    'stream/*'
}

client_script {
    "@vrp/lib/utils.lua",
    "client.lua"
}

server_scripts{
    "@vrp/lib/utils.lua",
    "server.lua"
}

