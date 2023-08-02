
function Molerat()
    local npc = CreateNPC(GetNewNPCName("Кротокрыс"));
    
    if(npc == -1)then
        print("Creating Molerat Failed!");
    end
    
    SetPlayerInstance(npc,"Molerat");
    
    SetPlayerStrength(npc, 35);
    SetPlayerDexterity(npc, 35);
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
    npcarr.func = Molerat;
    npcarr.respawntime = 900000;
    
    return npcarr;
end
