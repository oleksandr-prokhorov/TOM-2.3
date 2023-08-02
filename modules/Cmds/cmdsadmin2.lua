
-- говноскрипты дикнайта что ли... или это дерьмище с орс?..

function GetAdminsOnline(pid) 
	
end

function GetAdminLevel(pid)
	local lvl;
		if Player[pid].astatus == 1 then
			lvl = "Ведущий сюжета"
		elseif Player[pid].astatus == 2 then
			lvl = "Лидер"
		elseif Player[pid].astatus == 3 then
			lvl = "Помощник мастера"
		elseif Player[pid].astatus == 4 then	
			lvl = "Игровой мастер"
		elseif Player[pid].astatus == 5 then	
			lvl = "Координатор"
		elseif Player[pid].astatus == 6 then	
			lvl = "Т.А"
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
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права Ведущего сюжета игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Ведущего сюжета'");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 2 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права Лидера игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Лидера'");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 3 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права Помощника игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {125, 255, 122}
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Помощник'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 4 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права Мастера игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {110, 124, 255}
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Мастера'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 5 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права Координатора игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {189, 189, 189}
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Координатор'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 6 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." выдал права тех. администратора игроку "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {147, 31, 255}
					SendPlayerMessage(pid, 255, 255, 255, "Вам выданы внутриигровые права 'Т.А'");
					SavePlayer(pid);
					_ac_chatInit(pid);
					_showChat(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());

				elseif level == 0 then
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 176, 176, Player[id].nickname.." снял адм. права у игрока "..Player[pid].nickname);
						end
					end
					Player[pid].astatus = level;
					Player[pid].colorf5 = {255, 255, 255}
					SendPlayerMessage(pid, 255, 255, 255, "С вас были сняты игровые права.");
					SavePlayer(pid);
					LogString("Logs/Admins/setAdmin",Player[id].nickname.." дал права "..level.." уровня игроку "..Player[pid].nickname.." / ".._getRTime());
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/права (ид) (уровень)")
			SendPlayerMessage(id, 255, 255, 255, "1 - ведущий сюжета, 2 - лидер, 3 - помощник, 4 - мастер, 5 - координатор, 6 - Т.А")
		end
	end

end
addCommandHandler({"/права"}, _SetAdmin);

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
					SendPlayerMessage(playerid, 255, 255, 255, "Нельзя просить ХП в репорт у администрации.")
					Player[playerid].warns = Player[playerid].warns + 1;
					SendPlayerMessage(playerid, 255, 255, 255, "Вам выдано предупреждение по причине: правила сервера п2.2");
					SendPlayerMessage(playerid, 255, 255, 255, "При достижении 3х предупреждений вы будете забанены. Текущее кол-во: "..Player[playerid].warns);
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
			GameTextForPlayer(playerid, 3000, 3500, "Сообщение отправлено!","Font_Old_20_White_Hi.TGA", 255, 154, 0, 2400);
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
		SendPlayerMessage(playerid, 255, 255, 255 ,"/репорт (текст).");
	end
end
addCommandHandler({"/репорт","/report"}, CMD_REPORT)

function CMD_ASKREPORT(playerid,params)
	local result,id,text = sscanf(params,"ds");
	if Player[playerid].astatus > 2 then
		if result == 1 then
			if IsPlayerConnected(id) == 1 then
				SendPlayerMessage(id,255,68,0,GetAdminLevel(playerid).." "..Player[playerid].nickname..": "..text);
				SendPlayerMessage(playerid,255,68,0,"Вы ответили игроку "..Player[id].nickname..": "..text);
				for i = 0, GetMaxPlayers() do
					if IsPlayerConnected(i) == 1 then
						if Player[i].astatus > 2 then
							if i ~= playerid then
								SendPlayerMessage(i,255,68,0,"(REPORT) "..Player[playerid].nickname.." отвечает "..Player[id].nickname.." (ID:"..id.."): "..text);
							end
						end
					end
				end
				LogString("Logs/Admins/report_answer",GetAdminLevel(playerid).." "..Player[playerid].nickname.." ответил игроку "..Player[id].nickname..": "..text);
			else
				SendPlayerMessage(playerid,255,0,0,"Игрока с таким ID нет на сервере.");
			end
		else
			SendPlayerMessage(playerid,255,0,0,"Ошибка! Используй /ответ (ID игрока) (текст).");
		end
	else
		GameTextForPlayer(playerid, 50, 6000, "(SERVER): Недостаточно прав!","Font_Old_10_White_Hi.TGA", 230, 50, 50, 3000);
	end
end
addCommandHandler({"/ответ","/ask"}, CMD_ASKREPORT)
