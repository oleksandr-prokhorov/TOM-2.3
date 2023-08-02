
function _createTempMonster(id, sets)

	if Player[id].astatus > 0 then
		local cmd, mtype, amount = sscanf(sets, "sd");
		if cmd == 1 then

			local x, y, z = GetPlayerPos(id);
			local world = GetPlayerWorld(id);
			--local point = "TEMP_POINT;"..x + math.random(-100, 100)..";"..y..";"..z + math.random(-100, 100)..";0;0";

			if mtype == "����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Wolf(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "���������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." �����������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Scavenger(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "�������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." �������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bloodfly(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "�������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ���. ��������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Gobbo_Green(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "���������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." �����������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Molerat(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "���" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." �����. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcWarrior(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());


			elseif mtype == "����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Lurker(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "��������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ����������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Shadowbeast(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ��������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Skeleton(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "�������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ���������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Snapper(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." �������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Troll(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Warg(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
				
			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." ��������. ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bandit_Jessy(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "�����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Pirat(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Savage(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "����������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(GiantBBug(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());


			elseif mtype == "���������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MeatBBug(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SSheep(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());


			elseif mtype == "��������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(DragonSnapper(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "�����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Zombie(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "��������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Guardian(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "����������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcElite(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Waran(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());


			elseif mtype == "�����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcBiter(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SwampDrone(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(StoneGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(FireGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(IceGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());

			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SwampGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "��������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcShaman(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "������������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcRoamer(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Savage(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MineCrawler(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "����������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MineCrawlerWarrior(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "�������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bogomol(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "�������������" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(StoneGuard(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			elseif mtype == "�����" then
				SendPlayerMessage(id, 255, 255, 255, "�� ���������� "..amount.." "..mtype..". ��� ����������� ����������� �� �����.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Yasherka(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." ��������� "..mtype.." � ���������� "..amount.." / ".._getRTime());
				
			else
				SendPlayerMessage(id, 255, 255, 255, "��� ���� �� ������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (���) (���-��)")
		end
	end

end
addCommandHandler({"/����"}, _createTempMonster);


function _setInviseForBots(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		
		if result == 1 then
			if Player[id].inviseforbots == false then
				AI_PlayerList[id].Invisible = true;
				Player[id].inviseforbots = true;
				SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(id).." ������ ������� ��� �����.")
				SendPlayerMessage(id, 255, 255, 255, "������ ��� ����� �� ��������.")
			else
				AI_PlayerList[id].Invisible = false;
				Player[id].inviseforbots = false;
				SendPlayerMessage(playerid, 255, 255, 255, "����� "..GetPlayerName(id).." ������ ����� ��� �����.")
				SendPlayerMessage(id, 255, 255, 255, "������ �� ������ ��� �����.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/��� (��)")
		end
	end

end
addCommandHandler({"/���", "/agr"}, _setInviseForBots);
 
function _setInviseForBotsAll(id, sets)

	if Player[id].astatus > 2 then
		local cmd, radius, status = sscanf(sets, "dd");
		if cmd == 1 then

			if status == 2 then

				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						if GetPlayerWorld(id) == GetPlayerWorld(i) then
							if GetDistancePlayers(id, i) <= radius then
								AI_PlayerList[i].Invisible = false;
								SendPlayerMessage(i, 255, 255, 255, "� ��� ������� ����������� �� �������� (������).")
							end
						end
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "��� ������ � ������� "..radius.." �������� ����-����.")


			elseif status == 1 then

				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						if GetPlayerWorld(id) == GetPlayerWorld(i) then
							if GetDistancePlayers(id, i) <= radius then
								AI_PlayerList[i].Invisible = true;
								SendPlayerMessage(i, 255, 255, 255, "�� �������� ����������� �� �������� (������).")
							end
						end
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "��� ������ � ������� "..radius.." �������� ����-���.")

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/���� (������) (������)")
			SendPlayerMessage(id, 255, 255, 255, "�������: 1 - �������� ����-���, 2 - ��������� ����-���")
		end
	end

end
addCommandHandler({"/����"}, _setInviseForBotsAll)

function IsInvise(playerid) -- ��� �� ��� ��� �����

	if Player[playerid].loggedIn == true then
		if Player[playerid].inviseforbots == true then
			return true;
		else
			return false;
		end
	else
		return false;
	end

end