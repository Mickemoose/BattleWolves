turf
	plane = -1

	Whale_Boat
		icon='Stages/Whale/turf.dmi'
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
		WaterFront
			icon='Stages/Whale/Water.dmi'
			density=0
			plane=2
		WaterBack
			icon='Stages/Whale/Water.dmi'
			icon_state="back"
			density=0
			plane=-3
		Water2
			icon_state="waterback"
			density=0
			plane=-3
		Water
			icon_state="water"
			density=0
			plane=2
		background
			icon='Stages/Whale/background.dmi'
			icon_state="background"
			appearance_flags = PIXEL_SCALE
			density=0
			plane=-5
			New()
				animate(src, transform=matrix()*1.95)

		WhaleBoat
			density=0
			plane=-1
			icon='Stages/Whale/Boat.dmi'
		Density
			density=1
			scaffold=1
STAGEART
	parent_type=/obj
	appearance_flags = PIXEL_SCALE
	scaffold=1
	plane=-1
	var
		loop=0
	proc
		loop()
			var/matrix=matrix()

			if(!loop)
				loop=1
				animate(src, transform = turn(matrix, 1), time = 20)
				animate(transform = turn(matrix, 0), time = 20)
				spawn(40)
					loop()
			else
				loop=0
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
		density=0


		//New()
		//	..()
		//	loop()