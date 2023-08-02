function Scavenger()
    local npc = CreateNPC(GetNewNPCName("Падальщик"));
    
    if(npc == -1)then
        print("Creating Scavenger Failed!");
    end
    
    SetPlayerInstance(npc,"Scavenger");
    
    SetPlayerStrength(npc, 30);
    SetPlayerDexterity(npc, 30);
    SetPlayerMaxHealth(npc, 120);
    SetPlayerHealth(npc, 120);
    
    
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

function YoungScavenger()
    local npcarr = Scavenger();
    local name = GetNewNPCName("Молодой падальщик");
    SetPlayerName(npcarr.id, name);
    
    SetPlayerStrength(npcarr.id, 20);
    SetPlayerDexterity(npcarr.id, 20);
    SetPlayerMaxHealth(npcarr.id, 40);
    SetPlayerHealth(npcarr.id, 40);
    npcarr.func = YoungScavenger;
    
    
    return npcarr;
end
