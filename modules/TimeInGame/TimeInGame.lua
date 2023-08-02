
function _timeInGameConnect(id)
	
	Player[id]._timeInGameNow = {0, 0, 0}; -- сессия игрока
	Player[id]._timeInGame = {0, 0, 0}; -- общее время.
	Player[id]._timeInGameTimer = nil;

end

function _setTimerInGame(id)

	if Player[id].loggedIn == true then
		if Player[id]._timeInGameTimer ~= nil then

			--------------------------------------------------------------------

			Player[id]._timeInGameNow[3] = Player[id]._timeInGameNow[3] + 1;

			if Player[id]._timeInGameNow[3] == 60 then
				Player[id]._timeInGameNow[3] = 0;
				Player[id]._timeInGameNow[2] = Player[id]._timeInGameNow[2] + 1;
			end

			if Player[id]._timeInGameNow[2] == 60 then
				Player[id]._timeInGameNow[2] = 0;
				Player[id]._timeInGameNow[1] = Player[id]._timeInGameNow[1] + 1;
			end

			--------------------------------------------------------------------

			Player[id]._timeInGame[3] = Player[id]._timeInGame[3] + 1;

			if Player[id]._timeInGame[3] == 60 then
				Player[id]._timeInGame[3] = 0;
				Player[id]._timeInGame[2] = Player[id]._timeInGame[2] + 1;
			end

			if Player[id]._timeInGame[2] == 60 then
				Player[id]._timeInGame[2] = 0;
				Player[id]._timeInGame[1] = Player[id]._timeInGame[1] + 1;
			end

			--------------------------------------------------------------------
			_saveTimeInGame(id);
		end
	end
end


function _saveTimeInGame(id)

	local file = io.open("Database/Players/Profiles/TimeInGame/"..Player[id].nickname..".txt", "w");
	file:write(Player[id]._timeInGame[1].." "..Player[id]._timeInGame[2].." "..Player[id]._timeInGame[3]);
	file:close();

end

function _readTimeInGame(id)

	local file = io.open("Database/Players/Profiles/TimeInGame/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local l, t1, t2, t3 = sscanf(line, "ddd");
		if l == 1 then
			Player[id]._timeInGame = {t1, t2, t3};
		end

		file:close();

	else
		_saveTimeInGame(id);
	end

end

function _myTime(id)
	if Player[id].loggedIn == true then
		SendPlayerMessage(id, 255, 253, 117, "(Глобальное) Вы провели "..Player[id]._timeInGame[1].." часов, "..Player[id]._timeInGame[2].." минуты, "..Player[id]._timeInGame[3].." секунды на сервере.")
		SendPlayerMessage(id, 255, 253, 117, "(Сессия) Вы провели "..Player[id]._timeInGameNow[1].." часов, "..Player[id]._timeInGameNow[2].." минуты, "..Player[id]._timeInGameNow[3].." секунды на сервере.")
	end
end
addCommandHandler({"/моевремя"}, _myTime);