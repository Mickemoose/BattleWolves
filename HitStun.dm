mob
	proc
		setDamage(num,option)

			switch(option)
				if("ADD")
					if(src.INVINCIBLE) return
					src.percent+=num
					if(percent >= 3.0)
						percent = 3.0
					else if (percent <= 0)
						percent = 0
					UpdateWorldUI(src)
					return
				if("REMOVE")
					src.percent-=num
					if(percent >= 3.0)
						percent = 3.0
					else if (percent <= 0)
						percent = 0
					UpdateWorldUI(src)
					return
				else
					src.percent=num
					if(percent >= 3.0)
						percent = 3.0
					else if (percent <= 0)
						percent = 0
					//UpdateWorldUI(src)
					return
		getDamage()
			return src.percent
		HitStun(var/mob/target, time=2)
			if(target.INVINCIBLE||target.SUPERARMOR) return
			Shake("LIGHT")
			target.Shake("LIGHT")
			flick("hit",target)
			world<<HIT
			//src.vel_x=0
			//src.vel_y=0
			target.vel_x=0
			target.vel_y=0
			target.hitstun=1
			//src.hitstun=1
			animate(target,color=rgb(255,0,0),time=1)
			sleep(1)
			spawn(time)
				animate(target,color=rgb(255,255,255),time=3)
				target.hitstun=0

				//src.hitstun=0
		Knockback(power = "LIGHT", where = "UP RIGHT")
			if(src.INVINCIBLE||src.SUPERARMOR) return
			var magnitude = 0
			canAct=0
			hitstun=0
			tumbled = 1
			reeled = 1
			spawn(7)
				reeled=0
			switch(power)
				if("NONE")
					magnitude = 0.3
				if("LIGHT")
					magnitude = 1
					KBSMOKE()
				if("MEDIUM")
					magnitude = 4
					kblevel=1
					KBSMOKE()
				if("HEAVY")
					magnitude = 6
					kblevel=2
					KBSMOKE()
				if("EXTREME")
					magnitude = 12
					KBSMOKE()
			switch(where)
				if("RIGHT")
					knockbacked=1
					vel_x=magnitude
					vel_y=1
					spawn(3)
						setTumbled()
						canAct=1
						knockbacked=0


				if("LEFT")
					knockbacked=1
					vel_x=-magnitude
					vel_y=1
					spawn(3)
						canAct=1
						knockbacked=0

				if("UP LEFT")
					knockbacked=1
					vel_x=-magnitude
					vel_y=magnitude+4
					spawn(3)
						canAct=1
						knockbacked=0

				if("UP RIGHT")
					knockbacked=1
					vel_x=magnitude
					vel_y=magnitude+4
					spawn(3)
						setTumbled()
						canAct=1

						knockbacked=0
					return

				if("UP")
					knockbacked=1
					vel_x=2
					vel_y=magnitude*2
					spawn(3)
						setTumbled()
						canAct=1
						knockbacked=0

				if("DOWN")
					knockbacked=1
					vel_x=2
					vel_y=-magnitude*2
					spawn(3)
						canAct=1
						knockbacked=0



