
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
								SendPlayerMessage(id, 182, 240, 67, "Вы незаметно обокрали игрока "..GetPlayerName(pid).." и украли у него: "..GetItemName(drop_item));
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: "..GetItemName(drop_item).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "Вы незаметно обокрали игрока "..GetPlayerName(pid).." и украли у него: "..rnd.." руды.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: "..rnd.." руды / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "У игрока ничего нет.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: 0 руды / "..date);
								end
							end

						elseif min > 10 and min < 25 then

							if drop_item ~= nil then
								SendPlayerMessage(id, 182, 240, 67, "Вы обокрали игрока "..GetPlayerName(pid).." и украли у него: "..GetItemName(drop_item));
								SendPlayerMessage(id, 182, 240, 67, "Возможно игрок догадался о краже!")
								SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): С вами случилось что-то непонятное.");
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." почти идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: "..GetItemName(drop_item).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "Вы обокрали игрока "..GetPlayerName(pid).." и украли у него: "..rnd.." руды.");
									SendPlayerMessage(id, 182, 240, 67, "Возможно игрок догадался о краже!");
									SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): С вами случилось что-то непонятное.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." почти идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: "..rnd.." руды / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "У игрока ничего нет.");
									SendPlayerMessage(id, 182, 240, 67, "Возможно игрок догадался о попытке кражи!");
									SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): С вами случилось что-то непонятное.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." почти идеально обокрал игрока "..GetPlayerName(pid).." и украл у него: 0 руды / "..date);
								end
							end

						elseif min <= 10 then

							if drop_item ~= nil then
								SendPlayerMessage(id, 182, 240, 67, "Вы обокрали игрока "..GetPlayerName(pid).." и украли у него: "..GetItemName(drop_item));
								SendPlayerMessage(id, 182, 240, 67, "Игрок заметил вашу кражу.")
								SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): Игрок "..GetPlayerName(id).." украл у вас "..GetItemName(drop_item));
								LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." не смог обокрасть игрока "..GetPlayerName(pid).." / "..date);
							else
								if Player[pid].rude > 0 and Player[pid].rude < 10000 then
									local rnd = math.random(1, 15);
									SendPlayerMessage(id, 182, 240, 67, "Вы обокрали игрока "..GetPlayerName(pid).." и украли у него: "..rnd.." руды.");
									SendPlayerMessage(id, 182, 240, 67, "Возможно игрок догадался о краже!");
									SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): Игрок "..GetPlayerName(id).." украл у вас "..rnd.." руды.");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." не смог обокрасть игрока "..GetPlayerName(pid).." / "..date);
								else
									SendPlayerMessage(id, 182, 240, 67, "У игрока ничего нет.");
									SendPlayerMessage(id, 182, 240, 67, "Игрок догадался о попытке кражи!");
									SendPlayerMessage(pid, 182, 240, 67, "(Обстановка): "..GetPlayerName(id).." попытался безуспешно вас ограбить");
									LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." не смог обокрасть игрока "..GetPlayerName(pid).." / "..date);
								end
							end
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Вы не смогли ничего украсть и вас обнаружили.")
						SendPlayerMessage(pid, 255, 255, 255, "Вы поймали чужую руку в своем кармане, им оказался - "..GetPlayerName(id));
						LogString("Logs/PlayersAll/Steal", GetPlayerName(id).." не смог обокрасть игрока (перевес) "..GetPlayerName(pid).." / "..date);
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Это НПС.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован или не найден.");
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/вор (ид)");
		end
	end
end
--addCommandHandler({"/вор"}, _doSteal);