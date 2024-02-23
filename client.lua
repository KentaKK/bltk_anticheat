SCWHURL = nil
local t = 0

TriggerServerEvent("237462384623874632874682346")
RegisterNetEvent("loadfullclient_68347623", function(config)
	ClientConfig = config
	if not ClientConfig then
		TriggerServerEvent("237462384623874632874682346")
        t += 1
		Wait(2000)
		if not ClientConfig then return print("Failed to load client config for "..t.." time") end
	else
		local function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
			local nearbyEntities = {}
			if coords then
				coords = vector3(coords.x, coords.y, coords.z)
			else
				local playerPed = PlayerPedId()
				coords = GetEntityCoords(playerPed)
			end
			for k,entity in pairs(entities) do
				local distance = #(coords - GetEntityCoords(entity))
				if distance <= maxDistance then
					nearbyEntities[#nearbyEntities + 1] = isPlayerEntities and k or entity
				end
			end
			return nearbyEntities
		end
		function BltkGetVehiclesInArea(coords, maxDistance)
			return EnumerateEntitiesWithinDistance(GetGamePool('CVehicle'), false, coords, maxDistance)
		end
		AddEventHandler("playerSpawned", function()
			Wait(5000)
			OldUserCommands4u6 = #GetRegisteredCommands()
			ResourceCount = GetNumResources()
		end)
		RegisterNetEvent("excuseme", function()
			while true do
			end
		end)
		if ClientConfig.ClientTriggers then
			for _, cliev in pairs(ClientConfig.ClientTriggerList) do
				RegisterNetEvent(cliev, function()
					TriggerServerEvent(
						"bltk_anticheat:server:detection",
						"Client Trigger",
						"Client-side trigger used\n**Trigger:** `" .. cliev .. "`",
						ClientConfig.ClientTriggerKick,
						ClientConfig.ClientTriggerBan
					)
				end)
			end
		end
		if ClientConfig.MenuChecks then
			CreateThread(function()
				Wait(20000)
				while true do
					Wait(ClientConfig.MenuCheckDelay)
					if ClientConfig.AntiGodMode then
						if GetPlayerInvincible(PlayerId()) then
							Wait(50000)
							if GetPlayerInvincible(PlayerId()) then
							    TriggerServerEvent(
								    "bltk_anticheat:server:detection",
								    "MenuCheck GodMode",
								    "This player tried to use GodMode.",
								    ClientConfig.MenuCheckKick,
								    ClientConfig.MenuCheckBan
							    )
						    end
						end
					end
					if GetEntityHealth(PlayerPedId()) > ClientConfig.MaxHealth then
						TriggerServerEvent(
							"bltk_anticheat:server:detection",
							"MenuCheck HealthGodMode",
							"This player tried to use Health GodMode.",
							ClientConfig.MenuCheckKick,
							ClientConfig.MenuCheckBan
						)
					end
					if ClientConfig.AntiExplosiveBullets then
						local weapondmg = GetWeaponDamageType(GetSelectedPedWeapon(PlayerPedId()))
						if weapondmg == 4 or weapondmg == 5 or weapondmg == 6 or weapondmg == 13 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck AntiExplosiveWeapons",
								"This player tried to use an explosive weapon.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.Noclip then
						local ped = PlayerPedId()
						if
							GetEntityHeightAboveGround(ped) > 100
							and not IsPedInAnyVehicle(ped, false)
							and not IsPedFalling(ped)
							and not IsPedSwimming(ped)
							and not IsPedFleeing(ped)
							and not IsPedJumpingOutOfVehicle(ped)
							and not IsPedInParachuteFreeFall(ped)
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Noclip",
								"This player tried to fly with noclip.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.AntiWeaponDamageChanger then
						local ply = PlayerId()
						if GetPlayerMeleeWeaponDefenseModifier(ply) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetPlayerWeaponDamageModifier(ply) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetPlayerMeleeWeaponDamageModifier(ply) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetPlayerWeaponDefenseModifier(ply) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetWeaponDamageModifier(GetSelectedPedWeapon(PlayerPedId())) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetPlayerWeaponDefenseModifier_2(ply) > 1.0 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Menucheck WeaponDamage",
								"This player modified his weapon damage.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.AntiSpectate then
						if NetworkIsInSpectatorMode() then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Spectate",
								"This player tried to spectate another player.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.BlackListWeaponChecks then
						for _, v in pairs(ClientConfig.BlackListWeaponList) do
							if joaat(v) == GetSelectedPedWeapon(PlayerPedId()) then
								TriggerServerEvent(
									"bltk_anticheat:server:detection",
									"MenuCheck Weapons",
									"This player tried to use a blacklisted weapon.\n**Weapon:** `"
										.. v
										.. "`"
										.. "\n**Weapon Hash:** `"
										.. joaat(v)
										.. "`",
									ClientConfig.MenuCheckKick,
									ClientConfig.MenuCheckBan
								)
							end
						end
					end
					if ClientConfig.NoNPC then
						for _, ped in pairs(GetGamePool("CPed")) do
							if DoesEntityExist(ped) and not (IsPedAPlayer(ped)) then
								--if not IsEntityAMissionEntity(ped) then
								SetEntityAsMissionEntity(ped, false, false)
								DeleteEntity(ped)
								--end
							end
						end
					end
					if ClientConfig.AntiFreeCam then
						local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()) - GetFinalRenderedCamCoord())
						if
							(x > ClientConfig.FreecamLimit)
							or (y > ClientConfig.FreecamLimit)
							or (z > ClientConfig.FreecamLimit)
							or (x < -ClientConfig.FreecamLimit)
							or (y < -ClientConfig.FreecamLimit)
							or (z < -ClientConfig.FreecamLimit)
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Freecam",
								"This player tried to use Freecam.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.ThermalVision then
						if GetUsingseethrough() then
							if not IsPedInAnyHeli(PlayerPedId()) then
								TriggerServerEvent(
									"bltk_anticheat:server:detection",
									"MenuCheck Visions",
									"ThermalVision detected.",
									ClientConfig.MenuCheckKick,
									ClientConfig.MenuCheckBan
								)
							end
						end
					end
					if ClientConfig.MaxArmor then
						if GetPedArmour(PlayerPedId()) > ClientConfig.MaxArmor then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Armor",
								"This player tried to exceed the armor limit.\n**Player armor:** `"
									.. GetPedArmour(PlayerPedId())
									.. "`\n**Max Armor:** `"
									.. ClientConfig.MaxArmor
									.. "`",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.UserPedCheckMS then
						for _, ATMPedModel in pairs(ClientConfig.UserPedChecks) do
							if IsPedModel(PlayerPedId(), ATMPedModel) then
								TriggerServerEvent(
									"bltk_anticheat:server:detection",
									"MenuCheck Ped Check",
									"This player tried to use a blacklisted ped.\n**Ped:** `"
										.. ATMPedModel
										.. "`\n**Ped hash:** `"
										.. joaat(ATMPedModel)
										.. "`",
									ClientConfig.MenuCheckKick,
									ClientConfig.MenuCheckBan
								)
							end
						end
					end
					if ClientConfig.NightVision then
						if GetUsingnightvision() then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Visions",
								"NightVision detected.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.AntiInvisible then
						if GetEntityAlpha(PlayerPedId()) <= 150 or not IsEntityVisible(PlayerPedId()) then
							Wait(20000)
							if GetEntityAlpha(PlayerPedId()) <= 150 or not IsEntityVisible(PlayerPedId()) then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Invisibility",
								"This player tried to become invisible.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						    end
						end
					end
					if ClientConfig.TxdMenu then
						local DetectableTextures = {
							{ texture = "HydroMenu", texturetitle = "HydroMenuHeader", modmenu = "Hydro Menu" },
							{ texture = "John", texturetitle = "John2", modmenu = "Sugar Mods" },
							{ texture = "darkside", texturetitle = "logo", modmenu = "Dopex Mod Menu" },
							{ texture = "fm", texturetitle = "menu_bg", modmenu = "Fallout Menu" },
							{ texture = "wave", texturetitle = "logo", modmenu = "Wave" },
							{ texture = "wave1", texturetitle = "logo1", modmenu = "AltWave" },
							{ texture = "meow2", texturetitle = "woof2", modmenu = "Alokas66", x = 1000, y = 1000 },
							{
								texture = "adb831a7fdd83d_Guest_d1e2a309ce7591dff86",
								texturetitle = "adb831a7fdd83d_Guest_d1e2a309ce7591dff8Header6",
								modmenu = "Guestrian Menu",
							},
							{
								texture = "hugev_gif_DSGUHSDGISDG",
								texturetitle = "duiTex_DSIOGJSDG",
								modmenu = "HugeV",
							},
							{ texture = "ISMMENU", texturetitle = "ISMMENUHeader", modmenu = "ISMMENU" },
							{ texture = "dopatest", texturetitle = "duiTex", modmenu = "DopaMine" },
							{ texture = "MM", texturetitle = "menu_bg", modmenu = "MetrixFallout" },
							{ texture = "wm", texturetitle = "wm2", modmenu = "WM" },
						}

						for _, data in pairs(DetectableTextures) do
							if data.x and data.y then
								if
									GetTextureResolution(data.texture, data.texturetitle).x == data.x
									and GetTextureResolution(data.texture, data.texturetitle).y == data.y
								then
									TriggerServerEvent(
										"bltk_anticheat:server:detection",
										"MenuCheck Textures",
										"This player tried to inject a textured menu.\n**Mod Menu:** `"
											.. data.modmenu
											.. "`",
										ClientConfig.MenuCheckKick,
										ClientConfig.MenuCheckBan
									)
								end
							else
								if GetTextureResolution(data.texture, data.texturetitle).x ~= 4.0 then
									TriggerServerEvent(
										"bltk_anticheat:server:detection",
										"MenuCheck Textures",
										"This player tried to inject a textured menu.\n**Mod Menu:** `"
											.. data.modmenu
											.. "`",
										ClientConfig.MenuCheckKick,
										ClientConfig.MenuCheckBan
									)
								end
							end
						end
					end
					if ClientConfig.SpeedHack then
						local vehicleid = BltkGetVehiclesInArea(GetEntityCoords(PlayerPedId()), 10) -- GOOD STUFF
						local nearvehs = json.encode(vehicleid)
						local ped = PlayerPedId()
						if
							not IsPedInAnyVehicle(ped, true)
							and GetEntitySpeed(ped) > 10
							and not IsPedFalling(ped)
							and not IsPedInParachuteFreeFall(ped)
							and not IsPedJumpingOutOfVehicle(ped)
							and not IsPedRagdoll(ped)
							and nearvehs == "[]"
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck SpeedHack",
								"This player tried to use a speedhack script.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.AntiSuperJump then
						if IsPedJumping(PlayerPedId()) then
							TriggerServerEvent("bltk:clienttoserver:72813618768432576", GetPlayerServerId(PlayerId()))
						end
					end
					if ClientConfig.AntiAFKBypass then
						local ped = PlayerPedId()
						if
							GetIsTaskActive(ped, 100)
							or GetIsTaskActive(ped, 101)
							or GetIsTaskActive(ped, 151)
							or GetIsTaskActive(ped, 221)
							or GetIsTaskActive(ped, 222)
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck AntiAFK Bypass",
								"This player tried to bypass AntiAFK.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.Styles then
						if
							HasStreamedTextureDictLoaded("fm")
							or HasStreamedTextureDictLoaded("rampage_tr_main")
							or HasStreamedTextureDictLoaded("MenyooExtras")
							or HasStreamedTextureDictLoaded("NUI_DevTools")
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Styles",
								"Mennyoo/Rampage based menu detected.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if
							HasStreamedTextureDictLoaded("shopui_title_graphics_franklin")
							or HasStreamedTextureDictLoaded("deadline")
						then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Styles",
								"Dopamine based menu detected.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if HasStreamedTextureDictLoaded("cockmenuuu") then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Styles",
								"CockMenu based menu detected.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
					if ClientConfig.AntiSemiGodMode then
						local bull, fire, expl, coll, steam, p7, dr = GetEntityProofs(PlayerPedId())
						if
							bull
							and fire
							and expl
							and coll
							and steam
							and p7
							and dr
						then
							Wait(30000)
							local bul, fir, exp, col, stea, p, d = GetEntityProofs(PlayerPedId())
							if
								bul
								and fir
								and exp
								and col
								and stea
								and p
								and d
							then
							    TriggerServerEvent(
								    "bltk_anticheat:server:detection",
								    "MenuCheck SemiGodMode",
								    "This player tried to use godmode with semi.",
								    ClientConfig.MenuCheckKick,
								    ClientConfig.MenuCheckBan
							    )
						    end
						end
						if GetPlayerInvincible(PlayerId()) and GetPlayerInvincible_2(PlayerId()) and not GetEntityCanBeDamaged(PlayerPedId()) then
							Wait(30000)
							if GetPlayerInvincible(PlayerId()) and GetPlayerInvincible_2(PlayerId()) and not GetEntityCanBeDamaged(PlayerPedId()) then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck SemiGodMode",
								"This player tried to use godmode with invincible.",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						    end
						end
					end
				end
			end)
		end
		local function IsolationCheck()
			local resourceList = {}
			for i = 0, GetNumResources() - 1 do
				resourceList[i + 1] = GetResourceByFindIndex(i)
			end
			TriggerServerEvent("bltkac_isolationservercheck", resourceList)
		end
		TriggerServerEvent("bltk:read:screenshotstorage")

		RegisterNetEvent("bltk:screenshotstorage", function(sslink)
			if ClientConfig.AI then
				if ClientConfig.OnButtons then
					CreateThread(function()
						Wait(500)
						while true do
							Wait(0)
							if IsControlJustReleased(0, 121) or IsDisabledControlJustReleased(0, 121) then
								exports["screenshot-basic"]:requestScreenshotUpload(sslink, "files[]", function(data)
									local resp = json.decode(data)
									if resp then
										if resp.attachments then
											local ssdata = resp.attachments[1].url
											SendNUIMessage({
												type = "ai",
												screenshoturl = ssdata,
											})
										else
											print("Screenshot ERROR!")
										end
									end
								end)
							end
							if IsControlJustReleased(0, 214) or IsDisabledControlJustReleased(0, 214) then
								exports["screenshot-basic"]:requestScreenshotUpload(sslink, "files[]", function(data)
									local resp = json.decode(data)
									if resp.attachments then
										local ssdata = resp.attachments[1].url
										SendNUIMessage({
											type = "ai",
											screenshoturl = ssdata,
										})
									else
										print("Screenshot ERROR!")
									end
								end)
							end
						end
					end)
				end
			end
		end)
		RegisterNetEvent("bltkac:antinuke:clearvehicles")
		AddEventHandler("bltkac:antinuke:clearvehicles", function(vehicles)
			if not vehicles then
				local poolvehlist = GetGamePool("CVehicle")
				for _, vehicle in ipairs(poolvehlist) do
					if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
						if NetworkGetEntityIsNetworked(vehicle) then
							SetEntityAsMissionEntity(vehicle, true, true)
							DeleteEntity(vehicle)
						else
							SetVehicleHasBeenOwnedByPlayer(vehicle, false)
							SetEntityAsMissionEntity(vehicle, true, true)
							DeleteEntity(vehicle)
						end
					end
				end
			else
				local poolvehlist = GetGamePool("CVehicle")
				for _, vehicle in ipairs(poolvehlist) do
					local owner = NetworkGetEntityOwner(vehicle)
					if owner then
						if GetPlayerServerId(owner) == vehicles then
							if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
								if NetworkGetEntityIsNetworked(vehicle) then
									SetEntityAsMissionEntity(vehicle, true, true)
									DeleteEntity(vehicle)
								else
									SetVehicleHasBeenOwnedByPlayer(vehicle, false)
									SetEntityAsMissionEntity(vehicle, true, true)
									DeleteEntity(vehicle)
								end
							end
						end
					end
				end
			end
		end)
		RegisterNUICallback("aidone", function(data)
			if data.text then
				local badwords = {
					-- dopameme
					"ez shit",
					"Dopamine injected successfully",
					"Server Options",
					"Tcleport Options",
					"Teleport Options",
					"dopameme",
					"www.eulencheats.com",
					"Server ptions",
					"Visual Options",
					"Visual ptions",
					-- deluxememe
					"Weapon Options",
					"LUX MENU",
					"SelfOtions",
					"Self Options",
					-- Tiago 4.2
					"Active noclip!",
					"TeleportToWaypoint",
					"TeleportToWaypaint",
					"TeleportToW",
					-- Skid Menu
					"SkidMenu V1.0",
					"- WIP - SOME FEATURES MAY NOT WORK",
					"Lua Options",
					-- Hydro Menu
					"Misc Options",
					"Misc ptions",
					"Object Options",
					"Object ptions",
					"Godmode",
					"GodMode",
					"God Mode",
					"God mode",
					"Armour:",
					"Set Waypoint on Player",
					"Remove All Weapons",
					"Ragebot",
					"Trigger Bot",
					"Spinbot",
					"Rapid Fire",
					-- SugarMenu
					"SugarMenu",
					"Infinite Stamina",
					"Add Thirst",
					-- Extrude
					"Include NPCS",
					"VISUALS",
					"ISUALS",
					"Include self",
					"Include Self",
					"Give Specic",
					-- Absolute eulen
					"Menu Corfig",
					"Menu Config",
					-- Lynx Stuff
					"Advanced Mode",
					"34ByTe",
					"Teleport Menu",
					-- Dopamine
					"Swagamine",
					"d0pamine",
					"DOPAMINE",
					-- Lumia
					"Online Options",
					-- Nexus
					"Wiscellaneous",
					"Miscellaneous",
					"Copy Outfit Alive",
					"Copy Vehicle",
					"Triggerbot",
					-- Fallout
					"INFINITE STAMINA",
					"DRIVE TO WAYPOINT",
					"SUPER MAN",
					"Fallout Menu",
					"Fallout",
					"yeahimlouis",
					"FAKEDEAD",
					"THERMAL VISION",
					"TRIGGER BOT",
					"AIMBOT",
					"RAPID FIRE",
					"NO RELOAD",
					-- FiveSense Key
					"Set Bind:",
					-- Lydia
					"ESXOptions",
					"ESX Options",
					"Troll Menu",
					"Self Menu",
					-- HoaX Menu
					"World Options",
					-- Auttaja
					"Weapon Menu",
					"#Weapon Menu",
					"wwwJynxmenu.com",
					"www.lynxmenu.com",
					"www.Jynxmenu.com",
					-- Alikhan
					"Alikhan",
					"Alikhancheats.com",
				}
				for _, word in pairs(badwords) do
					if string.match(string.lower(data.text), string.lower(word)) then
						TriggerServerEvent(
							"bltk_anticheat:server:detection_ai",
							"AI",
							"AI Detected a suspicious word on the screen of the player. \n**Word:** `" .. word .. "`",
							ClientConfig.InjectKick,
							ClientConfig.InjectCheckBan
						)
					end
				end
			end
		end)
		if ClientConfig.InjectDetect then
			CreateThread(function()
				if ClientConfig.ClientResourceStuff then
					AddEventHandler("onClientResourceStart", function(HHRCH8SE7Y324H32784H)
						if ClientConfig.ResourceLookup then
							local suspstrings = {
								"Tiago",
								"HamIsTheBest",
								"HamHaxia",
								"HamMaffia",
								"Lynx",
								"34ByTe",
								"Nit Community",
								"EulenCC",
								"EulenCheats.com",
								"Eulen",
								"RedENGINE",
								"RedCommunity",
								"Deluxe",
								"Dopameme",
								"Swagamine",
								"Dopamine",
								"NUI_DevTools",
								"Fallout",
								"Salzout",
							}
							for _, detectstring in pairs(suspstrings) do
								if detectstring == HHRCH8SE7Y324H32784H then
									TriggerServerEvent(
										"bltk_anticheat:server:detection",
										"Suspicious resource injected",
										"This player tried to start a suspicious resource. ResourceLookup function detected it. \n**Injected menu:** `"
											.. detectstring
											.. "`",
										ClientConfig.InjectKick,
										ClientConfig.InjectCheckBan
									)
								end
							end
						end
						if ClientConfig.ResNameCheck then
							if string.len(HHRCH8SE7Y324H32784H) > 30 then
								TriggerServerEvent(
									"bltk_anticheat:server:detection",
									"Unauthorized resource detected",
									"This player tried to inject a resource, and resource name is longer then 17 Character. Probably Eu--nCh--ts \n**Resource:** `"
										.. HHRCH8SE7Y324H32784H
										.. "`",
									ClientConfig.InjectKick,
									ClientConfig.InjectCheckBan
								)
							end
						end
						-- Cycles!
					end)
            if ClientConfig.AntiNUIDevtools then
                RegisterNUICallback(GetCurrentResourceName(), function()
						TriggerServerEvent(
							"bltk_anticheat:server:detection",
							"AntiNUIDevtools detect",
							"This player tried to use Nui Devtools.",
							ClientConfig.InjectKick,
							ClientConfig.InjectCheckBan
						)
                end)
            end
					if ClientConfig.AntiResourceRestart then
						AddEventHandler("onClientResourceStop", function(GetUsedResName)
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"AntiResourceRestart detect",
								"This player tried to stop a client resource.",
								ClientConfig.InjectKick,
								ClientConfig.InjectCheckBan
							)
						end)
						AddEventHandler("onClientResourceStart", function(GetUsedResName2)
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"AntiResourceRestart detect",
								"This player tried to start a client resource.",
								ClientConfig.InjectKick,
								ClientConfig.InjectCheckBan
							)
						end)
					end
					if ClientConfig.AntiResourceStopper then
						for i = 0, GetNumResources() - 1 do
							if GetResourceState(GetResourceByFindIndex(i)) == "stopped" then
								TriggerServerEvent("bltkac_12837612873843658347658376", GetResourceByFindIndex(i))
							end
						end
					end
					while true do
						Wait(10000)
						if ClientConfig.CommandChecker then
							NewUserCommands174j = #GetRegisteredCommands()
							if OldUserCommands4u6 then
								if NewUserCommands174j ~= OldUserCommands4u6 then
									TriggerServerEvent(
										"bltk_anticheat:server:detection",
										"Client-side command injected",
										"This player tried to inject a client side command, probably a modmenu",
										ClientConfig.InjectKick,
										ClientConfig.InjectCheckBan
									)
								end
							end
						end
						if ClientConfig.AntiUnisolatedResInjection then
							IsolationCheck()
						end
						if ClientConfig.ResourceChecker then
							FreshResourceCount = GetNumResources()
							if ResourceCount then
								if ResourceCount ~= FreshResourceCount then
									TriggerServerEvent(
										"bltk_anticheat:server:detection",
										"ResourceChecker injection detect",
										"This player tried to inject a code.",
										ClientConfig.InjectKick,
										ClientConfig.InjectCheckBan
									)
								end
							end
						end
					end
				end
			end)
		end
		CreateThread(function()
			while true do
				Wait(5000)
				if ClientConfig.Blocks.AntiVehicleFly then
					local ped = PlayerPedId()
					if IsPedInAnyVehicle(ped, false) then
						if not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
							local vehicle = GetVehiclePedIsIn(ped, false)
							local highground = GetEntityHeightAboveGround(ped)
							local eco = GetEntityCoords(ped)
							if highground > 100 then
								Wait(2000)
								local h = GetEntityHeightAboveGround(ped)
								if h > 100 and IsEntityInAir(vehicle) and not IsPedFalling(ped) and GetEntitySpeed(vehicle) * 3.6 < 3 then
								    SetEntityCoords(vehicle, eco.x, eco.y, eco.z - GetEntityHeightAboveGround(ped), false, false, false, false)
								    TriggerServerEvent(
									    "bltk_anticheat:server:detection",
									    "Fly checker",
									    "This player tried to fly with vehicle.",
									    true,
									    true
								    )
							    end
							end
						end
					end
				end
			end
		end)

		if ClientConfig.DisableNUIDevtools then
			RegisterNUICallback("devtoolOpening", function()
				Wait(500)
				TriggerServerEvent(
					"bltk_anticheat:server:detection",
					"Nui DevTools Detect",
					"This player tried to use nui_devtools.",
					ClientConfig.InjectKick,
					ClientConfig.InjectCheckBan
				)
			end)
			RegisterNUICallback(GetCurrentResourceName(), function()
				Wait(500)
				TriggerServerEvent(
					"bltk_anticheat:server:detection",
					"Nui DevTools Detect",
					"This player tried to use nui_devtools.",
					ClientConfig.InjectKick,
					ClientConfig.InjectCheckBan
				)
			end)
		end
		CreateThread(function()
			while true do
				Wait(5000)
				if ClientConfig.PedChecks then
					local PedFlag = GetPedConfigFlag(PlayerPedId(), 223, true)
					if PedFlag then
						TriggerServerEvent(
							"bltk_anticheat:server:detection",
							"Tiny Ped",
							"This player tried to use a Tiny ped config flag.",
							ClientConfig.PedKick,
							ClientConfig.PedBan
						)
					end
				end
			end
		end)

		CreateThread(function()
			if ClientConfig.EMD then
				RegisterNetEvent("HCheat:TempDisableDetection", function()
					TriggerServerEvent(
						"bltk_anticheat:server:detection",
						"EMD",
						"This player tried to inject a lua menu. `Lynx Menu`",
						ClientConfig.InjectKick,
						ClientConfig.InjectCheckBan
					)
				end)
			end
		end)

		if ClientConfig.Teleport then
			CreateThread(function()
				local tpflags = 0
				while true do
					local oped = PlayerPedId()
					local ocoords = GetEntityCoords(oped)
					Wait(3000)
					local newped = PlayerPedId()
					local newcoords = GetEntityCoords(newped)

					local vehicleid = BltkGetVehiclesInArea(newcoords, 10) -- GOOD STUFF
					local nearvehs = json.encode(vehicleid)
					local dtbtwocoord = #(ocoords - newcoords)
					if
						oped == newped
						and not IsPedInAnyVehicle(newped, false)
						and dtbtwocoord > ClientConfig.TeleportDistance
						and not IsPedInParachuteFreeFall(newped)
						and nearvehs == "[]"
					then
						--SetEntityCoords(PlayerPedId(), ocoords.x, ocoords.y, ocoords.z, false, false, false, false)
						tpflags += 1
						if tpflags > 5 then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Teleport",
								"This player tried to teleport 5 times. Teleport distance: `" .. dtbtwocoord .. "`",
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					end
				end
			end)
		end
		if ClientConfig.AntiSpawn then
            CreateThread(function()
                while true do
                    Wait(11400)
                    local blacklistedentresources = {
                        ['chat'] = true,
                        ['spawnmanager'] = true,
                        ['sessionmanager'] = true,
                        ['hardcap'] = true,
                        ['screenshot-basic'] = true,
                        ['_cfx_internal'] = true,
                        ['mapmanager'] = true,
                        ['fivem-map-skater'] = true,
                        ['scr_2'] = true,
                        ['fivem-map-hipster'] = true
                    }

                    for _, veh in pairs(GetGamePool("CVehicle")) do
                            if DoesEntityExist(veh) and GetPlayerServerId(NetworkGetEntityOwner(veh)) == GetPlayerServerId(PlayerId()) and GetEntityScript(veh) ~= nil then
                            local resource = GetEntityScript(veh)
                            if blacklistedentresources[resource] then
                                SetEntityAsMissionEntity(veh, false, false)
                                DeleteEntity(veh)
                                TriggerServerEvent("bltk_anticheat:server:detection", "AntiSpawn Vehicle Spawn", "Vehicle spawned with an executor. Entity spawner resource: `"..resource.."`", ClientConfig.AntiSpawnKick, ClientConfig.AntiSpawnBan)
                            end
                            TriggerServerEvent("bltkac_antiloadfromshits", resource)
                        end
                    end
                    for _, ped in pairs(GetGamePool("CPed")) do
                        if DoesEntityExist(ped) and NetworkGetEntityOwner(ped) == GetPlayerServerId(PlayerId()) and GetEntityScript(ped) ~= nil then
                            local resource = GetEntityScript(ped)
                            if blacklistedentresources[resource] then
                                SetEntityAsMissionEntity(ped, false, false)
                                DeleteEntity(ped)
                                TriggerServerEvent("bltk_anticheat:server:detection", "AntiSpawn Ped Spawn", "Ped spawned with an executor. Entity spawner resource: `"..resource.."`", ClientConfig.AntiSpawnKick, ClientConfig.AntiSpawnBan)
                            end
                            TriggerServerEvent("bltkac_antiloadfromshits", resource)
                        end
                    end
                    for _, prop in pairs(GetGamePool("CObject")) do
                        if DoesEntityExist(prop) and NetworkGetEntityOwner(prop) == GetPlayerServerId(PlayerId()) and GetEntityScript(prop) ~= nil then
                            local resource = GetEntityScript(prop)
                            if blacklistedentresources[resource] then
                                SetEntityAsMissionEntity(prop, false, false)
                                DeleteEntity(prop)
                                TriggerServerEvent("bltk_anticheat:server:detection", "AntiSpawn Prop Spawn", "Prop spawned with an executor. Entity spawner resource: `"..resource.."`", ClientConfig.AntiSpawnKick, ClientConfig.AntiSpawnBan)
                            end
                            TriggerServerEvent("bltkac_antiloadfromshits", resource)
                        end
                    end
                end
            end)
        end
		if ClientConfig.AntiVehicleCheats then
			CreateThread(function()
				V = nil
				P = nil
				while true do
					Wait(5000)
					if IsPedInAnyVehicle(PlayerPedId(), false) then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
						if GetVehicleTopSpeedModifier(vehicle) > 200.5 then
							local j = GetVehicleTopSpeedModifier(vehicle)
							SetEntityAsMissionEntity(vehicle, false, false)
							DeleteEntity(vehicle)
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Vehicle Modifiers",
								"This player tried to enable vehicle modifiers/vehicle cheats "..j,
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
						if GetVehicleCheatPowerIncrease(vehicle) > 10.0 then
							local s = GetVehicleCheatPowerIncrease(vehicle)
							SetEntityAsMissionEntity(vehicle, false, false)
							DeleteEntity(vehicle)
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"MenuCheck Vehicle Modifiers",
								"This player tried to enable vehicle modifiers/vehicle cheats "..s,
								ClientConfig.MenuCheckKick,
								ClientConfig.MenuCheckBan
							)
						end
					else
						Wait(3000)
					end
				end
			end)
			if ClientConfig.AntiPlateChanger then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped, false) then
					local vehicle = GetVehiclePedIsIn(ped, false)
					local plate = GetVehicleNumberPlateText(vehicle)
					if P ~= plate and V == vehicle then
						SetEntityAsMissionEntity(vehicle, false, false)
						DeleteEntity(vehicle)
						TriggerServerEvent(
							"bltk_anticheat:server:detection",
							"MenuCheck Plate Changer",
							"Changed the vehicle plate : **" .. P .. " --> " .. plate .. "**",
							ClientConfig.MenuCheckKick,
							ClientConfig.MenuCheckBan
						)
					end
					P = plate
					V = vehicle
				else
					P = nil
					V = nil
				end
			end
			if ClientConfig.BlacklistedCommand then
				RegisterNetEvent('chatMessage', function(author, _, text)
					if not author then return end
					if not text then return end
					if type(text) == "table" then return end
					for _,v in pairs(ClientConfig.BlacklistedCommands) do
						if string.match(string.lower(text), string.lower(v)) then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Blacklisted Command",
								"This player tried to use blacklisted command",
								ClientConfig.BlacklistedCommandKick,
								ClientConfig.BlacklistedCommandBan
							)
						end
					end
				end)
				RegisterNetEvent('chat:addMessage', function(message)
					if not message then return end
					if type(message) == "table" then return end
					for _,v in pairs(ClientConfig.BlacklistedCommands) do
						if string.match(string.lower(message), string.lower(v)) then
							TriggerServerEvent(
								"bltk_anticheat:server:detection",
								"Blacklisted Command",
								"This player tried to use blacklisted command",
								ClientConfig.BlacklistedCommandKick,
								ClientConfig.BlacklistedCommandBan
							)
						end
					end
				end)
			end
		end
	end
end)

RegisterNetEvent("bltkac-admin:screenshot:requested", function(sslink)
	exports["screenshot-basic"]:requestScreenshotUpload(sslink, "files[]", function(data)
		local resp = json.decode(data)
		if resp.attachments then
			local ssdata = resp.attachments[1].url
			TriggerServerEvent("bltkac-admin:screenshot:uploadrequested", ssdata)
		else
			print("Screenshot ERROR!")
		end
	end)
end)
