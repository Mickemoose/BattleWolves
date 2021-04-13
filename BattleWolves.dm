
client
	perspective = EYE_PERSPECTIVE
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
//	New()
//		..()
//
//		spawn(10)
//		movement_loop()
//		world.set_icon_size()


mob


	appearance_flags = PIXEL_SCALE
	density=0
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

		src.loc=locate(47,37,2)
		setCharacter("Derek")
		setStage()
		var/mob/player/p = new /mob/player(49,39,2)
		p.loc=locate(49,39,2)
		p.setCharacter("Sandbag")
		src<<MENU
		SongPlaying = MENU



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
			if(!is_jumping && on_ground && vel_x == move_speed || !is_jumping && on_ground && vel_x == -move_speed)
				is_jumping=1
				flick("squat",src)
				canMove=0
				vel_x=0
				has_jumped=1
				setLandingLag("MEDIUM")
				spawn(0.5)
					flick("jumping",src)
					canMove=1
					boost = boostdefault
					dbljumped=0
					vel_y = jump_speed
					if(dir==RIGHT)
						vel_x=8
					else
						vel_x=-8


	jump()
		if(canAct)
			animate(src, transform = null, time = 1, loop = -1)
			has_jumped=1
			is_jumping=1
			tumbled=0

			setLandingLag("LIGHT")
			flick("squat",src)
			canMove=0
			vel_x=0
			spawn(1)
				flick("jumping",src)
				canMove=1
				boost = boostdefault
				dbljumped=0
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
			if(k == "9")
				setVolume("DOWN")
			if(k == "0")
				setVolume("UP")
			if(k == "1" && Debug)
				ItemSpawn("Barrel", src.z)
			if(k == "2")
				if(paused)
					paused=0
				else
					paused=1

			if(k == "escape")
				client.ToggleFullscreen()
			if(k == controls.jump)
				if(!dbljumped && !on_ground)
					flick("squat",src)
					hitstun=1
					vel_y=0
					spawn(1)
						hitstun=0
						flick("jumping",src)
						dbljumped = 1
						setLandingLag("LIGHT")
						boost = boostdefault
						vel_y = jump_speed
			if(k == "f")
				if(holdingItem.len == 0)
					for(var/ITEMS/CONTAINERS/C in oview(1,src))
						if(C.inside(src))
							canAttack=0
							Carry(C)
				else
					for(var/ITEMS/CONTAINERS/C in holdingItem)
						Drop(C)
						canAttack=1
						canAct=1
			if(k == "d" && carrying)
				for(var/ITEMS/CONTAINERS/C in holdingItem)
					Throw(C)
					canAttack=1
					canAct=1

			if(k == "d" && canAttack && canAct)
				canAttack=0
				vel_x=0
				vel_y=0
				canMove=0
				flick("nspecial",src)
				for(var/mob/M in front(10,8,8))
					if(M.hitIndex!="D1" && M.isPlayer)
						M.hitIndex="D1"
						flick("hit",M)
						M.face(src)
						HitStun(M,1)
						spawn(1)
							flick("hitend",M)
							M.Knockback(power = "HEAVY", where = "UP RIGHT")

						spawn(6)
							M.hitIndex="null"
				spawn(4)
					flick("squatend",src)
					canMove=1
					canAttack=1

	bump(atom/a, d)
		..()
		animate(src, transform = null, time = 0.5)

		if(tumbled)
			setLandingLag("HEAVY")
			tumbled=0
		if(d == DOWN)
			flick("squat",src)
			canMove=0
			vel_y = 0
			vel_x = 0
			is_jumping=0
			is_skidding=0
			has_jumped=0
			spawn(LAG)
				flick("squatend",src)
				canMove=1
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
			item.carrier = null
			item.icon_state=""
			item.plane=1
			if(dir == RIGHT)
				item.set_pos(px+8, py+12)
			else
				item.set_pos(px-12, py+12)
		Throw(var/ITEMS/CONTAINERS/item)
			carrying=0
			item.carried=0
			holdingItem.Remove(item)
			item.carrier = null
			item.icon_state="moving"
			item.plane=1
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
			carrying=1
			item.carried=1
			item.setCarry()
			holdingItem.Add(item)
			item.carrier = src
			item.icon_state="carried"
			item.plane=plane-1
			item.set_pos(px, py+24)
