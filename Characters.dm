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
		NeutralSpecial()
			animate(src, transform = null, time = 0.1)
			switch(character)
				if("Derek")
					SpiritBurst()
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
			on_wall=0
			setPlayerLives(1,"REMOVE")
			canMove=0
			canAct=0
			reeled=0
			dead=1
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
				UI_Populate()
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
				if("whale")
					for(var/GameCamera/GC in world)
						if(GC.z == 3)
							client.eye = GC
							my_background.show()
							loc=locate(47,37,3)
							for(var/ItemSpawn/S in world)
								if(S.z == 3) itemspawns.Add(S)


				if("debug")
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							client.eye = GC
							loc=locate(47,37,2)
							for(var/ItemSpawn/S in world)
								if(S.z == 2) itemspawns.Add(S)

				else
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							usr.client.eye = GC
							loc=locate(47,37,2)
							for(var/ItemSpawn/S in world)
								if(S.z == 2) itemspawns.Add(S)

		setCharacter(name)
			isPlayer=1
			dead=0
			character = "[name]"
			dir=RIGHT
			density=0
			setLandingLag("LIGHT")
			switch(name)

				if("Derek")
					icon='Characters/Derek.dmi'
					jump_speed = 6
					boostdefault = 2
					pixel_x=-22
					pixel_y=-16
					pwidth=22
					pheight=33
					fall_speed=6
					move_speed=5
					air_move_speed=4.5
					air_decel=0.14
					gravity=1
					carry_speed=2
					setPlayerLives(3)
				if("Sandbag")
					icon='Characters/Sandbag.dmi'
					jump_speed = 12
					boostdefault = 4
					pixel_x=-25
					pixel_y=-16
					pwidth=16
					pheight=33
					fall_speed=4
					move_speed=4
					carry_speed=3
					setPlayerLives(1)