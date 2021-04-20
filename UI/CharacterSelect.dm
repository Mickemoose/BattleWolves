UI
	CSS
		Portrait
		Plates
			icon='UI/Plate.dmi'
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
					for(var/mob/m in world)
						if(m.client)
							m.setPortait()

				Deselect(var/mob/user)
					for(var/UI/CSS/Characters/C in user.cssicons)
						if(user.character==C.name)
							animate(C, color=rgb(255,255,255,255), time=2)


mob
	proc
		setTempPortrait(character)
			var num=0
			for(var/mob/m in world)
				if(m.client)
					for(var/UI/CSS/Portrait/P in m.client.screen)
						del P
					var/UI/CSS/Portrait/P=new/UI/CSS/Portrait(m.client)
					P.screen_loc="CENTER-11:[12+num],CENTER-6:-12"
					P.plane+=1
					switch(character)
						if("Derek") P.icon='Characters/Derek.dmi'
						if("Brendan") P.icon='Characters/Brendan.dmi'
					P.icon_state=""
					animate(P, alpha=150, transform= matrix()*2)
					spawn(1)
						animate(P, alpha=150, time=0.5,loop=-1)
						animate(alpha=125, time=0.5)
					num+=90
		setPortait()
			var num=0
			for(var/mob/m in world)
				if(m.client)
					for(var/UI/CSS/Portrait/P in m.client.screen)
						del P
					var/UI/CSS/Portrait/P=new/UI/CSS/Portrait(m.client)
					P.screen_loc="CENTER-11:[12+num],CENTER-6:-12"
					P.plane+=1
					P.icon=m.icon
					P.icon_state=""
					animate(P, transform= matrix()*2)
					num+=90
		Portraits()
			for(var/UI/CSS/Plates/P in src.client.screen)
				del P
			for(var/UI/CSS/Portrait/P in src.client.screen)
				del P
			var num=0
			for(var/mob/m in world)
				if(m.client)
					var/UI/CSS/Plates/P = new/UI/CSS/Plates(src.client)
					P.screen_loc="CENTER-10:[num],CENTER-6:-6"
					P.icon_state="[m.PLAYERNUMBER]"
					animate(P, color=getPlayerColor(m), transform=matrix()*2)

					var/UI/CSS/Portrait/P2=new/UI/CSS/Portrait(src.client)
					P2.screen_loc="CENTER-11:[12+num],CENTER-6:-12"
					P2.plane+=1
				//	P2.icon=m.icon
				//	P2.icon_state=""
					animate(P2, transform= matrix()*2)
					num+=90
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
			Portraits()
			setTempPortrait(characters[cssicon])
		CSS_Deinitialize()
			for(var/UI/CSS/Characters/C in src.client.screen)
				animate(C, transform=matrix().Translate(0,200), time=4, easing=BOUNCE_EASING)
				spawn(5)
					src.cssicons.Remove(C)
					del C
				sleep(1)
