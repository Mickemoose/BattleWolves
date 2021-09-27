EFFECT
	parent_type=/obj
	plane=FLOAT_PLANE+2
	appearance_flags= PIXEL_SCALE
	density=0
	BIG_HIT
		icon='Effects/Hit.dmi'
		New()
			..()
			Ripple()
			spawn(9)
				del src
		proc/Ripple()
			filters += filter(type="ripple", size = 10, radius = 10, falloff = 4, repeat=5, flags = 0 )
			var f = filters[filters.len]
			animate(f, time = 5, easing = LINEAR_EASING, radius = 90, size=0, flags =ANIMATION_PARALLEL)
			spawn(10)
				filters-=f
	MASH_ALERT
		icon='Effects/Mash.dmi'
	DASH_SMOKE
		icon='Effects/DashSmoke.dmi'
		icon_state=""
	SLIDE_SMOKE
		icon='Effects/SlideSmoke.dmi'
		icon_state=""
	LANDING_SMOKE
		icon='Effects/LandingSmoke.dmi'
		icon_state=""
	BLAST
		icon='Effects/Blast.dmi'
		icon_state=""
	KBSMOKE
		icon='Effects/KBSmoke.dmi'
		icon_state=""
		var
			level=0
		New()
			flick("",src)
			if(!level)
				animate(src, transform = matrix(), time=2)
				animate(transform = matrix()*1.2, time=2)
				animate(transform = matrix()*1.5, time=2)
				animate(transform = matrix()*1.8, alpha=100, time=2)
				animate(transform = matrix()*2, alpha=0,time = 3)
			if(level==1)
				animate(src, transform = matrix(), color="#ffcc66", time=2)
				animate(transform = matrix()*1.8,color="#ff9933", time=2)
				animate(transform = matrix()*2, color="#cc6600", time=2)
				animate(transform = matrix()*2.4, color="#663300",alpha=100, time=2)
				animate(transform = matrix()*2.6, alpha=0,time = 3)
			if(level==2)
				animate(src, transform = matrix(), color="#ff6e00", time=2)
				animate(transform = matrix()*1.5,color=rgb(255, 204, 0), time=2)
				animate(transform = matrix()*2, color="#4d0000", time=2)
				animate(transform = matrix()*2.5, color="#524e4e", alpha=100, time=2)
				animate(transform = matrix()*3, alpha=0,time = 3)
	DEREK
		USPECIAL
			icon='Effects/Derek/BlueSplode.dmi'
			New()
				animate(src, transform=matrix()*2)
				flick("",src)
				spawn(8)
					del src
		NSPECIAL
			icon='Effects/Derek/NSpecial.dmi'
			pwidth=120
			pheight=120
			New()
				flick("",src)

mob
	EFFECT
		appearance_flags = PIXEL_SCALE
		set_state()
		gravity()
		//movement()
		//action()
		bump()
		proc
			setSpinning()
				animate(src, transform = turn(matrix(), 120), time = 3, loop = -1)
				animate(transform = turn(matrix(), 240), time = 3, loop = -1)
				animate(transform = null, time = 3, loop = -1)
		SMITTY
			var/mob/Spirits/owner
			density=0
			scaffold=0
			STARGREEN
				icon='Effects/Smitty/Star.dmi'
				icon_state="green"
				pixel_x=-17
				pixel_y=-17
				pwidth=30
				pheight=30
				New(mob/owner)
					owner=owner
					loc=owner.loc
					set_pos(owner.px-4, owner.py)

					animate(src,transform=matrix(0.1,0,0,0,0.1,16),alpha=255, flags=ANIMATION_PARALLEL)
					spawn(0.1)
						vel_x=5
						setSpinning()

						animate(src,transform=matrix()*1, time=3, flags=ANIMATION_PARALLEL)
						spawn(6)
							animate(src,alpha=0, time=2, flags=ANIMATION_PARALLEL)
							spawn(2)
								del src
				action()
					..()
					for(var/mob/m in oview(1,src))
						if(m.inside(src))
							if(m.isPlayer && !m.INVINCIBLE && m.hitIndex!="SmittyStar" && src.owner!=src.owner.owner)
								m.hitIndex="SmittyStar"
								HitStun(m,1)
								spawn(1)
									if(m.px + m.pwidth / 2 < px + pwidth / 2)
										m.Knockback("LIGHT", "LEFT")
									// otherwise you're to the right of a
									else
										m.Knockback("LIGHT", "RIGHT")
								m.setDamage(0.02, "ADD")
								spawn(8)
									if(m.hitIndex=="SmittyStar")
										m.hitIndex=null

			STARBLUE
				icon='Effects/Smitty/Star.dmi'
				icon_state="blue"
				pixel_x=-17
				pixel_y=-17
				pwidth=30
				pheight=30
				New(mob/owner)
					owner=owner
					loc=owner.loc
					set_pos(owner.px-8, owner.py)

					animate(src,transform=matrix(0.1,0,0,0,0.1,16),alpha=255, flags=ANIMATION_PARALLEL)
					spawn(0.1)
						vel_x=-5
						setSpinning()

						animate(src,transform=matrix()*1, time=3, flags=ANIMATION_PARALLEL)
						spawn(6)
							animate(src,alpha=0, time=2, flags=ANIMATION_PARALLEL)
							spawn(2)
								del src
				action()
					..()
					for(var/mob/m in oview(1,src))
						if(m.inside(src))
							if(m.isPlayer && !m.INVINCIBLE && m.hitIndex!="SmittyStar"  && src.owner!=src.owner.owner)
								m.hitIndex="SmittyStar"
								HitStun(m,1)
								spawn(1)
									if(m.px + m.pwidth / 2 < px + pwidth / 2)
										m.Knockback("LIGHT", "LEFT")
									// otherwise you're to the right of a
									else
										m.Knockback("LIGHT", "RIGHT")
								m.setDamage(0.02, "ADD")
								spawn(8)
									if(m.hitIndex=="SmittyStar")
										m.hitIndex=null
		DEREK
			SSPECIAL
				icon='Effects/Derek/SSpecial.dmi'
				pwidth=12
				pheight=120
				pixel_x=-10
				density=0
				scaffold=0
				var/owner
				New(mob/owner)
					owner=owner
					spawn(1)
						flick("",src)
						spawn(3)
							flick("plume",src)
							spawn(6)
								del src


