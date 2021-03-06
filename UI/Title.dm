atom/movable
	var global/RedOutline = filter(type = "outline", color = "red", size = 2)
	var global/BlueOutline = filter(type = "outline", color = "blue", size = 2)
	var global/WhiteOutline = filter(type = "outline", color = "white", size = 1)
	var/global/Wave = filter(type="wave")
	var/global/Blur = filter(type="radial_blur",x=16,y=16,size=2)
atom/proc/WaterEffect2()
    var/start = filters.len
    var/X,Y,rsq,i,f
    for(i=1, i<=10, ++i)
        // choose a wave with a random direction and a period between 10 and 30 pixels
        do
            X = 60*rand() - 30
            Y = 1200*rand() - 30
            rsq = X*X + Y*Y
        while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
        // keep distortion (size) small, from 0.5 to 3 pixels
        // choose a random phase (offset)
        filters += filter(type="wave", x=X, y=Y, size=rand()*8.6+4,8, offset=rand())
    for(i=1, i<=10, ++i)
        // animate phase of each wave from its original phase to phase-1 and then reset;
        // this moves the wave forward in the X,Y direction
        f = filters[start+i]
        animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
        animate(offset=f:offset-1, time=rand()*20+10)
atom/proc/WaterEffect()
    var/start = filters.len
    var/X,Y,rsq,i,f
    for(i=1, i<=10, ++i)
        // choose a wave with a random direction and a period between 10 and 30 pixels
        do
            X = 60*rand() - 30
            Y = 60*rand() - 30
            rsq = X*X + Y*Y
        while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
        // keep distortion (size) small, from 0.5 to 3 pixels
        // choose a random phase (offset)
        filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
    for(i=1, i<=10, ++i)
        // animate phase of each wave from its original phase to phase-1 and then reset;
        // this moves the wave forward in the X,Y direction
        f = filters[start+i]
        animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
        animate(offset=f:offset-1, time=rand()*20+10)
atom/proc/WaterEffectTransparent()
    var/start = filters.len
    var/X,Y,rsq,i,f
    for(i=1, i<=10, ++i)
        // choose a wave with a random direction and a period between 10 and 30 pixels
        do
            X = 60*rand() - 30
            Y = 60*rand() - 30
            rsq = X*X + Y*Y
        while(rsq<100 || rsq>900)   // keep trying if we don't like the numbers
        // keep distortion (size) small, from 0.5 to 3 pixels
        // choose a random phase (offset)
        filters += filter(type="wave", x=X, y=Y, size=rand()*1.0+0.5, offset=rand())
    for(i=1, i<=10, ++i)
        // animate phase of each wave from its original phase to phase-1 and then reset;
        // this moves the wave forward in the X,Y direction
        f = filters[start+i]
        animate(f, offset=f:offset, time=0, loop=-1, flags=ANIMATION_PARALLEL)
        animate(offset=f:offset-1, time=rand()*20+10)
UI
	FRAME
		icon='UI/Background.dmi'
		icon_state="frame"
		screen_loc="CENTER-8:+6,CENTER-4"
		plane=4
		New(client/c)
			c.screen+=src
			animate(src, transform=matrix()*2)
		//	src.WaterEffect()
	FIRE2
		icon='UI/Background.dmi'
		icon_state="fire3"
		screen_loc="CENTER-8,CENTER-4"
		plane=3
		New(client/c)
		//	animate(src, alpha=0)
			c.screen+=src
			animate(src, transform=matrix()*2)
			animate(src, alpha=255, time=5)
			src.WaterEffect()
	FIRE
		icon='UI/Background.dmi'
		icon_state="fire2"
		screen_loc="CENTER-7,CENTER-4"
		plane=3
		New(client/c)
		//	animate(src, alpha=0)
			c.screen+=src
			animate(src, transform=matrix()*2)
			animate(src, alpha=255, time=5)
			src.WaterEffect2()
	BACK
		icon='UI/Background.dmi'
		icon_state=""
		screen_loc="CENTER-8,CENTER-4"
		plane=1
		New(client/c)
		//	animate(src, alpha=0)
			c.screen+=src
			animate(src, transform=matrix()*2)
			animate(src, alpha=255, time=5)
	LOGO
		icon='UI/Logo.dmi'
		screen_loc="CENTER-7,CENTER"
		plane=5
		New(client/c)
			animate(src,alpha=0)
			c.screen+=src
			src.filters += WhiteOutline
		//	src.filters+= Wave




		proc
			Appear()
				animate(src,transform=matrix(0.1,0,0,0,0.1,16), time=0, easing=SINE_EASING)
				//spawn(1)
				animate(transform=matrix()*1, alpha=255,time=15, easing=BOUNCE_EASING)
					//WaterEffect()
			Disappear()
				animate(src,transform=matrix().Translate(0,-600), time=20, alpha=0,easing=BOUNCE_EASING)
				spawn(10)
					del src