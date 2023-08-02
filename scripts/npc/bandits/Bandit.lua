function Bandit_Jessy()
	local npc = CreateNPC(GetNewNPCName("Бандит"));

	SetPlayerInstance(npc,"PC_HERO");
    SetPlayerAdditionalVisual(npc,"Hum_Body_Naked0",1, "Hum_Head_FatBald", math.random(35,200));
	SetPlayerWalk(npc, "HumanS_Relaxed.mds");
	SetPlayerFatness(npc, 0.5);
    
    SetPlayerStrength(npc, 35);
    SetPlayerDexterity(npc, 35);
    SetPlayerMaxHealth(npc, 200);
	SetPlayerHealth(npc, 200);
	SetPlayerSkillWeapon(npc, SKILL_1H, 30);
	--Items:
	EquipArmor(npc,"YFAUUN_ITAR_BDT_L");
    EquipMeleeWeapon(npc,"JKZTZD_ITMW_1H_COMMON_01");

    npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_ONEH_MASTER;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Bandit;
	npcarr.respawntime = 9999999999;
	
	return npcarr;
end

function Guardian()
	local npc = CreateNPC(GetNewNPCName("Стражник"));

	SetPlayerInstance(npc,"PC_HERO");
    SetPlayerAdditionalVisual(npc,"Hum_Body_Naked0",1, "Hum_Head_FatBald", math.random(35,200));
	SetPlayerWalk(npc, "HumanS_Relaxed.mds");
	SetPlayerFatness(npc, 0.5);
    
    SetPlayerStrength(npc, 15);
    SetPlayerDexterity(npc, 15);
    SetPlayerMaxHealth(npc, 150);
	SetPlayerHealth(npc, 150);
	SetPlayerSkillWeapon(npc, SKILL_1H, 30);
	--Items:
	EquipArmor(npc,"itar_mil_a_l");
    EquipMeleeWeapon(npc,"JKZTZD_ITMW_1H_COMMON_01");

    npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_ONEH_MASTER;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Bandit;
	npcarr.respawntime = 9999999999;
	
	return npcarr;
end

function Pirat()
	local npc = CreateNPC(GetNewNPCName("Пират"));

	SetPlayerInstance(npc,"PC_HERO");
    SetPlayerAdditionalVisual(npc,"Hum_Body_Naked0",1, "Hum_Head_FatBald", math.random(35,200));
	SetPlayerWalk(npc, "HumanS_Relaxed.mds");
	SetPlayerFatness(npc, 0.5);
    
    SetPlayerStrength(npc, 35);
    SetPlayerDexterity(npc, 35);
    SetPlayerMaxHealth(npc, 200);
	SetPlayerHealth(npc, 200);
	SetPlayerSkillWeapon(npc, SKILL_1H, 30);
	--Items:
	EquipArmor(npc,"YFAUUN_ITAR_PIR_L_ADDON");
    EquipMeleeWeapon(npc,"JKZTZD_ITMW_PIRATENSAEBEL");

    npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_ONEH_MASTER;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Bandit;
	npcarr.respawntime = 9999999999;
	
	return npcarr;
end

function Savage()
	local npc = CreateNPC(GetNewNPCName("Дикарь"));

	SetPlayerInstance(npc,"PC_HERO");
    SetPlayerAdditionalVisual(npc,"Hum_Body_Naked0",1, "Hum_Head_FatBald", math.random(35,200));
	SetPlayerWalk(npc, "HumanS_Relaxed.mds");
	SetPlayerFatness(npc, 0.5);
    
    SetPlayerStrength(npc, 40);
    SetPlayerDexterity(npc, 35);
    SetPlayerMaxHealth(npc, 200);
	SetPlayerHealth(npc, 300);
	SetPlayerSkillWeapon(npc, SKILL_1H, 40);
	--Items:
	EquipArmor(npc,"YFAUUN_ITAR_CRAWLER_L");
    EquipMeleeWeapon(npc,"JKZTZD_ITMW_ADDONKEU");

    npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_ONEH_MASTER;
	npcarr.WeaponMode = 3;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Bandit;
	npcarr.respawntime = 9999999999;
	
	return npcarr;
end
   