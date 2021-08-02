fx_version 'adamant'
game 'common'

ui_page_preload "yes"
ui_page "frontend_html/index.html"

client_scripts {
  "@_xFramework/Server/CallBack/Callback_Utils.lua",
  "backend_c/*"
}

server_scripts {
  "@_xFramework/Server/CallBack/Callback_Utils.lua",
  "backend_s/*"
}

files {
  "frontend_html/*",
  "frontend_html/**/*"
}