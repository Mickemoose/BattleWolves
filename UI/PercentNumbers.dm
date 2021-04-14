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
	LIFE
		icon='UI/Life.dmi'
	New(client/c, tracking)
		c.screen+=src
		playernum=tracking
proc
	DestroyWorldUI(var/mob/player)
		for(var/mob/M in world)
			if(M.client)
				M.UI_Destroy(player)
	DestroyWorldLife(var/mob/player)
		for(var/mob/M in world)
			if(M.client)
				M.Life_Destroy(player)
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
				var num3=8
				var percent2 = num2text(M.getDamage()*100) + "%"
				for(var/i=1, i<=length(percent2),i++)
					var/UI/NAME/N= new (usr.client, M.PLAYERNUMBER)
					N.screen_loc="CENTER:[num + num2],CENTER-7"
					animate(N, transform = matrix()*2, alpha= 0,time = 0)
					spawn(1)
						animate(N, transform= matrix()*2, alpha=255, time=3)
					N.icon_state="[copytext(percent2,i,i+1)]"
					num+=13


				for(var/i2=1, i2<=M.lives,i2++)
					var/UI/LIFE/L= new (usr.client, M.PLAYERNUMBER)
					L.screen_loc="CENTER:[num3 + num2],CENTER-6:-16"
					animate(L, transform = matrix(), alpha= 255,time = 3)

					num3+=8

				num2+=120
				spawn(1)
					UI_Update(M)






		Life_Destroy(var/mob/player)
			var/list/lifelist=list()
			for(var/UI/LIFE/N2 in usr.client.screen)
				if(N2.playernum==player.PLAYERNUMBER)
					lifelist.Add(N2)
			var/UI/LIFE/selected = lifelist[lifelist.len]
			if(selected.playernum==player.PLAYERNUMBER)
				var/matrix/m = matrix()*2
				animate(selected, transform=m.Translate(rand(2,8),10), time=1)
				animate(transform=m.Translate(rand(2,8),2), time=1)
				animate(transform=m.Translate(rand(2,8),-200), time=3)
				spawn(8)
					del selected
		UI_Destroy(var/mob/player)
			var/list/lifelist=list()
			for(var/UI/LIFE/N2 in usr.client.screen)
				if(N2.playernum==player.PLAYERNUMBER)
					lifelist.Add(N2)
			var/UI/LIFE/selected = lifelist[lifelist.len]
			if(selected.playernum==player.PLAYERNUMBER)
				var/matrix/m = matrix()*2
				animate(selected, transform=m.Translate(rand(2,8),10), time=1)
				animate(transform=m.Translate(rand(2,8),2), time=1)
				animate(transform=m.Translate(rand(2,8),-200), time=3)
				spawn(8)
					del selected
			for(var/UI/NAME/N2 in usr.client.screen)
				if(N2.playernum==player.PLAYERNUMBER)
					//Life_Destroy(player)
					var/matrix/m = matrix()*2
					animate(N2, transform=m.Translate(rand(2,8),10), time=1)
					animate(transform=m.Translate(rand(2,8),2), time=1)
					animate(transform=m.Translate(rand(2,8),-200), time=3)
					spawn(8)
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
							animate(F, transform= matrix()*2, alpha=255)
							var num=13
							var num3=8
							var percent2 = num2text(M.getDamage()*100) + "%"
							for(var/i=1, i<=length(percent2),i++)
								var/UI/NAME/N= new (usr.client, M.PLAYERNUMBER)
								N.screen_loc="CENTER:[num + num2],CENTER-7"
								N.icon_state="[copytext(percent2,i,i+1)]"
								num+=13
								animate(N, transform= matrix()*2, alpha=255, time=3)
							for(var/i2=1, i2<=M.lives,i2++)
								var/UI/LIFE/L= new (usr.client, M.PLAYERNUMBER)
								L.screen_loc="CENTER:[num3 + num2],CENTER-6:-16"
								animate(L, transform = matrix(), alpha= 255,time = 3)

								num3+=8
							num2+=120

							spawn(1)
								UI_Update(M)

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
				animate(F, transform= matrix()*2, alpha=255)
				var num=13
				var num3=8
				var percent2 = num2text(M.getDamage()*100) + "%"
				for(var/i=1, i<=length(percent2),i++)
					var/UI/NAME/N= new (usr.client, M.PLAYERNUMBER)
					N.screen_loc="CENTER:[num + num2],CENTER-7"
					N.icon_state="[copytext(percent2,i,i+1)]"
					num+=13
					animate(N, transform= matrix()*2, alpha=255, time=0.1)
				for(var/i2=1, i2<=M.lives,i2++)
					var/UI/LIFE/L= new (usr.client, M.PLAYERNUMBER)
					L.screen_loc="CENTER:[num3 + num2],CENTER-6:-16"
					animate(L, transform = matrix(), alpha= 255,time = 3)

					num3+=8

				num2+=120
				for(var/UI/NAME/N in usr.client.screen)
					if(N.playernum==M.PLAYERNUMBER)
						if(M.percent>=0.5 && M.percent<=0.75)
							animate(N, transform= matrix()*2, alpha=255, color="yellow", time=0.1)
						if(M.percent>=0.75 && M.percent<=1.0)
							animate(N, transform= matrix()*2, alpha=255, color="#ff8f1f", time=0.1)
						if(M.percent>=1.0 && M.percent<=1.50)
							animate(N, transform= matrix()*2, alpha=255, color="#ff6b98", time=0.1)
						if(M.percent>=1.50)
							animate(N, transform= matrix()*2, alpha=255, color="red", time=0.1)
						if(M.percent>=2.50)
							animate(N, transform= matrix()*2, alpha=255, color="#611c1c", time=0.1)
						animate(N, transform = turn(matrix()*2, rand(10,22)), time = 1, loop=1 )
						animate(N, transform = turn(matrix()*2, 0), time = 1,loop=1  )
						spawn(1.2)
							animate(N, transform = turn(matrix()*2, rand(330,350)), time = 1,loop=1 )
							animate(N, transform = turn(matrix()*2, 0), time = 1, loop=1 )
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