

function OrcElite()
    local npc = CreateNPC(GetNewNPCName("Орк-командир"));
    
    if(npc == -1)then
        print("Creating Orc Elite Failed!");
    end
    
    SetPlayerInstance(npc,"OrcElite_Roam");

    SetPlayerStrength(npc, 100);
    SetPlayerDexterity(npc, 100);
    SetPlayerMaxHealth(npc, 400);
    SetPlayerHealth(npc, 400);
    SetPlayerSkillWeapon(npc, SKILL_2H, 50);
    
    EquipMeleeWeapon(npc, "jkztzd_itmw_2h_orcaxe_01");
    
    npcarr = {};
    npcarr.id = npc;
    npcarr.daily_routine = nil;
    npcarr.attack_routine = FAI_ONEH_MASTER;
    npcarr.WeaponMode = 4;
    npcarr.dialogs = nil;
    npcarr.update_func = AI_UP_MONSTER;
    npcarr.target_routine = AI_TA_MONSTER;
    npcarr.onhitted = ON_WOLF_HIT;
    npcarr.Guild = AI_GUILD_Scavenger;
    npcarr.func = OrcElite;
    npcarr.respawntime = 9999999990;
    
    return npcarr;
end