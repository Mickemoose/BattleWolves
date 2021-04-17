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
				Items_ACTIVE.Remove(src)
				del src
	PhormPhather
		icon='Items/KFK/Phorm.dmi'
		icon_state="stand"
		pixel_x=-24
		pixel_y=-5
		fall_speed=5
		density=0
		scaffold=0

		Active()
			spawn(10)
				flick("",src)
				spawn(4)
					icon_state="watch"
					for(var/mob/m in view())
						if(m.client && owner!=m)
							var/UI/KFK/Clock/C1 = new /UI/KFK/Clock(m.client)

							var/UI/KFK/Hand/C2 = new /UI/KFK/Hand(m.client)
							spawn(7.5)
								if(m.isPlayer)
									animate(m, color=rgb(102, 0, 255,255))
									m.gravity=0.1
									m.jump_speed=1
									m.fall_speed=0.2
									m.move_speed=1
									m.air_move_speed=1
									m.air_decel=0.1
									m.carry_speed=1
							spawn(100)
								if(m.isPlayer)
									animate(m, color=rgb(255, 255, 255,255))
									m.setCharacter(m.character)
								icon_state="stand"
								C1.deactive()
								C2.deactive()
								spawn(5)
									Deactivate()
		bump()
		action()
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
