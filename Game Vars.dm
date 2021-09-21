var
	Game_Mode = "Free For All"
	Enabled_Items = 1
	Debug = 1 //Turn off to turn off Debug commands
	Max_Items = 10 //best currently is 8
	Current_KFK=0
	Max_KFK = 5 //best currently is 4
	Max_Players = 8
	Players = 0
	paused=0
	Set_Lives = 3
	itemsStarted=0
	Stage_Selected = null
	Winner
	list
		Players_INSERVER = list()
		Players_INLOBBY = list()
		Players_READY = list()
		Players_ALIVE = list()
		Items_ACTIVE = list()
		localplayers= list()
	MATCH_WINNER

	list/kfks = list("/KFK_Mobs/Doop","/KFK_Mobs/PhormPhather","/KFK_Mobs/Steve","/KFK_Mobs/Zeke","/KFK_Mobs/Hazorb","/KFK_Mobs/Beefalo","/KFK_Mobs/Jellypot","/KFK_Mobs/NinjaSquidSquad")

