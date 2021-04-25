mob
	BOULDER
		icon='Items/KFK/Beefalo.dmi'
		icon_state="rock"
		isPlayer=0
		fall_speed=6
		set_state()
		movement()
			..()
			for(var/mob/m in oview(1,src))
				if(m.hitIndex!="Boulder" && m.inside(src))
					m.hitIndex="Boulder"
					view(m)<<HIT
					HitStun(m,1)
					m.setDamage(pick(0.02),"ADD")
					spawn(1)
						if(m.dir==RIGHT)
							m.Knockback(power = "LIGHT", where = "UP RIGHT")
						else
							m.Knockback(power = "LIGHT", where = "UP LEFT")
					spawn(6)
						if(m.hitIndex=="Boulder")
							m.hitIndex=null
		New()
			..()
			src.x=rand(38,62)
			src.y=48
			setSpinning()
		bump(turf/t)
			for(var/mob/m in view(src))
				m.Shake("LIGHT")
				m<<BOULDER
			vel_y=6
			animate(src, alpha=0, time=5)
			spawn(5)
				del src
		proc
			setSpinning()
				animate(src, transform = turn(matrix(), 120), time = 1, loop = -1)
				animate(transform = turn(matrix(), 240), time = 1, loop = -1)
				animate(transform = null, time = 1, loop = -1)