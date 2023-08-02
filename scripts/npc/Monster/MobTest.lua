
function MobTest()
    local npc = CreateNPC(GetNewNPCName("Ёлитный гоблин"));
    
    if(npc == -1)then
        print("Creating TestMob Failed!");
    end
    
    SetPlayerInstance(npc, "GOBLIN_ELITKA");
    
    SetPlayerStrength(npc, 10);
    SetPlayerDexterity(npc, 10);
    SetPlayerMaxHealth(npc, 100);
    SetPlayerHealth(npc, 100);
    
    
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
    npcarr.respawntime = 9999999999;
    
    return npcarr;
end
