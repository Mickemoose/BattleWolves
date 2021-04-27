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
		Alkaline
			icon='Characters/Smitty/Alkaline.dmi'
			icon_state="spirit"
			pixel_x=-24
			pixel_y=-17
			pwidth=15
			pheight=12
			Summon()
				path=null
				destination=null
				summoned=1
				vel_x=0
				vel_y=0
				flick("trans",src)
				spawn(2.5)
					icon_state="wolf"
			gravity()
			action()
				if(summoned)
					..()
				else
					if(path || destination )
						follow_path()
					for(var/mob/M in world)
						if(src.owner==M)
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
			proc
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
				summoned=0
				vel_y=0
				vel_x=0
				move_towards(owner)
				flick("revert",src)
				spawn(2.5)
					icon_state="spirit"
		set_state()
		bump()
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