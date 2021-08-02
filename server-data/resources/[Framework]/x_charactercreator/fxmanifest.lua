fx_version 'adamant'
game 'common'

server_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
    "backend/backend-s/*.lua",
}
client_scripts {
    "@_xFramework/Server/CallBack/Callback_Utils.lua",
	"backend/backend-rdr2-adaptations/*.lua",
    "backend/backend-c/*.lua",
}
ui_page "frontend-html/html/create-character.html"
files {
	"frontend-html/*",
	"frontend-html/fonts/typography/*",
	"frontend-html/fonts/icons/*",
	"frontend-html/html/*",
	"frontend-html/scripts/*",
	"frontend-html/styles/*"
}
