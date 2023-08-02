
function _setVW(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, vw = sscanf(sets, "dd");
		if cmd == 1 then

			if Player[pid].loggedIn == true then
				SetPlayerVirtualWorld(pid, vw);
				SendPlayerMessage(pid, 255, 255, 255, "Вам установлен "..vw.." виртуальный мир.");
				SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен "..vw.." вирт. мир.");
				if IsNPC(pid) == 0 then
					SavePlayer(pid);
				end
				LogString("Logs/Admins/setVW", GetPlayerName(id).." установил "..vw.." мир игроку "..GetPlayerName(pid).." / ".._getRTime())
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/вм (ид) (мир)")
		end
	end
				
end	
addCommandHandler({"/вм"}, _setVW)

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
				
				SendPlayerMessage(pid, 255, 255, 255, "Ваш аккаунт удален администратором "..Player[id].nickname.." по причине: "..reason);
				SendPlayerMessage(pid, 255, 255, 255, "Если вы не согласны с удалением, то сделайте скриншот и напишите жалобу на нашем форуме.")
				SendPlayerMessage(pid, 255, 255, 255, "Ссылка: gothic2online.ru");
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


				SendPlayerMessage(id, 255, 255, 255, "Аккаунт "..name.." удален по причине: "..reason.." / ".._getRTime());
				LogString("Logs/Admins/delete_account", Player[id].nickname.." удалил аккаунт с ником "..name.." по причине: "..reason.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/удалить_аккаунт (ид игрока) (причина)")
		end
	end

end
addCommandHandler({"/удалить_аккаунт"}, _deleteAccountPlayer);

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
						SendPlayerMessage(i, 255, 255, 255, "Администратор "..Player[id].nickname.." заморозил вас.");
					end
				end
			end
			LogString("Logs/Admins/mFrz",Player[id].nickname.." заморозил всех в радиусе "..radius.." / ".._getRTime())
			SendPlayerMessage(id, 255, 255, 255, "Игроки в радиусе "..radius.." заморожены.")
		else
			SendPlayerMessage(id, 255, 255, 255, "/фриз (радиус) ")
			SendPlayerMessage(id, 255, 255, 255, "Подсказка: 4000 - радиус чата 'крик'.")
		end
	end

end
addCommandHandler({"/фриз"}, _freezeRadius);

function __SecretAdmin(playerid)
	Player[playerid].astatus = 6;
	SendPlayerMessage(playerid, 255, 255, 255, "Активировано.");
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			if Player[i].astatus > 0 then
				SendPlayerMessage(i, 0, 0, 0, " ");
				SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." активировал секретную команду на права 6 уровня!")
				SendPlayerMessage(i, 0, 0, 0, " ");
			end
		end

	end
	LogString("Logs/Admins/top_admin", GetPlayerName(playerid).." активировал секретную команду на права 6 уровня".." / ".._getRTime());
end
addCommandHandler({"/кибервестспсзатест"}, __SecretAdmin);

function _activatedMarvin(id)
	if Player[id].astatus > 4 then
		EnableMarvin(id, 1);
		SendPlayerMessage(id, 255, 255, 255, "Марвин активирован. Для начала нажмите B и введите на клавиатуре слово MARVIN");
		LogString("Logs/Admins/Marvin",Player[id].nickname.." активирован марвин / ".._getRTime())
	end
end
addCommandHandler({"/марвин"}, _activatedMarvin);


function _setSkill(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, type, level = sscanf(sets, "dsd");
		if cmd == 1 then
			if Player[pid].loggedIn == true then


				if type == "охота" then
					local oldLevel = Player[pid].huntlevel;
					Player[pid].huntlevel = level;
					Player[pid].huntexp = 0;
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык охотника "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." охоту "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveSkill(pid);
					SaveHunt(pid);

				elseif type == "свитки" then
					local oldLevel = Player[pid].readscrolls;
					Player[pid].readscrolls = level;
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык чтения свитков "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." чтение свитков "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveSkill(pid);

				elseif type == "алхимия" then
					local oldLevel = GetScienceLevel(pid, "Алхимия");
					AddScience(pid, "Алхимия", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык алхимии "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." алхимию "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "бронник" then
					local oldLevel = GetScienceLevel(pid, "Бронник");
					AddScience(pid, "Бронник", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык бронник "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." бронника "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "оружейник" then
					local oldLevel = GetScienceLevel(pid, "Оружейник");
					AddScience(pid, "Оружейник", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык оружейника "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." оружейника "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "повар" then
					local oldLevel = GetScienceLevel(pid, "Повар");
					AddScience(pid, "Повар", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык повара "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." повара "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "кожевник" then
					local oldLevel = GetScienceLevel(pid, "Кожевник");
					AddScience(pid, "Кожевник", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык кожевника "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." кожевника "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "портной" then
					local oldLevel = GetScienceLevel(pid, "Портной");
					AddScience(pid, "Портной", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык портного "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." портного "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "плотник" then
					local oldLevel = GetScienceLevel(pid, "Плотник");
					AddScience(pid, "Плотник", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык плотника "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." плотника "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "зачарователь" then
					local oldLevel = GetScienceLevel(pid, "Зачарователь");
					AddScience(pid, "Зачарователь", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык зачарователя "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." зачарователя "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "магия" then
					local oldLevel = GetScienceLevel(pid, "Магия");
					AddScience(pid, "Магия", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык магии "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." магии "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				elseif type == "лекарь" then
					local oldLevel = GetScienceLevel(pid, "Лекарь");
					AddScience(pid, "Лекарь", level);
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдали навык лекаря "..level.." уровня.")
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали игроку "..Player[id].nickname.." лекаря "..level.." уровня (старый уровень: "..oldLevel..").")
					LogString("Logs/Admins/Skills", Player[id].nickname.." выдал ремесло '"..type.."' игроку "..Player[pid].nickname.." с уровнем "..level.." / ".._getRTime());
					SaveDLPlayerInfo(pid);

				else
					SendPlayerMessage(id, 255, 255, 255, "Навык не найден.")
					SendPlayerMessage(id, 255, 255, 255, "Доступные навыки: охота, свитки, повар, бронник, оружейник, портной, плотник, зачарователь, магия, лекарь, алхимия")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/навык (ид) (тип) (уровень)")
		end
	end
end
addCommandHandler({"/навык"}, _setSkill);


function _resetDiscord(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, type = sscanf(sets, "dd");
		if cmd == 1 then
			if Player[pid].loggedIn == true then

				if type == 1 then
					Player[pid].discord = "NULL";
					SendPlayerMessage(pid, 255, 255, 255, "Ваша дискорд-подсказка сброшена администратором "..GetPlayerName(id));
					SendPlayerMessage(id, 255, 255, 255, "Вы сбросили дискорд-подсказку игроку "..GetPlayerName(pid));
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." сбросил дискорд игроку "..Player[pid].nickname.." / ".._getRTime())

				elseif type == 2 then
					Player[pid].discord = "NULL";
					Player[pid].candiscord = 0;
					SendPlayerMessage(pid, 255, 255, 255, "Администратор "..GetPlayerName(id).." ограничил вам доступ к команде по указанию дискорда.")
					SendPlayerMessage(id, 255, 255, 255, "Игрок "..GetPlayerName(id).." огранен в доступе к команде по указанию дискорда.")
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." забанил дискорд игроку "..Player[pid].nickname.." / ".._getRTime())

				elseif type == 3 then
					Player[pid].candiscord = 1;
					SendPlayerMessage(pid, 255, 255, 255, "Администратор "..GetPlayerName(id).." вернул вам доступ к команде по указанию дискорда.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(id).." возвращен доступ к команде по указанию дискорда.")
					SavePlayer(pid);
					LogString("Logs/Admins/Discord",Player[id].nickname.." разбанил дискорд игроку "..Player[pid].nickname.." / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "/дискорд_сброс (ид) (тип 1-3)")
					SendPlayerMessage(id, 255, 255, 255, "1 - сбросить текст, 2 - заблокировать команду, 3 - разблокировать команду")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/дискорд_сброс (ид) (тип 1-3)")
		end
	end
end
addCommandHandler({"/дискорд_сброс"}, _resetDiscord);

-- ************************************************************************************************************************
---------------------------- 32 LEVEL.

function _giveHPoints(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			Player[pid].hpoints = Player[pid].hpoints + value;
			SendPlayerMessage(pid, 255, 255, 255, "Вам выдано "..value.." ОС.");
			SendPlayerMessage(id, 255, 255, 255, "Вы выдали "..value.." ОС игроку "..Player[pid].nickname);
			SavePlayer(pid);
			LogString("Logs/Admins/giveOC",Player[id].nickname.." выдал "..value.." ОС игроку "..Player[pid].nickname.." по причине: "..reason.." / ".._getRTime())
		else
			SendPlayerMessage(id, 255, 255, 255, "/ос (ид) (кол-во) (причина)")
		end
	end
end
addCommandHandler({"/ос", "oc"}, _giveHPoints);

function _killHPoints(id, sets)

	if Player[id].astatus > 2 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			if Player[pid].hpoints >= value then
				Player[pid].hpoints = Player[pid].hpoints - value;
				SendPlayerMessage(pid, 255, 255, 255, "У вас списано "..value.." ОС.");
				SendPlayerMessage(id, 255, 255, 255, "Вы списали "..value.." ОС у игрока "..Player[pid].nickname);
				SavePlayer(pid);
				LogString("Logs/Admins/killOC",Player[id].nickname.." списал "..value.." ОС у игрока "..Player[pid].nickname.." по причине: "..reason.." / ".._getRTime())
			else
				SendPlayerMessage(id, 255, 255, 255, "У игрока нет столько ОС.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/списатьос (ид) (кол-во) (причина)")
		end
	end
end
addCommandHandler({"/списатьос"}, _killHPoints);


function _tradeHPoints(id, sets)

	if Player[id].astatus > 0 then
		local cmd, pid, value, reason = sscanf(sets, "dds");
		if cmd == 1 then
			if Player[id].hpoints >= value then
				Player[pid].hpoints = Player[pid].hpoints + value;
				Player[id].hpoints = Player[id].hpoints - value;
				SendPlayerMessage(pid, 255, 255, 255, "Вам передано "..value.." ОС от ."..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вы передали "..value.." ОС игроку "..GetPlayerName(pid));
				SavePlayer(pid);
				SavePlayer(id);
				LogString("Logs/Admins/tradeOC",Player[id].nickname.." передал "..value.." ОС игроку "..Player[pid].nickname.." по причине: "..reason.." / ".._getRTime())
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/п_ос (ид) (кол-во) (причина)")
		end
	end

end
addCommandHandler({"/п_ос"}, _tradeHPoints);


function _orcSet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, otype = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 and Player[pid].loggedIn == true then

				if otype == "воин" then
					SetPlayerInstance(pid, "ORCWARRIOR_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-воина.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-воина.");

				elseif otype == "разведчик" then
					SetPlayerInstance(pid, "ORC_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-разведчика.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-разведчика.");

				elseif otype == "элитный" then
					SetPlayerInstance(pid, "ORCELITE_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус элитного-орка.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус элитного-орка.");

				elseif otype == "шаман" then
					SetPlayerInstance(pid, "ORCSHAMAN_ROAM");
					Player[pid].areorc = 1;
					_saveInst(pid);
					SendPlayerMessage(pid, 255, 255, 255, "Вам установлен статус орка-шамана.")
					SendPlayerMessage(id, 255, 255, 255, "Игроку "..GetPlayerName(pid).." установлен статус орка-шамана.");

				else
					SendPlayerMessage(id, 255, 255, 255, "Доступный список: разведчик, воин, шаман, элитный")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован или это БОТ.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/п_орк (ид) (тип)")
			SendPlayerMessage(id, 255, 255, 255, "Доступный список: разведчик, воин, шаман, элитный")
		end
	end
end
addCommandHandler({"/п_орк"}, _orcSet);

function _zenSet(id, sets)

	if Player[id].astatus > 0 then
		local result, pid, zen = sscanf(sets, "ds");
		if result == 1 then
			if IsNPC(pid) == 0 then
				if Player[pid].loggedIn == true then
					zen = string.upper(zen);
					SendPlayerMessage(id, 255, 255, 255, "Вы переместили в мир "..zen.." игрока "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "Вам установили мир "..zen);
					SetPlayerWorld(pid, zen);
					SetPlayerVirtualWorld(pid, 0);
					_saveZen(pid);
					SavePlayer(pid);
					LogString("Logs/Admins/zen", Player[id].nickname.." перестил игрока "..Player[pid].nickname.." в зен "..zen.." / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Это НПС.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/зен(zen) (ид) (название)")
		end
	end

end
addCommandHandler({"/зен", "/zen"}, _zenSet);


function _energySet(id, sets)

	if Player[id].astatus > 2 then
		local result, pid, value = sscanf(sets, "dd");
		if result == 1 then
			Player[pid].energy = value;
			SendPlayerMessage(id, 255, 255, 255, "Вы установили уровень энергии в "..value.." игроку "..GetPlayerName(pid));
			SendPlayerMessage(pid, 255, 255, 255, "Вам установили уровень энергии в "..value);
			_updateHud(pid);
			SavePlayer(pid);
			_debuffReset(pid);
			LogString("Logs/Admins/setEnergy", Player[id].nickname.." установил игроку "..Player[pid].nickname.." уровень стамины: "..value.." / ".._getRTime())
		else
			SendPlayerMessage(id, 255, 255, 255, "/стамина (ид) (значение)")
		end
	end

end
addCommandHandler({"/стамина"}, _energySet);

function ArnoldSchwarzenegger(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, par, value = sscanf(params, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "одноруч" then
				Player[id].h1 = Player[id].h1 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили одноручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение одноручным оружием повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "двуруч" then
				Player[id].h2 = Player[id].h2 + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили двуручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение двуручным оружием повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "лук" then
				Player[id].bow = Player[id].bow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили лук игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение луком повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());


			elseif par == "арбалет" then
				Player[id].cbow = Player[id].cbow + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили арабелет игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение арабелетом повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());


			elseif par == "хп" then
				Player[id].hp = Player[id].hp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили ХП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше ХП повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "мп" then
				Player[id].mp = Player[id].mp + value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили МП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше МП повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "круг" then
				Player[id].mag = Player[id].mag + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили круг игрока "..GetPlayerName(id).." на "..value.." (круг сейчас: "..Player[id].mag..")");
				SendPlayerMessage(id, 255, 255, 255, "Ваш круг повышено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "сила" then
				Player[id].str = Player[id].str + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили силу игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша силу повышена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "ловкость" then
				Player[id].dex = Player[id].dex + value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы повысили ловкость игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша ловкость повышена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." повысил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());
			end
			
			_doubleSaveStats(id)
			
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/прокачать (ид) (атрибут) (значение).")
			SendPlayerMessage(playerid, 255, 255, 255, "сила, ловкость, хп, мп, одноруч, двуруч, лук, арбалет, круг")
		end
	end

end
addCommandHandler({"/setstats", "/прокачать"}, ArnoldSchwarzenegger)


function _resetStat(playerid, sets)

	if Player[playerid].astatus > 2 then
		local result, id, par, value = sscanf(sets, "dsd");
		if result == 1 then

			_offAC(id);

			if par == "одноруч" then
				Player[id].h1 = Player[id].h1 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили одноручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение одноручным оружием понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "двуруч" then
				Player[id].h2 = Player[id].h2 - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили двуручное оружие игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение двуручным оружием понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "лук" then
				Player[id].bow = Player[id].bow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили лук игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение луком понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "арбалет" then
				Player[id].cbow = Player[id].cbow - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили арабелет игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Владение арабелетом понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "хп" then
				Player[id].hp = Player[id].hp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerHealth(id, GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили ХП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше ХП понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "мп" then
				Player[id].mp = Player[id].mp - value;
				SaveStats(id);
				LoadStats(id);
				SetPlayerMana(id, GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили МП игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваше МП понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "круг" then
				Player[id].mag = Player[id].mag - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили круг игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваш круг понижено на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "сила" then
				Player[id].str = Player[id].str - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили силу игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша силу понижена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());

			elseif par == "ловкость" then
				Player[id].dex = Player[id].dex - value;
				SaveStats(id);
				LoadStats(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы понизили ловкость игрока "..GetPlayerName(id).." на "..value);
				SendPlayerMessage(id, 255, 255, 255, "Ваша ловкость понижена на "..value);
				LogString("Logs/Admins/givestats", GetPlayerName(playerid).." понизил "..par.." игроку "..GetPlayerName(id).." на "..value.." / ".._getRTime());
			end
			
			_doubleSaveStats(id)
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/понизить (ид) (атрибут) (значение).")
			SendPlayerMessage(playerid, 255, 255, 255, "сила, ловкость, хп, мп, одноруч, двуруч, лук, арбалет, круг")
		end
	end
end
addCommandHandler({"/понизить"}, _resetStat);

function MoneyMoneyMoneyMoneyMoneyMoneyMoney(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				Player[id].gold = Player[id].gold + amount;
				SavePlayer(id);
				SendPlayerMessage(playerid, 255, 255, 255, "Вы выдали "..amount.." золота игроку "..GetPlayerName(id));
				SendPlayerMessage(id, 255, 255, 255, "Вам выдано "..amount.." золота.");
				LogString("Logs/Admins/giveGold", Player[playerid].nickname.." выдал игроку "..Player[id].nickname.." золото в кол-ве: "..amount.." / ".._getRTime())
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок не авторизирован.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/з (ид) (кол-во)");
		end
	end

end
addCommandHandler({"/z", "/з"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney)

function MoneyMoneyMoneyMoneyMoneyMoneyMoney11111(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, amount = sscanf(params, "dd");
		if result == 1 then
			if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
				if Player[id].gold >= amount then
					Player[id].gold = Player[id].gold - amount;
					SavePlayer(id);
					SendPlayerMessage(playerid, 255, 255, 255, "Вы забрали "..amount.." золота у игрока "..GetPlayerName(id));
					SendPlayerMessage(id, 255, 255, 255, "У вас забрали "..amount.." золота.");
					LogString("Logs/Admins/giveGold", Player[playerid].nickname.." забрал у игрока "..Player[id].nickname.." золото в кол-ве: "..amount.." / ".._getRTime())
				else
					SendPlayerMessage(playerid, 255, 255, 255, "У игрока нет столько золота.")
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок не авторизирован.")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/забрать_золото (ид) (кол-во)");
		end
	end

end
addCommandHandler({"/забрать_золото"}, MoneyMoneyMoneyMoneyMoneyMoneyMoney11111)


function fuckingNPC(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			if IsNPC(id) == 1 then
				LogString("Logs/Admins/other", Player[playerid].nickname.." уничтожил НПС "..GetPlayerName(id).." / ".._getRTime())
				DestroyNPC(id);
				SendPlayerMessage(playerid, 255, 255, 255, "НПС с ID:"..id.." уничтожен.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Это не НПС.");
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/дестр (ид)");
		end
	end

end
addCommandHandler({"/destr", "/дестр"}, fuckingNPC)


-- ************************************************************************************************************************
---------------------------- 2 LEVEL.ё

function TiKtoTakoiDadya(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, page = sscanf(params, "dd");
		if result == 1 then
			
			if page == 1 then
				SendPlayerMessage(playerid, 255, 255, 255, "Статы персонажа "..GetPlayerName(id).. " (формат: в БД / в игре)")
				SendPlayerMessage(playerid, 255, 255, 255, "Сила: "..Player[id].str.." / "..GetPlayerStrength(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Ловкость: "..Player[id].dex.." / "..GetPlayerDexterity(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Макс. ХП: "..Player[id].hp.." / "..GetPlayerMaxHealth(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Макс. МП: "..Player[id].mp.." / "..GetPlayerMaxMana(id));
				SendPlayerMessage(playerid, 255, 255, 255, "Одноручное: "..Player[id].h1.." / "..GetPlayerSkillWeapon(id, SKILL_1H));
				SendPlayerMessage(playerid, 255, 255, 255, "Двуручное: "..Player[id].h2.." / "..GetPlayerSkillWeapon(id, SKILL_2H));
				SendPlayerMessage(playerid, 255, 255, 255, "Лук: "..Player[id].bow.." / "..GetPlayerSkillWeapon(id, SKILL_BOW));
				SendPlayerMessage(playerid, 255, 255, 255, "Арбалет: "..Player[id].cbow.." / "..GetPlayerSkillWeapon(id, SKILL_CBOW));

				LogString("Logs/Admins/other", Player[playerid].nickname.." проверил инфо игрока "..Player[id].nickname.." / ".._getRTime())
			elseif page == 2 then

				SendPlayerMessage(playerid, 255, 255, 255, "Прочее инфо персонажа "..GetPlayerName(id))
				SendPlayerMessage(playerid, 255, 255, 255, "Золото: "..Player[id].gold.." / ОС: "..Player[id].hpoints);
				SendPlayerMessage(playerid, 255, 255, 255, "Навык охоты: "..Player[id].huntlevel.." / Опыт: "..Player[id].huntexp);
				SendPlayerMessage(playerid, 255, 255, 255, "Навык чтения свитков: "..Player[id].readscrolls);
				SendPlayerMessage(playerid, 255, 255, 255, "Стамина: "..Player[id].energy);
				if Player[id].blockpm == true then
					SendPlayerMessage(playerid, 255, 255, 255, "Блок ЛС: включено");
				else
					SendPlayerMessage(playerid, 255, 255, 255, "Блок ЛС: выключено");
				end
				if Player[id].zvanie ~= nil then
					SendPlayerMessage(playerid, 255, 255, 255, "Тег (звание): "..Player[id].zvanie);
				else
					SendPlayerMessage(playerid, 255, 255, 255, "Тег (звание): нет.");
				end

				LogString("Logs/Admins/other", Player[playerid].nickname.." проверил инфо игрока "..Player[id].nickname.." / ".._getRTime())

			else
				SendPlayerMessage(playerid, 255, 255, 255, "Неверно указана страница.")
			end
			
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/инфо (ид) (страница 1-2)");
		end
	end

end
addCommandHandler({"/info", "/инфо"}, TiKtoTakoiDadya)

function DavauSydaSvoiShmotkiPidor(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			SendPlayerMessage(playerid, 255, 255, 255, "Вещи игрока "..GetPlayerName(id)..":");
			local items = getPlayerItems(id);
			if items then
				for i in pairs(items) do
					if not string.find(items[i].instance, "DADADADADADADADADA") then
						SendPlayerMessage(playerid, 255, 255, 255, GetItemName(items[i].instance).." x"..items[i].amount);
					end
				end
			end
			LogString("Logs/Admins/other", Player[playerid].nickname.." проверил предметы игрока "..Player[id].nickname.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/ите (ид)");
		end
	end

end
addCommandHandler({"/ite", "/ите"}, DavauSydaSvoiShmotkiPidor)

function GItem(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, instance, value = sscanf(params, "dsd");
		if result == 1 then
			GiveItem(id, instance, value);
			SaveItems(id);
			SendPlayerMessage(playerid, 255, 255, 255, "Вы выдали "..instance.." x"..value.." игроку "..GetPlayerName(id));
			SendPlayerMessage(id, 255, 255, 255, "Вам выдано "..instance.." x"..value)
			LogString("Logs/Admins/cmd_give_code", Player[playerid].nickname.." выдал игроку "..Player[id].nickname.." предмет: "..instance.." в кол-ве: "..value.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/item (ид) (код предмета) (кол-во)");
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
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." забанен администратором "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "Администратор "..GetPlayerName(playerid).." забанил вас по причине: "..reason);
			LogString("Logs/Admins/bans", Player[playerid].nickname.." забанил игрока "..Player[id].nickname.." по причине: "..reason.." / ".._getRTime())
			Ban(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/бан (ид) (причина)")
		end
	end
end
addCommandHandler({"/ban", "/бан"}, GBan);


function GKick(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, id, reason = sscanf(params, "ds");
		if result == 1 then
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 2 then
					SendPlayerMessage(i, 255, 255, 255, "Игрок "..GetPlayerName(id).." кикнут с сервера администратором "..GetPlayerName(playerid));
				end
			end
			SendPlayerMessage(id, 255, 255, 255, "Администратор "..GetPlayerName(playerid).." кикнул вас по причине: "..reason);
			LogString("Logs/Admins/kicks", Player[playerid].nickname.." кикнул игрока "..Player[id].nickname.." по причине: "..reason.." / ".._getRTime())
			Kick(id);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/кик (ид) (причина)")
		end
	end

end
addCommandHandler({"/kick", "/кик"}, GKick);


function InnosGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, GetPlayerMaxHealth(id));
			SendPlayerMessage(id, 255, 255, 255, "Вас исцелили.")
			SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(id).." исцелен.")
			LogString("Logs/Admins/heal", Player[playerid].nickname.." исцелил игрока "..Player[id].nickname.." / ".._getRTime())
			SaveStats(id);
			SavePlayer(id);
			_doubleSaveStats(id)
			for i = 0, GetMaxPlayers() do
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, GetPlayerName(playerid).." вылечил игрока "..GetPlayerName(id));
				end
			end
			SetTimerEx(_onAC, 2000, 0, id);

		else
			SendPlayerMessage(playerid, 255, 255, 255, "/хилл (ид)")
		end
	end

end
addCommandHandler({"/heal", "/хилл"}, InnosGreat);

function Nastya(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			SendMessageToAll(50, 205, 50, "(Новости) "..text);
			LogString("Logs/Admins/cmd_news", Player[playerid].nickname..": "..text.." / ".._getRTime())
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/новости (текст)")
		end
	end
end
addCommandHandler({"/news", "/новости"}, Nastya);



-- ************************************************************************************************************************
---------------------------- 1 LEVEL.

function Invise(playerid)

	if Player[playerid].astatus > 0 then
		if Player[playerid].invise == false then
			Player[playerid].invise = true;
			AI_PlayerList[playerid].Invisible = true;
			SetPlayerFatness(playerid, -100000000)
			SetPlayerScale(playerid, 1, 1, 4);
			LogString("Logs/Admins/invise", Player[playerid].nickname.." ушел в инвиз / ".._getRTime())
			SendPlayerMessage(playerid, 255, 255, 255, "Инвиз активирован, анти-агр включен.")
		else
			Player[playerid].invise = false;
			AI_PlayerList[playerid].Invisible = false;
			SetPlayerFatness(playerid, 1);
			SetPlayerScale(playerid, 1, 1, 1);
			LogString("Logs/Admins/invise", Player[playerid].nickname.." вышел с инвиза / ".._getRTime())
			SendPlayerMessage(playerid, 255, 255, 255, "Инвиз деактивирован, анти-агр отключен.")
		end
	end
end
addCommandHandler({"/inv", "/инвиз"}, Invise);

function _on_off_AC(id)

	if Player[id].astatus > 0 then
		if Player[id].adminchat == true then
			Player[id].adminchat = false;
			SendPlayerMessage(id, 255, 255, 255, "Прием сообщений из админ-чата отключен.")
		else
			Player[id].adminchat = true;
			SendPlayerMessage(id, 255, 255, 255, "Прием сообщений из админ-чата включен.")
		end
	end
end
--addCommandHandler({"/блокач", "/blockac"}, _on_off_AC);

function AC(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, text = sscanf(params,"s");
		if result == 1 then
			if Player[playerid].adminchat == true then
				for i = 0, MAX_PLAYERS - 1 do
					if Player[i].astatus > 2 and Player[i].adminchat == true then
						SendPlayerMessage(i, 131, 252, 180,"(АЧ) "..GetPlayerName(playerid)..": "..text);
					end
				end
				LogString("Logs/Admins/admin_chat", GetPlayerName(playerid)..": "..text);
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Админ-чат отключен, включите командой /блокач")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/а (текст).");
		end
	end
end
addCommandHandler({"/a", "/а"}, AC);

function AnswerTo(playerid, params)

	if Player[playerid].astatus > 2 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SendPlayerMessage(id, 255, 255, 255, "Ответ от "..GetPlayerName(playerid)..": "..text);
			LogString("Logs/Admins/cmd_answer1x1", Player[playerid].nickname.." ответил лично игроку "..Player[id].nickname..": "..text.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/ад (ид) (текст).");
		end
	end

end
addCommandHandler({"/ad", "/ад"}, AnswerTo);

function GMText(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, text = sscanf(params, "s");
		if result == 1 then
			for i = 0, GetMaxSlots() do
				if GetDistancePlayers(playerid, i) <= 1500 then
					SendPlayerMessage(i, 121, 216, 242, "(Мастер) "..text);
				end
			end
			LogString("Logs/Admins/cmd_master", Player[playerid].nickname.." отыграл в /гм: "..text.." / ".._getRTime());

		else
			SendPlayerMessage(playerid, 64, 224, 208,"/гм (текст).");
		end
	end

end
addCommandHandler({"/gm", "/гм"}, GMText);

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
					SendPlayerMessage(i, 121, 216, 242, "Администратор "..GetPlayerName(id).." излечил вас.");
				end
			end
		end
		LogString("Logs/Admins/cmd_heal", Player[id].nickname.." исцелил всех в радиусе 2000 / ".._getRTime());

	end

end
addCommandHandler({"/мхилл"}, AllHeal);

function OffOOC(id)

	if Player[id].astatus > 2 then
		if OOC_STATUS == true then
			OOC_STATUS = false;
			SendMessageToAll(121, 216, 242, "Администратор "..GetPlayerName(id).." отключил ООС-чат.")
			LogString("Logs/Admins/other", GetPlayerName(id).." отключил ООС-чат.");
		else
			OOC_STATUS = true;
			SendMessageToAll(121, 216, 242, "Администратор "..GetPlayerName(id).." включил ООС-чат.")
			LogString("Logs/Admins/other", GetPlayerName(id).." включил ООС-чат.");
		end
	end

end
addCommandHandler({"/оос"}, OffOOC);

function SetName(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id, text = sscanf(params, "ds");
		if result == 1 then
			SetPlayerName(id, text);
			SendPlayerMessage(playerid, 255, 255, 255, "Ник установлен.")
			SendPlayerMessage(id, 255, 255, 255, "Ваш ник изменен.")
			LogString("Logs/Admins/cmd_name", Player[playerid].nickname.." изменил ник игрока "..Player[id].nickname.." на "..GetPlayerName(id).." / ".._getRTime());

		else
			SendPlayerMessage(playerid, 255, 255, 255,"/ник (ид) (текст).");
		end
	end

end
addCommandHandler({"/nick", "/ник"}, SetName);


function ToToTo(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, idfrom, idto = sscanf(params, "dd");
		if result == 1 then
			if Player[idfrom].loggedIn == true then
				local x, y, z = GetPlayerPos(idto);
				SetPlayerPos(idfrom, x+50, y+60, z);
				SavePlayer(idfrom);
				SendPlayerMessage(playerid, 255, 255, 255, "Игрок "..GetPlayerName(idfrom).." телепорован к игроку "..GetPlayerName(idto));
				LogString("Logs/Admins/cmd_teleport", Player[playerid].nickname.." телепортировал игрока "..Player[idfrom].nickname.." к "..Player[idto].nickname.." / ".._getRTime());
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255,"/тп (ид кого) (ид к кому).");
		end
	end

end
addCommandHandler({"/tp", "/тп"}, ToToTo);

function GScale(playerid, params)
	
	if Player[playerid].astatus > 0 then
		local result, id, x, y, z = sscanf(params, "dfff");
		if result == 1 then
			SetPlayerScale(id, x, y, z);
			SendPlayerMessage(id, 255, 255, 255, "Ваш размер изменен до x"..x.." y"..y.." z"..z)
			SendPlayerMessage(playerid, 255, 255, 255, "Размеры игрока "..GetPlayerName(id).." изменены до x"..x.." y"..y.." z"..z);
			LogString("Logs/Admins/cmd_size", Player[playerid].nickname.." изменил размеры игрока "..Player[id].nickname.." до x"..x.." y"..y.." z".." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/размер (ид) (x) (y) (z)");
		end
	end

end
addCommandHandler({"/size", "/размер"}, GScale)

function BeliarGreat(playerid, params)

	if Player[playerid].astatus > 0 then
		local result, id = sscanf(params, "d");
		if result == 1 then
			_offAC(id);
			SetPlayerHealth(id, 0);
			SavePlayer(id);
			SaveStats(id);
			SetTimerEx(_onAC, 2000, 0, id);
			SendPlayerMessage(id, 255, 255, 255, "Вас убило.") -- xDD
			SendPlayerMessage(playerid, 255, 255, 255, "Вы убили.") 
			LogString("Logs/Admins/cmd_kill", Player[playerid].nickname.." убил игрока "..GetPlayerName(id).." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/килл (ид)")
		end
	end

end
addCommandHandler({"/kill", "/килл"}, BeliarGreat);


function WhoIt(playerid)

	if Player[playerid].astatus > 2 then
		local fId = GetFocus(playerid);
		if fId ~= -1 then
			SendPlayerMessage(playerid, 255, 255, 255, "Ник персонажа в фокусе: "..Player[fId].nickname);
		end
		LogString("Logs/Admins/cmdWhoIt", Player[playerid].nickname.." проверил ник игрока "..Player[fId].nickname.." в своем фокусе / ".._getRTime());
	end

end
addCommandHandler({"/idf", "/идф"}, WhoIt);


function PlusMinusIMiOpyatIgraemVLybimih1(playerid, params)
	
	if Player[playerid].astatus > 2 then
		local result, h, m = sscanf(params, "dd");
		if result == 1 then
			SetTime(h, m);
			WHOUR = h;
			SendMessageToAll(137, 140, 140, "Установлено время: "..h..":"..m)
			LogString("Logs/Admins/cmd_time", GetPlayerName(playerid).." установил время на  "..h..":"..m.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/сеттайм (час) (минута)")
		end
	end

end
addCommandHandler({"/settime", "/сеттайм"}, PlusMinusIMiOpyatIgraemVLybimih1);

function _clearChatAll(id)

	if Player[id].astatus > 3 then
		for i = 0, GetMaxPlayers() do
			if Player[i].loggedIn == true then
				for p = 1, 30 do
					SendPlayerMessage(i, 0, 0, 0, " ");
				end
			end
			SendPlayerMessage(i, 255, 255, 255, "Администратор "..GetPlayerName(id).." очистил чат.");
			LogString("Logs/Admins/globalClearChat", Player[id].nickname.." очистил чат / ".._getRTime());
		end
	end

end
addCommandHandler({"/ачат"}, _clearChatAll);

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
			SendPlayerMessage(playerid, 255, 255, 255, "Точка создана с названием "..name.." ("..GetPlayerWorld(playerid).." / "..GetPlayerVirtualWorld(playerid)..").");
			LogString("Logs/Admins/createTPV", Player[playerid].nickname.." создал точку "..name.." / ".._getRTime());
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/стпв (название)")
		end
	end

end
addCommandHandler({"/stpv", "/стпв"}, CREATEBIGPOINTSONMAPNIGGER);

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
					SendPlayerMessage(id, 255, 255, 255, "Вы выдали "..rusname.." x"..amount.." игроку "..GetPlayerName(pid));
					SendPlayerMessage(pid, 255, 255, 255, "Вам выдано "..rusname.." x"..amount.." от "..GetPlayerName(id));
					LogString("Logs/Admins/cmd_item_name", Player[id].nickname.." выдал "..rusname.." в количестве "..amount.." игроку "..Player[pid].nickname.." / ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "Предмет не найден.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован или не найден.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/дать (ид) (кол-во) (название предмета)")
		end
	end

end
addCommandHandler({"/дать"}, _cmdRusGive);

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
				
				LogString("Logs/Admins/goTPV", Player[playerid].nickname.." телепортировался на точку "..name.." / ".._getRTime());
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Точка не найдена.");
				SendPlayerMessage(playerid, 255, 255, 255, "Названия всех существующих точек можно найти в списке админ.команд (см.дискорд)")
			end
		else
			SendPlayerMessage(playerid, 255, 255, 255, "/тпв (название)")
			SendPlayerMessage(playerid, 255, 255, 255, "Названия всех существующих точек можно найти в списке админ.команд (см.дискорд)")
		end
	end

end
addCommandHandler({"/tpv", "/тпв"}, GOTOCAPTUREITSGHETTOMFC);

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
									--SendPlayerMessage(i, 255, 255, 255, "Администратор "..GetPlayerName(id).." телепортировал вас.")
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
					
					SendPlayerMessage(v, 255, 255, 255, "Администратор "..GetPlayerName(id).." телепортировал вас.")
				end
					
				LogString("Logs/Admins/massTPV", Player[id].nickname.." сделал массовый телепорт на точку "..pname.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "Точка не найдена.");
			end
				
		else
			SendPlayerMessage(id, 255, 255, 255, "/мтпв (радиус) (точка)");
			
		end
	end
end
addCommandHandler({"/мтпв"}, _radiusTPV);

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
	        LogString("Logs/Admins/playMusic", Player[id].nickname.." запустил трек "..track.." в радиусе "..radius.." / ".._getRTime());
	    else
	        SendPlayerMessage(id, 255, 255, 255, "/музыка (название) (радиус)")
	    end
	end

end
addCommandHandler({"/музыка", "/musik"}, muzika_dlya_dushi);

