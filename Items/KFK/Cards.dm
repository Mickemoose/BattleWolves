KFK_Mobs
	parent_type=/mob
	isPlayer=1
	lives=0
	var
		owner
		timer=100
	set_state()
	//bump()
	New()
		..()
		reeled=1
		dir=RIGHT
		vel_y=8
		spawn(2)
			vel_y=0
			spawn(2)
				reeled=0
				Timer()
				Active()
	proc
		Active()
		Timer()
			timer--
			if(timer<=0)
				Deactivate()
			if(timer>0)
				spawn(5)
					Timer()
		Deactivate()
			animate(src, alpha = 0, transform = matrix()/4, color = "black", time = 3)
			spawn(3)
				Current_KFK--
				del src
	Doop
		icon='Items/KFK/Doop.dmi'
		icon_state=""
		pixel_x=-19
		pixel_y=-16
		pwidth=24
		fall_speed=5
		pheight=20
		density=0
		scaffold=0
		var
			mob/target
			targeted=0
			list/targetlist=list()


		proc

			Scan()
				if(!targeted)
					for(var/mob/m in view())
						if(!m.dead && m.on_ground)
							targetlist.Add(m)
					target=pick(targetlist)
					Target()


			Target()
				targeted=1
				for(target in view())
					if(!target.dead)
						face(target)
						flick("intent",src)
						spawn(6)
							icon_state="targeted"

								//Attack()

			Attack()
				reeled=0
				hitstun=0
				icon_state="attack"
			Spin()
				animate(src, transform = turn(matrix(), 120), time = 0.5, loop = -1)
				animate(transform = turn(matrix(), 240), time = 0.5, loop = -1)
				animate(transform = null, time = 0.5, loop = -1)

		bump(atom/a, d)
			if(d==DOWN)
				hitstun=0
				reeled=0
			..()
				//animate(transform = null, loop = -1)
	//
	//			Target()

		action()


			if(at_edge()&&on_ground)
				turn_around()
			if(!targeted && !reeled && !hitstun)
				for(var/mob/M in front(6))
					if(M.inside(src))
						if(M.hitIndex!="Doop1" && M.isPlayer && !reeled && !hitstun)
							targeted=1
							if(hitstun) return
							flick("intent",src)
							spawn(3.5)
								if(hitstun) return
								M.hitIndex="Doop1"
								flick("hit",M)
								HitStun(M,1)
								M.setDamage(pick(0.08),"ADD")
								spawn(1)
									flick("hitend",M)
									M.Knockback(power = "MEDIUM", where = "UP RIGHT")
								spawn(6)
									M.hitIndex="null"
									targeted=0
									Active()
				..()

		Active()
			if(!targeted && !reeled && !hitstun)
				spawn(rand(15,20))

					if(prob(50) && !targeted && !reeled && !hitstun)
						if(dir==RIGHT && !targeted && !reeled && !hitstun)
							vel_x=6
							vel_y=2
							icon_state="moving"
							view()<<FOOTSTEP
							spawn(rand(5,10))
								vel_x=0
								icon_state=""
								spawn(20)
									if(prob(50))
										Active()


						if(dir==LEFT && !targeted && !reeled && !hitstun)
							vel_y=2
							vel_x=-6
							icon_state="moving"
							view()<<FOOTSTEP
							spawn(rand(5,10))
								vel_x=0
								icon_state=""
								spawn(20)
									if(prob(50))
										Active()


					else if(prob(50) && !targeted && !reeled && !hitstun)
						if(dir==RIGHT && !targeted && !reeled && !hitstun)
							dir=LEFT
							spawn(20)
								Active()
						else
							dir=RIGHT
							spawn(20)
								Active()
