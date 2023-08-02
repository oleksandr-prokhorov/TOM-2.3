
--  # AC for save-items (files) by royclapton #
--  #              version: 0.1               #
--  #                  lite                   #


function _ac_connect(id)

	Player[id]._ac_gameItems = {};
	for i = 1, 2 do
		Player[id]._ac_gameItems[i] = {};
	end

	Player[id]._ac_baseItems = {};
	for i = 1, 2 do
		Player[id]._ac_baseItems[i] = {};
	end

	Player[id]._ac_checkerItems = false;
	Player[id]._ac_currentItemsCount = 0;

end

function _ac_checkIBase(id, item)

	item = string.upper(item);
	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	for line in file:lines() do
		local result, code, value = sscanf(line, "sd");
		if result == 1 then
			if code == item then
				file:close();
				return true;
			end
		end
	end
	file:close();
	return false;

end

function _ac_openInventory(id)
	
	if Player[id].hero_use[1] == false then
		
		if Player[id].loggedIn == true then

			local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
			if file then
				for line in file:lines() do
					local result, code, value = sscanf(line, "sd");
					if result == 1 then
						table.insert(Player[id]._ac_baseItems[1], code);
						table.insert(Player[id]._ac_baseItems[2], value);
					end
				end
				file:close();

				for i = 0, 100 do
					Player[id]._ac_checkerItems = true;
					GetPlayerItem(id, i);
				end
			end
		end

	end

end


function _ac_Response(id, slot, itemInstance, amount, equipped)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	if Player[id].loggedIn == true then
		if Player[id]._ac_checkerItems == true then
			if itemInstance ~= "NULL" then
				if itemInstance ~= "JKZTZD_ITRW_ARROW" then
					if itemInstance ~= "JKZTZD_ITRW_BOLT" then
						if itemInstance ~= "JKZTZD_ITMW_2H_AXE_L_01" then
							if itemInstance ~= "OOLTYB_ITMI_SAW" then
								if itemInstance ~= "OOLTYB_ITMI_FISHING" then
									if itemInstance ~= "OOLTYB_ITMI_BRUSH" then
										if itemInstance ~= "OOLTYB_ITMI_BROOM" then
											if itemInstance ~= "OOLTYB_ITMI_LUTE" then

												-- AMOUNT
												local items = getPlayerItems(id);
												if items then
													for i in pairs(items) do
														if items[i].instance == itemInstance then
															if items[i].amount < amount then
																if Player[id].astatus == 0 then
																	if GetPlayerInstance(id) ~= "PC_HERO" then
																		LogString("Logs/AC/ac_items", Player[id].nickname.." ���� � ��������� "..amount.." "..GetItemName(itemInstance)..", � � ��: "..items[i].amount.." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
																		SendPlayerMessage(id, 255, 255, 255, "���������� ������������ � ����������! �������: "..itemInstance.." ���-�� � ��: "..items[i].amount..", � ����: "..amount);
																		SendPlayerMessage(id, 255, 255, 255, "�� �������� �� ��������� ��������.")
																		for i = 0, GetMaxPlayers() do
																			SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." ������� �� ������������� ����� (�������� ���������� � ���������).");
																		end
																		Ban(id);
																	end
																end
																break
															end
														end
													end
												end

												-- ITEM
												local checkerItem = _ac_checkIBase(id, itemInstance);
												if checkerItem == false then
													if Player[id].astatus < 1 then
														if GetPlayerInstance(id) ~= "PC_HERO" then
															LogString("Logs/AC/ac_items", Player[id].nickname.." ���� � ��������� �������. �������: "..GetItemName(itemInstance).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
															SendPlayerMessage(id, 255, 255, 255, "��������� �������������������� �������: "..itemInstance);
															SendPlayerMessage(id, 255, 255, 255, "�� �������� �� ��������� ��������.")
															for i = 0, GetMaxPlayers() do
																SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." ������� �� ������������� ����� (��������� ���������).");
															end
															Ban(id);
														end
													end
												end
												Player[id]._ac_checkerItems = false;
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

end


--[[

local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
		for line in file:lines() do
			local result, code, value = sscanf(line, "sd");
			if result == 1 then
				table.insert(Player[id]._ac_baseItems[1], code);
				table.insert(Player[id]._ac_baseItems[2], value);
			end
		end
		file:close();

		if table.getn(Player[id]._ac_baseItems[1]) > 0 then
			Player[id]._ac_currentItemsCount = table.getn(Player[id]._ac_baseItems[1]);
		else
			Player[id]._ac_currentItemsCount = 0;
			for i = 1, 2 do
				Player[id]._ac_baseItems[i] = {};
			end
		end

		Player[id]._ac_checkerItems = true;
		for i = 1, 2 do
			Player[id]._ac_baseItems[i] = {};
		end

		for i = 0, 100 do
			GetPlayerItem(id, i);
		end
		print("----------------------")
		print("----------------------")

		if table.getn(Player[id]._ac_gameItems[1]) > 0 then

			local bI = 1; local pos = 1;
			while pos < table.getn(Player[id]._ac_gameItems[1]) do
				for i = 1, table.getn(Player[id]._ac_gameItems[1]) do
					if Player[id]._ac_gameItems[1][i] == Player[id]._ac_baseItems[1][bI] then
						if Player[id]._ac_gameItems[2][i] == Player[id]._ac_baseItems[1][i] then
							bI = bI + 1;
							pos = pos + 1;
						else
							print("KICK KICK KICK");
						end
					end
				end
			end
		end

]]