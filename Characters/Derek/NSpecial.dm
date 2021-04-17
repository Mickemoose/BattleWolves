mob
	proc
		SpiritBurst()
			client.lock_input()
			INVINCIBLE=1
			setLandingLag("HEAVY")
			canAttack=0
			canMove=0
			canAct=0
			hitstun=1
			vel_x=0
			vel_y=0
			flick("NSPECIAL",src)
			var/EFFECT/DEREK/NSPECIAL/FX = new /EFFECT/DEREK/NSPECIAL(src)
			view()<<DEREKNSPECIAL
			animate(FX,alpha=200)
			FX.plane=src.plane+1
			FX.loc=src.loc
			FX.dir=EAST
			FX.step_x=src.step_x-53
			FX.step_y=src.step_y-43
			flick("",FX)
			spawn(2)
				var/obj/hitbox/hit=new/obj/hitbox(src,_bounds="-30,-60 to 30,60", px=60, py=120, frames=15, hitstun=4, knockback="MEDIUM", direction="UP RIGHT")
				hit.step_x=step_x+40
				hit.step_y=step_y+20
				hit.dir=RIGHT

				var/obj/hitbox/hit2=new/obj/hitbox(src,_bounds="-30,-60 to 30,60", px=60, py=120, frames=15, hitstun=4, knockback="MEDIUM", direction="UP LEFT")
				hit2.step_x=step_x-20
				hit2.step_y=step_y+20
				hit2.dir=LEFT
			spawn(6)
				del FX
			spawn(10)
				client.unlock_input()
				INVINCIBLE=0
				canMove=1
				canAct=1
				hitstun=0
				flick("falling",src)
			spawn(14)
				canAttack=1
