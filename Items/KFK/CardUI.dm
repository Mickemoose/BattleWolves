UI
	KFK

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