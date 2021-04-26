mob
	Spirits
		icon='Characters/Smitty/Spirits.dmi'
		density=0
		accel=0.3
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
			pixel_x=-24
			pixel_y=-17
			pwidth=15
			pheight=12
			gravity()
				if(summoned)
					..()
				else
					return
			action()
				if(summoned)
					..()
				else
					if(path || destination )
						follow_path()
					for(var/mob/M in world)
						if(src.owner==M)
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
		proc
			Summon()
				path=null
				destination=null
				summoned=1
				vel_x=0
				vel_y=0
				flick("trans",src)
				spawn(2.5)
					icon_state="wolf"
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