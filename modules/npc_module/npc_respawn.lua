require "scripts/libs/AIFunctions"
require "scripts/default_scripts/SpawnColony"
local npc_respawn = {}
local time_npc_is_dead = {}
local respawn_time_npc = {}

local function getNpcForName(name)

    if (string.match(name, "^�������.*")) then
        return Bloodfly();
		
	elseif (string.match(name, "^�������� ����.*")) then
        return SwampDrone();
    
    elseif (string.match(name, "^����.*")) then
        return Lurker();

    elseif (string.match(name, "^����.*")) then
        return Wolf();
    
    elseif (string.match(name, "^���������.*")) then
        return Molerat();
   
    elseif (string.match(name, "^���������.*")) then
        return Scavenger();

    elseif (string.match(name, "^�����.*")) then
        return OrcBiter();
		
	elseif (string.match(name, "^������� ���������.*")) then
        return YoungScavenger();

    elseif (string.match(name, "^����.*")) then
        return Waran();
   
    elseif (string.match(name, "^������� ������.*")) then
        return MobTest();

	elseif (string.match(name, "^������ �������.*")) then
        return DragonSnapper();
		
	elseif (string.match(name, "^������.*")) then
        return Gobbo_Green();
		
	elseif (string.match(name, "^������ ������.*")) then
        return Gobbo_Black();
		
	elseif (string.match(name, "^������ ����.*")) then
        return Skeleton();

	elseif (string.match(name, "^������ ������.*")) then
        return SkeletonWarrior();		
		
	elseif (string.match(name, "^������ ���.*")) then
        return SkeletonMage();
		
	elseif (string.match(name, "^�������.*")) then
        return Zombie();		
		
	elseif (string.match(name, "^������ ����.*")) then
        return Shadowbeast_Skeleton();
		
	elseif (string.match(name, "^�������.*")) then
        return Snapper();
		
	elseif (string.match(name, "^�����.*")) then
        return Troll();
		
	elseif (string.match(name, "^������ �����.*")) then
        return Troll_Black();
		
	elseif (string.match(name, "^����.*")) then
        return Warg();
		
	elseif (string.match(name, "^��������.*")) then
        return Shadowbeast();
		
	elseif (string.match(name, "^��� ����.*")) then
        return OrcWarrior();
		
	elseif (string.match(name, "^������� ���.*")) then
        return OrcElite();
	
	elseif (string.match(name, "^��� �����.*")) then
        return OrcShaman();
		
	elseif (string.match(name, "^��� ���������.*")) then
        return OrcRoamer();
		
	elseif (string.match(name, "^�������� �����.*")) then
        return StoneGolem();
		
	elseif (string.match(name, "^���������.*")) then
        return Alligator();
		
	elseif (string.match(name, "^�������� �����.*")) then
        return Swampshark();
		
	elseif (string.match(name, "^������.*")) then
        return Bandit();
		
    end
end




local function getWaypointForName(playerid, name)
    return AI_NPCList[playerid].StartWP
end

function respawnNpc(playerid)
    local name = GetPlayerName(playerid);
    local world = GetPlayerWorld(playerid);
    local wp = getWaypointForName(playerid, name)
    DestroyNPC(playerid);
    SpawnNPC(getNpcForName(name), wp, world);
end


function CheckDeadNpcForRespawn()
    for key, value in pairs(time_npc_is_dead) do
        if (os.clock() - value > respawn_time_npc[key]) then
            time_npc_is_dead[key] = nil
            respawn_time_npc[key] = nil
            respawnNpc(key);
        end
    end
end

function npc_respawn.OnGamemodeInit()
    R1_Respawn_Timer = SetTimer("CheckDeadNpcForRespawn", 5000, 1);
end

function npc_respawn.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
    if AI_NPCList[playerid] ~= nil and IsNPC(playerid) == 1 then
		time_npc_is_dead[playerid] = os.clock();
        respawn_time_npc[playerid] = AI_NPCList[playerid].RespawnTime
    end
end

return npc_respawn