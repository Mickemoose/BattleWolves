proc
	getPlayerColor(var/mob/src)
		var/rcolor
		switch(src.PLAYERNUMBER)
			if(1)
				rcolor="#b50033"
				return rcolor
			if(2)
				rcolor="#1368d6"
				return rcolor
			if(3)
				rcolor="#ffc400"
				return rcolor
			if(4)
				rcolor="#62d185"
				return rcolor
			if(5)
				rcolor="#ff6e00"
				return rcolor
			if(6)
				rcolor="#4ff6ff"
				return rcolor
			if(7)
				rcolor="#e54fff"
				return rcolor
			if(8)
				rcolor="#524e4e"
				return rcolor
mob
	proc
		setVulnerable()
			VULNERABLE=1
			canAttack=0
			dbljumped=1
			jumped=1
			has_jumped=1
			animate(src, color=rgb(100,100,100,255), time=0.8, loop=-1)
			animate(color=rgb(150,150,150,255), time=0.8)

		Mash()
			animate(src, transform=matrix().Translate(pick(-1, 1),0), time=0.75)
			animate(transform=matrix().Translate(0,0), time=0.75)
			for(var/EFFECT/MASH_ALERT/FX in world)
				if(mashFX==FX)
					if(FX.icon_state=="press") FX.icon_state=""
					else FX.icon_state="press"
			mashAmount += rand(1,5)
			if(mashAmount >=100)
				freeMashing()

			return
		freeMashing()
			if(isMashing)
				jump()
				hitstun=0
				isMashing=0

				for(var/EFFECT/MASH_ALERT/FX in world)
					if(mashFX==FX)
						del FX
				for(var/mob/m in world)
					if(grabbedBy==m)
						del m
				grabbedBy = null
		setMashing(var/mob/m)
			if(!isMashing)
				grabbedBy=m
				for(var/ITEMS/CONTAINERS/C in holdingItem)
					Drop(C)
				animate(src, transform = null)
				vel_x=0
				vel_y=0
				mashAmount=0
				hitstun=1
				isMashing=1
				var/EFFECT/MASH_ALERT/FX = new /EFFECT/MASH_ALERT(src)
				mashFX=FX
				FX.plane=src.plane+4
				FX.loc=src.loc
				FX.step_x=src.step_x-3
				FX.step_y=src.step_y+22

		SideSpecial()
			animate(src, transform = null, time = 0.1)
			switch(character)
				if("Derek")
					FlamePlume()
		NeutralSpecial()
			animate(src, transform = null, time = 0.1)
			switch(character)
				if("Derek")
					SpiritBurst()
		UpSpecial()
			animate(src, transform = null, time = 0.1)
			switch(character)
				if("Derek")
					BurstGrab()

		DownSpecial()
			animate(src, transform = null, time = 0.1)
			switch(character)
				if("Derek")
					MooseKicker()

		KBSMOKE()
			if(reeled)
				if(!kbsmoke)
					kbsmoke=1
					var/EFFECT/KBSMOKE/FX = new /EFFECT/KBSMOKE(src)
					FX.level=kblevel
					FX.plane=src.plane+1
					FX.loc=src.loc
					FX.step_x=src.step_x-6
					FX.step_y-=2
					spawn(0.8)
						kbsmoke=0
						KBSMOKE()
				else()
					KBSMOKE()
			else
				return
		setPlayerColor(num)
			PLAYERNUMBER=num



		Death()
			if(client) client.has_key(null)
			freeMashing()
			animate(src, color=rgb(255,255,255,255))
			VULNERABLE=0
			setLandingLag("LIGHT")
			on_wall=0
			canAttack=1
			dbljumped=0
			jumped=0
			has_jumped=0
			setPlayerLives(1,"REMOVE")
			canMove=0
			canAct=0
			reeled=0
			dead=1
			grabbedBy=null
			vel_x=0
			vel_y=0
			invisibility=101
			setDamage(0)
			world<<output("[src] DIED with [src.lives] lives","window1.output1")
			spawn(10)
				if(lives>0)
					Respawn()
				else
					if(src in Players_ALIVE)
						Players_ALIVE.Remove(src)
						Players--
						PopulateWorldUI(src)
						UpdateWorldUI(src)
					if(!client) del src
			return

		Respawn()
			respawning=1
			dead=0
			hitstun=0
			new /RESPAWN_PLATFORM(src)
			invisibility=0
			spawn(12)
				respawning=0
				canMove=1
				canAct=1
		setPlayerLives(num,option)
			switch(option)
				if("ADD")
					lives+=num
					UpdateWorldUI(src)
					return
				if("REMOVE")

					lives-=num
					DestroyWorldUI(src)

					return
				else
					lives=num
					UpdateWorldUI(src)
					return
			if(lives>6)
				lives=6
			if(lives<0)
				lives=0


		setPlayerNumber()
			if(Players < 8)
				Players++
				PLAYERNUMBER = Players
				//setPlayerLives(6)
				Players_ALIVE.Add(src)

				return
		setTumbled()
			on_ground=0
			animate(src, transform = turn(matrix(), 120), time = 1.5, loop = -1)
			animate(transform = turn(matrix(), 240), time = 1.5, loop = -1)
			animate(transform = null, time = 1.5, loop = -1)
		setLandingLag(weight)
			switch(weight)
				if("LIGHT")
					LAG=0.4
				if("MEDIUM")
					LAG=3.5
				if("HEAVY")
					LAG=6
		setStage(name)
			itemspawns=new()

			switch(name)
				if("Whale Boat")
					src<<WHALE
					SongPlaying = WHALE
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					for(var/GameCamera/GC in world)
						if(GC.z == 3)
							client.eye = GC
							loc=locate(47,37,3)
							for(var/ItemSpawn/S in world)
								if(S.z == 3) itemspawns.Add(S)

				if("Glitch Realm")
					src<<GLITCH
					SongPlaying = GLITCH
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					for(var/GameCamera/GC in world)
						if(GC.z == 4)
							client.eye = GC
							loc=locate(43,37,4)
							for(var/ItemSpawn/S in world)
								if(S.z == 4) itemspawns.Add(S)
				if("Debug")
					src<<GLITCH
					SongPlaying = GLITCH
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							client.eye = GC
							loc=locate(47,37,2)
							for(var/ItemSpawn/S in world)
								if(S.z == 2) itemspawns.Add(S)

				else
					src<<GLITCH
					SongPlaying = GLITCH
					SongPlaying.volume = MUSIC_VOLUME
					SongPlaying.status = SOUND_UPDATE
					src<<SongPlaying
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							usr.client.eye = GC
							loc=locate(47,37,2)
							for(var/ItemSpawn/S in world)
								if(S.z == 2) itemspawns.Add(S)
			UI_Populate()
		setBurning()
			if(burning)
				src.HitStun(src,1)
				spawn(hitstun)
					setDamage(pick(0.01,0.02,0.03,0.04),"ADD")
					Knockback(power = "NONE", where = pick("UP","UP RIGHT","UP LEFT"))
				spawn(12)
					setBurning()
		setCharacter(name)
			isPlayer=1
			//inTitle=0
			dead=0

			dir=RIGHT
			density=0
			setLandingLag("LIGHT")

			switch(name)
				if("null")
					character = null
					icon=null
					jump_speed = 0
					boostdefault = 0
					pixel_x=0
					pixel_y=0
					pwidth=0
					pheight=0
					fall_speed=0
					move_speed=0
					air_move_speed=0
					air_decel=0
					gravity=0
					carry_speed=0
				if("Matt")
					character = "[name]"
					if(inCSS) src<<Matt
				if("Schnerch")
					character = "[name]"
					if(inCSS) src<<Schnerch
				if("Hartshorne")
					character = "[name]"
					if(inCSS) src<<Hartshorne
				if("Froese")
					character = "[name]"
					if(inCSS) src<<Froese
				if("Hunter")
					character = "[name]"
					if(inCSS) src<<Hunter
				if("Laundry")
					character = "[name]"
					if(inCSS) src<<Laundry
				if("Smitty")
					character = "[name]"
					if(inCSS) src<<Smitty
				if("Becca")
					character = "[name]"
					if(inCSS) src<<Becca
				if("Brendan")
					icon='Characters/Brendan.dmi'
					jump_speed = 5
					boostdefault = 2
					pixel_x=-22
					pixel_y=-16
					pwidth=22
					character = "[name]"
					pheight=33
					fall_speed=7
					move_speed=4.5
					air_move_speed=3
					air_decel=0.14
					gravity=1
					carry_speed=1.5
					if(inCSS) src<<Brendan
				if("Derek")
					icon='Characters/Derek.dmi'
					jump_speed = 6
					boostdefault = 2
					pixel_x=-22
					pixel_y=-16
					pwidth=22
					character = "[name]"
					pheight=33
					fall_speed=6
					move_speed=5
					air_move_speed=4.5
					air_decel=0.14
					gravity=1
					carry_speed=2
					if(inCSS) src<<Derek
				//	setPlayerLives(3)
				if("Sandbag")
					icon='Characters/Sandbag.dmi'
					jump_speed = 12
					boostdefault = 4
					pixel_x=-25
					pixel_y=-16
					pwidth=16
					pheight=33
					fall_speed=4
					character = "[name]"
					move_speed=4
					carry_speed=3
				//	setPlayerLives(1)