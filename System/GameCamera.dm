GameCamera
	icon='System/Camera.dmi'
	invisibility=101
	parent_type=/mob
	set_state()
	gravity()
	move()
	pixel_move()
mob
	proc
		Shake(c=rand(4,10))
			pixel_x -= c
			pixel_y -= c
			animate(src,pixel_x=pixel_x+c,pixel_y=pixel_y+c,time=6,easing=BOUNCE_EASING)

ItemSpawn
	icon='System/Camera.dmi'
	icon_state="item"
	invisibility=101
	parent_type=/obj