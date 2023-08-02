
BOT_TRAVELER = {};
BOT_ZENS = {};
BOT_GOLD_TRADER = {};
BOT_IRON_TRADER = {};
BOT_BUYER = nil;

function _initWay()
	
	print(" ");
	print("way bots");
	BOT_TRAVELER[1] = CreateNPC("Перевозчик")
	--SpawnPlayer(BOT_TRAVELER[1]);
	--SetPlayerWorld(BOT_TRAVELER[1], "");
	--SetPlayerPos(BOT_TRAVELER[1], 300, 300, 300);
	--SetPlayerAngle(BOT_TRAVELER[1], 50);

	BOT_ZENS[1] = CreateNPC("Проводник")
	SpawnPlayer(BOT_ZENS[1]);
	SetPlayerWorld(BOT_ZENS[1], "FULLWORLD2.ZEN");
	SetPlayerPos(BOT_ZENS[1], 76286.296875, 3612.2971191406, -10572.958984375);
	SetPlayerAngle(BOT_ZENS[1], 220);
	EquipArmor(BOT_ZENS[1], "itar_arx_r_l");
	SetPlayerMaxHealth(BOT_ZENS[1], 999999999);
	SetPlayerHealth(BOT_ZENS[1], 999999999);
	SetPlayerVirtualWorld(BOT_ZENS[1], 999);

	BOT_ZENS[2] = CreateNPC("Проводник") -- ворота
	--SpawnPlayer(BOT_ZENS[2]);
	--SetPlayerWorld(BOT_ZENS[2], "FULLWORLD2.ZEN");
	--SetPlayerPos(BOT_ZENS[2], 10462.345703125, 368.3115234375, 4909.2553710938);
	--SetPlayerAngle(BOT_ZENS[2], 284);
	--EquipArmor(BOT_ZENS[2], "itar_arx_r_l");
	--SetPlayerMaxHealth(BOT_ZENS[2], 999999999);
	--SetPlayerHealth(BOT_ZENS[2], 999999999);

	BOT_ZENS[3] = CreateNPC("Проводник") -- порт
	--SpawnPlayer(BOT_ZENS[3]);
	--SetPlayerWorld(BOT_ZENS[3], "FULLWORLD2.ZEN");
	--SetPlayerPos(BOT_ZENS[3], 1013.135559082, -87.28889465332, -1481.4069824219);
	--SetPlayerAngle(BOT_ZENS[3], 357);
	--EquipArmor(BOT_ZENS[3], "itar_arx_r_l");
	--SetPlayerMaxHealth(BOT_ZENS[3], 999999999);
	--SetPlayerHealth(BOT_ZENS[3], 999999999);

	BOT_ZENS[4] = CreateNPC("Проводник") -- ферма
	--SpawnPlayer(BOT_ZENS[4]);
	--SetPlayerWorld(BOT_ZENS[4], "FULLWORLD2.ZEN");
	--SetPlayerPos(BOT_ZENS[4], 7371.7392578125, 784.00927734375, -12566.907226562);
	--SetPlayerAngle(BOT_ZENS[4], 72);
	--EquipArmor(BOT_ZENS[4], "itar_arx_r_l");
	--SetPlayerMaxHealth(BOT_ZENS[4], 999999999);
	--SetPlayerHealth(BOT_ZENS[4], 999999999);
	
	BOT_ZENS[5] = CreateNPC("Проводник") -- Яркендар
	SpawnPlayer(BOT_ZENS[5]);
	SetPlayerWorld(BOT_ZENS[5], "ADDONWORLD2.ZEN");
	SetPlayerPos(BOT_ZENS[5], -45769.20703125, -907.98181152344, 17852.541015625);
	SetPlayerAngle(BOT_ZENS[5], 15);
	EquipArmor(BOT_ZENS[5], "itar_arx_r_l");
	SetPlayerMaxHealth(BOT_ZENS[5], 999999999);
	SetPlayerHealth(BOT_ZENS[5], 999999999);

	BOT_GOLD_TRADER[1] = CreateNPC("Обменщик золота")
	SpawnPlayer(BOT_GOLD_TRADER[1]);
	SetPlayerWorld(BOT_GOLD_TRADER[1], "FULLWORLD2.ZEN");
	SetPlayerPos(BOT_GOLD_TRADER[1], 7353.412109375, 223.01431274414, 369.97964477539);
	SetPlayerAngle(BOT_GOLD_TRADER[1], 28);
	EquipArmor(BOT_GOLD_TRADER[1], "yfauun_itar_vlk_l");
	SetPlayerMaxHealth(BOT_GOLD_TRADER[1], 999999999);
	SetPlayerHealth(BOT_GOLD_TRADER[1], 999999999);
	
	BOT_GOLD_TRADER[2] = CreateNPC("Обменщик золота")  -- Яркендар
	SpawnPlayer(BOT_GOLD_TRADER[2]);
	SetPlayerWorld(BOT_GOLD_TRADER[2], "ADDONWORLD2.ZEN");
	SetPlayerPos(BOT_GOLD_TRADER[2], -44513.453125, -1636.7368164063, 20408.927734375);
	SetPlayerAngle(BOT_GOLD_TRADER[2], 234);
	EquipArmor(BOT_GOLD_TRADER[2], "yfauun_itar_vlk_l");
	SetPlayerMaxHealth(BOT_GOLD_TRADER[2], 999999999);
	SetPlayerHealth(BOT_GOLD_TRADER[2], 999999999);

	BOT_IRON_TRADER[1] = CreateNPC("Обменщик серебра")
	SpawnPlayer(BOT_IRON_TRADER[1]);
	SetPlayerWorld(BOT_IRON_TRADER[1], "FULLWORLD2.ZEN");
	SetPlayerPos(BOT_IRON_TRADER[1], 7502.6513671875, 222.60736083984, 285.16333007812);
	SetPlayerAngle(BOT_IRON_TRADER[1], 32);
	EquipArmor(BOT_IRON_TRADER[1], "yfauun_itar_vlk_h");
	SetPlayerMaxHealth(BOT_IRON_TRADER[1], 999999999);
	SetPlayerHealth(BOT_IRON_TRADER[1], 999999999);
	
	BOT_IRON_TRADER[2] = CreateNPC("Обменщик серебра")  -- Яркендар
	SpawnPlayer(BOT_IRON_TRADER[2]);
	SetPlayerWorld(BOT_IRON_TRADER[2], "ADDONWORLD2.ZEN");
	SetPlayerPos(BOT_IRON_TRADER[2], -44898.58984375, -1636.1447753906, 19211.31640625);
	SetPlayerAngle(BOT_IRON_TRADER[2], 329);
	EquipArmor(BOT_IRON_TRADER[2], "yfauun_itar_vlk_h");
	SetPlayerMaxHealth(BOT_IRON_TRADER[2], 999999999);
	SetPlayerHealth(BOT_IRON_TRADER[2], 999999999);
	
	BOT_BUYER = CreateNPC("Скупщик материалов")
	SpawnPlayer(BOT_BUYER);
	SetPlayerWorld(BOT_BUYER, "FULLWORLD2.ZEN");
	SetPlayerPos(BOT_BUYER, 91.16943359375, -88.186386108398, -3211.1652832031);
	SetPlayerAngle(BOT_BUYER, 280);
	EquipArmor(BOT_BUYER, "yfauun_itar_col");
	SetPlayerMaxHealth(BOT_BUYER, 999999999);
	SetPlayerHealth(BOT_BUYER, 999999999);

end

function _wayFocus(id, fid)

	if GetFocus(id) == BOT_TRAVELER[1]
	or GetFocus(id) == BOT_ZENS[1] or GetFocus(id) == BOT_ZENS[2]
	or GetFocus(id) == BOT_ZENS[3] or GetFocus(id) == BOT_ZENS[4]
	or GetFocus(id) == BOT_ZENS[5]
	or GetFocus(id) == BOT_IRON_TRADER[1] or GetFocus(id) == BOT_IRON_TRADER[2]
	or GetFocus(id) == BOT_GOLD_TRADER[1] or GetFocus(id) == BOT_GOLD_TRADER[2]
	or GetFocus(id) == BOT_BUYER then
		SendPlayerMessage(id, 255, 255, 255, "Для разговора нажмите CTRL")
	end

end

createGUIMenu("TRAVEL_MENU", {
	{ "1. Поездка до (name)" },
	{ "2. Поездка до (name)" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

createGUIMenu("ZENS_MENU", {
	{ "1. Стартовая зона" },
	{ "2. РП зона" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

createGUIMenu("ZENS_MENU_1", {
	{ "1. Пляж" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 1);

createGUIMenu("GOLD_MENU", {
	{ "1. Обменять 5 самородков" },
	{ "2. Обменять 1 самородок" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

createGUIMenu("IRON_MENU", {
	{ "1. Обменять 15 самородков" },
	{ "2. Обменять 3 самородка" },
	{ "3. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);

createGUIMenu("BUYER_MENU", {
	{ "1. Продать слиток" },
	{ "2. Продать обр. древесину" },
	{ "3. Продать кожу" },
	{ "4. Продать нити" },
	{ "5. Продать раск. сталь" },
	{ "6. Закончить разговор" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5343, 3395, 8062, 4987, 'menu_ingame'), 6);
	
function _showZensMenu(id)
	showGUIMenu(id, "ZENS_MENU");
	Freeze(id);
end
function _showTravelMenu(id)
	showGUIMenu(id, "TRAVEL_MENU");
	Freeze(id);
end
function _showGoldMenu(id)
	showGUIMenu(id, "GOLD_MENU");
	Freeze(id);
end
function _showIronMenu(id)
	showGUIMenu(id, "IRON_MENU");
	Freeze(id);
end
function _showBuyerMenu(id)
	showGUIMenu(id, "BUYER_MENU");
	Freeze(id);
end

function _wayKey(id, down, up)

	if down == KEY_LCONTROL then
		if Player[id].loggedIn == true then

			if GetFocus(id) == BOT_TRAVELER[1] then
				SetTimerEx(_showTravelMenu, 400, 0, id);

			elseif GetFocus(id) == BOT_ZENS[1] then
				SetTimerEx(_showZensMenu, 400, 0, id);

			elseif GetFocus(id) == BOT_ZENS[2] then
				SetTimerEx(_showZensMenu, 400, 0, id);
			
			elseif GetFocus(id) == BOT_ZENS[3] then
				SetTimerEx(_showZensMenu, 400, 0, id);
				
			elseif GetFocus(id) == BOT_ZENS[4] then
				SetTimerEx(_showZensMenu, 400, 0, id);
				
			elseif GetFocus(id) == BOT_ZENS[5] then
				SetTimerEx(_showZensMenu, 400, 0, id);

			elseif GetFocus(id) == BOT_GOLD_TRADER[1] then
				SetTimerEx(_showGoldMenu, 400, 0, id);

			elseif GetFocus(id) == BOT_IRON_TRADER[1] then
				SetTimerEx(_showIronMenu, 400, 0, id);
				
			elseif GetFocus(id) == BOT_GOLD_TRADER[2] then
				SetTimerEx(_showGoldMenu, 400, 0, id);

			elseif GetFocus(id) == BOT_IRON_TRADER[2] then
				SetTimerEx(_showIronMenu, 400, 0, id);
				
			elseif GetFocus(id) == BOT_BUYER then
				SetTimerEx(_showBuyerMenu, 400, 0, id);

			end
		end
	end

	if down == KEY_UP then
		switchGUIMenuUp(id, "TRAVEL_MENU");
		switchGUIMenuUp(id, "ZENS_MENU");
		switchGUIMenuUp(id, "GOLD_MENU");
		switchGUIMenuUp(id, "IRON_MENU");
		switchGUIMenuUp(id, "ZENS_MENU_1");
		switchGUIMenuUp(id, "BUYER_MENU");
	end

	if down == KEY_DOWN then
		switchGUIMenuDown(id, "TRAVEL_MENU");
		switchGUIMenuDown(id, "ZENS_MENU");
		switchGUIMenuDown(id, "GOLD_MENU");
		switchGUIMenuDown(id, "IRON_MENU");
		switchGUIMenuDown(id, "ZENS_MENU_1");
		switchGUIMenuDown(id, "BUYER_MENU");
	end

	if down == KEY_RETURN then
		if Player[id].loggedIn == true then

			-- трейдер золота
			if getPlayerOptionID(id, "GOLD_MENU") == 1 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_GOLDNUGGET_ADDON" then
						if amount >= 5 then
							iValue = 5;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_GOLDNUGGET_ADDON", iValue);
					Player[id].gold = Player[id].gold + 20; --CITY_CASH = CITY_CASH + 5; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы обменяли 5 золотых самородков на 20 монет.");
					LogString("Database/City/Tax","Приход 5 золота при обмене зол. самородков от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько самородков в инвентаре.")
				end

			elseif getPlayerOptionID(id, "GOLD_MENU") == 2 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_GOLDNUGGET_ADDON" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_GOLDNUGGET_ADDON", iValue);
					Player[id].gold = Player[id].gold + 4; --CITY_CASH = CITY_CASH + 1; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы обменяли 1 золотой самородок на 4 монеты.");
					LogString("Database/City/Tax","Приход 1 золота при обмене зол. самородков от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько самородков в инвентаре.")
				end

			elseif getPlayerOptionID(id, "GOLD_MENU") == 3 then
				UnFreeze(id);
				hideGUIMenu(id, "GOLD_MENU");

			-- скупка материалов
			elseif getPlayerOptionID(id, "BUYER_MENU") == 1 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_S_IGNOT" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_S_IGNOT", iValue);
					Player[id].gold = Player[id].gold + 30; CITY_CASH = CITY_CASH + 4; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы продали слиток за 30 монет.");
					LogString("Database/City/Tax","Приход 4 золота при продаже слитка от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько слитков в инвентаре.")
				end

			elseif getPlayerOptionID(id, "BUYER_MENU") == 2 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_OBRABOTDER" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_OBRABOTDER", iValue);
					Player[id].gold = Player[id].gold + 25; CITY_CASH = CITY_CASH + 3; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы продали древесину за 25 монет.");
					LogString("Database/City/Tax","Приход 4 золота при продаже дерева от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько древесины в инвентаре.")
				end
				
			elseif getPlayerOptionID(id, "BUYER_MENU") == 3 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_LEATHER" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_LEATHER", iValue);
					Player[id].gold = Player[id].gold + 25; CITY_CASH = CITY_CASH + 3; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы продали кожу за 25 монет.");
					LogString("Database/City/Tax","Приход 3 золота при продаже кожи от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько кожи в инвентаре.")
				end
				
			elseif getPlayerOptionID(id, "BUYER_MENU") == 4 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_FIBER" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_FIBER", iValue);
					Player[id].gold = Player[id].gold + 25; CITY_CASH = CITY_CASH + 3; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы продали нити за 25 монет.");
					LogString("Database/City/Tax","Приход 3 золота при продаже нитей от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько нитей в инвентаре.")
				end
				
			elseif getPlayerOptionID(id, "BUYER_MENU") == 5 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMISWORDRAWHOT" then
						if amount >= 1 then
							iValue = 1;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMISWORDRAWHOT", iValue);
					Player[id].gold = Player[id].gold + 39; CITY_CASH = CITY_CASH + 4; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы продали сталь за 30 монет.");
					LogString("Database/City/Tax","Приход 4 золота при продаже стали от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько стали в инвентаре.")
				end

			elseif getPlayerOptionID(id, "BUYER_MENU") == 6 then
				UnFreeze(id);
				hideGUIMenu(id, "BUYER_MENU");
				
			-- ####################################################################

			elseif getPlayerOptionID(id, "ZENS_MENU") == 1 then

				if GetPlayerVirtualWorld(id) == 0 then
					SetPlayerVirtualWorld(id, 999)
					SetPlayerWorld(id, "FULLWORLD2.ZEN");
					SetPlayerPos(id, 75629.71875, 3612.2917480469, -11347.44140625);
					SetPlayerAngle(id, 86);
					SetDefaultCamera(id);
					UnFreeze(id);
					hideGUIMenu(id, "ZENS_MENU");
					LogString("Logs/PlayersAll/perehod",Player[id].nickname.." перешел в стартовую зону / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы уже в стартовой зоне.")
				end

			elseif getPlayerOptionID(id, "ZENS_MENU") == 2 then

				if GetPlayerVirtualWorld(id) == 999 then
					hideGUIMenu(id, "ZENS_MENU");
					showGUIMenu(id, "ZENS_MENU_1");
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы уже в РП-зоне.")
				end

			elseif getPlayerOptionID(id, "ZENS_MENU") == 3 then
				UnFreeze(id);
				hideGUIMenu(id, "ZENS_MENU");
			-- ####################################################################
			elseif getPlayerOptionID(id, "ZENS_MENU_1") == 1 then

				if GetPlayerVirtualWorld(id) == 999 then
					SetPlayerVirtualWorld(id, 0);
					SetPlayerWorld(id, "ADDONWORLD2.ZEN");
					SetPlayerPos(id, -45769.20703125 + math.random(-100, 100), -907.98181152344, 17852.541015625);
					SetPlayerAngle(id, 67);
					UnFreeze(id);
					SetDefaultCamera(id);
					hideGUIMenu(id, "ZENS_MENU_1");
					LogString("Logs/PlayersAll/perehod",Player[id].nickname.." перешел в рп зону (Яркендар) / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы уже в РП-зоне.")
				end


			--[[elseif getPlayerOptionID(id, "ZENS_MENU_1") == 2 then

				if GetPlayerVirtualWorld(id) == 999 then
					SetPlayerVirtualWorld(id, 0);
					--SetPlayerWorld(id, "FULLWORLD2.ZEN");
					SetPlayerPos(id, 1013.135559082 + math.random(-100, 100), -87.28889465332, -1481.4069824219);
					SetPlayerAngle(id, 231);
					UnFreeze(id);
					SetDefaultCamera(id);
					hideGUIMenu(id, "ZENS_MENU_1");
					LogString("Logs/PlayersAll/perehod",Player[id].nickname.." перешел в рп зону (порт) / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы уже в РП-зоне.")
				end


			elseif getPlayerOptionID(id, "ZENS_MENU_1") == 3 then

				if GetPlayerVirtualWorld(id) == 999 then
					SetPlayerVirtualWorld(id, 0);
					--SetPlayerWorld(id, "FULLWORLD2.ZEN");
					SetPlayerPos(id, 7371.7392578125 + math.random(-200, 100), 784.00927734375, -12566.907226562);
					SetPlayerAngle(id, 231);
					UnFreeze(id);
					SetDefaultCamera(id);
					hideGUIMenu(id, "ZENS_MENU_1");
					LogString("Logs/PlayersAll/perehod",Player[id].nickname.." перешел в рп зону (ферма) / ".._getRTime())
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы уже в РП-зоне.")
				end]]

			-- ####################################################################

			elseif getPlayerOptionID(id, "IRON_MENU") == 1 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_SILVERNUGGET" then
						if amount >= 15 then
							iValue = 15;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_SILVERNUGGET", iValue);
					Player[id].gold = Player[id].gold + 20; --CITY_CASH = CITY_CASH + 5; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы обменяли 15 серебрянных самородков на 20 монет.");
					LogString("Database/City/Tax","Приход 5 золота при обмене жел. самородков от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько самородков в инвентаре.")
				end

			elseif getPlayerOptionID(id, "IRON_MENU") == 2 then

				local iValue = nil;
				local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
				for line in file:lines() do
					local result, code, amount = sscanf(line, "sd");
					if code == "OOLTYB_ITMI_SILVERNUGGET" then
						if amount >= 3 then
							iValue = 3;
							break
						end
					end
				end

				if iValue ~= nil then
					RemoveItem(id, "OOLTYB_ITMI_SILVERNUGGET", iValue);
					Player[id].gold = Player[id].gold + 4; --CITY_CASH = CITY_CASH + 1; _saveCity()
					SaveItems(id); SavePlayer(id); 
					SendPlayerMessage(id, 255, 255, 255, "Вы обменяли 3 серебрянных самородка на 4 монеты.");
					LogString("Database/City/Tax","Приход 1 золота при обмене жел. самородков от игрока "..Player[id].nickname.." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "У вас нет столько самородков в инвентаре.")
				end

			elseif getPlayerOptionID(id, "IRON_MENU") == 3 then
				UnFreeze(id);
				hideGUIMenu(id, "IRON_MENU");
			end

		end
	end

end