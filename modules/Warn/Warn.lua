
--  #  Warn system by royclapton  #
--  #         version: 1.0        #


function _getWarns(id)
	return Player[id].warns;
end

function _newWarn(id, sets)
	
	if Player[id].astatus > 0 then
		local result, pid, reason = sscanf(sets, "ds");
		if result == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then

				Player[pid].warns = Player[pid].warns + 1;
				LogString("Logs/Admins/Warn",Player[id].nickname.." ����� ���� ������ "..Player[pid].nickname.." �� �������: "..reason.." ("..Player[pid].warns.."/3) / ".._getRTime());
				if Player[pid].warns < 3 then
					SendPlayerMessage(pid, 255, 255, 255, "������������� "..Player[id].nickname.." ����� ��� �������������� �� ������� "..reason);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� 3� �������������� �� ������ ��������. ������� ���-��: "..Player[pid].warns);
					_saveWarn(pid);

					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 0 then
							SendPlayerMessage(i, 255, 255, 255, "������������� "..Player[id].nickname.." ����� �������������� "..Player[pid].nickname.." �� ������� "..reason);
						end
					end

				elseif Player[pid].warns > 2 then
					LogString("Logs/Admins/Warn",Player[id].nickname.." ������� ������ ������ "..Player[pid].nickname.." �� �������: "..reason.." ("..Player[pid].warns.."/3) / ".._getRTime());
					SendPlayerMessage(pid, 255, 255, 255, "������������� "..Player[id].nickname.." ����� ��� �������������� �� ������� "..reason);
					SendPlayerMessage(pid, 255, 255, 255, "�� �������� �� �������. ������� ���-�� ��������������: "..Player[pid].warns);
					Player[pid].warns = 0;
					_saveWarn(pid);

					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 0 then
							SendPlayerMessage(i, 255, 255, 255, "������������� "..Player[id].nickname.." ����� �������������� "..Player[pid].nickname.." �� ������� "..reason);
						end
					end
		
					Ban(pid);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ����������� ��� �� ������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (��) (�������)")
		end
	end

end
addCommandHandler({"/����", "/warn"}, _newWarn);

function _saveWarn(id)

	local file = io.open("Database/Players/Warns/"..Player[id].nickname..".txt", "w");
	file:write(Player[id].warns);
	file:close();

end

function _readWarn(id);

	local file = io.open("Database/Players/Warns/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, n = sscanf(line, "d");
		if result == 1 then
			Player[id].warns = n;
		end

		file:close();

	else
		_saveWarn(id);
	end

end