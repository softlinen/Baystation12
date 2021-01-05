#if !defined(using_map_DATUM)

	#include "colony_announcements.dm"
	#include "colony_antagonism.dm"
	#include "colony_areas.dm"
	#include "colony_elevator.dm"
	#include "colony_holodecks.dm"
	#include "colony_lobby.dm"
	#include "colony_npcs.dm"
	#include "colony_overmap.dm"
	#include "colony_presets.dm"
	#include "colony_procs.dm"
	#include "colony_ranks.dm"
	#include "colony_security_state.dm"
	#include "colony_setup.dm"
	#include "colony_shuttles.dm"
	#include "colony_submaps.dm"
	#include "colony_turfs.dm"
	#include "colony_unit_testing.dm"

	#include "datums/uniforms.dm"

	#include "datums/reports/command.dm"
	#include "datums/reports/corporate.dm"
	#include "datums/reports/exploration.dm"
	#include "datums/reports/science.dm"
	#include "datums/reports/security.dm"
	#include "datums/reports/deck.dm"

	#include "datums/shackle_law_sets.dm"
	#include "datums/supplypacks/security.dm"
	#include "datums/supplypacks/science.dm"

	#include "items/cards_ids.dm"
	#include "items/documents.dm"
	#include "items/explo_shotgun.dm"
	#include "items/encryption_keys.dm"
	#include "items/headsets.dm"
	#include "items/items.dm"
	#include "items/lighting.dm"
	#include "items/papers.dm"
	#include "items/manuals.dm"
	#include "items/rigs.dm"
	#include "items/stamps.dm"

	#include "items/clothing/clothing.dm"
	#include "items/clothing/exploration.dm"
	#include "items/clothing/override.dm"
	#include "items/clothing/solgov-infinity.dm"
	#include "items/clothing/solgov-accessory.dm"
	#include "items/clothing/solgov-armor.dm"
	#include "items/clothing/solgov-feet.dm"
	#include "items/clothing/solgov-hands.dm"
	#include "items/clothing/solgov-head.dm"
	#include "items/clothing/solgov-suit.dm"
	#include "items/clothing/solgov-under.dm"
	#include "items/clothing/storages.dm"
	#include "items/clothing/terran-accessory.dm"
	#include "items/clothing/terran-feet.dm"
	#include "items/clothing/terran-hands.dm"
	#include "items/clothing/terran-head.dm"
	#include "items/clothing/terran-suit.dm"
	#include "items/clothing/terran-under.dm"

	#include "job/access.dm"
	#include "job/jobs.dm"
	#include "job/outfits.dm"
	#include "job/infinity.dm"

	#include "job/jobs_cargo.dm"
	#include "job/jobs_command.dm"
	#include "job/jobs_engineering.dm"
	#include "job/jobs_exploration.dm"
	#include "job/jobs_medical.dm"
	#include "job/jobs_misc.dm"
	#include "job/jobs_research.dm"
	#include "job/jobs_security.dm"
	#include "job/jobs_service.dm"

	#include "machinery/alarm.dm"
	#include "machinery/doors.dm"
	#include "machinery/keycard authentication.dm"
	#include "machinery/machinery.dm"
	#include "machinery/navbeacons.dm"
	#include "machinery/power.dm"
	#include "machinery/random.dm"
	#include "machinery/tcomms.dm"
	#include "machinery/thrusters.dm"
	#include "machinery/uniform_vendor.dm"
	#include "machinery/vendors.dm"

	#include "structures/closets.dm"
	#include "structures/other.dm"
	#include "structures/override.dm"
	#include "structures/signs.dm"

	#include "structures/closets/_closets_appearances.dm"
	#include "structures/closets/armory.dm"
	#include "structures/closets/command.dm"
	#include "structures/closets/engineering.dm"
	#include "structures/closets/medical.dm"
	#include "structures/closets/misc.dm"
	#include "structures/closets/research.dm"
	#include "structures/closets/security.dm"
	#include "structures/closets/services.dm"
	#include "structures/closets/supply.dm"
	#include "structures/closets/exploration.dm"

	#include "loadout/_defines.dm"
	#include "loadout/loadout_accessories.dm"
	#include "loadout/loadout_eyes.dm"
	#include "loadout/loadout_gloves.dm"
	#include "loadout/loadout_head.dm"
	#include "loadout/loadout_shoes.dm"
	#include "loadout/loadout_suit.dm"
	#include "loadout/loadout_uniform.dm"
	#include "loadout/loadout_tactical.dm"
	#include "loadout/loadout_xeno.dm"
	#include "loadout/~defines.dm"

	#include "colony1-underground.dmm"
	#include "colony2-surface.dmm"
	#include "colony3-peak.dmm"
	#include "../away/empty.dmm"

	#include "../away_inf/yacht/yacht.dm"
	#include "../away_inf/mining/mining.dm"
//  #include "../away_inf/tajsc/tajsciship.dm"
	#include "../away_inf/blueriver/blueriver.dm"
	#include "../away_inf/smugglers/smugglers.dm"
	#include "../away_inf/skrellscoutship/skrellscoutship.dm"

	#include "../away/bearcat/bearcat.dm"
	#include "../away/derelict/derelict.dm"
	#include "../away/magshield/magshield.dm"
	#include "../away/casino/casino.dm"
	#include "../away/errant_pisces/errant_pisces.dm"
	#include "../away/lar_maria/lar_maria.dm"
	#include "../away/unishi/unishi.dm"
	#include "../away/slavers/slavers_base.dm"
	#include "../away/voxship/voxship.dm"

	#define using_map_DATUM /datum/map/colony

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Colony

#endif
