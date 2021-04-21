var
	list
		itemlist=list("INSTANTS/KFK_Card","CONTAINERS/Barrel","CONTAINERS/Crate","CONTAINERS/Wheel_Crate","INSTANTS/Food","THROWABLES/WebTrap")
ITEMS
	parent_type = /mob
	appearance_flags = PIXEL_SCALE
	fall_speed=4
	move_speed=2
	plane=1
	density=0
	scaffold=0
	var
		damage = 0

		thrown = 0
		mover=0
		carrier
		timer = 100
		canCarry=1
		isDeleting = 0
		isReallyDeleting = 0
		isActuallyDeleting =0
		flash = 0
		list
			contains = list("INSTANTS/Food","INSTANTS/Food","INSTANTS/Food", "THROWABLES/WebTrap")
	THROWABLES
		WebTrap
			icon='Items/Webtrap.dmi'
			carried=0
			pixel_x=-20
			pixel_y=-20
			pwidth=22
			pheight=22
			PickUp(var/mob/pickuper)
				pickuper.heldItem="WebTrap"
				UpdateWorldUI(pickuper)
				Items_ACTIVE.Remove(src)
				del src
			movement()
				..()
				for(var/mob/m in oview(1,src))
					if(m.isPlayer && icon_state=="hidden" && m.inside(src))
						spawn(1)
							animate(src, transform = matrix().Scale(1, 0) ,alpha=0)
							icon_state="trap"
							animate(transform = matrix().Scale(1, 1) ,alpha=255,time=1, easing=BOUNCE_EASING)
							animate(m, color=rgb(100,100,100))
							m.client.lock_input()
							m.hitstun=1
							m.vel_x=0
							m.vel_y=0
							spawn(75)
								animate(src, alpha=0,time=3)
								animate(m, color=rgb(255,255,255))
								spawn(4)
									del src
								m.hitstun=0
								m.client.unlock_input()

			bump(atom/a)
				if(istype(a, /turf))
					if(thrown)
						animate(src, transform = null)
						carried=1
						flick("plant",src)
						spawn(3)
							icon_state="hidden"

							pwidth=32



			//	..()


	INSTANTS
		Food
			icon='Items/Food.dmi'
			carried=0
			move_speed=2
			pwidth=20
			pheight=20
			New()
				..()
				icon_state=pick("pizza","icecream","shrimp","sushi","donut")
			Activate(var/mob/activator)
				carried=1
				activator.holdingItem=new()
				view()<<EAT
				animate(src,alpha=0,time=0.5)
				animate(activator,color=rgb(0,200,0),time=1)
				activator.setDamage(pick(0.01,0.02,0.03,0.04,0.05,0.06),"REMOVE")
				spawn(1.5)
					animate(activator,color=rgb(255,255,255),time=1)
					spawn(1)
						Items_ACTIVE.Remove(src)
						del src
		KFK_Card
			icon='Items/KFK.dmi'
			icon_state=""
			pwidth=16
			pheight=24
			pixel_x=-24
			pixel_y=-16
			move_speed=2
			plane=3
			carried=0
			var
				list/chars = list("Doop","PhormPhather","Steve","Zeke")
				list/sacs = list()
				ctype = "character" //or sacrifice
			Activate(var/mob/activator)
				carried=1
				activator.holdingItem=new()
				var/matrix/M = matrix()

				//set_pos(px, activator.py+16)
				animate(src, transform = M.Translate(0,42), ,time = 5, loop = 0, easing = CIRCULAR_EASING)
				spawn(5)
					//vel_y=0


					animate(src, transform = M.Scale(-1, 1)  , time = 5, loop = 0, easing = SINE_EASING)
					spawn(3)
						if(prob(80)) ctype="character"
						else if(prob(20)) ctype = "sacrifice"
						icon_state=ctype
						animate(transform = M.Scale(1, 1)  , loop = 0, easing = SINE_EASING)
					spawn(10)
						flick("summon",src)
						view()<<KFKSUMMON
						spawn(2)
							Summon(ctype,activator)
						spawn(8)
							Items_ACTIVE.Remove(src)
							del src
			proc
				Summon(ctype,var/mob/owner)
					var/F
					switch(ctype)
						if("character")
							F=pick(chars)
						if("sacrifice")
							F=pick(sacs)
					var/KFK_Mobs/O = text2path("/KFK_Mobs/[F]")
					var/KFK_Mobs/O2 = new O(src.loc)
					O2.loc=src.loc
					O2.set_pos(src.px-8, src.py+16)
					O2.owner=owner
					return

	CONTAINERS
		Barrel
			icon='Items/Containers.dmi'
			icon_state=""
			pwidth=24
			pheight=20
			pixel_x=-20
			pixel_y=-16
			move_speed=2
			mover=1
			carried=0
			movement()
				..()
				if(icon_state=="moving")
					for(var/ITEMS/CONTAINERS/C in oview(1,src))
						if(C.inside(src))
							C.Destroy()
							Destroy()
					for(var/mob/M in oview(1,src))
						if(M.isPlayer && carrier!=M)
							if(M.inside(src))
								if(M.hitIndex!="Barrel" && M.isPlayer && !reeled && !hitstun)
									if(hitstun) return
									spawn(3.5)
										if(hitstun) return
										M.hitIndex="Barrel"
										HitStun(M,2)
										M.setDamage(pick(0.06),"ADD")
										spawn(1)
											if(M.dir==RIGHT)
												M.Knockback(power = "LIGHT", where = "UP RIGHT")
											else
												M.Knockback(power = "LIGHT", where = "UP LEFT")
										spawn(6)
											M.hitIndex="null"
								Destroy()
		Wheel_Crate
			icon='Items/WheelCrate.dmi'
			icon_state="3"
			pwidth=34
			pheight=37
			pixel_x=-20
			pixel_y=-15
			move_speed=2
			carried=0
			scaffold=1
			canCarry=0
			New()
				..()
				icon_state=pick("1","2","3")
			action()
				//..()
				if(vel_x!=0 && on_ground)
					switch(icon_state)
						if("1") icon_state="1-moving"
						if("2") icon_state="2-moving"
						if("3") icon_state="3-moving"

			pixel_move(dpx, dpy)
				var/riders = top(1)
				..()
				for(var/mob/m in riders)
					if(on_ground && isPlayer)
						m.pixel_move(move_x, move_y)
					else if(isPlayer)
						m.jump()
						setSpinning()


		Crate
			icon='Items/Crate.dmi'
			icon_state="3"
			pwidth=24
			pheight=20
			pixel_x=-20
			pixel_y=-16
			move_speed=2
			carried=0
			New()
				..()
				icon_state=pick("1","2","3")
			bump(atom/a, d)
				..()
				if(d==DOWN&&thrown)
					src.Destroy()
			bump(ITEMS/CONTAINERS/C)
				..()
				if(thrown)
					src.Destroy()
					C.Destroy()
			movement()
				..()
				if(thrown)
					for(var/ITEMS/CONTAINERS/C in oview(1,src))
						if(C.inside(src))
							C.Destroy()
							Destroy()
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.isPlayer && carrier!=M)
								if(M.hitIndex!="Barrel" && M.isPlayer && !reeled && !hitstun)
									if(hitstun) return
									spawn(3.5)
										if(hitstun) return
										M.hitIndex="Barrel"
										HitStun(M,2)
										M.setDamage(pick(0.06),"ADD")
										spawn(1)
											if(M.dir==RIGHT)
												M.Knockback(power = "LIGHT", where = "UP RIGHT")
											else
												M.Knockback(power = "LIGHT", where = "UP LEFT")
										spawn(6)
											M.hitIndex="null"
								Destroy()
	proc
		Destroy()
			if(!carried)
				var/F
				var/ITEMS/O
				var/ITEMS/O2
				carried=1
				vel_x=0
				vel_y=0
				canMove=0
				icon_state="break"
				world<<BREAK
				animate(src, transform = matrix(), alpha = 0, time = 5)
				animate(transform = turn(matrix(), 120), time = 1.5, loop = -1)
				animate(transform = turn(matrix(), 240), time = 1.5, loop = -1)
				//animate(transform = null, time = 1.5, loop = -1)
				animate(src, transform = matrix().Translate(0,42), ,time = 5, loop = 0, easing = SINE_EASING)
				if(Items_ACTIVE.len < Max_Items)
					F=pick(contains)
					O = text2path("/ITEMS/[F]")
					O2 = new O(src.loc)
					O2.set_pos(src.px-8, src.py+16)
					O2.vel_y=rand(3,5)
					O2.vel_x=rand(-2,2)
					Items_ACTIVE.Add(O2)
					if(Items_ACTIVE.len < Max_Items)
						F=pick(contains)
						O = text2path("/ITEMS/[F]")
						O2 = new O(src.loc)
						O2.set_pos(src.px-8, src.py+16)
						O2.vel_y=rand(3,5)
						O2.vel_x=rand(-2,2)
						Items_ACTIVE.Add(O2)
						if(Items_ACTIVE.len < Max_Items)
							F=pick(contains)
							O = text2path("/ITEMS/[F]")
							O2 = new O(src.loc)
							O2.set_pos(src.px-8, src.py+16)
							O2.vel_y=rand(3,5)
							O2.vel_x=rand(-2,2)
							Items_ACTIVE.Add(O2)

				spawn(8)
					Items_ACTIVE.Remove(src)
					del src





	set_state()
	action()
		if(mover) return
		else
			..()


	movement()
		if(carried) return
		else
			..()

	//	for(var/ITEMS/I in oview(1,src))
	//		if(on_ground && !thrown && !I.thrown && vel_x==0)
	//			if(inside(I))
	//				if(I.vel_x==0) I.px +=8
	//				if(vel_x==0) px -=8

	bump(atom/a, d)

		if(!on_ground && !isDeleting && vel_y==0 && d==DOWN)
			carried=0
			world<<FOOTSTEP
			var/EFFECT/LANDING_SMOKE/FX = new /EFFECT/LANDING_SMOKE(src)
			FX.plane=src.plane-1
			FX.loc=src.loc
			FX.dir=EAST
			FX.step_x=src.step_x-32
			FX.step_y-=2
			flick("",FX)
			spawn(6)
				del FX

		for(var/ITEMS/I in oview(1,src))
			if(!thrown && !I.thrown && vel_x==0 && I.vel_x==0 &&!carried && !I.carried)
				if(inside(I))
					I.set_pos(I.px+8,I.py)
					set_pos(px-8,py)





	New(var/mob/m,thrown=0)
		if(!thrown)
			carried=1
			animate(src, alpha = 0, transform = matrix()*4, color = "black", time = 0.1)
			spawn(0.1)
				animate(src, alpha = 255, transform = matrix()/4, color = "white", time = 2)
				spawn(2)
					view()<<ITEMSPAWN
					carried=0
					spawn(1)
						setSpinning()
						spawn(4)
							DeleteTimer()
		else
			src.thrown=1
			carried=0
			src.loc=m.loc
			src.set_pos(m.px,m.py+6)
			src.vel_y=5
			switch(m.dir)
				if(RIGHT) vel_x=8
				if(LEFT) vel_x=-8
			setSpinning()
	proc
		PickUp(var/mob/pickuper)
		Activate(var/mob/activator)
		setSpinning()
			animate(src, transform = turn(matrix(), 120), time = 1.5, loop = -1)
			animate(transform = turn(matrix(), 240), time = 1.5, loop = -1)
			animate(transform = null, time = 1.5, loop = -1)
		setCarry()
			carried=1
		DeleteFlash()
			if(!carried)
				if(flash==0 || flash ==1)
					flash=1
					animate(src, alpha = 0, time = 2)
					spawn(2)
						animate(src, alpha = 255, time = 2)
						spawn(2)
							DeleteFlash()
				else if(flash==2)
					flash=2
					animate(src, alpha = 0, time = 1)
					spawn(1)
						animate(src, alpha = 255, time = 1)
						spawn(1)
							DeleteFlash()


		DeleteTimer()
			if(!carried || !thrown || isDeleting || isReallyDeleting)
				timer-=1
				if(timer <= 10 && flash==1 )
					flash=2
				if(timer <= 20 && flash ==0)
					DeleteFlash()
				if(timer <= 0)
					timer = 0
					isDeleting=1
					animate(src, alpha = 0, transform = matrix()/4, color = "black", time = 3)
					spawn(3)
						if(istype(src, /ITEMS/INSTANTS/KFK_Card)) Current_KFK--
						Items_ACTIVE.Remove(src)

						del src
				spawn(10)
					DeleteTimer()





var/list/itemspawns = list()
proc
	ItemSpawn(name, z)
		if(Items_ACTIVE.len > Max_Items) return
		var/ItemSpawn/selected


		selected = pick(itemspawns)
		switch(name)
			if("item")
				var/F=pick(itemlist)
				var/ITEMS/O = text2path("/ITEMS/[F]")
				var/ITEMS/O2 = new O(selected.loc)
				Items_ACTIVE.Add(O2)
				if(istype(O, /ITEMS/INSTANTS/KFK_Card))
					Current_KFK++
			if("KFK")
				if(Current_KFK > Max_KFK) return
				var/ITEMS/INSTANTS/KFK_Card/B= new /ITEMS/INSTANTS/KFK_Card(selected.loc)

				Items_ACTIVE.Add(B)
				Current_KFK++
			if("Barrel")

				var/ITEMS/CONTAINERS/Barrel/B = new /ITEMS/CONTAINERS/Barrel(selected.loc)
				Items_ACTIVE.Add(B)


