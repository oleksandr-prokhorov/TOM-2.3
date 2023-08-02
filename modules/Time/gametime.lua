
timebc = CreateTexture(6855, 7225, 8215, 8193, 'TOM_ARCHOLO_INGAME')

GAME_DATE = {1, 1, 1000};
GAME_DATE_STOP = false;

function _initGameDate()

	local file = io.open("Database/City/Time.txt", "r");
	if file then

		line = file:read("*l")
		local pos, day, month, year = sscanf(line, "ddd"); 
		if pos == 1 then
			GAME_DATE = {day, month, year}
		end

		file:close();
	end

	print(" ");
	print(" Game Date: "..GAME_DATE[1].."."..GAME_DATE[2].."."..GAME_DATE[3])

end

function _saveGameDate()

	local file = io.open("Database/City/Time.txt", "w");
	file:write(GAME_DATE[1].." "..GAME_DATE[2].." "..GAME_DATE[3])
	file:close();

end

function TTable(playerid)

	ShowPlayerDraw(playerid, gtdraw);
	ShowPlayerDraw(playerid, rtdraw);
	ShowPlayerDraw(playerid, datedraw);
	ShowTexture(playerid, timebc);

end

function UpdateTTable(playerid)

	-- game
	local hour, minute = GetTime();
    local gh = string.format("%02d",hour);
    local gm = string.format("%02d",minute);
    local gt = "GT: "..gh..":"..gm.." / "..GAME_DATE[1].."."..GAME_DATE[2].."."..GAME_DATE[3];
	UpdatePlayerDraw(playerid, gtdraw, 165, 6808, gt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- real time/date
	time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local rt = "RT: "..rhour..":"..rminute.." / "..rday.."."..rmonth.."."..ryear;
	UpdatePlayerDraw(playerid, rtdraw, 165, 7018, rt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	if GAME_DATE_STOP == false then
		if hour == 0 or hour == 24 then
			GAME_DATE[1] = GAME_DATE[1] + 1;
			if GAME_DATE[1] == 31 then
				GAME_DATE[1] = 1;
				GAME_DATE[2] = GAME_DATE[2] + 1;
			end
			if GAME_DATE[2] == 13 then
				GAME_DATE[2] = 1;
				GAME_DATE[3] = GAME_DATE[3] + 1;
			end
			GAME_DATE_STOP = true;
			SetTimer(_resetDateStop, 1200000, 0);
			_saveGameDate();
		end
	end
	
end

function _resetDateStop()
	GAME_DATE_STOP = false;
end