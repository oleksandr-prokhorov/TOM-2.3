
function Skeleton()
	local npc = CreateNPC(GetNewNPCName("������ ����"));
	
	if(npc == -1 or npc==nil)then
		print("Creating Skeleton Failed!");
	end
	
	SetPlayerInstance(npc,"Skeleton");
	
	SetPlayerStrength(npc, 100);
	SetPlayerDexterity(npc, 150);
	SetPlayerMaxHealth(npc, 300);
	SetPlayerHealth(npc, 300);
	
	EquipMeleeWeapon(npc, "jkztzd_itmw_2h_sword_m_01");
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 4;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Skeleton;
	npcarr.respawntime = 900000;
	
	return npcarr;
end


function SkeletonSH()
	local npcArray = Skeleton();
	
	SetPlayerStrength(npcArray.id, 110);
	npcArray.WeaponMode = 3;
	EquipMeleeWeapon(npcArray.id, "ItMw_1h_MISC_Sword");
	npcArray.func = SkeletonSH;
	
	return npcArray;
end


function SkeletonScout()
	local npc = CreateNPC(GetNewNPCName("Skeleton Scout"));
	
	if(npc == -1)then
		print("Creating Skeleton Scout Failed!");
	end
	
	SetPlayerInstance(npc,"Lesser_Skeleton");
	
	SetPlayerStrength(npc, 45);
	SetPlayerDexterity(npc, 75);
	SetPlayerLevel(npc, 15);
	SetPlayerMaxHealth(npc, 300);
	SetPlayerHealth(npc, 300);
	
	EquipMeleeWeapon(npc, "ItMw_1h_MISC_Sword");
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Skeleton;
	npcarr.func = SkeletonScout;
	npcarr.respawntime = 300;
	npcarr.Aivars = {}
	npcarr.Aivars["MaxWarnDistance"] = 500
	
	return npcarr;
end

function Lesser_Skeleton()
	local npc = CreateNPC(GetNewNPCName("Lesser Skeleton"));
	
	if(npc == -1)then
		print("Creating Lesser Skeleton Failed!");
	end
	
	SetPlayerInstance(npc,"Lesser_Skeleton");
	
	SetPlayerStrength(npc, 45);
	SetPlayerDexterity(npc, 75);
	SetPlayerLevel(npc, 15);
	SetPlayerMaxHealth(npc, 300);
	SetPlayerHealth(npc, 300);
	
	EquipMeleeWeapon(npc, "ItMw_1h_MISC_Sword");
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Skeleton;
	npcarr.func = Lesser_Skeleton;
	npcarr.respawntime = 300;
	npcarr.Aivars = {}
	npcarr.Aivars["MaxWarnDistance"] = 500
	
	return npcarr;
end







function SkeletonLord()
	local npcarr = SkeletonWarrior();
	local name = GetNewNPCName("Skeleton Lord");
	SetPlayerName(npcarr.id, name);
	
	
	return npcarr;
end


