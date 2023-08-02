function SkeletonWarrior()
	local npc = CreateNPC(GetNewNPCName("Темный Скелет"));
	
	if(npc == -1 or npc == nil)then
		print("Creating Skeleton Warrior Failed!");
	end
	
	SetPlayerInstance(npc,"Skeleton_Lord");
	
	SetPlayerStrength(npc, 250);
	SetPlayerDexterity(npc, 150);
	SetPlayerLevel(npc, 40);
	SetPlayerMaxHealth(npc, 500);
	SetPlayerHealth(npc, 500);
	
	EquipMeleeWeapon(npc, "ItMw_Zweihaender2");
	EquipArmor(npc, "ITAR_PAL_SKEL");
	
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 4;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Skeleton;
	npcarr.func = SkeletonWarrior;
	npcarr.respawntime = 300;
	npcarr.Aivars = {}
	npcarr.Aivars["MaxWarnDistance"] = 500
	
	return npcarr;
end