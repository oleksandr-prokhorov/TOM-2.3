
function Waran()
    local npc = CreateNPC(GetNewNPCName("ящер"));
    
    if(npc == -1)then
        print("Creating Waran Failed!");
    end
    
    SetPlayerInstance(npc,"Waran");
    
    SetPlayerStrength(npc, 80);
    SetPlayerDexterity(npc, 80);
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
    npcarr.func = Waran;
    npcarr.respawntime = 9999999900;
    
    return npcarr;
end
