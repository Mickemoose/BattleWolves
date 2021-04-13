/*

	Lazy Camera Springarm
	thanks to ter13 and lummoxjr

*/

atom/movable
	var
		camera_x = 0
		camera_y = 0

camera
	density = 0
	invisibility = 101
	parent_type = /mob
	var
		atom/movable/target
		tracking_factor = 1/4
	proc
		Track()
			if(target && loc)
				var/xpos = x*TILE_WIDTH + step_x
				var/ypos = y*TILE_HEIGHT + step_y
				var/dx = target.x*TILE_WIDTH + target:step_x + camera_x + target:camera_x - xpos
				var/dy = target.y*TILE_HEIGHT + target:step_y + camera_y + target:camera_y - ypos

				// Artificially increase tracking factor to ensure at least 1 pixel of movement
				var/maxdist = max(abs(dx), abs(dy))
				var/tf = tracking_factor
				if(maxdist)
					tf = max(min(1, 1/maxdist), tf)
				else
					return

				var/xoff = dx * tf + xpos
				var/yoff = dy * tf + ypos

				loc = locate(xoff/TILE_WIDTH, yoff/TILE_HEIGHT, target.z)
				step_x = xoff - (x * TILE_WIDTH)
				step_y = yoff - (y * TILE_HEIGHT)

		Recenter()
			if(target)
				loc = target.loc
				step_x = target.step_x
				step_y = target.step_y

		DestroyCamera()
			target = null
			loc = null

	New(loc,step_x,step_y)
		src.step_x = step_x
		src.step_y = step_y
		..()

client
	var
		camera/camera
	New()
		. = ..()
		camera = new(mob.loc,mob.step_x,mob.step_y)
		eye = camera
		//camera.target = mob
		CameraLoop()

	Del()
		camera.DestroyCamera()
		camera = null
		..()

	proc
		CameraTarget(mob/M)
			camera.target=M
		CameraRefresh()
			camera.target=src.mob
		CameraLoop()
			set waitfor = 0
			while(camera)
				camera.Track()
				sleep(world.tick_lag)