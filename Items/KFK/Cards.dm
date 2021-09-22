KFK_Mobs
	parent_type=/mob
	isPlayer=1
	lives=0
	var
		mob/owner
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
	Staryxia
		icon='Items/KFK/Staryxia.dmi'
		density=0
		scaffold=0
		isPlayer=0
		var/list/players=list()
		var/list/target=list()
		var/grabbed=0
		var/attacked=0
		var/list/diamond=list()
		can_bump(turf/t)
			return 0
		gravity()
		bump()
		movement()
			..()
		action()
			if(!grabbed)
				if(path || destination )
					follow_path()

				for(var/mob/M in target)

					if(!grabbed)
						move_towards(M)
						if(src.py < M.py+20)
							src.py+=2
						if(src.py > M.py+20)
							src.py-=2
						face(M)
						spawn(8)
							grabbed=1
							vel_x=0
							vel_y=0
							Magic()




			slow_down()
		proc
			Magic()
				if(!attacked)
					attacked=1
					icon_state="magic"
					var/mob/M=pick(target)
					M.hitstun=1
					M.overlays+=/obj/KFK_EFFECT/DiamondPrison
					spawn(15)
						M.vel_y=2
						spawn(5)
							M.vel_y=4
							spawn(5)
								M.vel_y=0
								spawn(5)
									M.overlays-=M.overlays
									world<<FIRESPLODE
									var/EFFECT/DEREK/USPECIAL/FX = new /EFFECT/DEREK/USPECIAL(M.loc)
									FX.step_x=M.step_x+16
									FX.step_y=M.step_y
									M.hitstun=0
									M.setDamage(0.11,"ADD")
									HitStun(M,1,"blue")
									spawn(1)
										M.Knockback(power = "MEDIUM", where = "UP RIGHT")
									spawn(5)
										icon_state=""
										vel_y=2
									spawn(7)
										vel_y=3.5
									spawn(10)
										vel_y=5
									spawn(15)
										Deactivate()

		Active()
			for(var/mob/M in Players_ALIVE)
				if(owner!=M && target.len<=0)
					players.Add(M)

			target.Add(pick(players))

	Jellypot
		icon='Items/KFK/Jellypot.dmi'
		density=0
		scaffold=0
		isPlayer=0
		dir=RIGHT
		bump()
		gravity()
		Active()
			spawn(3)
				flick("closed",src)
				spawn(4)
					icon_state=""
					src.dir=RIGHT
					var/ITEMS/O = text2path("/ITEMS/THROWABLES/JamJar/VARIANTS/Jelly")
					new O(src,thrown=1)
					spawn(4)
						flick("closed",src)
						spawn(4)
							icon_state=""
							src.dir=LEFT
							new O(src,thrown=1)
							spawn(4)
								flick("closed",src)
								spawn(4)
									icon_state=""
									src.dir=RIGHT
									new O(src,thrown=1)
									spawn(4)
										flick("closed",src)
										spawn(4)
											icon_state=""
											src.dir=LEFT
											new O(src,thrown=1)
											spawn(4)
												flick("closed",src)
												spawn(4)
													icon_state=""
													src.dir=RIGHT
													new O(src,thrown=1)
													flick("closed",src)
													spawn(4)
														icon_state=""
														src.dir=LEFT
														new O(src,thrown=1)
														spawn(4)
															flick("closed",src)
															spawn(4)
																icon_state=""
																src.dir=RIGHT
																new O(src,thrown=1)
																flick("closed",src)
																spawn(4)
																	flick("closed",src)
																	spawn(4)
																		icon_state=""
																		src.dir=LEFT
																		new O(src,thrown=1)
																		spawn(4)
																			Deactivate()


	NinjaSquidSquad
		icon='Items/KFK/NinjaSquid.dmi'
		icon_state="stay"
		density=0
		scaffold=0
		isPlayer=0
		bump()
		gravity()
		can_bump()
			return 0
		Active()
			spawn(1)
				icon_state="rise"
				src.vel_y=8
				spawn(2)
					icon_state="fall"
					src.vel_y=-12
					spawn(10)
						src.vel_y=0
						spawn(2)
							for(var/i=1, i<=10,i++)
								spawn(3)
									SquidSpawn()
								sleep(4)
								if(i ==20)
									Deactivate()



		proc
			SquidSpawn()
				var/mob/SQUID/B=new /mob/SQUID(src.loc)
				B.spawner=src.owner
				for(var/i=1, i<=20,i++)

					sleep(1)

	Beefalo
		icon='Items/KFK/Beefalo.dmi'
		density=0
		scaffold=0
		isPlayer=0
		bump()
		Active()
			spawn(2)
				for(var/i=1, i<=10,i++)
					flick("stomp",src)
					spawn(3)

						for(var/mob/m in view(src))
							m<<STOMP
							m.Shake("LIGHT")
						RockSpawn()
					sleep(4)
					if(i ==10)
						Deactivate()



		proc
			RockSpawn()
				var/mob/BOULDER/B=new /mob/BOULDER(src.loc)
				B.spawner=src.owner
				for(var/i=1, i<=10,i++)

					sleep(2)
	Hazorb
		icon='Items/KFK/Hazorb.dmi'
		pixel_x=-25
		pixel_y=-17
		pwidth=17
		pheight=26
		density=0
		scaffold=0
		isPlayer=0
		var/list/players=list()
		var/list/target=list()
		var/grabbed=0
		can_bump(turf/t)
			return 0
		gravity()
		bump()
		pixel_move(dpx, dpy)
			..()
			for(var/mob/m in Players_ALIVE)
				if(m.grabbedBy==src)
					m.pixel_move(move_x, move_y)
		movement()
			..()
			for(var/mob/m in oview(1,src))
				if(m.inside(src) && !grabbed && src.owner!=m)
					vel_x=0
					vel_y=0
					grabbed=1
					spawn(0.75)
						m.setMashing(src)
						set_pos(px,py+14)
						vel_y=4.3
						move_speed=4
						m.grabbedBy = src
		action()
			if(!grabbed)
				if(path || destination )
					follow_path()

				for(var/mob/M in target)
					if(!grabbed)
						move_towards(M)
						if(src.py < M.py+10)
							src.py+=2
						if(src.py > M.py+10)
							src.py-=2
						face(M)
			slow_down()
		Active()
			for(var/mob/M in Players_ALIVE)
				if(owner!=M)
					players.Add(M)
			target.Add(pick(players))

	Zeke
		icon='Items/KFK/Zeke.dmi'
		pixel_x=-23
		pixel_y=-1
		pwidth=19
		pheight=12
		density=0
		scaffold=0
		isPlayer=0
		var/shelled=0
		Active()
			spawn(10)
				shelled=1
				icon_state="shell"
				vel_x=6
				spawn(100)
					Deactivate()
		action()
			if(at_edge())
				turn_around()
			//..()
		bump()
		movement()
			..()
			if(shelled)
				for(var/mob/M in oview(1,src))
					if(M.isPlayer && M.hitIndex!="Zeke" && M.inside(src))
						M.hitIndex="Zeke"
						world<<HIT
						HitStun(M,1)
						M.setDamage(pick(0.02),"ADD")
						spawn(1)
							if(M.dir==RIGHT)
								M.Knockback(power = "NONE", where = "UP RIGHT")
							else
								M.Knockback(power = "NONE", where = "UP LEFT")
						spawn(6)
							M.hitIndex="null"
	RabbitSuit
		icon='Items/KFK/RabbitSuit/RabbitSuit.dmi'
		icon_state=""
		pixel_x=-24
		pixel_y=-5
		fall_speed=5
		density=0
		scaffold=0
		hitstun=1
		isPlayer=0
		can_bump(turf/t)
			return 0
		gravity()
		bump()
		movement()
			..()
		Active()
			vel_y=4
			animate(src, alpha = 0, transform = matrix()/4, color = "black", time = 3)
			spawn(5)
				vel_y=0
				for(var/mob/m in view(src))
					m<<NEWS
					var/UI/KFK/RabbitSuit/C3 = new /UI/KFK/RabbitSuit(m.client)
					var/UI/KFK/RabbitLive/C4 = new /UI/KFK/RabbitLive(m.client)
					var/UI/KFK/RabbitLogo/C5 = new /UI/KFK/RabbitLogo(m.client)
					var/UI/KFK/RabbitHeadline/C6 = new /UI/KFK/RabbitHeadline(m.client)

					spawn(130)
						if(m.isPlayer)

							C3.deactive()
							C4.deactive()
							C5.deactive()
							C6.deactive()
							spawn(5)
								Deactivate()
		bump()
	Steve
		//icon='Items/KFK/Steve.dmi'
		//icon_state="stand"
		pixel_x=-24
		pixel_y=-5
		fall_speed=5
		density=0
		scaffold=0
		hitstun=1
		isPlayer=0
		Active()
			spawn(10)
				for(var/mob/m in view(src))
					var/UI/KFK/SunBackground/C1 = new /UI/KFK/SunBackground(m.client)
					//var/UI/KFK/SunForeground/C2 = new /UI/KFK/SunForeground(m.client)
					var/UI/KFK/Steve/C3 = new /UI/KFK/Steve(m.client)

					var/obj/overlay = new /obj/

					spawn(7.5)
						if(m.isPlayer && owner!=m)

							overlay.icon=m.icon
							overlay.layer=m.layer+1
							overlay.blend_mode=BLEND_MULTIPLY

							animate(overlay, color=rgb(204, 102, 0,255), time=2)
							overlay.WaterEffect()
							m.overlays+=overlay
							m.burning=1
							m.setBurning()
					spawn(100)
						if(m.isPlayer)
							m.overlays-=overlay
							del overlay
							m.burning=0
						//	icon_state="stand"
							C1.deactive()
							C3.deactive()
							spawn(5)
								Deactivate()
		bump()
	PhormPhather
		icon='Items/KFK/Phorm.dmi'
		icon_state="stand"
		pixel_x=-24
		pixel_y=-5
		fall_speed=5
		density=0
		scaffold=0
		isPlayer=0
		Active()
			spawn(10)
				flick("",src)
				spawn(4)
					icon_state="watch"
					for(var/mob/m in view(src))
						var/UI/KFK/Clock/C1 = new /UI/KFK/Clock(m.client)

						var/UI/KFK/Hand/C2 = new /UI/KFK/Hand(m.client)
						spawn(7.5)
							if(m.isPlayer && owner!=m)
								animate(m, color=rgb(102, 0, 255,255))
								m.gravity=0.1
								m.jump_speed=1
								m.fall_speed=0.2
								m.move_speed=1
								m.air_move_speed=1
								m.air_decel=0.1
								m.carry_speed=1
						spawn(100)
							if(m.isPlayer  && owner!=m)
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
								HitStun(M,1)
								M.setDamage(pick(0.08),"ADD")
								spawn(1)
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
