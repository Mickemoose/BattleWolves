mob
	SQUID
		icon='Items/KFK/NinjaSquid.dmi'
		icon_state="rise"
		isPlayer=0
		var/mob/spawner
		fall_speed=6
		set_state()
		gravity()
		can_bump()
			return 0
		New()
			..()
			src.x=rand(38,62)
			if(src.x > 50)
				src.dir=LEFT
			else
				src.dir=RIGHT
			src.y=26
			//setSpinning()
			src.vel_y=11
			spawn(pick(6,6.5,7,7.5,8))
				src.vel_y=4
				src.icon_state="stay"
				spawn(2)
					src.vel_y=0
					var/ITEMS/O = text2path("/ITEMS/THROWABLES/NinjaStar")
					new O(src,thrown=1)
					spawn(5)
						src.icon_state="rise"
						src.vel_y=4
						spawn(2)
							src.icon_state="fall"
							src.vel_y=-5
							spawn(2)
								src.vel_y=-10
								spawn(10)
									del src

	BOULDER
		icon='Items/KFK/Beefalo.dmi'
		icon_state="rock"
		isPlayer=0
		var/mob/spawner
		fall_speed=6
		pwidth=64
		pheight=64
		set_state()
		movement()
			..()
			for(var/mob/m in oview(1,src))
				if(m.hitIndex!="Boulder" && m.isPlayer && spawner!=m && m.inside(src))
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
		can_bump(mob/m)
			return 0
		can_bump(turf/t)
			return t.density

		bump(turf/t)
			for(var/mob/m in view(src))
				m.Shake("LIGHT")
				m<<BOULDER
			vel_y=6
			density=0
			animate(src, alpha=0, time=5)
			spawn(5)
				del src
		proc
			setSpinning()
				animate(src, transform = turn(matrix(), 120), time = 1, loop = -1)
				animate(transform = turn(matrix(), 240), time = 1, loop = -1)
				animate(transform = null, time = 1, loop = -1)