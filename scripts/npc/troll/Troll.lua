function Troll()
	local npc = CreateNPC(GetNewNPCName("Троль"));
	
	if(npc == -1)then
		print("Creating Troll Failed!");
	end
	
	SetPlayerInstance(npc,"Troll");
	
	SetPlayerStrength(npc, 105);
	SetPlayerDexterity(npc, 100);
	SetPlayerLevel(npc, 50);
	SetPlayerMaxHealth(npc, 1100);
	SetPlayerHealth(npc, 1100);
	
	
	npcarr = {};
	npcarr.id = npc;
	npcarr.daily_routine = nil;
	npcarr.attack_routine = FAI_WOLF_ATTACK;
	npcarr.WeaponMode = 0;
	npcarr.dialogs = nil;
	npcarr.update_func = AI_UP_MONSTER;
	npcarr.target_routine = AI_TA_MONSTER;
	npcarr.onhitted = ON_WOLF_HIT;
	npcarr.Guild = AI_GUILD_Troll;
	npcarr.func = Troll;
	npcarr.respawntime = 900000000;
	
	return npcarr;
end