
TIME_FOR_RESTART_BLOCK = false;
function _regularCheckBlock()
	
	time = os.date('*t');

	if time.hour == 4 then
		if time.min == 7 then
			if TIME_FOR_RESTART_BLOCK == false then

				TIME_FOR_RESTART_BLOCK = true;
				------------------------------------------------------------------------------------
				preENERGY_BLOCK = {}; local file = io.open("Blocks/preENERGY.txt", "w+"); file:close();
				MANA_BLOCK = {}; local file = io.open("Blocks/MANA.txt", "w+"); file:close();
				TRAINING_BLOCK = {}; local file = io.open("Blocks/STATS.txt", "w+"); file:close();
				ENERGY_BLOCK = {}; local file = io.open("Blocks/ENERGY.txt", "w+"); file:close();
				local file = io.open("Blocks/Workers.txt", "w+"); file:close();
				------------------------------------------------------------------------------------
				TEAM_BOTS_LIST = {}; local file = io.open("Database/Team/zones_bonus.txt", "w"); file:close();
				for i = 1, TZONES_AMOUNT do
					TZONES[i].try = 2;
				end
				for i = 1, 200 do
					TEAM[i].cancapture = 3;
				end
				------------------------------------------------------------------------------------
				SendMessageToAll(242, 255, 0, "Тренировки вновь доступны.")
				SetTimer(_unlockCheckBlock, 90000, 0);

				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						Player[i].energyblock = 0;
						SavePlayer(i);
					end
				end

			end
		end
	end

end
SetTimer(_regularCheckBlock, 2000, 1);

function _unlockCheckBlock()
	TIME_FOR_RESTART_BLOCK = false;
end