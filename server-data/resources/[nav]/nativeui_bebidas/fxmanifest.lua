fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page "nui/ui.html"
client_scripts {
	"client.lua"
}

server_scripts {
	"@_xFramework/Server/CallBack/Callback_Utils.lua",
	"server.lua"
}

files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}