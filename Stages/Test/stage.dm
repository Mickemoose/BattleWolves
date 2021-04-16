turf
	plane = -1

	Test_Stage
		icon = 'Stages/Test/turf.dmi'
		floor1
			density = 1
			icon_state = "floor"
		floor_l
			density = 1
			icon_state = "floor_l"
		floor_r
			density = 1
			icon_state = "floor_r"
		wall
			icon_state = "wall"
			density = 1
		wall_l
			icon_state = "wall_l"
			density = 1
			wall =1
		wall_r
			icon_state = "wall_r"
			density = 1
			wall =1
		background
			icon_state="background"
			density=0
			plane=-5

STAGEART
	parent_type=/mob
	appearance_flags = PIXEL_SCALE
	scaffold=1
	plane=-1
	var
		loop=0
	set_state()
	gravity()
	action()
		..()
	proc
		loop()
			vel_y=0
			var/matrix=matrix()

			if(!loop)
				loop=1
				vel_y=0.1
				animate(src, transform = turn(matrix, 1), time = 20)
				animate(transform = turn(matrix, 0), time = 20)
				spawn(40)
					loop()
			else
				loop=0
				vel_y=-0.1
				animate(src,transform = turn(matrix, 359), time = 20 )
				animate(transform = turn(matrix, 0), time = 20)

				spawn(40)
					loop()



	WhaleBoat
		icon='Stages/Whale/Boat.dmi'
		pheight=210
		pwidth=614
		pleft=210
		pright=210
		pixel_move(dpx, dpy)
			var/list/riders = top(2)

			..()

			for(var/mob/m in riders)
				m.riding=1
				//m.fall_speed=20
				m.pixel_move(move_x, move_y)
				//m.set_pos(m.px,m.py=py)

		New()
			..()
			loop()
