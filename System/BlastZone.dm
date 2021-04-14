area
	BlastZone
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="blast"
		Entered(mob/M)
			if(M.isPlayer && !M.dead)
				world<<PLAYERDEATH

				M.Death()
				world<<output("[M] DIED","window1.output1")
				return