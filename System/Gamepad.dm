//PLAYER 1
button_tracker/echo
	Pressed(k)
		//..()
		//Use this button for testing things
		/*
		if(button=="A")
			GoArrow()
		*/
	//	if(k == "GamepadStart")
	//		if(!usr.inTitle)
	//			if(localplayers.len<1)
	//				var/mob/Player1/P = new/mob/Player1
	//				localplayers.Add(P)
	//				P.setPlayerNumber()
	//				world<<CHOOSE
	//				P.CSS_InitializeLOCAL()
	//				P.character=null
	//				P.inCSS=1
	//				P.cssicon=1
		for(var/mob/Player1/P in localplayers)
			if(P.isMashing)
				P.Mash()
			if(!P.canAct)
				return
			else
				if(P.inCSS)
					if(k == "GamepadRight" && P.character==null)
						P<<CLICK
						P.cssicon++
						if(P.cssicon > P.cssicons.len)
							P.cssicon=1
						for(var/UI/CSS/Cursor/C in P.cursor)
							C.screen_loc=usr.cssicons[P.cssicon].screen_loc
						P.setTempPortrait(P.characters[P.cssicon])
						return
					if(k == "GamepadLeft" && P.character==null)
						P<<CLICK
						P.cssicon--
						if(P.cssicon <= 0)
							P.cssicon=P.cssicons.len
						for(var/UI/CSS/Cursor/C in P.cursor)
							C.screen_loc=P.cssicons[P.cssicon].screen_loc
						P.setTempPortrait(P.characters[P.cssicon])
						return



					if(k == "GamepadFace1" || k  == "GamepadStart"  && P.character==null)
						P<<CHOOSE

						P.setCharacter(P.characters[P.cssicon])
						for(var/UI/CSS/Cursor/C in P.cursor)
							C.Choose(P)
						Players_READY.Add(P)
						if(P.PLAYERNUMBER==1)
							P.inCSS=0
							P.inSSS=1
							spawn(1)
								for(var/UI/CSS/Cursor/C in P.cursor)
									C.screen_loc=P.sssicons[P.sssicon].screen_loc

						if(Players_READY.len == Players_ALIVE.len)
							for(var/mob/m in world)
								if(m.client)
									new/UI/CSS/Ready(P.client)
						return
					if(k == "GamepadFace2"  && P.character!=null)
						for(var/UI/CSS/Cursor/C in P.cursor)
							C.Deselect(P)
						P<<CANCEL
						P.setCharacter("null")
						Players_READY.Remove(P)
						if(Players_READY.len != Players_ALIVE.len)
							for(var/mob/m in world)
								if(m.client)
									for(var/UI/CSS/Ready/R in m.client.screen)
										del R
						P.setTempPortrait(P.characters[P.cssicon])
						return

				..()
				if(!P.inCSS || !P.inSSS)

					if(k == "GamepadStart" || k == "GamepadFace1")

						if(P.inTitle)
							P.inTitle=0
							P.client.lock_input()
							P.setPlayerNumber()
							for(var/UI/LOGO/L in usr.client.screen)
								L.Disappear()



							//spawn(11)
							//	fade.FadeOut(time=1)
							//	fade.FadeIn(time=15)
							//	setCharacter("Derek")
							//	setStage()
							//	setPlayerNumber()
							spawn(13)
								if(P.PLAYERNUMBER==1)
									P.SSS_Initialize()
								P.CSS_Initialize()
							spawn(15)

								P.client.unlock_input()
					if(k == "GamepadFace3" && !P.inTitle && !P.hitstun)
						if(!P.dbljumped && !P.on_ground)
							P.canAct=0
							flick("squat",P)
							P.hitstun=1
							P.vel_y=0
							spawn(1)
								P.canAct=1
								P.hitstun=0
								flick("jumping",P)
								P.dbljumped = 1
								P.setLandingLag("LIGHT")
								P.boost = P.boostdefault
								P.vel_y = P.jump_speed
					if(k=="GamepadFace1" && !P.on_ground && !P.hitstun)
						if(P.holdingItem.len == 0)
							if(P.heldItem != "frame")
								var/ITEMS/O = text2path("/ITEMS/THROWABLES/[P.heldItem]")
								new O(P,thrown=1)

								P.heldItem = "frame"
								UpdateWorldUI(P)
								return
					if(k == "GamepadFace1" && P.on_ground && !P.hitstun)
						if(P.holdingItem.len == 0)
							if(P.heldItem != "frame")
								var/ITEMS/O = text2path("/ITEMS/THROWABLES/[P.heldItem]")
								new O(P,thrown=1)

								P.heldItem = "frame"
								UpdateWorldUI(P)
								return
							if(P.heldItem == "frame")
								var/ITEMS/cue
								for(var/ITEMS/I in oview(1,P))
									cue=pick(I)
									//THROWABLES
									if(istype(I, /ITEMS/THROWABLES))

										P.vel_x=0
										if(cue.inside(P) && !cue.isDeleting && !cue.thrown && cue in oview(1,P))
											//holdingItem.Add(cue)
											P.canAttack=0
											flick("squat",P)
											view(P)<<PICKUP
											P.vel_x=0
											spawn(1.5)
												flick("squatend",P)
												P.vel_x=0
												P.canAttack=1
												cue.PickUp(P)
										break

									//INSTANTS
									if(istype(I, /ITEMS/INSTANTS))

										P.vel_x=0
										if(cue.inside(P) && !cue.isDeleting && !cue.carried && cue in oview(1,P))
											//holdingItem.Add(cue)
											P.canAttack=0
											flick("squat",P)
											view(P)<<PICKUP
											P.vel_x=0
											spawn(2)
												P.vel_x=0
												P.canAttack=1
												flick("carrying",P)
												cue.Activate(P)
										break
									//CONTAINERS
									if(istype(I, /ITEMS/CONTAINERS))
										P.vel_x=0
										if(I.canCarry)
											if(cue.inside(P) && !cue.isDeleting && !cue.carried && cue in oview(1,P))
												P.canAttack=0
												flick("squat",P)
												P.vel_x=0
												spawn(2)
													P.vel_x=0
													flick("carrying",P)
													P.Carry(cue)
											break
						else
							for(var/ITEMS/CONTAINERS/C in P.holdingItem)
								P.Drop(C)
								P.canAttack=1
								P.canAct=1
					if(k == "GamepadFace2" && P.carrying && !P.hitstun)
						for(var/ITEMS/CONTAINERS/C in P.holdingItem)
							P.canMove=0
							P.vel_x=0
							flick("throw",P)
							spawn(4)
								P.Throw(C)
								P.canMove=1
								P.canAttack=1
								P.canAct=1


					if(k == "GamepadFace2" && !P.carrying && !P.hitstun)
						if(k == "GamepadLeft" )
							P.SideSpecial()
						else if(k == "GamepadRight" )
							P.SideSpecial()
						else if(k == "GamepadDown" )
							P.DownSpecial()
						else if(k == "GamepadUp" )
							P.UpSpecial()
						else
							P.NeutralSpecial()
