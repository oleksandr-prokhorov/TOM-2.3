function Shadowbeast()
	local npc = CreateNPC(GetNewNPCName("ћракорис"));
	
	if(npc == -1)then
		print("Creating Shadowbeast Failed!");
	end
	
	SetPlayerInstance(npc,"Shadowbeast");
	
	SetPlayerStrength(npc, 150);
	SetPlayerDexterity(npc, 150);
	SetPlayerMaxHealth(npc, 650);
	SetPlayerHealth(npc, 650);
	
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 0;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.GotEnemyFunc = AI_GOTENEMY_MONSTER_FLEE;
	npcarr.func = Shadowbeast;
	npcarr.respawntime = 900000;
	
	return npcarr;
end