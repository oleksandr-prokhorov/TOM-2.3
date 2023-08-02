
function MineCrawler()
    local npc = CreateNPC(GetNewNPCName("Ползун"));
    
    if(npc == -1)then
        print("Creating minecrawler Failed!");
    end
    
    SetPlayerInstance(npc,"MINECRAWLER");
    
    SetPlayerStrength(npc, 40);
    SetPlayerDexterity(npc, 40);
    SetPlayerMaxHealth(npc, 200);
    SetPlayerHealth(npc, 200);
    
    npcarr = {};
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
    npcarr.func = Scavenger;
    npcarr.respawntime = 999999999;
    return npcarr;
	
end

function MineCrawlerWarrior()
    local npc = CreateNPC(GetNewNPCName("Ползун-воин"));
    
    if(npc == -1)then
        print("Creating minecrawlerwarrior Failed!");
    end
    
    SetPlayerInstance(npc,"MINECRAWLERWARRIOR");
    
    SetPlayerStrength(npc, 60);
    SetPlayerDexterity(npc, 60);
    SetPlayerMaxHealth(npc, 300);
    SetPlayerHealth(npc, 300);
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
    npcarr.func = Scavenger;
    npcarr.respawntime = 999999999;
    return npcarr;
	
end


function Bogomol()
    local npc = CreateNPC(GetNewNPCName("Богомол"));
    
    if(npc == -1)then
        print("Creating bogomol Failed!");
    end
    
    SetPlayerInstance(npc,"BLATTCRAWLER");
    
    SetPlayerStrength(npc, 40);
    SetPlayerDexterity(npc, 40);
    SetPlayerMaxHealth(npc, 200);
    SetPlayerHealth(npc, 200);
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
    npcarr.func = Scavenger;
    npcarr.respawntime = 999999999;
    return npcarr;
	
end


function StoneGuard()
    local npc = CreateNPC(GetNewNPCName("Каменный-страж"));
    
    if(npc == -1)then
        print("Creating stone guard Failed!");
    end
    
    SetPlayerInstance(npc,"STONEGUARDIAN");
    
    SetPlayerStrength(npc, 50);
    SetPlayerDexterity(npc, 50);
    SetPlayerMaxHealth(npc, 250);
    SetPlayerHealth(npc, 250);
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
    npcarr.func = Scavenger;
    npcarr.respawntime = 999999999;
    return npcarr;
	
end


function Yasherka()
    local npc = CreateNPC(GetNewNPCName("Человек-ящер"));
    
    if(npc == -1)then
        print("Creating hyasher lmao Failed!");
    end
    
    SetPlayerInstance(npc,"DRACONIAN");
    
    SetPlayerStrength(npc, 45);
    SetPlayerDexterity(npc, 45);
    SetPlayerMaxHealth(npc, 250);
    SetPlayerHealth(npc, 250);
	
	EquipMeleeWeapon(npc, "JKZTZD_ITMW_2H_ORCAXE_04");
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
    npcarr.func = Scavenger;
    npcarr.respawntime = 999999999;
    return npcarr;
	
end


