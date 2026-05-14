fx_version 'cerulean'
game 'gta5'

author "HKN Work's"
description 'Hkn Cinematic Welcome & Intro Experience'
version '1.0.0'
lua54 'yes'

ui_page 'html/index.html'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/updates.lua',
    'server/main.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

escrow_ignore {
    "config.lua"
}

dependency '/assetpacks'