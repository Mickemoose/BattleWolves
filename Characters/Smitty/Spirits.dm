mob
	Spirits
		icon='Characters/Smitty/Spirits.dmi'
		density=0
		accel=0.3
		fall_speed=0.2
		move_speed=6
		var
			owner
			hovering=0
			returning=0
			ready=1
			summoned=0
			totem=0
		Alkaline
			icon='Characters/Smitty/Alkaline.dmi'
			icon_state="spirit"
			pixel_x=-24
			pixel_y=-17
			pwidth=15
			pheight=12
			var
				chasing=0
				biting=0
			proc
				Totem()
					if(summoned)
						set_pos(px,py+64)
						flick("trans",src)
						spawn(1.5)
							animate(src,alpha=0)
						spawn(25)
							if(summoned)
								Revert()
				Chase(dir=LEFT)
					if(summoned)
						set_pos(px,py-12)
						view(src)<<SQUAWK
						chasing=1
						icon_state="flying"
						switch(dir)
							if(LEFT)
								vel_x=-5
							else
								vel_x=5
						spawn(10)
							if(chasing)
								Revert()
			Revert()
				animate(src,alpha=255)
				summoned=0
				biting=0
				chasing=0
				vel_y=0
				vel_x=0
				move_towards(owner)
				flick("revert",src)
				spawn(2.5)
					icon_state="spirit"

			Summon(command)
				path=null
				destination=null
				summoned=1
				vel_x=0
				vel_y=0
				flick("trans",src)
				spawn(2.5)
					icon_state="wolf"
					switch(command)
						if("CHASE")
							Chase(src.dir)
						if("TOTEM")
							Totem()

			gravity()
			pixel_move(dpx, dpy)
				..()
				for(var/mob/m in world)
					if(m.grabbedBy==src)
						m.pixel_move(move_x, move_y)
			action()


				if(path || destination )
					if(!chasing && !biting)
						follow_path()
				for(var/mob/M in world)
					if(src.owner==M && !chasing && !biting)
						move_towards(M)

						if(src.py < M.py+32)
							src.py+=2
						if(src.py > M.py+32)
							src.py-=2
						if(M.inside(src))
							vel_x=0
							if(src.py < M.py+32)
								src.py+=2
							if(src.py > M.py+32)
								src.py-=2
						face(M)

						slow_down()
					else
						if(chasing && M.isPlayer && src.owner!=M && M.inside(src))
							chasing=0
							biting=1
							vel_y=1
							spawn(0.5)
								M.setMashing(src)
								M.grabbedBy = src
								M.setDamage(pick(0.03),"ADD")
								spawn(10)
									biting=0
									M.freeMashing()
									spawn(1.5)
										vel_y=0
										vel_x=0
										Revert()
		Pyrex
			icon='Characters/Smitty/Pyrex.dmi'
			icon_state="spirit"
			fall_speed=3
			pixel_x=-24
			pixel_y=-17
			pwidth=15
			pheight=12
			var
				chasing=0
				biting=0
			Revert()
				summoned=0
				biting=0
				chasing=0
				vel_y=0
				vel_x=0
				totem=0
				move_towards(owner)
				flick("revert",src)
				spawn(2.5)
					icon_state="spirit"
			Summon(command)
				path=null
				destination=null
				summoned=1
				vel_x=0
				vel_y=0
				flick("trans",src)
				spawn(2.5)
					icon_state="wolf"
					switch(command)
						if("CHASE")
							Chase(src.dir)
						if("TOTEM")
							Totem()
			proc
				Totem()
					totem=1
					path=null
					destination=null
					summoned=1
					vel_x=0
					vel_y=8
				//	set_pos(px,py+64)
					flick("trans",src)
					spawn(1.5)
						icon_state="totem"
						pheight=64
						pixel_y=0
						fall_speed=6
					//	vel_y=0
					spawn(25)
						if(summoned)
							pheight=12
							pixel_y=-17
							fall_speed=4
							Revert()

				Chase(dir=LEFT)
					if(summoned)
						view(src)<<BORK
						chasing=1
						icon_state="run"
						vel_x=-3
						switch(dir)
							if(LEFT)
								vel_x=-3
							else
								vel_x=3
			gravity()
				if(summoned)
					..()
				else
					return
			action()

				if(path || destination )
					if(!chasing && !biting)
						follow_path()
				for(var/mob/M in world)
					if(src.owner==M && !chasing && !biting)
						if(!summoned)
							move_towards(M)

							if(src.py < M.py+26)
								src.py+=2
							if(src.py > M.py+26)
								src.py-=2
							if(M.inside(src))
								vel_x=0
								if(src.py < M.py+26)
									src.py+=2
								if(src.py > M.py+26)
									src.py-=2
							face(M)
							slow_down()
					else
						if(chasing && at_edge())
							Revert()
						if(chasing && M.isPlayer && src.owner!=M && M.inside(src))
							chasing=0
							biting=1
							vel_y=3
							view(M,15)<<BORK
							icon_state="jump"
							spawn(0.5)
								view(M)<<CHOMP
								M.hitstun=1
								M.vel_x=0
								M.vel_y=0
								icon_state="bite"
								vel_y=0
								vel_x=0
								HitStun(M,1)
								M.setDamage(pick(0.02),"ADD")
								spawn(2)
									view(M)<<CHOMP
									HitStun(M,1)
									M.setDamage(pick(0.02),"ADD")
								spawn(4)
									view(M)<<CHOMP
									HitStun(M,1)
									M.setDamage(pick(0.04),"ADD")
								spawn(6)
									M.hitstun=0
									icon_state="jump"
									biting=0
									vel_y=3
									switch(dir)
										if(LEFT)
											vel_x=3
										else
											vel_x=-3
									spawn(1.5)
										Revert()




		proc
			Summon()


			Revert()

		set_state()
		bump()
			if(totem==1)
				totem=0
				view(src)<<STOMP
		can_bump(mob/m)
			if(summoned && owner!=m)
				return m.density
			else
				return 0
		can_bump(turf/t)
			if(summoned)
				return t.density
			else
				return 0
		move(d)
			set background=1
			src.moved = d

			// we want to keep the mob's velocity between -5 and 5.
			if(d == RIGHT)
				vel_x += accel
				if(vel_x > move_speed)
					vel_x = move_speed
			else if(d == LEFT)
				vel_x -= accel
				if(vel_x < -move_speed)
					vel_x = -move_speed

			else if(d == UP)
				vel_y += accel
				if(vel_y > move_speed)
					vel_y = move_speed
			else if(d == DOWN)
				vel_y -= accel
				if(vel_y < -move_speed)
					vel_y = -move_speed





		New(var/mob/owner2)
			owner=owner2
			loc=owner2.loc
			set_pos(owner2.px,owner2.py+64)