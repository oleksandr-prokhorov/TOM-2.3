
function SaveStats(playerid)
	
	if IsNPC(playerid) == 0 and Player[playerid].loggedIn == true then
		local file = io.open("Database/Players/Stats/"..Player[playerid].nickname..".db", "w+");

		file:write(Player[playerid].str.."\n");
		file:write(Player[playerid].dex.."\n");
		file:write(Player[playerid].hp.."\n");
		file:write(Player[playerid].mp.."\n");
		file:write(Player[playerid].h1.."\n");
		file:write(Player[playerid].h2.."\n");
		file:write(Player[playerid].cbow.."\n");
		file:write(Player[playerid].bow.."\n");
		file:write(Player[playerid].mag.."\n");

		if GetPlayerHealth(playerid) > 1 then
			file:write(GetPlayerHealth(playerid).."\n");
		else
			file:write("10\n");
		end
		file:write(GetPlayerMana(playerid).."\n");
		file:close();
	end

end

function ReadStats(playerid)
	
	local file = io.open("Database/Players/Stats/"..Player[playerid].nickname..".db", "r+");
	
	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].str = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].dex = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].hp = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].mp = par;
		end

	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].h1 = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].h2 = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].cbow = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].bow = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].mag = par;
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			if par > 9 then
				Player[playerid].chp = par;
			elseif par < 10 then
				Player[playerid].chp = 10;
			end
		end


	tempvar = file:read("*l");
		local result, par = sscanf(tempvar,"d");
		if result == 1 then
			Player[playerid].cmp = par;
		end

	file:close();

end


function _doubleSaveStats(playerid)

	if IsNPC(playerid) == 0 and Player[playerid].loggedIn == true then
		local file = io.open("Database/Players/Stats/"..Player[playerid].nickname.."_double.db", "w+");

		file:write(Player[playerid].str.."\n");
		file:write(Player[playerid].dex.."\n");
		file:write(Player[playerid].hp.."\n");
		file:write(Player[playerid].mp.."\n");
		file:write(Player[playerid].h1.."\n");
		file:write(Player[playerid].h2.."\n");
		file:write(Player[playerid].cbow.."\n");
		file:write(Player[playerid].bow.."\n");
		file:write(Player[playerid].mag.."\n");
		
		if GetPlayerHealth(playerid) > 1 then
			file:write(GetPlayerHealth(playerid).."\n");
		else
			file:write("10\n");
		end
		file:write(GetPlayerMana(playerid).."\n");
		file:close();
	end
	
end

function _checkStats(playerid)

	if IsNPC(playerid) == 0 and Player[playerid].loggedIn == true then
	
		local file = io.open("Database/Players/Stats/"..Player[playerid].nickname.."_double.db", "r");
		if file then
		
			local stats = {};
		
			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end

			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end

			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end

			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end

			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end


			tempvar = file:read("*l");
			local result, par = sscanf(tempvar,"d");
			if result == 1 then
				table.insert(stats, par);
			end
			
			
			file:close();
			
			local check = false;
			
			if GetPlayerStrength(playerid) ~= stats[1] then
				SetPlayerStrength(playerid, stats[1]);
				Player[playerid].str = stats[1];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (СИЛА), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
			
			elseif GetPlayerDexterity(playerid) ~= stats[2] then
				SetPlayerDexterity(playerid, stats[2]);
				Player[playerid].dex = stats[2];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ЛОВКОСТЬ), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerMaxHealth(playerid) ~= stats[3] then
				SetPlayerMaxHealth(playerid, stats[3]);
				Player[playerid].hp = stats[3];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (МХП), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerMaxMana(playerid) ~= stats[4] then
				SetPlayerMaxMana(playerid, stats[4]);
				Player[playerid].mp = stats[4];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ММП), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerSkillWeapon(playerid, SKILL_1H) ~= stats[5] then
				SetPlayerWeaponSkill(playerid, SKILL_1H, stats[5]);
				Player[playerid].h1 = stats[5];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ОДНОРУЧ), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerSkillWeapon(playerid, SKILL_2H) ~= stats[6] then
				SetPlayerWeaponSkill(playerid, SKILL_2H, stats[6]);
				Player[playerid].h2 = stats[6];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ДВУРУЧ), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerSkillWeapon(playerid, SKILL_BOW) ~= stats[7] then
				SetPlayerWeaponSkill(playerid, SKILL_BOW, stats[7]);
				Player[playerid].bow = stats[7];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ЛУК), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerSkillWeapon(playerid, SKILL_CBOW) ~= stats[8] then
				SetPlayerWeaponSkill(playerid, SKILL_CBOW, stats[8]);
				Player[playerid].cbow = stats[8];
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (АРБАЛЕТ), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerMagicLevel(playerid) ~= stats[9] then
				SetPlayerMagicLevel(playerid, stats[9]);
				Player[playerid].mag = stats[9];
				
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (КРУГ), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			elseif GetPlayerHealth(playerid) ~= stats[10] then
			
				--[[if stats[10] > 0 then
					SetPlayerHealth(playerid, 10);
					Player[playerid].chp = 10;
				else
					SetPlayerHealth(playerid, stats[10]);
					Player[playerid].chp = stats[10];
				end]]
				
				--LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (ХП), произошла подгрузка из доп. файла / ".._getRTime());
				--check = true;
				
			elseif GetPlayerMana(playerid) ~= stats[11] then
			
				if stats[11] > 0 then
					SetPlayerMana(playerid, 10);
					Player[playerid].cmp = 10;
				else
					SetPlayerMana(playerid, stats[11]);
					Player[playerid].chp = stats[11];
				end
				
				LogString("Logs/RecoveryStats",Player[playerid].nickname.." не подгрузил характеристики (МП), произошла подгрузка из доп. файла / ".._getRTime());
				check = true;
				
			end
			
		
		else
			_doubleSaveStats(playerid)
		end
	end

end

