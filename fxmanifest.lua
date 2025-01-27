fx_version 'cerulean'
game 'gta5'

author 'ProxyFile'
description 'A simple money washing system'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua',
    'config.lua'
}

server_scripts {
    'server/main.lua',
    'sv_config.lua',
    'config.lua'
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/app.js',
    'html/style.css',
    'html/jquery-3.7.1.min.js',
    'html/assets/*'
}

escrow_ignore {
    'config.lua'
}
