-- Resource Metadata
fx_version 'adamant'
game 'common'

author 'SuperCoolNinja'
description 'Experimented html stuff a simple notification.'
version '1.2.0'

client_scripts {
    "client/client_sounds.lua",
    "client/client_notification.lua",
    "example.lua", --To use it dont forgot to remove the --
}

server_scripts { 
    "server/server_sounds.lua",
    "server_example.lua" --To use it dont forgot to remove the --
} 

ui_page "html/index.html"
files {
    "html/index.html",
    "html/script.js",
    "html/style.css",
    "html/sounds/*.ogg" --> all sounds need to be on .ogg
}

export 'GTA_NUI_ShowNotification'