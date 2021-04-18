mob
	proc
		FlamePlume()

			client.lock_input()
			INVINCIBLE=1
			setLandingLag("HEAVY")
			canAttack=0
			canMove=0
			canAct=0
			hitstun=1
			fall_speed=0.3
			if(!on_ground)
				spawn(2)
					hitstun=0
				spawn(4)
					fall_speed=1
				spawn(6)
					fall_speed=2
			vel_x=0
			vel_y=0
			flick("SSPECIAL",src)
			var/mob/EFFECT/DEREK/SSPECIAL/FX = new /mob/EFFECT/DEREK/SSPECIAL(src)

		//	animate(FX,alpha=200)
			FX.plane=src.plane+1
			FX.loc=src.loc
		//	FX.dir=EAST
			if(dir==RIGHT)

				FX.set_pos(src.px+46,src.py)


			if(dir==LEFT)

				FX.set_pos(src.px-46,src.py)


			spawn(3.5)
				view()<<DEREKNSPECIAL
				for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,FX))
					if(W.hitIndex!=FX)
						W.hitIndex=FX
						if(dir==RIGHT) W.vel_x=5
						else W.vel_x=-5
						spawn(2)
							W.hitIndex=null
				for(var/mob/m in oview(1,FX))
					if(m.inside(FX) && m.isPlayer)
						world<<HIT
						m.canAct=0
						m.tumbled = 1
						m.reeled = 1
						m.vel_y=4
						m.hitIndex=FX
						spawn(2)
							m.hitIndex=null
			spawn(4.8)
				for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,FX))
					if(W.hitIndex!=FX)
						W.hitIndex=FX
						if(dir==RIGHT) W.vel_x=5
						else W.vel_x=-5
						spawn(2)
							W.hitIndex=null
				for(var/mob/m in oview(1,FX))
					if(m.inside(FX)&& m.isPlayer)
						world<<HIT
						m.canAct=0
						m.tumbled = 1
						m.reeled = 1
						m.vel_y=4
						m.hitIndex=FX
						spawn(2)
							m.hitIndex=null
			spawn(6.5)
				for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,FX))
					if(W.hitIndex!=FX)
						W.hitIndex=FX
						if(dir==RIGHT) W.vel_x=5
						else W.vel_x=-5
						spawn(2)
							W.hitIndex=null
				for(var/mob/m in oview(1,FX))
					if(m.inside(FX)&& m.isPlayer)
						src.HitStun(m,1)
						spawn(1)
							m.Knockback(power = "MEDIUM", where = "UP")
						m.hitIndex=FX
						spawn(2)
							m.hitIndex=null
			spawn(10)
				fall_speed=6
				client.unlock_input()
				INVINCIBLE=0
				canMove=1
				canAct=1
				hitstun=0
				flick("squatend",src)
			spawn(14)
				canAttack=1
