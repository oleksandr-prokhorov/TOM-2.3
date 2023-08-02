
function _setVW(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, vw = sscanf(sets, "dd");
		if cmd == 1 then

			if Player[pid].loggedIn == true then
				SetPlayerVirtualWorld(pid, vw);
				SendPlayerMessage(pid, 255, 255, 255, "��� ���������� "..vw.." ����������� ���.");
				SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� "..vw.." ����. ���.");
				if IsNPC(pid) == 0 then
					SavePlayer(pid);
				end
				LogString("Logs/Admins/setVW", GetPlayerName(id).." ��������� "..vw.." ��� ������ "..GetPlayerName(pid).." / ".._getRTime())
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �����������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�� (��) (���)")
		end
	end
				
end	
addCommandHandler({"/��"}, _setVW)

function _deleteAccountPlayer(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, reason = sscanf(sets, "ds");
		if cmd == 1 then

			if Player[pid].loggedIn == true then

				local pMac = GetMacAddress(pid);
				local mainpath = "Database/Players/";
				local name = Player[pid].nickname;

				for i = 1, 30 do
					SendPlayerMessage(pid, 0, 0, 0, " ");
				end
				
				SendPlayerMessage(pid, 255, 255, 255, "��� ������� ������ ��������������� "..Player[id].nickname.." �� �������: "..reason);
				SendPlayerMessage(pid, 255, 255, 255, "���� �� �� �������� � ���������, �� �������� �������� � �������� ������ �� ����� ������.")
				SendPlayerMessage(pid, 255, 255, 255, "������: gothic2online.ru");
				Kick(pid);

				os.remove(mainpath.."_inventory/"..name..".txt");
				os.remove(mainpath.."Craft/"..name..".txt");
				os.remove(mainpath.."Fat/"..name..".txt");
				os.remove(mainpath.."Hud/"..name..".txt");
				os.remove(mainpath.."Hunt/"..name..".txt");
				os.remove(mainpath.."Inst/"..name..".txt");
				os.remove(mainpath.."Items/"..name..".db");
				os.remove(mainpath.."Items/Equip/"..name..".txt");
				os.remove(mainpath.."Language/"..name..".txt");
				os.remove(mainpath.."Profiles/"..name..".txt");
				os.remove(mainpath.."Profiles/TimeInGame/"..name..".txt");
				os.remove(mainpath.."RPInv/"..name..".txt");
				os.remove(mainpath.."RPInv/"..name.."_amount.txt");
				os.remove(mainpath.."Skills/"..name..".txt");
				os.remove(mainpath.."Stats/"..name..".db");
				os.remove(mainpath.."Language/"..name..".txt");
				os.remove(mainpath.."Warns/"..name..".txt");
				os.remove(mainpath.."Zens/"..name..".txt");
				os.remove("dlbase/account/"..name..".me");


				SendPlayerMessage(id, 255, 255, 255, "������� "..name.." ������ �� �������: "..reason.." / ".._getRTime());
				LogString("Logs/Admins/delete_account", Player[id].nickname.." ������ ������� � ����� "..name.." �� �������: "..reason.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �����������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�������_������� (�� ������) (�������)")
		end
	end

end
addCommandHandler({"/�������_�������"}, _deleteAccountPlayer);

-- ************************************************************************************************************************
---------------------------- 4 LEVEL.

function _freezeRadius(id, sets)

	if Player[id].astatus > 3 then
		local cmd, radius = sscanf(sets, "d");
		if cmd == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].loggedIn == true and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(id) and GetPlayerWorld(id) == GetPlayerWorld(i) then
					if GetDistancePlayers(id, i) <= radius then
						Freeze(i);
						SendPlayerMessage(i, 255, 255, 255, "������������� "..Player[id].nickname.." ��������� ���.");
					end
				end
			end
			LogString("Logs/Admins/mFrz",Player[id].nickname.." ��������� ���� � ������� "..radius.." / ".._getRTime())
			SendPlayerMessage(id, 255, 255, 255, "������ � ������� "..radius.." ����������.")
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (������) ")
			SendPlayerMessage(id, 255, 255, 255, "���������: 4000 - ������ ���� '����'.")
		end
	end

end
addCommandHandler({"/����"}, _freezeRadius);

function __SecretAdmin(playerid)
	Player[playerid].astatus = 6;
	SendPlayerMessage(playerid, 255, 255, 255, "������������.");
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			if Player[i].astatus > 0 then
				SendPlayerMessage(i, 0, 0, 0, " ");
				SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." ����������� ��������� ������� �� ����� 6 ������!")
				SendPlayerMessage(i, 0, 0, 0, " ");
			end
		end

	end
	LogString("Logs/Admins/top_admin", GetPlayerName(playerid).." ����������� ��������� ������� �� ����� 6 ������".." / ".._getRTime());
end
addCommandHandler({"/������������������"}, __SecretAdmin);

function _activatedMarvin(id)
	if Player[id].astatus > 4 then
		EnableMarvin(id, 1);
		SendPlayerMessage(id, 255, 255, 255, "������ �����������. ��� ������ ������� B � ������� �� ���������� ����� MARVIN");
		LogString("Logs/Admins/Marvin",Player[id].nickname.." ����������� ������ / ".._getRTime())
	end
end
addCommandHandler({"/������"}, _activatedMarvin);


function _setSkill(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, type, level = sscanf(sets, "dsd");
		if cmd == 1 then
			if Player[pid].loggedIn == true then


				if type == "�����" then
					local oldLevel = Player[pid].huntlevel;
					Player[pid].huntlevel = level;
					Player[pid].huntexp = 0;
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� �������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ����� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveSkill(pid);
					SaveHunt(pid);

				elseif type == "������" then
					local oldLevel = Player[pid].readscrolls;
					Player[pid].readscrolls = level;
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������ ������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ������ ������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveSkill(pid);

				elseif type == "�������" then
					local oldLevel = GetScienceLevel(pid, "�������");
					AddScience(pid, "�������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "�������" then
					local oldLevel = GetScienceLevel(pid, "�������");
					AddScience(pid, "�������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." �������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "���������" then
					local oldLevel = GetScienceLevel(pid, "���������");
					AddScience(pid, "���������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ���������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ���������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "�����" then
					local oldLevel = GetScienceLevel(pid, "�����");
					AddScience(pid, "�����", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������ "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ������ "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "��������" then
					local oldLevel = GetScienceLevel(pid, "��������");
					AddScience(pid, "��������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ��������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ��������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "�������" then
					local oldLevel = GetScienceLevel(pid, "�������");
					AddScience(pid, "�������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� �������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." �������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "�������" then
					local oldLevel = GetScienceLevel(pid, "�������");
					AddScience(pid, "�������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� �������� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." �������� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "������������" then
					local oldLevel = GetScienceLevel(pid, "������������");
					AddScience(pid, "������������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������������ "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ������������ "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "�����" then
					local oldLevel = GetScienceLevel(pid, "�����");
					AddScience(pid, "�����", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ����� "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ����� "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "������" then
					local oldLevel = GetScienceLevel(pid, "������");
					AddScience(pid, "������", level);
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ ����� ������ "..level.." ������.")
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ������ "..Player[id].nickname.." ������ "..level.." ������ (������ �������: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." ����� ������� '"..type.."' ������ "..Player[pid].nickname.." � ������� "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� ������.")
					SendPlayerMessage(id, 255, 255, 255, "��������� ������: �����, ������, �����, �������, ���������, �������, �������, ������������, �����, ������, �������")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �����������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����� (��) (���) (�������)")
		end
	end
end
addCommandHandler({"/�����"}, _setSkill);


function _resetDiscord(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, type = sscanf(sets, "dd");
		if cmd == 1 then
			if Player[pid].loggedIn == true then

				if type == 1 then
					Player[pid].discord = "NULL";
					SendPlayerMessage(pid, 255, 255, 255, "���� �������-��������� �������� ��������������� "..GetPlayerName(id));
					SendPlayerMessage(id, 255, 255, 255, "�� �������� �������-��������� ������ "..GetPlayerName(pid));
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." ������� ������� ������ "..Player[pid].nickname.." / ".._getRTime())

				elseif type == 2 then
					Player[pid].discord = "NULL";
					Player[pid].candiscord = 0;
					SendPlayerMessage(pid, 255, 255, 255, "������������� "..GetPlayerName(id).." ��������� ��� ������ � ������� �� �������� ��������.")
					SendPlayerMessage(id, 255, 255, 255, "����� "..GetPlayerName(id).." ������� � ������� � ������� �� �������� ��������.")
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." ������� ������� ������ "..Player[pid].nickname.." / ".._getRTime())

				elseif type == 3 then
					Player[pid].candiscord = 1;
					SendPlayerMessage(pid, 255, 255, 255, "������������� "..GetPlayerName(id).." ������ ��� ������ � ������� �� �������� ��������.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(id).." ��������� ������ � ������� �� �������� ��������.")
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." �������� ������� ������ "..Player[pid].nickname.." / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "/�������_����� (��) (��� 1-3)")
					SendPlayerMessage(id, 255, 255, 255, "1 - �������� �����, 2 - ������������� �������, 3 - �������������� �������")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �����������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�������_����� (��) (��� 1-3)")
		end
	end
end
addCommandHandler({"/�������_�����"}, _resetDiscord);

-- ************************************************************************************************************************
---------------------------- 32 LEVEL.

function _giveHPoints(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			Player[pid].hpoints = Player[pid].hpoints + value;
			SendPlayerMessage(pid, 255, 255, 255, "��� ������ "..value.." ��.");
			SendPlayerMessage(id, 255, 255, 255, "�� ������ "..value.." �� ������ "..Player[pid].nickname);
			SavePlayer(pid);
			LogString("Logs/Admins/giveOC",Player[id].nickname.." ����� "..value.." �� ������ "..Player[pid].nickname.." �� �������: "..reason.." / ".._getRTime())
		else
			SendPlayerMessage(id, 255, 255, 255, "/�� (��) (���-��) (�������)")
		end
	end
end
addCommandHandler({"/��", "oc"}, _giveHPoints);

function _killHPoints(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			if Player[pid].hpoints >= value then
				Player[pid].hpoints = Player[pid].hpoints - value;
				SendPlayerMessage(pid, 255, 255, 255, "� ��� ������� "..value.." ��.");
				SendPlayerMessage(id, 255, 255, 255, "�� ������� "..value.." �� � ������ "..Player[pid].nickname);
				SavePlayer(pid);
				LogString("Logs/Admins/killOC",Player[id].nickname.." ������ "..value.." �� � ������ "..Player[pid].nickname.." �� �������: "..reason.." / ".._getRTime())
			else
				SendPlayerMessage(id, 255, 255, 255, "� ������ ��� ������� ��.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/��������� (��) (���-��) (�������)")
		end
	end
end
addCommandHandler({"/���������"}, _killHPoints);


function _tradeHPoints(id, sets)

	if Player[id].astatus > 0 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			if Player[id].hpoints >= value then
				Player[pid].hpoints = Player[pid].hpoints + value;
				Player[id].hpoints = Player[id].hpoints - value;
				SendPlayerMessage(pid, 255, 255, 255, "��� �������� "..value.." �� �� ."..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "�� �������� "..value.." �� ������ "..GetPlayerName(pid));
				SavePlayer(pid);
				SavePlayer(id);
				LogString("Logs/Admins/tradeOC",Player[id].nickname.." ������� "..value.." �� ������ "..Player[pid].nickname.." �� �������: "..reason.." / ".._getRTime())
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�_�� (��) (���-��) (�������)")
		end
	end

end
addCommandHandler({"/�_��"}, _tradeHPoints);


function _orcSet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, otype = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 and Player[pid].loggedIn == true then

				if otype == "����" then
					SetPlayerInstance(pid, "ORCWARRIOR_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-�����.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-�����.");

				elseif otype == "���������" then
					SetPlayerInstance(pid, "ORC_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-����������.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-����������.");

				elseif otype == "�������" then
					SetPlayerInstance(pid, "ORCELITE_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ��������-����.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ��������-����.");

				elseif otype == "�����" then
					SetPlayerInstance(pid, "ORCSHAMAN_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������ ����-������.")
					SendPlayerMessage(id, 255, 255, 255, "������ "..GetPlayerName(pid).." ���������� ������ ����-������.");

				else
					SendPlayerMessage(id, 255, 255, 255, "��������� ������: ���������, ����, �����, �������")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ����������� ��� ��� ���.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�_��� (��) (���)")
			SendPlayerMessage(id, 255, 255, 255, "��������� ������: ���������, ����, �����, �������")
		end
	end
end
addCommandHandler({"/�_���"}, _orcSet);

function _zenSet(id, sets)

	if Player[id].astatus > 0 then
		local result, pid, zen = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 then
				if Player[pid].loggedIn == true then
					zen = string.upper(zen);
					SendPlayerMessage(id, 255, 255, 255, "�� ����������� � ��� "..zen.." ������ "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ��� "..zen);
					SetPlayerWorld(pid, zen);
					SetPlayerVirtualWorld(pid, 0);
					_saveZen(pid);
					SavePlayer(pid);
					LogString("Logs/Admins/zen", Player[id].nickname.." �������� ������ "..Player[pid].nickname.." � ��� "..zen.." / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "����� �� �������������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "��� ���.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���(zen) (��) (��������)")
		end
	end

end
addCommandHandler({"/���", "/zen"}, _zenSet);


function _energySet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			Player[pid].energy = value;
			SendPlayerMessage(id, 255, 255, 255, "�� ���������� ������� ������� � "..value.." ������ "..GetPlayerName(pid));
			SendPlayerMessage(pid, 255, 255, 255, "��� ���������� ������� ������� � "..value);
			_updateHud(pid);
			SavePlayer(pid);
			_debuffReset(pid);
			LogString("Logs/Admins/setEnergy", Player[id].nickname.." ��������� ������ "..Player[pid].nickname.." ������� �������: "..value.." / ".._getRTime())
		else
			SendPlayerMessage(id, 255, 255, 255, "/������� (��) (��������)")
		end
	end

end
addCommandHandler({"/�������"}, _energySet);

function ArnoldSchwarzenegger(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, par, value = sscanf(params, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "�������" then
				Player[id].h1 = Player[id].h1 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "������" then
				Player[id].h2 = Player[id].h2 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "���" then
				Player[id].bow = Player[id].bow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ����� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());


			elseif par == "�������" then
				Player[id].cbow = Player[id].cbow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());


			elseif par == "��" then
				Player[id].hp = Player[id].hp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "��" then
				Player[id].mp = Player[id].mp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "����" then
				Player[id].mag = Player[id].mag + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value.." (���� ������: "..Player[id].mag..")");
				SendPlayerMessage(id, 255, 255, 255, "��� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "����" then
				Player[id].str = Player[id].str + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "��������" then
				Player[id].dex = Player[id].dex + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());
			end
			
			_doubleSaveStats(id)
			
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��������� (��) (�������) (��������).")
			SendPlayerMessage(playerid, 255, 255, 255, "����, ��������, ��, ��, �������, ������, ���, �������, ����")
		end
	end

end
addCommandHandler({"/setstats", "/���������"}, ArnoldSchwarzenegger)


function _resetStat(playerid, sets)

	if Player[playerid].astatus > 2 then
		local result, id, par, value = sscanf(sets, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "�������" then
				Player[id].h1 = Player[id].h1 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "������" then
				Player[id].h2 = Player[id].h2 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��������� ������ ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ��������� ������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "���" then
				Player[id].bow = Player[id].bow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ��� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ����� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "�������" then
				Player[id].cbow = Player[id].cbow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "�������� ���������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "��" then
				Player[id].hp = Player[id].hp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "��" then
				Player[id].mp = Player[id].mp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "����" then
				Player[id].mag = Player[id].mag - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "��� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "����" then
				Player[id].str = Player[id].str - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� ���� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� ���� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());

			elseif par == "��������" then
				Player[id].dex = Player[id].dex - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� �������� �������� ������ "..GetPlayerName(id).." �� "..value);
				SendPlayerMessage(id, 255, 255, 255, "���� �������� �������� �� "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." ������� "..par.." ������ "..GetPlayerName(id).." �� "..value.." / ".._getRTime());
			end
			
			_doubleSaveStats(id)
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/�������� (��) (�������) (��������).")
			SendPlayerMessage(playerid, 255, 255, 255, "����, ��������, ��, ��, �������, ������, ���, �������, ����")
		end
	end
end
addCommandHandler({"/��������"}, _resetStat);

function MoneyMoneyMoneyMoneyMoneyMoneyMoney(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].gold = Player[id].gold + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..amount.." ������ ������ "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "��� ������ "..amount.." ������.");
				LogString("Logs/Admins/giveGold", Player[playerid].nickname.." ����� ������ "..Player[id].nickname.." ������ � ���-��: "..amount.." / ".._getRTime())
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������������.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/� (��) (���-��)");
		end
	end

end
addCommandHandler({"/z", "/�"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney)

function MoneyMoneyMoneyMoneyMoneyMoneyMoney11111(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				if Player[id].gold >= amount then
					Player[id].gold = Player[id].gold - amount;
					SavePlayer(id);
					SendPlayerMessage(playerid, 255, 255, 255, "�� ������� "..amount.." ������ � ������ "..GetPlayerName(id));
					SendPlayerMessage(id, 255, 255, 255, "� ��� ������� "..amount.." ������.");
					LogString("Logs/Admins/giveGold", Player[playerid].nickname.." ������ � ������ "..Player[id].nickname.." ������ � ���-��: "..amount.." / ".._getRTime())
				else
					SendPlayerMessage(playerid, 255, 255, 255, "� ������ ��� ������� ������.")
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������������.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/�������_������ (��) (���-��)");
		end
	end

end
addCommandHandler({"/�������_������"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney11111)


function fuckingNPC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			if IsNPC(id) == 1 then
				LogString("Logs/Admins/other", Player[playerid].nickname.." ��������� ��� "..GetPlayerName(id).." / ".._getRTime())
				DestroyNPC(id);
				SendPlayerMessage(playerid, 255, 255, 255, "��� � ID:"..id.." ���������.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "��� �� ���.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/����� (��)");
		end
	end

end
addCommandHandler({"/destr", "/�����"}, fuckingNPC)


-- ************************************************************************************************************************
---------------------------- 2 LEVEL.�

function TiKtoTakoiDadya(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, page = sscanf(params, "dd");
		if result == 1 then
			
			if page == 1 then
				SendPlayerMessage(playerid, 255, 255, 255, "����� ��������� "..GetPlayerName(id).. " (������: � �� / � ����)")
				SendPlayerMessage(playerid, 255, 255, 255, "����: "..Player[id].str.." / "..GetPlayerStrength(id));
				SendPlayerMessage(playerid, 255, 255, 255, "��������: "..Player[id].dex.." / "..GetPlayerDexterity(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����. ��: "..Player[id].hp.." / "..GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����. ��: "..Player[id].mp.." / "..GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "����������: "..Player[id].h1.." / "..GetPlayerSkillWeapon(id, SKILL_1H));
				SendPlayerMessage(playerid, 255, 255, 255, "���������: "..Player[id].h2.." / "..GetPlayerSkillWeapon(id, SKILL_2H));
				SendPlayerMessage(playerid, 255, 255, 255, "���: "..Player[id].bow.." / "..GetPlayerSkillWeapon(id, SKILL_BOW));
				SendPlayerMessage(playerid, 255, 255, 255, "�������: "..Player[id].cbow.." / "..GetPlayerSkillWeapon(id, SKILL_CBOW));

				LogString("Logs/Admins/other", Player[playerid].nickname.." �������� ���� ������ "..Player[id].nickname.." / ".._getRTime())
			elseif page == 2 then

				SendPlayerMessage(playerid, 255, 255, 255, "������ ���� ��������� "..GetPlayerName(id))
				SendPlayerMessage(playerid, 255, 255, 255, "������: "..Player[id].gold.." / ��: "..Player[id].hpoints);
				SendPlayerMessage(playerid, 255, 255, 255, "����� �����: "..Player[id].huntlevel.." / ����: "..Player[id].huntexp);
				SendPlayerMessage(playerid, 255, 255, 255, "����� ������ �������: "..Player[id].readscrolls);
				SendPlayerMessage(playerid, 255, 255, 255, "�������: "..Player[id].energy);
				if Player[id].blockpm == true then
					SendPlayerMessage(playerid, 255, 255, 255, "���� ��: ��������");
				else
					SendPlayerMessage(playerid, 255, 255, 255, "���� ��: ���������");
				end
				if Player[id].zvanie ~= nil then
					SendPlayerMessage(playerid, 255, 255, 255, "��� (������): "..Player[id].zvanie);
				else
					SendPlayerMessage(playerid, 255, 255, 255, "��� (������): ���.");
				end

				LogString("Logs/Admins/other", Player[playerid].nickname.." �������� ���� ������ "..Player[id].nickname.." / ".._getRTime())

			else
				SendPlayerMessage(playerid, 255, 255, 255, "������� ������� ��������.")
			end
			
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��) (�������� 1-2)");
		end
	end

end
addCommandHandler({"/info", "/����"}, TiKtoTakoiDadya)

function DavauSydaSvoiShmotkiPidor(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			SendPlayerMessage(playerid, 255, 255, 255, "���� ������ "..GetPlayerName(id)..":");
			local items = getPlayerItems(id);
			if items then
				for i in pairs(items) do
					if not string.find(items[i].instance, "DADADADADADADADADA") then
						SendPlayerMessage(playerid, 255, 255, 255, GetItemName(items[i].instance).." x"..items[i].amount);
					end
				end
			end
			LogString("Logs/Admins/other", Player[playerid].nickname.." �������� �������� ������ "..Player[id].nickname.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��)");
		end
	end

end
addCommandHandler({"/ite", "/���"}, DavauSydaSvoiShmotkiPidor)

function GItem(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, instance, value = sscanf(params, "dsd");
		if result == 1 then
			GiveItem(id, instance, value);
			SaveItems(id);
			SendPlayerMessage(playerid, 255, 255, 255, "�� ������ "..instance.." x"..value.." ������ "..GetPlayerName(id));
			SendPlayerMessage(id, 255, 255, 255, "��� ������ "..instance.." x"..value)
			LogString("Logs/Admins/cmd_give_code", Player[playerid].nickname.." ����� ������ "..Player[id].nickname.." �������: "..instance.." � ���-��: "..value.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/item (��) (��� ��������) (���-��)");
		end
	end

end
addCommandHandler({"/item"}, GItem)

function GBan(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 0 then
					SendPlayerMessage(i, 255, 255, 255, "����� "..GetPlayerName(id).." ������� ��������������� "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "������������� "..GetPlayerName(playerid).." ������� ��� �� �������: "..reason);
			LogString("Logs/Admins/bans", Player[playerid].nickname.." ������� ������ "..Player[id].nickname.." �� �������: "..reason.." / ".._getRTime())
			Ban(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��) (�������)")
		end
	end
end
addCommandHandler({"/ban", "/���"}, GBan);


function GKick(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 2 then
					SendPlayerMessage(i, 255, 255, 255, "����� "..GetPlayerName(id).." ������ � ������� ��������������� "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "������������� "..GetPlayerName(playerid).." ������ ��� �� �������: "..reason);
			LogString("Logs/Admins/kicks", Player[playerid].nickname.." ������ ������ "..Player[id].nickname.." �� �������: "..reason.." / ".._getRTime())
			Kick(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��) (�������)")
		end
	end

end
addCommandHandler({"/kick", "/���"}, GKick);


function InnosGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, GetPlayerMaxHealth(id));
			SendPlayerMessage(id, 255, 255, 255, "��� ��������.")
			SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(id).." �������.")
			LogString("Logs/Admins/heal", Player[playerid].nickname.." ������� ������ "..Player[id].nickname.." / ".._getRTime())
			SaveStats(id);
			SavePlayer(id);
			_doubleSaveStats(id)
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." ������� ������ "..GetPlayerName(id));
				end
			end
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��)")
		end
	end

end
addCommandHandler({"/heal", "/����"}, InnosGreat);

function Nastya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(50, 205, 50, "(�������) "..text);
			LogString("Logs/Admins/cmd_news", Player[playerid].nickname..": "..text.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������� (�����)")
		end
	end
end
addCommandHandler({"/news", "/�������"}, Nastya);



-- ************************************************************************************************************************
---------------------------- 1 LEVEL.

function Invise(playerid)

	if Player[playerid].astatus > 0 then
		if Player[playerid].invise == false then
			Player[playerid].invise = true;
			AI_PlayerList[playerid].Invisible = true;
			SetPlayerFatness(playerid, -100000000)
			SetPlayerScale(playerid, 1, 1, 4);
			LogString("Logs/Admins/invise", Player[playerid].nickname.." ���� � ����� / ".._getRTime())
			SendPlayerMessage(playerid, 255, 255, 255, "����� �����������, ����-��� �������.")
		else
			Player[playerid].invise = false;
			AI_PlayerList[playerid].Invisible = false;
			SetPlayerFatness(playerid, 1);
			SetPlayerScale(playerid, 1, 1, 1);
			LogString("Logs/Admins/invise", Player[playerid].nickname.." ����� � ������ / ".._getRTime())
			SendPlayerMessage(playerid, 255, 255, 255, "����� �������������, ����-��� ��������.")
		end
	end
end
addCommandHandler({"/inv", "/�����"}, Invise);

function _on_off_AC(id)

	if Player[id].astatus > 0 then
		if Player[id].adminchat == true then
			Player[id].adminchat = false;
			SendPlayerMessage(id, 255, 255, 255, "����� ��������� �� �����-���� ��������.")
		else
			Player[id].adminchat = true;
			SendPlayerMessage(id, 255, 255, 255, "����� ��������� �� �����-���� �������.")
		end
	end
end
--addCommandHandler({"/������", "/blockac"}, _on_off_AC);

function AC(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params,"s");
		if result == 1 then
			if Player[playerid].adminchat == true then
				for i = 0, MAX_PLAYERS - 1 do
					if Player[i].astatus > 2 and Player[i].adminchat == true then
						SendPlayerMessage(i, 131, 252, 180,"(��) "..GetPlayerName(playerid)..": "..text);
					end
				end
				LogString("Logs/Admins/admin_chat", GetPlayerName(playerid)..": "..text);
			else
				SendPlayerMessage(playerid, 255, 255, 255, "�����-��� ��������, �������� �������� /������")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/� (�����).");
		end
	end
end
addCommandHandler({"/a", "/�"}, AC);

function AnswerTo(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, "����� �� "..GetPlayerName(playerid)..": "..text);
			LogString("Logs/Admins/cmd_answer1x1", Player[playerid].nickname.." ������� ����� ������ "..Player[id].nickname..": "..text.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/�� (��) (�����).");
		end
	end

end
addCommandHandler({"/ad", "/��"}, AnswerTo);

function GMText(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			for i = 0, GetMaxSlots() do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 121, 216, 242, "(������) "..text);
				end
			end
			LogString("Logs/Admins/cmd_master", Player[playerid].nickname.." ������� � /��: "..text.." / ".._getRTime());

		else
			SendPlayerMessage(playerid, 64, 224, 208,"/�� (�����).");
		end
	end

end
addCommandHandler({"/gm", "/��"}, GMText);

function AllHeal(id)

	if Player[id].astatus > 0 then
		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 2000 then
				if Player[i].loggedIn == true and IsNPC(i) == 0 then
					_offAC(i);
					SetPlayerHealth(i, GetPlayerMaxHealth(i));
					SaveStats(i);
					SavePlayer(i);
					_doubleSaveStats(i)
					_onAC(i);
					SendPlayerMessage(i, 121, 216, 242, "������������� "..GetPlayerName(id).." ������� ���.");
				end
			end
		end
		LogString("Logs/Admins/cmd_heal", Player[id].nickname.." ������� ���� � ������� 2000 / ".._getRTime());

	end

end
addCommandHandler({"/�����"}, AllHeal);

function OffOOC(id)

	if Player[id].astatus > 2 then
		if OOC_STATUS == true then
			OOC_STATUS = false;
			SendMessageToAll(121, 216, 242, "������������� "..GetPlayerName(id).." �������� ���-���.")
			LogString("Logs/Admins/other", GetPlayerName(id).." �������� ���-���.");
		else
			OOC_STATUS = true;
			SendMessageToAll(121, 216, 242, "������������� "..GetPlayerName(id).." ������� ���-���.")
			LogString("Logs/Admins/other", GetPlayerName(id).." ������� ���-���.");
		end
	end

end
addCommandHandler({"/���"}, OffOOC);

function SetName(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SetPlayerName(id, text);
			SendPlayerMessage(playerid, 255, 255, 255, "��� ����������.")
			SendPlayerMessage(id, 255, 255, 255, "��� ��� �������.")
			LogString("Logs/Admins/cmd_name", Player[playerid].nickname.." ������� ��� ������ "..Player[id].nickname.." �� "..GetPlayerName(id).." / ".._getRTime());

		else
			SendPlayerMessage(playerid, 255, 255, 255,"/��� (��) (�����).");
		end
	end

end
addCommandHandler({"/nick", "/���"}, SetName);


function ToToTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, idfrom, idto = sscanf(params, "dd");
		if result == 1 then
			if Player[idfrom].loggedIn == true then
				local x, y, z = GetPlayerPos(idto);
				SetPlayerPos(idfrom, x+50, y+60, z);
				SavePlayer(idfrom);
				SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(idfrom).." ����������� � ������ "..GetPlayerName(idto));
				LogString("Logs/Admins/cmd_teleport", Player[playerid].nickname.." �������������� ������ "..Player[idfrom].nickname.." � "..Player[idto].nickname.." / ".._getRTime());
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/�� (�� ����) (�� � ����).");
		end
	end

end
addCommandHandler({"/tp", "/��"}, ToToTo);

function GScale(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, x, y, z = sscanf(params, "dfff");
		if result == 1 then
			SetPlayerScale(id, x, y, z);
			SendPlayerMessage(id, 255, 255, 255, "��� ������ ������� �� x"..x.." y"..y.." z"..z)
			SendPlayerMessage(playerid, 255, 255, 255, "������� ������ "..GetPlayerName(id).." �������� �� x"..x.." y"..y.." z"..z);
			LogString("Logs/Admins/cmd_size", Player[playerid].nickname.." ������� ������� ������ "..Player[id].nickname.." �� x"..x.." y"..y.." z".." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������ (��) (x) (y) (z)");
		end
	end

end
addCommandHandler({"/size", "/������"}, GScale)

function BeliarGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, 0);
			SavePlayer(id);
			SaveStats(id);
			SetTimerEx(_onAC, 2000, 0, id);
			SendPlayerMessage(id, 255, 255, 255, "��� �����.") -- xDD
			SendPlayerMessage(playerid, 255, 255, 255, "�� �����.") 
			LogString("Logs/Admins/cmd_kill", Player[playerid].nickname.." ���� ������ "..GetPlayerName(id).." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��)")
		end
	end

end
addCommandHandler({"/kill", "/����"}, BeliarGreat);


function WhoIt(playerid)

	if Player[playerid].astatus > 2 then
		local fId = GetFocus(playerid);
		if fId ~= -1 then
			SendPlayerMessage(playerid, 255, 255, 255, "��� ��������� � ������: "..Player[fId].nickname);
		end
		LogString("Logs/Admins/cmdWhoIt", Player[playerid].nickname.." �������� ��� ������ "..Player[fId].nickname.." � ����� ������ / ".._getRTime());
	end

end
addCommandHandler({"/idf", "/���"}, WhoIt);


function PlusMinusIMiOpyatIgraemVLybimih1(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, h, m = sscanf(params, "dd");
		if result == 1 then
			SetTime(h, m);
			WHOUR = h;
			SendMessageToAll(137, 140, 140, "����������� �����: "..h..":"..m)
			LogString("Logs/Admins/cmd_time", GetPlayerName(playerid).." ��������� ����� ��  "..h..":"..m.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/������� (���) (������)")
		end
	end

end
addCommandHandler({"/settime", "/�������"}, PlusMinusIMiOpyatIgraemVLybimih1);

function _clearChatAll(id)

	if Player[id].astatus > 3 then
		for i = 0, GetMaxPlayers() do
			if Player[i].loggedIn == true then
				for p = 1, 30 do
					SendPlayerMessage(i, 0, 0, 0, " ");
				end
			end
			SendPlayerMessage(i, 255, 255, 255, "������������� "..GetPlayerName(id).." ������� ���.");
			LogString("Logs/Admins/globalClearChat", Player[id].nickname.." ������� ��� / ".._getRTime());
		end
	end

end
addCommandHandler({"/����"}, _clearChatAll);

function CREATEBIGPOINTSONMAPNIGGER(playerid, params)

	if Player[playerid].astatus > 3 then
		local result, name = sscanf(params, "s");
		if result == 1 then
			local x, y, z = GetPlayerPos(playerid);
			local file = io.open("tpv/"..name, "w+");
			file:write(x.."\n");
			file:write(y.."\n");
			file:write(z.."\n");
			file:write(GetPlayerWorld(playerid).."\n");
			file:write(GetPlayerVirtualWorld(playerid).."\n");
			file:close();
			SendPlayerMessage(playerid, 255, 255, 255, "����� ������� � ��������� "..name.." ("..GetPlayerWorld(playerid).." / "..GetPlayerVirtualWorld(playerid)..").");
			LogString("Logs/Admins/createTPV", Player[playerid].nickname.." ������ ����� "..name.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/���� (��������)")
		end
	end

end
addCommandHandler({"/stpv", "/����"}, CREATEBIGPOINTSONMAPNIGGER);

function _cmdRusGive(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, amount, item = sscanf(sets, "dds");
		if result == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
				local rusname = GetItemCode(item);
				if rusname ~= item then
					GiveItem(pid, string.upper(GetItemCode(item)), amount);
					SaveItems(pid);
					SavePlayer(pid);
					SendPlayerMessage(id, 255, 255, 255, "�� ������ "..rusname.." x"..amount.." ������ "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "��� ������ "..rusname.." x"..amount.." �� "..GetPlayerName(id));
					LogString("Logs/Admins/cmd_item_name", Player[id].nickname.." ����� "..rusname.." � ���������� "..amount.." ������ "..Player[pid].nickname.." / ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "������� �� ������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� �� ������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (��) (���-��) (�������� ��������)")
		end
	end

end
addCommandHandler({"/����"}, _cmdRusGive);

function GOTOCAPTUREITSGHETTOMFC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, name = sscanf(params, "s");
		if result == 1 then
			local file = io.open("tpv/"..name, "r");
			if file then
				
				local x, y, z, world, vw;
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					x = d;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					y = d;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					z = d;
				end
				
				tempvar = file:read("*l");
				local result, s = sscanf(tempvar,"s");
				if result == 1 then
					world = s;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					vw = d;
				end
				
				file:close();
				
				if GetPlayerWorld(playerid) ~= world then
					SetPlayerWorld(playerid, world);
				end
				
				SetPlayerPos(playerid, x, y, z);
				
				if GetPlayerVirtualWorld(playerid) ~= vw then
					SetPlayerVirtualWorld(playerid, vw);
				end
				
				SavePlayer(playerid);
				_saveZen(playerid);
				
				LogString("Logs/Admins/goTPV", Player[playerid].nickname.." ���������������� �� ����� "..name.." / ".._getRTime());
			else
				SendPlayerMessage(playerid, 255, 255, 255, "����� �� �������.");
				SendPlayerMessage(playerid, 255, 255, 255, "�������� ���� ������������ ����� ����� ����� � ������ �����.������ (��.�������)")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��������)")
			SendPlayerMessage(playerid, 255, 255, 255, "�������� ���� ������������ ����� ����� ����� � ������ �����.������ (��.�������)")
		end
	end

end
addCommandHandler({"/tpv", "/���"}, GOTOCAPTUREITSGHETTOMFC);

function _radiusTPV(id, sets)
	
	if Player[id].astatus > 0 then
		local cmd, radius, pname = sscanf(sets, "ds");
		if cmd == 1 then

			local file = io.open("tpv/"..pname, "r");
			if file then
				
				local x, y, z, world, vw;
				
				line = file:read("*l");
				local result, d = sscanf(line,"d");
				if result == 1 then
					x = d;
				end
				
				line = file:read("*l");
				local result, d = sscanf(line,"d");
				if result == 1 then
					y = d;
				end
				
				line = file:read("*l");
				local result, d = sscanf(line,"d");
				if result == 1 then
					z = d;
				end
				
				tempvar = file:read("*l");
				local result, s = sscanf(tempvar,"s");
				if result == 1 then
					world = s;
				end
				
				tempvar = file:read("*l");
				local result, d = sscanf(tempvar,"d");
				if result == 1 then
					vw = d;
				end
				
				
				file:close();
				
				local tempArr = {};
				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						if GetPlayerWorld(i) == GetPlayerWorld(id) then
							if GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(id) then
								if GetDistancePlayers(i, id) <= radius then
									table.insert(tempArr, i);
									--SetPlayerPos(i, x, y, z);
									--SendPlayerMessage(i, 255, 255, 255, "������������� "..GetPlayerName(id).." �������������� ���.")
								end
							end
						end
					end
				end
				
				for _, v in pairs(tempArr) do
				
					SetPlayerPos(v, x, y, z);
					
					if GetPlayerWorld(v) ~= world then
						SetPlayerWorld(v, world);
					end
					
					if GetPlayerVirtualWorld(v) ~= vw then
						SetPlayerVirtualWorld(v, vw);
					end
					
					SendPlayerMessage(v, 255, 255, 255, "������������� "..GetPlayerName(id).." �������������� ���.")
				end
					
				LogString("Logs/Admins/massTPV", Player[id].nickname.." ������ �������� �������� �� ����� "..pname.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� �������.");
			end
				
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (������) (�����)");
			
		end
	end
end
addCommandHandler({"/����"}, _radiusTPV);

local track1 = CreateSound("LUTE_PLAY_1.WAV");
local track2 = CreateSound("LUTE_PLAY_2.WAV");
local track3 = CreateSound("LUTE_PLAY_3.WAV");
local track4 = CreateSound("LUTE_PLAY_4.WAV");
local track5 = CreateSound("LUTE_PLAY_5.WAV");

function muzika_dlya_dushi(id, sets)

	if Player[id].astatus > 0 then
	    local music, track, radius = sscanf(sets, "sd");
	    if music == 1 then
	        local temp = CreateSound(track);
	        for i = 0, GetMaxPlayers() do
	            if GetDistancePlayers(id, i) <= radius then
	                PlayPlayerSound(i, temp);
	            end
	        end
	        LogString("Logs/Admins/playMusic", Player[id].nickname.." �������� ���� "..track.." � ������� "..radius.." / ".._getRTime());
	    else
	        SendPlayerMessage(id, 255, 255, 255, "/������ (��������) (������)")
	    end
	end

end
addCommandHandler({"/������", "/musik"}, muzika_dlya_dushi);

