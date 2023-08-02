
local stats_background = CreateTexture(1979, 1657, 5997, 6241, 'new_stats_v1')

function LogMana(id, mp)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	local txt = GetPlayerName(id).." получил +"..mp.." маны";
	
	LogString("Logs/Stats/Mana.txt", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..txt);

end 

function _initBlocks()

	local file = io.open("Blocks/MANA.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(MANA_BLOCK, name);
			end
		end
	file:close();
	end

	local file = io.open("Blocks/ENERGY.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(ENERGY_BLOCK, name);
			end
		end
	file:close();
	end

	local file = io.open("Blocks/STATS.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(TRAINING_BLOCK, name);
			end
		end
	file:close();
	end

end

function _checkBlock(id, btype, nickname)

	if btype == "mage" then

		local file = io.open("Blocks/MANA.txt", "r");
		if file then
			for line in file:lines() do
				local result, name = sscanf(line, "s");
				if result == 1 then
					if name == nickname then
						file:close();
						return true;
					end
				end
			end
		file:close();
		end
		return false;

	elseif btype == "stats" then

		local file = io.open("Blocks/STATS.txt", "r");
		if file then
			for line in file:lines() do
				local result, name = sscanf(line, "s");
				if result == 1 then
					if name == nickname then
						file:close();
						return true;
					end
				end
			end
		file:close();
		end
		return false;



	elseif btype == "energy" then

		local file = io.open("Blocks/ENERGY.txt", "r");
		if file then
			for line in file:lines() do
				local result, mac = sscanf(line, "s");
				if result == 1 then
					if mac == nickname then
						file:close();
						return true;
					end
				end
			end
		file:close();
		end
		return false;


	end

end

function _addToBlock(id, btype)

	if btype == "mage" then
		local name = Player[id].nickname;
		table.insert(MANA_BLOCK, name);
		local file = io.open("Blocks/MANA.txt", "w+");
		for i, v in pairs(MANA_BLOCK) do
			file:write(v.."\n");
		end
		file:close();

	elseif btype == "stats" then
		local name = Player[id].nickname;
		table.insert(TRAINING_BLOCK, name);
		local file = io.open("Blocks/STATS.txt", "w+");
		for i, v in pairs(TRAINING_BLOCK) do
			file:write(v.."\n");
		end
		file:close();


	elseif btype == "energy" then
		local name = Player[id].nickname;
		table.insert(ENERGY_BLOCK, name);
		local file = io.open("Blocks/ENERGY.txt", "w+");
		for i, v in pairs(ENERGY_BLOCK) do
			file:write(v.."\n");
		end
		file:close();

	end

end


function _statsmage_energy(playerid)

	local status = false;

	if _checkBlock(playerid, "mage", Player[playerid].nickname) == true then
		status = true;
  	end

  	if Player[playerid].readscrolls == 0 then
  		status = true;
  		SendPlayerMessage(playerid, 255, 255, 255, "Вы не можете развивать ману.")
  	end

  	if Player[playerid].gold < 100 then
  		status = true;
  	end

  	if status == false then

  		SendPlayerMessage(playerid, 255, 255, 255, "Вы провели развитие маны.");
  		PlayAnimation(playerid, "T_STAND_2_SIT");

		_offAC(playerid);

		if Player[playerid].mag == 0 then

			if Player[playerid].mp < 50 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 1 then

			if Player[playerid].mp < 100 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 2 then

			if Player[playerid].mp < 200 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				_updateHud(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 3 then

			if Player[playerid].mp < 300 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				_updateHud(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 4 then

			if Player[playerid].mp < 400 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				_updateHud(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 5 then

			if Player[playerid].mp < 500 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				_updateHud(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		elseif Player[playerid].mag == 6 then

			if Player[playerid].mp < 600 then
				Player[playerid].mp = Player[playerid].mp + 10;
				LogMana(playerid, 10)
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SaveStats(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				_updateHud(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				_addToBlock(playerid, "mage");
			else
				Player[playerid].gold = Player[playerid].gold - 100;
				UpdateEnergyBar(playerid);
				SavePlayer(playerid);
				_saveEnergy(playerid);
				SetPlayerMana(playerid, Player[playerid].mp);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
			end

		end

		SetTimerEx(_onAC, 2000, 0, playerid);
		UpdateEnergyBar(playerid);
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Вы уже тренировались сегодня, либо у вас недостаточно золота.")
	end

end

function _statsmage_oc(playerid)

	local status = false;


  	if Player[playerid].readscrolls == 0 then
  		status = true;
  		SendPlayerMessage(playerid, 255, 255, 255, "Вы не можете развивать ману.")
  	end

  	if status == false then

  		SendPlayerMessage(playerid, 255, 255, 255, "Вы провели развитие маны (ОС).");
  		PlayAnimation(playerid, "T_STAND_2_SIT");

		_offAC(playerid);
		if Player[playerid].hpoints >= 2 then
			if Player[playerid].mag == 0 then

				if Player[playerid].mp < 50 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 1 then

				if Player[playerid].mp < 100 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 2 then

				if Player[playerid].mp < 200 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					_updateHud(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 3 then

				if Player[playerid].mp < 300 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					_updateHud(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 4 then

				if Player[playerid].mp < 400 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					_updateHud(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 5 then

				if Player[playerid].mp < 500 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					_updateHud(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			elseif Player[playerid].mag == 6 then

				if Player[playerid].mp < 600 then
					Player[playerid].mp = Player[playerid].mp + 10;
					LogMana(playerid, 10)
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SaveStats(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					_updateHud(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
				else
					Player[playerid].hpoints = Player[playerid].hpoints - 2;
					UpdateEnergyBar(playerid);
					SavePlayer(playerid);
					_saveEnergy(playerid);
					SetPlayerMana(playerid, Player[playerid].mp);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы развили максимум маны.")
				end

			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "У вас нет столько ОС");
		end

		SetTimerEx(_onAC, 2000, 0, playerid);
		UpdateEnergyBar(playerid);
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Вы уже тренировались сегодня, либо у вас недостаточно золота.")
	end

end

function _showManaMenuTimer(id)
	showGUIMenu(id, "MANA_MENU");
end

function _openManaMenu(id)

	if Player[id].loggedIn == true then
		if Player[id].manamenu == 0 then
			SetTimerEx(_showManaMenuTimer, 1000, 0, id);
			Freeze(id);
		else
			hideGUIMenu(id, "MANA_MENU");
		end
	end

end
addCommandHandler({"/медитация"}, _openManaMenu);


function _newStatsConnect(id)

	Player[id]._stats_draws = {};
	for i = 1, 7 do
		Player[id]._stats_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

end

function _updateMyStatsFuture(id)

	if Player[id].str < 30 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[1], 2799, 3140, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].str > 29 and Player[id].str < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[1], 2799, 3140, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].str > 49 and Player[id].str < 60 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[1], 2799, 3140, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[1], 2799, 3140, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)

	end
	----------------------------
	if Player[id].dex < 30 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[2], 2799, 4100, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].dex > 29 and Player[id].dex < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[2], 2799, 4100, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].dex > 49 and Player[id].dex < 60 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[2], 2799, 4100, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[2], 2799, 4100, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)

	end

	----------------------------
	if Player[id].hp < 360 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[3], 2799, 5035, "+15", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].hp > 359 and Player[id].hp < 450 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[3], 2799, 5035, "+10", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].hp > 449 and Player[id].hp < 500 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[3], 2799, 5035, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[3], 2799, 5035, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)
	end

	----------------------------
	if Player[id].h1 < 20 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[4], 5096, 2593, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].h1 > 19 and Player[id].h1 < 40 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[4], 5096, 2593, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].h1 > 39 and Player[id].h1 < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[4], 5096, 2593, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[4], 5096, 2593, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)
		
	end
	----------------------------
	if Player[id].h2 < 20 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[5], 5096, 3553, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].h2 > 19 and Player[id].h2 < 40 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[5], 5096, 3553, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].h2 > 39 and Player[id].h2 < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[5], 5096, 3553, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[5], 5096, 3553, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)
		
	end

	----------------------------
	if Player[id].bow < 20 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[6], 5096, 4473, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].bow > 19 and Player[id].bow < 40 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[6], 5096, 4473, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].bow > 39 and Player[id].bow < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[6], 5096, 4473, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[6], 5096, 4473, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)
		
	end
	----------------------------
	if Player[id].cbow < 20 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[7], 5096, 5403, "+5", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].cbow > 19 and Player[id].cbow < 40 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[7], 5096, 5403, "+2", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	elseif Player[id].cbow > 39 and Player[id].cbow < 50 then
		UpdatePlayerDraw(id, Player[id]._stats_draws[7], 5096, 5403, "+1", "Font_Old_10_White_Hi.TGA", 126, 247, 160)

	else
		UpdatePlayerDraw(id, Player[id]._stats_draws[7], 5096, 5403, "+0", "Font_Old_10_White_Hi.TGA", 255, 30, 30)
		
	end

end

local pos_kazarmi = {6277.1728515625, 848.20452880859, 9390.30078125};
local pos_orc = {100000000, 100000000, 10000000};
local pos_port = {-3058.9470214844, -42.363803863525, -4386.4296875}
local pos4_1 = {13768.81640625, 404.38897705078, -3574.6303710938}; -- маги огня
local pos4_2 = {14414.493164063, -1376.8328857422, -613.60382080078}; -- маги воды
local pos4_3 = {75629.71875, 3612.2917480469, -11347.44140625}; -- старт поз
local pos4_4 = {-31461.580078125, -1176.1448974609, 24262.2890625};  -- яркендар

function ShowStatsPanel(playerid)

	local x, y, z = GetPlayerPos(playerid);
	
	if GetDistance3D(x, y, z, pos_kazarmi[1], pos_kazarmi[2], pos_kazarmi[3]) < 500
	or GetDistance3D(x, y, z, pos_port[1], pos_port[2], pos_port[3]) < 500
	or GetDistance3D(x, y, z, pos4_1[1], pos4_1[2], pos4_1[3]) < 300
	or GetDistance3D(x, y, z, pos4_2[1], pos4_2[2], pos4_2[3]) < 500
	or GetDistance3D(x, y, z, pos4_3[1], pos4_3[2], pos4_3[3]) < 1000	
	or GetDistance3D(x, y, z, pos4_4[1], pos4_4[2], pos4_4[3]) < 500
	
	then

		if Player[playerid].openstatspanel == false then
			ShowTexture(playerid, stats_background);
			Player[playerid].openstatspanel = true;
			SetCursorVisible(playerid, 1);

			Freeze(playerid);
			FreezeCamera(playerid, 1);

		else
			HideTexture(playerid, stats_background);
			Player[playerid].openstatspanel = false;
			SetCursorVisible(playerid, 0);

			UnFreeze(playerid);
			FreezeCamera(playerid, 0);

			for i = 1, 7 do
				HidePlayerDraw(playerid, Player[playerid]._stats_draws[i]);
			end

		end
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Вы не в зоне арены (человек).")
		UnFreeze(playerid);
		FreezeCamera(playerid, 0);
	end

	--[[if pos_orc < 700 then
		if Player[playerid].areorc == 1 then
			if Player[playerid].openstatspanel == false then
				ShowTexture(playerid, stats_background);
				Player[playerid].openstatspanel = true;
				SetCursorVisible(playerid, 1);

				Freeze(playerid);
				FreezeCamera(playerid, 1);

				for i = 1, 7 do
					ShowPlayerDraw(playerid, Player[playerid]._stats_draws[i]);
				end
				_updateMyStatsFuture(playerid);

			else
				HideTexture(playerid, stats_background);
				Player[playerid].openstatspanel = false;
				SetCursorVisible(playerid, 0);

				UnFreeze(playerid);
				FreezeCamera(playerid, 0);

				for i = 1, 7 do
					HidePlayerDraw(playerid, Player[playerid]._stats_draws[i]);
				end

			end
		end
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Вы не в зоне арены (орк).")
		UnFreeze(playerid);
		FreezeCamera(playerid, 0);
	end]]

end
--addCommandHandler({"/stats"}, ShowStatsPanel);

function StatsMouse(playerid, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then

			if Player[playerid].loggedIn == true and Player[playerid].openstatspanel == true then

				if posX > stats_but_1p[1] and posX < stats_but_1p[2] and posY > stats_but_1p[3] and posY < stats_but_1p[4] then
					if Player[playerid].areorc == 0 then
						PickStats(playerid, 1)
					end
				end

				if posX > stats_but_2p[1] and posX < stats_but_2p[2] and posY > stats_but_2p[3] and posY < stats_but_2p[4] then
					PickStats(playerid, 2)
				end

				if posX > stats_but_3p[1] and posX < stats_but_3p[2] and posY > stats_but_3p[3] and posY < stats_but_3p[4] then
					PickStats(playerid, 3)
				end

				if posX > stats_but_4p[1] and posX < stats_but_4p[2] and posY > stats_but_4p[3] and posY < stats_but_4p[4] then
					PickStats(playerid, 4)
				end

				if posX > stats_but_5p[1] and posX < stats_but_5p[2] and posY > stats_but_5p[3] and posY < stats_but_5p[4] then
					PickStats(playerid, 5)
				end

				if posX > stats_but_6p[1] and posX < stats_but_6p[2] and posY > stats_but_6p[3] and posY < stats_but_6p[4] then
					PickStats(playerid, 6)
				end

				if posX > stats_but_7p[1] and posX < stats_but_7p[2] and posY > stats_but_7p[3] and posY < stats_but_7p[4] then
					PickStats(playerid, 7)
				end

			end

		end
	end

end

function LogStats(id, skill, n)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	local txt = GetPlayerName(id).." получил +"..n.." к скиллу "..skill;
	
	LogString("Logs/Stats/Stats.txt", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..txt);

end 

function PickStats(playerid, opt)
	

	if Player[playerid].statsmenu == 1 then
		local status = false;

		if _checkBlock(playerid, "stats", Player[playerid].nickname) == true then
			status = true;
		end

	  	if Player[playerid].gold < 50 then
	  		status = true;
	  	end

	  	if status == false then
		
	  		_offAC(playerid);
	  		------------------------------------------------------------------------------------------------------------
	  		-- ############################################### ЛЮДИ
	  		if Player[playerid].areorc == 0 then
				if opt == 1 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h1 <= 20 then

						Player[playerid].h1 = Player[playerid].h1 + 5;
						LogStats(playerid, "H1", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h1 > 20 and Player[playerid].h1 <= 40 then

						Player[playerid].h1 = Player[playerid].h1 + 2;
						LogStats(playerid, "H1", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h1 > 40 and Player[playerid].h1 < 50 then

						Player[playerid].h1 = Player[playerid].h1 + 1;
						LogStats(playerid, "H1", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h1 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 2 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h2 <= 20 then

						Player[playerid].h2 = Player[playerid].h2 + 5;
						LogStats(playerid, "H2", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h2 > 20 and Player[playerid].h2 <= 40 then

						Player[playerid].h2 = Player[playerid].h2 + 2;
						LogStats(playerid, "H2", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h2 > 40 and Player[playerid].h2 < 50 then

						Player[playerid].h2 = Player[playerid].h2 + 1;
						LogStats(playerid, "H2", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h2 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 3 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
					FreezePlayer(playerid, 1);

					if Player[playerid].str < 30 then

						Player[playerid].str = Player[playerid].str + 5;
						LogStats(playerid, "STR", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerStrength(playerid, Player[playerid].str);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].str >= 30 and Player[playerid].str < 50 then

						Player[playerid].str = Player[playerid].str + 2;
						LogStats(playerid, "STR", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerStrength(playerid, Player[playerid].str);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].str >= 50 and Player[playerid].str < 60 then

						Player[playerid].str = Player[playerid].str + 1;
						LogStats(playerid, "STR", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerStrength(playerid, Player[playerid].str);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].str == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 4 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкость!");
					FreezePlayer(playerid, 1);

					if Player[playerid].dex < 30 then

						Player[playerid].dex = Player[playerid].dex + 5;
						LogStats(playerid, "DEX", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerDexterity(playerid, Player[playerid].dex);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].dex > 29 and Player[playerid].dex < 50 then

						Player[playerid].dex = Player[playerid].dex + 2;
						LogStats(playerid, "DEX", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerDexterity(playerid, Player[playerid].dex);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].dex > 49 and Player[playerid].dex < 60 then

						Player[playerid].dex = Player[playerid].dex + 1;
						LogStats(playerid, "DEX", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerDexterity(playerid, Player[playerid].dex);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].dex == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 5 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
					FreezePlayer(playerid, 1);

					if Player[playerid].bow < 20 then

						Player[playerid].bow = Player[playerid].bow + 5;
						LogStats(playerid, "BOW", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].bow >= 20 and Player[playerid].bow < 40 then

						Player[playerid].bow = Player[playerid].bow + 2;
						LogStats(playerid, "BOW", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].bow >= 40 and Player[playerid].bow < 50 then

						Player[playerid].bow = Player[playerid].bow + 1;
						LogStats(playerid, "BOW", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].bow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 6 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
					FreezePlayer(playerid, 1);

					if Player[playerid].cbow < 20 then

						Player[playerid].cbow = Player[playerid].cbow + 5;
						LogStats(playerid, "CBOW", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].cbow >= 20 and Player[playerid].cbow < 40 then

						Player[playerid].cbow = Player[playerid].cbow + 2;
						LogStats(playerid, "CBOW", 2)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].cbow >= 40 and Player[playerid].cbow < 50 then

						Player[playerid].cbow = Player[playerid].cbow + 1;
						LogStats(playerid, "CBOW", 1)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].cbow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 7 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
					FreezePlayer(playerid, 1);

					if Player[playerid].hp < 360 then
						Player[playerid].hp = Player[playerid].hp + 15;
						LogStats(playerid, "HP", 15)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp > 359 and Player[playerid].hp < 450 then

						Player[playerid].hp = Player[playerid].hp + 10;
						LogStats(playerid, "HP", 10)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp > 449 and Player[playerid].hp < 500 then

						Player[playerid].hp = Player[playerid].hp + 5;
						LogStats(playerid, "HP", 5)
						Player[playerid].gold = Player[playerid].gold - 50;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp >= 500 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				
				_updateMyStatsFuture(playerid);
				-- №№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
			else
				------------------------------------------------------------------------------------------------------------
				if opt == 1 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h1 < 30 then

						Player[playerid].h1 = Player[playerid].h1 + 5;
						LogStats(playerid, "H1", 5)
						Player[playerid].gold = Player[playerid].gold - 100;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h1 > 29 and Player[playerid].h1 < 50 then

						Player[playerid].h1 = Player[playerid].h1 + 2;
						LogStats(playerid, "H1", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h1 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 2 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h2 < 30 then

						Player[playerid].h2 = Player[playerid].h2 + 5;
						LogStats(playerid, "H2", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h2 > 29 and Player[playerid].h2 < 50 then

						Player[playerid].h2 = Player[playerid].h2 + 2;
						LogStats(playerid, "H2", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].h2 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 3 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
					FreezePlayer(playerid, 1);

					if Player[playerid].str < 30 then

						Player[playerid].str = Player[playerid].str + 5;
						LogStats(playerid, "STR", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerStrength(playerid, Player[playerid].str);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].str > 29 and Player[playerid].str < 60 then

						Player[playerid].str = Player[playerid].str + 2;
						LogStats(playerid, "STR", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerStrength(playerid, Player[playerid].str);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].str == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 4 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкость!");
					FreezePlayer(playerid, 1);

					if Player[playerid].dex < 30 then

						Player[playerid].dex = Player[playerid].dex + 5;
						LogStats(playerid, "DEX", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerDexterity(playerid, Player[playerid].dex);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].dex > 49 and Player[playerid].dex < 60 then

						Player[playerid].dex = Player[playerid].dex + 2;
						LogStats(playerid, "DEX", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerDexterity(playerid, Player[playerid].dex);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].dex == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 5 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
					FreezePlayer(playerid, 1);

					if Player[playerid].bow < 30 then

						Player[playerid].bow = Player[playerid].bow + 5;
						LogStats(playerid, "BOW", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].bow > 29 and Player[playerid].bow < 50 then

						Player[playerid].bow = Player[playerid].bow + 2;
						LogStats(playerid, "BOW", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].bow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 6 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
					FreezePlayer(playerid, 1);

					if Player[playerid].cbow < 30 then

						Player[playerid].cbow = Player[playerid].cbow + 5;
						LogStats(playerid, "CBOW", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].cbow > 29 and Player[playerid].cbow < 50 then

						Player[playerid].cbow = Player[playerid].cbow + 2;
						LogStats(playerid, "CBOW", 2)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						SaveStats(playerid);
						SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						_addToBlock(playerid, "stats");

					elseif Player[playerid].cbow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 7 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
					FreezePlayer(playerid, 1);

					if Player[playerid].hp < 360 then
						Player[playerid].hp = Player[playerid].hp + 15;
						LogStats(playerid, "HP", 15)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp > 359 and Player[playerid].hp < 450 then

						Player[playerid].hp = Player[playerid].hp + 10;
						LogStats(playerid, "HP", 10)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp > 449 and Player[playerid].hp < 500 then

						Player[playerid].hp = Player[playerid].hp + 5;
						LogStats(playerid, "HP", 5)
						Player[playerid].energy = Player[playerid].energy - 25;
						UpdateEnergyBar(playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						_addToBlock(playerid, "stats");
						SetPlayerMaxHealth(playerid, Player[playerid].hp);
						SetPlayerHealth(playerid, Player[playerid].hp);
						SaveStats(playerid);


					elseif Player[playerid].hp >= 500 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
			end
			------------------------------------------------------------------------------------------------------------
			SetTimerEx(_onAC, 2000, 0, playerid);
			ShowStatsPanel(playerid);
			UpdateEnergyBar(playerid);
			_updateMyStatsFuture(playerid);
		else
			GameTextForPlayer(playerid, 2054, 6201, "У вас недостаточно золота, либо вы уже тренировались сегодня.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
		end
		
		

	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################	
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################
	-- ############################################################################################################

	elseif Player[playerid].statsmenu == 2 then
		
		if Player[playerid].hpoints >= 1 then
			------------------------------------------------------------------------------------------------------------
			-- ############################################### ЛЮДИ
			if Player[playerid].areorc == 0 then
				if opt == 1 then

					if Player[playerid].h1 < 20 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h1 = Player[playerid].h1 + 5;
							LogStats(playerid, "H1", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h1 >= 20 and Player[playerid].h1 < 40 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h1 = Player[playerid].h1 + 2;
							LogStats(playerid, "H1", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h1 >= 40 and Player[playerid].h1 < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h1 = Player[playerid].h1 + 1;
							LogStats(playerid, "H1", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h1 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 2 then

					if Player[playerid].h2 < 20 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h2 = Player[playerid].h2 + 5;
							LogStats(playerid, "H2", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h2 >= 20 and Player[playerid].h2 < 40 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h2 = Player[playerid].h2 + 2;
							LogStats(playerid, "H2", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h2 >= 40 and Player[playerid].h2 < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h2 = Player[playerid].h2 + 1;
							LogStats(playerid, "H2", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].h2 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 3 then

					if Player[playerid].str < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].str = Player[playerid].str + 5;
							LogStats(playerid, "STR", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerStrength(playerid, Player[playerid].str);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].str >= 30 and Player[playerid].str < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].str = Player[playerid].str + 2;
							LogStats(playerid, "STR", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerStrength(playerid, Player[playerid].str);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].str >= 50 and Player[playerid].str < 60 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].str = Player[playerid].str + 1;
							LogStats(playerid, "STR", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerStrength(playerid, Player[playerid].str);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
							FreezePlayer(playerid, 1);
						end


					elseif Player[playerid].str == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 4 then

					if Player[playerid].dex < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].dex = Player[playerid].dex + 5;
							LogStats(playerid, "DEX", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerDexterity(playerid, Player[playerid].dex);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкости!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].dex >= 30 and Player[playerid].dex < 50 then

						if Player[playerid].hpoints >= 1 then
							Player[playerid].dex = Player[playerid].dex + 2;
							LogStats(playerid, "DEX", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerDexterity(playerid, Player[playerid].dex);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкости!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].dex >= 50 and Player[playerid].dex < 60 then

						if Player[playerid].hpoints >= 1 then
							Player[playerid].dex = Player[playerid].dex + 1;
							LogStats(playerid, "DEX", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerDexterity(playerid, Player[playerid].dex);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкости!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].dex == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 5 then

					if Player[playerid].bow < 20 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].bow = Player[playerid].bow + 5;
							LogStats(playerid, "BOW", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].bow >= 20 and Player[playerid].bow < 40 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].bow = Player[playerid].bow + 2;
							LogStats(playerid, "BOW", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].bow >= 40 and Player[playerid].bow < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].bow = Player[playerid].bow + 1;
							LogStats(playerid, "BOW", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
							FreezePlayer(playerid, 1);
						end


					elseif Player[playerid].bow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 6 then

					if Player[playerid].cbow < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].cbow = Player[playerid].cbow + 5;
							LogStats(playerid, "CBOW", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].cbow >= 20 and Player[playerid].cbow < 40 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].cbow = Player[playerid].cbow + 2;
							LogStats(playerid, "CBOW", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].cbow >= 40 and Player[playerid].cbow < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].cbow = Player[playerid].cbow + 1;
							LogStats(playerid, "CBOW", 1)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].cbow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 7 then

					if Player[playerid].hp > 299 and Player[playerid].hp < 360 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 15;
							LogStats(playerid, "HP", 15)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
							FreezePlayer(playerid, 1);
						end


					elseif Player[playerid].hp > 359 and Player[playerid].hp < 450 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 10;
							LogStats(playerid, "HP", 10)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
							FreezePlayer(playerid, 1);
						end

					elseif Player[playerid].hp > 449 and Player[playerid].hp < 500 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 5;
							LogStats(playerid, "HP", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
							SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
							FreezePlayer(playerid, 1);
						end


					elseif Player[playerid].hp >= 500 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				-- №№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№№
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
				-- ########################################## ОРКИ
			else
				------------------------------------------------------------------------------------------------------------
				if opt == 1 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства одноручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h1 < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h1 = Player[playerid].h1 + 5;
							LogStats(playerid, "H1", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						end

					elseif Player[playerid].h1 > 29 and Player[playerid].h1 < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h1 = Player[playerid].h1 + 2;
							LogStats(playerid, "H1", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_1H, Player[playerid].h1);
						end

					elseif Player[playerid].h1 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 2 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства двуручного оружия!");
					FreezePlayer(playerid, 1);

					if Player[playerid].h2 < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h2 = Player[playerid].h2 + 5;
							LogStats(playerid, "H2", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						end

					elseif Player[playerid].h2 > 29 and Player[playerid].h2 < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].h2 = Player[playerid].h2 + 2;
							LogStats(playerid, "H2", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_2H, Player[playerid].h2);
						end

					elseif Player[playerid].h2 == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 3 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению силы!");
					FreezePlayer(playerid, 1);

					if Player[playerid].str < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].str = Player[playerid].str + 5;
							LogStats(playerid, "STR", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerStrength(playerid, Player[playerid].str);
						end

					elseif Player[playerid].str > 29 and Player[playerid].str < 60 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].str = Player[playerid].str + 2;
							LogStats(playerid, "STR", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerStrength(playerid, Player[playerid].str);
						end


					elseif Player[playerid].str == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 4 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку по увеличению ловкость!");
					FreezePlayer(playerid, 1);

					if Player[playerid].dex < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].dex = Player[playerid].dex + 5;
							LogStats(playerid, "DEX", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerDexterity(playerid, Player[playerid].dex);
						end

					elseif Player[playerid].dex > 29 and Player[playerid].dex < 60 then

						if Player[playerid].hpoints >= 1 then
							Player[playerid].dex = Player[playerid].dex + 2;
							LogStats(playerid, "DEX", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerDexterity(playerid, Player[playerid].dex);
						end

					elseif Player[playerid].dex == 60 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 5 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения луком!");
					FreezePlayer(playerid, 1);

					if Player[playerid].bow < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].bow = Player[playerid].bow + 5;
							LogStats(playerid, "BOW", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						end

					elseif Player[playerid].bow > 29 and Player[playerid].bow < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].bow = Player[playerid].bow + 2;
							LogStats(playerid, "BOW", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_BOW, Player[playerid].bow);
						end


					elseif Player[playerid].bow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 6 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку мастерства владения арбалетом!");
					FreezePlayer(playerid, 1);

					if Player[playerid].cbow < 30 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].cbow = Player[playerid].cbow + 5;
							LogStats(playerid, "CBOW", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						end

					elseif Player[playerid].cbow > 29 and Player[playerid].cbow < 50 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].cbow = Player[playerid].cbow + 2;
							LogStats(playerid, "CBOW", 2)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SaveStats(playerid);
							SetPlayerSkillWeapon(playerid, SKILL_CBOW, Player[playerid].cbow);
						end

					elseif Player[playerid].cbow == 50 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
				------------------------------------------------------------------------------------------------------------
				if opt == 7 then
					SendPlayerMessage(playerid, 255, 255, 255, "Вы провели тренировку повышения живучести!");
					FreezePlayer(playerid, 1);

					if Player[playerid].hp > 299 and Player[playerid].hp < 360 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 15;
							LogStats(playerid, "HP", 15)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
						end


					elseif Player[playerid].hp > 360 and Player[playerid].hp < 450 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 10;
							LogStats(playerid, "HP", 10)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
						end

					elseif Player[playerid].hp > 450 and Player[playerid].hp < 500 then
						if Player[playerid].hpoints >= 1 then
							Player[playerid].hp = Player[playerid].hp + 5;
							LogStats(playerid, "HP", 5)
							Player[playerid].hpoints = Player[playerid].hpoints - 1;
							SavePlayer(playerid);
							_saveEnergy(playerid);
							SetPlayerMaxHealth(playerid, Player[playerid].hp);
							SetPlayerHealth(playerid, Player[playerid].hp);
							SaveStats(playerid);
						end


					elseif Player[playerid].hp >= 500 then
						SendPlayerMessage(playerid, 255, 255, 255, "Достигнул предел прокачки.")
					end
				end
			end
		
		else
			GameTextForPlayer(playerid, 2054, 6201, "У вас недостаточно очков сюжета для развития характеристики.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
		end
	end
	
	_updateMyStatsFuture(playerid);
	
end

function opoveshenie_dlya_igroka_chto_on_zakonchil_prokachky_mani(id)

	SendPlayerMessage(id, 255, 255, 255, "Вы успешно развили ману.")
	SendPlayerMessage(id, 255, 255, 255, "Ваша мана полностью восстановлена.")
	SetPlayerMana(id, GetPlayerMaxMana(id));

end

function UnFreezeP(playerid)
	FreezePlayer(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
end

createGUIMenu("STATS_MENU", {
	{ "Тренировка за золото" },
	{ "Тренировка за ОС" },
	{ "Закрыть" },
    }, 150, 150, 150, 255, 255, 255, 5728, 3266, "Font_Old_10_White_Hi.TGA", nil, 3);

createGUIMenu("MANA_MENU", {
	{ "Тренировка за энергию" },
	{ "Тренировка за ОС" },
	{ "Закрыть" },
    }, 150, 150, 150, 255, 255, 255, 5728, 3266, "Font_Old_10_White_Hi.TGA", nil, 3);


function TrainKey(playerid, keyDown, keyUp)
	
	local x, y, z = GetPlayerPos(playerid);
	if Player[playerid].loggedIn == true then
		if keyDown == KEY_P then
			if Player[playerid].openstatspanel == false then
				if GetDistance3D(x, y, z, pos_kazarmi[1], pos_kazarmi[2], pos_kazarmi[3]) < 500 
				or GetDistance3D(x, y, z, pos_port[1], pos_port[2], pos_port[3]) < 500 
				or GetDistance3D(x, y, z, pos4_1[1], pos4_1[2], pos4_1[3]) < 300
				or GetDistance3D(x, y, z, pos4_2[1], pos4_2[2], pos4_2[3]) < 500
				or GetDistance3D(x, y, z, pos4_3[1], pos4_3[2], pos4_3[3]) < 1000
				or GetDistance3D(x, y, z, pos4_4[1], pos4_4[2], pos4_4[3]) < 500
					
				then
					Freeze(playerid);
					showGUIMenu(playerid, "STATS_MENU");
					FreezeCamera(playerid, 1);
				end
			else
				ShowStatsPanel(playerid);
			end
		end

		if keyDown == KEY_UP then
			switchGUIMenuUp(playerid, "STATS_MENU");
			switchGUIMenuUp(playerid, "MANA_MENU");
		end

		if keyDown == KEY_DOWN then
			switchGUIMenuDown(playerid, "STATS_MENU");
			switchGUIMenuDown(playerid, "MANA_MENU");
		end

		if keyDown == KEY_RETURN then
			if getPlayerOptionID(playerid, "STATS_MENU") == 1 then
				hideGUIMenu(playerid, "STATS_MENU");
				ShowStatsPanel(playerid);
				Player[playerid].statsmenu = 1;
				_updateMyStatsFuture(playerid);
				
				for i = 1, 7 do
					ShowPlayerDraw(playerid, Player[playerid]._stats_draws[i]);
				end

			elseif getPlayerOptionID(playerid, "STATS_MENU") == 2 then
				hideGUIMenu(playerid, "STATS_MENU");
				ShowStatsPanel(playerid);
				Player[playerid].statsmenu = 2;
				_updateMyStatsFuture(playerid);
				
				for i = 1, 7 do
					ShowPlayerDraw(playerid, Player[playerid]._stats_draws[i]);
				end

			elseif getPlayerOptionID(playerid, "STATS_MENU") == 3 then
				UnFreeze(playerid);
				hideGUIMenu(playerid, "STATS_MENU");
				FreezeCamera(playerid, 0);
				Player[playerid].statsmenu = 0;
			-------------------------------------------------------
			elseif getPlayerOptionID(playerid, "MANA_MENU") == 1 then
				hideGUIMenu(playerid, "MANA_MENU");
				_statsmage_energy(playerid);
				Player[playerid].manamenu = 0;
				UnFreeze(playerid);

			elseif getPlayerOptionID(playerid, "MANA_MENU") == 2 then
				hideGUIMenu(playerid, "MANA_MENU");
				_statsmage_oc(playerid);
				Player[playerid].manamenu = 0;
				UnFreeze(playerid);

			elseif getPlayerOptionID(playerid, "MANA_MENU") == 3 then
				UnFreeze(playerid);
				hideGUIMenu(playerid, "MANA_MENU");
				FreezeCamera(playerid, 0);
				Player[playerid].manamenu = 0;
			end
		end
	end
end