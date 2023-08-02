
--  #  Login system by royclapton  #
--  #          version: 1.0        #

local logmac = CreateTexture(6390, 6469, 8138, 6865, 'menu_ingame')
--local logfon1 = CreateTexture(6375, 2255, 8125, 6350, 'log') -- old
local logfon1 = CreateTexture(-31, -60, 8203, 8220, 'log_new')

log_camera_pos1 = Vob.Create("none", "FULLWORLD2.ZEN", 11352, 1532.1318359375, -3376.5986328125);
log_camera_pos1:SetRotation(0, 70, 0);

function LVobTimer(id)
	SetCameraBehindVob(id, log_camera_pos1);
	SetTimerEx("camfrz", 1000, 0, id);
end

function KillVobTimer(id)
	KillTimer(Player[id].vobtimer);
end

function camfrz(id)
	FreezeCamera(id, 0);
end

function ShowLogin(id)

	FreezePlayer(id, 1);
	Player[id].vobtimer = SetTimerEx("LVobTimer", 1000, 0, id);
	ShowTexture(id, logfon1);
	--ShowTexture(id, logmac);
	--ShowPlayerDraw(id, automac);
	ShowPlayerDraw(id, autonick);
	ShowPlayerDraw(id, autopass);
	SetCursorVisible(id, 1);
	Player[id].logconnect = false;
	
end

local tlog;
function EnterPasswordLog(id, text)

	--[[
	
	tlog = tostring(text);
	local name = GetPlayerName(id);

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt","r+");
	tempvar = file:read("*l"); 
	tempvar = file:read("*l"); 
	local result, passww = sscanf(tempvar,"s"); 
		if result == 1 then 
			Player[id].password = passww; 
		end
	file:close(); 


	if tlog == Player[id].password then
		Player[id].logconnect = true;
		Player[id].enterlog = false;
		HidePlayerDraw(id, reglogPODSKAZOCHKA);
		local ttext = string.format("%s","#*#*#*#*#*#*#*#*#*#*#"); -- string.reverse(text)
		UpdatePlayerDraw(id, autopass, 3337, 4468, ttext, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	else
		GameTextForPlayer(id, 3550, 5638, "Неверный пароль!", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
	end
]]

end

function logged(id)

	StopPlayerSound(id, GO_LOG_SOUND);

	SetPlayerScale(id, 1, 1, 1);
	ClearInventory(id);
	FreezeCamera(id, 0);
	FreezePlayer(id, 0);
	SetDefaultCamera(id);
	ShowChat(id, 1);
	

	ReadStats(id);
	LoadStats(id);
	
	_readEnergy(id);
	_readZen(id);
	ReadPlayer(id);
	_readInst(id);
	_readTeam(id);

	--_readEquip(id);
	ReadItems(id);
	SaveItems(id);

	ReadRPInv(id);
	ReadHunt(id);
	_readLang(id);
	ReadSkill(id);
	_readFat(id);
	_readNewSkills(id);

	SetCursorVisible(id, 0);
	Player[id].loggedIn = true;

	if Player[id].chp == 0 then
		SetPlayerHealth(id, 10);
		SaveStats(id);
	end
	
	InitDLPlayerInfo(id);
	InitInvent(id);
	_readHud(id);
	_hudInit(id);
	ShowPlayerDraw(id, Player[id].afkdraw);
	_readWarn(id);

	_saveInfoPO(id);
	_craftReadEXP(id);

	_readTimeInGame(id);

	Player[id]._timeInGameTimer = SetTimerEx(_setTimerInGame, 1000, 1, id);
	
	SetTimerEx(_onAC, 10000, 0, id);	

	if Player[id].meinfo ~= nil then
		SendPlayerMessage(id, 255, 255, 255, "Текущее описание: "..Player[id].meinfo);
	end

	if Player[id].hud_current == "player" then
		SendPlayerMessage(id, 255, 255, 255, "Загружен пользовательский HUD ("..Player[id].hud_texturename..").")
	else
		SendPlayerMessage(id, 255, 255, 255, "Загружен HUD # "..Player[id].hud_textures..".");
	end

	if WEATHER_NOW == "sun" then
		local weather = string.format("%s%s%s", "Погода: солнечная (",WEATHER_TEMP[WHOUR],")");
		UpdatePlayerDraw(id, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif WEATHER_NOW == "rain" then
		local weather = string.format("%s%s%s", "Погода: дождь (",WEATHER_TEMP[WHOUR],")");
		UpdatePlayerDraw(id, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

	if Player[id].astatus > 2 then
		_ac_chatInit(id);
		_showChat(id);
	end
	
	Player[id].hitmark = GetPlayerHealth(id);
	_updateHealth(id);

	if TEAM_CAPTURE == true then
		local tempteam = _getPlayerTeam(id);
		if (TEAM_FIGHTERS[1] == tempteam or TEAM_FIGHTERS[2] == tempteam) then
			Player[id].team_war_hud = true;
			ShowPlayerDraw(id, Player[id].hud_twar_draws[1])
			ShowPlayerDraw(id, Player[id].hud_twar_draws[2])
			ShowTexture(id, CAPTURE_TEX);
		end
	end

	if Player[id].chp < 30 then
		SendPlayerMessage(id, 255, 255, 255, "Включена невидимость от агрессивных монстров на 15 секунд.")
		AI_PlayerList[id].Invisible = true;
		SetTimerEx(_loAgr, 15000, 0, id);
	end

	SetPlayerEnableGMPMenu(id, 0);
	
	_checkStats(id);

end

function _loAgr(id)
	
	if AI_PlayerList[id].Invisible ~= nil then
		AI_PlayerList[id].Invisible = false;
		SendPlayerMessage(id, 255, 255, 255, "Теперь вы видимы для мобов.")
	end

end

function LogMouse(id, button, pressed, posX, posY)

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[id].loggedIn == false then

				if posX > BUTTON_EXIT_REGLOG[1] and posX < BUTTON_EXIT_REGLOG[2] and posY > BUTTON_EXIT_REGLOG[3] and posY < BUTTON_EXIT_REGLOG[4] then
					ExitGame(id);
				end

				if posX > BUTTON_ENTER_REGLOG[1] and posX < BUTTON_ENTER_REGLOG[2] and posY > BUTTON_ENTER_REGLOG[3] and posY < BUTTON_ENTER_REGLOG[4] then
					if Player[id].logconnect == true then
						Player[id].loggedIn = true;
						Player[id].logconnect = false;
						HideTexture(id, logfon1);
						--HideTexture(id, logmac);
						HidePlayerDraw(id, autonick);
						HidePlayerDraw(id, autopass);
						--HidePlayerDraw(id, automac);
						ClearInventory(id);
						logged(id);
						LogString("Logs/PlayersAll/login", GetPlayerName(id).." авторизовался по паролю / "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
					end
				end

				
				--if posX > 6390 and posX < 8138 and posY > 6469 and posY < 6865 then
				--	_logMAC(id);
				--end

			end
		end
	end
end

function _logMAC(id)

	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	local mac = _getMAC(id);
	local file = io.open("Database/Players/Macs/"..GetMacAddress(id), "r");
	if file then

		line = file:read("*l");
		local result, nickname = sscanf(line, "s");
		if result == 1 then
			if GetPlayerName(id) == nickname then

				local fileN = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt","r+");
				tempvar = fileN:read("*l"); 
				local result, name, passww = sscanf(tempvar,"ss"); 
					if result == 1 then 
						Player[id].password = passww; 
					end
				fileN:close(); 

				Player[id].enterlog = false;
				Player[id].loggedIn = true;
				Player[id].logconnect = false;
				HideTexture(id, logfon1);
				HideTexture(id, logmac);
				HidePlayerDraw(id, autonick);
				HidePlayerDraw(id, autopass);
				HidePlayerDraw(id, automac);
				ClearInventory(id);
				logged(id);
				LogString("Logs/PlayersAll/login", GetPlayerName(id).." авторизовался по маку / "..rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute);
			end
		end
	file:close();
	end

end







