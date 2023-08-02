
function _createTempMonster(id, sets)

	if Player[id].astatus > 0 then
		local cmd, mtype, amount = sscanf(sets, "sd");
		if cmd == 1 then

			local x, y, z = GetPlayerPos(id);
			local world = GetPlayerWorld(id);
			--local point = "TEMP_POINT;"..x + math.random(-100, 100)..";"..y..";"..z + math.random(-100, 100)..";0;0";

			if mtype == "волк" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." волков. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Wolf(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "падальщик" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." падальщиков. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Scavenger(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "шершень" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." шершней. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bloodfly(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "згоблин" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." зел. гоблинов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Gobbo_Green(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "кротокрыс" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." кротокрысов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Molerat(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "орк" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." орков. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcWarrior(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());


			elseif mtype == "шныг" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." шныгов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Lurker(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "мракорис" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." мракорисов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Shadowbeast(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "скелет" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." скелетов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Skeleton(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "снеппер" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." снепперов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Snapper(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "тролль" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." троллей. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Troll(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "варг" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." варгов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Warg(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
				
			elseif mtype == "бандит" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." бандитов. Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bandit_Jessy(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "пират" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Pirat(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "дикарь" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Savage(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "полевойжук" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(GiantBBug(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());


			elseif mtype == "мяснойжук" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MeatBBug(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "овца" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SSheep(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());


			elseif mtype == "дснеппер" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(DragonSnapper(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "зомби" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Zombie(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "стражник" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Guardian(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "элитныйорк" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcElite(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "ящер" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Waran(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());


			elseif mtype == "кусач" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcBiter(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "болотныйдрон" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SwampDrone(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "кголем" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(StoneGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "оголем" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(FireGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "лголем" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(IceGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());

			elseif mtype == "бголем" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(SwampGolem(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "оркшаман" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcShaman(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "оркразведчик" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(OrcRoamer(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "дикарь" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Savage(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "ползун" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MineCrawler(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "ползунвоин" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(MineCrawlerWarrior(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "богомол" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Bogomol(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "каменныйстраж" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(StoneGuard(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			elseif mtype == "чящер" then
				SendPlayerMessage(id, 255, 255, 255, "Вы заспавнили "..amount.." "..mtype..". Вам установлена невидимость от мобов.")
				AI_PlayerList[id].Invisible = true;

				for i = 1, amount do
					_SpawnNPCpos(Yasherka(), x + math.random(-100, 100), y + math.random(-100, 100), z + math.random(-100, 100), world)
				end

				LogString("Logs/Admins/tempMonster", Player[id].nickname.." заспавнил "..mtype.." в количестве "..amount.." / ".._getRTime());
				
			else
				SendPlayerMessage(id, 255, 255, 255, "Тип моба не найден.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/смоб (тип) (кол-во)")
		end
	end

end
addCommandHandler({"/смоб"}, _createTempMonster);


function _setInviseForBots(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		
		if result == 1 then
			if Player[id].inviseforbots == false then
				AI_PlayerList[id].Invisible = true;
				Player[id].inviseforbots = true;
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(id).." теперь невидим для мобов.")
				SendPlayerMessage(id, 255, 255, 255, "Теперь для мобов вы невидимы.")
			else
				AI_PlayerList[id].Invisible = false;
				Player[id].inviseforbots = false;
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(id).." теперь видим для мобов.")
				SendPlayerMessage(id, 255, 255, 255, "Теперь вы видимы для мобов.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/агр (ид)")
		end
	end

end
addCommandHandler({"/агр", "/agr"}, _setInviseForBots);
 
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
								SendPlayerMessage(i, 255, 255, 255, "У вас забрали невидимость от монстров (радиус).")
							end
						end
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Все игроки в радиусе "..radius.." лишились анти-агра.")


			elseif status == 1 then

				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						if GetPlayerWorld(id) == GetPlayerWorld(i) then
							if GetDistancePlayers(id, i) <= radius then
								AI_PlayerList[i].Invisible = true;
								SendPlayerMessage(i, 255, 255, 255, "Вы получили невидимость от монстров (радиус).")
							end
						end
					end
				end

				SendPlayerMessage(id, 255, 255, 255, "Все игроки в радиусе "..radius.." получили анти-агр.")

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/магр (радиус) (статус)")
			SendPlayerMessage(id, 255, 255, 255, "статусы: 1 - включить анти-агр, 2 - выключить анти-агр")
		end
	end

end
addCommandHandler({"/магр"}, _setInviseForBotsAll)

function IsInvise(playerid) -- чек на агр для мобов

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