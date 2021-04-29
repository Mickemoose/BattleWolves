mob

	Player1
		isPlayer = 1
		character=null
	Player2
		isPlayer = 1
		character=null
	Player3
		isPlayer = 1
		character=null
	Player4
		isPlayer = 1
		character=null


particles/snow
	icon='confetti.dmi'
	icon_state=list("front"=5, "back"=5, "yellow"=5, "red"=5, "blue"=5, "white"=5)
	width = 1000     // 500 x 500 image to cover a moderately sized map
	height = 700
	count = 2500    // 2500 particles
	spawning = 12    // 12 new particles per 0.1s
	bound1 = list(-1000, -400, -1000)   // end particles at Y=-300
	lifespan = 600  // live for 60s max
	fade = 50       // fade out over the last 5s if still on screen
	// spawn within a certain x,y,z space
	position = generator("box", list(-500,300,0), list(500,300,50))
	// control how the snow falls
	gravity = list(0, -8)
	friction = 0.3  // shed 30% of velocity and drift every 0.1s
	drift = generator("sphere", -8, 10)
	scale=generator(list(-1,1),list(-1,1))

	New()
		..()
		spin = rand(10,18)
	//	animate(src, alpha=100)
		//animate(src, transform = matrix().Scale(-1, 1)  , time = 5, easing = SINE_EASING)
		//animate(transform = matrix().Scale(1, 1), time=5)
obj/snow
	screen_loc = "CENTER"
	appearance_flags = PIXEL_SCALE
	particles = new/particles/snow


mob
	proc/CreateSnow()
		client?.screen += new/obj/snow
	proc/StopSnow()
		for(var/obj/snow/S in client?.screen)
			animate(S, alpha=0, time=5)
			spawn(5)
				del S