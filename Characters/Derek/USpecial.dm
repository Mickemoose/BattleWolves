mob
	movement()
		..()
		if(character=="Derek" && doingSpecial == "UP")
			for(var/mob/m in front(20))
				if(m.isPlayer && !m.INVINCIBLE && character=="Derek" && doingSpecial == "UP" && !hasGrabbed)
					hasGrabbed=1
					flick("USPECIAL-2",src)
				//	m.client.lock_input()
				//	client.lock_input()
					hitstun=1
					m.hitstun=1
					m.vel_x=0
					m.vel_y=0
					vel_x=0
					vel_y=0

					if(dir==LEFT)
						set_pos(m.px+14, m.py)
					else
						set_pos(m.px-17, m.py)
					spawn(8)
						world<<FIRESPLODE
						var/EFFECT/DEREK/USPECIAL/FX = new /EFFECT/DEREK/USPECIAL(src.loc)
						FX.step_x=src.step_x+16
						FX.step_y=src.step_y
						flick("jumping",src)
						m.hitstun=0
						hitstun=0
						doingSpecial = null
						hasGrabbed=0
						canAttack=1
						canAct=1
						canMove=1
						dbljumped=0
						jumped=0
						has_jumped=0
						if(dir==LEFT)
							m.Knockback("HEAVY", "UP LEFT")
							vel_y=4
							vel_x=4
						else
							m.Knockback("HEAVY", "UP RIGHT")
							vel_y=4
							vel_x=-4
						m.setDamage(0.08, "ADD")
						INVINCIBLE=0

	proc
		BurstGrab()
			client.lock_input()
			INVINCIBLE=1
			setLandingLag("HEAVY")
			canAttack=0
			canMove=0
			canAct=0
			hitstun=1
			vel_x=0
			vel_y=0
			has_jumped=1
			is_jumping=1
			tumbled=0

			flick("squat",src)
			spawn(1)
				doingSpecial = "UP"
				client.unlock_input()
				canAct=1
				hitstun=0
				flick("USPECIAL-1",src)
				canMove=1
				dbljumped=0
				if(reeled)
					reeled=0
				vel_y = jump_speed*2
				switch(dir)
					if(LEFT)
						vel_x=-4
					else
						vel_x=4


			spawn(7)
				if(!hasGrabbed)
					doingSpecial = null
					INVINCIBLE=0
					flick("falling",src)
					setVulnerable()