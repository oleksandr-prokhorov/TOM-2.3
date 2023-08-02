
--  #   Mac system by royclapton  #
--  #         version: 1.0        #



function _saveMacNew(id)

	--local file = io.open("Database/Players/Macs/"..GetMacAddress(id),"a+");
	--file:write(GetMacAddress(id).." "..GetPlayerName(id).."\n");
	--file:close();

end


function _checkMacNew(id)

	--[[local file = io.open("Database/Players/Macs/"..GetMacAddress(id), "r");
	if file then
		local status = true;
		local countLines = 0;
		for line in file:lines() do
			countLines = countLines + 1;
			local check, mac, name = sscanf(line, "ss");
			if check == 1 then
				if GetPlayerName(id) == name then
					status = false;
				end
			end
			if status == true then
				if countLines > 2 then
					SendPlayerMessage(id, 255, 255, 255, "��������� ����� ��������� ��� ����������� ��������� (3 ��������).")
					Kick(id);
					break
				end
			end
		end
		file:close();
	end]]

end


function _checkNickname(id)

	--[[local playerMac = GetMacAddress(id);
	local playerName = GetPlayerName(id);
	local profile = io.open("Database/Players/Info/"..playerName..".txt", "r");
	if profile then
		line = profile:read("*l");
		local l, str1, str2, str3, str4, str5, str6, str7, str8, str9, str10 = sscanf(line, "sssssssssss");
		if l == 1 then
			
			if str7 ~= "/" and str7 ~= "Date" and str7 ~= "MAC:" then
				if playerMac == str7 then
					profile:close();
				else
					SendPlayerMessage(id, 255, 0, 0, "�� ���� ������� ��������������� MAC: "..str7);
					SendPlayerMessage(id, 255, 0, 0, "������� MAC: "..playerMac);
					Kick(id);
					profile:close();
				end
			
			elseif str8 ~= "/" and str8 ~= "Date" and str8 ~= "MAC:" then
				if playerMac == str8 then
					profile:close();
				else
					SendPlayerMessage(id, 255, 0, 0, "�� ���� ������� ��������������� MAC: "..str8);
					SendPlayerMessage(id, 255, 0, 0, "������� MAC: "..playerMac);
					Kick(id);
					profile:close();
				end
				
			elseif str9 ~= "/" and str9 ~= "Date" and str9 ~= "MAC:" then
				if playerMac == str9 then
					profile:close();
				else
					SendPlayerMessage(id, 255, 0, 0, "�� ���� ������� ��������������� MAC: "..str9);
					SendPlayerMessage(id, 255, 0, 0, "������� MAC: "..playerMac);
					Kick(id);
					profile:close();
				end
			end
		end
	end]]
	
end




-------------------------- old

FORUM_MACS = {}

function _saveMac(id)
	
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id),"w+");
	file:write(GetPlayerName(id));
	file:close();

end

function _checkMac(id)
	
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id), "r");
	local trueNick;
	if file then
		line = file:read("*l");
		local result, nick = sscanf(line, "s");
		if result == 1 then
			trueNick = nick;
			if trueNick ~= GetPlayerName(id) then
				ClearChat(id)
				SendPlayerMessage(id, 255, 173, 173, "��������� �����. � ����� ������������ ���� �� ������� ���������� ��������...")
				SendPlayerMessage(id, 255, 173, 173, "...���� ������� = ���� ���������.");
				SendPlayerMessage(id, 255, 173, 173, "��� ����������� ���� ������� ������� ��������, ������� ���������������.");
				SendPlayerMessage(id, 248, 252, 179, "�� MAC: "..GetMacAddress(id).." ��������������� �������: "..trueNick);
				SendPlayerMessage(id, 248, 252, 179, "������� �������: "..GetPlayerName(id));
				Kick(id);
			end
		end
		file:close();
	end
	
end

function _checkForumMacs(id)

	for i, v in pairs(FORUM_MACS) do
		if GetPlayerName(id) == v then
			table.remove(FORUM_MACS, i);
			_saveMac(id);
			_updateMacForum();
			break
		end
	end

end

function _updateMacForum()

	local file = io.open("Database/Players/Macs/forum_list.txt", "w");
	if file then
		if table.getn(FORUM_MACS) > 0 then
			for i = 1, table.getn(FORUM_MACS) do
				file:write(FORUM_MACS[i].."\n");
			end
		else
			os.remove("Database/Players/Macs/forum_list.txt");
			print(" ");
			print(" ");
			print("All forums accs register");
			print(" ");
			print(" ");
		end
	end

end

function _macForumInit()

	local file = io.open("Database/Players/Macs/forum_list.txt", "r");
	if file then
		for line in file:lines() do
			local result, name = sscanf(line, "s");
			if result == 1 then
				table.insert(FORUM_MACS, name);
			end
		end
		file:close();
	end

end
