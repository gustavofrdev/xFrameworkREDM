game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts{
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
     'RCPMenu.lua'
}
server_scripts{
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "server.lua"
}

ui_page 'RCPMenu.html'

files {
    'RCPMenu.html', 
    "CHINESER.TTF"
}