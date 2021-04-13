mob
	proc
		HitStun(var/mob/target, time=2)
			src.vel_x=0
			src.vel_y=0
			target.vel_x=0
			target.vel_y=0
			target.hitstun=1
			src.hitstun=1
			sleep(1)
			spawn(time)
				target.hitstun=0
				src.hitstun=0
		Knockback(power = "LIGHT", where = "UP RIGHT")
			var magnitude = 0
			canAct=0
			hitstun=0
			tumbled = 1
			reeled = 1
			switch(power)
				if("NONE") magnitude = 0.3
				if("LIGHT") magnitude = 4
				if("MEDIUM") magnitude = 7.5
				if("HEAVY") magnitude = 14
				if("EXTREME") magnitude = 16
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
					vel_y=magnitude+8
					spawn(3)
						canAct=1
						knockbacked=0

				if("UP RIGHT")
					knockbacked=1
					vel_x=magnitude
					vel_y=magnitude+8
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


