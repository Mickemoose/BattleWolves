client/New()
	..()



	screen += fade
var/SCREEN_FADE/fade = new()
SCREEN_FADE
	parent_type=/obj

	icon = 'System/fade.dmi'

	screen_loc = "NORTHWEST to SOUTHEAST"

	// Defaults to 255, but this can be altered with the fade.MapLayer() proc.
	plane=255
	New()
		//animate(src, alpha=0, time=30)
		//FadeIn()
	proc
		FadeIn(client/c, time=20)
			animate(src, alpha=0, time=time)
		Fade(client/c,color="#000000",alpha=0,time=5)
			animate(src, color=color, alpha=alpha, time=time)
		FadeOut(client/c, time=20)
			animate(src, alpha=255, time=time)

mob
	proc
		Fade(client/c,color="#000000",alpha=0,time=5)
			if(ismob(c))
				var/mob/M = c
				if(!M.client)
					return
				c = M.client
			for(var/SCREEN_FADE/S in src.client.screen)
				animate(S, color=color, alpha=alpha, time=time)
		FadeOut(client/c, time=20)
			if(ismob(c))
				var/mob/M = c
				if(!M.client)
					return
				c = M.client
			for(var/SCREEN_FADE/S in src.client.screen)
				animate(S, alpha=255, time=time)
		FadeIn(client/c, time=20)
			for(var/SCREEN_FADE/S in src.client.screen)
				animate(S, alpha=0, time=time)