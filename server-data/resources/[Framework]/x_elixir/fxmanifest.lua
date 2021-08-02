description 'Amakuu and Ktoś Housing System'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
   "@_xFramework/Server/CallBack/Callback_Utils.lua",
   'config.lua',
   'client/cl_main.lua'
}

server_scripts {
   "@_xFramework/Server/CallBack/Callback_Utils.lua",
   'config.lua',
   'server/sv_main.lua',
}