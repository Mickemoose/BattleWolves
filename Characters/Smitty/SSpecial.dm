mob
	proc
		SpiritGrab()
			if(on_ground)
				flick("SSPECIAL",src)
				client.lock_input()
				INVINCIBLE=1
				canAttack=0
				canMove=0
				canAct=0
				vel_x=0
				vel_y=0
				for(var/mob/Spirits/Pyrex/P in spirits)
					if(P.summoned)
						P.Revert()
					//	return
					else
						P.Summon("CHASE")
						//return
				spawn(5)
					flick("",src)
					client.unlock_input()
					INVINCIBLE=0
					canMove=1
					canAct=1
				spawn(6)
					canAttack=1
			else
				flick("SSPECIAL-AIR",src)
				client.lock_input()
				INVINCIBLE=1
				canAttack=0
				canMove=0
				canAct=0
				vel_x=0
				vel_y=0
				fall_speed=0.3
				for(var/mob/Spirits/Alkaline/P in spirits)
					if(P.summoned)
						P.Revert()
						//return
					else
						P.Summon("CHASE")
						//return
				spawn(5)
					flick("falling",src)
					client.unlock_input()
					INVINCIBLE=0
					canMove=1
					canAct=1
					fall_speed=5.5
				spawn(6)
					canAttack=1