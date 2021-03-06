
// File:    keyboard.dm
// Library: Forum_account.Sidescroller
// Author:  Forum_account
//
// Contents:
//   This file handles keyboard input. It adds keyboard macros
//   at runtime which call the KeyUp and KeyDown verbs. These
//   verbs call the key_up and key_down procs which you can
//   override to create new input behavior.

var
	const
		// used to reference keyboard keys
		K_RIGHT = "east"
		K_LEFT = "west"
		K_UP = "north"
		K_DOWN = "south"
		K_SPACE = "space"

Controls
	var
		up = K_UP
		down = K_DOWN
		left = K_LEFT
		right = K_RIGHT
		jump = K_SPACE

client
	New()
		..()

		// by default, the Keyboard library sets the focus to
		// the client, we need to set it to the mob so the mob's
		// key_up and key_down procs are called.
		focus = mob

	// returns 1 if the key is down
	proc/has_key(k)
		return istype(keys) && keys[k]


mob
	var
		Controls/controls = new()

		jumped = 0
		dropped = 0

		holding_left = 0
		holding_right = 0

	// implement the default key_up and key_down behavior
	key_down(k, client/c)
		if(k == controls.jump)
			if(c.keys[controls.down])
				drop()
			else
				jumped = 1

	key_up(k, client/c)
		if(k == controls.jump)
			dropped = 0
