mob
	movement()
		..()
		//	for(var/mob/m in obounds(0,src)-owner)
		for(var/mob/m in front(20)-src)
			if(m.isPlayer && !m.INVINCIBLE && character=="Derek" && doingSpecial == "DOWN" && m.hitIndex!="Derek-Down")
				m.hitIndex="Derek-Down"
				world<<FIRESPLODE
				var/EFFECT/DEREK/USPECIAL/FX = new /EFFECT/DEREK/USPECIAL(m.loc)
				FX.step_x=m.step_x+16
				FX.step_y=m.step_y
				HitStun(m,1)
				spawn(1)
					if(dir==LEFT)
						m.Knockback("MEDIUM", "UP LEFT")

					else
						m.Knockback("MEDIUM", "UP RIGHT")

				m.setDamage(0.06, "ADD")
				spawn(6)
					if(m.hitIndex=="Derek-Down")
						m.hitIndex=null

	proc
		MooseKicker()
			client.lock_input()
			INVINCIBLE=1
			setLandingLag("MEDIUM")
			canAttack=0
			canMove=0
			canAct=0
			hitstun=1
			vel_x=0
			vel_y=0
			tumbled=0
			var/last_fall=fall_speed
			flick("SSPECIAL",src)
			fall_speed=0
			spawn(1)
				doingSpecial="DOWN"
				view()<<DEREKNSPECIAL
				hitstun=0
				flick("DSPECIAL",src)
				switch(dir)
					if(LEFT)
						vel_x=-12
					else
						vel_x=12


			spawn(6)
				doingSpecial=null
				fall_speed=last_fall
				switch(dir)
					if(LEFT)
						vel_x=-2
					else
						vel_x=2
				client.unlock_input()
				canMove=1
				canAct=1
				canAttack=1
				INVINCIBLE=0
				flick("skidend",src)