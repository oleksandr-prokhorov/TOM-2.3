
--  #  Regeneration system by royclapton  #
--  #             version: 1.0            #

function _onBedConnect(id)
	Player[id]._useBed = false;
end

function _onBed(id, scheme, on, used)

	if scheme == "BED_FRONT" or scheme == "BED_BACK" then

		if used == 1 then

			Player[id]._useBed = true;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) <= hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы легли в кровать. Началась регенерация ХП.")
			end
			
			SaveStats(id);
			
		else

			Player[id]._useBed = false;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) <= hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы встали с кровати. Регенерация завершена.")
			end
			
			SaveStats(id);

		end

	end


	if scheme == "BEDHIGH_FRONT" or scheme == "BEDHIGH_BACK" then

		if used == 1 then

			Player[id]._useBed = true;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) <= hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы легли в кровать. Началась регенерация ХП.")
			end
			
			SaveStats(id);

		else

			Player[id]._useBed = false;
			local hpLimit = GetPlayerMaxHealth(id) / 2;
			if GetPlayerHealth(id) <= hpLimit then
				SendPlayerMessage(id, 255, 255, 255, "Вы встали с кровати. Регенерация завершена.")
			end
			
			SaveStats(id);

		end

	end


end

function _bedRegen()

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and GetPlayerHealth(i) > 0 then
			if Player[i]._useBed == true then
				if GetPlayerAnimationName(i) == "S_BED_FRONT_S1" or GetPlayerAnimationName(i) == "S_BEDHIGH_FRONT_S1"
					or GetPlayerAnimationName(i) == "S_BED_BACK_S1" or GetPlayerAnimationName(i) == "S_BEDHIGH_BACK_S1" then
					
					local maxHp = GetPlayerMaxHealth(i);
					local hpForm = (maxHp / 100) * 2;
					local hpLimit = maxHp / 2;
				
					if GetPlayerHealth(i) < hpLimit then
						SetPlayerHealth(i, GetPlayerHealth(i) + hpForm);
						if GetPlayerHealth(i) > maxHp then
							SetPlayerMaxHealth(i, maxHp);
						end
						SaveStats(i);
						SavePlayer(i);
					end
						
				end
			end
		end
	end

end
SetTimer(_bedRegen, 10000, 1);