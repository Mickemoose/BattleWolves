GameCamera
	icon='System/Camera.dmi'
	invisibility=101
	density=0
	parent_type=/obj


mob
	proc
		Shake(level="MEDIUM")
			//var/matrix/m = matrix()
			switch(level)
				if("LIGHT")
					animate(src.client, pixel_y=pick(-rand(6,14),rand(6,14)), pixel_x=pick(-rand(6,14),rand(6,14)), time=8, easing=BOUNCE_EASING)
				if("MEDIUM")
					animate(src.client, pixel_y=pick(-rand(40,50),rand(40,50)), pixel_x=pick(-rand(40,50),rand(40,50)), time=15, easing=BOUNCE_EASING)
					//animate(pixel_y=pick(-rand(30,80),rand(30,80)), pixel_x=pick(-rand(30,80),rand(30,80)), time=5, easing=BOUNCE_EASING)


ItemSpawn
	icon='System/Camera.dmi'
	icon_state="item"
	invisibility=101
	parent_type=/obj
RespawnSpawn
	icon='System/Camera.dmi'
	icon_state="respawn"
	invisibility=101
	parent_type=/obj
	var
		taken=0
		takenBy