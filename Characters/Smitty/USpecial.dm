mob
	proc
		SpiritFlight()
			flick("DSPECIAL",src)
			client.lock_input()
			INVINCIBLE=1
			canAttack=0
			canMove=0
			canAct=0
			vel_x=0
			vel_y=0
			for(var/mob/Spirits/Pyrex/P in spirits)
				if(!P.summoned)
					P.Summon("HIDE")
			for(var/mob/Spirits/Alkaline/P in spirits)
				if(!P.summoned)
					P.Summon("HIDE")
			spawn(5)
				flick("USPECIAL",src)
				view(src)<<SQUAWK
				dbljumped=0
				if(reeled)
					reeled=0
				vel_y=14
				spawn(6)
					for(var/mob/Spirits/Alkaline/P in spirits)
						if(!P.summoned)
							P.Revert()
					for(var/mob/Spirits/Pyrex/P in spirits)
						if(!P.summoned)
							P.Revert()
					client.unlock_input()
					INVINCIBLE=0
					canMove=1
					canAct=1
					INVINCIBLE=0
					flick("falling",src)
					setVulnerable()

