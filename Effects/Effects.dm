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
				//world<<HIT
				for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,src))
					if(W.inside(src))
						if(dir==RIGHT) W.vel_x=4
						else W.vel_x=-4
				for(var/mob/M in oview(1,src))
					if(M.inside(src))
						if(M.hitIndex!="DerekNS" && M.isPlayer)
							M.hitIndex="DerekNS"
							flick("hit",M)
							M.face(src)
							M.HitStun(M,4)
							M.setDamage(0.3,"ADD")
							spawn(4)
								flick("hitend",M)
								// if you're to the left of a
								if(M.px + M.pwidth / 2 < px + pwidth / 2)
									M.Knockback(power = "HEAVY", where = "UP LEFT")
								// otherwise you're to the right of a
								else
									M.Knockback(power = "HEAVY", where = "UP RIGHT")

							spawn(6)
								M.hitIndex="null"
				spawn(0.5)
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.hitIndex!="DerekNS" && M.isPlayer)
								M.hitIndex="DerekNS"
								flick("hit",M)
								M.face(src)
								M.HitStun(M,4)
								M.setDamage(0.3,"ADD")
								spawn(4)
									flick("hitend",M)
									// if you're to the left of a
									if(M.px + M.pwidth / 2 < px + pwidth / 2)
										M.Knockback(power = "HEAVY", where = "UP LEFT")
									// otherwise you're to the right of a
									else
										M.Knockback(power = "HEAVY", where = "UP RIGHT")

								spawn(6)
									M.hitIndex="null"
				spawn(1)
					//world<<HIT
					for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,src))
						if(W.inside(src))
							if(dir==RIGHT) W.vel_x=4
							else W.vel_x=-4
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.hitIndex!="DerekNS1" && M.isPlayer)
								M.hitIndex="DerekNS1"
								flick("hit",M)
								M.face(src)
								M.HitStun(M,4)
								M.setDamage(0.5,"ADD")
								spawn(4)
									flick("hitend",M)
									// if you're to the left of a
									if(M.px + M.pwidth / 2 < px + pwidth / 2)
										M.Knockback(power = "HEAVY", where = "UP LEFT")
									// otherwise you're to the right of a
									else
										M.Knockback(power = "HEAVY", where = "UP RIGHT")

								spawn(6)
									M.hitIndex="null"
				spawn(1.5)
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.hitIndex!="DerekNS1" && M.isPlayer)
								M.hitIndex="DerekNS1"
								flick("hit",M)
								M.face(src)
								M.HitStun(M,4)
								M.setDamage(0.5,"ADD")
								spawn(4)
									flick("hitend",M)
									// if you're to the left of a
									if(M.px + M.pwidth / 2 < px + pwidth / 2)
										M.Knockback(power = "HEAVY", where = "UP LEFT")
									// otherwise you're to the right of a
									else
										M.Knockback(power = "HEAVY", where = "UP RIGHT")

								spawn(6)
									M.hitIndex="null"
				spawn(2)
				//	world<<HIT
					for(var/ITEMS/CONTAINERS/Wheel_Crate/W in oview(1,src))
						if(W.inside(src))
							if(dir==RIGHT) W.vel_x=4
							else W.vel_x=-4
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.hitIndex!="DerekNS2" && M.isPlayer)
								M.hitIndex="DerekNS2"
								flick("hit",M)
								M.face(src)
								M.HitStun(M,4)
								M.setDamage(0.3,"ADD")
								spawn(4)
									flick("hitend",M)
									// if you're to the left of a
									if(M.px + M.pwidth / 2 < px + pwidth / 2)
										M.Knockback(power = "HEAVY", where = "UP LEFT")
									// otherwise you're to the right of a
									else
										M.Knockback(power = "HEAVY", where = "UP RIGHT")

								spawn(6)
									M.hitIndex="null"
				spawn(2.5)
					for(var/mob/M in oview(1,src))
						if(M.inside(src))
							if(M.hitIndex!="DerekNS2" && M.isPlayer)
								M.hitIndex="DerekNS2"
								flick("hit",M)
								M.face(src)
								M.HitStun(M,4)
								M.setDamage(0.3,"ADD")
								spawn(4)
									flick("hitend",M)
									// if you're to the left of a
									if(M.px + M.pwidth / 2 < px + pwidth / 2)
										M.Knockback(power = "HEAVY", where = "UP LEFT")
									// otherwise you're to the right of a
									else
										M.Knockback(power = "HEAVY", where = "UP RIGHT")

								spawn(6)
									M.hitIndex="null"