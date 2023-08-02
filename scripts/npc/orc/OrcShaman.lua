
function OrcShaman()
	local npc = CreateNPC(GetNewNPCName("Орк-шаман"));
	
	if(npc == -1)then
		print("Creating Orc Shaman Failed!");
	end
	
	SetPlayerInstance(npc,"ORCSHAMAN_SIT");
	
	SetPlayerStrength(npc, 30);
	SetPlayerDexterity(npc, 30);
	SetPlayerMaxHealth(npc, 500);
	SetPlayerHealth(npc, 500);
	SetPlayerSkillWeapon(npc, SKILL_2H, 40);
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
	npcarr.func = OrcWarrior;
	npcarr.respawntime = 9999999990;
	
	return npcarr;
end



function OrcWarrior1()
	npcarr = OrcWarrior();
	
	npcarr.func = OrcWarrior1;
	
	
	return npcarr;
end

function OrcWarrior2()
	npcarr = OrcWarrior();
	npcarr.func = OrcWarrior2;
	
	return npcarr;
end

function OrcWarrior3()
	npcarr = OrcWarrior();
	npcarr.func = OrcWarrior3;
	
	return npcarr;
end

function OrcWarrior4()
	npcarr = OrcWarrior();
	npcarr.func = OrcWarrior4;
	
	return npcarr;
end