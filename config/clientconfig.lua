-- BLTK_ANTICHEAT V5

ClientConfig = {}
-- [[READ THIS!]]
-- [[Always configure your anticheat properly, a bad configuration can cause false positives, and ban innocent players.]]

ClientConfig.Blocks = { -- Some functions that are not detectable, but blockable
	AntiVehicleFly = true, -- I would recommend to turn this on
}

ClientConfig.AntiPlateChanger = true
ClientConfig.DisableNUIDevtools = true
ClientConfig.AntiNUIDevtools = true
ClientConfig.AntiNUIDevtoolsKick = true
ClientConfig.AntiNUIDevtoolsBan = true
ClientConfig.MenuChecks = true -- Menucheck system
ClientConfig.MenuCheckDelay = 10000 -- Menucheck repeat delay in ms, lower numbers are more efficient, but they are causing more lag.
ClientConfig.MenuCheckKick = true -- Kick players, if menucheck catch cheaters.
ClientConfig.MenuCheckBan = true -- Ban players, if menucheck catch cheaters.
ClientConfig.AntiGodMode = false -- This can cause problems on a few frameworks. Usually works fine with ESX.
ClientConfig.MaxHealth = 200 -- Max player health, usually 200.
ClientConfig.AntiSemiGodMode = true -- That's a better option for detecting godmode, more reliable etc...
ClientConfig.AntiSpectate = true -- This will detect spectating players.
ClientConfig.BlackListWeaponChecks = true -- Weapon blacklist system
ClientConfig.BlackListWeaponList = { -- Blacklisted Weapons
	"WEAPON_RPG",
	"WEAPON_FIREWORK",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_MINIGUN",
	"WEAPON_RAILGUN",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_RAYMINIGUN",
}
ClientConfig.NoNPC = false -- Turn this on, if you have a NoNPC server. This function will delete ALL UNKNOWN ped.
ClientConfig.TxdMenu = true -- This will detect some textured mod menu.
ClientConfig.AntiSuperJump = true -- Blocks superjump functions
ClientConfig.ThermalVision = false -- This will detect thermal vision if the player is not in any helicopter.
ClientConfig.NightVision = false -- This will detect night vision.
ClientConfig.AntiFreeCam = false -- Anti Freecam system, that can be useful against entity spawner scripts.
ClientConfig.FreecamLimit = 200 -- Freecam distance limit, 100 is a good starting point, but if you get false bans with this, you should increase this number
ClientConfig.MaxArmor = 200 -- Max armor (usually 100)
ClientConfig.AntiInvisible = false -- It may not work correctly on some servers.
ClientConfig.SpeedHack = true -- It may not work correctly on some servers.
ClientConfig.AntiExplosiveBullets = false -- Blocks explosive bullets
ClientConfig.Noclip = false -- AntiNoclip, this may not work correctly on some servers, test it out yourself.
ClientConfig.Teleport = true -- Blocks teleport/noclip methods, detects abnormal position changes
ClientConfig.TeleportDistance = 2000 -- Teleport distance, 50 is a good starting point
ClientConfig.AntiWeaponDamageChanger = true -- AntiWeaponDamageModifier, please note that this can fuck up with some servers.
ClientConfig.Styles = true -- I would recommend you to turn this on, this will catch a few mod menus.
ClientConfig.AntiVehicleCheats = true -- Blocks vehicle modifiers
ClientConfig.AntiAFKBypass = true -- Detects if someone is trying to bypass Anti AFK systems.

ClientConfig.InjectDetect = true -- Client-side anti injector system
ClientConfig.ClientResourceStuff = true -- If you enabled one of these functions under the ClientResourceStuff section, Some of these functions doesn't support script restarting.
ClientConfig.InjectKick = true -- Kick players, if injection system catch cheaters.
ClientConfig.InjectCheckBan = true -- Ban players, if injection system catch cheaters.
ClientConfig.ResourceLookup = true -- This will lookup client resources, and can detect some light and free crap executors.
ClientConfig.CommandChecker = true -- This will catch new client sided commands, that can be really useful, if someone wants to inject a menu with commands.
ClientConfig.ResourceChecker = true -- This will check the number of resources.
ClientConfig.AntiResourceRestart = false -- (Really useful) Can detect some executors. DON'T STOP RESTART OR START SCRIPTS IF YOU ENABLED THIS.
ClientConfig.AntiResourceStopper = false -- Detects if a cheater is trying to stop client-side of OTHER resources.
ClientConfig.ResNameCheck = true -- E***n checker, make sure your resource names does not contains more than 17 character.
ClientConfig.AntiUnisolatedResInjection = false -- Rally useful, but on heavily loaded servers it can be laggy, don't use if you have more than 80 players.
ClientConfig.EMD = true -- Enhanced Menu Detection. One of the most advanced anti injection systems. Use bltkemd to install and bltkemdun to uninstall EMD.

ClientConfig.AI = false -- Screen analyzer AI (REQUIRES SCREENSHOT-BASIC)
ClientConfig.OnButtons = false -- Checks screen on DELETE & INSERT button

ClientConfig.PedChecks = true -- This will check ped manipulations.
ClientConfig.PedKick = true
ClientConfig.PedBan = true
ClientConfig.UserPedCheckMS = true -- Master switch for the blacklisted ped system.
ClientConfig.UserPedChecks = { -- This is a blacklisted ped system.
	"g_m_m_chemwork_01",
	"s_m_y_swat_01",
	"u_m_y_zombie_01",
}

ClientConfig.ClientTriggers = true -- Client trigger protection system
ClientConfig.ClientTriggerKick = true
ClientConfig.ClientTriggerBan = true
ClientConfig.ClientTriggerList = {
	"ambulancier:selfRespawn",
	"esx-qalle-jail:openJailMenu",
	"esx_jailer:wysylandoo",
	"esx:spawnVehicle",
	--"esx_status:set",
	"bank:transfer",
	"HCheat:TempDisableDetection",
	"UnJP"
}

ClientConfig.AntiSpawn = true -- Blocks entity spawns (very useful) anti vehicle, ped, prop spawn.
ClientConfig.AntiSpawnKick = true
ClientConfig.AntiSpawnBan = true

ClientConfig.BlacklistedCommand = true
ClientConfig.BlacklistedCommandKick = true
ClientConfig.BlacklistedCommandBan = true
ClientConfig.BlacklistedCommands = {
    "killmenu",
    "ssssss",
    "brutan",
    "brutanpremium",
    "hammafia",
	"purgemenu",
    "hamhaxia",
    "redstonia",
    "hoax",
    "desudo",
    "jd",
    "ham",
    "lua options",
    "God Mode",
    "Maestro",
    "FunCtionOk",
    "lynx9_fixed",
    "Fucked",
	"injected",
	"vRP",
	"deleted due to u being a nigger",
	"Dopamine injected successfully",
    "parent menu doesn",
    "www.d0pamine.xyz",
    "d0pamine v1.1 by Nertigel",
	"d0pamine",
	"lynx",
	"FOriv gay",
	"TiagoModz#1478",
	"WarMenu",
	"tiago",
	"TiagoModz",
	"dopamine",
	"dopamina",
	"Nertigel: This server is protected and the menu is not gonna work here.",
	"Information",
	"KP",
	"opk",
	"jolmany",
    "SovietH4X",
	"Desudo",
	"Brutan",
	"EulenCheats",
	"Lynx 8",
	"www.lynxmenu.com",
	"HamHaxia",
	"Ham Mafia",
	"köcsög",
	"kocsog",
	"anyad",
	"genyó",
	"geci",
	"szar",
	"kurva",
	"anyád",
	"lynxmenu.com",
	"Anti-Lynx",
	"Baran#8992",
	"iLostName#7138",
	"Melon#1379",
	"hammafia.com",
	"AlphaV ~ 5391",
	"vjuton.pl",
	"Soviet Bear",
	"MARVIN menu",
	"Alpha Menu",
	"Tiafall",
	"KoGuSzEk#3251",
}
