UI
	KFK
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
			New(client./c)
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

			New(client./c)
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

			New(client./c)
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