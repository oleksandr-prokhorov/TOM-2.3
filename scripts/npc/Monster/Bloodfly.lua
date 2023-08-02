function Bloodfly()
    local npc = CreateNPC(GetNewNPCName("Шершень"));
    
    if(npc == -1)then
        print("Creating Bloodfly Failed!");
    end
    
    SetPlayerInstance(npc,"Bloodfly");
    
    SetPlayerStrength(npc, 30);
    SetPlayerDexterity(npc, 30);
    SetPlayerMaxHealth(npc, 150);
    SetPlayerHealth(npc, 150);
    
    
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
    npcarr.aivar = {};
    npcarr.aivar["ATTACKRANGE"] = 300;
    npcarr.aivar["WARNTIME"] = 3000;
    npcarr.func = Bloodfly;
    npcarr.respawntime = 900000;
    
    return npcarr;
end
