var
	Game_Mode = "Free For All"
	Enabled_Items = 1
	Debug = 1 //Turn off to turn off Debug commands
	Max_Items = 8
	Current_KFK=0
	Max_KFK = 4
	Max_Players = 8
	Players = 0
	paused=0
	Stage_Selected = null
	list
		Players_INSERVER = list()
		Players_INLOBBY = list()
		Players_READY = list()
		Players_ALIVE = list()
		Items_ACTIVE = list()
	MATCH_WINNER

	list/kfks = list("/KFK_Mobs/Doop","/KFK_Mobs/PhormPhather","/KFK_Mobs/Steve","/KFK_Mobs/Zeke","/KFK_Mobs/Hazorb","/KFK_Mobs/Beefalo")

