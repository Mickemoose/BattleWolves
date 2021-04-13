mob
	proc
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