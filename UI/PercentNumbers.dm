UI
	parent_type=/obj
	plane=FLOAT_PLANE+1
	appearance_flags = PIXEL_SCALE
	var
		playernum
	NAME
		icon='UI/Letters.dmi'
	FACE
		icon='UI/Faces.dmi'
	New(client/c)
		c.screen+=src


mob
	proc
		UI_Populate()
			var num2 =0


			num2-=52*Players

			for(var/UI/U in usr.client.screen)
				del U

			for(var/mob/M in Players_ALIVE)
				//if(M.hud) continue
				//M.hud=1


				M.setDamage(1.0)
				var/UI/FACE/F= new (usr.client)
				F.icon_state=M.character
				F.screen_loc="CENTER-1:[num2],CENTER-7:-7"
				animate(F, transform= matrix()*2, alpha=255, time=3)
				var num=13
				var percent2 = num2text(M.getDamage()*100) + "%"
				for(var/i=1, i<=length(percent2),i++)
					var/UI/NAME/N= new (usr.client)
					N.screen_loc="CENTER:[num + num2],CENTER-7"
					animate(N, transform = matrix()*2, alpha= 0,time = 0)
					spawn(1)
						animate(N, transform= matrix()*2, alpha=255, time=3)
					N.icon_state="[copytext(percent2,i,i+1)]"
					num+=13

				num2+=120

		UI_Destroy(var/mob/player)
		UI_Update(var/mob/player)