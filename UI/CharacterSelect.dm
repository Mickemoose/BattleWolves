UI
	Background
		icon='UI/Background.dmi'
		plane=1

		New()
			..()
			animate(src, transform=matrix()*2)
	SSS
		Stages
			icon='UI/CSSIcon.dmi'
			icon_state=""
			var stagename
	CSS
		Name
			icon='UI/Letters.dmi'
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
					//animate(src, transform=matrix().Translate(0,-6), time=1)
					//animate(transform=matrix().Translate(0,0), time=1)
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
		setTempPortrait(character)
			var num=0
			var num2=0
			for(var/mob/m in Players_ALIVE)
				//if(m.client)
				for(var/UI/CSS/Portrait/P in m.client.screen)
					del P
				for(var/UI/CSS/Name/P in m.client.screen)
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


				for(var/i2=1, i2<=length(character),i2++)
					var/UI/CSS/Name/N= new (src.client)
					N.screen_loc="CENTER-10:[num2-16+num],CENTER-7:-6"
					N.plane+=2
					animate(N, transform = matrix())
					N.icon_state="[copytext(uppertext(character),i2,i2+1)]"
					num2+=6
				num+=90
		setPortait()
			var num=0
			for(var/mob/m in Players_ALIVE)
				//if(m.client)
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
			for(var/mob/m in Players_ALIVE)
			//	if(m.client)
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
		SSS_Initialize()

			var num=0
			sssicons=new()
			for(var/i=1, i<=src.stages.len,i++)
				var/UI/SSS/Stages/C = new /UI/SSS/Stages(src.client)
				C.screen_loc="CENTER-[src.stages.len]:[num],CENTER+2"
				C.icon_state=src.stages[i]
				C.name=src.stages[i]
				src.sssicons.Add(C)
				animate(C, transform=matrix().Translate(0,200))
				animate(transform=matrix().Translate(0,0), time=4, easing=BOUNCE_EASING)

				num+=34
				sleep(1)
		CSS_InitializeLOCAL()




			for(var/mob/m in world)
				if(m.client)
					for(var/UI/CSS/Characters/C in m.client.screen)
						src.cssicons.Add(C)
					var/UI/CSS/Cursor/CU=new/UI/CSS/Cursor(m.client)
					cursor.Add(CU)
					CU.screen_loc=cssicons[1].screen_loc
					CU.plane+=1
					animate(CU, color=getPlayerColor(src))
					inCSS=1

					m.Portraits()
					setTempPortrait(characters[cssicon])
		CSS_Initialize()
		//	var/UI/Background/B = new/UI/Background(src.client)
		//	B.screen_loc="CENTER-8,CENTER-4"
			src<<sound(null)
			spawn(1)
				src<<MENU


			cssicon=1
			sssicon=1
			var num=0
			cssicons=new()
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
			cursor=new()
			cursor.Add(CU)
			CU.screen_loc=cssicons[1].screen_loc
			CU.plane+=1
			animate(CU, color=getPlayerColor(src))
			inCSS=1
			for(var/obj/CSS/Portrait/p in world)
				p.SetPortait(src, characters[cssicon], temp=1)
			see_invisible=100
		//	Portraits()
		//	setTempPortrait(characters[cssicon])
		CSS_Deinitialize()
			for(var/UI/CSS/Characters/C in src.client.screen)
				animate(C, transform=matrix().Translate(0,320), time=4, easing=BOUNCE_EASING)
				spawn(5)
					src.cssicons.Remove(C)
					del C
				sleep(1)

obj
	CSS
		invisibility=100
		appearance_flags = PIXEL_SCALE
		var
			number
		Name
			icon='UI/Names.dmi'
			P1
				icon_state="1"
			P2
				icon_state="2"
			P3
				icon_state="3"
			P4
				icon_state="4"
			P5
				icon_state="5"
			P6
				icon_state="6"
			P7
				icon_state="7"
			P8
				icon_state="8"
			New()
				number=text2num(icon_state)
				step_x=-16
			proc
				SetName(var/mob/m, name)
					if(m.PLAYERNUMBER==number)
						if(name==null)
							icon_state="[number]"
						icon_state=name

		Portrait
			icon='UI/Portraits.dmi'
			P1
				icon_state="1"
			P2
				icon_state="2"
			P3
				icon_state="3"
			P4
				icon_state="4"
			P5
				icon_state="5"
			P6
				icon_state="6"
			P7
				icon_state="7"
			P8
				icon_state="8"
			New()
				animate(src, transform= matrix()*2)
				step_x=-18
				number=text2num(icon_state)
			proc
				SetPortait(var/mob/m, character, temp=0)
					if(m.PLAYERNUMBER==number)
						if(!temp)
							animate(src, alpha=255)
						else
							animate(src, alpha=150)
							spawn(1)
								animate(src, alpha=150, time=0.5,loop=-1)
								animate(alpha=125, time=0.5)
						switch(character)
							if("Derek") icon='Characters/Derek.dmi'
							if("Brendan") icon='Characters/Brendan.dmi'
							if("Laundry") icon='Characters/Laundry.dmi'
							if("Smitty") icon='Characters/Smitty.dmi'
							else
								icon='UI/Portraits.dmi'
								icon_state="[m.PLAYERNUMBER]"
						icon_state=""
						for(var/obj/CSS/Name/N in world)
							N.SetName(m, character)




		Plates
			icon='UI/Plate.dmi'
			P1
				icon_state="1"
			P2
				icon_state="2"
			P3
				icon_state="3"
			P4
				icon_state="4"
			P5
				icon_state="5"
			P6
				icon_state="6"
			P7
				icon_state="7"
			P8
				icon_state="8"
			New()
				animate(src, transform=matrix()*2)
				number=text2num(icon_state)

			proc
				CheckPlayers()
					for(var/mob/m in Players_ALIVE)

						if(m.PLAYERNUMBER==number)
							animate(src, color=getPlayerColor(m))
						else
							icon_state=""


