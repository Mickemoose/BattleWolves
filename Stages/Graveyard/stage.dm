turf
	plane = -1

	Graveyard
		icon = 'Stages/Graveyard/turf.dmi'
		floor1
			density = 1
			icon_state = "dirt"
			//wall =1
		wall
			density = 1
			icon_state = "dirt"
			wall =1
		floortop
			plane=0
			icon_state = "top"
		floortop2
			plane=0
			icon_state = "top2"
		floortop3
			plane=0
			icon_state = "top3"
		background
			icon='Stages/Graveyard/background.dmi'
			icon_state=""
			appearance_flags = PIXEL_SCALE
			density=0
			plane=-5
			pixel_y=-192
			pixel_x=-256
			New()
				animate(src, transform=matrix()*1)


