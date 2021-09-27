mob
	movement()
		..()
		if(character=="Smitty" && doingSpecial == "NEUTRAL")
			for(var/ITEMS/CONTAINERS/Wheel_Crate/W in right(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					if(W.hitIndex!=src)
						W.hitIndex=src
						if(dir==RIGHT) W.vel_x=4
						else W.vel_x=-4
			for(var/ITEMS/CONTAINERS/C in right(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					C.Destroy()
			for(var/ITEMS/CONTAINERS/Wheel_Crate/W in left(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					if(W.hitIndex!=src)
						W.hitIndex=src
						if(dir==RIGHT) W.vel_x=4
						else W.vel_x=-4
			for(var/ITEMS/CONTAINERS/C in left(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					C.Destroy()
			for(var/ITEMS/CONTAINERS/Wheel_Crate/W in top(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					if(W.hitIndex!=src)
						W.hitIndex=src
						if(dir==RIGHT) W.vel_x=4
						else W.vel_x=-4
			for(var/ITEMS/CONTAINERS/C in top(20)-src)
				if(character=="Smitty" && doingSpecial == "NEUTRAL")
					C.Destroy()
			for(var/mob/m in right(20)-src)
				if(m.isPlayer && !m.INVINCIBLE && character=="Smitty" && doingSpecial == "NEUTRAL" && m.hitIndex!="Smitty-Neutral")
					m.hitIndex="Smitty-Neutral"
					HitStun(m,1)
					spawn(1)
						m.Knockback("LIGHT", "UP RIGHT")

					m.setDamage(pick(0.05,0.06,0.07), "ADD")
					spawn(3)
						if(m.hitIndex=="Smitty-Neutral")
							m.hitIndex=null
			for(var/mob/m in left(20)-src)
				if(m.isPlayer && !m.INVINCIBLE && character=="Smitty" && doingSpecial == "NEUTRAL" && m.hitIndex!="Smitty-Neutral")
					m.hitIndex="Smitty-Neutral"
					HitStun(m,1)
					spawn(1)
						m.Knockback("LIGHT", "UP LEFT")

					m.setDamage(pick(0.05,0.06,0.07), "ADD")
					spawn(3)
						if(m.hitIndex=="Smitty-Neutral")
							m.hitIndex=null
			for(var/mob/m in top(20)-src)
				if(m.isPlayer && !m.INVINCIBLE && character=="Smitty" && doingSpecial == "NEUTRAL" && m.hitIndex!="Smitty-Neutral")
					m.hitIndex="Smitty-Neutral"
					HitStun(m,1)
					spawn(1)
						m.Knockback("LIGHT", "UP")

					m.setDamage(pick(0.05,0.06,0.07), "ADD")
					spawn(3)
						if(m.hitIndex=="Smitty-Neutral")
							m.hitIndex=null

	proc
		SpiritProtect()
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
			flick("NSPECIAL-1",src)
			fall_speed=0
			for(var/mob/Spirits/Alkaline/P in spirits)
				if(!P.summoned)
					P.Summon("HIDE")
			for(var/mob/Spirits/Pyrex/P in spirits)
				if(!P.summoned)
					P.Summon("HIDE")
			spawn(2)
				doingSpecial="NEUTRAL"
				view()<<DEREKNSPECIAL
				hitstun=0
				flick("NSPECIAL",src)
				fall_speed=2


			spawn(8)
				flick("",src)
				for(var/mob/Spirits/Alkaline/P in spirits)
					P.Revert()
				for(var/mob/Spirits/Pyrex/P in spirits)
					P.Revert()
				doingSpecial=null
				fall_speed=last_fall
				client.unlock_input()
				canMove=1
				canAct=1
				canAttack=1
				INVINCIBLE=0