mob
	var
		MUSIC_VOLUME = 1
		SFX_VOLUME = 30
		sound/SongPlaying = ""

		inTitle=0
		inCSS=0
		inSSS=0
		inResults=0
		boostdefault = 8
		boost = 8
		dbljumped =0
		lasthitby = null
		character = null
		respawned=0
		webtrapped=0
		doingSpecial=null

		burning=0
		blitz=0
		lives =1
		percent = 0
		canMove = 1
		canAttack = 1
		canAct = 1
		kbsmoke=0
		kblevel=0
		VULNERABLE=0
		hud=0
		target_arrows[]
		target_circles[]
		LAG = 3

		INVINCIBLE=0
		SUPERARMOR=0
		PLAYERNUMBER=0
		isMashing=0
		mashAmount=0
		mashFX

		isPlayer = 0

		hitIndex = "null"
		heldItem= "frame"

		grabbedBy
		hasGrabbed=0

		cssicon=1
		sssicon=1

		list
			effects = list()
			trackers = list()
			holdingItem = list()
			characters = list("Derek","Brendan","Laundry","Smitty","Hunter","Matt","Becca","Froese","Hartshorne","Schnerch")
			stages = list("Debug","Whale Boat", "Glitch Realm")
			cssicons = list()
			sssicons = list()
			cursor=list()
			items = list("Containers","Food","KFK","BluJay","WebTrap")
			spirits = list()


		holdingAttack = 0
		chargingAttck = 0



		//STATS
		DEATHS = 0
		KILLS = 0
		SELF_DESTRUCTS = 0
		TOTAL_DAMAGE_MATCH = 0


