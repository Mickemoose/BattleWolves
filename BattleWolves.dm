#include "alibs\sidescroller\_flags.dm"
#include "alibs\sidescroller\background.dm"
#include "alibs\sidescroller\camera.dm"
#include "alibs\sidescroller\collision.dm"
#include "alibs\sidescroller\debugging.dm"
#include "alibs\sidescroller\keyboard.dm"
#include "alibs\sidescroller\movement.dm"
#include "alibs\sidescroller\pathing.dm"
#include "alibs\sidescroller\pixel-movement.dm"
#include "alibs\sidescroller\procs.dm"
#include "alibs\sidescroller\world.dm"
client
	perspective = EYE_PERSPECTIVE
	preload_rsc = 2
	fps = 60
	New()
		macros = new/button_tracker/echo
		return ..()
	key_down(k)
		..()

// Make objects move 8 pixels per tick when walking
	proc
		ViewWidth() //returns this client's view width, in pixels.
			if(isnum(view)) return (view * 2 + 1) * world.icon_size
			else return text2num(copytext(view, 1, findtext(view, "x"))) * world.icon_size
		ViewHeight() //returns this client's view height, in pixels.
			if(isnum(view)) return (view * 2 + 1) * world.icon_size
			else return text2num(copytext(view, findtext(view, "x")+1)) * world.icon_size



world
	fps = 50
	icon_size = 32
	view = "40x21"


mob
	var
		Background/my_background
		list/
			PlayerController = list()

	appearance_flags = PIXEL_SCALE
	pixel_move(dpx, dpy)
		..()
		for(var/EFFECT/MASH_ALERT/FX in world)
			if(mashFX==FX)
				FX.loc=src.loc
				FX.step_x=src.step_x-3
				FX.step_y=src.step_y+22
		for(var/ITEMS/I in holdingItem)
			I.pixel_move(move_x, move_y)
			I.dir=src.dir
			if(moved)
				if(dir==RIGHT)
					I.px=src.px-4
					I.py=src.py+28
				else
					I.px=src.px
					I.py=src.py+28
			else
				if(dir==RIGHT)
					I.px=src.px
					I.py=src.py+24
				else
					I.px=src.px-4
					I.py=src.py+24
	Logout()
		Players_INSERVER.Remove(src)
	Login()
		see_invisible=0
		src.client.lock_input()
		Players_INSERVER.Add(src)
		src.client.screen += new/obj/lighting_plane
		for(var/GameCamera/GC in world)
			if(GC.z==1)
				src.client.eye=GC
		spawn(10)
			src.inTitle=1
			new /UI/BACK(client)
			new /UI/FIRE2(client)
			new /UI/FIRE(client)
			new /UI/FRAME(client)
			src<<FLAMES
			var/UI/LOGO/L = new /UI/LOGO(client)
			var/UI/LOGO/L2 = new /UI/LOGO(client)
			L2.Appear()
			src.CreateEmber()
			fade.FadeIn(time=0)
			animate(L, alpha=0, time=1)
			spawn(1)
				L.Appear()



				spawn(10)

					L.WaterEffect()
					animate(L, alpha=170, time=10, flags=ANIMATION_PARALLEL)


		spawn(30)
			src.client.unlock_input()


		my_background = background('background.png', REPEAT_X + REPEAT_Y)
		my_background.hide()
	//	fade.FadeIn()

	set_background()
		if(my_background)

			// The background object isn't an atom, but it has px and py vars.
			// These vars set it's position relative to the center of the player's
			// screen. We set their values based on the player's position so the
			// background scrolls as you move.
			my_background.px = -px * 1.3
			my_background.py = -py * 1.3



	move(d)
		if(canMove)
			..()
		else
			return

	action()

		..()

		while(paused)
			vel_x=0
			vel_y=0
			canMove=0
			canAct=0

		if(boost > 0)
			boost -= 1
			spawn(0.5)
				if(client.has_key(controls.jump))
					vel_y += 1
				else
					boost = 0


		if(at_edge())
			for(var/ITEMS/CONTAINERS/C in holdingItem)
				Drop(C)
				canAttack=1
				canAct=1
			if(!is_jumping && on_ground && vel_x == move_speed || !is_jumping && on_ground && vel_x == -move_speed)
				canAct=0
				is_jumping=1
				flick("squat",src)
				canMove=0
				vel_x=0
				has_jumped=1
				setLandingLag("MEDIUM")
				spawn(0.5)
					canAct=1
					slow_down()
					flick("jumping",src)
					canMove=1
					boost = boostdefault
					dbljumped=0
					riding=0
					vel_y = jump_speed
					if(reeled)
						reeled=0
					if(dir==RIGHT)
						vel_x=8
					else
						vel_x=-8


	jump()
		if(canAct && !inTitle && !hitstun)
			canAct=0
			animate(src, transform = null, time = 1, loop = -1)
			has_jumped=1
			is_jumping=1
			tumbled=0
			setLandingLag("LIGHT")
			flick("squat",src)
			canMove=0
			spawn(1)
				canAct=1
				slow_down()
				for(var/RESPAWN_PLATFORM/R in bottom(4))
					R.Wobble()
				flick("jumping",src)
				canMove=1
				riding=0
				boost = boostdefault
				dbljumped=0
				if(reeled)
					reeled=0
				vel_y = jump_speed
				riding=0


			..()
	key_up(k)
		..()
		if(k == controls.left || k == controls.right)
			if(on_ground && vel_x != 0 && !knockbacked && !is_skidding && !carrying)
				flick("squatend",src)


	key_down(k)
		..()
		if(isMashing)
			for(var/EFFECT/MASH_ALERT/FX in world)
				if(mashFX==FX)
					if(FX.icon_state=="press")
						FX.icon_state=""

					else
						FX.icon_state="press"
			Mash()
		if(!canAct)
			return
		else
			if(inResults)
				if(k=="return" || k=="enter")
					if(PLAYERNUMBER==1)
						for(var/mob/m in Players_INSERVER)
							m<<CHOOSE
							m.ResultsEnd()
			if(inSSS)
				if(k == "1")
					src.StopEmber()
					for(var/UI/BACK/F2 in src.client.screen)
						animate(F2, alpha=0, time=3)
						spawn(3)
							del F2
					for(var/UI/FIRE2/F2 in src.client.screen)
						animate(F2, alpha=0, time=3, flags=ANIMATION_PARALLEL)
						spawn(3)
							del F2
					for(var/UI/FIRE/F in src.client.screen)
						animate(F, alpha=0, time=3, flags=ANIMATION_PARALLEL)
						spawn(3)
							del F
					for(var/UI/FRAME/R in src.client.screen)

						spawn(3)
							del R
					src.see_invisible=0
					for(var/UI/CSS/Plates/P in src.client.screen)
						del P
					for(var/UI/CSS/Ready/R in src.client.screen)
						del R
					for(var/UI/CSS/Portrait/P in src.client.screen)
						del P
					for(var/UI/CSS/Name/P in src.client.screen)
						del P

					for(var/GameCamera/GC in world)
						if(GC.z == 7)
							client.eye = GC
				if(k == "enter" || k  == "return" && Stage_Selected!=null && Players_READY.len == Players_ALIVE.len)
					for(var/mob/m in Players_ALIVE)
						if(m.client)
							m.StopEmber()
							for(var/UI/BACK/F2 in m.client.screen)
								animate(F2, alpha=0, time=3)
								spawn(3)
									del F2
							for(var/UI/FIRE2/F2 in m.client.screen)
								animate(F2, alpha=0, time=3, flags=ANIMATION_PARALLEL)
								spawn(3)
									del F2
							for(var/UI/FIRE/F in m.client.screen)
								animate(F, alpha=0, time=3, flags=ANIMATION_PARALLEL)
								spawn(3)
									del F
							for(var/UI/FRAME/R in m.client.screen)

								spawn(3)
									del R
							fade.FadeOut(time=6)
							m.see_invisible=0
							m.client.lock_input()
							m<<CHOOSE
							for(var/UI/SSS/Stages/C in m.client.screen)
								del C
							for(var/UI/CSS/Cursor/C in m.cursor)
								cursor.Remove(C)
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
									m.Countdown()
									Players_READY.Remove(m)

			if(inCSS)
				if(k == "back"  && character!=null)
					for(var/UI/CSS/Cursor/C in cursor)
						C.Deselect(src)
					src<<CANCEL
					setCharacter("null")
					Players_READY.Remove(src)
					if(Players_READY.len != Players_ALIVE.len)
						for(var/mob/m in Players_ALIVE)
							if(m.client)
								for(var/UI/CSS/Ready/R in m.client.screen)
									del R
					for(var/obj/CSS/Portrait/p in world)
						p.SetPortait(src, characters[cssicon], temp=1)
					return

			..()
			if(!inCSS || !inSSS || !inResults)
				if(k == "return" || k == "space" || k == "enter")
					if(inTitle)
						inTitle=0
						src.client.lock_input()
						src.setPlayerNumber()
						for(var/UI/LOGO/L in client.screen)
							L.Disappear()



						for(var/obj/CSS/Plates/p in world)
							p.CheckPlayers()
						spawn(13)
							CSS_Initialize()

						spawn(15)
							src.client.unlock_input()
				if(k=="6")
					var/vector/start = new (pick(src.x-pick(0,1,2,3,4,5),src.x+pick(0,1,2,3,4,5)) * world.icon_size, 50 * world.icon_size)
					var/vector/dest  = new (src.x * world.icon_size, src.y * world.icon_size)
					var/bolt/b = new(start, dest, 25)
					b.Draw(usr.z, color = "#a5daff")
					world<<LIGHTNING
					src.setDamage(0.05, "ADD")
					src.HitStun(src,1,"black")
					spawn(1)
						src.HitStun(src,1,"yellow")
						spawn(1)
							src.Knockback("MEDIUM", pick("UP LEFT","UP RIGHT"))


				if(k=="4")
					var/KFK_Mobs/variable=input("Spawn KFK") in kfks
					var/KFK_Mobs/kfk=new variable(src.loc)
					kfk.owner=src
				if(k == "5")
					new /UI/ScreenKO(client,character)

				if(k == "8")
					src.HitStun(src,4)
					spawn(hitstun)
						flick("hitend",src)
						Knockback(power = "NONE", where = "UP")

				if(k == "0")
					Ripple()


				if(k == "1" && Debug)
					ItemSpawn("item", src.z)
				if(k == "3" && Debug)
					if(Players >=8) return
					var/mob/p = new /mob(49,39,src.z)
					p.loc=locate(49,39,src.z)
					PlayerController.Add(p)
					p.setCharacter("Sandbag")
					p.setPlayerNumber()
					Players_INSERVER.Add(p)
					UI_Update()

				if(k == "2")
					for(var/ITEMS/I in Items_ACTIVE)
						Items_ACTIVE.Remove(I)
						if(istype(I,/ITEMS/INSTANTS/KFK_Card)) Current_KFK--
						del I
				if(k == "escape")
					client.ToggleFullscreen()
				if(k == controls.jump && !inTitle && !hitstun)
					if(!dbljumped && !on_ground)
						canAct=0
						flick("squat",src)
						hitstun=1
						vel_y=0
						spawn(1)
							canAct=1
							hitstun=0
							flick("jumping",src)
							dbljumped = 1
							setLandingLag("LIGHT")
							boost = boostdefault
							vel_y = jump_speed
				if(k=="f" && !on_ground && !hitstun)
					if(holdingItem.len == 0)
						if(heldItem != "frame")
							var/ITEMS/O = text2path("/ITEMS/THROWABLES/[heldItem]")
							new O(src,thrown=1)

							heldItem = "frame"
							UpdateWorldUI(src)
							return
				if(k == "f" && on_ground && !hitstun)
					if(holdingItem.len == 0)
						if(heldItem != "frame")
							var/ITEMS/O = text2path("/ITEMS/THROWABLES/[heldItem]")
							new O(src,thrown=1)

							heldItem = "frame"
							UpdateWorldUI(src)
							return
						if(heldItem == "frame")
							var/ITEMS/cue
							for(var/ITEMS/I in oview(1,src))
								cue=pick(I)
								//THROWABLES
								if(istype(I, /ITEMS/THROWABLES))

									vel_x=0
									if(cue.inside(src) && !cue.isDeleting && !cue.thrown && cue in oview(1,src))
										//holdingItem.Add(cue)
										canAttack=0
										flick("squat",src)
										view()<<PICKUP
										vel_x=0
										spawn(1.5)
											flick("squatend",src)
											vel_x=0
											canAttack=1
											cue.PickUp(src)
									break

								//INSTANTS
								if(istype(I, /ITEMS/INSTANTS))

									vel_x=0
									if(cue.inside(src) && !cue.isDeleting && !cue.carried && cue in oview(1,src))
										//holdingItem.Add(cue)
										canAttack=0
										flick("squat",src)
										view()<<PICKUP
										vel_x=0
										spawn(2)
											vel_x=0
											canAttack=1
											flick("carrying",src)
											cue.Activate(src)
									break
								//CONTAINERS
								if(istype(I, /ITEMS/CONTAINERS))
									vel_x=0
									if(I.canCarry)
										if(cue.inside(src) && !cue.isDeleting && !cue.carried && cue in oview(1,src))
											canAttack=0
											flick("squat",src)
											vel_x=0
											spawn(2)
												vel_x=0
												flick("carrying",src)
												Carry(cue)
										break
					else
						for(var/ITEMS/CONTAINERS/C in holdingItem)
							Drop(C)
							canAttack=1
							canAct=1
				if(k == "d" && carrying && !hitstun)
					for(var/ITEMS/CONTAINERS/C in holdingItem)
						canMove=0
						vel_x=0
						flick("throw",src)
						spawn(4)
							Throw(C)
							canMove=1
							canAttack=1
							canAct=1

				if(k == "d" && canAttack && canAct && !hitstun)
					if(client.has_key(controls.left))
						SideSpecial()
					else if(client.has_key(controls.right))
						SideSpecial()
					else if(client.has_key(controls.down))
						DownSpecial()
					else if(client.has_key(controls.up))
						UpSpecial()
					else
						NeutralSpecial()

	bump(atom/a, d)

		if(isMashing)
			return
		else
			..()
			if(VULNERABLE)
				animate(src, color=rgb(255,255,255,255))
				VULNERABLE=0
				canAttack=1
				dbljumped=0
				jumped=0
				has_jumped=0
			animate(src, transform = null, time = 0.5)


			if(istype(a, /STAGEART/WhaleBoat))
				jumped=0
				dbljumped=0
				canMove=1
				reeled=0
				tumbled=0
				is_jumping=0
				has_jumped=0
				is_skidding=0
			if(istype(a, /ITEMS/CONTAINERS/Wheel_Crate))
				var/ITEMS/I=a
				if(dir==RIGHT) I.vel_x=1
				else I.vel_x=-1
			if(istype(a, /mob))
				var/mob/M=a
				if(d==DOWN && M.isPlayer)
					if(M.hitIndex!="STOMP")
						M.hitIndex="STOMP"
						HitStun(M,1)
						spawn(1)
							jump()
							if(dir==RIGHT) vel_x=6
							else vel_x=-6
							canMove=1
							canAttack=1
							has_jumped=0
							jumped=0
							dbljumped=0
						spawn(6)
							M.hitIndex="null"


			if(istype(a, /turf))
				if(tumbled)
					setLandingLag("HEAVY")
					tumbled=0
				if(d == DOWN)
					var/EFFECT/LANDING_SMOKE/FX = new /EFFECT/LANDING_SMOKE(src)
					FX.layer=src.layer-1
					FX.loc=src.loc
					FX.dir=EAST
					FX.step_x=src.step_x-32
					FX.step_y-=2
					flick("",FX)
					spawn(6)
						del FX
					flick("squat",src)

					canMove=0
					vel_y = 0
					vel_x = 0
					spawn(LAG)
						del FX
						flick("squatend",src)
						if(canAttack)

							canAct=1

						canMove=1
						jumped=0
						dbljumped=0
						reeled=0
						tumbled=0
						is_jumping=0
						has_jumped=0
						is_skidding=0

	slow_down()

		if(knockbacked)
			if(vel_x > move_speed)
				vel_x -= kdecel
			else if(vel_x < -move_speed)
				vel_x += kdecel
		else
			..()
	gravity()
		if(carried)
			return
		else
			..()
	movement()
		..()
		//OLD OOV Circle kinda shit so disabled
		/*
		for(var/mob/M in Players_ALIVE)
			for(var/GameCamera/GC in world)
				if(GC.z == src.z && M.isPlayer)

					if(get_dist(GC,M)<=14)
						if(M in trackers)
							trackers.Remove(M)


							client.screen -= target_arrows[M]
							target_arrows -= M

							if(!target_arrows.len)
								target_arrows = null

						continue

					else
						if(M in trackers) break
						else
							if(M in target_arrows) return
							if(!target_arrows)
								target_arrows = new
								var/OOV_Arrow/A = new /OOV_Arrow
								A.icon_state=M.character
								animate(A, color=getPlayerColor(M))
								target_arrows[M] = A

								client.screen += target_arrows[M]


							src.target2 = M

							trackers.Add(M)
							break
		var/mob/O = src.target2

		for(var/GameCamera/GC in world)
			if(GC.z == src.z)
				PointArrow(src.target_arrows[O], O)

		..() */

	proc
		Drop(var/ITEMS/CONTAINERS/item)
			carrying=0
			item.carried=0
			holdingItem.Remove(item)
			holdingItem=new()
			item.carrier = null
			if(istype(item,/ITEMS/CONTAINERS/Crate))
				switch(item.icon_state)
					if("1-carried")
						item.icon_state="1"
					if("2-carried")
						item.icon_state="2"
					if("3-carried")
						item.icon_state="3"
			else item.icon_state=""
			item.layer=1
			if(dir == RIGHT)
				item.set_pos(px+8, py+12)
			else
				item.set_pos(px-12, py+12)
		Throw(var/ITEMS/CONTAINERS/item)
			carrying=0
			item.carried=0
			holdingItem.Remove(item)
			holdingItem=new()
			spawn(2) item.carrier = null
			item.layer=1
			spawn(1) item.thrown=1
			if(item.mover) item.icon_state="moving"
			else item.setSpinning()
			if(dir == RIGHT)
				item.set_pos(px+8, py+12)
				item.vel_x=5
				item.vel_y=6
				spawn(2)
					item.vel_x=3
			else
				item.set_pos(px-12, py+12)
				item.vel_x=-5
				item.vel_y=6
				spawn(3.5)
					item.vel_x=-3

		Carry(var/ITEMS/CONTAINERS/item)
			animate(item, transform = null, time = 0.1)
			view()<<PICKUP
			carrying=1
			item.timer=100
			item.carried=1
			item.setCarry()
			holdingItem.Add(item)
			item.carrier = src
			if(istype(item,/ITEMS/CONTAINERS/Crate))
				switch(item.icon_state)
					if("1")
						item.icon_state="1-carried"
					if("2")
						item.icon_state="2-carried"
					if("3")
						item.icon_state="3-carried"
			else item.icon_state="carried"
			item.layer=layer-1
			item.set_pos(px, py+24)
			item.vel_x=0
			item.vel_y=0
			item.thrown=0
