require "scripts/libs/AIFunctions"
require "scripts/default_scripts/SpawnAddonWorld2"
local npc_drop = require "modules/npc_module/npc_drop"
local npc_respawn = require "modules/npc_module/npc_respawn"
local npc_drop_and_kill = require "modules/npc_module/npc_drop_and_kill"

local npc_module = {}

function npc_module.OnGamemodeInit()
    InitAiSystem();
    InitAWNpc();
    npc_respawn.OnGamemodeInit()
end

function npc_module.OnPlayerConnect(playerid)
    AI_OnPlayerConnect(playerid);
end

function npc_module.OnPlayerDisconnect(playerid, reason)
    AI_OnPlayerDisconnect(playerid);
end

function npc_module.OnPlayerKey(playerid, keydown, keyUp)
    AI_OnPlayerKey(playerid, keydown);
end

function npc_module.OnPlayerHit(playerid, killerid)
    AI_OnPlayerHit(playerid, killerid);
end

function npc_module.OnPlayerHasItem(playerid, item_instance, amount, equipped, checkid)
    AI_OnPlayerHasItem(playerid, item_instance, amount, equipped, checkid);
end

function npc_module.OnPlayerResponseItem(playerid, slot, item_instance, amount, equipped)
    AI_OnPlayerResponseItem(playerid, slot, item_instance, amount, equipped);
end

function npc_module.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
    npc_respawn.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
   --npc_drop.OnPlayerDeath(playerid, p_classid, killerid, k_classid)
end

function npc_module.OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
    npc_drop_and_kill.OnPlayerUnconscious(playerid, p_classid, killerid, k_classid)
end


return npc_module

