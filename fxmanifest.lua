fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author("Blitoka33")
description("FiveM Anticheat")
version("1.0.0")

client_script({
	"client.*",
})

server_script({
	"config/*",
	"server.lua",
})

ui_page("html/index.*")

files({
	"html/index.*",
})
