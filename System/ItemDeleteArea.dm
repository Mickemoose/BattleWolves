area
	ItemDelete
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="delete"
		Entered(mob/M)
			if(istype(M,/ITEMS))
				del M