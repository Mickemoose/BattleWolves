turf
	plane = -1

	JapCastle
		icon = 'Stages/JPNCastle/turf.dmi'
		floor
			density = 1
		wall
			density = 1
			wall =1
		scaffold
			scaffold=1

		background
			icon='Stages/JPNCastle/background.dmi'
			icon_state=""
			density=0
			plane=-5
			appearance_flags = PIXEL_SCALE

			New()
				animate(src, transform=matrix()*1.4)
		Castle
			icon='Stages/JPNCastle/castle.dmi'
			density=0
		Lantern
			icon_state="lantern"
			plane=0
		Light
			icon_state="light"
			plane=1



