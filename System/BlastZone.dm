area
	BlastZone
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="blast"
		Entered(mob/M)
			if(M.isPlayer && !M.dead)
				world<<PLAYERDEATH
				for(var/mob/m in world)
					if(m.client) m.Shake()
				M.Death()
				world<<output("[M] DIED with [M.lives] lives left","window1.output1")
				return