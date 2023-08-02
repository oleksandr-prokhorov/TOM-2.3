
SHIP_ITEMS_LIST = {};
for i = 0, 100 do
	SHIP_ITEMS_LIST[i] = {};
end

SHIP_ITEMS_LIST[0] = {

	"zdpwla_itfo_bottleofbeer",
	"zdpwla_itfo_apple",
	"zdpwla_itfo_cheese",
	"zdpwla_itfo_bacon",
	"zdpwla_itfo_bread",
	"zdpwla_itfo_fish",
	"zdpwla_itfo_beer",
	"zdpwla_itfo_booze",
	"zdpwla_itfo_wine",
	"zdpwla_itfo_milk",
	"zdpwla_itfo_pie",
	"zdpwla_itfo_mors",
	"yfauun_ithl_m_helmet1",
	"yfauun_ithl_m_helmet2",
	"yfauun_ithl_m_helmet3",
	"yfauun_ithl_m_helmet4",
	"yfauun_ithl_m_helmet5",
	"rc_blue_mask",
	"rc_dblue_mask",
	"rc_dgreen_mask",
	"rc_gray_mask",
	"zdpwla_itfo_flour",
	"ooltyb_itmi_stuff_silverware_01",
	"ooltyb_itmi_alchemy_alcohol_01",
	"ooltyb_itat_sting",
	"ooltyb_itat_shadowhorn",
	"ooltyb_itat_trolltooth",
	"ooltyb_itat_fat",
	"ooltyb_itmi_silverring",
	"ooltyb_itmi_silverplate",
	"ooltyb_itmi_innosstatue",
	"ooltyb_itmi_darkpearl",
	"ooltyb_itmi_aquamarine",
	"ooltyb_itmi_paper",
	"ooltyb_itmi_apfeltabak",
	"ooltyb_itmi_pilztabak",
	"ooltyb_itmi_doppeltabak",
	"ooltyb_itmi_honigtabak",
	"ooltyb_itmi_sumpftabak",
	"ooltyb_itmi_joint_1",
	"ooltyb_itmi_joint_2",	
	"ooltyb_itmi_joint_3",
	"zdpwla_itpl_mana_herb_01",	
	"zdpwla_itpl_mana_herb_02",
	"zdpwla_itpl_mana_herb_03",
	"zdpwla_itpl_health_herb_01",
	"zdpwla_itpl_health_herb_02",
	"zdpwla_itpl_health_herb_03",
	"zdpwla_itpl_forestberry",
	"zdpwla_itpl_temp_herb",
	"zdpwla_itpl_perm_herb",
	"zeqfrn_itpo_mana_02",
	"zeqfrn_itpo_health_02",
	"zeqfrn_itpo_speed",
	"jkztzd_itmw_steinbrecher",
	"jkztzd_itmw_schwert1",
	"jkztzd_itmw_rapier",
	"jkztzd_itmw_schiffsaxt"

}

for i = 1, 100 do
	SHIP_ITEMS_LIST[i].code = SHIP_ITEMS_LIST[0][i];
	SHIP_ITEMS_LIST[i].amount = 0;
	SHIP_ITEMS_LIST[i].minprice = 0;
	SHIP_ITEMS_LIST[i].price = 0;
	SHIP_ITEMS_LIST[i].description = {};
end

-- options
SHIP_ITEMS_LIST[1].description = {"Бутылочка темного паладинского пивка.", "Употреблять охлажденным."};
SHIP_ITEMS_LIST[1].minprice = 2;

SHIP_ITEMS_LIST[2].description = {"Твердое и хрустящее."};
SHIP_ITEMS_LIST[2].minprice = 2;

SHIP_ITEMS_LIST[3].description = {"Только из свежего молока.", "Отличная закуска.", "+50 энергии."};
SHIP_ITEMS_LIST[3].minprice = 5;

SHIP_ITEMS_LIST[4].description = {"Хорошенький хряк был.", "Идеально для жарки.", "+50 энергии."};
SHIP_ITEMS_LIST[4].minprice = 5;

SHIP_ITEMS_LIST[5].description = {"Мука не высший класс, но съедобно.", "Выращено на полях Миртаны.", "+25 энергии."};
SHIP_ITEMS_LIST[5].minprice = 5;

SHIP_ITEMS_LIST[6].description = {"Свежая рыба."};
SHIP_ITEMS_LIST[6].minprice = 2;

SHIP_ITEMS_LIST[7].description = {"Закрытый бокал светлого пива.", "Хмель - друг человека.", "+75 энергии."};
SHIP_ITEMS_LIST[7].minprice = 5;

SHIP_ITEMS_LIST[8].description = {"Настоящий джин.", "Любимчик среднего класса.", "+75 энергии."};
SHIP_ITEMS_LIST[8].minprice = 5;

SHIP_ITEMS_LIST[9].description = {"Монастырское вино.", "Или подвальное?", "+75 энергии."};
SHIP_ITEMS_LIST[9].minprice = 5;

SHIP_ITEMS_LIST[10].description = {"Ведро молока.", "С фермерской буренки."};
SHIP_ITEMS_LIST[10].minprice = 1;

SHIP_ITEMS_LIST[11].description = {"Пирог.", "Большой и вкусный."};
SHIP_ITEMS_LIST[11].minprice = 2;

SHIP_ITEMS_LIST[12].description = {"Ягодный морс.", "+75 энергии."};
SHIP_ITEMS_LIST[12].minprice = 5;

SHIP_ITEMS_LIST[13].description = {"Аксессуар."};
SHIP_ITEMS_LIST[13].minprice = 80;

SHIP_ITEMS_LIST[14].description = {"Аксессуар."};
SHIP_ITEMS_LIST[14].minprice = 80;

SHIP_ITEMS_LIST[15].description = {"Аксессуар."};
SHIP_ITEMS_LIST[15].minprice = 80;

SHIP_ITEMS_LIST[16].description = {"Аксессуар."};
SHIP_ITEMS_LIST[16].minprice = 80;

SHIP_ITEMS_LIST[17].description = {"Аксессуар."};
SHIP_ITEMS_LIST[17].minprice = 80;

SHIP_ITEMS_LIST[18].description = {"Аксессуар."};
SHIP_ITEMS_LIST[18].minprice = 30;

SHIP_ITEMS_LIST[19].description = {"Аксессуар."};
SHIP_ITEMS_LIST[19].minprice = 30;

SHIP_ITEMS_LIST[20].description = {"Аксессуар."};
SHIP_ITEMS_LIST[20].minprice = 30;

SHIP_ITEMS_LIST[21].description = {"Аксессуар."};
SHIP_ITEMS_LIST[21].minprice = 60;

SHIP_ITEMS_LIST[22].description = {"Мешок муки, весом около фунта."};
SHIP_ITEMS_LIST[22].minprice = 45;

SHIP_ITEMS_LIST[23].description = {"Для людей, не любящих есть руками.", "Сделано из серебра."};
SHIP_ITEMS_LIST[23].minprice = 15;

SHIP_ITEMS_LIST[24].description = {"Неразбавленный водой, чистейший.", "Это не муть, это тень так падает."};
SHIP_ITEMS_LIST[24].minprice = 25;

SHIP_ITEMS_LIST[25].description = {"Извлечено из полевого шершня."};
SHIP_ITEMS_LIST[25].minprice = 10;

SHIP_ITEMS_LIST[26].description = {"Большой и острый.", "Таким можно и зарубить."};
SHIP_ITEMS_LIST[26].minprice = 80;

SHIP_ITEMS_LIST[27].description = {"Прекрасный трофей.", "Можно сделать кулон."};
SHIP_ITEMS_LIST[27].minprice = 90;

SHIP_ITEMS_LIST[28].description = {"Жир из-под боков кротокрыса.", "Отличный ингредиент."};
SHIP_ITEMS_LIST[28].minprice = 3;

SHIP_ITEMS_LIST[29].description = {"Гравировка: Миртана.", "Имеет небольшие потертости."};
SHIP_ITEMS_LIST[29].minprice = 20;

SHIP_ITEMS_LIST[30].description = {"Посуда для употребления пищи.", "Сделано из серебра."};
SHIP_ITEMS_LIST[30].minprice = 10;

SHIP_ITEMS_LIST[31].description = {"Позолочена, новенькая.", "За Инноса!"};
SHIP_ITEMS_LIST[31].minprice = 15;

SHIP_ITEMS_LIST[32].description = {"Такую штуковину найти - большая удача."};
SHIP_ITEMS_LIST[32].minprice = 30;

SHIP_ITEMS_LIST[33].description = {"Полезное ископаемое.", "Популярно у магов."};
SHIP_ITEMS_LIST[33].minprice = 30;

SHIP_ITEMS_LIST[34].description = {"Многофункциональная вещь."};
SHIP_ITEMS_LIST[34].minprice = 5;

SHIP_ITEMS_LIST[35].description = {"Прямиком из пустынь Варанта.", "Особой терпкости."};
SHIP_ITEMS_LIST[35].minprice = 40;

SHIP_ITEMS_LIST[36].description = {"Прямиком из пустынь Варанта.", "Немного вяжет."};
SHIP_ITEMS_LIST[36].minprice = 40;

SHIP_ITEMS_LIST[37].description = {"Прямиком из пустынь Варанта.", "Для настоящий ценителей."};
SHIP_ITEMS_LIST[37].minprice = 40;

SHIP_ITEMS_LIST[38].description = {"Прямиком из пустынь Варанта.", "Табачок в радость."};
SHIP_ITEMS_LIST[38].minprice = 40;

SHIP_ITEMS_LIST[39].description = {"Прямиком из пустынь Варанта.", "Особой крепкости"};
SHIP_ITEMS_LIST[39].minprice = 40;

SHIP_ITEMS_LIST[40].description = {"Болотник низкого качества", "Вызывает зависимость", "+30 энергии."};
SHIP_ITEMS_LIST[40].minprice = 5;

SHIP_ITEMS_LIST[41].description = {"Болотник среднего качества.", "Вызывает зависимость", "+45 энергии."};
SHIP_ITEMS_LIST[41].minprice = 6;

SHIP_ITEMS_LIST[42].description = {"Болотник высшего качества.", "Вызывает зависимость", "+60 энергии."};
SHIP_ITEMS_LIST[42].minprice = 7;

SHIP_ITEMS_LIST[43].description = {"Главное не жевать."};
SHIP_ITEMS_LIST[43].minprice = 5;

SHIP_ITEMS_LIST[44].description = {"Главное не трогать руками."};
SHIP_ITEMS_LIST[44].minprice = 8;

SHIP_ITEMS_LIST[45].description = {"Очень популярно у алхимиков."};
SHIP_ITEMS_LIST[45].minprice = 11;

SHIP_ITEMS_LIST[46].description = {"Что-то вроде подорожника."};
SHIP_ITEMS_LIST[46].minprice = 5;

SHIP_ITEMS_LIST[47].description = {"Можно сделать компресс на сутки."};
SHIP_ITEMS_LIST[47].minprice = 8;

SHIP_ITEMS_LIST[48].description = {"Очень популярно у алхимиков."};
SHIP_ITEMS_LIST[48].minprice = 11;

SHIP_ITEMS_LIST[49].description = {"Терпкий и сладкий вкус."};
SHIP_ITEMS_LIST[49].minprice = 2;

SHIP_ITEMS_LIST[50].description = {"Не знаем, как это оказалось на корабле.", "Берите почти даром."};
SHIP_ITEMS_LIST[50].minprice = 2;

SHIP_ITEMS_LIST[51].description = {"Берите, дорогие, у нас таких много растет."};
SHIP_ITEMS_LIST[51].minprice = 10;

SHIP_ITEMS_LIST[52].description = {"Восстанавливает маг. силу.", "Не магам не брать."};
SHIP_ITEMS_LIST[52].minprice = 15;

SHIP_ITEMS_LIST[53].description = {"Стягивает раны и лечит простые холеры."};
SHIP_ITEMS_LIST[53].minprice = 15;

SHIP_ITEMS_LIST[54].description = {"Необычная разработка алхимиков.", "Словно сам Иннос дал сил."};
SHIP_ITEMS_LIST[54].minprice = 60;

SHIP_ITEMS_LIST[55].description = {"Можно и чужой череп раздробить.", "Одноручное.", "Тир 2 (урон 30)."};
SHIP_ITEMS_LIST[55].minprice = 150;

SHIP_ITEMS_LIST[56].description = {"Идеальная работа кузнеца-любителя", "Одноручное.", "Тир 2 (урон 30)."};
SHIP_ITEMS_LIST[56].minprice = 150;

SHIP_ITEMS_LIST[57].description = {"Легкая и удобная.", "Одноручное.", "Тир 2 (урон 30)."};
SHIP_ITEMS_LIST[57].minprice = 150;

SHIP_ITEMS_LIST[58].description = {"Оружие моряка.", "Одноручное", "Тир 1 (урон 20)."};
SHIP_ITEMS_LIST[58].minprice = 80;


function _doRandomAmount()
	
	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i].code ~= nil then
			if string.find(SHIP_ITEMS_LIST[i].code, "itfo") then
				SHIP_ITEMS_LIST[i].amount = math.random(10, 20);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "itpl") then
				SHIP_ITEMS_LIST[i].amount = math.random(10, 30);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "itpo") then
				SHIP_ITEMS_LIST[i].amount = math.random(5, 10);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "itmw") then
				SHIP_ITEMS_LIST[i].amount = math.random(1, 10);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "itmi") then
				SHIP_ITEMS_LIST[i].amount = math.random(8, 30);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "itat") then
				SHIP_ITEMS_LIST[i].amount = math.random(10, 20);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "ithl") then
				SHIP_ITEMS_LIST[i].amount = math.random(1, 3);

			elseif string.find(SHIP_ITEMS_LIST[i].code, "mask") then
				SHIP_ITEMS_LIST[i].amount = math.random(1, 3);
			else
				SHIP_ITEMS_LIST[i].amount = math.random(1, 15);
			end
		end
	end

end

function _getIdSItem(code)

	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i].code == code then
			return i;
		end
	end
	return 0;

end

function _getAmountSItem(code)

	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i].code == code then
			return SHIP_ITEMS_LIST[i].amount;
		end
	end
	return 0;

end

function _getPriceSItem(code)

	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i].code == code then
			local min = SHIP_ITEMS_LIST[i].minprice;
			local all = SHIP_ITEMS_LIST[i].price;
			return min, all;
		end
	end
	return 0;

end

function _doRandomPrice()

	for i = 1, 100 do
		if SHIP_ITEMS_LIST[i].code ~= nil then
			SHIP_ITEMS_LIST[i].price = SHIP_ITEMS_LIST[i].minprice + math.random(5, 20);
		end
	end

end
