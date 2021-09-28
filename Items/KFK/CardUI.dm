UI
	KFK
		RabbitSuit
			icon = 'Items/KFK/RabbitSuit/RabbitSuit.dmi'
			icon_state=""
			plane=10000
			screen_loc="CENTER+1,CENTER+2:-14"
			appearance_flags = PIXEL_SCALE
			var/mob/owner
			New(client/c)
				c.screen+=src
				owner=c
				animate(src,transform=matrix()*4, time=0)
				animate(src,transform=matrix().Translate(0,400)*4, time=0, easing=SINE_EASING)
				spawn(1)
					active()
			proc
				active()

					animate(src,transform=matrix().Translate(0,0)*4, time=10, easing=QUAD_EASING)

					spawn(11)
						flick("cough",src)
						owner<<NEWSCLEAR
					spawn(20)
						icon_state="talking"
						owner<<NEWSCAST
					spawn(25)
						icon_state=""
					spawn(30)
						icon_state="talking"
					spawn(44)
						icon_state=""
					spawn(50)
						flick("cough",src)
						owner<<NEWSCLEAR
					spawn(55)
						icon_state=""
					spawn(60)
						icon_state="talking"
						owner<<NEWSCAST
					spawn(70)
						icon_state="talking"
					spawn(100)
						icon_state=""
				deactive()
					animate(src,transform=matrix().Translate(0,400)*4, time=6, easing=QUAD_EASING)
					spawn(4)
						del src
		RabbitLogo
			icon = 'Items/KFK/RabbitSuit/NewsLogo.dmi'
			icon_state=""
			plane=10000
			screen_loc="CENTER-11,CENTER+6"
			appearance_flags = PIXEL_SCALE
			New(client/c)
				c.screen+=src
				animate(src,transform=matrix()*2, time=0)
				animate(src,transform=matrix().Translate(400,0)*2, time=0, easing=SINE_EASING)
				spawn(1)
					active()
			proc
				active()
					animate(src,transform=matrix().Translate(0,0)*2, time=10, easing=QUAD_EASING)
				deactive()
					animate(src,transform=matrix().Translate(400,0)*2, time=6, easing=QUAD_EASING)
					spawn(4)
						del src
		RabbitLive
			icon = 'Items/KFK/RabbitSuit/Live.dmi'
			icon_state=""
			plane=10000
			screen_loc="CENTER+10,CENTER+5"
			appearance_flags = PIXEL_SCALE
			New(client/c)
				c.screen+=src
				icon_state="[Stage_Selected]"
				animate(src,transform=matrix()*2, time=0)
				animate(src,transform=matrix().Translate(-400,0)*2, time=0, easing=SINE_EASING)
				spawn(1)
					active()
			proc
				active()
					animate(src,transform=matrix().Translate(0,0)*2, time=10, easing=QUAD_EASING)
				deactive()
					animate(src,transform=matrix().Translate(-400,0)*2, time=6, easing=QUAD_EASING)
					spawn(4)
						del src
		RabbitHeadline
			icon = 'Items/KFK/RabbitSuit/Headline.dmi'

			plane=10000
			screen_loc="CENTER-7,CENTER-6"
			appearance_flags = PIXEL_SCALE
			New(client/c)
				c.screen+=src
				icon_state=pick("1","2","3","4")
				animate(src,transform=matrix()*2, time=0)
				animate(src,transform=matrix().Translate(0,-400)*2, time=0, easing=SINE_EASING)
				spawn(1)
					active()
			proc
				active()
					animate(src,transform=matrix().Translate(0,0)*2, time=10, easing=QUAD_EASING)
				deactive()
					animate(src,transform=matrix().Translate(0,-400)*2, time=6, easing=QUAD_EASING)
					spawn(4)
						del src

		SunBackground
			icon = 'System/fade.dmi'
			icon_state="white"
			screen_loc = "NORTHWEST to SOUTHEAST"
			New(client/c)
				c.screen+=src
				animate(src, alpha=50,time=0, easing=SINE_EASING)
				animate(color="yellow", alpha=25,time=3, easing=SINE_EASING)
			//	active()
			proc
				active()
				deactive()
					animate(src, alpha=0,time=5, easing=SINE_EASING)
					spawn(5)
						del src
		SunForeground
			icon = 'System/fade.dmi'
			icon_state="splot"
			screen_loc = "NORTHWEST to SOUTHEAST"
			New(client/c)
				c.screen+=src
				src.filters += Blur
				animate(src, alpha=0,time=0, easing=SINE_EASING)
				animate(color="#cc6600", alpha=120,time=3, easing=SINE_EASING)
				active()
			proc
				active()
					src.WaterEffect()
		Steve
			icon='Items/KFK/Steve.dmi'
			plane=-3
			screen_loc="CENTER-5,CENTER-2"
			New(client/c)

				c.screen+=src
				animate(src,transform=matrix().Translate(0,400), time=0, easing=SINE_EASING)
				spawn(1)
					active()
			proc
				active()
					animate(src,transform=matrix().Translate(0,0), time=25, easing=QUAD_EASING)
				deactive()
					animate(src,transform=matrix().Translate(0,400), time=6, easing=QUAD_EASING)
					spawn(4)
						del src
		Clock
			icon='Items/KFK/Clock.dmi'
			icon_state="base"
			screen_loc="CENTER-3,CENTER-2"

			New(client/c)
				c.screen+=src

				active()
			proc
				active()
					animate(src,transform=matrix().Translate(-600,0), time=0, easing=SINE_EASING, flags=ANIMATION_PARALLEL)
					animate(transform=matrix().Translate(0,0), time=5, easing=SINE_EASING, flags=ANIMATION_PARALLEL)

					animate( alpha=200,time=5, flags=ANIMATION_PARALLEL)
					src.WaterEffectTransparent()
				deactive()
					animate(src,transform=matrix().Translate(600,0), time=5, easing=SINE_EASING)
					spawn(4)
						del src


		Hand
			icon='Items/KFK/Clock.dmi'
			icon_state="hand"
			screen_loc="CENTER-3,CENTER-2"

			New(client/c)
				c.screen+=src

				active()
			proc
				active()
					animate(src,transform=matrix().Translate(-600,0), time=0, easing=SINE_EASING, flags=ANIMATION_PARALLEL)
					animate(transform=matrix().Translate(0,0), time=5, easing=SINE_EASING, flags=ANIMATION_PARALLEL)
					//src.filters += WhiteOutline
					animate( alpha=200,time=5, flags=ANIMATION_PARALLEL)
					spawn(7)
						animate(src, transform = turn(matrix(), 120), time = 6, loop = -1)
						animate(transform = turn(matrix(), 240), time = 6, loop = -1)
						animate(transform = null, time = 6, loop = -1)
				deactive()
					animate(src,transform=matrix().Translate(600,0), time=5, easing=SINE_EASING)
					spawn(4)
						del src