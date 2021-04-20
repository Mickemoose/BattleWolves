UI
	CSS
		Ready
			icon='UI/ReadyBar.dmi'
			screen_loc="CENTER-4,CENTER-2"
			New()
				..()
				Activate()
			Activate()
				animate(src, transform=matrix()*4)
		Characters
			icon='UI/CSSIcon.dmi'
			icon_state=""
			Derek
			Brendan
		proc
			Activate()
				usr.setCharacter(src.icon_state)
		Cursor
			icon='UI/CSSIcon.dmi'
			icon_state="cursor"
			proc
				Choose(var/mob/user)
					//icon_state="cursor-choose"
					animate(src, transform=matrix().Translate(0,-6), time=1)
					animate(transform=matrix().Translate(0,0), time=1)
					for(var/UI/CSS/Characters/C in user.client.screen)
						if(C.name==user.character)
							animate(C, transform=matrix().Translate(0,-6), color=rgb(90,90,90,255), time=1)
							animate(transform=matrix().Translate(0,0), color=rgb(90,90,90,255), time=1)

				Deselect(var/mob/user)
					for(var/UI/CSS/Characters/C in user.cssicons)
						if(user.character==C.name)
							animate(C, color=rgb(255,255,255,255), time=2)


mob
	proc
		CSS_Initialize()
			var num=0
			for(var/i=1, i<=src.characters.len,i++)
				var/UI/CSS/Characters/C = new /UI/CSS/Characters(src.client)
				C.screen_loc="CENTER-5:[num],CENTER"
				C.icon_state=src.characters[i]
				C.name=src.characters[i]
				src.cssicons.Add(C)
				animate(C, transform=matrix().Translate(0,200))
				animate(transform=matrix().Translate(0,0), time=4, easing=BOUNCE_EASING)
				num+=34
				sleep(1)


			var/UI/CSS/Cursor/CU=new/UI/CSS/Cursor(src.client)
			cursor.Add(CU)
			CU.screen_loc=cssicons[1].screen_loc
			CU.plane+=1
			animate(CU, color=getPlayerColor(src))
			inCSS=1
		CSS_Deinitialize()
			for(var/UI/CSS/Characters/C in src.client.screen)
				animate(C, transform=matrix().Translate(0,200), time=4, easing=BOUNCE_EASING)
				spawn(5)
					src.cssicons.Remove(C)
					del C
				sleep(1)

