


function _saveInst(id)
	local file = io.open("Database/Players/Inst/"..Player[id].nickname..".txt", "w+");
	
	if Player[id].areorc == 1 then
		file:write(Player[id].areorc.."\n");
		file:write(GetPlayerInstance(id).."\n")
	else
		file:write("0".."\n".."0");
	end

	file:close();
end

function _readInst(id)
	local file = io.open("Database/Players/Inst/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, status = sscanf(line, "d");
		if result == 1 then
			Player[id].areorc = status; 
		end

		line = file:read("*l");
		local result, inst = sscanf(line, "s");
		if result == 1 then
			if Player[id].areorc == 1 then
				SetPlayerInstance(id, inst);
				SendPlayerMessage(id, 255, 255, 255, "Установлен класс: "..inst);
			end
		end

		file:close();
	else
		_saveInst(id);
	end
end


----------------------------------------------------------------
function _saveZen(id)
	local file = io.open("Database/Players/Zens/"..Player[id].nickname..".txt", "w+");
	file:write(GetPlayerWorld(id).."\n");
	local x, y, z = GetPlayerPos(id);
	file:write(x.." "..y.." "..z);
	file:close();
end

function _readZen(id)
	local file = io.open("Database/Players/Zens/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, world = sscanf(line, "s");
		if result == 1 then
			SetPlayerWorld(id, world);
		end

		line = file:read("*l");
		local result, x, y, z = sscanf(line, "ddd");
		if result == 1 then
			SetPlayerPos(id, x, y, z);
		end

		file:close();
	else
		_saveZen(id);
	end
end

function SavePlayer(playerid)
	
	if IsNPC(playerid) == 0 then
		local fileWrite = io.open("Database/Players/Profiles/"..Player[playerid].nickname..".txt", "w+");

		local x, y, z = GetPlayerPos(playerid);
		Player[playerid].skin[1], Player[playerid].skin[2], Player[playerid].skin[3], Player[playerid].skin[4] = GetPlayerAdditionalVisual(playerid);


		fileWrite:write(Player[playerid].nickname.."\n");
		fileWrite:write(Player[playerid].password.."\n");
		fileWrite:write(Player[playerid].astatus.."\n"); -- уровень прав 
		fileWrite:write(Player[playerid].skin[1]," ",Player[playerid].skin[2]," ",Player[playerid].skin[3]," ",Player[playerid].skin[4].."\n"); -- внешность
		fileWrite:write(x.." "..y.." "..z.."\n"); -- координаты выхода
		fileWrite:write(Player[playerid].gold.."\n"); -- золото
		if Player[playerid].hpoints ~= nil then
			fileWrite:write(Player[playerid].hpoints.."\n"); -- очки сюжета
		else
			fileWrite("0\n");
		end
		fileWrite:write(Player[playerid].overlay.."\n"); -- походка
		fileWrite:write(GetPlayerVirtualWorld(playerid).."\n"); -- vw
		if Player[playerid].zvanie ~= nil then
			fileWrite:write(Player[playerid].zvanie.."\n");
		else
			fileWrite:write("NULL\n");
		end

		fileWrite:write(Player[playerid].colorf5[1].." "..Player[playerid].colorf5[2].." "..Player[playerid].colorf5[3].."\n")

		time = os.date('*t');
		local ryear = time.year;
		local rmonth = time.month;
		local rday = time.day; 
		local rhour = string.format("%02d", time.hour);
		local rminute = string.format("%02d", time.min);
		local txt = ""..rday.."."..rmonth.."."..ryear.."_"..rhour..":"..rminute;
		Player[playerid].lastplay_data = txt;

		fileWrite:write(tostring(Player[playerid].lastplay_data).."\n"); -- последняя игра
		fileWrite:write(Player[playerid].candiscord.." "..Player[playerid].discord.."\n");
		fileWrite:write(Player[playerid].rost.."\n");
		fileWrite:write("0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0");

		fileWrite:close();
		_saveZen(playerid);
	end
end

function ReadPlayer(playerid)

	local fileRead = io.open("Database/Players/Profiles/"..Player[playerid].nickname..".txt", "r+");
	if fileRead then
		tempvar = fileRead:read("*l"); -- nick
		local line, l = sscanf(tempvar, "s");
		if line == 1 then
			SetPlayerName(playerid, l);
		end
		tempvar = fileRead:read("*l"); -- password
		tempvar = fileRead:read("*l");
			local result, admin = sscanf(tempvar,"d");
			if result == 1 then
				Player[playerid].astatus = admin;
			end
		

		tempvar = fileRead:read("*l");
			local result, wyg_1, wyg_2, wyg_3, wyg_4 = sscanf(tempvar,"sdsd");
			if result == 1 then
				SetPlayerAdditionalVisual(playerid, wyg_1, wyg_2, wyg_3, wyg_4);
			end

		tempvar = fileRead:read("*l");
			local result, x, y, z = sscanf(tempvar,"ddd");
			if result == 1 then
				SetPlayerPos(playerid, x, y, z);
			end
		

		tempvar = fileRead:read("*l");
			local result, ore = sscanf(tempvar,"f");
			if result == 1 then
				Player[playerid].gold = ore;
			end
				

		tempvar = fileRead:read("*l");
			local result, level = sscanf(tempvar,"d");
			if result == 1 then
				Player[playerid].hpoints = level;
			end


		tempvar = fileRead:read("*l");
			local result, profID = sscanf(tempvar,"s");
			if result == 1 then
				SetPlayerWalk(playerid, profID);
				Player[playerid].overlay = profID;
			end

		tempvar = fileRead:read("*l");
			local result, profID = sscanf(tempvar,"d");
			if result == 1 then
				if profID == 100 then
					SetPlayerVirtualWorld(playerid, 0);
				else
					SetPlayerVirtualWorld(playerid, profID)
				end
			end

		tempvar = fileRead:read("*l");
			local result, profID = sscanf(tempvar,"s");
			if result == 1 then
				if profID ~= "NULL" then
					Player[playerid].zvanie = profID;
				else
					Player[playerid].zvanie = nil;
				end
			end


		tempvar = fileRead:read("*l");
			local result, c1, c2, c3 = sscanf(tempvar,"ddd");
			if result == 1 then
				Player[playerid].colorf5 = {c1, c2, c3};
				--SetPlayerColor(playerid, c1, c2, c3);
			end

		tempvar = fileRead:read("*l"); -- дата ласт игры
		tempvar = fileRead:read("*l");
		local result, can, text, c3 = sscanf(tempvar,"ds");
			if result == 1 then
				Player[playerid].candiscord = can;
				Player[playerid].discord = text;
			end

		tempvar = fileRead:read("*l");
			local result, c1 = sscanf(tempvar,"f");
			if result == 1 then
				if c1 < 0.85 then
					Player[playerid].rost = 1;
					SetPlayerScale(playerid, 1, 1, 1);
				else
					Player[playerid].rost = c1;
					SetPlayerScale(playerid, 1, 1, 1);
				end
			end

		_readEnergy(playerid);
		fileRead:close()
	end
	
end