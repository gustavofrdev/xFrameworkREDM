client_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

fx_version 'adamant'
game 'common'

ui_page 'html/index.html'

client_scripts{
  "@_xFramework/Server/CallBack/Callback_Utils.lua",
 'cl_chat.lua'
}
server_scripts{
  "@_xFramework/Server/CallBack/Callback_Utils.lua",
  'sv_chat.lua'
}

files {
    'html/index.html',
    'html/index.css',
    'html/fontawesome.css',
    'html/config.default.js',
    'html/config.js',
    'html/App.js',
    --Doublox#9803---
    'html/Message.js',
    'html/Suggestions.js',
    'html/vendor/vue.2.3.3.min.js',
    'html/vendor/flexboxgrid.6.3.1.min.css',
    'html/vendor/animate.3.5.2.min.css',
    'html/vendor/latofonts.css',
    'html/vendor/fonts/LatoRegular.woff2',
    'html/vendor/fonts/LatoRegular2.woff2',
    'html/vendor/fonts/LatoLight2.woff2',
    'html/vendor/fonts/LatoLight.woff2',
    'html/vendor/fonts/LatoBold.woff2',
    'html/vendor/fonts/LatoBold2.woff2',
  }
