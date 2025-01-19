UI
	StarKO
		screen_loc="CENTER,NORTH-3"
		New(client/c, character)
			c.screen+=src
			icon=file("Characters/[character].dmi")
			icon_state="hitstun"
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
	ScreenKO
		screen_loc="CENTER,CENTER"
		New(client/c, character, mob/P)
			c.screen+=src
			icon=file("Characters/[character]/ScreenHit.dmi")
			c<<WILHELM
			var/num=rand(-256,256)
			screen_loc="CENTER:[num],CENTER"
			animate(src, transform=matrix(0.1,0,0,0,0.1,16).Translate(rand(6,21),600), time=0, flags=ANIMATION_PARALLEL)
			animate(transform=matrix().Translate(0,0)*6, time=8, flags=ANIMATION_PARALLEL)
			spawn(8)
				//animate(src, transform=null,time=0)
				animate(src, transform=turn(matrix()*5.2, pick(10,5,345,350)), alpha=255,time=1)
				animate(transform=turn(matrix()*5, 360), alpha=255,time=1)
				for(var/mob/m in world)
					if(m.client)
						m.Shake("LIGHT")
				//flick("hitstun",src)
				world<<SCREENHIT
				spawn(6)
					animate(src, transform=matrix().Translate(0,-400)*2.5, alpha=255,time=8)
					spawn(7)
						world<<PLAYERDEATH
						for(var/mob/m in world)
							if(m.client)
								m.Shake("MEDIUM")
						var/EFFECT/BLAST/FX = new /EFFECT/BLAST(P)
						animate(FX, transform = turn(matrix()*1.5, rand(80,105)), color=getPlayerColor(P), loop=1 ,easing=BOUNCE_EASING)
						FX.plane=3
						FX.layer=10000
						FX.loc=P.loc
						FX.step_x=P.step_x-264
						FX.y=36
						flick("",FX)
						spawn(4)
							del FX
					spawn(12)
						del src