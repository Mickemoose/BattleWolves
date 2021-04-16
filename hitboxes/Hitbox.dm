



obj/hitbox
	icon='HitBox/dot.dmi'
	var/tmp/mob/owner
	proc/onHit(mob/m)
	firey
		onHit(mob/m)
	New(mob/m,px,py,_bounds="1,1 to 2,2",frames=1)
		..()
		m.contents -= src//shhhhh
		owner = m
		if(m.dir==LEFT)
			px=-px
		bounds = _bounds
		var/matrix/M = matrix()
		M.Scale(px,py)
		animate(src,transform = M,time=0)
		color=rgb(255,0,0,220)
		layer=8
		SetCenter(m.Cx()+px,m.Cy()+py,m.z)//using kaiochao's absolute positions library
		spawn()//ter will hate me for it but spawn is used here because there is a looping while() in the active() proc and i don't want to stall any code
			active(frames,px,py)
	proc/active(frames,px,py)
		var/hit_mobs = list(owner)
		while(frames--)//repeat this a number of times equal to frames
			for(var/mob/m in obounds(0,src)-hit_mobs)//look for a person you haven't hit yet. locate() might be a faster alternative, but it doesn't let you hit two mobs in a single frame unless you loop it until you can't find a mob. this code is simpler.
				onHit(m)
			SetCenter(owner.Cx()+px,owner.Cy()+py,owner.z)//this keeps the hitbox on the player
			sleep(world.tick_lag)
		del(src)
mob/proc/hitbox(_bounds,px,py,frames,hitbox_type=/obj/hitbox)
	new hitbox_type(src,px,py,_bounds,frames)