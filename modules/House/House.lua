
--  #   House system by royclapton  #
--  #         version: 0.2          #

local HOUSE_TEXTURE = CreateTexture(6191, 86.5, 8125.5, 3275, 'menu_ingame')

_HOUSE_IDS = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37};

_HOUSE_XYZ = {};
_HOUSE_XYZ[1] = {-9999999, -9999999, -9999999, 520, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[2] = {-9999999, -9999999, -9999999, 550, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[3] = {-9999999, -9999999, -9999999, 540, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[4] = {-9999999, -9999999, -9999999, 600, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[5] = {-9999999, -9999999, -9999999, 400, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[6] = {-9999999, -9999999, -9999999, 330, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[7] = {-9999999, -9999999, -9999999, 580, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[8] = {-9999999, -9999999, -9999999, 540, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[9] = {-9999999, -9999999, -9999999, 600, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[10] = {-9999999, -9999999, -9999999, 550, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[12] = {-9999999, -9999999, -9999999, 600, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[13] = {-9999999, -9999999, -9999999, 600, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[14] = {-9999999, -9999999, -9999999, 590, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[15] = {-9999999, -9999999, -9999999, 530, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[16] = {-9999999, -9999999, -9999999, 550, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[17] = {-9999999, -9999999, -9999999, 550, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[18] = {-9999999, -9999999, -9999999, 570, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[19] = {-9999999, -9999999, -9999999, 560, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[20] = {-9999999, -9999999, -9999999, 520, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[21] = {-9999999, -9999999, -9999999, 520, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[22] = {-9999999, -9999999, -9999999, 113, "FULLWORLD2.ZEN"};
_HOUSE_XYZ[23] = {-33629.04296875, -1827.0733642578, 22748.98828125, 250, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[24] = {-33441.6875, -1842.494140625, 22397.775390625, 250, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[25] = {-34242.390625, -1525.1009521484, 21103.818359375, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[26] = {-33991.484375, -1815.6989746094, 17931.09375, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[27] = {-36808.24609375, -1841.6091308594, 16624.21875, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[28] = {-37385.4609375, -1842.4489746094, 18188.755859375, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[29] = {-36444.09375, -1853.5238037109, 19260.216796875, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[30] = {-39375.71484375, -1987.7312011719, 19947.13671875, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[31] = {-38483.87890625, -1973.0523681641, 21085.724609375, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[32] = {-37844.2421875, -1991.2241210938, 22552.29296875, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[33] = {-40716.13671875, -1992.7487792969, 20319.7421875, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[34] = {-40062.4375, -1973.2155761719, 21805.994140625, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[35] = {-39155.875, -1992.0305175781, 23062.884765625, 480, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[36] = {-28272.23828125, -1862.8305664063, 27465.728515625, 1100, "ADDONWORLD2.ZEN"};
_HOUSE_XYZ[37] = {-5612.2739257813, -1106.2515869141, -6456.3588867188, 1100, "ADDONWORLD2.ZEN"};

_HOUSE_POSITIONS = {

    { item_instance = "RC_HOUSE_TABLE_LOW", model3d = "KM_VOB_TAVERN_TABLE_01.3DS", name = "Низкий стол"},
    { item_instance = "RC_HOUSE_TABLE_POOR", model3d = "OC_TABLE_V2.3DS", name = "Дешевый стол"},
    { item_instance = "RC_HOUSE_TABLE_MIDDLE_1", model3d = "NW_CITY_TABLE_PEASANT_01.3DS", name = "Обычный стол (1)"},
    { item_instance = "RC_HOUSE_TABLE_MIDDLE_2", model3d = "NW_CITY_TABLE_NORMAL_01.3DS", name = "Обычный стол (2)"},
    { item_instance = "RC_HOUSE_TABLE_RICH", model3d = "NW_CITY_TABLE_RICH_02.3DS", name = "Дорогой стол"},
    { item_instance = "RC_HOUSE_TABLE_LONG", model3d = "OC_LOB_TABLE_HEAVY_LONG.3DS", name = "Длинный стол в гостинную"},
    { item_instance = "RC_HOUSE_TABLE_CIRCLE", model3d = "TOM_WATERCIRCLE_TABLE.3DS", name = "Круглый стол в гостинную"},
    { item_instance = "RC_HOUSE_TABLE_WORK", model3d = "KM_VOB_TABLESHELVES.3DS", name = "Рабочее место (стол + полки)"},
    { item_instance = "RC_HOUSE_CUPBOARD_POOR", model3d = "NW_CITY_CUPBOARD_POOR_01.3DS", name = "Дешевый шкаф"},
    { item_instance = "RC_HOUSE_CUPBOARDLOW_POOR", model3d = "NW_CITY_CUPBOARD_POOR_02.3DS", name = "Дешевый комод"},
    { item_instance = "RC_HOUSE_CUPBOARD_RICH", model3d = "NW_CITY_CUPBOARD_RICH_01.3DS", name = "Дорогой шкаф"},
    { item_instance = "RC_HOUSE_WARDROBE_RICH", model3d = "KM_VOB_WARDROBE_01.3DS", name = "Дорогой гардероб"},
    { item_instance = "RC_HOUSE_CUPBOARDLOW_RICH", model3d = "NW_CITY_CUPBOARD_RICH_02.3DS", name = "Дорогой комод"},
    { item_instance = "RC_HOUSE_SHELF_WEAPON", model3d = "OC_WEAPON_SHELF_EMPTY_V2.3DS", name = "Стенд для оружия (1)"},
    { item_instance = "RC_HOUSE_SHELF", model3d = "DT_SHELF_V1.3DS", name = "Пустые полки (ряд)"},
    { item_instance = "RC_HOUSE_SHELFLOW", model3d = "OC_MOB_SHELVES_SMALL.3DS", name = "Пустые полки (низкие-ряд)"},
    { item_instance = "RC_HOUSE_SHELFBOTTLE", model3d = "KM_VOB_WINEBOTTLE_STAND_02.3DS", name = "Полки с бутылями (ряд)"},
    { item_instance = "RC_HOUSE_SHELFWALL_1", model3d = "OC_SHELF_V4.3DS", name = "Настенная полка (1)"},
    { item_instance = "RC_HOUSE_SHELFWALL_2", model3d = "LOA_REGAL_B_BOOK_01.3DS", name = "Настенная полка (2)"},
    { item_instance = "RC_HOUSE_SHELFBIG", model3d = "KM_VOB_NORMAL_SHELF_01.3DS", name = "Широкая полка"},
    { item_instance = "RC_HOUSE_SHELFRICH", model3d = "KM_LAKOMY_SINGLE_OPEN_STORAGE_01.3DS", name = "Большая дорогая полка (ряд)"},
    { item_instance = "RC_HOUSE_SCROLLSTAND", model3d = "KM_VOB_SCRIBE_SCROLLSTAND_01.3DS", name = "Стенд для писем"},
    { item_instance = "RC_HOUSE_OTHERSTAND", model3d = "KM_VOB_COUNTER_01.3DS", name = "Стойка для вещей"},
    { item_instance = "RC_HOUSE_ARMCHAIR_ROFL", model3d = "NW_DRAGONISLE_TORTURE_05.3DS", name = "Кресло с шипами"},
    { item_instance = "RC_HOUSE_ARMCHAIR_WOOD", model3d = "THRONE_BIG.ASC", name = "Деревянное кресло с обшивкой"},
    { item_instance = "RC_HOUSE_ARMCHAIR_RICH", model3d = "THRONE_NW_CITY_01.ASC", name = "Кожаное кресло"},
    { item_instance = "RC_HOUSE_HIGHCHAIR_RICH", model3d = "THRONENEW_RICH.ASC", name = "Высокий дорогой стул с вырезами"},
    { item_instance = "RC_HOUSE_LOWCHAIR_RICH", model3d = "CHAIR_NW_EDEL_01.ASC", name = "Дорогой табурет"},
    { item_instance = "RC_HOUSE_LOWCHAIR_NORMAL", model3d = "CHAIR_NW_NORMAL_01.ASC", name = "Обычный табурет"},
    { item_instance = "RC_HOUSE_LOWCHAIR_POOR", model3d = "CHAIR_1_OC.ASC", name = "Дешевый табурет"},
    { item_instance = "RC_HOUSE_LOWCHAIR_WOOD", model3d = "CHAIR_1_NC.ASC", name = "Пенек"},
    { item_instance = "RC_HOUSE_SOFA_BLUE", model3d = "SOFA_BLUE.ASC", name = "Диван обшитый синей тканью"},
    { item_instance = "RC_HOUSE_SOFA_RED", model3d = "SOFA_BROTHEL.ASC", name = "Диван обшитый красной тканью"},
    { item_instance = "RC_HOUSE_BED_BAD", model3d = "BEDHIGH_PSI.ASC", name = "Плохая кровать"},
    { item_instance = "RC_HOUSE_BED_POOR", model3d = "BEDHIGH_NW_NORMAL_01.ASC", name = "Дешевая кровать"},
    { item_instance = "RC_HOUSE_BED_NORMAL", model3d = "BEDHIGH_NW_EDEL_01.ASC", name = "Обычная кровать"},
    { item_instance = "RC_HOUSE_BED_RICH", model3d = "BEDHIGH_NW_MASTER_01.ASC", name = "Дорогая кровать"},
    { item_instance = "RC_HOUSE_CARPET_1", model3d = "KM_VOB_CARPET_06.3DS", name = "Синий ковер (звезда)"},
    { item_instance = "RC_HOUSE_CARPET_2", model3d = "KM_VOB_CARPET_03.3DS", name = "Красный ковер (звезда)"},
    { item_instance = "RC_HOUSE_CARPET_3", model3d = "KM_VOB_PICNIC_BLANKET_01.3DS", name = "Обычный ковер (белый)"},
    { item_instance = "RC_HOUSE_CARPET_4", model3d = "KM_VOB_CARPET_05.3DS", name = "Синий длинный ковер (звезда)"},
    { item_instance = "RC_HOUSE_CARPET_5", model3d = "DT_CARPET_ROUND_03.3DS", name = "Синий большой ковер (звезда)"},
    { item_instance = "RC_HOUSE_CARPET_6", model3d = "KM_VOB_CARPET_07.3DS", name = "Обычный ковер (синий)"},
    { item_instance = "RC_HOUSE_CARPET_7", model3d = "DT_CARPET_ROUND_01.3DS", name = "Красный большой ковер (звезда)"},
    { item_instance = "RC_HOUSE_CARPET_8", model3d = "NW_CITY_CARPET_03.3DS", name = "Обычный ковер (1)"},
    { item_instance = "RC_HOUSE_CARPET_9", model3d = "NW_CITY_CARPET_01.3DS", name = "Обычный ковер (2)"},
    { item_instance = "RC_HOUSE_CARPET_10", model3d = "NW_CITY_CARPET_02.3DS", name = "Обычный ковер (в виде ромба)"},
    { item_instance = "RC_HOUSE_PICTURE_1", model3d = "KM_PICTURE_01_A.3DS", name = "Картина (1)"},
    { item_instance = "RC_HOUSE_PICTURE_2", model3d = "KH_DECO_PICTURE_03.3DS", name = "Картина (2)"},
    { item_instance = "RC_HOUSE_PICTURE_3", model3d = "KH_DECO_PICTURE_02.3DS", name = "Картина (3)"},
    { item_instance = "RC_HOUSE_PICTURE_4", model3d = "LC_PICTURE_06.3DS", name = "Картина (4 / Большая)"},
    { item_instance = "RC_HOUSE_PICTURE_5", model3d = "LC_PICTURE_02.3DS", name = "Картина (5)"},
    { item_instance = "RC_HOUSE_PICTURE_6", model3d = "LC_PICTURE_01.3DS", name = "Картина (6)"},
    { item_instance = "RC_HOUSE_PICTURE_7", model3d = "KM_VOB_PICTURE_BIG_01.3DS", name = "Картина (7)"},
    { item_instance = "RC_HOUSE_PICTURE_8", model3d = "KM_VOB_MAP_01.3DS", name = "Карта Архолос (8)"},
    { item_instance = "RC_HOUSE_PICTURE_9", model3d = "LC_PICTURE_04.3DS", name = "Картина (9)"},
    { item_instance = "RC_HOUSE_PICTURE_10", model3d = "LC_PICTURE_07.3DS", name = "Картина (9)"},
    { item_instance = "RC_HOUSE_CANVAS_WHITE", model3d = "KM_VOB_HANGINGCLOTH_01.3DS", name = "Белая тряпка (на стену)"},
    { item_instance = "RC_HOUSE_CANVAS_YELLOW", model3d = "KM_VOB_CURTAIN_05.3DS", name = "Желтое полотно (на стену)"},
    { item_instance = "RC_HOUSE_CANVAS_BLUE", model3d = "KM_VOB_CURTAIN_03.3DS", name = "Синее полотно (на стену)"},
    { item_instance = "RC_HOUSE_CANVAS_RED", model3d = "KM_VOB_CURTAIN_01.3DS", name = "Красное полотно (на стену)"},
    { item_instance = "RC_HOUSE_CANVAS_MYRTANA", model3d = "KM_VOB_WALL_BANNER_01.3DS", name = "Герб Миртаны (на стену)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_1", model3d = "KM_VOB_WOLFSDEN_HANGING_ARMOR_01.3DS", name = "Настенный стенд с доспехами (1)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_2", model3d = "KM_VOB_ARMORER_ARMOR_01.3DS", name = "Стенд с доспехами (1)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_3", model3d = "KM_VOB_ARMORER_ARMOR_02.3DS", name = "Стенд с доспехами (2)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_4", model3d = "KM_VOB_ARMORER_ARMOR_03.3DS", name = "Стенд с доспехами (3)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_5", model3d = "KM_VOB_GUARD_DUMMY_01.3DS", name = "Стенд с доспехами (стража)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_6", model3d = "KM_VOB_HANGING_GUARD_ARMOR_01.3DS", name = "Настенный стенд с доспехами (2)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_7", model3d = "OC_WEAPON_WALLARMOR.3DS", name = "Настенный стенд с доспехами (2)"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_8", model3d = "XR_SCHNEIDER_KLEID.3DS", name = "Стенд с платьем"},
    { item_instance = "RC_HOUSE_STAND_ARMOR_9", model3d = "OC_WEAPON_ARMORSHOES.3DS", name = "Настенный стенд с сапогами"},
    { item_instance = "RC_HOUSE_STAND_WEAPON_1", model3d = "NW_CITY_WEAPON_BARREL_01.3DS", name = "Бочка с мечами (1)"},
    { item_instance = "RC_HOUSE_STAND_WEAPON_2", model3d = "NW_CITY_WEAPON_BAG_01.3DS", name = "Мечи в ножнах (набор)"},
    { item_instance = "RC_HOUSE_STAND_WEAPON_3", model3d = "KM_CITY_WEAPON_BARREL_01.3DS", name = "Бочка с мечами (2)"},
    { item_instance = "RC_HOUSE_BOOKSHELF_1", model3d = "DT_BOOKSHELF_V2.3DS", name = "Большая книжная полка (ряд)"},
    { item_instance = "RC_HOUSE_BOOKSHELF_2", model3d = "BOOK_NW_CITY_CUPBOARD_01.ASC", name = "Стенд с открытой книгой"},
    { item_instance = "RC_HOUSE_BOOKSHELF_3", model3d = "BOOKSHELF_NORMAL01.ASC", name = "Средняя книжная полка (1 / ряд)"},
    { item_instance = "RC_HOUSE_BOOKSHELF_4", model3d = "WRITING_TABLE.ASC", name = "Стол для написания свитков"},
    { item_instance = "RC_HOUSE_BOOKSHELF_5", model3d = "NW_CITY_CNSTBOOKSHELF_01.3DS", name = "Малая книжная полка (ряд)"},
    { item_instance = "RC_HOUSE_BOOKSHELF_6", model3d = "KM_VOB_MERCHANT_BOOKSTAND_01.3DS", name = "Малая книжная полка"},
    { item_instance = "RC_HOUSE_BOOKSHELF_7", model3d = "KB_BUCHREGAL_02.3DS", name = "Средняя книжная полка (2 / ряд)"},
    { item_instance = "RC_HOUSE_BOOKS_1", model3d = "KM_VOB_BOOKS_04.3DS", name = "Стопка книг (1)"},
    { item_instance = "RC_HOUSE_BOOKS_2", model3d = "LOA_BOOK8.3DS", name = "Толстая красная книга"},
    { item_instance = "RC_HOUSE_BOOKS_3", model3d = "NW_CITY_MAP_WAR_CLOSED_01.3DS", name = "Завернутый пергамент с печатью"},
    { item_instance = "RC_HOUSE_BOOKS_4", model3d = "KM_ITEM_BOOK_05.3DS", name = "Зеленая книга"},
    { item_instance = "RC_HOUSE_BOOKS_5", model3d = "KM_VOB_BOOKS_02.3DS", name = "Стопка книг (2)"},
    { item_instance = "RC_HOUSE_BOOKS_6", model3d = "KM_VOB_BOOKS_01.3DS", name = "Стопка книг (3)"},
    { item_instance = "RC_HOUSE_BOOKS_7", model3d = "KM_ITEM_SCROLL_7.3DS", name = "Пустой свиток"},
    { item_instance = "RC_HOUSE_BOOKS_8", model3d = "ITWR_MAP_NW_CITY.3DS", name = "Маленькая карта Хориниса"},
    { item_instance = "RC_HOUSE_BOOKS_9", model3d = "KM_ITEM_SCROLL_8.3DS", name = "Свиток"},
    { item_instance = "RC_HOUSE_BOOKS_10", model3d = "KM_VOB_MERCHANT_NOTEBOOK_01.3DS", name = "Открытый дневник"},
    { item_instance = "RC_HOUSE_BOOKS_11", model3d = "KM_VOB_INKWELL.3DS", name = "Перо и чернила"},
    { item_instance = "RC_HOUSE_WARE_1", model3d = "ITFO_LAKOMY_METAL_BEER_MUG_EMPTY_01.3DS", name = "Железный бокал"},
    { item_instance = "RC_HOUSE_WARE_2", model3d = "ITFO_MEATPACKS.3DS", name = "Тарелка с голубцами"},
    { item_instance = "RC_HOUSE_WARE_3", model3d = "KM_VOB_WICKERBASKET_01.3DS", name = "Тарелка под еду"},
    { item_instance = "RC_HOUSE_WARE_4", model3d = "ITMI_STUFF_SILVERWARE_01.3DS", name = "Столовые приборы"},
    { item_instance = "RC_HOUSE_WARE_5", model3d = "LAKOMY_BEER_BOX_PEASANT_01.3DS", name = "Корзинка с пивом"},
    { item_instance = "RC_HOUSE_WARE_6", model3d = "KM_VOB_MERCHANT_BOWL_01.3DS", name = "Маленькое блюдо"},
    { item_instance = "RC_HOUSE_WARE_7", model3d = "KM_VOB_MERCHANT_SOUPCAULDRON_03.3DS", name = "Кастрюля ухи"},
    { item_instance = "RC_HOUSE_WARE_8", model3d = "KM_VOB_MERCHANT_SOUPCAULDRON_01.3DS", name = "Кастрюля солянки"},
    { item_instance = "RC_HOUSE_WARE_9", model3d = "KM_VOB_METAL_FOODCONTAINER_04.3DS", name = "Железный контейнер с картошкой"},
    { item_instance = "RC_HOUSE_WARE_10", model3d = "KM_VOB_POT_01.3DS", name = "Кастрюля с ручкой"},
    { item_instance = "RC_HOUSE_WARE_11", model3d = "OC_KITCHENSTUFF_V01.3DS", name = "Сушеные овощи на веревке"},
    { item_instance = "RC_HOUSE_WARE_12", model3d = "KM_VOB_WINEBOTTLE_01.3DS", name = "Бутыль вина"},
    { item_instance = "RC_HOUSE_WARE_13", model3d = "ITFO_BEER_01.3DS", name = "Бутыль пива"},
    { item_instance = "RC_HOUSE_WARE_14", model3d = "ITMI_STUFF_CUP_02.3DS", name = "Деревянный кубок"},
    { item_instance = "RC_HOUSE_WARE_15", model3d = "ITFO_BOOZE.3DS", name = "Бутыль джина"},
    { item_instance = "RC_HOUSE_WARE_16", model3d = "ITFO_LAKOMY_BOTTLE_02.3DS", name = "Бутыль разбавленного спирта"},
    { item_instance = "RC_HOUSE_WARE_17", model3d = "ITFO_LAKOMY_WINE_02.3DS", name = "Бутыль дорогого вина"},
    { item_instance = "RC_HOUSE_WARE_18", model3d = "ITFO_LAKOMY_BEER_01.3DS", name = "Бутыль дорогого пива"},
    { item_instance = "RC_HOUSE_WARE_19", model3d = "LAKOMY_BEER_CRATE_PEASANT_01.3DS", name = "Закрытый ящик с пивом"},
    { item_instance = "RC_HOUSE_WARE_20", model3d = "KM_NEW_BOTTLE_01.3DS", name = "Бутыль браги"},
    { item_instance = "RC_HOUSE_WARE_21", model3d = "KM_VOB_GRAPECRATE_01.3DS", name = "Ящик с виноградом"},
    { item_instance = "RC_HOUSE_WARE_22", model3d = "KM_VOB_CASEOFBEER_01.3DS", name = "Ящик бутылок"},
    { item_instance = "RC_HOUSE_WARE_23", model3d = "ITFO_FISHCOTLET.3DS", name = "Тарелка с мясом в травах"},
    { item_instance = "RC_HOUSE_WARE_24", model3d = "ITFO_FISHFILLETPERM.3DS", name = "Тарелка с рыбой в травах"},
    { item_instance = "RC_HOUSE_WARE_25", model3d = "ITFO_WATER.3DS", name = "Бутыль воды"},
    { item_instance = "RC_HOUSE_WARE_26", model3d = "ITFO_MUSHROOMSOUP.3DS", name = "Тарелка каши"},
    { item_instance = "RC_HOUSE_WARE_27", model3d = "ITFO_BEER.3DS", name = "Бокал пива"},
    { item_instance = "RC_HOUSE_WARE_28", model3d = "KM_VOB_WINEBOTTLE_BOX_01.3DS", name = "Ящик вина"},
    { item_instance = "RC_HOUSE_WARE_29", model3d = "ITFO_POTION_WATER_01.3DS", name = "Бутыль чистого спирта"},
    { item_instance = "RC_HOUSE_WARE_30", model3d = "ITMI_SILVERBOWL_01.3DS", name = "Серебряная глубокая чаша"},
    { item_instance = "RC_HOUSE_WARE_31", model3d = "ITMI_SILVERCUP.3DS", name = "Серебряный дорогой кубок"},
    { item_instance = "RC_HOUSE_WARE_32", model3d = "KM_VOB_FRESHMEAT_03.3DS", name = "Стенд с колбасами"},
    { item_instance = "RC_HOUSE_WARE_33", model3d = "KM_VOB_PACKAGE_01.3DS", name = "Запечатанный тюк"},
    { item_instance = "RC_HOUSE_WARE_34", model3d = "KM_VOB_BASKET_WITH_CARROTS_01.3DS", name = "Корзинка с морковью"},
    { item_instance = "RC_HOUSE_WARE_35", model3d = "ITMI_FISHCRATE_SMALL_02.3DS", name = "Ящик рыбы"},
    { item_instance = "RC_HOUSE_WARE_36", model3d = "KM_VOB_MERCHANT_FOODBOX_02.3DS", name = "Ящик овощей"},
    { item_instance = "RC_HOUSE_WARE_37", model3d = "KM_VOB_MERCHANT_WEEDBOX_01.3DS", name = "Ящик трав"},
    { item_instance = "RC_HOUSE_WARE_38", model3d = "KM_VOB_FLOWERS_03.3DS", name = "Малый ящик цветов"},
    { item_instance = "RC_HOUSE_CREATE_1", model3d = "AW_CRATE_01.3DS", name = "Обычный ящик"},
    { item_instance = "RC_HOUSE_CREATE_2", model3d = "NW_HARBOUR_CRATEPILE_01.3DS", name = "Гора ящиков"},
    { item_instance = "RC_HOUSE_CREATE_3", model3d = "KM_VOB_SULFUR_CRATE.3DS", name = "Малый ящик"},
    { item_instance = "RC_HOUSE_CREATE_4", model3d = "OC_FIREWOOD_V2.3DS", name = "Ящик с дровами"},
    { item_instance = "RC_HOUSE_CREATE_5", model3d = "KM_VOB_SALT_CHEST_01.3DS", name = "Старый ящик"},
    { item_instance = "RC_HOUSE_CREATE_6", model3d = "NW_HARBOUR_CRATEBROKEN_01.3DS", name = "Разбитый ящик"},
    { item_instance = "RC_HOUSE_BARREL_1", model3d = "NW_HARBOUR_BARREL_01.3DS", name = "Обычная бочка"},
    { item_instance = "RC_HOUSE_BARREL_2", model3d = "TRINKFASS_MESH.ASC", name = "Бочка с водой"},
    { item_instance = "RC_HOUSE_BARREL_3", model3d = "BSCOOL_OC.MDS", name = "Ведро воды"},
    { item_instance = "RC_HOUSE_BARREL_4", model3d = "KM_VOB_BARRELTABLE_02.3DS", name = "Накрытая полотном бочка"},
    { item_instance = "RC_HOUSE_BARREL_5", model3d = "NW_CITY_BEERBARREL_02.3DS", name = "Огромная пивная бочка"},
    { item_instance = "RC_HOUSE_BARREL_6", model3d = "NW_HARBOUR_BARRELGROUP_02.3DS", name = "Груда бочек (разбросаны)"},
    { item_instance = "RC_HOUSE_BARREL_7", model3d = "NW_HARBOUR_BARRELGROUP_01.3DS", name = "Груда бочек (собраны)"},
    { item_instance = "RC_HOUSE_BARREL_8", model3d = "KM_VOB_BARRELTABLE_04.3DS", name = "Груда бочек (накрыты полотном)"},
    { item_instance = "RC_HOUSE_STOVE_DEFAULT", model3d = "STOVE_NW_CITY_01.ASC", name = "Обычная плита"}

}

function _developGetAllObjects(id)

    if Player[id].astatus > 5 then
        for i = 1, table.getn(_HOUSE_POSITIONS) do
            GiveItem(id, _HOUSE_POSITIONS[i].item_instance, 1);
        end
        SaveItems(id);
    end

end
addCommandHandler({"/дом_объекты"}, _developGetAllObjects);

function _houseGetModelByInstance(item_instance)
	if item_instance and type(item_instance) == "string" then
		for key, model in ipairs(_HOUSE_POSITIONS) do
			if string.upper(item_instance) == model.item_instance then
				return model.model3d
			end
		end
	end
	return nil
end

function _houseGetNameByModel(model3d)
	if model3d and type(model3d) == "string" then
		for key, obj in ipairs(_HOUSE_POSITIONS) do
			if string.upper(model3d) == obj.model3d then
				return obj.name
			end
		end
	end
	return nil
end

_HOUSE = {};
for i = 1, table.getn(_HOUSE_XYZ) do
    if _HOUSE_XYZ[i] ~= nil then
        _HOUSE[i] = {};
        _HOUSE[i].owner = nil;
		_HOUSE[i].world = nil;
        _HOUSE[i].objects = {};
        for k = 1, 30 do
            _HOUSE[i].objects[k] = {nil};
        end
    end
end


function _houseInit()
    
	print(" ");
    print("=====================")
    print("     House system    ")
    

    for house = 1, table.getn(_HOUSE_XYZ) do
        if _HOUSE_XYZ[house] ~= nil then
            local file = io.open("Database/House/House_ID"..house..".txt", "r");
            if file then
                
				_HOUSE[house].world = _HOUSE_XYZ[house][5];
				
                line = file:read("*l");
                local l, owner = sscanf(line, "s");
                if l == 1 then
                    _HOUSE[house].owner = owner;
                end

                for line in file:lines() do
                    local l, vobModel, vType, x, y, z, rx, ry, rz = sscanf(line, "ssffffff");
                    if l == 1 then
                        
                        for slot = 1, table.getn(_HOUSE[house].objects) do
                            if _HOUSE[house].objects[slot][1] == nil then
                                table.remove(_HOUSE[house].objects[slot], 1);
                                table.insert(_HOUSE[house].objects[slot], vobModel);
                                table.insert(_HOUSE[house].objects[slot], vType);
                                table.insert(_HOUSE[house].objects[slot], x);
                                table.insert(_HOUSE[house].objects[slot], y);
                                table.insert(_HOUSE[house].objects[slot], z);
                                table.insert(_HOUSE[house].objects[slot], rx);
                                table.insert(_HOUSE[house].objects[slot], ry);
                                table.insert(_HOUSE[house].objects[slot], rz);

                                if vType == "MOB" then
                                    table.insert(_HOUSE[house].objects[slot], Mob.Create(vobModel, _house_ObjectGetMobname(vobModel), 1, _house_ObjectGetScheme(vobModel), "", _HOUSE[house].world, x, y, z));
                                    Mob.SetRotation(_HOUSE[house].objects[slot][9], rx, ry, rz)
                                
                                elseif vType == "VOB" then
                                    table.insert(_HOUSE[house].objects[slot], Vob.Create(vobModel, _HOUSE[house].world, x, y, z));
                                    Vob.SetRotation(_HOUSE[house].objects[slot][9], rx, ry, rz)
                                end

                                break
                            end
                        end

                    end
                end

                print("("..house..") Owner: ".._HOUSE[house].owner.." / Objects: ".._houseGetValueObjects(house).." / World: ".._HOUSE[house].world)
            else
                local fileW = io.open("Database/House/House_ID"..house..".txt", "w");
                fileW:write("Город\n");
                fileW:close();
            end
        end
    end

    print("=====================")
	
	
end

function _houseGetValueObjects(house)
    
    local count = 0;
    for i = 1, table.getn(_HOUSE[house].objects) do
        if _HOUSE[house].objects[i][1] ~= nil then
            count = count + 1;
        end
    end
    return count;

end


function _houseConnect(id)

    _cityHouseConnect(id);

    Player[id]._house_Draws = {};
    Player[id]._house_Draws[1] = CreatePlayerDraw(id, 0, 0, "# Перемещение: WASD.")
    Player[id]._house_Draws[2] = CreatePlayerDraw(id, 0, 0, "# Скорость: '-' и '+'")
    Player[id]._house_Draws[3] = CreatePlayerDraw(id, 0, 0, "# Наклон: стрелки.")
    Player[id]._house_Draws[4] = CreatePlayerDraw(id, 0, 0, "# Высота: ZX")
    Player[id]._house_Draws[5] = CreatePlayerDraw(id, 0, 0, "# Сбросить наклон: R")
    Player[id]._house_Draws[6] = CreatePlayerDraw(id, 0, 0, "# Сохранить: /дом_сохранить.")
    Player[id]._house_Draws[7] = CreatePlayerDraw(id, 0, 0, "# Подвердить: /дом_да.")
    Player[id]._house_Draws[8] = CreatePlayerDraw(id, 0, 0, "------------------------------")
    Player[id]._house_Draws[9] = CreatePlayerDraw(id, 0, 0, "")
    Player[id]._house_Draws[10] = CreatePlayerDraw(id, 0, 0, "")
    Player[id]._house_Draws[11] = CreatePlayerDraw(id, 0, 0, "")

    for i = 1, table.getn(Player[id]._house_Draws) do
        SetPlayerDrawPos(id, Player[id]._house_Draws[i], 6284, 170 + 200 * i);
    end

    Player[id]._house_Vobbing = false; -- состояние обустройства дома (установка новых объектов);
    Player[id]._house_Editing = false; -- состояние редактирования дома (изменение существующих объектов);

    Player[id]._house_EditingObject = nil;

    Player[id]._house_Accept = false; -- статус подтверждения действия
    Player[id]._house_Accept_Object = nil; -- подтверждаемый объект
    Player[id]._house_Accept_Object_Timer = nil; -- таймер для подтверждения

    Player[id]._house_Current = nil; -- над каким домом сейчас проводятся работы

    Player[id]._house_Vob = nil; -- объект для работы
    Player[id]._house_VobPos = {-9999, -9999, -9999}; -- текущее положение объекта
    Player[id]._house_VobRot = {0, 0, 0}; -- текущий угол объекта

    Player[id]._house_PositionCheker = nil; -- таймер, проверяющий координаты игрока (чтобы не упиздил куда-то в режиме обустройства).

    Player[id]._house_MoveTimer = nil;

    Player[id]._house_W = 0;
    Player[id]._house_A = 0;
    Player[id]._house_S = 0;
    Player[id]._house_D = 0;

    Player[id]._house_Z = 0;
    Player[id]._house_X = 0;

    Player[id]._house_Up = 0;
    Player[id]._house_Down = 0;
    Player[id]._house_Left = 0;
    Player[id]._house_Right = 0;

    Player[id]._house_SpeedMove = 3;

end



function _houseVobbing(id)

    if Player[id].loggedIn == true then
        if GetPlayerVirtualWorld(id) == 0 then
            if Player[id]._house_Editing == false then
                if Player[id]._house_Vobbing == false then
                    local x, y, z = GetPlayerPos(id);
                    local current_house = nil;
                    

                    for i = 1, table.getn(_HOUSE_XYZ) do
                        if _HOUSE_XYZ[i] ~= nil then
                            if GetDistance3D(x, y, z, _HOUSE_XYZ[i][1], _HOUSE_XYZ[i][2], _HOUSE_XYZ[i][3]) < 600 then
                                if GetPlayerWorld(id) == _HOUSE_XYZ[i][5] then
                                    current_house = i;
                                    break
                                end
                            end
                        end
                    end

                    if current_house ~= nil then
                        if _HOUSE[current_house].owner == Player[id].nickname then
                            if _houseGetValueObjects(current_house) < 30 then

                                for i = 1, table.getn(Player[id]._house_Draws) do
                                    ShowPlayerDraw(id, Player[id]._house_Draws[i]);
                                end

                                Player[id]._house_Vobbing = true;
                                Player[id]._house_Current = current_house;
                                Player[id]._house_PositionCheker = SetTimerEx(_house_PlayerPosCheker, 3000, 1, id);

                                ShowTexture(id, HOUSE_TEXTURE);

                                SendPlayerMessage(id, 255, 255, 255, " ");
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы вошли в режим обустройства.")
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Чтобы начать установку предмета - выберите его в инвентаре и выкиньте.")
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Завершить - /дом_обустройство")
                            else
                                SendPlayerMessage(id, 255, 255, 255, " ");
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Лимит объектов на дом заполнен (максимум 30). /дом_удалить - удалить существующий объект.")
                            end

                        else
                            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Это не ваш дом, вы не можете обустраивать его.")
                        end
                    else
                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Поблизости нет домов.")
                    end

                else

                    HideTexture(id, HOUSE_TEXTURE);

                    for i = 1, table.getn(Player[id]._house_Draws) do
                        HidePlayerDraw(id, Player[id]._house_Draws[i]);
                    end

                    if Player[id]._house_Vob ~= nil then
                        Vob.Destroy(Player[id]._house_Vob);
                    end

                    if Player[id]._house_PositionCheker ~= nil then
                        KillTimer(Player[id]._house_PositionCheker);
                    end
                    Player[id]._house_PositionCheker = nil;

                    if Player[id]._house_MoveTimer ~= nil then
                        KillTimer(Player[id]._house_MoveTimer);
                    end
                    Player[id]._house_MoveTimer = nil;
        
                    Player[id]._house_Vob = nil;
                    Player[id]._house_Accept = false;
                    Player[id]._house_Accept_Object = nil;
                    Player[id]._house_Vobbing = false;
                    Player[id]._house_Current = nil;
                    Player[id]._house_VobPos = {-9999, -9999, -9999};
                    Player[id]._house_VobRot = {0, 0, 0};
                    Player[id]._house_SpeedMove = 3;

                    UnFreeze(id);
                    SetDefaultCamera(id);

                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы вышли из режима обустройства.")
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Все несохраненные объекты не установлены.")
                end
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Команда доступна только в основном полигоне.")
        end
    end

end
addCommandHandler({"/дом_обустроить"}, _houseVobbing);

function _house_DeleteObject(id, sets)

    if Player[id].loggedIn == true then
        if Player[id]._house_Vobbing == false and Player[id]._house_Editing == false then
            local cmd, house, obj = sscanf(sets, "dd");
            if cmd == 1 then
                if _HOUSE[house].owner == Player[id].nickname and GetPlayerWorld(id) == _HOUSE[house].world then
                    if _HOUSE[house].objects[obj][1] ~= nil then

                        LogString("Logs/House/delete", Player[id].nickname.." удалил объект ".._HOUSE[house].objects[obj][1].." из дома №"..house.." / ".._getRTime());

                        if _HOUSE[house].objects[obj][2] == "VOB" then
                            Vob.Destroy(_HOUSE[house].objects[obj][9]);
                        else
                            Mob.Destroy(_HOUSE[house].objects[obj][9]);
                        end

                        local model = _HOUSE[house].objects[obj][1];

                        for i = 1, 9 do
                            _HOUSE[house].objects[obj][i] = nil;
                        end


                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Объект "..model.." удален.")
                        _house_Save(house);
                    else
                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Объект не найден.")
                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Узнать ID объекта можно в режиме редактирования.")
                    end
                else
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Это не ваш дом.")
                end
            else
                SendPlayerMessage(id, 255, 255, 255, "/дом_удалить (номер дома) (номер объекта)")
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "Вначале выйдите из режима обустройства (редактирования).")
        end
    end

end
addCommandHandler({"/дом_удалить"}, _house_DeleteObject);

function _houseEditing(id)

    if Player[id].loggedIn == true then
        if GetPlayerVirtualWorld(id) == 0 then
            if Player[id]._house_Vobbing == false then
                if Player[id]._house_Editing == false then
                    local x, y, z = GetPlayerPos(id);
                    local current_house = nil;
                    

                    for i = 1, table.getn(_HOUSE_XYZ) do
                        if _HOUSE_XYZ[i] ~= nil then
                            if GetDistance3D(x, y, z, _HOUSE_XYZ[i][1], _HOUSE_XYZ[i][2], _HOUSE_XYZ[i][3]) < 600 then
                                if GetPlayerWorld(id) == _HOUSE_XYZ[i][5] then
                                    current_house = i;
                                    break
                                end
                            end
                        end
                    end

                    if current_house ~= nil then
                        if _HOUSE[current_house].owner == Player[id].nickname then
                            if _houseGetValueObjects(current_house) > 0 then

                                for i = 1, table.getn(Player[id]._house_Draws) do
                                    ShowPlayerDraw(id, Player[id]._house_Draws[i]);
                                end

                                Player[id]._house_Editing = true;
                                Player[id]._house_Current = current_house;
                                Player[id]._house_PositionCheker = SetTimerEx(_house_PlayerPosCheker, 3000, 1, id);

                                ShowTexture(id, HOUSE_TEXTURE);

                                for i = 1, 30 do
                                    if _HOUSE[current_house].objects[i][1] ~= nil then
                                        Player[id]._house_EditingObject = i;
                                        break
                                    end
                                end
                                

                                SendPlayerMessage(id, 255, 255, 255, " ")
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы вошли в редактирования. Номер объекта редактирования: "..Player[id]._house_EditingObject)
                                SendPlayerMessage(id, 255, 255, 255, "(ВАЖНО) В режиме редактирования камера не переносится на объект.")

                                local pos = Player[id]._house_EditingObject;
                                local vob = _HOUSE[current_house].objects[pos][9];
                                local vx, vy, vz = vob:GetPosition();

                                Player[id]._house_VobPos = {vx, vy, vz};
                                Player[id]._house_Vob = vob;

                                Freeze(id);

                                Player[id]._house_MoveTimer = SetTimerEx(_houseMove, 50, 1, id);

                                local modelname = _houseGetNameByModel(_HOUSE[current_house].objects[pos][1]);
                                SetPlayerDrawText(id, Player[id]._house_Draws[9], string.format("%s%s","# ", modelname));
                                SetPlayerDrawText(id, Player[id]._house_Draws[10], string.format("%s%d","# Объект: ", Player[id]._house_EditingObject))
                                SetPlayerDrawText(id, Player[id]._house_Draws[11], "# Переключение: E");
                            else
                                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) В доме нет объектов для редактирования.")
                            end

                        else
                            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Это не ваш дом, вы не можете редактировать его.")
                        end
                    else
                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Поблизости нет домов.")
                    end

                else

                    HideTexture(id, HOUSE_TEXTURE);

                    for i = 1, table.getn(Player[id]._house_Draws) do
                        HidePlayerDraw(id, Player[id]._house_Draws[i]);
                    end

                    SetPlayerDrawText(id, Player[id]._house_Draws[9], " ");
                    SetPlayerDrawText(id, Player[id]._house_Draws[10], " ")
                    SetPlayerDrawText(id, Player[id]._house_Draws[11], " ")

                    if Player[id]._house_PositionCheker ~= nil then
                        KillTimer(Player[id]._house_PositionCheker);
                    end
                    Player[id]._house_PositionCheker = nil;

                    if Player[id]._house_MoveTimer ~= nil then
                        KillTimer(Player[id]._house_MoveTimer);
                    end
                    Player[id]._house_MoveTimer = nil;
        
                    Player[id]._house_Vob = nil;
                    Player[id]._house_Accept = false;
                    Player[id]._house_Accept_Object = nil;
                    Player[id]._house_Editing = false;
                    Player[id]._house_Current = nil;
                    Player[id]._house_VobPos = {-9999, -9999, -9999};
                    Player[id]._house_VobRot = {0, 0, 0};
                    Player[id]._house_SpeedMove = 3;
                    Player[id]._house_EditingObject = nil;

                    UnFreeze(id);
                    SetDefaultCamera(id);
                    SendPlayerMessage(id, 255, 255, 255, " ")
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы вышли из режима редактирования.")
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Несохраненные изменения сбросятся при рестарте сервера.")
                end  
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Команда доступна только в основном полигоне.")
        end
    end

end
addCommandHandler({"/дом_редактировать"}, _houseEditing);



--[[function _findNearestHouse(id)

    local x, y, z = GetPlayerPos(id);
    local houseid = nil;

    for i = 1, table.getn(_HOUSE_XYZ) do
        if _HOUSE_XYZ[i] ~= nil then
            if GetDistance3D(x, y, z, _HOUSE_XYZ[i][1], _HOUSE_XYZ[i][2], _HOUSE_XYZ[i][3]) < 800 then
                houseid = i;
                break
            end
        end
    end

    if houseid == nil then
        SendPlayerMessage(id, 255, 255, 255, "Рядом нет домов.");
    else
        SendPlayerMessage(id, 255, 255, 255, "Ближайший дом с ID: "..houseid);
    end

end
addCommandHandler({"/дм"}, _findNearestHouse);]]


function _houseDrop(id, itemid, instance, amount, posX, posY, posZ, world, rotX, rotY, rotZ)

    instance = string.upper(instance);

    if Player[id].loggedIn == true and Player[id]._house_Vobbing == true then
        if string.find(instance, "HOUSE") then
            if Player[id]._house_Accept == false then
                SendPlayerMessage(id, 255, 255, 255, " ");

                local model = _houseGetModelByInstance(instance);
                local modelname = _houseGetNameByModel(model);

                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы хотите установить объект: "..modelname.."? /дом_да для подтверждения.")
                Player[id]._house_Accept_Object = instance;
                Player[id]._house_Accept_Object_Timer = SetTimerEx(_houseAcceptTimer, 7000, 0, id);
                DestroyItem(itemid);
                GiveItem(id, instance, amount);
                SaveItems(id);
            else
                local model = _houseGetModelByInstance(Player[id]._house_Accept_Object);
                local modelname = _houseGetNameByModel(model);
                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вначале закончите работу с предыдущим объектом ("..modelname..").")
                DestroyItem(itemid);
                GiveItem(id, instance, amount);
                SaveItems(id);
            end
        end
    end

end

function _houseAcceptTimer(id)
    Player[id]._house_Accept_Object = nil;
    SendPlayerMessage(id, 255, 255, 255, "Время для подтверждения вышло.")
    Player[id]._house_Accept_Object_Timer = nil;
end

function _house_ObjectGetType(object_code)

    object_code = string.upper(object_code);

    if string.find(object_code, "ASC") then
        return "MOB"
    elseif string.find(object_code, "3DS") then
        return "VOB"
    end

end

function _house_ObjectGetScheme(object_code)

    object_code = string.upper(object_code);

    if string.find(object_code, "BED") then
        return "BED_FRONT"

    elseif string.find(object_code, "ARMCHAIR") then
        return "ARMCHAIR"

    elseif string.find(object_code, "THRONE") then
        return "THRONE"

    elseif string.find(object_code, "CHAIR") and not string.find(object_code, "ARMCHAIR") then
        return "CHAIR"

    elseif string.find(object_code, "BOOKSTAND") then
        return "BOOKSTAND";

    elseif string.find(object_code, "BOOKSBOARD") then
        return "BOOKSBOARD";

    elseif string.find(object_code, "STOVE") then
        return "STOVE";

    elseif string.find(object_code, "SOFA") then
        return "SOFA";

    elseif string.find(object_code, "BOOK") and not string.find(object_code, "BOOKSHELF") then
        return "BOOK";

    elseif string.find(object_code, "BOOKSHELF") then
        return "BOOK";

    elseif string.find(object_code, "WRITING") then
        return "WRITING";

    else
        return "";
    end

end

function _house_ObjectGetMobname(object_code)

    object_code = string.upper(object_code);

    if string.find(object_code, "BED") then
        return "MOBNAME_BED"

    elseif string.find(object_code, "ARMCHAIR") then
        return "MOBNAME_ARMCHAIR"
      
    elseif string.find(object_code, "CHAIR") and not string.find(object_code, "ARMCHAIR") then
        return "MOBNAME_CHAIR"

    elseif string.find(object_code, "BOOKSTAND") then
        return "MOBNAME_BOOKSTAND";

    elseif string.find(object_code, "BOOKSBOARD") then
        return "MOBNAME_BOOKSBOARD";

    elseif string.find(object_code, "STOVE") then
        return "MOBNAME_STOVE";

    else
        return "";
    end

end

function _houseAccept(id)

    if Player[id].loggedIn == true then
        if Player[id]._house_Accept_Object ~= nil and Player[id]._house_Accept == false then

            Player[id]._house_Accept = true;
            local x, y, z = GetPlayerPos(id);

            if Player[id]._house_Accept_Object_Timer ~= nil then
                KillTimer(Player[id]._house_Accept_Object_Timer);
                Player[id]._house_Accept_Object_Timer = nil;
            end

            local object = Player[id]._house_Accept_Object;
            local model = _houseGetModelByInstance(object);
            local modelname = _houseGetNameByModel(model);

            SendPlayerMessage(id, 255, 255, 255, " ")
            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы начали работу с "..modelname..".")

            SetPlayerDrawText(id, Player[id]._house_Draws[9], string.format("%s%s","# ", modelname));

            Player[id]._house_MoveTimer = SetTimerEx(_houseMove, 50, 1, id);


            Player[id]._house_Vob = Vob.Create(model, "ADDONWORLD2.ZEN", x, y + 100, z);
            Player[id]._house_VobPos = {x, y + 100, z};
            Player[id]._house_VobRot = {0, 0, 0};

            Freeze(id);

            SetCameraBehindVob(id, Player[id]._house_Vob);

        end
    end
end
addCommandHandler({"/дом_да"}, _houseAccept);

function _house_PlayerPosCheker(id)

    if Player[id].loggedIn == true then
        local x, y, z = GetPlayerPos(id);
        local house = Player[id]._house_Current;
        if GetDistance3D(x, y, z, _HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]) > 1000 then

            HideTexture(id, HOUSE_TEXTURE);

            for i = 1, table.getn(Player[id]._house_Draws) do
                HidePlayerDraw(id, Player[id]._house_Draws[i]);
            end

            SetPlayerDrawText(id, Player[id]._house_Draws[9], " ");
            SetPlayerDrawText(id, Player[id]._house_Draws[10], " ");
            SetPlayerDrawText(id, Player[id]._house_Draws[11], " ")

            KillTimer(Player[id]._house_PositionCheker);
            Player[id]._house_PositionCheker = nil;

            if Player[id]._house_MoveTimer ~= nil then
                KillTimer(Player[id]._house_MoveTimer);
            end
            Player[id]._house_MoveTimer = nil;

            SendPlayerMessage(id, 255, 255, 255, " ");
            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Вы отошли далеко от дома. Обустройство (редактирование) отключено.")

            if Player[id]._house_Vob ~= nil then
                Vob.Destroy(Player[id]._house_Vob);
            end

            Player[id]._house_Vob = nil;
            Player[id]._house_Accept = false;
            Player[id]._house_Accept_Object = nil;
            Player[id]._house_Vobbing = false;
            Player[id]._house_Editing = false;
            Player[id]._house_Current = nil;
            Player[id]._house_VobPos = {-9999, -9999, -9999};
            Player[id]._house_VobRot = {0, 0, 0};

            SetDefaultCamera(id);
            UnFreeze(id);
        end
    end

end

function _house_SaveObject(id)

    if Player[id].loggedIn == true then
        if Player[id]._house_Vobbing == true then
            if Player[id]._house_Accept_Object ~= nil and Player[id]._house_Accept == true then

                local object = Player[id]._house_Accept_Object;
                local model = _houseGetModelByInstance(object);
                local house = Player[id]._house_Current;

                if GetDistance3D(Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3], _HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]) > _HOUSE_XYZ[house][4] then

                    SendPlayerMessage(id, 255, 255, 255, " ");
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Нельзя пересекать пределы дома.")
                    Player[id]._house_Vob:SetPosition(_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]);
                    Player[id]._house_VobPos = {_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]};

                else

                    LogString("Logs/House/set", Player[id].nickname.." поставил объект "..model.." в доме №"..house.." / ".._getRTime());

                    Vob.Destroy(Player[id]._house_Vob);
                    SetDefaultCamera(id);

                    if Player[id]._house_MoveTimer ~= nil then
                        KillTimer(Player[id]._house_MoveTimer);
                    end
                    Player[id]._house_MoveTimer = nil;

                    if _house_ObjectGetType(model) == "VOB" then

                        for slot = 1, table.getn(_HOUSE[house].objects) do
                            if _HOUSE[house].objects[slot][1] == nil then
                                table.remove(_HOUSE[house].objects[slot], 1);

                                table.insert(_HOUSE[house].objects[slot], model);
                                table.insert(_HOUSE[house].objects[slot], "VOB");
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[1]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[2]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[3]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[1]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[2]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[3]);
                                table.insert(_HOUSE[house].objects[slot], Vob.Create(model, "ADDONWORLD2.ZEN", Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3]));
                                Vob.SetRotation(_HOUSE[house].objects[slot][9], Player[id]._house_VobRot[1], Player[id]._house_VobRot[2], Player[id]._house_VobRot[3])
                                break
                            end
                        end

                    elseif _house_ObjectGetType(model) == "MOB" then

                        for slot = 1, table.getn(_HOUSE[house].objects) do
                            if _HOUSE[house].objects[slot][1] == nil then
                                table.remove(_HOUSE[house].objects[slot], 1);

                                table.insert(_HOUSE[house].objects[slot], model);
                                table.insert(_HOUSE[house].objects[slot], "MOB");

                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[1]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[2]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobPos[3]);

                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[1]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[2]);
                                table.insert(_HOUSE[house].objects[slot], Player[id]._house_VobRot[3]);
                                table.insert(_HOUSE[house].objects[slot], Mob.Create(model, _house_ObjectGetMobname(model), 1, _house_ObjectGetScheme(model), "", "ADDONWORLD2.ZEN", Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3]));
                                Mob.SetRotation(_HOUSE[house].objects[slot][9], Player[id]._house_VobRot[1], Player[id]._house_VobRot[2], Player[id]._house_VobRot[3])
                                break
                            end
                        end

                    end

                    _house_Save(house);
                    UnFreeze(id);

                    RemoveItem(id, object, 1);
                    SaveItems(id);

                    Player[id]._house_Accept = false;
                    Player[id]._house_Accept_Object = nil;
                    Player[id]._house_Vob = nil;
                    Player[id]._house_VobPos = {-9999, -9999, -9999};
                    Player[id]._house_VobRot = {0, 0, 0};


                    SetPlayerDrawText(id, Player[id]._house_Draws[9], " ");
                    SetPlayerDrawText(id, Player[id]._house_Draws[10], " ");
                    SetPlayerDrawText(id, Player[id]._house_Draws[11], " ")

                    SendPlayerMessage(id, 255, 255, 255, " ");
                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Объект сохранен.")
                end
            end

        end

        if Player[id]._house_Editing == true then

            local slot = Player[id]._house_EditingObject;
            local house = Player[id]._house_Current;
            local visual = _HOUSE[house].objects[slot][1];
           
            if GetDistance3D(Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3], _HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]) > _HOUSE_XYZ[house][4] then

                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Нельзя пересекать пределы дома.")
                Player[id]._house_Vob:SetPosition(_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]);
                Player[id]._house_VobPos = {_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]};

            else

                LogString("Logs/House/set", Player[id].nickname.." отредактировал объект "..visual.." в доме №"..house.." / ".._getRTime());

                _HOUSE[house].objects[slot][3] = Player[id]._house_VobPos[1];
                _HOUSE[house].objects[slot][4] = Player[id]._house_VobPos[2];
                _HOUSE[house].objects[slot][5] = Player[id]._house_VobPos[3];
                _HOUSE[house].objects[slot][6] = Player[id]._house_VobRot[1];
                _HOUSE[house].objects[slot][7] = Player[id]._house_VobRot[2];
                _HOUSE[house].objects[slot][8] = Player[id]._house_VobRot[3];

                if _house_ObjectGetType(visual) == "VOB" then
                    Vob.SetPosition(_HOUSE[house].objects[slot][9], Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3]);
                    Vob.SetRotation(_HOUSE[house].objects[slot][9], Player[id]._house_VobRot[1], Player[id]._house_VobRot[2], Player[id]._house_VobRot[3]);
               
                elseif _house_ObjectGetType(visual) == "MOB" then
                    Mob.SetPosition(_HOUSE[house].objects[slot][9], Player[id]._house_VobPos[1], Player[id]._house_VobPos[2], Player[id]._house_VobPos[3]);
                    Mob.SetRotation(_HOUSE[house].objects[slot][9], Player[id]._house_VobRot[1], Player[id]._house_VobRot[2], Player[id]._house_VobRot[3])    
                end


                _house_Save(house);

                for i = 1, 30 do
                    if _HOUSE[house].objects[i][1] ~= nil then
                        Player[id]._house_EditingObject = i;
                        break
                    end
                end
                local pos = Player[id]._house_EditingObject;
                local modelname = _houseGetNameByModel(_HOUSE[house].objects[pos][1]);

                Player[id]._house_Vob = _HOUSE[house].objects[pos][9];
                Player[id]._house_VobPos = Player[id]._house_Vob:GetPosition();
                Player[id]._house_VobRot = Player[id]._house_Vob:GetRotation();

                SetPlayerDrawText(id, Player[id]._house_Draws[9], "# "..modelname);
                SetPlayerDrawText(id, Player[id]._house_Draws[10], "# Объект: "..pos);
                SetPlayerDrawText(id, Player[id]._house_Draws[11], "# Переключение: E");


                SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Объект сохранен. Новый номер объекта: "..pos)
            end

        end
    end

end
addCommandHandler({"/дом_сохранить"}, _house_SaveObject);


function _house_Save(house)

    local file = io.open("Database/House/House_ID"..house..".txt", "w");
    file:write(_HOUSE[house].owner.."\n");
    for slot = 1, table.getn(_HOUSE[house].objects) do
        if _HOUSE[house].objects[slot][1] ~= nil then
            file:write(_HOUSE[house].objects[slot][1].." ");
            file:write(_HOUSE[house].objects[slot][2].." ");
            file:write(_HOUSE[house].objects[slot][3].." ");
            file:write(_HOUSE[house].objects[slot][4].." ");
            file:write(_HOUSE[house].objects[slot][5].." ");
            file:write(_HOUSE[house].objects[slot][6].." ");
            file:write(_HOUSE[house].objects[slot][7].." ");
            file:write(_HOUSE[house].objects[slot][8].."\n");
        end
    end
    file:close();
end


function _houseKey(id, down, up)

    if Player[id].loggedIn == true and Player[id]._house_Vobbing == true or Player[id]._house_Editing == true then


        if Player[id]._house_Editing == true then

            if down == KEY_E then

                local house = Player[id]._house_Current;
                local plus = Player[id]._house_EditingObject + 1;

                if _houseGetValueObjects(house) >= plus then
                
                    if _HOUSE[house].objects[plus][9] ~= nil then
                        Player[id]._house_EditingObject = plus;
                        SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Номер объекта редактирования: "..plus)
                        Player[id]._house_Vob = _HOUSE[house].objects[plus][9];
                    end
                else
                    
                    for i = 1, 30 do
                        if _HOUSE[house].objects[i][1] ~= nil then
                            Player[id]._house_EditingObject = i;
                            break
                        end
                    end
                    local pos = Player[id]._house_EditingObject;

                    SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Номер объекта редактирования: "..pos)
                    Player[id]._house_Vob = _HOUSE[house].objects[pos][9];
                end

                local pos = Player[id]._house_EditingObject;
                local modelname = _houseGetNameByModel(_HOUSE[house].objects[pos][1]);
                SetPlayerDrawText(id, Player[id]._house_Draws[9], "# "..modelname);
                SetPlayerDrawText(id, Player[id]._house_Draws[10], "# Объект: "..pos);
                SetPlayerDrawText(id, Player[id]._house_Draws[11], "# Переключение: E");

            end

        end

        ----------------
        if down == KEY_R then
            local vob = Player[id]._house_Vob;
            vob:SetRotation(0, 0, 0);
            Player[id]._house_VobRot = {0, 0, 0};
        end
        ----------------
		if down == KEY_W then
			Player[id]._house_W = 1;
		end

		if down == KEY_S then
			Player[id]._house_S = 1;
		end

		if down == KEY_A then
			Player[id]._house_A = 1;
		end

		if down == KEY_D then
			Player[id]._house_D = 1;
		end
        ----------------
        if down == KEY_Z then
			Player[id]._house_Z = 1;
		end

		if down == KEY_X then
			Player[id]._house_X = 1;
		end
        ----------------
        if down == KEY_UP then
			Player[id]._house_Up = 1;
		end

		if down == KEY_DOWN then
			Player[id]._house_Down = 1;
		end

        if down == KEY_LEFT then
			Player[id]._house_Left = 1;
		end

		if down == KEY_RIGHT then
			Player[id]._house_Right = 1;
		end

        if down == KEY_MINUS then
			Player[id]._house_SpeedMove = Player[id]._house_SpeedMove - 1;
			if Player[id]._house_SpeedMove < 1 then
				Player[id]._house_SpeedMove = 1;
			end
		end


		if down == KEY_EQUALS then
			Player[id]._house_SpeedMove = Player[id]._house_SpeedMove + 1;
			if Player[id]._house_SpeedMove > 10 then
				Player[id]._house_SpeedMove = 10;
			end
		end

        ---------------------------------------------------
       
		if up == KEY_W then
			Player[id]._house_W = 0;
		end

		if up == KEY_S then
			Player[id]._house_S = 0;
		end

		if up == KEY_A then
			Player[id]._house_A = 0;
		end

		if up == KEY_D then
			Player[id]._house_D = 0;
		end
        ----------------
        if up == KEY_Z then
			Player[id]._house_Z = 0;
		end

		if up == KEY_X then
			Player[id]._house_X = 0;
		end
        ----------------
        if up == KEY_UP then
			Player[id]._house_Up = 0;
		end

		if up == KEY_DOWN then
			Player[id]._house_Down = 0;
		end

        if up == KEY_LEFT then
			Player[id]._house_Left = 0;
		end

		if up == KEY_RIGHT then
			Player[id]._house_Right = 0;
		end


    end

end

function _houseMove(id)

    if Player[id].loggedIn == true and Player[id]._house_Vob ~= nil then

        local house = Player[id]._house_Current;
        local vob = Player[id]._house_Vob;

        local x, y, z = vob:GetPosition();
        if GetDistance3D(x, y, z, _HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]) > _HOUSE_XYZ[house][4] then
            SendPlayerMessage(id, 255, 255, 255, "(ДОМ) Нельзя пересекать пределы дома.")
            vob:SetPosition(_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]);
			Player[id]._house_VobPos = {_HOUSE_XYZ[house][1], _HOUSE_XYZ[house][2], _HOUSE_XYZ[house][3]};
        end

        if Player[id]._house_W == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x + Player[id]._house_SpeedMove * _sin;
			z = z + Player[id]._house_SpeedMove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._house_VobPos = {x, y, z};
		end

		if Player[id]._house_S == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x - Player[id]._house_SpeedMove * _sin;
			z = z - Player[id]._house_SpeedMove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._house_VobPos = {x, y, z};
		end

		if Player[id]._house_A == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y - Player[id]._house_SpeedMove, r_z);
			Player[id]._house_VobRot = {r_x, r_y - Player[id]._house_SpeedMove, r_z}
		end

		if Player[id]._house_D == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y + Player[id]._house_SpeedMove, r_z);
			Player[id]._house_VobRot = {r_x, r_y + Player[id]._house_SpeedMove, r_z}
		end

        -----------------------------------------------------------------

        if Player[id]._house_Z == 1 then
			local vob = Player[id]._house_Vob;
			local v_x, v_y, v_z = vob:GetPosition()
			vob:SetPosition(v_x, v_y - Player[id]._house_SpeedMove, v_z);
			Player[id]._house_VobPos = {v_x, v_y - Player[id]._house_SpeedMove, v_z}
		end

        if Player[id]._house_X == 1 then
			local vob = Player[id]._house_Vob;
			local v_x, v_y, v_z = vob:GetPosition()
			vob:SetPosition(v_x, v_y + Player[id]._house_SpeedMove, v_z);
			Player[id]._house_VobPos = {v_x, v_y + Player[id]._house_SpeedMove, v_z}
		end

        -----------------------------------------------------------------

        if Player[id]._house_Up == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x + Player[id]._house_SpeedMove, r_y, r_z);
            Player[id]._house_VobRot = {r_x + Player[id]._house_SpeedMove, r_y, r_z};
		end

		if Player[id]._house_Down == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x - Player[id]._house_SpeedMove, r_y, r_z);
            Player[id]._house_VobRot = {r_x + Player[id]._house_SpeedMove, r_y, r_z};
		end

		if Player[id]._house_Left == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z + Player[id]._house_SpeedMove);
            Player[id]._house_VobRot = {r_x + Player[id]._house_SpeedMove, r_y, r_z};
		end

		if Player[id]._house_Right == 1 then
			local vob = Player[id]._house_Vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z - Player[id]._house_SpeedMove);
            Player[id]._house_VobRot = {r_x + Player[id]._house_SpeedMove, r_y, r_z};
		end

    end
end











-----------------------------------------------------------------------------------------

--[[local instanceArr = {}; local modelArr = {}; local nameArr = {};
	local file = io.open("obj.txt", "r");
	for line in file:lines() do
		local l, text = sscanf(line, "s");
		if l == 1 then
			if string.find(text, "instance") then
				local str, inst, code = sscanf(text, "ss");
				if str == 1 then
					if string.find(code, "RC_HOUSE") then
						table.insert(instanceArr, text);
					end
				end
			end

			if string.find(text, "name") and not string.find(text, "description") then 
				local str, code = sscanf(text, "s");
				if str == 1 then
					table.insert(nameArr, text);
				end
			end

			if string.find(text, "visual") then 
				local str, code = sscanf(text, "s");
				if str == 1 then
					table.insert(modelArr, text);
				end
			end


		end
	end
	file:close();

	local file = io.open("syda.txt", "w"); 
	for i = 1, table.getn(instanceArr) do
		local text = "{ item_instance = '"..instanceArr[i].."', model3d = '"..modelArr[i].."', name = '"..nameArr[i].."'},";
		file:write(text.."\n");
	end
	file:close();]]

    -- все что останется потом - это открыть файлик и убрать мусор в духе (C_ITEM) и лишних пробелов


--[[local checkposition = {0, 0, 0}; -- хуета чтобы определять дом 

function _houseTest()

    if Player[0].loggedIn == true and IsPlayerConnected(0) == 1 then
       local x, y, z = GetPlayerPos(0);
       checkposition = {x, y, z};
    end

end
addCommandHandler({"/чек"}, _houseTest)

function _htest()
    if checkposition[1] ~= 0 and checkposition[2] ~= 0 and checkposition[3] ~= 0 then
        local x, y, z = GetPlayerPos(0);
        SendPlayerMessage(0, 255, 255, 255, GetDistance3D(x, y, z, checkposition[1], checkposition[2], checkposition[3]));
    end
end
SetTimer(_htest, 1500, 1);]]