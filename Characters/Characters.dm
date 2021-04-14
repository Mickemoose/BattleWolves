mob
	proc
		Death()
			client.has_key(null)
			on_wall=0
			setPlayerLives(1,"REMOVE")
			canMove=0
			canAct=0
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
					Players_ALIVE.Remove(src)
					UpdateWorldUI(src)
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
				setPlayerLives(6)
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
			for(var/ItemSpawn/S in world)
				if(S.z == z)
					itemspawns.Add(S)
			switch(name)
				if("debug")
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							usr.client.eye = GC

				else
					for(var/GameCamera/GC in world)
						if(GC.z == 2)
							usr.client.eye = GC

		setCharacter(name)
			isPlayer=1
			character = "[name]"
			dir=RIGHT
			density=0
			setLandingLag("LIGHT")
			switch(name)

				if("Derek")
					icon='Characters/Derek.dmi'
					jump_speed = 10
					boostdefault = 8
					pixel_x=-22
					pixel_y=-16
					pwidth=22
					pheight=33
					fall_speed=9
					move_speed=5
					carry_speed=2
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