
function GiantBBug()
    local npc = CreateNPC(GetNewNPCName("Полевой жук"));
    
    if(npc == -1)then
        print("Creating GiantBug Failed!");
    end
    
    SetPlayerInstance(npc,"GIANT_BUG");
    
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
    npcarr.func = Lurker;
    npcarr.respawntime = 90000000;
    
    
    return npcarr;
end

function MeatBBug()
    local npc = CreateNPC(GetNewNPCName("Мясной жук"));
    
    if(npc == -1)then
        print("Creating MeatBug Failed!");
    end
    
    SetPlayerInstance(npc,"MEATBUG");
    
    SetPlayerStrength(npc, 1);
    SetPlayerDexterity(npc, 1);
    SetPlayerMaxHealth(npc, 5);
    SetPlayerHealth(npc, 5);
    
    
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
    npcarr.func = Lurker;
    npcarr.respawntime = 90000000;
    
    
    return npcarr;
end

function SSheep()
    local npc = CreateNPC(GetNewNPCName("Овца"));
    
    if(npc == -1)then
        print("Creating Sheep Failed!");
    end
    
    SetPlayerInstance(npc,"SHEEP");
    
    SetPlayerStrength(npc, 1);
    SetPlayerDexterity(npc, 1);
    SetPlayerMaxHealth(npc, 30);
    SetPlayerHealth(npc, 30);
    
    
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
    npcarr.func = Lurker;
    npcarr.respawntime = 90000000;
    
    
    return npcarr;
end