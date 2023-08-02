_M_OLDHP = {};
for i = 0, 3000 do
	_M_OLDHP[i] = {};
	_M_OLDHP[i].hp = 0;
	_M_OLDHP[i].timer = nil;
end

function AI_OnPlayerHit(playerid, killerid)
	if(AI_NPCList[playerid] == nil)then
		return;
	end
	
	if(AI_NPCList[playerid].OnHitFunc == nil)then
		return;
	end
	AI_NPCList[playerid].OnHitFunc(AI_NPCList[playerid], killerid);

	local getInst = string.upper(GetPlayerInstance(playerid));
	if getInst ~= "PC_HERO" and getInst ~= "SHEEP" then
		if IsNPC(playerid) == 1 then
			if killerid ~= -1 then
				if IsNPC(killerid) == 0 then
					if GetDistancePlayers(playerid, killerid) > 500 then
						local angle = GetAngleToPlayer(playerid, killerid);
						SetPlayerAngle(playerid, angle);
						if _M_OLDHP[playerid].timer == nil then
							_M_OLDHP[playerid].hp = GetPlayerHealth(playerid);
							SetPlayerHealth(playerid, 9999);
							_M_OLDHP[playerid].timer = SetTimerEx(_setDefHealth, 3000, 0, playerid);
						end
						local ani = aniHelper("S", GetPlayerWeaponMode(playerid), "RUNL")
						PlayAnimation(playerid, ani);
						SetEnemy(playerid, killerid);
					end
				end
			end
		end
	end
end

function _setDefHealth(mid)
	SetPlayerHealth(mid, _M_OLDHP[mid].hp);
	_M_OLDHP[mid].hp = 0;
	_M_OLDHP[mid].timer = nil;
end