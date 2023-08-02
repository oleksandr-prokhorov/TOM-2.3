
--  # Thief system by royclapton #
--  #       version: 0.1         #


function _doSteal(id, sets)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local date = rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear;
	
	if Player[id].loggedIn == true then
		local cmd, pid = sscanf(sets, "d");
		if cmd == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
				if IsNPC(pid) == 0 then


					local items = getPlayerItems(pid); local drop_item = nil;
					if items then
						for i in pairs(items) do
							local find = string.find(items[i].instance, "ITFO");
							if find then
								drop_item = items[i].instance;
							end
						end
					end

					math.randomseed(os.time());
					local dex_p1 = GetPlayerDexterity(id); local dex_p2 = GetPlayerDexterity(pid);

					if dex_p1 > dex_p2 then
						local min = dex_p1 - dex_p2;
						if min > 25 then
							if drop_item ~= nil then
								SendPlayerMessage(id, 182, 240, 67, "�� ��������� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..GetItemName(drop_item));
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: "..GetItemName(drop_item).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "�� ��������� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..rnd.." ����.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: "..rnd.." ���� / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "� ������ ������ ���.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: 0 ���� / "..date);
								end
							end

						elseif min > 10 and min < 25 then

							if drop_item ~= nil then
								SendPlayerMessage(id, 182, 240, 67, "�� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..GetItemName(drop_item));
								SendPlayerMessage(id, 182, 240, 67, "�������� ����� ��������� � �����!")
								SendPlayerMessage(pid, 182, 240, 67, "(����������): � ���� ��������� ���-�� ����������.");
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." ����� �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: "..GetItemName(drop_item).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "�� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..rnd.." ����.");
									SendPlayerMessage(id, 182, 240, 67, "�������� ����� ��������� � �����!");
									SendPlayerMessage(pid, 182, 240, 67, "(����������): � ���� ��������� ���-�� ����������.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." ����� �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: "..rnd.." ���� / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "� ������ ������ ���.");
									SendPlayerMessage(id, 182, 240, 67, "�������� ����� ��������� � ������� �����!");
									SendPlayerMessage(pid, 182, 240, 67, "(����������): � ���� ��������� ���-�� ����������.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." ����� �������� ������� ������ "..GetPlayerName(pid).." � ����� � ����: 0 ���� / "..date);
								end
							end

						elseif min <= 10 then

							if drop_item ~= nil then
								SendPlayerMessage(id, 182, 240, 67, "�� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..GetItemName(drop_item));
								SendPlayerMessage(id, 182, 240, 67, "����� ������� ���� �����.")
								SendPlayerMessage(pid, 182, 240, 67, "(����������): ����� "..GetPlayerName(id).." ����� � ��� "..GetItemName(drop_item));
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �� ���� ��������� ������ "..GetPlayerName(pid).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "�� �������� ������ "..GetPlayerName(pid).." � ������ � ����: "..rnd.." ����.");
									SendPlayerMessage(id, 182, 240, 67, "�������� ����� ��������� � �����!");
									SendPlayerMessage(pid, 182, 240, 67, "(����������): ����� "..GetPlayerName(id).." ����� � ��� "..rnd.." ����.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �� ���� ��������� ������ "..GetPlayerName(pid).." / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "� ������ ������ ���.");
									SendPlayerMessage(id, 182, 240, 67, "����� ��������� � ������� �����!");
									SendPlayerMessage(pid, 182, 240, 67, "(����������): "..GetPlayerName(id).." ��������� ���������� ��� ��������");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �� ���� ��������� ������ "..GetPlayerName(pid).." / "..date);
								end
							end
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ������ ������� � ��� ����������.")
						SendPlayerMessage(pid, 255, 255, 255, "�� ������� ����� ���� � ����� �������, �� �������� - "..GetPlayerName(id));
						LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." �� ���� ��������� ������ (�������) "..GetPlayerName(pid).." / "..date);
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "��� ���.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� �� ������.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/��� (��)");
		end
	end
end
--addCommandHandler({"/���"}, _doSteal);