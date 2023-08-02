
function _weaponModeConnect(id)
	Player[id]._weaponMode = GetPlayerWeaponMode(id);
	Player[id]._weaponModeDraws = {};
	Player[id]._weaponModeDraws[1] = CreatePlayerDraw(id, 0, 0, "");
	Player[id]._weaponModeUpdate = false;
	Player[id]._weaponModeTimer = nil;
end

function _changeWeaponMode(id, wm)

	if IsNPC(id) == 0 then
	
		Player[id]._weaponMode = wm;
		if Player[id]._weaponMode == 1 or Player[id]._weaponMode == 3
		or Player[id]._weaponMode == 4 or Player[id]._weaponMode == 5
		or Player[id]._weaponMode == 6 or Player[id]._weaponMode == 7 then
			for i = 1, table.getn(Player[id]._weaponModeDraws) do
				ShowPlayerDraw(id, Player[id]._weaponModeDraws[i]);
			end
			Player[id]._weaponModeUpdate = true;
			Player[id]._weaponModeTimer = SetTimerEx(_weaponModeFocus, 500, 1, id);
		
		elseif Player[id]._weaponMode == 0 then
			UpdatePlayerDraw(id, Player[id]._weaponModeDraws[1], 154, 6394, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			for i = 1, table.getn(Player[id]._weaponModeDraws) do
				HidePlayerDraw(id, Player[id]._weaponModeDraws[i]);
			end
			Player[id]._weaponModeUpdate = false;
			if Player[id]._weaponModeTimer ~= nil then
				KillTimer(Player[id]._weaponModeTimer);
			end
			Player[id]._weaponModeTimer = nil;
		end
	end

end

function _getDistance(id, fid)
	local x1, y1, z1 = GetPlayerPos(id); local x2, y2, z2 = GetPlayerPos(fid);
	return GetDistance2D(x1, z1, x2, z2) / 100;
end

function _weaponModeFocus(id)

	if Player[id]._weaponModeUpdate == true then
		if GetFocus(id) ~= -1 then
			local fid = GetFocus(id);
			local text = string.format("%s%d%s","Дистанция до цели: ",_getDistance(id, fid),"м.");
			UpdatePlayerDraw(id, Player[id]._weaponModeDraws[1], 154, 6394, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end
end