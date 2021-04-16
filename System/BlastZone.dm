area
	BlastZone
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="blast"
		Entered(ITEMS/M)
			world<<output("[M] DELETE","window1.output1")
			M.dead=1
			Items_ACTIVE.Remove(M)
			if(istype(M, /ITEMS/INSTANTS/KFK_Card)) Current_KFK--
			Items_ACTIVE.Remove(M)
			del M
		Entered(mob/M)
			if(istype(M,/ITEMS))

				M.dead=1
				Items_ACTIVE.Remove(M)
				if(istype(M, /ITEMS/INSTANTS/KFK_Card))
					Current_KFK--
				world<<output("[M] DELETE now [Items_ACTIVE.len] items remain","window1.output1")
				spawn(1)
					del M
			if(M.isPlayer && !M.dead)
				if(dir==SOUTHEAST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 45), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=38
					FX.x=32

					flick("",FX)
					spawn(5)
						del FX

				if(dir==SOUTHWEST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 140), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=38
					FX.x=50
					flick("",FX)
					spawn(5)
						del FX

				if(dir==NORTHEAST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 140), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=33
					FX.x=36

					flick("",FX)
					spawn(5)
						del FX

				if(dir==NORTHWEST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, 45), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.y=33
					FX.x=50

					flick("",FX)
					spawn(5)
						del FX

				if(dir==WEST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(src)
					animate(FX, transform = turn(matrix()*1.5, 0), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_y=M.step_y
					FX.x=40

					flick("",FX)
					spawn(5)
						del FX

				if(dir==EAST)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(src)
					animate(FX, transform = turn(matrix()*1.5, 0), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_y=M.step_y
					FX.x=45

					flick("",FX)
					spawn(5)
						del FX

				if(dir==SOUTH)
					for(var/mob/m in world)
						if(m.client)
							m.Shake()
							m<<PLAYERDEATH
					var/EFFECT/BLAST/FX = new /EFFECT/BLAST(M)
					animate(FX, transform = turn(matrix()*1.5, rand(80,105)), color=getPlayerColor(M), loop=1 ,easing=BOUNCE_EASING)
					FX.plane=M.plane+5
					FX.loc=M.loc
					FX.step_x=M.step_x-264
					FX.y=36
					flick("",FX)
					spawn(5)
						del FX
				if(dir==NORTH)
					for(var/mob/m in world)
						if(m.client)
							new /UI/StarKO(m.client,M.character)


				M.Death()
				world<<output("[M] DIED with [M.lives] lives left","window1.output1")
				return