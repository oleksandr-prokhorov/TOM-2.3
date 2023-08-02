function SaveItems(playerid)

	if Player[playerid].hero_use[1] == false then
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	else
		local file = io.open("Database/Heroes/Items/"..GetPlayerName(playerid)..".txt","w+");
		local items = getPlayerItems(playerid);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	end

end


function ReadItems(playerid)

	if Player[playerid].hero_use[1] == false then
		_readEquip(playerid);
		local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, bdvalue = sscanf(line,"sd");
				if result == 1 and bdvalue ~= 0 then

					if Player[playerid].emelee == item then
						if bdvalue == 1 then
							EquipMeleeWeapon(playerid, item);
						else
							local val = bdvalue - 1;
							EquipMeleeWeapon(playerid, item);
							GiveItem(playerid, item, val);
						end

					elseif Player[playerid].erange == item then
						if bdvalue == 1 then
							EquipRangedWeapon(playerid, item);
						else
							local val = bdvalue - 1;
							EquipRangedWeapon(playerid, item);
							GiveItem(playerid, item, val);
						end

					elseif Player[playerid].earmor == item then
						if bdvalue == 1 then
							EquipArmor(playerid, item);
						else
							local val = bdvalue - 1;
							EquipArmor(playerid, item);
							GiveItem(playerid, item, val);
						end

					elseif Player[playerid].ehelmet == item then
						if bdvalue == 1 then
							EquipItem(playerid, item);
						else
							local val = bdvalue - 1;
							EquipItem(playerid, item);
							GiveItem(playerid, item, val);
						end

					else
						GiveItem(playerid, item, bdvalue);
					end
				end
			end
		file:close();
		end
	else
		local file = io.open("Database/Heroes/Items/"..GetPlayerName(playerid)..".txt","r+");
		if file then
			for line in file:lines() do 
				local result, item, bdvalue = sscanf(line,"sd");
				if result == 1 and bdvalue ~= 0 then
					GiveItem(playerid, item, bdvalue);
				end
			end
		file:close();
		end
	end

end

function _saveEquip(id)
	local armor = GetEquippedArmor(id);
	local melee = GetEquippedMeleeWeapon(id);
	local range = GetEquippedRangedWeapon(id);
	local helmet = GetEquippedHelmet(id);
	local file = io.open("Database/Players/Items/Equip/"..GetPlayerName(id)..".txt", "w");
	file:write(armor.." "..melee.." "..range.." "..helmet);
	file:close();
end

function _readEquip(id)

	local file = io.open("Database/Players/Items/Equip/"..GetPlayerName(id)..".txt", "r");
	if file then

		line = file:read("*l");
		local l, armor, melee, range, helmet = sscanf(line, "ssss");
		if l == 1 then
			Player[id].emelee = string.upper(melee);
			Player[id].earmor = string.upper(armor);
			Player[id].erange = string.upper(range);
			Player[id].ehelmet = string.upper(helmet);
		end

		SendPlayerMessage(id, 0, 0, 0, " ");
		if helmet == "NULL" and armor == "NULL" and melee == "NULL" and range == "NULL" then
		else
			SendPlayerMessage(id, 142, 237, 166, "Загружена экипировка:");
		end
		if helmet ~= "NULL" then
			SendPlayerMessage(id, 142, 237, 166, "Головной убор: "..GetItemName(helmet));
		end
		if armor ~= "NULL" then
			SendPlayerMessage(id, 142, 237, 166, "Доспехи: "..GetItemName(armor));
		end
		if melee ~= "NULL" then
			SendPlayerMessage(id, 142, 237, 166, "Ближнее оружие: "..GetItemName(melee));
		end
		if range ~= "NULL" then
			SendPlayerMessage(id, 142, 237, 166, "Дальнее оружие: "..GetItemName(range));
		end

		file:close();

	else
		_saveEquip(id);
	end

end