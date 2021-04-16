



obj/hitbox
	icon='hitboxes/dot.dmi'
	var/tmp/mob/owner
	density=0

	New(mob/m,px,py,_bounds="1,1 to 2,2",frames=1,hitstun=1,knockback="LIGHT",direction="UP RIGHT")
		..()
		m.contents -= src//shhhhh
		owner = m
		if(m.dir==LEFT)
			px=-px
		bounds = _bounds
		var/matrix/M = matrix()
		M.Scale(px,py)
		animate(src,transform = M,alpha=100,time=0)
		color=rgb(255,0,0,100)
		plane=8
		loc=owner.loc
		spawn()//ter will hate me for it but spawn is used here because there is a looping while() in the active() proc and i don't want to stall any code
			active(frames,px,py,hitstun=hitstun,knockback=knockback,direction=direction)
	proc/active(frames,px,py,hitstun,knockback,direction)
		//var/hit_mobs = list(owner)
		while(frames--)//repeat this a number of times equal to frames
			for(var/mob/m in obounds(0,src)-owner)//look for a person you haven't hit yet. locate() might be a faster alternative, but it doesn't let you hit two mobs in a single frame unless you loop it until you can't find a mob. this code is simpler.
				if(m.isPlayer && m.hitIndex!=src)


					owner.HitStun(m,hitstun)
					spawn(2) m.Knockback(power = knockback, where = direction)
					m.hitIndex=src
			for(var/ITEMS/CONTAINERS/Wheel_Crate/W in obounds(0,src)-owner)
				if(W.hitIndex!=src)
					W.hitIndex=src
					if(dir==RIGHT) W.vel_x=4
					else W.vel_x=-4




			sleep(world.tick_lag)
		del(src)
mob/proc/hitbox(_bounds,px,py,frames,hitstun,knockback,direction,hitbox_type=/obj/hitbox)
	new hitbox_type(src,px,py,_bounds,frames,hitstun,knockback,direction)