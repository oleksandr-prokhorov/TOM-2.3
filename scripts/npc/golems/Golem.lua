function StoneGolem()
    local npc = CreateNPC(GetNewNPCName("Каменный Голем"));
    
    if(npc == -1)then
        print("Creating StoneGolem Failed!");
    end
    
    SetPlayerInstance(npc,"StoneGolem");
    
    SetPlayerStrength(npc, 300);
    SetPlayerDexterity(npc, 300);
    SetPlayerMaxHealth(npc, 400);
    SetPlayerHealth(npc, 400);
    
    
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
    npcarr.func = StoneGolem;
	npcarr.respawntime = 99999999999;
    
    return npcarr;
end


function FireGolem()
    local npc = CreateNPC(GetNewNPCName("Fire Golem"));
    
    if(npc == -1)then
        print("Creating FireGolem Failed!");
    end
    
    SetPlayerInstance(npc,"FireGolem");
    
    SetPlayerStrength(npc, 320);
    SetPlayerDexterity(npc, 320);
    SetPlayerMaxHealth(npc, 450);
    SetPlayerHealth(npc, 450);
    
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = nil;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.func = FireGolem;
    npcarr.respawntime = 99999999999;
    
    return npcarr;
end



function IceGolem()
    local npc = CreateNPC(GetNewNPCName("Ice Golem"));
    
    if(npc == -1)then
        print("Creating IceGolem Failed!");
    end
    
    SetPlayerInstance(npc,"IceGolem");
    
    SetPlayerStrength(npc, 310);
    SetPlayerDexterity(npc, 310);
    SetPlayerMaxHealth(npc, 450);
    SetPlayerHealth(npc, 450);
    
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = nil;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.func = IceGolem;
    npcarr.respawntime = 99999999999;
    
    return npcarr;
end

function SwampGolem()
    local npc = CreateNPC(GetNewNPCName("Swamp Golem"));
    
    if(npc == -1)then
        print("Creating SwampGolem Failed!");
    end
    
    SetPlayerInstance(npc,"SwampGolem");
    
    SetPlayerStrength(npc, 150);
    SetPlayerDexterity(npc, 150);
    SetPlayerMaxHealth(npc, 400);
    SetPlayerHealth(npc, 400);
    
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = nil;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.func = SwampGolem;
    npcarr.respawntime = 99999999999;

    return npcarr;
end


function BridgeGolem()
    npcarr = StoneGolem();
    npcarr.func = BridgeGolem;
    
    
    return npcarr;
end

function Shattered_Golem()
    npcarr = StoneGolem();
    npcarr.func = Shattered_Golem;
    
    
    return npcarr;
end