
--  #   Reg system by royclapton  #
--  #         version: 1.0        #

local regfon1 = CreateTexture(-31, -60, 8203, 8220, 'log_new')
local regfon2 = CreateTexture(6294, 2280, 8174, 6212, 'skin_new') 
local classfon1 = CreateTexture(4385, 2280, 8002, 6860, 'setClass')


reg_camera_pos1 = Vob.Create("none", "FULLWORLD2.ZEN", 11352, 1532.1318359375, -3376.5986328125);
reg_camera_pos1:SetRotation(0, 70, 0);

skin_camera_pos1 = Vob.Create("none", "FULLWORLD2.ZEN", 11352, 1532.1318359375, -3376.5986328125);
skin_camera_pos1:SetRotation(0, 70, 0);

function VobTimer(playerid)
	SetCameraBehindVob(playerid, reg_camera_pos1);
	SetTimerEx("camfrz", 1000, 0, playerid);
end

function VobTimerSkin(playerid)
	--SetPlayerPos(playerid, 5444.4819335938, 5448.87890625, 36172.70703125);
	SetPlayerAngle(playerid, 150);
	setCameraBeforePlayer(playerid, 20);
	SetTimerEx("camfrz", 800, 0, playerid);
end

function KillVobTimer(playerid)
	KillTimer(Player[playerid].vobtimer);
end

function camfrz(playerid)
	FreezeCamera(playerid, 0);
end

function ShowRegister(playerid)
	
	FreezePlayer(playerid, 1);
	Player[playerid].vobtimer = SetTimerEx("VobTimer", 1000, 0, playerid);
	ShowTexture(playerid, regfon1);
	ShowPlayerDraw(playerid, autonick);
	ShowPlayerDraw(playerid, autopass);
	SetCursorVisible(playerid, 1);

end


local treg;
function EnterPasswordReg(playerid, text)
	
	--[[
	if string.len(text) > 3 and not(string.find(string.lower(text), string.lower(" "))) then
		Player[playerid].rdy = true;
		treg = tostring(text);
		Player[playerid].enterreg = false;
		Player[playerid].password = treg;
		UpdatePlayerDraw(playerid, autopass, 3337, 4468, treg, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		HidePlayerDraw(playerid, reglogPODSKAZOCHKA);
	else
		GameTextForPlayer(playerid, 2485, 5580, "Подсказка: не менее 3 символов без пробелов.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 3000);
	end
	
	]]

end

function RegMouse(playerid, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[playerid].loggedIn == false then
				if posX > BUTTON_EXIT_REGLOG[1] and posX < BUTTON_EXIT_REGLOG[2] and posY > BUTTON_EXIT_REGLOG[3] and posY < BUTTON_EXIT_REGLOG[4] then
					ExitGame(playerid);
				end

				if posX > BUTTON_ENTER_REGLOG[1] and posX < BUTTON_ENTER_REGLOG[2] and posY > BUTTON_ENTER_REGLOG[3] and posY < BUTTON_ENTER_REGLOG[4] then
					if Player[playerid].enterreg == false and Player[playerid].rdy == true then
						HideTexture(playerid, regfon1);
						HidePlayerDraw(playerid, autonick);
						HidePlayerDraw(playerid, autopass);
						Player[playerid].loggedIn = true;
						Player[playerid].rdy = false;
						ClearInventory(playerid);
						print(" ");
						print(" ");
						print("==========================================");
						print("                REG_INFO					 ");
						print("   ",GetPlayerName(playerid),"register in server.");
						print("==========================================");
						print(" ");
						print(" ");
						FreezeCamera(playerid, 0);
						SetDefaultCamera(playerid);
						Player[playerid].steptwo = true;
						Player[playerid].defclick = Player[playerid].defclick + 1;
						SetCursorVisible(playerid, 0);
						StopPlayerSound(playerid, GO_LOG_SOUND);
						SetTimerEx("ShowSkin", 600, 0, playerid);
					end
				end
			end
		end
	end
end

function RandomSkin(playerid)

	local pol;
	local head = math.random(1, 7); local Hhead;
	local b1rnd = math.random(1,3);

	if b1rnd == 1 then
		pol = "Hum_Body_Naked0";
	elseif b1rnd == 2 then
		pol = "Hum_Body_Naked0";
	elseif b1rnd == 3 then
		pol = "Hum_Body_Babe0";
	end

	if head == 1 then
		Hhead = "Hum_Head_FatBald"
	elseif head == 2 then
		Hhead = "Hum_Head_Fighter";
	elseif head == 3 then
		Hhead = "Hum_Head_Pony";
	elseif head == 4 then
		Hhead = "Hum_Head_Bald";
	elseif head == 5 then
		Hhead = "Hum_Head_Thief";
	elseif head == 6 then
		Hhead = "Hum_Head_Psionic";
	elseif head == 7 then
		Hhead = "Hum_Head_Babe";
	end
	
	SetPlayerAdditionalVisual(playerid, pol, math.random(1, 100), Hhead, math.random(1, 300));

end

function ShowSkin(playerid)

	SetPlayerScale(playerid, 1, 1, 1);
	Player[playerid].steptwo = true;
	Player[playerid].vobtimer = SetTimerEx("VobTimerSkin", 200, 0, playerid);
	Freeze(playerid);
	LockShowChat(playerid, false);
	ShowTexture(playerid, regfon2);
	--RandomSkin(playerid);
	SetCursorVisible(playerid, 1);

end

function EndSkin(playerid)

	Player[playerid].steptwo = false;
	HideTexture(playerid, regfon2);
	Player[playerid].skin[1], Player[playerid].skin[2], Player[playerid].skin[3], Player[playerid].skin[4] = GetPlayerAdditionalVisual(playerid);
	EndClass (playerid);
	--ShowClass(playerid);

end


function EndClass(playerid)
	
	UnFreeze(playerid);
	FreezeCamera(playerid, 0);
	SetDefaultCamera(playerid);
	SetPlayerVirtualWorld(playerid, 0);
	SetCursorVisible(playerid, 0);
	Player[playerid].loggedIn = true;
	ShowChat(playerid, 1);

	SetTimerEx("AllSave", 1000, 0, playerid);
	
	Player[playerid].hOldHP = GetPlayerHealth(playerid);
	
end



function AllSave(playerid)
	
	SetPlayerWorld(playerid, "FULLWORLD2.ZEN");
	SetPlayerPos(playerid, 75629.71875, 3612.2917480469, -11347.44140625);
	SetPlayerAngle(playerid, 86);
	SetPlayerVirtualWorld(playerid, 999);
	SetDefaultCamera(playerid);

	Player[playerid].hpoints = 10;
	SavePlayer(playerid);

	Player[playerid].h1 = 0;
	Player[playerid].h2 = 0;
	Player[playerid].bow = 0;
	Player[playerid].cbow = 0;
	Player[playerid].hp = 300;
	Player[playerid].chp = 300;
	Player[playerid].mp = 0;
	Player[playerid].cmp = 0;
	Player[playerid].currenthp = 300;
	Player[playerid].str = 10;
	Player[playerid].dex = 10;
	Player[playerid].mag = 0;
	SaveStats(playerid);
	LoadStats(playerid);
	SaveItems(playerid);
	SaveSkill(playerid);

	Player[playerid].rpinventory = {"", "", "", "", "", "", "", "", "", ""};
	Player[playerid].rpinventory_amount = {" ", " ", " ", " ", " ", " ", " ", " ", " ", " "};
	SaveRPInv(playerid);
	SaveHunt(playerid);
	Player[playerid]._language_myrtana = 1; Player[playerid]._language_current = "MYRTANA";
	_saveLang(playerid);
	--_saveMac(playerid);
	--_saveMacNew(playerid);
	_saveFat(playerid);
	_saveTeam(playerid);

	InitDLPlayerInfo(playerid);
	SaveDLPlayerInfo(playerid);
    InitInvent(playerid);
	ShowPlayerDraw(playerid, Player[playerid].afkdraw);
	_saveWarn(playerid);

	_saveInfoPO(playerid);
	_craftSaveEXP(playerid);
	SetTimerEx(_onAC, 10000, 0, playerid);
	_saveZen(playerid);
	_saveInst(playerid);
	--if _saveEnergyNewAccount(playerid) == false then
		_saveEnergy(playerid);
	--else
	--	_readEnergy(playerid);
	--end
	_saveHud(playerid);
	_hudInit(playerid);
	_saveEquip(playerid);
	_saveTimeInGame(playerid);
	_saveNewSkills(playerid);
	
	if Player[playerid]._timeInGameTimer == nil then
		Player[playerid]._timeInGameTimer = SetTimerEx(_setTimerInGame, 1000, 1, playerid);
	end

	if WEATHER_NOW == "sun" then
		local weather = string.format("%s%s%s", "Погода: солнечная (",WEATHER_TEMP[WHOUR],")");
		UpdatePlayerDraw(playerid, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	elseif WEATHER_NOW == "rain" then
		local weather = string.format("%s%s%s", "Погода: дождь (",WEATHER_TEMP[WHOUR],")");
		UpdatePlayerDraw(playerid, weatherdraw, 165, 6598, weather, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

	PLAYERS_ACCOUNTS_COUNT = PLAYERS_ACCOUNTS_COUNT + 1;
	_saveAccounts()
	
	SendPlayerMessage(playerid, 77, 255, 127, "Благодарим за регистрацию! В данный момент вы находитесь в стартовой зоне.");
	SendPlayerMessage(playerid, 77, 255, 127, "Это НЕ игровая область игры, позволяющая решать нон-рп вопросы, общаться с администрацией и т.д");
	SendPlayerMessage(playerid, 77, 255, 127, "Вокруг вас стоят НПС, продающие различные товары за ОС (очки сюжета). У вас их 10.");
	SendPlayerMessage(playerid, 77, 255, 127, "Для ознакомления с базовой информацией: (ESC) > Википедия.");
	SendPlayerMessage(playerid, 77, 255, 127, "При проблемах с аккаунтом создавайте тикет в нашем дискорде или пост на форуме.");
	SendPlayerMessage(playerid, 77, 255, 127, "Когда закончите знакомство со стартовой зоной - ищите проводника и вперед!");
	
	SetPlayerEnableGMPMenu(playerid, 0);

end

function _saveAccounts()
	local file = io.open("Database/Players/CountAccounts.txt", "w");
	file:write(PLAYERS_ACCOUNTS_COUNT);
	file:close();
end

function _initAccounts()

	local file = io.open("Database/Players/CountAccounts.txt", "r");
	for line in file:lines() do
		local l, count = sscanf(line, "d");
		if l == 1 then
			PLAYERS_ACCOUNTS_COUNT = count;
		end
	end
	file:close();
	print(" ")
	print(" ----------------")
	print(" Accounts: "..PLAYERS_ACCOUNTS_COUNT);
	print(" ----------------")
	print(" ")

end



function SkinMouse(playerid, button, pressed, posX, posY)
	
	if button == MB_LEFT then
		if pressed == 0 then
		if Player[playerid].steptwo == true then
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_TYPE[1] and posX < BUTTON_LEFT_TYPE[2] and posY > BUTTON_LEFT_TYPE[3] and posY < BUTTON_LEFT_TYPE[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyM == "Hum_Body_Babe0" then
					bodyM = "Hum_Body_Naked0";
				elseif bodyM == "Hum_Body_Naked0" then
					bodyM = "Hum_Body_Babe0"
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_TYPE[1] and posX < BUTTON_RIGHT_TYPE[2] and posY > BUTTON_RIGHT_TYPE[3] and posY < BUTTON_RIGHT_TYPE[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyM == "Hum_Body_Babe0" then
					bodyM = "Hum_Body_Naked0";
				elseif bodyM == "Hum_Body_Naked0" then
					bodyM = "Hum_Body_Babe0"
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_BODY[1] and posX < BUTTON_LEFT_BODY[2] and posY > BUTTON_LEFT_BODY[3] and posY < BUTTON_LEFT_BODY[4] then

				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyT > 0 then
					bodyT = bodyT - 1;

				elseif bodyT == 0 then
					bodyT = 174;
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_BODY[1] and posX < BUTTON_RIGHT_BODY[2] and posY > BUTTON_RIGHT_BODY[3] and posY < BUTTON_RIGHT_BODY[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if bodyT < 174 then
					bodyT = bodyT + 1;
				else
					bodyT = 1
				end
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_HEAD[1] and posX < BUTTON_LEFT_HEAD[2] and posY > BUTTON_LEFT_HEAD[3] and posY < BUTTON_LEFT_HEAD[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);

				if headM == "Hum_Head_Fighter" then
					headM = "Hum_Head_FatBald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "Hum_Head_Pony" then
					headM = "Hum_Head_Fighter";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Bald" then
					headM = "Hum_Head_Pony";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Thief" then
					headM = "Hum_Head_Bald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			
				elseif headM == "Hum_Head_Psionic" then
					headM = "Hum_Head_Thief";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BABE7" then
					headM = "Hum_Head_Psionic";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT); 
				
				elseif headM == "HUM_HEAD_BABE12" then
					headM = "HUM_HEAD_BABE7";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BALD" then
					headM = "HUM_HEAD_BABE12";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD1" then
					headM = "HUM_HEAD_BALD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD2" then
					headM = "HUM_HEAD_BEARD1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD3" then
					headM = "HUM_HEAD_BEARD2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD4" then
					headM = "HUM_HEAD_BEARD3";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				--elseif headM == "HUM_HEAD_BEARDMAN" then
					--headM = "HUM_HEAD_BEARD4";
					--SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				--elseif headM == "HUM_HEAD_LONG" then
					--headM = "HUM_HEAD_BEARDMAN";
					--SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_SHEPHERD" then
					headM = "HUM_HEAD_LONG";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_LONGHAIR2" then
					headM = "HUM_HEAD_SHEPHERD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_FatBald" then
					headM = "HUM_HEAD_LONGHAIR2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_FatBald" then
					headM = "HUM_HEAD_MUSTACHE";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_DREADLOCKS" then
					headM = "Hum_Head_FatBald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_NORDBART_1" then
					headM = "HUM_HEAD_DREADLOCKS";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_NORDBART_2" then
					headM = "HUM_HEAD_NORDBART_1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_SACK" then
					headM = "HUM_HEAD_NORDBART_2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "Hum_Head_FatBald" then
					headM = "HUM_HEAD_SACK";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				end

			end
			
			if posX > BUTTON_RIGHT_HEAD[1] and posX < BUTTON_RIGHT_HEAD[2] and posY > BUTTON_RIGHT_HEAD[3] and posY < BUTTON_RIGHT_HEAD[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				if headM == "Hum_Head_FatBald" then
					headM = "Hum_Head_Fighter";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "Hum_Head_Fighter" then
					headM = "Hum_Head_Pony";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Pony" then
					headM = "Hum_Head_Bald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "Hum_Head_Bald" then
					headM = "Hum_Head_Thief";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			
				elseif headM == "Hum_Head_Thief" then
					headM = "Hum_Head_Psionic";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "Hum_Head_Psionic" then
					headM = "HUM_HEAD_BABE7";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT); 
				
				elseif headM == "HUM_HEAD_BABE7" then
					headM = "HUM_HEAD_BABE12";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BABE12" then
					headM = "HUM_HEAD_BALD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BALD" then
					headM = "HUM_HEAD_BEARD1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD1" then
					headM = "HUM_HEAD_BEARD2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_BEARD2" then
					headM = "HUM_HEAD_BEARD3";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_BEARD3" then
					headM = "HUM_HEAD_BEARD4";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				--elseif headM == "HUM_HEAD_BEARD4" then
					--headM = "HUM_HEAD_BEARDMAN";
					--SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				--elseif headM == "HUM_HEAD_BEARDMAN" then
					--headM = "HUM_HEAD_LONG";
					--SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
					
				elseif headM == "HUM_HEAD_LONG" then
					headM = "HUM_HEAD_SHEPHERD";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_SHEPHERD" then
					headM = "HUM_HEAD_LONGHAIR2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_LONGHAIR2" then
					headM = "HUM_HEAD_MUSTACHE";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				elseif headM == "HUM_HEAD_MUSTACHE" then
					headM = "HUM_HEAD_DREADLOCKS";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_DREADLOCKS" then
					headM = "HUM_HEAD_NORDBART_1";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_NORDBART_1" then
					headM = "HUM_HEAD_NORDBART_2";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_NORDBART_2" then
					headM = "HUM_HEAD_SACK";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);

				elseif headM == "HUM_HEAD_SACK" then
					headM = "Hum_Head_FatBald";
					SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
				
				end
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_LEFT_FACE[1] and posX < BUTTON_LEFT_FACE[2] and posY > BUTTON_LEFT_FACE[3] and posY < BUTTON_LEFT_FACE[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				headT = headT - 1;
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			
			if posX > BUTTON_RIGHT_FACE[1] and posX < BUTTON_RIGHT_FACE[2] and posY > BUTTON_RIGHT_FACE[3] and posY < BUTTON_RIGHT_FACE[4] then
				local bodyM, bodyT, headM, headT = GetPlayerAdditionalVisual(playerid);
				headT = headT + 1;
				SetPlayerAdditionalVisual(playerid, bodyM, bodyT, headM, headT);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_SKIN_FINISH[1] and posX < BUTTON_SKIN_FINISH[2] and posY > BUTTON_SKIN_FINISH[3] and posY < BUTTON_SKIN_FINISH[4] then
				EndSkin(playerid);
			end
			-------------------------------------------------------------------------
			if posX > BUTTON_SKIN_RANDOM[1] and posX < BUTTON_SKIN_RANDOM[2] and posY > BUTTON_SKIN_RANDOM[3] and posY < BUTTON_SKIN_RANDOM[4] then
				RandomSkin1(playerid);
			end
			-------------------------------------------------------------------------
		end
		end
	end

end