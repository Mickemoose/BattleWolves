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
	fps = 60
	icon_size = 32
	view = "40x21"


mob
	var
		Background/my_background

	appearance_flags = PIXEL_SCALE
	pixel_move(dpx, dpy)
		..()
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

	Login()


		for(var/GameCamera/GC in world)
			if(GC.z==1)
				src.client.eye=GC
		spawn(10)
			src.inTitle=1

			var/UI/LOGO/L = new /UI/LOGO(client)
			var/UI/LOGO/L2 = new /UI/LOGO(client)
			L2.Appear()
			fade.FadeIn(time=0)
			animate(L, alpha=0, time=1)
			spawn(1)
				L.Appear()



				spawn(10)
					L.WaterEffect()
					animate(L, alpha=170, time=10, flags=ANIMATION_PARALLEL)



		src<<MENU
		SongPlaying = MENU
		SongPlaying.volume = MUSIC_VOLUME
		SongPlaying.status = SOUND_UPDATE
		src<<SongPlaying

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
		var/list/ridees = bottom(2)
		while(!/STAGEART/WhaleBoat in ridees)
			riding=0

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
		if(canAct && !inTitle)
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


			..()
	key_up(k)
		..()
		if(k == controls.left || k == controls.right)
			if(on_ground && vel_x != 0 && !knockbacked && !is_skidding && !carrying)
				flick("squatend",src)
	key_down(k)
		if(!canAct)
			return
		else
			..()
			if(k == "return" || k == "space" || k == "enter")
				if(inTitle)
					inTitle=0
					src.client.lock_input()
					for(var/UI/LOGO/L in client.screen)
						L.Disappear()



					spawn(11)
						fade.FadeOut(time=1)
						fade.FadeIn(time=15)
						setCharacter("Derek")
						setStage()
						setPlayerNumber()
					spawn(15)
						src.client.unlock_input()

			if(k == "7")
				setVolume("DOWN", "MUSIC")
			if(k == "8")
				src.HitStun(src,4)
				spawn(hitstun)
					flick("hitend",src)
					Knockback(power = "MEDIUM", where = "UP RIGHT")
			if(k == "9")

				new /UI/StarKO(src.client,src.character)

			if(k == "0")
				setStage("whale")


			if(k == "1" && Debug)
				ItemSpawn("item", src.z)
			if(k == "3" && Debug)
				if(Players >=8) return
				var/mob/p = new /mob(49,39,src.z)
				p.loc=locate(49,39,src.z)
				p.setCharacter("Sandbag")
				p.setPlayerNumber()
				UI_Update()

			if(k == "2")
				for(var/ITEMS/I in world)
					Items_ACTIVE.Remove(I)
					if(istype(I,/ITEMS/INSTANTS/KFK_Card)) Current_KFK--
					del I
			if(k == "escape")
				client.ToggleFullscreen()
			if(k == controls.jump && !inTitle)
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
			if(k == "f" && on_ground)
				if(holdingItem.len == 0)
					var/ITEMS/cue
					for(var/ITEMS/I in oview(1,src))
						cue=pick(I)
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
			if(k == "d" && carrying)
				for(var/ITEMS/CONTAINERS/C in holdingItem)
					canMove=0
					vel_x=0
					flick("throw",src)
					spawn(4)
						Throw(C)
						canMove=1
						canAttack=1
						canAct=1

			if(k == "d" && canAttack && canAct)
				NeutralSpecial()


				/*
				for(var/ITEMS/CONTAINERS/Wheel_Crate/W in front(10,8,8))
					if(dir==RIGHT) W.vel_x=4
					else W.vel_x=-4

				for(var/mob/M in front(10,8,8))
					if(M.hitIndex!="D1" && M.isPlayer)
						M.hitIndex="D1"
						HitStun(M,1)
						spawn(1)
							flick("hitend",M)
							M.Knockback(power = "HEAVY", where = "UP RIGHT")

						spawn(6)
							M.hitIndex="null"
				spawn(4)
					flick("squatend",src)
					canMove=1
					canAttack=1 */

	bump(atom/a, d)
		..()
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
					flick("hit",M)
					//M.face(src)
					HitStun(M,1)
					spawn(1)
						flick("hitend",M)
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
				FX.plane=src.plane-1
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
					if(canAttack)
						flick("squatend",src)
						canAct=1

					canMove=1
					jumped=0
					dbljumped=0
					reeled=0
					tumbled=0
					is_jumping=0
					has_jumped=0
					is_skidding=0

//	bump(STAGEART/WhaleBoat)
//		jumped=0
//		dbljumped=0
//		canMove=1
//		reeled=0
//		tumbled=0
//		is_jumping=0
//		has_jumped=0
//		is_skidding=0






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


		for(var/mob/M in world)
			for(var/GameCamera/GC in Players_ALIVE)
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
								target_arrows[M] = A

								client.screen += target_arrows[M]


							src.target2 = M

							trackers.Add(M)
							break
		var/mob/O = src.target2

		for(var/GameCamera/GC in world)
			if(GC.z == src.z)
				PointArrow(src.target_arrows[O], O)

		//..()

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
			item.plane=1
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
			item.plane=1
			item.thrown=1
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
			item.plane=plane-1
			item.set_pos(px, py+24)
			item.vel_x=0
			item.vel_y=0
			item.thrown=0
