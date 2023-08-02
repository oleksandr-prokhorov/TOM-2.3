function Shadowbeast()
	local npc = CreateNPC(GetNewNPCName("ћракорис"));
	
	if(npc == -1)then
		print("Creating Shadowbeast Failed!");
	end
	
	SetPlayerInstance(npc,"Shadowbeast");
	
	SetPlayerStrength(npc, 200);
	SetPlayerDexterity(npc, 200);
	SetPlayerMaxHealth(npc, 800);
	SetPlayerHealth(npc, 800);
	
	local npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = DR_Monster_MidEat;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 0;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Scavenger;
	npcarr.func = Shadowbeast;
	npcarr.respawntime = 9999999999;
	return npcarr;
end