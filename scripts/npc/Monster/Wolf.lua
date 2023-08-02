
function Wolf()
    local npc = CreateNPC(GetNewNPCName("Волк"));
    
    if(npc == -1)then
        print("Creating Wolf Failed!");
    end
    
    SetPlayerInstance(npc,"Wolf");
    
    SetPlayerStrength(npc, 40);
    SetPlayerDexterity(npc, 40);
    SetPlayerMaxHealth(npc, 150);
    SetPlayerHealth(npc, 150);
    
    local npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = DR_Monster_MidEat;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.func = Wolf;
    npcarr.respawntime = 900000;
    return npcarr;
end
