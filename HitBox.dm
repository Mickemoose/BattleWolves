
HITBOX
	parent_type = /mob
	pwidth=16
	pheight=16
	density=0
	icon='hitboxes/16x16.dmi'
	gravity()
	action()
	set_state()

	WIDE
		icon='hitboxes/32x16.dmi'
		pwidth=32
	TALL
		pheight=32
		icon='hitboxes/16x32.dmi'
	LARGE
		pwidth=24
		pheight=24
	XLARGE
		pwidth=32
		icon='hitboxes/32x32.dmi'
		pheight=32

	SWEET
		icon_state="sweet"
		SWEET_SPOT=1
	var

		OWNER   //Player who owns the Hitbox

		DAMAGE = 0// Damage % given to target
		KILLMOVE = 0 //Whether it can kill at certain percents
		TYPE = "Hitstun"  // Hitstun or Knockback depending on move

		SWEET_SPOT = 0 //whether or not they are a hitspot
		CAN_DEFLECT = 0 //whether or not they deflect projectiles
		//HITSTUN ONLY VARS
		KICKBACK = 0   //how far should a hitstun push the TARGET back? used with vel_x

		INDEX = "00"  //Each move in the game has an index indentifier, so you cant be hit by the same move in split second intervals.

		//EXAMP

		/*
		D1 = Dereks Z attack 1
		D2 = Dereks Z attack 2
		D3, etc.



		*/
		//KNOCKBACK ONLY VARS
		DIRECTION = "Forward" //   Forward, Up, Down, Up Angle, Down Angle, Backward used to determine which direction they fly back.
		FORCE = 0  //Force level FROM 0-5 defines how far people should fly like a mutha fucka  will program levels in soon



	New(mob/source)
		OWNER=source


		loc=source.loc