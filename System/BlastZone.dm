area
	BlastZone
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="blast"

		Entered(mob/M)
			if(M.isPlayer && !M.dead)
				if(dir==SOUTHEAST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 45), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=38
					FX.x=32

					flick("",FX)
					spawn(5)
						del FX

				if(dir==SOUTHWEST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 140), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=38
					FX.x=50
					flick("",FX)
					spawn(5)
						del FX

				if(dir==NORTHEAST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 140), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=33
					FX.x=36

					flick("",FX)
					spawn(5)
						del FX

				if(dir==NORTHWEST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 45), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=33
					FX.x=50

					flick("",FX)
					spawn(5)
						del FX

				if(dir==WEST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(src)
					animate(FX, transform = turn(matrix()*1.5, 0), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_y=M.step_y
					FX.x=40

					flick("",FX)
					spawn(5)
						del FX

				if(dir==EAST)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(src)
					animate(FX, transform = turn(matrix()*1.5, 0), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_y=M.step_y
					FX.x=45

					flick("",FX)
					spawn(5)
						del FX

				if(dir==NORTH || dir==SOUTH)
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, rand(80,105)), color=M.getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_x=M.step_x-264
					FX.y=36
					flick("",FX)
					spawn(5)
						del FX
				world<<PLAYERDEATH
				for(var/mob/m in world)
					if(m.client) m.Shake()
				M.Death()
				world<<output("[M] DIED with [M.lives] lives left","window1.output1")
				return