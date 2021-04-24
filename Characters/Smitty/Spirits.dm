mob
	Spirits
		icon='Characters/Smitty/Spirits.dmi'
		density=0
		accel=0.3
		move_speed=6
		var
			owner
		Alkaline
			icon_state="alkaline"
			action()
				if(path || destination )
					follow_path()
				for(var/mob/M in world)
					if(src.owner==M)
						move_towards(M)
						if(src.py < M.py+15)
							src.py+=2
						if(src.py > M.py+15)
							src.py-=2
						face(M)
					if(src.inside(M) || M.inside(src))
						vel_x=0
						vel_y=0
				slow_down()
		Pyrex
			icon_state="pyrex"
			action()
				if(path || destination )
					follow_path()
				for(var/mob/M in world)
					if(src.owner==M && !src.inside(M))
						move_towards(M)
						if(src.py < M.py+32)
							src.py+=2
						if(src.py > M.py+32)
							src.py-=2
						face(M)
					if(src.inside(M) || M.inside(src))
						vel_x=0
						vel_y=0
				slow_down()
		set_state()
		can_bump(turf/t)
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




		gravity()
		New(var/mob/owner2)
			owner=owner2
			loc=owner2.loc