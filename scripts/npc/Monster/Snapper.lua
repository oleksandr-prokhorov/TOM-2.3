
function Snapper()
	local npc = CreateNPC(GetNewNPCName("Снеппер"));
	
	if(npc == -1)then
		print("Creating Snapper Failed!");
	end
	
	SetPlayerInstance(npc,"Snapper");
	
	SetPlayerStrength(npc, 120);
	SetPlayerDexterity(npc, 120);
	SetPlayerMaxHealth(npc, 400);
	SetPlayerHealth(npc, 400);
	
	
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
	npcarr.func = Snapper;
	npcarr.respawntime = 9000000;
	return npcarr;
end