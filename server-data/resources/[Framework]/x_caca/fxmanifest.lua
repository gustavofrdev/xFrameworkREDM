fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

client_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
	'config.lua',
	'functions.lua',
	'client.lua'
               
}

server_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
	'config.lua',
	'server.lua',
}
