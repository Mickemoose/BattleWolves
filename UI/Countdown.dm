UI
	Countdown
		icon='Countdown.dmi'
		screen_loc="CENTER-1,CENTER"
		New(client/c)
			c.screen+=src
			animate(src, transform=matrix()*2)
			icon_state="3"
			c<<KFKSUMMON
			spawn(5)
				icon_state="2"
				c<<KFKSUMMON
			spawn(10)
				icon_state="1"
				c<<KFKSUMMON
			spawn(15)
				icon_state="GO!"
				c<<KFKSUMMON
			spawn(20)
				Enabled_Items=1
				for(var/mob/m in Players_ALIVE)
					m.client.unlock_input()


					if(!itemsStarted)
						itemsStarted=1
						StartItems(m.z)
				spawn(1)
					del src
mob
	proc
		Countdown()
			new /UI/Countdown(src.client)
		Spawn(z)
			var/list/spawns=list()
			for(var/PlayerSpawn/PS in world)
				if(PS.z==z)
					if(PS.taken) continue
					spawns.Add(PS)
					break
			var/PlayerSpawn/selected = pick(spawns)
			selected.taken=1
			src.loc=selected.loc
			src.setPlayerLives(Set_Lives)
			spawn(1)
				if(src.character=="Smitty")
					var/mob/Spirits/Pyrex/P = new /mob/Spirits/Pyrex(src)
					var/mob/Spirits/Alkaline/A = new /mob/Spirits/Alkaline(src)
					spirits.Add(P)
					spirits.Add(A)
			spawn(4)
				selected.taken=0

		ShutdownMap(z)
proc
	CheckMatch()
		if(Players==(Players_INSERVER.len-(Players_INSERVER.len-1)))
			EndMatch()
	ShutdownMap(z)
		Enabled_Items=0
		itemsStarted=0
	EndMatch()
		Stage_Selected=null
		Enabled_Items=0
		itemsStarted=0
		fade.FadeOut(time=3)
		spawn(3)
			for(var/ITEMS/I in Items_ACTIVE)
				Items_ACTIVE.Remove(I)
				if(istype(I,/ITEMS/INSTANTS/KFK_Card)) Current_KFK--
				del I
			for(var/KFK_Mobs/K in world)
				Current_KFK--
				del K
			for(var/mob/m in Players_ALIVE)
				Winner=m.character
			for(var/mob/m in Players_INSERVER)
				m.SongPlaying.volume = 0
				m.SongPlaying.status = SOUND_UPDATE
				m<<m.SongPlaying
				Players--
				Players_ALIVE.Remove(m)
				PopulateWorldUI(m)
				UpdateWorldUI(m)
				Players++
				Players_ALIVE.Add(m)
				m.setCharacter("null")
				m.hitstun=0
				m.dead=0
				m.canMove=1
				m.canAct=1
				m.loc=locate(1,1,1)
				for(var/mob/q in m.spirits)
					m.spirits.Remove(q)
					del q
				fade.FadeIn(time=0)
				for(var/GameCamera/GC in world)
					if(GC.z==1)
						m.client.eye=GC
				m.Results()
				fade.FadeIn(time=3)

	StartItems(z)
		if(Enabled_Items)
			spawn(pick(300,350,400))
				ItemSpawn("item", z)
				spawn(2)
					StartItems(z)
		else
			return
