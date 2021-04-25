UI
	ITEMSCREEN
		ItemToggle
			icon='UI/ItemIcon.dmi'
		Name
			icon='UI/Letters.dmi'
		Description
			icon='UI/Letters.dmi'


mob
	proc
		ItemSreenOn()
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