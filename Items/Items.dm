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
		carrier
		timer = 100
		isDeleting = 0
		isReallyDeleting = 0
		isActuallyDeleting =0
		flash = 0
		list
			contains = list()
	INSTANTS
		KFK_Card
			icon='Items/KFK.dmi'
			icon_state=""
			pwidth=16
			pheight=24
			pixel_x=-24
			pixel_y=-16
			move_speed=2
			carried=0
			var
				list/chars = list("Doop")
				list/sacs = list()
				ctype = "character" //or sacrifice
			Activate(var/mob/activator)
				activator.holdingItem.Remove(src)
				var/matrix/M = matrix()
				carried=1
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

							del src
			proc
				Summon(ctype,var/mob/owner)
					var/result= 0
					var/F
					switch(ctype)
						if("character")
							F=pick(chars)
						if("sacrifice")
							F=pick(sacs)
					var/KFK_Mobs/O = text2path("/KFK_Mobs/[F]")
					new O(src.loc)
					O.set_pos(src.px-8, src.py+16)
					O.owner=owner
					if(O) result=1
					else result=0
					return result

	CONTAINERS
		Barrel
			icon='Items/Containers.dmi'
			icon_state=""
			pwidth=26
			pheight=20
			pixel_x=-20
			pixel_y=-16
			move_speed=2
			carried=0
	set_state()
	action()


	movement()
		if(carried) return
		else
			..()


	//	for(var/ITEMS/I in oview(1,src))
	//		if(on_ground && !thrown && !I.thrown)
	//			while(inside(I))
	//				I.px ++

	bump(atom/d)

		if(!on_ground && !isDeleting)
			DeleteTimer()

	New()
		carried=1
		animate(src, alpha = 0, transform = matrix()*4, color = "black", time = 0.1)
		spawn(0.1)
			animate(src, alpha = 255, transform = matrix()/4, color = "white", time = 2)
			spawn(2)
				view()<<ITEMSPAWN
				carried=0
				spawn(1)
					setSpinning()
	proc
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
			if("KFK")
				if(Current_KFK > Max_KFK) return
				var/ITEMS/INSTANTS/KFK_Card/B= new /ITEMS/INSTANTS/KFK_Card(selected.loc)

				Items_ACTIVE.Add(B)
				Current_KFK++
			if("Barrel")

				var/ITEMS/CONTAINERS/Barrel/B = new /ITEMS/CONTAINERS/Barrel(selected.loc)
				Items_ACTIVE.Add(B)


