function SkeletonMage()
	local npc = CreateNPC(GetNewNPCName("Скелет Маг"));
	
	if(npc == -1)then
		print("Creating Skeleton Mage Failed!");
	end
	
	SetPlayerInstance(npc,"SkeletonMage");
	
	--SetPlayerWeaponMode(npc, 4)
	SetPlayerMagicLevel(npc, 6)
	SetPlayerStrength(npc, 150);
	SetPlayerDexterity(npc, 150);
	SetPlayerLevel(npc, 30);
	SetPlayerMaxHealth(npc, 300);
	SetPlayerHealth(npc, 300);
	SetPlayerMaxMana(npc, 1000);
	SetPlayerMana(npc, 1000);
	
	EquipItem(npc, "ItRu_Firebolt")
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 7;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Skeleton;
	npcarr.func = SkeletonMage;
	npcarr.respawntime = 300;
	npcarr.Aivars = {}
	npcarr.Aivars["MaxWarnDistance"] = 500
	
	return npcarr;
end