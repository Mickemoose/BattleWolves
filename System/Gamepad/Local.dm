//PLAYER 1
button_tracker/echo
	Pressed(k)
		if(usr.client.input_lock == 1)
			return
		else
			if(usr.isMashing)
				usr.Mash()
			if(!usr.canAct)
				return

			else
				if(usr.inSSS)

					if(k == "GamepadStart" || k  == "GamepadFace1" && Stage_Selected!=null && Players_READY.len == Players_ALIVE.len)
						for(var/mob/m in world)
							if(m.client)
								fade.FadeOut(time=6)
								m.client.lock_input()
								m<<CHOOSE
								for(var/UI/SSS/Stages/C in m.client.screen)
									del C
								for(var/UI/CSS/Cursor/C in m.cursor)
									usr.cursor.Remove(C)
									del C
								m.CSS_Deinitialize()
								for(var/UI/CSS/Plates/P in m.client.screen)
									del P
								for(var/UI/CSS/Ready/R in m.client.screen)
									del R
								for(var/UI/CSS/Portrait/P in m.client.screen)
									del P
								for(var/UI/CSS/Name/P in m.client.screen)
									del P
								spawn(6)

									m.setStage(Stage_Selected)
									fade.FadeIn(time=10)
									spawn(10)
										m.inCSS=0
										m.inSSS=0
										m.client.unlock_input()
				if(usr.inCSS)


					if(k == "GamepadFace1" || k  == "GamepadStart"  && usr.character==null)
						usr<<CHOOSE

						usr.setCharacter(usr.characters[usr.cssicon])
						for(var/UI/CSS/Cursor/C in usr.cursor)
							C.Choose(usr)
						Players_READY.Add(usr)
						if(usr.PLAYERNUMBER==1)
							usr.inCSS=0
							usr.inSSS=1
							spawn(1)
								for(var/UI/CSS/Cursor/C in usr.cursor)
									C.screen_loc=usr.sssicons[usr.sssicon].screen_loc

						if(Players_READY.len == Players_ALIVE.len)
							for(var/mob/m in world)
								if(m.client)
									new/UI/CSS/Ready(usr.client)
						return
					if(k == "GamepadFace2"  && usr.character!=null)
						for(var/UI/CSS/Cursor/C in usr.cursor)
							C.Deselect(usr)
						usr<<CANCEL
						usr.setCharacter("null")
						Players_READY.Remove(usr)
						if(Players_READY.len != Players_ALIVE.len)
							for(var/mob/m in world)
								if(m.client)
									for(var/UI/CSS/Ready/R in m.client.screen)
										del R
						usr.setTempPortrait(usr.characters[usr.cssicon])
						return

				..()
				if(!usr.inCSS || !usr.inSSS)

					if(k == "GamepadStart" || k == "GamepadFace1")

						if(usr.inTitle)
							usr.inTitle=0
							usr.client.lock_input()
							usr.setPlayerNumber()
							for(var/UI/LOGO/L in usr.client.screen)
								L.Disappear()



							//susrawn(11)
							//	fade.FadeOut(time=1)
							//	fade.FadeIn(time=15)
							//	setCharacter("Derek")
							//	setStage()
							//	setusrlayerNumber()
							spawn(13)
								if(usr.PLAYERNUMBER==1)
									usr.SSS_Initialize()
								usr.CSS_Initialize()
							spawn(15)

								usr.client.unlock_input()
					if(k == "GamepadFace3" && !usr.inTitle && !usr.hitstun && !usr.carrying || k == "GamepadFace4" && !usr.inTitle && !usr.hitstun && !usr.carrying)

						if(!usr.has_jumped && usr.on_ground)
							if(usr.canAct && !usr.inTitle && !usr.hitstun)
								usr.canAct=0
								animate(usr, transform = null, time = 1, loop = -1)
								usr.has_jumped=1
								usr.is_jumping=1
								usr.tumbled=0
								usr.setLandingLag("LIGHT")
								flick("squat",usr)
								usr.canMove=0
								spawn(1)
									usr.canAct=1
									usr.slow_down()
									for(var/RESPAWN_PLATFORM/R in usr.bottom(4))
										R.Wobble()
									flick("jumping",usr)
									usr.canMove=1
									usr.riding=0
									usr.boost = usr.boostdefault
									usr.dbljumped=0
									if(usr.reeled)
										usr.reeled=0
									usr.vel_y = usr.jump_speed
									if(usr.boost > 0)
										usr.boost -= 1
										spawn(0.5)
											if(IsPressed("GamepadFace3") || IsPressed("GamepadFace4"))
												usr.vel_y += 1
											else
												usr.boost = 0
						if(!usr.dbljumped && !usr.on_ground)
							usr.canAct=0
							flick("squat",usr)
							usr.hitstun=1
							usr.vel_y=0
							spawn(1)
								usr.canAct=1
								usr.hitstun=0
								flick("jumping",usr)
								usr.dbljumped = 1
								usr.setLandingLag("LIGHT")
								usr.boost = usr.boostdefault
								usr.vel_y = usr.jump_speed
								if(usr.boost > 0)
									usr.boost -= 1
									spawn(0.5)
										if(IsPressed("GamepadFace3") || IsPressed("GamepadFace4"))
											usr.vel_y += 1
										else
											usr.boost = 0
					if(k=="GamepadFace1" && !usr.on_ground && !usr.hitstun)
						if(usr.holdingItem.len == 0)
							if(usr.heldItem != "frame")
								var/ITEMS/O = text2path("/ITEMS/THROWABLES/[usr.heldItem]")
								new O(usr,thrown=1)

								usr.heldItem = "frame"
								UpdateWorldUI(usr)
								return
					if(k == "GamepadFace1" && usr.on_ground && !usr.hitstun)
						if(usr.holdingItem.len == 0)
							if(usr.heldItem != "frame")
								var/ITEMS/O = text2path("/ITEMS/THROWABLES/[usr.heldItem]")
								new O(usr,thrown=1)

								usr.heldItem = "frame"
								UpdateWorldUI(usr)
								return
							if(usr.heldItem == "frame")
								var/ITEMS/cue
								for(var/ITEMS/I in oview(1,usr))
									cue=pick(I)
									//THROWABLES
									if(istype(I, /ITEMS/THROWABLES))

										usr.vel_x=0
										if(cue.inside(usr) && !cue.isDeleting && !cue.thrown && cue in oview(1,usr))
											//holdingItem.Add(cue)
											usr.canAttack=0
											flick("squat",usr)
											view(usr)<<PICKUP
											usr.vel_x=0
											spawn(1.5)
												flick("squatend",usr)
												usr.vel_x=0
												usr.canAttack=1
												cue.PickUp(usr)
										break

									//INSTANTS
									if(istype(I, /ITEMS/INSTANTS))

										usr.vel_x=0
										if(cue.inside(usr) && !cue.isDeleting && !cue.carried && cue in oview(1,usr))
											//holdingItem.Add(cue)
											usr.canAttack=0
											flick("squat",usr)
											view(usr)<<PICKUP
											usr.vel_x=0
											spawn(2)
												usr.vel_x=0
												usr.canAttack=1
												flick("carrying",usr)
												cue.Activate(usr)
										break
									//CONTAINERS
									if(istype(I, /ITEMS/CONTAINERS))
										usr.vel_x=0
										if(I.canCarry)
											if(cue.inside(usr) && !cue.isDeleting && !cue.carried && cue in oview(1,usr))
												usr.canAttack=0
												flick("squat",usr)
												usr.vel_x=0
												spawn(2)
													usr.vel_x=0
													flick("carrying",usr)
													usr.Carry(cue)
											break
						else
							for(var/ITEMS/CONTAINERS/C in usr.holdingItem)
								usr.Drop(C)
								usr.canAttack=1
								usr.canAct=1
					if(k == "GamepadFace2" && usr.carrying && !usr.hitstun)
						for(var/ITEMS/CONTAINERS/C in usr.holdingItem)
							usr.canMove=0
							usr.vel_x=0
							flick("throw",usr)
							spawn(4)
								usr.Throw(C)
								usr.canMove=1
								usr.canAttack=1
								usr.canAct=1


					if(k == "GamepadFace2" && usr.canAttack && usr.canAct && !usr.carrying && !usr.hitstun)
						if(IsPressed("GamepadLeft"))
							usr.SideSpecial()
						else if(IsPressed("GamepadRight"))
							usr.SideSpecial()
						else if(IsPressed("GamepadDown") || IsPressed("GamepadDownRight") || IsPressed("GamepadDownLeft"))
							usr.DownSpecial()
						else if(IsPressed("GamepadUp") || IsPressed("GamepadUpRight") || IsPressed("GamepadUpLeft"))
							usr.UpSpecial()
						else
							usr.NeutralSpecial()
