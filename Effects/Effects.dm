EFFECT
	parent_type=/obj
	plane=FLOAT_PLANE+2
	appearance_flags= PIXEL_SCALE
	density=0

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
		NSPECIAL
			icon='Effects/Derek/NSpecial.dmi'
			pwidth=120
			pheight=120
			New()
				flick("",src)

mob
	EFFECT
		set_state()
		gravity()
		//movement()
		//action()
		bump()
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


