mob
	var
		target
	proc
		OOV_Circle()


OOV_Circle
	appearance_flags = PIXEL_SCALE
	parent_type = /obj
	plane=FLOAT_PLANE+1
	icon='UI/OOV.dmi'
	screen_loc = "CENTER,CENTER"
	var
		tracking
	New(client/C)
		C.screen += src
OOV_Arrow
	appearance_flags = PIXEL_SCALE
	parent_type = /obj
	plane=FLOAT_PLANE+1
	icon='UI/OOV.dmi'
	icon_state="arrow"
	screen_loc = "CENTER,CENTER"
	var
		tracking
	New(client/C)
		C.screen += src

proc
	get_angle_nums(ax,ay,bx,by)
		var/val = sqrt((bx - ax) * (bx - ax) + (by - ay) * (by - ay))
		if(!val) return 0
		var/ar = arccos((bx - ax) / val)
		var/deg = round(360 - (by - ay >= 0 ? ar : -ar), 1)
		while(deg > 360) deg -= 360
		while(deg < 0) deg += 360
		return deg


#include <kaiochao/pixelpositions/pixelpositions.dme>

mob
	proc/PointArrow(OOV_Arrow/Arrow, atom/Target, MinDistance, ArrowDistance)
		for(var/GameCamera/GC in world)
			if(GC.z == src.z)
				#if DM_VERSION < 509
				if(isnull(MinDistance)) MinDistance = min(client.ViewPixelWidth(), client.ViewPixelHeight()) * (5/8)
				if(isnull(ArrowDistance)) ArrowDistance = min(client.ViewPixelWidth(), client.ViewPixelHeight()) * (3/8)
				#else
				if(isnull(MinDistance)) MinDistance = min(client.bound_width, client.bound_height) * (5/8)
				if(isnull(ArrowDistance)) ArrowDistance = min(client.bound_width, client.bound_height) * (4.5/8)
				#endif
				var dx = Target.CenterX() - GC.CenterX()
				var dy = Target.CenterY() - GC.CenterY()
				var dot = dx*dx + dy*dy
				if(dot < MinDistance * MinDistance)
					Arrow.screen_loc = null

					return
				Arrow.screen_loc = "CENTER"

				var matrix/m = new
				m.Translate(0, ArrowDistance)
				m.Turn(dx > 0 ? arccos(dy / sqrt(dot)) : -arccos(dy / sqrt(dot)))
				Arrow.transform = initial(Arrow.transform) * m

