function random(arg)
	return math.random(arg);
end

function Freeze(arg)
	return FreezePlayer(arg, 1);
end

function UnFreeze(arg)
	return FreezePlayer(arg, 0);
end

-- vars
require "gamemodes/global_var"

-- Bimbol
require "Bimbol Engine/require"
gui_Init(true);
ai_Init(true);

-- Stats info
require "modules/additional_stats"
require "modules/LogCraft/log_craft"

-- Reg/Log
require "modules/Registration/Registration"
require "modules/Login/Login"

-- Player
require "modules/Player/PlayerScructure"
require "modules/Player/ButtonsXYZ"
require "modules/Player/draws"

-- Saves
require "modules/Saves/SavePlayer"
require "modules/Saves/SaveStats"
require "modules/Saves/SaveItems"
require "modules/Saves/SaveSkill"

-- CMDs
require "modules/CMDs/cmds"
require "modules/CMDs/cmdschats"
require "modules/CMDs/cmdsadmin"
require "modules/CMDs/cmdsadmin2"
require "modules/CMDs/inst"
require "modules/CMDs/anims"


-- Time
require "modules/Time/gametime"

-- Bots
require "modules/Bots/CreateBots"
require "modules/Bots/Bots"
require "modules/Bots/OBDialogs"

-- Mine
require "modules/Mine/mine"
require "modules/Mine/sheeps"
require "modules/Mine/fishing"

-- Energy
require "modules/Energy/energy"

-- Arena
require "modules/Stats Up/statsup"

-- Craft
require "modules/Craft/minecraft"

-- RPINV
require "modules/Inventory RP/rpinventory_dis"

-- Anim Bots
require "modules/AnimBot/setanimbot"

-- AI Bots
require "modules/Bots/BE_Bots"

-- Hunting
require "modules/Hunting/Hunting"

-- Thief
require "modules/Thief/Thief"

-- Board
require "modules/Board/Board"

-- Handscript
require "modules/Handscript_Inventory/handscript"
require "modules/Handscript_Inventory/inventory"

-- Admin logs
require "modules/Logs/a_logs"

-- Zones
require "modules/Zones/zones"

-- Map (Osmith)
require "modules/Map/map"

-- Games
require "modules/Games/game_21"
require "modules/Games/poker"

-- Regeneration HP (bed)
require "modules/Regeneration/Regeneration"

-- Language
require "modules/Language/Language"

-- Skinset
require "modules/Skinset/skinset"

-- Traders
require "modules/Traders/Traders"

-- Hud
require "modules/Hud/Hud"

-- Wiki
require "modules/Wiki/Wiki"

-- Mac
require "modules/Mac/Mac"

-- Hero info
require "modules/Hero Info/Hero Info"

-- Players info
require "modules/Players info/Players info"

-- Warn
require "modules/Warn/Warn"

-- Info about player
require "modules/Info/Info"

-- Heroes
require "modules/Hero/Hero"

-- Animation on chat
require "modules/AnimText/AnimText"

-- Workers
require "modules/Workers/Workers"

-- AC
require "modules/Anti-cheat/ac_items"
require "modules/Anti-cheat/ac_att"

-- Chest
require "modules/Chest/Chest"

-- City
require "modules/City/city"

-- Way
require "modules/Bots/way"

-- Weather
require "modules/Weather/Weather"

-- WeaponMode
require "modules/WeaponMode/WeaponMode"

-- TimeInGame
require "modules/TimeInGame/TimeInGame"

-- AdminChat
require "modules/AChat/AChat"

-- mainclain bots
local npc_module = require "modules/npc_module/npc_module"
require "modules/npc_module/npc_drop"

-- vobber
require "modules/Vobber/Vobber"

-- Achievements
require "modules/Achievements/Achievements"

-- Book
require "modules/Book/Book"

-- AutoRestart
require "modules/AutoRestart/AutoRestart"

-- Ship
require "modules/Ship/Ship"
require "modules/Ship/ShipItems"

-- Discord-bot
require "modules/Discord-bot/Online"
require "modules/Discord-bot/SendMessage"
require "modules/Discord-bot/Kick"
require "modules/Discord-bot/chekerPlayers"

-- Team
require "modules/Team/Team"

-- World Containers
require "modules/WorldContainer/WorldContainer"

-- RangeInFight
require "modules/RangeInFight/RangeInFight"

-- House system
require "modules/House/House"

-- Daily Routine
require "modules/Daily Routine/Daily Routine"

-- rcg
require "modules/royclapton_GUARD/rcg"

-- Talents
require "modules/Talents/Talents"

-- Травка ебать на карте ресурсы которые
local world_items_module = require "modules/world_items_module/world_items_module"

-- Buttons
require "modules/Buttons/buttons_system"

-- GMPMenu
require "modules/GMPMenu/GMPMenu"

--#################################################

function ClearChat(id)
	for i = 0, 50 do
		SendPlayerMessage(id, 1, 1, 1, " ");
	end
end
addCommandHandler({"/clear", "/очистить"}, ClearChat);

function _saverPlayers()

	-- Периодический сейвер всех подключенных игроков.
	-- by royclapton

	local time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local count = 0; local tempArr = {};
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 and IsNPC(i) == 0 and GetPlayerInstance(i) == "PC_HERO" then
			count = count + 1; table.insert(tempArr, Player[i].nickname);
			SavePlayer(i);
			SaveStats(i);
			_doubleSaveStats(i);
			SaveItems(i);
		end
	end

	if table.getn(tempArr) > 0 then
		LogString("Logs/Server/Saves", "Все подключенные аккаунты сохранены. Список аккаунтов: "..count);
		LogString("Logs/Server/Saves", "Дата: ("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."). Список игроков:");
		for _, v in pairs(tempArr) do
			LogString("Logs/Server/Saves", v);
		end
	end

end


PLAYERS_ACCOUNTS_COUNT = 0;

require "server_description";
function BE_OnGamemodeInit()

	EnableChat(0); -- глобальное использование чата
	OpenLocks(0); -- открыть закрытое (двери, сундуки). НА ЗАПУСКЕ ПОМЕНЯТЬ НА 0 !!!
	Enable_OnPlayerKey(1); -- функция, включающая использование кнопок через OnPlayerKey
	EnableExitGame(0); -- вкл/выкл выхода через ESC
	EnableNickname(1); -- ники над головами.
	EnableNicknameID(0); -- айдишники в нике

	SetGamemodeName("RCE RP 2.3"); -- игровой мод

	-- нпс
	OtherNPC();
	NCInit();

	-- мобы
	--InitMobs();
	--SpawnMobs();
	--_readNewBots();

	npc_module.OnGamemodeInit();

	-- крафты?
	InitCraftList();

	-- доски
	_initBoard();

	-- handscript / inv
	InitInventTexture();
	InitHandscripts();

	-- osmith map
	_InitMap();
	
	-- traders
	_initTraders();
	
	-- hunting timer
	SetTimer(_timerHunting, 2000, 1);

	-- wiki
	_wikiInit();

	-- mac
	_macForumInit();

	-- sheeps
	_sheepsSpawn();

	-- blocks
	_initBlocks();

	-- saver
	SetTimer(_saverPlayers, 600000, 1);

	-- heroes
	_heroInit();

	-- workers
	_initWorkers();

	-- chests
	_initChest();
	
	-- poker
	_poker_textureSlots();
	
	-- energy
	_initEnergy();

	-- city
	_initCity();
	_initBanya();

	-- way
	_initWay();

	-- weather
	_initWeather();

	-- game date
	_initGameDate();

	-- vobs
	_vobberInit();

	-- accounts
	_initAccounts();
	
	-- ONLINE DISCORD BOT
	_updateOnlineForDiscord();

	print("Discord-bot: Online load")
	print("Discord-bot: SendMessage load")
	print("Discord-bot: Kick load")
	

	-- Ship
	--_initShip();

	-- Team
	_teamInit();

	-- WC
	_worldContainerInit();
	
	-- house
	_houseInit()

	-- DR
	_dailyRoutineInit();
	
	-- RC_GUARD
	_royclaptonGuard();
	
	-- травка
	world_items_module.OnGamemodeInit();

	-- кнопки
	_initButton();

end

ai_Init(true);


function OnPlayerTriggerMob(id, scheme, objectName, trigger)
	_board(id, scheme, objectName, trigger);
	_onBed(id, scheme, objectName, trigger);
	_useChest(id, scheme, objectName, trigger);
end

function OnPlayerResponseItem(id, slot, itemInstance, amount, equipped)
	
	
	if Player[id].itemsid == true then
		if itemInstance ~= "NULL" then
			SendPlayerMessage(id, 255, 255, 255, "#"..slot.." "..GetItemName(itemInstance).." / Кол-во: "..amount);
		end
	end
	
	
	
	_teamResponse(id, slot, itemInstance, amount, equipped)
	_tradersResponse(id, slot, itemInstance, amount, equipped);
	_ac_Response(id, slot, itemInstance, amount, equipped);

	if Player[id].drop == true and Player[id].chest_id == 0 then
		DropItem(id, itemInstance, Player[id].amounts);
		Player[id].drop = false;
	end
	
	itemInstance = string.upper(itemInstance);

	if Player[id]._checkInv == true then
		if Player[id]._checkInvItem ~= nil then
			if itemInstance == Player[id]._checkInvItem then
				if amount > 100 then
					local ndrop = amount - 100;
					DropItem(id, Player[id]._checkInvItem, ndrop);
					Player[id]._checkInv = false;
					Player[id]._checkInvItem = nil;
				end
			end
		else	
			if slot > 15 then
				DropItem(id, itemInstance, amount);
			end
		end
	end

end


function LockShowChat(id, toggle)

	if toggle == true then
		Player[id].showchat = true;
		ShowChat(id, 1);
	else
		Player[id].showchat = false;
		ShowChat(id, 0);
	end

end


function LoadingLogin(id)

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt", "r+");
	if file then
		Player[id].timerconnect = SetTimerEx("SL", 2000, 0, id);
		--ShowPlayerDraw(id, reglogPODSKAZOCHKA);
		file:close();
	else
		Player[id].timerconnect = SetTimerEx("SR", 2000, 0, id);
		--ShowPlayerDraw(id, reglogPODSKAZOCHKA);
	end

end

function OnPlayerOpenInventory(id)

	_ac_openInventory(id);

	if Player[id].chest_id ~= 0 then
		CloseInventory(id);
	end

	if Player[id].onGUI == true then
		CloseInventory(id);
	end
	
	if Player[id]._trader_menu == true then
		CloseInventory(id);
	end

	if Player[id]._gmpMenu == true then
		CloseInventory(id);
	end

end


function OnPlayerMD5File(id, pathFile, hash)
	if pathFile == "Data\\GO_Anims.VDF" then
		if hash ~= "6b8ff68eb96ffa4e6205eedf2678c8aa" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Anims.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end

	elseif pathFile == "Data\\GO_Meshes.VDF" then
		if hash ~= "be80b5729d836cc32213a60e801c3171" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Meshes.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end

	elseif pathFile == "Data\\GO_Scripts.VDF" then
		if hash ~= "b675585ba83b9c7bd1d526020a39b7b4" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Scripts.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end

	elseif pathFile == "Data\\GO_Sound.VDF" then
		if hash ~= "a1f04fa49886da2cfe27dfb88cc5fbac" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Sound.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end

	elseif pathFile == "Data\\GO_Textures.VDF" then
		if hash ~= "a918f92d8b20fe4223e2c8adca0f7d29" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Textures.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end

	elseif pathFile == "Data\\GO_Worlds.VDF" then
		if hash ~= "08785c729479e95cdd4b1fd6f04389cf" then
			ShowChat(id, 1);
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Обнаружен некорректная версия файла 'GO_Worlds.VDF'.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Пожалуйста, скачайте свежую версию игрового ресурс-пака.")
			SendPlayerMessage(id, 255, 255, 255, "(SERVER) Ссылка: gothic2online.ru")
			Kick(id);
		end
	end
end


bad_symbols = {"1", "2", "3,", "4", "5", "6", "7", "8", "9", "0", "?", '"'}
function BE_OnPlayerConnect(id)
	
	-- Hitmark
	Player[id].hitmark = 0;
	if IsNPC(id) == 0 then
		
		_checkNickname(id);
		_checkMacNew(id);
	
		local name = GetPlayerName(id);
		local result = string.find(name, "");
		
		if name == "Nickname" then
			SendPlayerMessage(id, 255, 255, 255, "Данный никнейм запрещен.");
			Kick(id);
		end

			for _, v in pairs(bad_symbols) do
				if string.find(name, v) then
					SendPlayerMessage(id, 255, 255, 255, "Обнаружены запрещенные символы в нике.")
					Kick(id);
					break
				end
			end
					
			EnablePlayerPlayerlist(id, 0)

			GetMD5File(id, "Data\\GO_Anims.VDF");
			GetMD5File(id, "Data\\GO_Meshes.VDF");
			GetMD5File(id, "Data\\GO_Scripts.VDF");
			GetMD5File(id, "Data\\GO_Textures.VDF");
			GetMD5File(id, "Data\\GO_Worlds.VDF");

			_playersInfoCheckConnectsDisconnects(id);
			SetPlayerInstance(id, "PC_HERO")
			SetPlayerWorld(id, "FULLWORLD2.ZEN")
			SetPlayerVirtualWorld(id, math.random(200, 800));

			_buttonsConnect(id);
			_gmpMenuConnect(id);

			Player[id]._globalMenu = 0;

			AI_SetPlayer(id);

			Player[id].skinset = false;

			Player[id].colorf5 = {255, 255, 255}

			-- Ship
			_shipConnect(id);
			
			Player[id].abuz = false;
			
			-- Team
			_teamConnect(id);

			-- WC
			_worldContainerConnect(id);
			
			-- Talents
			_talentsConnect(id);
			
			_debuffConnect(id);
			
			Player[id].itemsid = false;

			-- Warn
			Player[id].warns = 0;

			-- AFK
			Player[id].afk = false;
			Player[id].afkdraw = CreatePlayerDraw(id, 0, 0, "");

			-- hand-inv
			Player[id].onGUI = false;

			-- fat
			Player[id].fatness = 0.0;

			-- info_me
			Player[id].meinfo = " ";
			Player[id].medraw = nil; Player[id].medraw = CreatePlayerDraw(id, 0, 0, "");
			Player[id].namedraw = nil; Player[id].namedraw = CreatePlayerDraw(id, 0, 0, "");
			
			-- PM
			Player[id].blockpm = false;
			Player[id].stalkerpm = false;

			-- admin chat
			Player[id].adminchat = true;
			
			-- trainman
			Player[id].manamenu = 0;
			
			Player[id]._inputID = 0;
		
			-- vobber
			_vobberConnect(id);

			-- mass draws
			DrawInit(id);
					
			-- board
			_boardPlayer(id);

			-- time in game
			_timeInGameConnect(id);
			
			-- map osmith
			_playerMap(id);

			-- craft log
			_logVar(id);

			-- use bed for regen
			_onBedConnect(id);
	
			Player[id]._checkInv = false;
			Player[id]._checkInvItem = nil;
		
		
			-- traders
			_tradersConnect(id);

			-- languages
			_languageConnect(id);
			
			-- house
			_houseConnect(id);

			-- hunting
			_huntingConnect(id);
			
			-- invise attack
			Player[id].invise_attack = false;

			-- hud
			_hudConnect(id);

			-- book
			Player[id].book = nil;

			-- games
			_21game_var(id);
			_pokerConnect(id);

			-- wiki
			_wikiConnect(id);

			-- sheep
			_sheepConnect(id);
			
			-- hero info
			_heroInfoConnect(id);

			-- rost
			Player[id].rost = 1;
			
			-- players info
			_playersInfoConnect(id);

			-- hero-system
			_aHeroConnect(id);

			-- enable nickname
			Player[id].tnickname = false;
			EnablePlayerNickname(id, 1);

			-- discord
			Player[id].candiscord = 1;
			Player[id].discord = "NULL";

			-- equip
			Player[id].emelee = nil;
			Player[id].earmor = nil;
			Player[id].erange = nil;
			Player[id].ehelmet = nil;

			-- Craft Levels
			_craftExpSkillConnect(id);

			-- Workers
			_workersConnect(id);

			-- AC
			_ac_connect(id);
			_ac_att_connect(id);

			-- chests
			_chestConnect(id);

			-- new stats
			_newStatsConnect(id);	

			-- assist
			_assistConnect(id);

			-- weaponmode
			_weaponModeConnect(id);

			-- exitf8
			Player[id].exitf8 = {false, nil};

			-- for player-orc
			Player[id].areorc = 0;

			-- stats_menu
			Player[id].statsmenu = 0;

			-- inst
			Player[id].IsInstance = false;

			-- mine
			Player[id].zero_size_f = 3017;
			Player[id].start_size_f = 5191;
			Player[id].current_size_f = 5191;
			Player[id].prog_background_f = CreateTexture(2565, 7045, 5619, 7625, 'PROGRESS_BLUE')
			Player[id].prog_f = CreateTexture(3007, 7283, Player[id].start_size_f, 7469, 'PROGRESS_BLUE_BAR')
			Player[id].prog_timer = nil;

			-- rp inventory #1
			Player[id].openinv = false;
			Player[id].rpinventory = {};
			Player[id].rpinventory_amount = {};
			Player[id].rpinventory_slot = nil;
			Player[id].rpinventory_final = false;

			-- skills
			Player[id].readscrolls = 0;

			-- Bot_AI
			Player[id].inviseforbots = false;

			-- mask
			Player[id].masked = false;

			-- admin
			Player[id].invise = false;

			-- tag
			Player[id].zvanie = nil;

			-- res
			Player[id].mine = 0;
			Player[id].wood = 0;
			Player[id].iron = 0;

			-- cur. zone
			Player[id].zone = {false, false};
		
			-- energy(stamina) -- полоска
			Player[id].energy = 100;
			Player[id].energyblock = 0;
			Player[id].energydate = 0;
			Player[id].energybar = {};
			Player[id].energybar_x = 1099;
			Player[id].energybar[1] = CreateTexture(74, 7592, Player[id].energybar_x, 7809, 'BAR1');
			Player[id].eBar = false;

			-- xz.
			Player[id].openstatspanel = false;

			-- craft #1 - старое
			Player[id].opencraft = false;
			Player[id].craftpage = 0;
			Player[id].selectcraftitem = 0;
			Player[id].craftlevel = {1, 2, 3}; -- [1] - smith, [2] - alchemy, [3] - wood
			Player[id].craftexp = {0, 0, 0};

			-- craft #2 
			Player[id].nEXP = 0;

			-- player
			Player[id].nickname = GetPlayerName(id);
			Player[id].password = "";
			Player[id].astatus = 0;
			Player[id].loggedIn = false;
			Player[id].lastplay_data = "";
			Player[id].overlay = "";
			Player[id].skin = {};


			-- money
			Player[id].hpoints = 0;
			Player[id].gold = 0;

			-- stats
			Player[id].h1 = 0;
			Player[id].h2 = 0;
			Player[id].bow = 0;
			Player[id].cbow = 0;
			Player[id].hp = 300;
			Player[id].chp = 300;
			Player[id].mp = 0;
			Player[id].cmp = 0;
			Player[id].currenthp = 300;
			Player[id].str = 10;
			Player[id].dex = 10;
			Player[id].mag = 0;
			
			-- other
			Player[id].menuopen = 0;
			Player[id].showchat = true;
			Player[id].vobtimer = nil;
			Player[id].enterreg = false;
			Player[id].enterlog = false;
			Player[id].logconnect = false;
			Player[id].rdy = false;
			Player[id].stepone = false;
			Player[id].steptwo = false;
			Player[id].stepthree = false;
			Player[id].regclass = 0;
			Player[id].animtimer = nil;
			Player[id].defclick = 0;
			Player[id].dlg = false;
			Player[id].campos = 0;
			Player[id].statsmenu = false;
			Player[id].hOldHP = 10;

			-- food
			Player[id].food = 100;

			SetTimerEx("LoadingLogin", 3000, 0, id);
			SpawnPlayer(id);
			LockShowChat(id, false); 
			ShowChat(id, 0);
			SendPlayerMessage(id, 255, 255, 255, "Приветствуем вас на сервере Gothic Online");
			SendPlayerMessage(id, 255, 255, 255, "Игровое вики доступно по нажатию клавиши 'Ф7'.");
			SendPlayerMessage(id, 249, 255, 135, "Актуальная версия игрового мода - RCE RP 2.3");
			SendPlayerMessage(id, 249, 255, 135, "Периодический рестарт сервера в 04:07 по МСК.");

		--end

	end

	npc_module.OnPlayerConnect(id)

end

GO_LOG_SOUND = CreateSound("GO_log_sound.wav");
function SR(id)
	Player[id].enterreg = true;
	Player[id].logconnect = false;
	ShowRegister(id);
	PlayPlayerSound(id, GO_LOG_SOUND);
end

function SL(id)
	Player[id].enterlog = true;
	Player[id].logconnect = true;
	ShowLogin(id);
	PlayPlayerSound(id, GO_LOG_SOUND);
end

function BE_OnPlayerDisconnect(id, reason)
    
	_playersInfoCheckConnectsDisconnects(id);

   if IsNPC(id) == 0 then

	   	if Player[id]._timeInGameTimer ~= nil then
			KillTimer(Player[id]._timeInGameTimer);
		end

   		if Player[id]._weaponModeTimer ~= nil then
   			KillTimer(Player[id]._weaponModeTimer);
   		end

   		Player[id].colorf5 = {255, 255, 255}

  	 	for i, v in pairs(HEROES_LIST_ACTIVE) do
			if v == Player[id].hero_use[2] then
				table.remove(HEROES_LIST_ACTIVE, i);
			end
		end

		if Player[id].loggedIn == true then
			if Player[id].animtimer ~= nil then
				KillTimer(Player[id].animtimer);
			end
			
			Player[id].animtimer = "";
			Player[id].loggedIn = false;

			if Player[id]._trader_bot[1] == true then
				for i = 1, TRADERS_COUNT do
					if TRADERS[i].name == GetPlayerName(Player[id]._trader_bot[2]) then
						TRADERS[i].busy = false;
						break
					end
				end
			end

			if Player[id]._worker_bot[2] == true then
				for i = 1, WORKERS_COUNT do
					if WORKERS[i].worker_name == GetPlayerName(Player[id]._worker_bot[2]) then
						WORKERS[i].worker_busy = false;
						break
					end
				end
			end


			SavePlayer(id);
			SaveStats(id);
			_doubleSaveStats(id);
			

		end
	end
	
	npc_module.OnPlayerDisconnect(id, reason)

end

function BE_OnPlayerSpawn(id)
	
	if IsNPC(id) == 0 then
		SetPlayerScale(id, 0, 0, 0);
		SetPlayerPos(id, 5870.5795898438, 846.41967773438, 5056.8920898438);
		SetPlayerScience(id, 1, 1);
		SetPlayerAngle(id, 150);
	else
		Player[id].hitmark = GetPlayerHealth(id);
	end

end


function BE_OnPlayerText(id, text)

	if Player[id].enterreg == true then
		EnterPasswordReg(id, text); -- ввод при регистрации.
	end

	if Player[id].enterlog == true then
		EnterPasswordLog(id, text); -- ввод при логине.
	end
	
	if Player[id].board_write == true then
		_writeText(id, text) -- ввод на доске.
	end

	if Player[id].loggedIn == true and Player[id].board_write == false and WriteHandscript(id, text) == 0 then
		_languageText(id, text);
		_findAnim(id, text);
	end
end

lns = 0;
lnsJ = 0;

function LinesMobs()
	local fileR = io.open("bogomol.txt", "r");
	if fileR then
		lns = 0;
		for _ in fileR:lines() do
			lns = lns + 1;
		end
		return lns;
	end
end

function LinesJili()
	local fileR = io.open("swampdrone.txt", "r");
	if fileR then
		lnsJ = 0;
		for _ in fileR:lines() do
			lnsJ = lnsJ + 1;
		end
		return lnsJ;
	end
end

--require "zTexEditor/require"

function BE_OnPlayerKey(id, keyDown, keyUp)

	--[[if keyDown == KEY_UP then
		LinesMobs();
		local x, y, z = GetPlayerPos(id);
		local text = "#_"..lns..";"..x..";"..y..";"..z..";0;0";
		SendPlayerMessage(id, 255, 255, 255, text)
		local fileW = io.open("bogomol.txt", "a");
		fileW:write("#_"..lns..";"..x..";"..y..";"..z..";0;0".."\n");
		fileW:close();
	end

	if keyDown == KEY_DOWN then
		LinesJili();
		local x, y, z = GetPlayerPos(id);
		local text = "#_"..lnsJ.." -   "..x..";"..y..";"..z..";0;0";
		SendPlayerMessage(id, 255, 255, 255, text)
		local fileW = io.open("swampdrone.txt", "a");
		fileW:write("#_"..lnsJ..";"..x..";"..y..";"..z.."\n");
		fileW:close();
	end]]

	--zTexKey(id, keyDown, keyUp);
	_vobberKey(id, keyDown, keyUp);
	_gmpMenuKey(id, keyDown, keyUp);


	if Player[id].hero_use[1] == false then
		_talentsKey(id, keyDown, keyUp); -- таланты
		_houseKey(id, keyDown, keyUp); -- дом
		_worldContainerKey(id, keyDown, keyUp); -- WC
		CheckCraftGUI(id, keyDown, keyUp); -- кнопки крафта
		--MINE_OnPlayerKey(id, keyDown, keyUp); -- кнопки добычи
		TrainKey(id, keyDown, keyUp); -- кнопки тренировки
		rpinvKey(id, keyDown, keyUp); -- кнопки РП-инвентаря (ныне какие-то бля статусы)
		ShopKeys_OtherBots(id, keyDown, keyUp); -- кнопки бота торговца (PAO)
		HandscriptKey(id, keyDown, keyUp); -- кнопки handscript (письма)
		CheckInventoryGUI(id, keyDown, keyUp); -- кнопки inventory (рп инвентарь на I)
		_tradersKey(id, keyDown, keyUp); -- кнопки для торговцев
		SkinKey1(id, keyDown, keyUp); -- скинченджер
		_huntKey(id, keyDown, keyUp); -- охота.
		--_sheepKey(id, keyDown, keyUp); -- овцы
		_heroKey(id, keyDown, keyUp); -- кнопки инфо о персонаже
		_workersKey(id, keyDown, keyUp); -- кнопки рабочих
		_chestKey(id, keyDown, keyUp); -- сундуки
		_selectKey(id, keyDown, keyUp); -- ввод кол-во сундуки
		_teamKey(id, keyDown, keyUp); -- /моякоманда
	end

	_rcgKey(id, keyDown, keyUp); -- кнопки бугая ростовщика ебать
	_wayKey(id, keyDown, keyUp); -- кнопки ботов для Проводника/перевозки
	_assistKey(id, keyDown, keyUp); -- кнопки бота ассистента губерыча
	_boardKey(id, keyDown, keyUp); -- кнопки доски
	_logCraftKey(id, keyDown, keyUp); -- проверка крафтов игрока.
	_heroesKey(id, keyDown, keyUp); -- выход из списка персонажей
	_hudKey(id, keyDown, keyUp) -- худ.
	_wikiKey(id, keyDown, keyUp); -- вики
	GesticKey(id, keyDown, keyUp); -- фаст анимки
	_playersInfoKey(id, keyDown, keyUp); -- лист игроков

	if keyDown == KEY_M then
		_openMap(id)
	end
	
	if keyDown == KEY_ESCAPE then
		if Player[id].team_open == true then
			_showMyTeam(id);
		end
	end

	if keyDown == KEY_F8 then
		--[[if Player[id].mine == 0 then
			if Player[id].exitf8[1] == false then
				if Player[id].loggedIn == true then

					for i, v in pairs(HEROES_LIST_ACTIVE) do
						if v == Player[id].hero_use[2] then
							table.remove(HEROES_LIST_ACTIVE, i);
						end
					end
					
					if GetPlayerInstance(id) == "PC_HERO" and GetPlayerName(id) == Player[id].nickname then
						if Player[id].hero_use[1] == false and Player[id].IsInstance == false then
							SavePlayer(id);
							SaveStats(id);
							SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
							SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
							Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
							Player[id].exitf8[1] = true;
						else
							SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
							SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
							Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
							Player[id].exitf8[1] = true;
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
						SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
						Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
						Player[id].exitf8[1] = true;
					end

					if GetPlayerInstance(id) ~= "PC_HERO" and Player[id].areorc == 1 then
						if Player[id].hero_use[1] == false and Player[id].IsInstance == false then
							SavePlayer(id);
							SaveStats(id);
							SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
							Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
							Player[id].exitf8[1] = true;
						else
							SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
							Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
							Player[id].exitf8[1] = true;
						end
					end
				end	
			else
				KillTimer(Player[id].exitf8[2]);
				Player[id].exitf8[1] = false;
				Player[id].exitf8[2] = nil;
				SendPlayerMessage(id, 255, 255, 255, "Выход отменен.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Нельзя выходить с сервера при активной добыче.")
		end]]
	end

end

function _timerToExit(id)
	if IsPlayerConnected(id) == 1 then

		for i, v in pairs(HEROES_LIST_ACTIVE) do
			if v == Player[id].hero_use[2] then
				table.remove(HEROES_LIST_ACTIVE, i);
			end
		end

		_saveEquip(id);
		ExitGame(id);
	end
end

function BE_OnPlayerFocus(id, focusid)
	_workersFocus(id, focusid);
	_wayFocus(id, focusid);
	_focusAssist(id, focusid);
	BotsShop_Focus(id, focusid);
	_tradersFocus(id, focusid);
	_sheepsFocus(id, focusid)

	local str = "";
	if focusid ~= -1 then
		if IsNPC(focusid) == 0 then
			if Player[focusid].masked == false then
				str = string.format("%s%s%d%s",GetPlayerName(focusid)," (ИД: ", focusid, ")");
			else
				str = "Неизвестный";
			end
		else
			str = string.format("%s%s%d%s",GetPlayerName(focusid)," (ИД: ", focusid, ")");
		end
		UpdatePlayerDraw(id,Player[id].namedraw, 1300, 7500, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		
		--[[if focusid == royclapton_GUARD then
			UpdatePlayerDraw(id, Player[id].medraw, 1300, 7800, "Нажмите L.CTRL чтобы поговорить с человеком ростовщика.", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end]]
		
		if IsNPC(focusid) == 0 then
			if Player[focusid].loggedIn == true then

				if Player[focusid].masked == false then
					if Player[focusid].meinfo ~= nil and Player[focusid].meinfo ~= "NULL" then
						local text = Player[focusid].meinfo;
						if Player[id].loggedIn == true then
							UpdatePlayerDraw(id, Player[id].medraw, 1300, 7800, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						end
					end
				end

				if Player[focusid].afk == true then
					UpdatePlayerDraw(id, Player[id].afkdraw, 1300, 7200, "Игрок АФК", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end

			end
		end
	else
		UpdatePlayerDraw(id,Player[id].namedraw, 1300, 7500, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		if Player[id].loggedIn == true then
			UpdatePlayerDraw(id, Player[id].medraw, 1300, 7800, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
		UpdatePlayerDraw(id, Player[id].afkdraw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end


function OnPlayerMouse(id, button, pressed, posX, posY)

	_shipMouse(id, button, pressed, posX, posY);
	_vobberMouse(id, button, pressed, posX, posY);
	_chatMouse(id, button, pressed, posX, posY);
	RegMouse(id, button, pressed, posX, posY);
	LogMouse(id, button, pressed, posX, posY);
	SkinMouse(id, button, pressed, posX, posY);
	StatsMouse(id, button, pressed, posX, posY);
	RPInvMouse(id, button, pressed, posX, posY);
	_boardMouse(id, button, pressed, posX, posY);
	_21game_mouse(id, button, pressed, posX, posY);
	SkinMouse1(id, button, pressed, posX, posY);
	_tradersMouse(id, button, pressed, posX, posY);
	_pokerMouse(id, button, pressed, posX, posY);
	_OnButtons(id, button, pressed, posX, posY);
	
	if (posX > 3253 and posX < 4914) and (posY > 4386 and posY < 4742) then -- log/reg
		if Player[id].loggedIn == false then
			if Player[id].enterlog == true or Player[id].enterreg == true then
				Player[id]._inputID = 1;
				OpenInputField(id, 3337, 4468, 700, 0, "#");
			end
		end
	end

end

function BE_OnPlayerHit(id, killerid)

	--_gItemsHit(id, killerid);

	local time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	
	if IsNPC(id) == 1 then
		--local hp = "-"..Player[id].hitmark - GetPlayerHealth(id).."HP!";
		--GameTextForPlayer(killerid, math.random(2200, 2490), math.random(3400, 3980), hp, "Font_Old_20_White_Hi.TGA", 255, 128, 128, 400);
		--Player[id].hitmark = GetPlayerHealth(id);
	end
	
	if IsNPC(id) == 0 and IsNPC(killerid) == 0 then
		local damage = Player[id].hOldHP - GetPlayerHealth(id);
		
		local txt = GetPlayerName(killerid).." ударил игрока "..GetPlayerName(id).." / Старое ХП: "..Player[id].hOldHP.." - Новое ХП: "..GetPlayerHealth(id).." (урон "..damage..")";
		Player[id].hOldHP = GetPlayerHealth(id);
		
		LogString("Logs/Hits/Hits", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..txt);
		SaveStats(id);
		_checkFightMode(id, killerid);

		
	end

	if IsNPC(id) == 0 then


		if Player[id].loggedIn == true then

			SaveStats(id);
			SavePlayer(id);

			_updateHealth(id);

			if IsNPC(killerid) == 0 and Player[killerid].loggedIn == true then
				_updateHealth(killerid);
			end


		end

		if Player[id].afk == true then
			if IsNPC(killerid) == 0 then
				SendPlayerMessage(killerid, 255, 255, 255, "Нельзя атаковать игрока в АФК.");
				SendPlayerMessage(id, 255, 255, 255, "Вас атаковал игрок "..GetPlayerName(killerid))
				LogString("Logs/PlayersAll/AFK", Player[killerid].nickname.." атаковал игрокоа в статусе АФК - "..Player[id].nickname);
			end
		end

	end
	
	_talentsHit(id, killerid);
	_hitDR(id, killerid)
	npc_module.OnPlayerHit(id, killerid)
	
	SaveStats(id);
	_doubleSaveStats(id)

end

function OnPlayerChangeHealth(id, newValue, oldValue)

	if IsNPC(id) == 0 then
		if Player[id].loggedIn == true then
			_checkHealth(id, newValue, oldValue)
			SaveStats(id);
		end
	end
	
end

function OnPlayerChangeMana(id, newValue, oldValue)

	if IsNPC(id) == 0 then
		if Player[id].loggedIn == true then
			_checkMana(id, newValue, oldValue)
			SaveStats(id);
		end
	end

end

function LoadStats(id)
	
	SetPlayerMaxHealth(id, Player[id].hp);
	SetPlayerHealth(id, Player[id].chp);
	SetPlayerMana(id, Player[id].cmp);
	SetPlayerMaxMana(id, Player[id].mp);
	SetPlayerMagicLevel(id, Player[id].mag);

	SetPlayerDexterity(id, Player[id].dex);
	SetPlayerStrength(id, Player[id].str);

	SetPlayerSkillWeapon(id, SKILL_1H, Player[id].h1);
	SetPlayerSkillWeapon(id, SKILL_2H, Player[id].h2);
	SetPlayerSkillWeapon(id, SKILL_BOW, Player[id].bow);
	SetPlayerSkillWeapon(id, SKILL_CBOW, Player[id].cbow);
	
	Player[id].hOldHP = Player[id].chp;

end

function BE_OnPlayerTakeItem(id, itemID, itemInstance, amount, x, y, z, world)

	world_items_module.OnPlayerTakeItem(id, itemID, itemInstance, amount, x, y, z, world)

	if Player[id].hero_use[1] == false and Player[id].IsInstance == false then

		if GetPlayerInstance(id) == "PC_HERO" or Player[id].areorc == 1 then
			local name = GetPlayerName(id);
			local oldValue;
			local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db","r+");
			if file then
				for line in file:lines() do
					local result, item, value = sscanf(line,"sd");
					if result == 1 then
						if string.upper(item) == itemInstance then
							oldValue = value;
						end
					end
				end
				file:close();
			end
			
			if oldValue == nil then
				local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db","a+");
				file:write(itemInstance.." "..amount.."\n");
				file:close();
				SaveItems(id);
			else
				local newValue = oldValue + amount;
				local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db","r+");
				local tempString = file:read("*a");
				file:close();
				tempString = string.gsub(tempString,string.upper(itemInstance).." "..oldValue,string.upper(itemInstance).." "..newValue);
				local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db","w+");
				file:write(tempString);
				file:close();
				SaveItems(id);
			end

			Player[id]._checkInv = true;
			Player[id]._checkInvItem = string.upper(itemInstance);
			for i = 0, 16 do
				GetPlayerItem(id, i)
			end
			
			SaveStats(id);
			
			local count = 0;
			local items = getPlayerItems(id);
			if items then
				for i in pairs(items) do
					count = count + 1;
					if count > 15 then
						DropItem(id, items[i].instance, items[i].amount);
					end
				end
			end

			local time = os.date('*t');
			local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/Drop/Drop", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..GetPlayerName(id).." поднял "..itemInstance.." в кол-ве "..amount);
		end
	else
		local file = io.open("Database/Heroes/Items/"..Player[id].nickname..".txt","w+");
		local items = getPlayerItems(id);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end

		
		file:close();
	end

end

function BE_OnPlayerDropItem(id, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)
	
	instance = string.upper(instance);
	local name = GetPlayerName(id);
	local ip = GetPlayerIP(id);
	local mac = GetMacAddress(id);
	local oldValue;

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	if Player[id].hero_use[1] == false and Player[id].IsInstance == false then

		local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, value = sscanf(line,"sd");
				if result == 1 then
					if string.upper(item) == instance then
						oldValue = value;
					end
				end
			end
			file:close();
		end
		
		if oldValue == nil then
			oldValue = 0;
		end
		
		local newValue = oldValue - amount;
		if newValue < 0 then
			newValue = 0;
			if Player[id].astatus < 8 and instance ~= "ITLSTORCHBURNING" then
				if Player[id].invise_attack == false then
					if not string.find(instance, "ARROW") then
						if not string.find(instance, "BOLT") then
							local sum = amount - oldValue;
							if sum > 1 then
								DestroyItem(itemid);
								SendPlayerMessage(id,255, 255, 255, "Вы были кикнуты по подозрению в дюпе.");
								Kick(id);
								LogString("Logs/AC/ac_items",name.." выбросил: "..GetItemName(instance).." (x "..amount.."), имея по БД: "..oldValue.." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
							end
						end
					end
				end
			end
		end
		
		if Player[id].masked == true then
			if string.find(instance, "MASK") or string.find(instance, "ITHL_L_BAND") then
				Player[id].masked = false;
				SetPlayerName(id, Player[id].nickname)
				SendPlayerMessage(id, 255, 255, 255, "Вы выбросили маску.");
			end
		end
		
		local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
		local tempString = file:read("*a");
		file:close();
		local tempString = string.gsub(tempString,string.upper(instance).." "..oldValue,string.upper(instance).." "..newValue);
		local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","w+");
		file:write(tempString);
		file:close();
		
		local time = os.date('*t');
		local ryear = time.year;
		local rmonth = time.month;
		local rday = time.day;
		local rhour = string.format("%02d", time.hour);
		local rminute = string.format("%02d", time.min);
		LogString("Logs/Drop/Drop", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..GetPlayerName(id).." выбросил "..instance.." в кол-ве "..amount);
		SaveItems(id);
	else
		local file = io.open("Database/Heroes/Items/"..Player[id].nickname..".txt","w+");
		local items = getPlayerItems(id);
		if items then
			for i in pairs(items) do
				file:write(items[i].instance.." "..items[i].amount.."\n");
			end
		end
		file:close();
	end
	
	_houseDrop(id, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)

end


function OnPlayerHasItem(id, itemInstance, amount, equipped, checkid)

	MINE_OnPlayerHasItem(id, itemInstance, amount, equipped, checkid)
	CheckPaper(id, itemInstance, amount, equipped, checkid); -- handscript

end

function _goOutVW(id)
	SetPlayerVirtualWorld(id, 0);
end

function OnPlayerUseItem(id, itemInstance, amount, hand)

	if Player[id].hero_use[1] == false and Player[id].IsInstance == false then
		_useBooks(id, itemInstance, amount, hand); -- книги
		MINE_OnPlayerUseItem(id, itemInstance, amount, hand); -- предметы добычи
		UseEnergyItems(id, itemInstance, amount, hand); -- предметы стамины
		_fishing(id, itemInstance, amount, hand); -- рыбалка

		local potions_code = string.upper(itemInstance);
		local potions = string.find(potions_code, "ZEQFRN");
		if potions then
			SetPlayerVirtualWorld(id, math.random(30, 100));
			SetTimerEx(_goOutVW, 2000, 0, id);
		end

		local oldValue;
		local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
		if file then
			for line in file:lines() do 
				local result, item, value = sscanf(line,"sd");
				if result == 1 then
					if string.upper(item) == itemInstance
					and itemInstance ~= "OOLTYB_ITMI_RAKE"
					and itemInstance ~= "OOLTYB_ITMI_BRUSH"
					and itemInstance ~= "OOLTYB_ITMI_SCOOP"
					and itemInstance ~= "OOLTYB_ITMI_BROOM"
					and itemInstance ~= "OOLTYB_ITMI_LUTE"
					and itemInstance ~= "OOLTYB_ITMI_SAW"
					then
						oldValue = value;
					end
				end
			end
			file:close();
		end

		if oldValue == nil then
			oldValue = 0;
		end

		local newValue = oldValue - amount;
		if newValue < 0 then
			newValue = 0;
		end

		local item = string.upper(itemInstance);
		if item ~= "JKZTZD_ITMW_2H_AXE_L_01" then
			if item ~= "OOLTYB_ITMI_SAW" then
				if item ~= "OOLTYB_ITMI_FISHING" then
					if item ~= "OOLTYB_ITMI_BRUSH" then
						if item ~= "OOLTYB_ITMI_BROOM" then
							if item ~= "OOLTYB_ITMI_LUTE" then
								local book = string.lower(item); local bfind = string.find(book, "book");
								if bfind then
								else
									local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","r+");
									local tempString = file:read("*a");
									file:close();

									local tempString = string.gsub(tempString,string.upper(itemInstance).." "..oldValue,string.upper(itemInstance).." "..newValue);
									local file = io.open("Database/Players/Items/"..Player[id].nickname..".db","w+");
									file:write(tempString);
									file:close();
									removeItem(id, string.upper(itemInstance), 1);
									SaveItems(id);
								end
							end
						end
					end
				end
			end
		end
	end
	
	_updateHealth(id);

end


function OnPlayerDeath(id, p_classid, killerid, k_classid)

	if killerid ~= -1 and IsNPC(killerid) == 0 then
		_deathMonster(id, killerid);
	end
	
	if killerid ~= -1 and IsNPC(killerid) == 0 and Player[killerid].loggedIn == true then

		if IsNPC(id) == 0 then

			_teamPlayerDeath(id, p_classid, killerid, k_classid)

			for i = 0, GetMaxPlayers() do 
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, "    Игрок "..GetPlayerName(killerid).." ("..Player[killerid].nickname..") убил "..GetPlayerName(id).." ("..Player[id].nickname..").");
				end
			end

		else

			for i = 0, GetMaxPlayers() do 
				if Player[i].astatus > 1 then
					SendPlayerMessage(i, 255, 255, 255, "    Игрок "..GetPlayerName(killerid).." ("..Player[killerid].nickname..") убил "..GetPlayerName(id));
				end
			end

		end

	end

	if IsNPC(id) == 0 and Player[id].loggedIn == true then
		SetPlayerHealth(id, 0);
		Player[id].chp = 10;
		SaveStats(id);
		SavePlayer(id);
		_saveZen(id);
		SendPlayerMessage(id, 255, 255, 255, "Вы погибли!");
	end

	if IsNPC(id) == 1 and IsNPC(killerid) == 0 then
		SetPlayerHealth(id, 0);
	end

	npc_module.OnPlayerDeath(id, p_classid, killerid, k_classid)
end

function OnPlayerUnconscious(id, p_classid, killerid, k_classid)
	
	if IsNPC(id) == 1 then
		SetPlayerHealth(id, 0);
	end

	if IsNPC(id) == 0 and Player[id].loggedIn == true then
		SavePlayer(id);
		_saveZen(id);
		SaveStats(id);
	end

	_teamUncon(id, p_classid, killerid, k_classid)

	npc_module.OnPlayerUnconscious(id, p_classid, killerid, k_classid)
end

function OnPlayerSpellCast(id, itemInstance)

	if GetPlayerInstance(id) == "PC_HERO" or Player[id].areorc == 1 then
		if Player[id].hero_use[1] == false then
			local IHPIWN = string.find(itemInstance, "IHPIWN");
			if IHPIWN then
				local item = string.upper(itemInstance);
				removeItem(id, item, 1);
				SaveItems(id);
			end

			if itemInstance == "IRICEWOLF1" then
				SendPlayerMessage(id, 255, 255, 255, "Эта руна серверно отключена.")
			end

		end
	end

end

--[[function _removeArrowBD(id)

	local item = "JKZTZD_ITRW_ARROW";
	local oldValue = 0;
	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then
		for line in file:lines() do
			local result, arrow, amount = sscanf(line, "sd");
			if result == 1 then
				if arrow == item then
					oldValue = amount;
					break
				end
			end
		end
	end


	local newValue = 0;
	if oldValue > 0 then
		newValue = oldValue - 1;
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r+");
	local tempString = file:read("*a");
	file:close();
	local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "w+");
	file:write(tempString);
	file:close();

end]]

function _checkArrows(id)

    if Player[id].hero_use[1] == false then
	    local animation = GetPlayerAnimationName(id)
	    if animation == "T_BOWRELOAD" then
	    	removeItem(id, "JKZTZD_ITRW_ARROW", 1);
			SaveItems(id);

	    elseif animation == "T_CBOWRELOAD" then
	    	removeItem(id, "JKZTZD_ITRW_BOLT", 1);
			SaveItems(id);
	    end
	end

end

function _timerCheckArrows()

    for i = 0, GetMaxPlayers() do
        if Player[i].loggedIn == true then
            _checkArrows(i);
        end
    end

end
SetTimer(_timerCheckArrows, 900, 1);


-- AC

function OnPlayerEquipRing(id, isActive, itemInstance)
	
	itemInstance = string.upper(itemInstance);
	
	if isActive == 1 then
		if string.find(itemInstance, "RMYMEW") then
			if GetPlayerHealth(id) > 500 then
				SetPlayerHealth(id, 500);
				if Player[id].loggedIn == true then
					_updateHealth(id);
				end
			end
		end
	end
	
end

function OnPlayerChangeAmulet(id, newAmulet, oldAmulet)
	
	newAmulet = string.upper(newAmulet);
	
	if newAmulet ~= "NULL" then
		if GetPlayerHealth(id) > 500 then
			SetPlayerHealth(id, 500);
			if Player[id].loggedIn == true then
				_updateHealth(id);
			end
		end
	end

end

function OnPlayerChangeMaxHealth(id, newValue, oldValue)
	
	if Player[id].loggedIn == true and IsNPC(id) == 0 then
		_updateHealth(id);
		if newValue > 499 then
			if Player[id].astatus < 3 then
				SetPlayerMaxHealth(id, 500);
				_updateHealth(id);
			end
		end
	end

end

function OnPlayerChangeHealth(id, newValue, oldValue)

	if Player[id].loggedIn == true and IsNPC(id) == 0 then
		_updateHealth(id);
		if newValue > 499 then
			if Player[id].astatus < 3 then
				Player[id].chp = 500;
				SetPlayerHealth(id, 500);
				_updateHealth(id);
			end
		end
	end

end

function OnPlayerChangeStrength(id, newValue, oldValue)

	if newValue > 60 then
		if Player[id].astatus < 3 then
			SetPlayerStrength(id, 60);
		end
	end
	_ac_ChangeStrength(id, newValue, oldValue);
end

function OnPlayerChangeDexterity(id, newValue, oldValue)

	if newValue > 60 then
		if Player[id].astatus < 3 then
			SetPlayerDexterity(id, 60);
		end
	end

	_ac_ChangeDexterity(id, newValue, oldValue);
end

function OnPlayerChangeAcrobatic(id, newValue, oldValue)
	_ac_ChangeAcrobatic(id, newValue, oldValue);
end

function OnPlayerChangeArmor(id, newArmor, oldArmor)
	
end

function OnPlayerWeaponMode(id, weaponMode)
	_changeWeaponMode(id, weaponMode);
end


function OnPlayerChangeWorld(playerid, newWorld)

	if newWorld == "ARCHOLOS_SEWERS.ZEN" then
		if IsNPC(playerid) == 0 then
			SetPlayerPos(playerid, 8120.5390625, -122.26010131836, -148.6163482666);
		end
	end
	
	if newWorld ~= "FULLWORLD2.ZEN" then
		SetPlayerVirtualWorld(playerid, 0);
	end
	
	if newWorld == "ADDONWORLD2.ZEN" then
		if Player[playerid].loggedIn == false then
			SetPlayerPos(playerid, -37844.3359375, -1908.4188232422, 17641.916015625);
			SetPlayerAngle(playerid, 71);
		end
	end

end


function _startZoneChecker()

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and GetPlayerVirtualWorld(i) == 999 then
			local x, y, z = GetPlayerPos(i);
			if GetPlayerWorld(i) == "FULLWORLD2.ZEN" then
				if GetDistance3D(x, y, z, 75629.71875, 3612.2917480469, -11347.44140625) > 1500 then
					SendPlayerMessage(i, 255, 255, 255, "Стартовую зону можно покидать только через НПС-проводника.");
					SetPlayerPos(i, 75629.71875, 3612.2917480469, -11347.44140625);
				end
			elseif GetPlayerWorld(i) == "ADDONWORLD2.ZEN" then
				SetPlayerWorld(i, "FULLWORLD2.ZEN");
				SendPlayerMessage(i, 255, 255, 255, "Стартовую зону можно покидать только через НПС-проводника.");
				SetPlayerPos(i, 75629.71875, 3612.2917480469, -11347.44140625);
			end
		end
	end

end
SetTimer(_startZoneChecker, 5000, 1);



function OnPlayerInputField(id, text)

    if text ~= nil then
        if Player[id]._inputID == 1 then
		
			if Player[id].enterlog == true then
			
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
					UpdatePlayerDraw(id, autopass, 3337, 4468, "#-#-#-#-#-#-#-#-#-#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				else
					GameTextForPlayer(id, 3550, 5638, "Неверный пароль!", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
				end
			
				Player[id]._inputID = 0;
			end
			
			if Player[id].enterreg == true then
				if string.len(text) > 3 and not(string.find(string.lower(text), string.lower(" "))) then
					Player[id].rdy = true;
					treg = tostring(text);
					Player[id].enterreg = false;
					Player[id].password = treg;
					UpdatePlayerDraw(id, autopass, 3337, 4468, "#-#-#-#-#-#-#-#-#-#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				else
					GameTextForPlayer(id, 2485, 5580, "Подсказка: не менее 3 символов без пробелов.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 3000);
				end
				
				Player[id]._inputID = 0;
			end
		
            
        end
    end

end
