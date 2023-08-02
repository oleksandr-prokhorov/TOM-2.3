
--  #    CraftLog by royclapton   #
--  #         version: 0.1        #


local craftlogtex = CreateTexture(786, 449, 7316, 6849, 'menu_ingame')
function _logVar(id)

	-- � OnPlayerConnect;
	Player[id].cl_openlogcraft = false;
	Player[id].cl_name = nil;
	Player[id].cl_draws = {};

end

function _checkLogCraft(id, pid)

	if Player[id].astatus > 3 then
		local result, player = sscanf(pid, "d");
		if result == 1 then
			if IsNPC(player) == 0 then
				if Player[player].loggedIn == true then


					if Player[id].cl_openlogcraft == false then
						Player[id].cl_openlogcraft = true;
						ShowTexture(id, craftlogtex);
						Player[id].cl_name = GetPlayerName(player);
						ShowChat(id, 0);

						Player[id].cl_draws = {};
						for i = 1, 30 do
							Player[id].cl_draws[i] = CreatePlayerDraw(id, 0, 0, "");
						end


						local tempArr = {};
						local file = io.open("craft_logs.txt", "r");
						if file then
							for line in file:lines() do
								local l = string.find(line, Player[id].cl_name); -- ���� ������� � ����� � ����� ������.
								if l then -- ���� ������� �������..
									table.insert(tempArr, line); -- .. ��������� �� � ������.
								end
							end
							file:close();
						else
							SendPlayerMessage(id, 255, 255, 255, "���� 'craft_logs.txt' ��������� ��� �� ������. ������������..");
							local dfile = io.open("craft_logs.txt", "w");
							dfile:close();
						end

						if table.getn(tempArr) > 0 then -- ���� ���-�� �������, �� ���������� �����.

							local dy = 830;

							if table.getn(tempArr) <= 30 then
								for i = 1, table.getn(tempArr) do
									UpdatePlayerDraw(id, Player[id].cl_draws[i], 1110, dy, tempArr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
									ShowPlayerDraw(id, Player[id].cl_draws[i]);
									dy = dy + 200;
								end

							else
								local c = 1;
						  		for i = table.getn(tempArr), 1, -1 do
						  			if c == 30 then
						  				break
						  			else
						  				c = c + 1;
						  				UpdatePlayerDraw(id, Player[id].cl_draws[c], 1110, dy, tempArr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
										ShowPlayerDraw(id, Player[id].cl_draws[c]);
										dy = dy + 200;
						  			end
						  		end
							end

						else
							SendPlayerMessage(id, 255, 255, 255, "������ ������ "..Player[id].cl_name.." �� �������.");
							HideTexture(id, craftlogtex);
							_logVar(id);
							ShowChat(id, 1);
						end

						--[[
						������� �2: (������)

						local file = io.open("craft_logs.txt", "r");
						if file then
							for line in file:lines() do -- ���������� ��� ������ �� ����� � ������.
								table.insert(tempArr, line);
							end
							file:close();

						else
							SendPlayerMessage(id, 255, 255, 255, "���� 'craft_logs.txt' ��������� ��� �� ������. ������������..");
							local dfile = io.open("craft_logs.txt", "w");
							dfile:close();
						end

						for i, v in pairs(tempArr) do
							local kline = string.find(v, Player[id].cl_name); -- ���� � ������� �������, � ������� ���� ��� ������.
							if kline then -- ���� ����� ������ �������..
								table.remove(tempArr, i); -- .. ������� �� �� �������.
							end
						end


						-- ������� �3: (������)
						local file = io.open("craft_logs.txt", "r");
						if file then
							for line in file:lines() do
								local l = string.find(line, Player[id].cl_name); -- ���� ������� � ����� � ����� ������.
								if l then -- ���� ������� �������..
									table.insert(tempArr, line); -- .. ��������� �� � ������.
								end
							end
							file:close();
						else
							SendPlayerMessage(id, 255, 255, 255, "���� 'craft_logs.txt' ��������� ��� �� ������. ������������..");
							local dfile = io.open("craft_logs.txt", "w");
							dfile:close();
						end

						if table.getn(tempArr) > 0 then -- ���� ���-�� �������, �� ���������� �����.

							local dy = 830;

							for i = 1, table.getn(tempArr) do
								Player[id].cl_draws[i] = CreatePlayerDraw(id, 1110, dy, tempArr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
								ShowPlayerDraw(id, Player[id].cl_draws[i]);
								dy = dy + 200;
							end

						else
							SendPlayerMessage(id, 255, 255, 255, "������ ������ "..Player[id].cl_name.." �� �������.");
							HideTexture(id, craftlogtex);
							_logVar(id);
							ShowChat(id, 1);
						end]]

					end
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� �������������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "��� ���.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���_����� (��)");
		end
	end

end
addCommandHandler({"/���_�����", "/log_craft"}, _checkLogCraft);

function _logCraftKey(id, down, up)

	-- � OnPlayerKey:

	if down == KEY_ESCAPE then
		if Player[id].cl_openlogcraft == true then

			for i = 1, table.getn(Player[id].cl_draws) do
				HidePlayerDraw(id, Player[id].cl_draws[i]);
				DestroyPlayerDraw(id, Player[id].cl_draws[i]);
			end

			HideTexture(id, craftlogtex);
			_logVar(id);

			ShowChat(id, 1);
		end
	end

end


function _logCraft(id, instance, amount)

	-- � ProceedCraft:
	-- _logCraft(id, instance, CraftItem[instance].amount);

	local time = os.date('*t');
  	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local txt = "["..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."] "..GetPlayerName(id).." ��������� "..GetItemName(instance).." (x"..amount..")";
	local file = io.open("craft_logs.txt", "a+");
	file:write(txt.."\n");
	file:close();

end