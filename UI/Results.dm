UI
	Results
		Background
			plane=1
			icon='UI/Background.dmi'
			icon_state="result"
			screen_loc="CENTER-8,CENTER-4"
			New(client/c)
				c.screen+=src
				animate(src,transform=matrix()*2)
		Winner
			plane=1
			icon='UI/Results.dmi'
			icon_state="result"
			screen_loc="CENTER-8,CENTER-4:-64"
			New(client/c)
				c.screen+=src
				animate(src, transform=matrix().Translate(-600,0), color=rgb(40,40,40,255))
				animate( transform=matrix().Translate(0,0), color=rgb(255,255,255,255), easing=BOUNCE_EASING, time=5)


mob
	proc
		ResultsEnd()
			fade.FadeOut(time=3)
			StopSnow()
			spawn(4)
				new /UI/BACK(src.client)
				new /UI/FIRE2(src.client)
				new /UI/FIRE(src.client)
				new /UI/FRAME(src.client)
			for(var/UI/Results/Background/B in src.client.screen)
				animate(B, transform=matrix().Translate(0,600), easing=BOUNCE_EASING, time=5)
				spawn(5)
					del(B)
			for(var/UI/Results/Winner/W in src.client.screen)
				animate(W, transform=matrix().Translate(0,600), color=rgb(0,0,0,255), easing=BOUNCE_EASING, time=5)
				spawn(5)
					del(W)
			spawn(6)
				fade.FadeIn(time=3)
				src.client.lock_input()
				for(var/obj/CSS/Plates/p in world)
					p.CheckPlayers()
				spawn(13)
					CSS_Initialize()
				spawn(15)
					src.client.unlock_input()
					src.inResults=0
		Results()
			new /UI/Results/Background(src.client)
			spawn(3)
				var/UI/Results/Winner/W = new /UI/Results/Winner(src.client)
				W.icon_state=Winner
				src<<FANFARE
				CreateSnow()
				var/UI/KFK/SunBackground/C1 = new /UI/KFK/SunBackground(src.client)
				animate(C1, color="white", alpha=0,time=0, easing=SINE_EASING)
				animate( alpha=24,time=2, easing=SINE_EASING)
				spawn(2)
					src<<CLAP

				animate( alpha=0,time=2, easing=SINE_EASING)
				animate( alpha=15,time=2, easing=SINE_EASING)
				spawn(6)
					src<<CLAP
				animate( alpha=0,time=2, easing=SINE_EASING)
				animate( alpha=15,time=2, easing=SINE_EASING)
				spawn(10)
					src<<CLAP
				animate( alpha=0,time=2, easing=SINE_EASING)
				animate( alpha=75,time=2, easing=SINE_EASING)
				spawn(14)
					src<<CLAP
					spawn(1)
						src<<CLAP
				animate( alpha=0,time=2, easing=SINE_EASING)
				spawn(18)
					src<<CROWD
					del C1
				spawn(25)
					inResults=1