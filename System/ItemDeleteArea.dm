area
	ItemDelete
		icon='System/Camera.dmi'
		invisibility=101
		icon_state="delete"
		Entered(ITEMS/M)
			M.dead=1
			if(istype(M, /ITEMS/INSTANTS/KFK_Card)) Current_KFK--
			Items_ACTIVE.Remove(M)
			del M