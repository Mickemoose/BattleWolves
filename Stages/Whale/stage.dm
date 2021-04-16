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
			icon_state="background"
			density=0
			plane=-5