function _updateOnlineForDiscord()
	

	local playercount = 0;
	local tempArrN = {}; local tempArrI = {}; local tempArrP = {}; local tempArrW = {}; local tempArrS = {};
	for i = 0, 100 do
		if IsNPC(i) == 0 and IsPlayerConnected(i) == 1 then
			table.insert(tempArrI, i);
			table.insert(tempArrN, GetPlayerName(i));

			local world = GetPlayerWorld(i);
			if string.find(world, "FULLWORLD") then
				table.insert(tempArrW, "Хоринис");

			elseif string.find(world, "NEWWORLD") then
				table.insert(tempArrW, "Хоринис (Г2)");

			elseif string.find(world, "OLDWORLD") then
				table.insert(tempArrW, "Колония (Г2)");

			elseif string.find(world, "KOLONIE") then
				table.insert(tempArrW, "Колония (Г1)");

			elseif string.find(world, "ADDONWORLD") then
				table.insert(tempArrW, "Яркендар");

			elseif string.find(world, "NEWWORLD") then
				table.insert(tempArrW, "Хоринис (старый)");
				
			elseif string.find(world, "SEWERS") then
				table.insert(tempArrW, "Канализация");

			else
				table.insert(tempArrW, "Неизвестно");
			end

			if Player[i].astatus == 1 then
				table.insert(tempArrP, "Ведущий сюжета");

			elseif Player[i].astatus == 2 then
				table.insert(tempArrP, "Лидер");

			elseif Player[i].astatus == 3 then
				table.insert(tempArrP, "Помощник");

			elseif Player[i].astatus == 4 then
				table.insert(tempArrP, "Игровой мастер");

			elseif Player[i].astatus == 5 then
				table.insert(tempArrP, "Координатор");

			elseif Player[i].astatus == 6 then
				table.insert(tempArrP, "Тех. администратор");

			else
				table.insert(tempArrP, "Игрок");
			end
			playercount = playercount + 1;
			
			if Player[i].loggedIn == true then
				table.insert(tempArrS, _playersInfo_timeInGame(i));
			else
				table.insert(tempArrS, "-----");
			end
			
		end
	end

	local file = io.open("localmysql_online.txt", "w");
	file:write(playercount);
	file:close();

	local file = io.open("localmysql.txt", "w");
	file:write("``                     Игроков онлайн: "..playercount.." (обновлено: ".._getRTime()..")                    ``\n")
	file:write("\n``# ID         |          NICKNAME          |          POST          |       WORLD       |  SESSION  #``\n");

	if table.getn(tempArrN) > 0 then
		for i = 1, table.getn(tempArrN) do

			if tempArrI[i] < 10 then
				file:write("``# "..tempArrI[i].."          | ");
				local lenlimit = 27 - string.len(tempArrN[i]);
				file:write(tempArrN[i]);
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("| "..tempArrP[i]);
				local lenlimit = 23 - tostring(string.len(tempArrP[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("| "..tempArrW[i]);
				local lenlimit = 18 - tostring(string.len(tempArrW[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("| "..tempArrS[i]);
				local lenlimit = 10 - tostring(string.len(tempArrS[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("#``\n");
			end

			if tempArrI[i] > 9 and tempArrI[i] < 100 then

				if tempArrI[i] == 9 then
					file:write("``# "..tempArrI[i].."       | ");
					local lenlimit = 27 - string.len(tempArrN[i]);
					file:write(tempArrN[i]);
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrP[i]);
					local lenlimit = 23 - tostring(string.len(tempArrP[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrW[i]);
					local lenlimit = 18 - tostring(string.len(tempArrW[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrS[i]);
					local lenlimit = 10 - tostring(string.len(tempArrS[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("#``\n");
				else
					file:write("``# "..tempArrI[i].."         | ");
					local lenlimit = 27 - string.len(tempArrN[i]);
					file:write(tempArrN[i]);
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrP[i]);
					local lenlimit = 23 - tostring(string.len(tempArrP[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrW[i]);
					local lenlimit = 18 - tostring(string.len(tempArrW[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("| "..tempArrS[i]);
					local lenlimit = 10 - tostring(string.len(tempArrS[i]));
					for i = 1, lenlimit do
						file:write(" ");
					end
					file:write("#``\n");
				end
			end

			if tempArrI[i] > 99 then
				file:write("``# "..tempArrI[i].."        | ");
				local lenlimit = 27 - string.len(tempArrN[i]);
				file:write(tempArrN[i]);
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("| "..tempArrP[i]);
				local lenlimit = 23 - tostring(string.len(tempArrP[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end
				file:write("| "..tempArrW[i]);
				local lenlimit = 18 - tostring(string.len(tempArrW[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end
				local lenlimit = 10 - tostring(string.len(tempArrS[i]));
				for i = 1, lenlimit do
					file:write(" ");
				end

				file:write("#``\n");
			end

		end
		file:close();
	else
		file:write("``# ------------------------------------------------------------------------------------------------ #``\n")
		file:write("``#                                    Игроков в сети не найдено.                                    #``\n")
		file:write("``# ------------------------------------------------------------------------------------------------ #``")
		file:close();
	end

end
SetTimer(_updateOnlineForDiscord, 60000, 1);