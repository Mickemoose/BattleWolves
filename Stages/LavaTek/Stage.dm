
var/global/GausianBlur = filter(type="motion_blur",y=4)
var/global/LavaRipple = filter(type="motion_blur",y=4)
var/global/LavaBloom = filter(type = "bloom", threshold = rgb(255, 128, 255), size = 12, offset = 2, alpha = 200)
obj
	LavaTek
		Darkness
			icon = 'System/fade.dmi'
			icon_state=""
			screen_loc = "NORTHWEST to SOUTHEAST"
			plane=2
			New(client/c)
				c.screen+=src
				animate(src, alpha=125,time=0)
				//filters+=GausianBlur
			//	active()
			proc
				active()
				deactive()
					animate(src, alpha=0,time=5, easing=SINE_EASING)
					spawn(5)
						del src
obj/lighting_plane
	screen_loc = "NORTHWEST to SOUTHEAST"
	plane = 3
	//blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER
	New()
		..()
		filters+=LavaBloom



turf
	plane = -1

	LavaTek
		appearance_flags = PIXEL_SCALE
		icon = 'Stages/LavaTek/turf.dmi'
		floor
			icon_state="floor"
			density = 1
		wall
			density = 1
			wall =1
		scaffold
			scaffold=1
		background
			icon='Stages/LavaTek/background.dmi'
			icon_state=""
			density=0
			plane=-5
			appearance_flags = PIXEL_SCALE

			New()
				animate(src, transform=matrix()*1.4)

		LavaTop
			icon_state="lava"
			plane=3
			//appearance_flags = PLANE_MASTER
			New()
				..()
				//filters+=LavaBloom
				WaterEffect3()

		Lava
			icon_state="lava2"
			plane=3



