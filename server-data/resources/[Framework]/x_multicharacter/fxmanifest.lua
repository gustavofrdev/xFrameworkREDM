fx_version 'adamant'
game 'common'

server_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "backend/backend-s/*.lua",
}
client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "backend/backend-c/*.lua",
}
ui_page "frontend-html/index.html"
files {
        "frontend-html/css/plugins.css",
        "frontend-html/css/style.css",
        "frontend-html/img/effects/film-grain.gif",
        "frontend-html/js/plugins.js",
        "frontend-html/js/rexbel.js",
        "frontend-html/index.html",
        "frontend-html/logo.png"
}