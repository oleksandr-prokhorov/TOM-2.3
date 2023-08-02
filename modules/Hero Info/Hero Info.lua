
--  #   Hero info by royclapton  #
--  #        Version 1.1         #

function _heroInfoConnect(id)
	
	Player[id]._heroinfo_open = false;

	Player[id]._heroinfo_main_draws = {};
	Player[id]._heroinfo_main_draws[1] = CreatePlayerDraw(id, 6925, 390, "Инфо", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[2] = CreatePlayerDraw(id, 6886, 2410, "Хар-ки", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[5] = CreatePlayerDraw(id, 7550, 2410, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[3] = CreatePlayerDraw(id, 6856, 4810, "Навыки", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id]._heroinfo_main_draws[4] = CreatePlayerDraw(id, 5160, 390, "Языки", "Font_Old_20_White_Hi.TGA", 255, 255, 255);

	Player[id]._heroinfo_title_1_draws = {}; -- инфо
	for i = 1, 9 do
		Player[id]._heroinfo_title_1_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_2_draws = {}; -- статы
	for i = 1, 9 do
		Player[id]._heroinfo_title_2_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_3_draws = {}; -- навыки
	for i = 1, 9 do
		Player[id]._heroinfo_title_3_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_4_draws = {}; -- языки
	for i = 1, 10 do
		Player[id]._heroinfo_title_4_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_title_5_draws = {}; -- мод
	for i = 1, 8 do
		Player[id]._heroinfo_title_5_draws[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id]._heroinfo_tex = {};
	Player[id]._heroinfo_tex[1] = CreateTexture(6353, 101, 8067, 7180, 'menu_ingame')
	Player[id]._heroinfo_tex[2] = CreateTexture(4595, 154, 6301, 3043, 'menu_ingame')

end

function _heroKey(id, down, up)

	if Player[id].loggedIn == true then

		if down == KEY_V then
			if Player[id]._heroinfo_open == true then
				--_heroMenu(id);
			end
		end

	end

end

function _heroMenu(id)
	
	if Player[id]._heroinfo_open == false then

		if Player[id]._globalMenu == 0 then

			Player[id]._globalMenu = 1;
			
			for i = 1, table.getn(Player[id]._heroinfo_tex) do
				ShowTexture(id, Player[id]._heroinfo_tex[i])
			end

			for i = 1, table.getn(Player[id]._heroinfo_main_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_main_draws[i]);
			end

			for i = 1, table.getn(Player[id]._heroinfo_title_1_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_title_1_draws[i]);
			end

			for i = 1, table.getn(Player[id]._heroinfo_title_2_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_title_2_draws[i]);
			end

			for i = 1, table.getn(Player[id]._heroinfo_title_3_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_title_3_draws[i]);
			end

			for i = 1, table.getn(Player[id]._heroinfo_title_4_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_title_4_draws[i]);
			end

			for i = 1, table.getn(Player[id]._heroinfo_title_5_draws) do
				ShowPlayerDraw(id, Player[id]._heroinfo_title_5_draws[i]);
			end


			_updateHeroMenu(id);

			Player[id]._heroinfo_open = true;
		end

	else

		Player[id]._globalMenu = 0;

		for i = 1, table.getn(Player[id]._heroinfo_tex) do
			HideTexture(id, Player[id]._heroinfo_tex[i])
		end

		for i = 1, table.getn(Player[id]._heroinfo_main_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_main_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_1_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_1_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_2_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_2_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_3_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_3_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_4_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_4_draws[i]);
		end

		for i = 1, table.getn(Player[id]._heroinfo_title_5_draws) do
			HidePlayerDraw(id, Player[id]._heroinfo_title_5_draws[i]);
		end

		Player[id]._heroinfo_open = false;
	end

end

function _updateHeroMenu(id)

	local _str = GetPlayerStrength(id);
	local _dex = GetPlayerDexterity(id);
	local _hp = GetPlayerMaxHealth(id);
	local _mp = GetPlayerMaxMana(id);
	local _h1 = GetPlayerSkillWeapon(id, SKILL_1H);
	local _h2 = GetPlayerSkillWeapon(id, SKILL_2H);
	local _hBOW = GetPlayerSkillWeapon(id, SKILL_BOW);
	local _hCBOW = GetPlayerSkillWeapon(id, SKILL_CBOW);

	local _gstr = (_str * 0.1)		
	local _gdex = (_dex * 0.1)
	local _ghp = (_hp * 0.01)
	local _gmp = (_mp * 0.01)
	local _gh1 = (_h1 * 0.1)
	local _gh2 = (_h2 * 0.1)
	local _ghBOW = (_hBOW * 0.1)
	local _ghCBOW = (_hCBOW * 0.1)

	local _rstr = math.floor(_gstr)
	local _rdex = math.floor(_gdex)
	local _rhp = math.floor(_ghp)
	local _rmp = math.floor(_gmp)
	local _rh1 = math.floor(_gh1)
	local _rh2 = math.floor(_gh2)
	local _rhBOW = math.floor(_ghBOW)
	local _rhCBOW = math.floor(_ghCBOW)

	local gold = tostring(Player[id].gold);
	
	-- title 1
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[1], 6460, 840,  string.format("%s%s", "Никнейм: ",Player[id].nickname), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[2], 6460, 1040, string.format("%s%s", "Количество золота: ",string.sub(gold, 1, 6)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[3], 6460, 1240, string.format("%s%d", "Количество ОС: ",Player[id].hpoints), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[4], 6460, 1440, string.format("%s%d", "Текущее ХП: ",GetPlayerHealth(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[5], 6460, 1640, string.format("%s%d%s%d", "Текущее МП: ",GetPlayerMana(id)," / Круг: ",GetPlayerMagicLevel(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[6], 6460, 1840, string.format("%s%d", "Текущая энергия: ",Player[id].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[7], 6460, 2040, "Лимит энергии: --", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_1_draws[8], 6460, 2240, "------------------------------", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 2
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[1], 6460, 2860,  string.format("%s%d", "Сила: ",GetPlayerStrength(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[2], 6460, 3060,  string.format("%s%d", "Ловкость: ",GetPlayerDexterity(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[3], 6460, 3260,  string.format("%s%d", "Макс. ХП: ",GetPlayerMaxHealth(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[4], 6460, 3460,  string.format("%s%d", "Макс. МП: ",GetPlayerMaxMana(id)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[5], 6460, 3860,  string.format("%s%d", "Одноручное: ",GetPlayerSkillWeapon(id, SKILL_1H)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[6], 6460, 4060,  string.format("%s%d", "Двуручное: ",GetPlayerSkillWeapon(id, SKILL_2H)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[7], 6460, 4260,  string.format("%s%d", "Лук: ",GetPlayerSkillWeapon(id, SKILL_BOW)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[8], 6460, 4460,  string.format("%s%d", "Арбалет: ",GetPlayerSkillWeapon(id, SKILL_CBOW)), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_2_draws[9], 6460, 4660,  "------------------------------", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 2.1 (5)
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[1], 7720, 2860,  string.format("%d", _rstr), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[2], 7720, 3060,  string.format("%d", _rdex), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[3], 7720, 3260,  string.format("%d", _rhp), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[4], 7720, 3460,  string.format("%d", _rmp), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[5], 7720, 3860,  string.format("%d", _rh1), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[6], 7720, 4060,  string.format("%d", _rh2), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[7], 7720, 4260,  string.format("%d", _rhBOW), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_5_draws[8], 7720, 4460,  string.format("%d", _rhCBOW), "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 3 
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[1],	6460, 5160,  string.format("%s%d%s", "Охотник: ",Player[id].huntlevel," / 3"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[2], 6460, 5360,  string.format("%s%s%s", "Чтение свитков: ",Player[id].readscrolls," / 1"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[3], 6460, 5560,  string.format("%s%s%s", "Портной: ",GetScienceLevel(id, "Портной")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[4], 6460, 5760,  string.format("%s%s%s", "Повар: ",GetScienceLevel(id, "Повар")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[5], 6460, 5960,  string.format("%s%s%s", "Плотник: ",GetScienceLevel(id, "Плотник")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[6], 6460, 6160,  string.format("%s%s%s", "Алхимик: ",GetScienceLevel(id, "Алхимия")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[7], 6460, 6360,  string.format("%s%s%s", "Бронник: ",GetScienceLevel(id, "Бронник")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[8], 6460, 6560,  string.format("%s%s%s", "Оружейник: ",GetScienceLevel(id, "Оружейник")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_3_draws[9], 6460, 6760,  string.format("%s%s%s", "Кожевник: ",GetScienceLevel(id, "Кожевник")," / 4"), "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	-- title 4
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[1],	4700, 840,  string.format("%s%d", "Орочий: ",Player[id]._language_orcs), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[2],	4700, 1040,  string.format("%s%d", "Зодчих: ",Player[id]._language_yarkendar), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[3],	4700, 1240,  string.format("%s%d", "Наречия Тимориса: ",Player[id]._language_temoris), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[4],	4700, 1440,  string.format("%s%d", "Гатийский: ",Player[id]._language_gatia), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[5],	4700, 1640,  string.format("%s%d", "Южных островов: ",Player[id]._language_afro), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[6],	4700, 1840,  string.format("%s%d", "Демонический: ",Player[id]._language_demon), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[7],	4700, 2040,  string.format("%s%d", "Ящеров: ",Player[id]._language_waran), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[8],	4700, 2240,  string.format("%s%d", "Варантский: ",Player[id]._language_warant), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[9],	4700, 2440,  string.format("%s%d", "Нордмарский: ",Player[id]._language_nord), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._heroinfo_title_4_draws[10], 4700, 2640,  string.format("%s%d", "Миртанский: ",Player[id]._language_myrtana), "Font_Old_10_White_Hi.TGA", 255, 255, 255);



end

