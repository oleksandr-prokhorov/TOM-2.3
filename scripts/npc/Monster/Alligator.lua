
function Alligator()
    local npc = CreateNPC(GetNewNPCName("Аллигатор"));
    
    if(npc == -1)then
        print("Creating Alligator Failed!");
    end
    
    SetPlayerInstance(npc,"Alligator");
    
    SetPlayerStrength(npc, 60);
    SetPlayerDexterity(npc, 60);
    SetPlayerMaxHealth(npc, 130);
    SetPlayerHealth(npc, 130);
    
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = nil;
    npcarr.attack_routine = FAI_WOLF_ATTACK;
    npcarr.WeaponMode = 0;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Waran;
    npcarr.func = Alligator;
    npcarr.respawntime = 300;
    
    return npcarr;
end
