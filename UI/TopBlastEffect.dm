UI
	StarKO
		screen_loc="CENTER,NORTH-3"
		New(client/c, character)
			c.screen+=src
			icon=file("Characters/[character].dmi")
			icon_state="hit"
			c<<WILHELM
			var/num=rand(-256,256)
			screen_loc="CENTER:[num],NORTH-3:-8"
			animate(src, transform = turn(matrix(), 120), time = 4, loop = -1, flags=ANIMATION_PARALLEL)
			animate(transform = turn(matrix(), 240), time = 4, loop = -1, flags=ANIMATION_PARALLEL)
			//animate(transform=matrix().Translate(rand(6,12),-600), time=16, flags=ANIMATION_PARALLEL)
			animate(transform=matrix(0.1,0,0,0,0.1,16),alpha=100, time=8, flags=ANIMATION_PARALLEL)
			spawn(8)
				animate(src, transform=null,time=0.1)
				animate(transform=matrix()*1, alpha=255,time=3)
				flick("star",src)
				world<<SHINE
				spawn(12)
					del src