
function Lurker()
    local npc = CreateNPC(GetNewNPCName("Øíûã"));
    
    if(npc == -1)then
        print("Creating Lurker Failed!");
    end
    
    SetPlayerInstance(npc,"Lurker");
    
    SetPlayerStrength(npc, 70);
    SetPlayerDexterity(npc, 70);
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
    npcarr.respawntime = 900000;
    
    
    return npcarr;
end