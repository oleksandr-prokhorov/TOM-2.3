
--  #   Ship-port  by royclapton   #
--  #         version: 1.0         #


SHIP_TEMP_OBJECTS = {};

SHIP_TEXTURES = {};
SHIP_TEXTURES[1] = CreateTexture(1048, 1471, 7019, 6853, 'menu_ingame')
SHIP_TEXTURES[2] = CreateTexture(1540, 2200, 2790, 4300, 'menu_ingame')
SHIP_TEXTURES[3] = CreateTexture(3390, 2200, 4647, 4300, 'menu_ingame')
SHIP_TEXTURES[4] = CreateTexture(5235, 2200, 6501, 4300, 'menu_ingame')

SHIP_TEXTURES[5] = CreateTexture(1750, 2550, 2525, 4050, '')
SHIP_TEXTURES[6] = CreateTexture(3650, 2550, 4425, 4050, '')
SHIP_TEXTURES[7] = CreateTexture(5500, 2550, 6295, 4050, '')

SHIP_TEXTURES[8] = CreateTexture(5781, 4641, 6736, 5024, 'menu_ingame')
SHIP_TEXTURES[9] = CreateTexture(5781, 5221, 6736, 5609, 'menu_ingame')



SHIP_ITEMS_POS = {};
SHIP_ITEMS_POS[1] = {1750, 2550, 2525, 4050};
SHIP_ITEMS_POS[2] = {3650, 2550, 4425, 4050};
SHIP_ITEMS_POS[3] = {5500, 2550, 6295, 4050};


SHIP_TO_CITY = {};
SHIP_TO_CITY[1] = {-32607.86328125, -2000.6501464844, 34331.988595089};
SHIP_TO_CITY[2] = {-5333.9657215572, -655.97222900391, 1370.6337152512};
SHIP_TO_CITY[3] = {-37128.058741668, -2000.6501464844, 34331.988595089};

SHIP_OUT_CITY = {};
SHIP_OUT_CITY[1] = {-37128.058741668, -2000.6501464844, 34331.988595089};
SHIP_OUT_CITY[2] = {-9278.8836903072, -655.97222900391, 1370.5032831223};
SHIP_OUT_CITY[3] = {-32607.86328125, -2000.6501464844, 34331.988595089};

SHIP_STEP = 0;

SHIP_ROT_OCEAN = {0, -300, 0};
SHIP_ROT_CITY = {0, -300, 0};

SHIP_STATE = "ocean" -- ocean/city/to-city/to-ocean
SHIP_CURRENT_POS = {-99999990, -99999990, 0};
SHIP_CURRENT_ROT = {0, -300, 0};

function _shipSpawn()

	SHIP_CURRENT_POS = {-37128.058741668, -2000.6501464844, 34331.988595089};
	SHIP_CURRENT_ROT = {0, -300, 0};

	SHIP_OBJECT = Vob.Create("KB_KOGGE_01.3DS", "ADDONWORLD2.ZEN", -37128.058741668, -1853.6501464844, 34331.988595089);
			  Vob.SetRotation(SHIP_OBJECT, SHIP_CURRENT_ROT[1], SHIP_CURRENT_ROT[2], SHIP_CURRENT_ROT[3]);
			  Vob.SetCollision(SHIP_OBJECT, 0);

end

SHIP_STATUS = 0; -- разрешение на торговлю
SHIP_MOVE = 0; -- статус движения

SHIP_TIMER = nil;
SHIP_MOVE_TIMER = nil;
SHIP_OBJECT = nil;

SHIP_ITEMS_NOW = {};

local BUY_SOUND = CreateSound("GELDBEUTEL.WAV")

function _initShip()

	print(" ");
	print("======================")
	print("   SHIP MODULE LOAD   ")
	print("======================")
	_shipFirst();
end

function _shipFirst()
	--SetTimer(_shipGoCity, 60000 * 60, 0);
end

function _shipGoCity()
	_shipSpawn();
	_shipMovingToCity();
end
addCommandHandler({"/ко0"}, _shipGoCity);

function _shipGoOcean()
	_shipMovingToOcean();
end

function _shipConnect(id)

	Player[id]._shipOpen = false;
	Player[id]._shipButtons = false;
	Player[id]._shipCurrentWindow = 0;
	Player[id]._shipCurrentWindowTex = CreateTexture(0, 0, 0, 0, '');

	Player[id]._shipCurrentItemIDTable = 0;
	Player[id]._shipDraws_help = CreatePlayerDraw(id, 2547, 6452, "Для продолжения работы нажмите на любое окно.", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	Player[id]._shipDraws_title = CreatePlayerDraw(id, 3246, 1673, "Торговое судно", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._shipDraws_name = CreatePlayerDraw(id, 0, 0, "");
	Player[id]._shipDraws_description = {};
	for i = 1, 5 do
		Player[id]._shipDraws_description[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	Player[id]._shipDraws_price = CreatePlayerDraw(id, 0, 0, "");
	Player[id]._shipDraws_amount = CreatePlayerDraw(id, 0, 0, "");
	Player[id]._shipDraws_buttons = {};
	Player[id]._shipDraws_buttons[1] = CreatePlayerDraw(id, 6052, 4740, "Купить", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	Player[id]._shipDraws_buttons[2] = CreatePlayerDraw(id, 6100, 5321, "Выход", "Font_Old_10_White_Hi.TGA", 255, 255, 255);




end

function _shipUpdateItemInfo(id)

	if Player[id]._shipCurrentWindow ~= 0 then
		local arrpos = Player[id]._shipCurrentWindow;
		local preitem = SHIP_ITEMS_NOW[arrpos];
		local id_item_in_list = _getIdSItem(preitem);

		for i = 1, 5 do
			if SHIP_ITEMS_LIST[id_item_in_list].description[i] ~= nil then
				UpdatePlayerDraw(id, Player[id]._shipDraws_description[i], 1260, 4600+250*i, SHIP_ITEMS_LIST[id_item_in_list].description[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			else
				UpdatePlayerDraw(id, Player[id]._shipDraws_description[i], 1260, 4600+250*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			end
		end
		UpdatePlayerDraw(id, Player[id]._shipDraws_name, 1235, 4400, GetItemName(preitem), "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._shipDraws_amount, 1235, 6255, string.format("%s%d%s","Кол-во: ",SHIP_ITEMS_LIST[id_item_in_list].amount," единиц."), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatePlayerDraw(id, Player[id]._shipDraws_price, 1235, 6455, string.format("%s%d%s","Цена: ",SHIP_ITEMS_LIST[id_item_in_list].price," монет."), "Font_Old_10_White_Hi.TGA", 255, 237, 77);
	else
		for i = 1, 5 do
			UpdatePlayerDraw(id, Player[id]._shipDraws_description[i], 1260, 4600+250*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
		UpdatePlayerDraw(id, Player[id]._shipDraws_name, 3000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._shipDraws_amount, 5000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._shipDraws_price, 5000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _shipItemInfoClear(id)

	for i = 1, 5 do
		UpdatePlayerDraw(id, Player[id]._shipDraws_description[i], 1260, 4600+250*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end
	UpdatePlayerDraw(id, Player[id]._shipDraws_name, 3000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._shipDraws_amount, 5000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._shipDraws_price, 5000, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end

function _shipHideButtons(id)

	if Player[id]._shipButtons == true then
		Player[id]._shipButtons = false;
		HideTexture(id, SHIP_TEXTURES[8]);
		HideTexture(id, SHIP_TEXTURES[9]);
		HidePlayerDraw(id, Player[id]._shipDraws_buttons[1]);
		HidePlayerDraw(id, Player[id]._shipDraws_buttons[2]);
		if Player[id]._shipOpen == false then
			HidePlayerDraw(id, Player[id]._shipDraws_help);
		else
			ShowPlayerDraw(id, Player[id]._shipDraws_help);
		end
	else
		if Player[id]._shipOpen == false then
			HidePlayerDraw(id, Player[id]._shipDraws_help);
		else
			ShowPlayerDraw(id, Player[id]._shipDraws_help);
		end
	end



end

function _shipShowButtons(id)

	if Player[id]._shipButtons == false then
		Player[id]._shipButtons = true;
		ShowTexture(id, SHIP_TEXTURES[8]);
		ShowTexture(id, SHIP_TEXTURES[9]);
		ShowPlayerDraw(id, Player[id]._shipDraws_buttons[1]);
		ShowPlayerDraw(id, Player[id]._shipDraws_buttons[2]);
		HidePlayerDraw(id, Player[id]._shipDraws_help);
	end

end

function _shipGetIdTable(id, itemcode)

	itemcode = string.lower(itemcode);
	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i] ~= nil then
			if SHIP_ITEMS_LIST[i].code == itemcode then
				Player[id]._shipCurrentItemIDTable = i;
				break
			end
		end
	end

end

function _shipOpen(id)

	if Player[id].loggedIn == true then

		local x, y, z = GetPlayerPos(id);
		if GetDistance3D(x, y, z, -2982.6467285156, -715.85217285156, 1370.7963867188) < 1000 then
			if SHIP_STATUS == 1 then
				if Player[id]._shipOpen == false then
					Player[id]._shipOpen = true;
					for i = 1, 7 do
						ShowTexture(id, SHIP_TEXTURES[i]);
					end
					ShowTexture(id, Player[id]._shipCurrentWindowTex);
					ShowPlayerDraw(id, Player[id]._shipDraws_title);
					for i = 1, 5 do
						ShowPlayerDraw(id, Player[id]._shipDraws_description[i]);
					end
					ShowPlayerDraw(id, Player[id]._shipDraws_name);
					ShowPlayerDraw(id, Player[id]._shipDraws_amount);
					ShowPlayerDraw(id, Player[id]._shipDraws_price);
					ShowPlayerDraw(id, Player[id]._shipDraws_help);
					Freeze(id);
					FreezeCamera(id, 1);
					SetCursorVisible(id, 1);
					_hud(id);
					ShowChat(id, 0);
				else
					Player[id]._shipOpen = false;
					for i = 1, 7 do
						HideTexture(id, SHIP_TEXTURES[i]);
					end

					if Player[id]._shipCurrentWindow ~= 0 then
						HideTexture(id, SHIP_TEXTURES[8]);
						HideTexture(id, SHIP_TEXTURES[9]);
					end

					UpdateTexture(Player[id]._shipCurrentWindowTex, 0, 0, 0, 0, '');
					HideTexture(id, Player[id]._shipCurrentWindowTex);
					HidePlayerDraw(id, Player[id]._shipDraws_title);
					for i = 1, 5 do
						HidePlayerDraw(id, Player[id]._shipDraws_description[i]);
					end
					HidePlayerDraw(id, Player[id]._shipDraws_name);
					HidePlayerDraw(id, Player[id]._shipDraws_amount);
					HidePlayerDraw(id, Player[id]._shipDraws_price);

					_shipHideButtons(id);

					UnFreeze(id);
					FreezeCamera(id, 0);
					SetCursorVisible(id, 0);
					_shipItemInfoClear(id);
					ShowChat(id, 1);
					_hud(id);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "В данный момент продажа закрыта.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вы далеко от места остановки судна.")
		end
	end

end
addCommandHandler({"/корабль"}, _shipOpen);

function _shipMouse(id, button, pressed, posX, posY)

	if button == MB_LEFT then
		if pressed == 0 then
			if Player[id].loggedIn == true then
				if Player[id]._shipOpen == true then

					if posX > SHIP_ITEMS_POS[1][1] and posX < SHIP_ITEMS_POS[1][3] and posY > SHIP_ITEMS_POS[1][2] and posY < SHIP_ITEMS_POS[1][4] then
						UpdateTexture(Player[id]._shipCurrentWindowTex, 1540, 2200, 2790, 4300, 'INV_SLOT_EQUIPPED_FOCUS');
						Player[id]._shipCurrentWindow = 1;
						_shipGetIdTable(id, SHIP_ITEMS_NOW[1]);
						_shipUpdateItemInfo(id);
						_shipShowButtons(id);

					elseif posX > SHIP_ITEMS_POS[2][1] and posX < SHIP_ITEMS_POS[2][3] and posY > SHIP_ITEMS_POS[2][2] and posY < SHIP_ITEMS_POS[2][4] then
						UpdateTexture(Player[id]._shipCurrentWindowTex, 3390, 2200, 4647, 4300, 'INV_SLOT_EQUIPPED_FOCUS');
						Player[id]._shipCurrentWindow = 2;
						_shipGetIdTable(id, SHIP_ITEMS_NOW[2]);
						_shipUpdateItemInfo(id);
						_shipShowButtons(id);

					elseif posX > SHIP_ITEMS_POS[3][1] and posX < SHIP_ITEMS_POS[3][3] and posY > SHIP_ITEMS_POS[3][2] and posY < SHIP_ITEMS_POS[3][4] then
						UpdateTexture(Player[id]._shipCurrentWindowTex, 5235, 2200, 6501, 4300, 'INV_SLOT_EQUIPPED_FOCUS');
						Player[id]._shipCurrentWindow = 3;
						_shipGetIdTable(id, SHIP_ITEMS_NOW[3]);
						_shipUpdateItemInfo(id);
						_shipShowButtons(id);

					elseif posX > 5781 and posX < 6736 and posY > 4641 and posY < 5024 then
						if Player[id]._shipButtons == true then
							_shipBuy(id);
						end

					elseif posX > 5781 and posX < 6736 and posY > 5221 and posY < 5609 then
						_shipOpen(id);

					else
						UpdateTexture(Player[id]._shipCurrentWindowTex, 0, 0, 0, 0, '');
						Player[id]._shipCurrentWindow = 0;
						Player[id]._shipCurrentItemIDTable = 0;
						_shipUpdateItemInfo(id);
						_shipHideButtons(id);
					end


				end
			end
		end
	end

end

function _shipBuy(id)

	local itemID = Player[id]._shipCurrentItemIDTable;
	local itemPrice = SHIP_ITEMS_LIST[itemID].price;
	local itemAmount = SHIP_ITEMS_LIST[itemID].amount;

	if Player[id].gold >= itemPrice then
		if itemAmount > 0 then
			SHIP_ITEMS_LIST[itemID].amount = SHIP_ITEMS_LIST[itemID].amount - 1;
			Player[id].gold = Player[id].gold - itemPrice;
			GiveItem(id, string.upper(SHIP_ITEMS_LIST[itemID].code), 1);
			SaveItems(id);
			SavePlayer(id);
			GameTextForPlayer(id, 1235, 6055, "Куплено!", "Font_Old_10_White_Hi.TGA", 154, 252, 134, 1500);
			_shipUpdateItemInfo(id);
			for i = 0, GetMaxPlayers() do
				if Player[i].loggedIn == true and Player[id]._shipOpen == true then
					if i ~= id then
						_shipUpdateItemInfo(i);
					end
				end
			end
			LogString("Logs/Ship/All",Player[id].nickname.." купил "..GetItemName(SHIP_ITEMS_LIST[itemID].code).." x1 за "..itemPrice.." / Дата: ".._getRTime());
			local rnd = math.random(1, 10);
			CITY_CASH = CITY_CASH + rnd;
			LogString("Database/City/Tax","Приход налога в 10% - "..rnd.." от покупки на корабле игроком "..GetPlayerName(id).." / Баланс города: "..CITY_CASH.." / Дата: ".._getRTime());
			_saveCity();
			PlayPlayerSound(id, BUY_SOUND);
		else
			GameTextForPlayer(id, 1235, 6055, "Товар кончился.", "Font_Old_10_White_Hi.TGA", 250, 115, 115, 1500);
		end
	else
		GameTextForPlayer(id, 1235, 6055, "Не хватает золота.", "Font_Old_10_White_Hi.TGA", 250, 115, 115, 1500);
	end

end

function _shipGlobalUpdateItems()

	print("Ship reload. Items update.")
	_doRandomAmount();
	_doRandomPrice();

	SHIP_ITEMS_NOW = {};
	while table.getn(SHIP_ITEMS_NOW) ~= 3 do
		local status = true;
		local rnd = SHIP_ITEMS_LIST[0][math.random(1, table.getn(SHIP_ITEMS_LIST[0]))];
		for _, v in pairs(SHIP_ITEMS_NOW) do
			if v == rnd then
				status = false;
			end
		end

		if status == true then
			table.insert(SHIP_ITEMS_NOW, rnd);
			local min, all = _getPriceSItem(rnd)
			print("Item add: "..rnd.." (№".._getIdSItem(rnd)..") / Amount: ".._getAmountSItem(rnd).." / Price (min/all): "..min.."/"..all)
		end
	end
	print(" ");

	local tex = {};
	tex[1] = "ship_"..SHIP_ITEMS_NOW[1];
	tex[2] = "ship_"..SHIP_ITEMS_NOW[2];
	tex[3] = "ship_"..SHIP_ITEMS_NOW[3];

	for i = 1, 3 do
		if string.find(SHIP_ITEMS_NOW[i], "joint") then
			tex[i] = "ship_ooltyb_itmi_joint";
		elseif string.find(SHIP_ITEMS_NOW[i], "tabak") then
			tex[i] = "ship_ooltyb_itmi_tabak";
		elseif string.find(SHIP_ITEMS_NOW[i], "fat") then
			tex[i] = "ship_zdpwla_itfo_flour";
		end
	end

	UpdateTexture(SHIP_TEXTURES[5], 1750, 2550, 2525, 4050, tex[1]);
	UpdateTexture(SHIP_TEXTURES[6], 3650, 2550, 4425, 4050, tex[2]);
	UpdateTexture(SHIP_TEXTURES[7], 5500, 2550, 6295, 4050, tex[3]);


end


function _hideShip()

	SHIP_CURRENT_POS = {0, 0, 0};
	SHIP_CURRENT_ROT = {0, 0, 0};
	Vob.Destroy(SHIP_OBJECT);

end

function _shipMovingToCity()

	if SHIP_STATE == "ocean" and SHIP_MOVE == 0 then
		SHIP_MOVE = 1;
		SHIP_STATUS = 0;
		SHIP_STEP = 1;
		SHIP_STATE = "to-city";
		_shipGlobalUpdateItems();
		SendMessageToAll(253, 255, 112, "Торговое судно появилось на горизонте - скоро оно будет в у пляжа острова.")
		SendMessageToAll(253, 255, 112, "Корабль пробудет там 2 часа.")
		SHIP_CURRENT_ROT = {0, -300, 0};
		Vob.SetRotation(SHIP_OBJECT, SHIP_CURRENT_ROT[1], SHIP_CURRENT_ROT[2], SHIP_CURRENT_ROT[3]);

		if SHIP_MOVE_TIMER ~= nil then
			KillTimer(SHIP_MOVE_TIMER);
			SHIP_MOVE_TIMER = nil;
		end

		SHIP_MOVE_TIMER = SetTimer(_shipMove, 100, 1);

	end

end
addCommandHandler({"/ко1"}, _shipMovingToCity);

function _shipMovingToOcean()

	if SHIP_STATE == "city" and SHIP_MOVE == 0 then
		SendMessageToAll(253, 255, 112, "Торговое судно отбыло за новой партией товаров.")
		SendMessageToAll(253, 255, 112, "Время возвращения: 1 часа.")
		--Mob.Destroy(SHIP_TEMP_OBJECTS[1]);
		--Mob.Destroy(SHIP_TEMP_OBJECTS[2]);
		--Mob.Destroy(SHIP_TEMP_OBJECTS[3]);
		--Vob.Destroy(SHIP_TEMP_OBJECTS[4]);

		SHIP_MOVE = 1;
		SHIP_STATUS = 0;
		SHIP_STEP = 1;
		SHIP_STATE = "to-ocean";

		if SHIP_MOVE_TIMER ~= nil then
			KillTimer(SHIP_MOVE_TIMER);
			SHIP_MOVE_TIMER = nil;
		end

		SHIP_MOVE_TIMER = SetTimer(_shipMove, 100, 1);

	end

end 
addCommandHandler({"/ко2"}, _shipMovingToOcean());

function _shipMove()

	if SHIP_MOVE == 1 then

		if SHIP_STATE == "to-city" then

			if SHIP_STEP == 1 then

				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] - 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3] + 30);
				
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] - 30; 
				SHIP_CURRENT_POS[3] = SHIP_CURRENT_POS[3] + 30;
				
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_TO_CITY[1][1], SHIP_TO_CITY[1][3]) < 200 then
					SHIP_STEP = 3;
				end

			end

			--[[if SHIP_STEP == 2 then

				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] + 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3]);
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] + 30;
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_TO_CITY[2][1], SHIP_TO_CITY[2][3]) < 200 then
					SHIP_STEP = 3;
				end

			end]]

			if SHIP_STEP == 3 then

				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] - 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3] + 30);
				
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] - 30; 
				SHIP_CURRENT_POS[3] = SHIP_CURRENT_POS[3] + 30;
				
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_TO_CITY[3][1], SHIP_TO_CITY[3][3]) < 200 then
					SHIP_STEP = 0;
					SHIP_STATE = "city";
					KillTimer(SHIP_MOVE_TIMER);
					SHIP_MOVE_TIMER = nil;
					SHIP_MOVE = 0;
					SHIP_STATUS = 1;
					--SHIP_TEMP_OBJECTS[1] = Mob.Create("LADDER_3.ASC", "MOBNAME_PASSOW", OCMOBLADDER, "LADDER", "", "ADDONWORLD2.ZEN", -2347.8264160156, -592.50262451172, 2096.0473632812); Mob.SetRotation(SHIP_TEMP_OBJECTS[1], 16, -180, 0);
					--SHIP_TEMP_OBJECTS[2] = Mob.Create("LADDER_3.ASC", "MOBNAME_PASSOW", OCMOBLADDER, "LADDER", "", "ADDONWORLD2.ZEN", -2429.2187623019, -592.35797119141, 2095.0407550252); Mob.SetRotation(SHIP_TEMP_OBJECTS[2], 16, -180, 0);
					--SHIP_TEMP_OBJECTS[3] = Mob.Create("LADDER_3.ASC", "MOBNAME_PASSOW", OCMOBLADDER, "LADDER", "", "ADDONWORLD2.ZEN", -2255.0207519531, -587.35797119141, 2094.9782714844); Mob.SetRotation(SHIP_TEMP_OBJECTS[3], 16, -180, 0);
					--SHIP_TEMP_OBJECTS[4] = Vob.Create("ADDON_MISC_BOHLEN_01.3DS", "ADDONWORLD2.ZEN", -2341.798828125, -294.33941650391, 1972.2860107422); Vob.SetRotation(SHIP_TEMP_OBJECTS[4], 0, -180, 0);
					Vob.SetCollision(SHIP_OBJECT, 1);

					SetTimer(_shipGoOcean, 60000 * 120, 0);
				end

			end
		end

		if SHIP_STATE == "to-ocean" then

			if SHIP_STEP == 1 then

				Vob.SetCollision(SHIP_OBJECT, 0);
				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] + 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3] - 30);
				
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] + 30;
				SHIP_CURRENT_POS[3] = SHIP_CURRENT_POS[3] - 30;
				
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_OUT_CITY[1][1], SHIP_OUT_CITY[1][3]) < 200 then
					SHIP_STEP = 3;
				end

			end


			--[[if SHIP_STEP == 2 then

				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] - 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3]);
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] - 30;
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_OUT_CITY[2][1], SHIP_OUT_CITY[2][3]) < 200 then
					SHIP_STEP = 3;
				end

			end]]

			if SHIP_STEP == 3 then

				Vob.SetPosition(SHIP_OBJECT, SHIP_CURRENT_POS[1] - 30, SHIP_CURRENT_POS[2], SHIP_CURRENT_POS[3] - 30);
				
				SHIP_CURRENT_POS[1] = SHIP_CURRENT_POS[1] + 30;
				SHIP_CURRENT_POS[3] = SHIP_CURRENT_POS[3] - 30;
				
				if GetDistance2D(SHIP_CURRENT_POS[1], SHIP_CURRENT_POS[3], SHIP_OUT_CITY[3][1], SHIP_OUT_CITY[3][3]) < 200 then
					SHIP_STEP = 0;
					SHIP_STATE = "ocean";
					KillTimer(SHIP_MOVE_TIMER);
					SHIP_MOVE_TIMER = nil;
					SHIP_MOVE = 0;
					_hideShip();
					SetTimer(_shipGoCity, 60000 * 60, 0);
				end
			end
		end
	end

end

