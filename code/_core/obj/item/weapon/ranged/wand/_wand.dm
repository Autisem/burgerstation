/obj/item/weapon/ranged/wand
	name = "wand"
	desc = "Wingardium Leviosa!"
	desc_extended = "A magic imbued wand that can fit any type of spell gem to amplify and improve its powers."
	icon_state = "inventory"

	value = -1

	var/obj/item/weapon/ranged/spellgem/socketed_spellgem

	automatic = TRUE

/obj/item/weapon/ranged/wand/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("socketed_spellgem")

/obj/item/weapon/ranged/wand/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("socketed_spellgem")

/obj/item/weapon/ranged/wand/can_gun_shoot(var/mob/caller,var/atom/object,location,params)

	if(!socketed_spellgem)
		return FALSE

	. = ..()

/obj/item/weapon/ranged/wand/shoot(var/mob/caller,var/atom/object,location,params,var/damage_multiplier=1)
	return socketed_spellgem.shoot(caller,object,location,params,damage_multiplier*2)

/obj/item/weapon/ranged/wand/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/ranged/spellgem/))
		var/obj/item/weapon/ranged/spellgem/SG = object
		if(socketed_spellgem)
			caller.to_chat(span("warning","Remove \the [socketed_spellgem.name] before inserting a new spellgem!"))
			return TRUE
		socketed_spellgem = SG
		SG.drop_item(src)
		caller.to_chat(span("notice","You insert \the [SG.name] into \the [src.name]."))
		return TRUE

	if(istype(object,/obj/hud/inventory/))
		var/obj/hud/inventory/I = object
		if(!socketed_spellgem)
			caller.to_chat(span("warning","There is no socketed spellgem to remove!"))
			return TRUE
		I.add_object(socketed_spellgem)
		caller.to_chat(span("notice","You remove \the [socketed_spellgem.name] from \the [src.name]."))
		socketed_spellgem = null
		return TRUE

	. = ..()

/obj/item/weapon/ranged/wand/branch
	name = "branch wand"
	icon = 'icons/obj/item/weapons/ranged/magic/wand/branch.dmi'

	value = 800