
--  #  Weather system by royclapton #
--  #         version: 1.0          #

WHOUR = 12;
WEATHER_REPEAT = {};
WEATHER_TEMP = {};
WEATHER_CURRENT_TEMP = 0;
WEATHER_NOW = "sun";
function _initWeather()
	
	for i = 1, 24 do

		local random_weather = math.random(0, 100);
		for i = 1, math.random(3, 10) do
			random_weather = math.random(0, 100);
		end

		if random_weather < 5 then

			if i ~= 12 and i ~= 11 and i ~= 13 then
				table.insert(WEATHER_REPEAT, "rain");
			else
				table.insert(WEATHER_REPEAT, "sun");
			end

			if i > 0 and i < 7 then
				local rnd = math.random(5, 9); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 6 and i < 12 then
				local rnd = math.random(9, 14); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 11 and i < 20 then
				local rnd = math.random(14, 16); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 19 and i < 25 then
				local rnd = math.random(11, 13); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);
			end

		elseif random_weather >= 5 then
			table.insert(WEATHER_REPEAT, "sun");

			if i > 0 and i < 7 then
				local rnd = math.random(7, 10); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 6 and i < 12 then
				local rnd = math.random(10, 16); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 11 and i < 20 then
				local rnd = math.random(16, 20); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);

			elseif i > 19 and i < 25 then
				local rnd = math.random(14, 16); local txt = tostring(rnd).."t.";
				table.insert(WEATHER_TEMP, txt);
			end

		end
	end

	print(" ");
	print("Init weather. List:")
	for i = 1, table.getn(WEATHER_REPEAT) do
		print(WEATHER_REPEAT[i].." / hour: "..i.." / temp: "..WEATHER_TEMP[i]);
	end
	print(" ");


end

function _regularWeather()
	
	local h, m = GetTime();
	WEATHER_CURRENT_TEMP = WEATHER_TEMP[h];
	if h ~= WHOUR then
		if WEATHER_REPEAT[h] == "sun" then
			--SetWeather(0, 0, h, 0, h + 1, 0);
			WHOUR = WHOUR + 1;
			if WHOUR == 25 then
				WHOUR = 0;
			end
			WEATHER_NOW = "sun";
			for i = 0, GetMaxPlayers() do
				if Player[i].loggedIn == true then
					local weather = string.format("%s%s%s", "Погода: солнечная (",WEATHER_TEMP[h],")");
					UpdatePlayerDraw(i, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end
			end
			
		elseif WEATHER_REPEAT[h] == "rain" then
			if h ~= 12 then
				SetWeather(WEATHER_RAIN, 1, h, 0, h + 1, 0);
				WHOUR = WHOUR + 1;
				if WHOUR == 25 then
					WHOUR = 0;
				end
				WEATHER_CURRENT_TEMP = WEATHER_TEMP[h];
				WEATHER_NOW = "rain";
				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						local weather = string.format("%s%s%s", "Погода: дождь (",WEATHER_TEMP[h],")");
						UpdatePlayerDraw(i, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					end
				end
			else
				--SetWeather(0, 0, h, 0, h + 1, 0);
				WHOUR = WHOUR + 1;
				if WHOUR == 25 then
					WHOUR = 0;
				end
				WEATHER_CURRENT_TEMP = WEATHER_TEMP[h];
				WEATHER_NOW = "sun";
				for i = 0, GetMaxPlayers() do
					if Player[i].loggedIn == true then
						local weather = string.format("%s%s%s", "Погода: солнечная (",WEATHER_TEMP[h],")");
						UpdatePlayerDraw(i, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					end
				end
			end
		end
	end

end
SetTimer(_regularWeather, 10000, 1);