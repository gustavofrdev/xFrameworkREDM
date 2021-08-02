fx_version 'adamant'
game 'common'

-- HYML
ui_page "html/index.html"

server_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "backend_s/server.lua"

}
client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "backend_c/client.lua",
    "backend_c/locais.lua"
}

files {
    "html/*.html",
    "html/*.js",
    "html/*.css",
    "html/assets/*.png"
}