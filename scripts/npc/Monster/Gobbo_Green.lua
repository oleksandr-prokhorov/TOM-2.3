
function Gobbo_Green()
    local npc = CreateNPC(GetNewNPCName("Гоблин"));
    
    if(npc == -1)then
        print("Creating Gobbo_Green Failed!");
    end
    
    SetPlayerInstance(npc,"Gobbo_Black");
    
    SetPlayerStrength(npc, 25);
    SetPlayerDexterity(npc, 25);
    SetPlayerMaxHealth(npc, 100);
    SetPlayerHealth(npc, 100);
    
    EquipMeleeWeapon(npc, "ItMw_1h_Bau_Mace");
    
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
    npcarr.func = Gobbo_Green;
	npcarr.respawntime = 900000;
    
    return npcarr;
end
