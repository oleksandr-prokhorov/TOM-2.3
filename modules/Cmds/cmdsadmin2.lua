
-- ������������ �������� ��� ��... ��� ��� �������� � ���?..

function GetAdminsOnline(pid) 
	
end

function GetAdminLevel(pid)
	local lvl;
		if Player[pid].astatus == 1 then
			lvl = "������� ������"
		elseif Player[pid].astatus == 2 then
			lvl = "�����"
		elseif Player[pid].astatus == 3 then
			lvl = "�������� �������"
		elseif Player[pid].astatus == 4 then	
			lvl = "������� ������"
		elseif Player[pid].astatus == 5 then	
			lvl = "�����������"
		elseif Player[pid].astatus == 6 then	
			lvl = "�.�"
		end
	return lvl;
end

function _SetAdmin(id, sets)

	if Player[id].astatus > 4 then
		local cmd, pid, level = sscanf(sets, "dd");
		if cmd == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then

				if level == 1 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� �������� ������ ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '�������� ������'");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 2 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� ������ ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '������'");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 3 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� ��������� ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {125, 255, 122}
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '��������'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 4 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� ������� ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {110, 124, 255}
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '�������'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 5 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� ������������ ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {189, 189, 189}
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '�����������'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 6 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ����� ����� ���. �������������� ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {147, 31, 255}
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ������������� ����� '�.�'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 0 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." ���� ���. ����� � ������ "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {255, 255, 255}
					SendPlayerMessage(pid, 255, 255, 255, "� ��� ���� ����� ������� �����.");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." ��� ����� "..level.." ������ ������ "..Player[pid].nickname.." / ".._getRTime());
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �������������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (��) (�������)")
			SendPlayerMessage(id, 255, 255, 255, "1 - ������� ������, 2 - �����, 3 - ��������, 4 - ������, 5 - �����������, 6 - �.�")
		end
	end

end
addCommandHandler({"/�����"}, _SetAdmin);

local pm_sound = CreateSound("OWL_03.WAV");
function CMD_REPORT(playerid,params)
	local result,message = sscanf(params,"s");
	if result == 1 then

		--[[local status = false;
		local text_find = string.lower(message);

		if Player[playerid].astatus < 1 then
			for _, v in pairs(bad_words_heal) do
				local find = string.find(text_find, v);
				if find then
					SendPlayerMessage(playerid, 255, 255, 255, "������ ������� �� � ������ � �������������.")
					Player[playerid].warns = Player[playerid].warns + 1;
					SendPlayerMessage(playerid, 255, 255, 255, "��� ������ �������������� �� �������: ������� ������� �2.2");
					SendPlayerMessage(playerid, 255, 255, 255, "��� ���������� 3� �������������� �� ������ ��������. ������� ���-��: "..Player[playerid].warns);
					_saveWarn(playerid);

					if _getWarns(playerid) == 3 then
						Player[playerid].warns = 0;
						_saveWarn(playerid);
						Ban(playerid);
					end

					status = true;
					break
				end
			end
		end

		if status == false then]]
			SendPlayerMessage(playerid,255,68,0,"(REPORT): "..Player[playerid].nickname..": "..message);
			GameTextForPlayer(playerid, 3000, 3500, "��������� ����������!","Font_Old_20_White_Hi.TGA", 255, 154, 0, 2400);
			LogString("Logs/PlayersAll/Reports","(REPORT) "..Player[playerid].nickname..": "..message);
	

			for i = 0, GetMaxPlayers() do
				if IsPlayerConnected(i) == 1 then
					if Player[i].astatus > 2 then
						PlayPlayerSound(i, pm_sound);
						SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." (ID:"..playerid.."): "..message);
					end
				end
			end
		--end

	else
		SendPlayerMessage(playerid, 255, 255, 255 ,"/������ (�����).");
	end
end
addCommandHandler({"/������","/report"}, CMD_REPORT)

function CMD_ASKREPORT(playerid,params)
	local result,id,text = sscanf(params,"ds");
	if Player[playerid].astatus > 2 then
		if result == 1 then
			if IsPlayerConnected(id) == 1 then
				SendPlayerMessage(id,255,68,0,GetAdminLevel(playerid).." "..Player[playerid].nickname..": "..text);
				SendPlayerMessage(playerid,255,68,0,"�� �������� ������ "..Player[id].nickname..": "..text);
				for i = 0, GetMaxPlayers() do
					if IsPlayerConnected(i) == 1 then
						if Player[i].astatus > 2 then
							if i ~= playerid then
								SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." �������� "..Player[id].nickname.." (ID:"..id.."): "..text);
							end
						end
					end
				end
				LogString("Logs/Admins/report_answer",GetAdminLevel(playerid).." "..Player[playerid].nickname.." ������� ������ "..Player[id].nickname..": "..text);
			else
				SendPlayerMessage(playerid,255,0,0,"������ � ����� ID ��� �� �������.");
			end
		else
			SendPlayerMessage(playerid,255,0,0,"������! ��������� /����� (ID ������) (�����).");
		end
	else
		GameTextForPlayer(playerid, 50, 6000, "(SERVER): ������������ ����!","Font_Old_10_White_Hi.TGA", 230, 50, 50, 3000);
	end
end
addCommandHandler({"/�����","/ask"}, CMD_ASKREPORT)
