RESPAWN_PLATFORM
	parent_type=/mob
	icon='Characters/RespawnPlatform.dmi'
	pixel_y=-9
	pixel_x=-17
	pwidth=31
	pheight=6
	density=1


	var
		timer=30
		isTimer=0
		start_py
		end_py
		list/spawns = list()
		stopped=0
		list/riders=list()
	set_state()
	gravity()
	New(var/mob/m)
		for(var/RespawnSpawn/S in world)
			if(S.z==m.z)
				spawns.Add(S)
		var/obj/selected=pick(spawns)
		src.loc=selected.loc
		dir=DOWN
		m.y=selected.y+2
		m.x=selected.x
		plane=src.plane+1
		start_py = py
		end_py = py - 10
		spawn(2)
			Timer()
	pixel_move(dpx, dpy)
		riders = top(1)
		if(stopped)
			return
		else
			..()

			for(var/mob/m in riders)
				//m.fall_speed=20
				m.pixel_move(move_x, move_y)
	movement()
		// move right

		if(stopped)
			vel_y=0

		else
			..()
			riders = top(1)
			vel_y=-3
			spawn(5)
				vel_y=-1
			spawn(12)
				vel_y=-0.5

				spawn(1)

					stopped=1



	proc
		Wobble()
			animate(src, transform = turn(matrix(), 10), time = 1.5, loop=1 )
			animate(src, transform = null, time = 1.5,loop=1  )
			spawn(1.5)
				animate(src, transform = turn(matrix(), 350), time = 1.5,loop=1 )
				animate(src, transform = null, time = 1.5, loop=1 )

		Timer()
			timer--
			if(timer<=0 || riders.len==0)
				Deactivate()
			if(timer>0)
				spawn(2)
					Timer()
		Active()
		Deactivate()
			animate(src, alpha = 0, transform = matrix()/4, color = "black", time = 3)
			spawn(3)
				del src