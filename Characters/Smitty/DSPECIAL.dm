mob
	proc
		SpiritTotem()
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
					P.Totem()
			for(var/mob/Spirits/Alkaline/P in spirits)
				if(!P.summoned)
					P.Summon("TOTEM")
			spawn(12)
				flick("",src)
				client.unlock_input()
				INVINCIBLE=0
				canMove=1
				canAct=1
			spawn(13)
				canAttack=1