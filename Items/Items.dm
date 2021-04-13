ITEMS
	parent_type = /mob
	appearance_flags = PIXEL_SCALE
	fall_speed=4
	plane=1
	var
		damage = 0
		carried = 0
		thrown = 0
		carrier
		timer = 100
		isDeleting = 0
		isReallyDeleting = 0
		isActuallyDeleting =0
		flash = 0
		list
			contains = list()
	CONTAINERS
		Barrel
			icon='Items/Containers.dmi'
			icon_state="barrel"
			pwidth=26
			pheight=20
			pixel_x=-20
			pixel_y=-16
	set_state()
	action()

//		for(var/ITEMS/I in oview(1,src))
//			if(on_ground)
//				while(inside(I))
//					I.px ++


	bump(atom/d)
		if(!on_ground && !isDeleting)
			DeleteTimer()

	New()
		animate(src, alpha = 0, transform = matrix()*4, color = "black", time = 0.1)
		spawn(0.1)
			animate(src, alpha = 255, transform = matrix()/4, color = "white", time = 2)
	proc
		DeleteFlash()
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
			if("Barrel")

				var/ITEMS/CONTAINERS/Barrel/B = new /ITEMS/CONTAINERS/Barrel(selected.loc)
				Items_ACTIVE.Add(B)

