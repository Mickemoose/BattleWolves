RESPAWN_PLATFORM
	parent_type=/mob
	icon='Characters/RespawnPlatform.dmi'
	pixel_y=-9
	pixel_x=-17
	pwidth=31
	pheight=6
	density=1


	var
		timer=100
		start_py
		end_py
		list/spawns = list()
		stopped=0
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
	pixel_move(dpx, dpy)
		var/list/riders = top(1)
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
		Active()
