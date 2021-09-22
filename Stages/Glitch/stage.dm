turf
	plane = -1

	Glitch_Realm
		icon = 'Stages/Glitch/turf.dmi'
		floor1
			density = 1
			icon_state = "ground"
		floor_l
			density = 1
			icon_state = "groundl"
		floor_r
			density = 1
			icon_state = "groundr"
		wall
			icon_state = "inwall"
			density = 1
		wall_l
			icon_state = "walll"
			density = 1
			wall =1
		wall_r
			icon_state = "wallr"
			density = 1
			wall =1
		background
			icon='Stages/Glitch/background.dmi'
			icon_state="background"
			density=0
			plane=-5
			appearance_flags = PIXEL_SCALE
			pixel_y=-256
			pixel_x=-256
			New()
				animate(src, transform=matrix()*1)

		effect
			icon_state="effect"
			density=1

		effect2
			icon_state="effect2"
			density=1
		effect3
			icon_state="effect3"
			density=1
		effect4
			icon_state="effect4"
			density=1
		effect5
			icon_state="effect5"
			density=1
		effect6
			icon_state="effect6"
			density=1
