require "scripts/libs/AIFunctions"
require "scripts/default_scripts/SpawnColony"
local npc_respawn = {}
local time_npc_is_dead = {}
local respawn_time_npc = {}

local function getNpcForName(name)

    if (string.match(name, "^Шершень.*")) then
        return Bloodfly();
		
	elseif (string.match(name, "^Болотный дрон.*")) then
        return SwampDrone();
    
    elseif (string.match(name, "^Шныг.*")) then
        return Lurker();

    elseif (string.match(name, "^Волк.*")) then
        return Wolf();
    
    elseif (string.match(name, "^Кротокрыс.*")) then
        return Molerat();
   
    elseif (string.match(name, "^Падальщик.*")) then
        return Scavenger();

    elseif (string.match(name, "^Кусач.*")) then
        return OrcBiter();
		
	elseif (string.match(name, "^Молодой падальщик.*")) then
        return YoungScavenger();

    elseif (string.match(name, "^Ящер.*")) then
        return Waran();
   
    elseif (string.match(name, "^Элитный гоблин.*")) then
        return MobTest();

	elseif (string.match(name, "^Дконий Снеппер.*")) then
        return DragonSnapper();
		
	elseif (string.match(name, "^Гоблин.*")) then
        return Gobbo_Green();
		
	elseif (string.match(name, "^Черный Гоблин.*")) then
        return Gobbo_Black();
		
	elseif (string.match(name, "^Скелет Воин.*")) then
        return Skeleton();

	elseif (string.match(name, "^Темный Скелет.*")) then
        return SkeletonWarrior();		
		
	elseif (string.match(name, "^Скелет Маг.*")) then
        return SkeletonMage();
		
	elseif (string.match(name, "^Мертвый.*")) then
        return Zombie();		
		
	elseif (string.match(name, "^Мертый Мрак.*")) then
        return Shadowbeast_Skeleton();
		
	elseif (string.match(name, "^Снеппер.*")) then
        return Snapper();
		
	elseif (string.match(name, "^Троль.*")) then
        return Troll();
		
	elseif (string.match(name, "^Черный Троль.*")) then
        return Troll_Black();
		
	elseif (string.match(name, "^Варг.*")) then
        return Warg();
		
	elseif (string.match(name, "^Мракорис.*")) then
        return Shadowbeast();
		
	elseif (string.match(name, "^Орк Воин.*")) then
        return OrcWarrior();
		
	elseif (string.match(name, "^Элитный Орк.*")) then
        return OrcElite();
	
	elseif (string.match(name, "^Орк шаман.*")) then
        return OrcShaman();
		
	elseif (string.match(name, "^Орк разведчик.*")) then
        return OrcRoamer();
		
	elseif (string.match(name, "^Каменный Голем.*")) then
        return StoneGolem();
		
	elseif (string.match(name, "^Аллигатор.*")) then
        return Alligator();
		
	elseif (string.match(name, "^Болотная Акула.*")) then
        return Swampshark();
		
	elseif (string.match(name, "^Бандит.*")) then
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