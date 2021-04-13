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
	New(client/c, tracking)
		c.screen+=src
		playernum=tracking
proc
	UpdateWorldUI(var/mob/player)
		for(var/mob/M in world)
			if(M.client)
				M.UI_Update(player)
	PopulateWorldUI()
		for(var/mob/M in world)
			if(M.client)
				M.UI_Populate()

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



				var/UI/FACE/F= new (usr.client, M.PLAYERNUMBER)
				F.icon_state=M.character
				F.screen_loc="CENTER-1:[num2],CENTER-7:-7"
				animate(F, transform= matrix()*2, alpha=255, time=3)
				var num=13
				var percent2 = num2text(M.getDamage()*100) + "%"
				for(var/i=1, i<=length(percent2),i++)
					var/UI/NAME/N= new (usr.client, M.PLAYERNUMBER)
					N.screen_loc="CENTER:[num + num2],CENTER-7"
					animate(N, transform = matrix()*2, alpha= 0,time = 0)
					spawn(1)
						animate(N, transform= matrix()*2, alpha=255, time=3)
					N.icon_state="[copytext(percent2,i,i+1)]"
					num+=13

				num2+=120

		UI_Destroy(var/mob/player)
		UI_Update(var/mob/player)
			var num2 =0


			num2-=52*Players

			for(var/UI/U in usr.client.screen)
				del U

			for(var/mob/M in Players_ALIVE)
				//if(M.hud) continue
				//M.hud=1



				var/UI/FACE/F= new (usr.client, M.PLAYERNUMBER)
				F.icon_state=M.character
				F.screen_loc="CENTER-1:[num2],CENTER-7:-7"
				animate(F, transform= matrix()*2, alpha=255, time=0.1)
				var num=13
				var percent2 = num2text(M.getDamage()*100) + "%"
				for(var/i=1, i<=length(percent2),i++)
					var/UI/NAME/N= new (usr.client, M.PLAYERNUMBER)
					N.screen_loc="CENTER:[num + num2],CENTER-7"
					N.icon_state="[copytext(percent2,i,i+1)]"
					num+=13
					animate(N, transform= matrix()*2, alpha=255, time=0.1)
				num2+=120
			for(var/UI/NAME/N in usr.client.screen)
				if(N.playernum==player.PLAYERNUMBER)
					if(player.percent>=0.5 && player.percent<=0.75)
						animate(N, transform= matrix()*2, alpha=255, color="yellow", time=0.1)
					if(player.percent>=0.75 && player.percent<=1.0)
						animate(N, transform= matrix()*2, alpha=255, color="#ff8f1f", time=0.1)
					if(player.percent>=1.0 && player.percent<=1.50)
						animate(N, transform= matrix()*2, alpha=255, color="#ff6b98", time=0.1)
					if(player.percent>=1.50)
						animate(N, transform= matrix()*2, alpha=255, color="red", time=0.1)
					if(player.percent>=2.50)
						animate(N, transform= matrix()*2, alpha=255, color="#611c1c", time=0.1)
					animate(N, transform = turn(matrix()*2, rand(10,22)), time = 1, loop=1 )
					animate(N, transform = turn(matrix()*2, 0), time = 1,loop=1  )
					spawn(1.2)
						animate(N, transform = turn(matrix()*2, rand(330,350)), time = 1,loop=1 )
						animate(N, transform = turn(matrix()*2, 0), time = 1, loop=1 )