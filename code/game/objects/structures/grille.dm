/obj/structure/grille
	name = "grille"
	desc = "A flimsy lattice of metal rods, with screws to secure it to the floor."
	icon = 'icons/obj/grille.dmi'
	icon_state = "grille"
	density = 1
	anchored = 1
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	layer = BELOW_OBJ_LAYER
	explosion_resistance = 1
	var/health = 10
	var/destroyed = 0
	var/on_frame = FALSE

	blend_objects = list(/obj/machinery/door, /turf/simulated/wall) // Objects which to blend with
	noblend_objects = list(/obj/machinery/door/window, /obj/machinery/door/blast/regular/evacshield)

/obj/structure/grille/New()
	. = ..()
	update_connections(1)
	update_icon()

/obj/structure/grille/ex_act(severity)
	qdel(src)

/obj/structure/grille/on_update_icon()
	update_onframe()

	overlays.Cut()
	if(destroyed)
		if(on_frame)
			icon_state = "broke_onframe"
		else
			icon_state = "broken"
	else
		var/image/I
		icon_state = ""
		if(on_frame)
			for(var/i = 1 to 4)
				if(other_connections[i] != "0")
					I = image(icon, "grille_other_onframe[connections[i]]", dir = 1<<(i-1))
				else
					I = image(icon, "grille_onframe[connections[i]]", dir = 1<<(i-1))
				overlays += I
		else
			for(var/i = 1 to 4)
				if(other_connections[i] != "0")
					I = image(icon, "grille_other[connections[i]]", dir = 1<<(i-1))
				else
					I = image(icon, "grille[connections[i]]", dir = 1<<(i-1))
				overlays += I

/obj/structure/grille/Bumped(atom/user)
	if(ismob(user)) shock(user, 70)

/obj/structure/grille/attack_hand(mob/user as mob)

	user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
	playsound(loc, 'sound/effects/grillehit.ogg', 80, 1)
	user.do_attack_animation(src)

	var/damage_dealt = 1
	var/attack_message = "kicks"
	if(istype(user,/mob/living/carbon/human))
		var/mob/living/carbon/human/H = user
		if(H.species.can_shred(H))
			attack_message = "mangles"
			damage_dealt = 5

	if(shock(user, 70))
		return

	if(MUTATION_HULK in user.mutations)
		damage_dealt += 5
	else
		damage_dealt += 1

	attack_generic(user,damage_dealt,attack_message)

/obj/structure/grille/CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
	if(air_group || (height==0)) return 1
	if(istype(mover) && mover.checkpass(PASS_FLAG_GRILLE))
		return 1
	else
		if(istype(mover, /obj/item/projectile))
			return prob(30)
		else
			return !density

/obj/structure/grille/bullet_act(var/obj/item/projectile/Proj)
	if(!Proj)	return

	//Flimsy grilles aren't so great at stopping projectiles. However they can absorb some of the impact
	var/damage = Proj.get_structure_damage()
	var/passthrough = 0

	if(!damage) return

	//20% chance that the grille provides a bit more cover than usual. Support structure for example might take up 20% of the grille's area.
	//If they click on the grille itself then we assume they are aiming at the grille itself and the extra cover behaviour is always used.
	switch(Proj.damage_type)
		if(BRUTE)
			//bullets
			if(Proj.original == src || prob(20))
				Proj.damage *= between(0, Proj.damage/60, 0.5)
				if(prob(max((damage-10)/25, 0))*100)
					passthrough = 1
			else
				Proj.damage *= between(0, Proj.damage/60, 1)
				passthrough = 1
		if(BURN)
			//beams and other projectiles are either blocked completely by grilles or stop half the damage.
			if(!(Proj.original == src || prob(20)))
				Proj.damage *= 0.5
				passthrough = 1

	if(passthrough)
		. = PROJECTILE_CONTINUE
		damage = between(0, (damage - Proj.damage)*(Proj.damage_type == BRUTE? 0.4 : 1), 10) //if the bullet passes through then the grille avoids most of the damage

	take_damage(damage*0.2)

/obj/structure/grille/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isWirecutter(W))
		if(!shock(user, 100))
			playsound(loc, 'sound/items/Wirecutter.ogg', 100, 1)
			new /obj/item/stack/rods(get_turf(src), destroyed ? 1 : 2)
			qdel(src)
	else if((isScrewdriver(W)) && (istype(loc, /turf/simulated) || anchored))
		if(!shock(user, 90))
			playsound(loc, 'sound/items/Screwdriver.ogg', 100, 1)
			anchored = !anchored
			user.visible_message("<span class='notice'>[user] [anchored ? "fastens" : "unfastens"] the grille.</span>", \
								 "<span class='notice'>You have [anchored ? "fastened the grille to" : "unfastened the grill from"] the floor.</span>")
			update_connections(1)
			update_icon()
			return

//window placing begin //TODO CONVERT PROPERLY TO MATERIAL DATUM
	else if(istype(W,/obj/item/stack/material))
		var/obj/item/stack/material/ST = W
		if(!ST.material.created_window)
			return 0

		var/dir_to_set = 5
		if(!on_frame)
			if(loc == user.loc)
				dir_to_set = user.dir
			else
				if( ( x == user.x ) || (y == user.y) ) //Only supposed to work for cardinal directions.
					if( x == user.x )
						if( y > user.y )
							dir_to_set = 2
						else
							dir_to_set = 1
					else if( y == user.y )
						if( x > user.x )
							dir_to_set = 8
						else
							dir_to_set = 4
				else
					to_chat(user, "<span class='notice'>You can't reach.</span>")
					return //Only works for cardinal direcitons, diagonals aren't supposed to work like this.
		for(var/obj/structure/window/WINDOW in loc)
			if(WINDOW.dir == dir_to_set)
				to_chat(user, "<span class='notice'>There is already a window facing this way there.</span>")
				return
		to_chat(user, "<span class='notice'>You start placing the window.</span>")
		if(do_after(user,20,src))
			for(var/obj/structure/window/WINDOW in loc)
				if(WINDOW.dir == dir_to_set)//checking this for a 2nd time to check if a window was made while we were waiting.
					to_chat(user, "<span class='notice'>There is already a window facing this way there.</span>")
					return

			var/wtype = ST.material.created_window
			var/ST_to_use = 4
			if (!on_frame) //if we setting low wall window - use more material!
				ST_to_use = 1
			if (ST.use(ST_to_use))
				var/obj/structure/window/WD = new wtype(loc, dir_to_set, 1)
				to_chat(user, "<span class='notice'>You place the [WD] on [src].</span>")
				WD.update_icon()
		return
//window placing end

	else if(!(W.obj_flags & OBJ_FLAG_CONDUCTIBLE) || !shock(user, 70))
		user.setClickCooldown(DEFAULT_ATTACK_COOLDOWN)
		user.do_attack_animation(src)
		playsound(loc, 'sound/effects/grillehit.ogg', 80, 1)
		switch(W.damtype)
			if("fire")
				take_damage(W.force)
			if("brute")
				take_damage(W.force * 0.1)
	..()


/obj/structure/grille/proc/healthcheck()
	if(health <= 0)
		if(!destroyed)
			set_density(0)
			destroyed = 1
			visible_message("<span class='notice'>\The [src] falls to pieces!</span>")
			update_icon()
			new /obj/item/stack/rods(get_turf(src))

		else
			if(health <= -6)
				new /obj/item/stack/rods(get_turf(src))
				qdel(src)
				return
	return

// shock user with probability prb (if all connections & power are working)
// returns 1 if shocked, 0 otherwise

/obj/structure/grille/proc/shock(mob/user as mob, prb)

	if(!anchored || destroyed)		// anchored/destroyed grilles are never connected
		return 0
	if(!prob(prb))
		return 0
	if(!in_range(src, user))//To prevent TK and mech users from getting shocked
		return 0
	var/turf/T = get_turf(src)
	var/obj/structure/cable/C = T.get_cable_node()
	if(C)
		if(electrocute_mob(user, C, src))
			if(C.powernet)
				C.powernet.trigger_warning()
			var/datum/effect/effect/system/spark_spread/s = new /datum/effect/effect/system/spark_spread
			s.set_up(3, 1, src)
			s.start()
			if(user.stunned)
				return 1
		else
			return 0
	return 0

/obj/structure/grille/fire_act(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(!destroyed)
		if(exposed_temperature > T0C + 1500)
			take_damage(1)
	..()

/obj/structure/grille/take_damage(damage)
	health -= damage
	healthcheck()

// Used in mapping to avoid
/obj/structure/grille/broken
	destroyed = 1
	icon_state = "broken"
	density = 0

/obj/structure/grille/broken/Initialize()
	. = ..()
	take_damage(rand(1, 5)) //In the destroyed but not utterly threshold.

/obj/structure/grille/cult
	name = "cult grille"
	desc = "A matrice built out of an unknown material, with some sort of force field blocking air around it."
	icon = 'icons/obj/grille_cult.dmi'
	health = 40 //Make it strong enough to avoid people breaking in too easily

/obj/structure/grille/cult/CanPass(atom/movable/mover, turf/target, height = 1.5, air_group = 0)
	if(air_group)
		return 0 //Make sure air doesn't drain
	..()

/obj/structure/grille/proc/update_onframe()
	on_frame = FALSE
	var/turf/T = get_turf(src)
	for(var/obj/O in T)
		if(istype(O, /obj/structure/wall_frame))
			on_frame = TRUE
			break
