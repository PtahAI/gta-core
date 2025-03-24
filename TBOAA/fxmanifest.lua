fx_version 'cerulean'

game 'gta5'

author 'PtahAI'

description 'GTA:Core'

version '1.1.0'

client_scripts {
    'client/main.lua',
    'client/mission.lua'
}

server_scripts {
    'server/main.lua'
}

shared_scripts {
    'shared/config.lua'
}

dependencies {
    'ox_lib',
    'bob74_ipl',
    'qubit-subtitle'
}

lua54 'yes'

--loadscreen_manual_shutdown 'yes'