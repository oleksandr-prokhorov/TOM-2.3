
--  #   Team system by royclapton  #
--  #         version: 1.0         #


local maptexture = CreateTexture(2719, 1526, 6394, 6751, 'team-war')

TEAM_BOTS_LIST = {};
TEAM_LIST = {};
TEAM = {};
for i = 1, 200 do
	TEAM[i] = {};

	--main
	TEAM[i].name = nil;
	TEAM[i].leader = nil;
	TEAM[i].preleaders = {};
	TEAM[i].ranks = {};
	TEAM[i].players = {};
	TEAM[i].description = {"##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##", "##"};
	TEAM[i].tag = nil;
	TEAM[i].color = {0, 0, 0};
	TEAM[i].level = 0;
	TEAM[i].coins = 0;
	TEAM[i].items = {};
	for k = 1, 2 do
		TEAM[i].items[k] = {};
	end

	-- bot
	TEAM[i].bot = nil;
	TEAM[i].bot_pos = {-999999999, -999999999, 0};
	TEAM[i].bot_armor = "";

	-- team-war
	TEAM[i].score = 0;
	TEAM[i].zones = {};
	TEAM[i].cancapture = 3;

end

TZONES_AMOUNT = 13;
TZONES = {};
for i = 1, TZONES_AMOUNT do
	TZONES[i] = {};
	TZONES[i].name = nil;
	TZONES[i].type = nil;
	TZONES[i].bonus = {};
	TZONES[i].bonus_type = "nil";
	TZONES[i].team = nil;
	TZONES[i].npc = {};
	TZONES[i].locate = {};
	TZONES[i].pfreeze = false;
	TZONES[i].try = 2;
end


function _teamInit()

	print(" ");
	print("================")
	print("   Team module  ")

	TZONES[1].name = "Пляж";
	TZONES[1].type = "default";
	TZONES[1].bonus = {"ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH","OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02"};
	TZONES[1].bonus_type = "item";
	TZONES[1].locate = {-35456.734375, -1851.1490478516, 7194.2890625};
	TZONES[1].pfreeze = false;

	for i, v in pairs(TZONES[1].bonus) do
		TZONES[1].bonus[i] = string.upper(v);
	end

	TZONES[2].name = "Дальний пляж";
	TZONES[2].type = "income";
	TZONES[2].bonus = {"ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_BIJOUTERIE", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "JKZTZD_ITRW_ARROW", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_REMI2"};
	TZONES[2].bonus_type = "item";
	TZONES[2].locate = {-28553.47265625, -1962.6330566406, 26899.416015625};
	TZONES[2].pfreeze = false;

	for i, v in pairs(TZONES[2].bonus) do
		TZONES[2].bonus[i] = string.upper(v);
	end

	TZONES[3].name = "Разрушенная башня";
	TZONES[3].type = "default";
	TZONES[3].bonus = {"ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET"};
	TZONES[3].bonus_type = "item";
	TZONES[3].locate = {-32345.73046875, -60.041702270508, 8209.9072265625};
	TZONES[3].pfreeze = false;

	for i, v in pairs(TZONES[3].bonus) do
		TZONES[3].bonus[i] = string.upper(v);
	end

	TZONES[4].name = "Шахта";
	TZONES[4].type = "income";
	TZONES[4].bonus = {"OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ItMi_Quartz", "OOLTYB_ItMi_Aquamarine", "OOLTYB_ITMI_RUBIN", "OOLTYB_ItMi_Sulfur", "OOLTYB_ItMi_Rockcrystal"};
	TZONES[4].bonus_type = "item";
	TZONES[4].locate = {-16941.552734375, -2020.4456787109, 17045.99609375};
	TZONES[4].pfreeze = false;

	for i, v in pairs(TZONES[4].bonus) do
		TZONES[4].bonus[i] = string.upper(v);
	end

	TZONES[5].name = "Храм в каньоне";
	TZONES[5].type = "default";
	TZONES[5].bonus = {30, 150};
	TZONES[5].bonus_type = "gold";
	TZONES[5].locate = {-6703.7719726563, -2765.6467285156, 32536.9453125};
	TZONES[5].pfreeze = true;

	for i, v in pairs(TZONES[5].bonus) do
		TZONES[5].bonus[i] = string.upper(v);
	end

	TZONES[6].name = "Пещера";
	TZONES[6].type = "default";
	TZONES[6].bonus = {"ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", "ZDPWLA_ITPL_MUSHROOM_04", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron", "OOLTYB_ItMi_Iron"};
	TZONES[6].bonus_type = "item";
	TZONES[6].locate = {477.00811767578, -2950.4831542969, 14579.87890625};
	TZONES[6].pfreeze = true;

	for i, v in pairs(TZONES[6].bonus) do
		TZONES[6].bonus[i] = string.upper(v);
	end

	TZONES[7].name = "Храм на болоте";
	TZONES[7].type = "default";
	TZONES[7].bonus = {30, 150};
	TZONES[7].bonus_type = "gold";
	TZONES[7].locate = {26167.625, -2116.7770996094, -17621.6875};
	TZONES[7].pfreeze = true;

	for i, v in pairs(TZONES[7].bonus) do
		TZONES[7].bonus[i] = string.upper(v);
	end

	TZONES[8].name = "Болото";
	TZONES[8].type = "income";
	TZONES[8].bonus = {"ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET"};
	TZONES[8].bonus_type = "item";
	TZONES[8].locate = {13520.036132813, -5146.5131835938, -9168.8623046875};
	TZONES[8].pfreeze = true;

	for i, v in pairs(TZONES[8].bonus) do
		TZONES[8].bonus[i] = string.upper(v);
	end

	TZONES[9].name = "Храм с порталом";
	TZONES[9].type = "default";
	TZONES[9].bonus = {30, 150};
	TZONES[9].bonus_type = "gold";
	TZONES[9].locate = {18.585966110229, -582.93524169922, -1138.9549560547};
	TZONES[9].pfreeze = false;

	for i, v in pairs(TZONES[9].bonus) do
		TZONES[9].bonus[i] = string.upper(v);
	end

	TZONES[10].name = "Храм в долине";
	TZONES[10].type = "default";
	TZONES[10].bonus = {30, 150};
	TZONES[10].bonus_type = "gold";
	TZONES[10].locate = {-11615.012695313, -4300.7241210938, -27989.68359375};
	TZONES[10].pfreeze = true;

	for i, v in pairs(TZONES[10].bonus) do
		TZONES[10].bonus[i] = string.upper(v);
	end

	TZONES[11].name = "Храм в долине 2";
	TZONES[11].type = "default";
	TZONES[11].bonus = {30, 150};
	TZONES[11].bonus_type = "gold";
	TZONES[11].locate = {-21822.87109375, -3121.7890625, -23922.3203125};
	TZONES[11].pfreeze = true;

	for i, v in pairs(TZONES[11].bonus) do
		TZONES[11].bonus[i] = string.upper(v);
	end

	TZONES[12].name = "Храм Куархадрона";
	TZONES[12].type = "income";
	TZONES[12].bonus = {"OOLTYB_ItMi_Aquamarine", "OOLTYB_ItMi_Sulfur", "OOLTYB_ITMI_RUBIN", "OOLTYB_ItMi_Rockcrystal", "OOLTYB_ItMi_Quartz", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON"};
	TZONES[12].bonus_type = "item";
	TZONES[12].locate = {-23706.62109375, -2659.8725585938, -2438.134765625};
	TZONES[12].pfreeze = true;

	for i, v in pairs(TZONES[12].bonus) do
		TZONES[12].bonus[i] = string.upper(v);
	end

	TZONES[13].name = "Лесопилка";
	TZONES[13].type = "income";
	TZONES[13].bonus = {"OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "JKZTZD_ItMw_1h_Bau_Mace", "JKZTZD_ItMw_1h_Bau_Mace", "JKZTZD_ItMw_1h_Bau_Mace", "JKZTZD_ItMw_1h_Bau_Mace", "JKZTZD_ItMw_1h_Bau_Mace", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ItMi_Pitch", "OOLTYB_ItMi_Pitch", "OOLTYB_ItMi_Pitch", "OOLTYB_ItMi_Pitch", "OOLTYB_ItMi_Pitch"};
	TZONES[13].bonus_type = "item";
	TZONES[13].locate = {-18280.62109375, -403.59729003906, -370.16162109375};
	TZONES[13].pfreeze = false;

	for i, v in pairs(TZONES[13].bonus) do
		TZONES[13].bonus[i] = string.upper(v);
	end

	


	local file = io.open("Database/Team/teamlist.txt", "r");
	if file then
		for line in file:lines() do
			local l, tname = sscanf(line, "s");
			if l == 1 then
				table.insert(TEAM_LIST, tname);

				for i = 1, 200 do
					if TEAM[i].name == nil then
						TEAM[i].name = tname;
						break
					end
				end

			end
		end
		file:close();
	else
		local fileW = io.open("Database/Team/teamlist.txt", "w");
		fileW:close();
	end

	local file = io.open("Database/Team/zones_bonus.txt", "r");
	if file then
		for line in file:lines() do
			local l, zid = sscanf(line, "d");
			if l == 1 then
				table.insert(TEAM_BOTS_LIST, zid);
			end
		end
		file:close();
	else
		local fileW = io.open("Database/Team/zones_bonus.txt", "w");
		fileW:close();
	end

	if table.getn(TEAM_LIST) > 0 then

		for i = 1, table.getn(TEAM_LIST) do

			local file = io.open("Database/Team/"..TEAM_LIST[i].."/description", "r");
			if file then
				TEAM[_getTeamID(TEAM_LIST[i])].description = {};
				for line in file:lines() do
					local l, str = sscanf(line, "s");
					if l == 1 then
						table.insert(TEAM[_getTeamID(TEAM_LIST[i])].description, str);
					end
				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/players/list", "r");
			if file then
				for line in file:lines() do
					local l, str = sscanf(line, "s");
					if l == 1 then
						table.insert(TEAM[_getTeamID(TEAM_LIST[i])].players, str);
					end
				end
				file:close();
			end
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/preleaders", "r");
			for line in file:lines() do
				local l, str = sscanf(line, "s");
				if l == 1 then
					table.insert(TEAM[_getTeamID(TEAM_LIST[i])].preleaders, str);
				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/ranks", "r");
			for line in file:lines() do
				local l, str = sscanf(line, "s");
				if l == 1 then
					table.insert(TEAM[_getTeamID(TEAM_LIST[i])].ranks, str);
				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/items", "r");
			for line in file:lines() do
				local l, item, amount = sscanf(line, "sd");
				if l == 1 then
					table.insert(TEAM[_getTeamID(TEAM_LIST[i])].items[1], string.upper(item));
					table.insert(TEAM[_getTeamID(TEAM_LIST[i])].items[2], amount);
				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/bot", "r");
			for line in file:lines() do
				local l, x, y, z, angle, armor, world = sscanf(line, "ddddss");
				if l == 1 then
					local tn = TEAM_LIST[i].." (бот)"
					TEAM[_getTeamID(TEAM_LIST[i])].bot = CreateNPC(tn);
					TEAM[_getTeamID(TEAM_LIST[i])].bot_pos = {x, y, z};
					SpawnPlayer(TEAM[_getTeamID(TEAM_LIST[i])].bot);
					SetPlayerWorld(TEAM[_getTeamID(TEAM_LIST[i])].bot, world);
					SetPlayerPos(TEAM[_getTeamID(TEAM_LIST[i])].bot, x, y, z);
					SetPlayerAngle(TEAM[_getTeamID(TEAM_LIST[i])].bot, angle);
					SetPlayerMaxHealth(TEAM[_getTeamID(TEAM_LIST[i])].bot, 999999999);
					SetPlayerHealth(TEAM[_getTeamID(TEAM_LIST[i])].bot, 999999999);
					EquipArmor(TEAM[_getTeamID(TEAM_LIST[i])].bot, armor);
				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/zones", "r");
			for line in file:lines() do
				local l, str = sscanf(line, "s");
				if l == 1 then
					table.insert(TEAM[_getTeamID(TEAM_LIST[i])].zones, str);

					for d = 1, TZONES_AMOUNT do
						if TZONES[d].name == str then
							TZONES[d].team = _getTeamID(TEAM_LIST[i]);
							print("# Zones ID:"..d.." controlled by team "..TEAM_LIST[i])
							break
						end
					end

				end
			end
			file:close();
			-------------------------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM_LIST[i].."/info", "r");
			
			line = file:read("*l");
			local l, str = sscanf(line, "s");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].name = str;
			end

			line = file:read("*l");
			local l, str = sscanf(line, "s");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].leader = str;
			end

			line = file:read("*l");
			local l, str = sscanf(line, "s");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].tag = str;
			end

			line = file:read("*l");
			local l, str = sscanf(line, "d");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].level = str;
			end

			line = file:read("*l");
			local l, str = sscanf(line, "d");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].coins = str;
			end

			line = file:read("*l");
			local l, r, g, b = sscanf(line, "ddd");
			if l == 1 then
				TEAM[_getTeamID(TEAM_LIST[i])].color[1] = r;
				TEAM[_getTeamID(TEAM_LIST[i])].color[2] = g;
				TEAM[_getTeamID(TEAM_LIST[i])].color[3] = b;
			end
			
			file:close();
			print("Team: "..TEAM[_getTeamID(TEAM_LIST[i])].name.." ("..TEAM[_getTeamID(TEAM_LIST[i])].tag..") / Level: "..TEAM[_getTeamID(TEAM_LIST[i])].level.." / Coins: "..TEAM[_getTeamID(TEAM_LIST[i])].coins.." -- load.");
		end
	end


	print("================")

end

function _getTeamID(name)

	for i = 1, 200 do
		if TEAM[i].name == name then
			return i;
		end
	end
	return nil;

end

function __CreateFolderTeam_s1(name)
	os.execute("mkdir " .. "Database\\Team\\"..name)
end

function __CreateFolderTeam_s2(name, folder)
	os.execute("mkdir " .. "Database\\Team\\"..name.."\\"..folder)
end

local tex1 = CreateTexture(1450, 1400, 2670, 6870, 'menu_ingame')
local tex2 = CreateTexture(2650, 1400, 6470, 6870, 'menu_ingame')

function _teamConnect(id)

	Player[id].team = nil;
	Player[id].team_pos = nil;
	Player[id].team_invite = {nil, nil};
	Player[id].team_open = false;
	Player[id].team_list = 0;

	Player[id].team_put = false;
	Player[id].team_slot = nil;
	Player[id].team_amount = nil;

	Player[id].team_draws_list = {};
	for i = 1, 9 do
		Player[id].team_draws_list[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].team_draws_ranks = {};
	for i = 1, 10 do
		Player[id].team_draws_ranks[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	Player[id].team_draws_ranks_p = {};
	Player[id].team_draws_ranks_p[1] = CreatePlayerDraw(id, 2800, 6060, "/мф_ранг (ид) (название) - выдать должность.");
	Player[id].team_draws_ranks_p[2] = CreatePlayerDraw(id, 2800, 6260, "/мф_дранг (название) - создать должность.");
	Player[id].team_draws_ranks_p[3] = CreatePlayerDraw(id, 2800, 6460, "/мф_уранг (номер) - удалить должность.");

	Player[id].team_draws_items_p = {};
	Player[id].team_draws_items_p[1] = CreatePlayerDraw(id, 2800, 6260, "/мф_положить (слот) (кол-во) - положить на склад.");
	Player[id].team_draws_items_p[2] = CreatePlayerDraw(id, 2800, 6460, "/мф_взять (слот) (кол-во) - взять со склада.");

	Player[id].team_draws_info_p = {};
	Player[id].team_draws_info_p[1] = CreatePlayerDraw(id, 2800, 4460, "/фчат (текст) - написать в чат фракции.");
	Player[id].team_draws_info_p[2] = CreatePlayerDraw(id, 2800, 4660, "/захват - напасть на территорию.");
	Player[id].team_draws_info_p[3] = CreatePlayerDraw(id, 2800, 4860, "/мф_бонус - собрать бонус с территорий.");
	Player[id].team_draws_info_p[4] = CreatePlayerDraw(id, 2800, 5060, "/мф_взолото (кол-во) - забрать золото.");
	Player[id].team_draws_info_p[5] = CreatePlayerDraw(id, 2800, 5260, "/мф_пзолото (кол-во) - положить золото.");
	Player[id].team_draws_info_p[6] = CreatePlayerDraw(id, 2800, 5460, "/мф_уйти (недоступно лидеру).");
	Player[id].team_draws_info_p[7] = CreatePlayerDraw(id, 2800, 5660, "/мф_выгнать (ид) (причина).");
	Player[id].team_draws_info_p[8] = CreatePlayerDraw(id, 2800, 5860, "/мф_пригласить (ид).");
	Player[id].team_draws_info_p[9] = CreatePlayerDraw(id, 2800, 6060, "/мф_описание (строка) (текст) - задать описание.");
	Player[id].team_draws_info_p[10] = CreatePlayerDraw(id, 2800, 6260, "/мф_цвет (р) (г) (б) - задать цвет.");
	Player[id].team_draws_info_p[11] = CreatePlayerDraw(id, 2800, 6460, "/мф_тег (тег) - задать тег.");

	Player[id].team_draws_history = {};
	for i = 1, 23 do
		Player[id].team_draws_history[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].team_draws_description = {};
	for i = 1, 23 do
		Player[id].team_draws_description[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].team_draws_info = {};
	for i = 1, 15 do
		Player[id].team_draws_info[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	
	Player[id].team_draws_zones_title = CreatePlayerDraw(id, 3536, 1613, "Территории фракции", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id].team_draws_zones = {};
	for i = 1, TZONES_AMOUNT do
		Player[id].team_draws_zones[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].team_draws_tagszones = {};
	
	Player[id].team_draws_tagszones[1] = CreatePlayerDraw(id, 2849, 3678, "");
	Player[id].team_draws_tagszones[2] = CreatePlayerDraw(id, 3207, 2035, "");
	Player[id].team_draws_tagszones[3] = CreatePlayerDraw(id, 3072, 3564, "");
	Player[id].team_draws_tagszones[4] = CreatePlayerDraw(id, 3714, 2808, "");
	Player[id].team_draws_tagszones[5] = CreatePlayerDraw(id, 4194, 1596, "");
	Player[id].team_draws_tagszones[6] = CreatePlayerDraw(id, 4404, 2802, "");
	Player[id].team_draws_tagszones[7] = CreatePlayerDraw(id, 5712, 5622, "");
	Player[id].team_draws_tagszones[8] = CreatePlayerDraw(id, 5100, 4985, "");
	Player[id].team_draws_tagszones[9] = CreatePlayerDraw(id, 4542, 4419, "");
	Player[id].team_draws_tagszones[10] = CreatePlayerDraw(id, 4047, 6426, "");
	Player[id].team_draws_tagszones[11] = CreatePlayerDraw(id, 3507, 6111, "");
	Player[id].team_draws_tagszones[12] = CreatePlayerDraw(id, 3516, 5139, "");
	Player[id].team_draws_tagszones[13] = CreatePlayerDraw(id, 3705, 4284, "");


	Player[id].team_draws_players_names = CreatePlayerDraw(id, 2740, 1580, "Никнейм");
	Player[id].team_draws_players_pos = CreatePlayerDraw(id, 4330, 1580, "Должность");
	Player[id].team_draws_players_status = CreatePlayerDraw(id, 5500, 1580, "Статус");

	Player[id].team_draws_players_names_list = {};
	Player[id].team_draws_players_pos_list = {};
	Player[id].team_draws_players_status_list = {};
	for i = 1, 20 do
		Player[id].team_draws_players_names_list[i] = CreatePlayerDraw(id, 0, 0, "");
		Player[id].team_draws_players_pos_list[i] = CreatePlayerDraw(id, 0, 0, "");
		Player[id].team_draws_players_status_list[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].team_draws_items_title = CreatePlayerDraw(id, 3536, 1613, "Хранилище фракции", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id].team_draws_items_name = CreatePlayerDraw(id, 2795, 2380, "Предмет", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id].team_draws_items_amount = CreatePlayerDraw(id, 5386, 2380, "Кол-во", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	Player[id].team_draws_items = {};
	for i = 1, 10 do
		Player[id].team_draws_items[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	Player[id].team_draws_items_a = {};
	for i = 1, 10 do
		Player[id].team_draws_items_a[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	Player[id].hud_twar_draws = {};
	Player[id].hud_twar_draws[1] = CreatePlayerDraw(id, 0, 0, "");
	Player[id].hud_twar_draws[2] = CreatePlayerDraw(id, 0, 0, "");

	Player[id].team_war_hud = false;


end


function _teamCheckNilSlot()

	for i = 1, 200 do
		if TEAM[i].name == nil then
			return true;
		end
	end
	return false;

end

function _teamCheckName(name)

	for _, v in pairs(bad_symbols) do
		local bad = tostring(v);
		if string.find(name, bad) then
			return false;
		end
	end

	if string.find(name, " ") then
		return false;
	end

	if string.len(name) < 3 and string.len(name) > 15 then
		return false;
	end

	for i = 1, 200 do
		if TEAM[i].name == name then
			return false;
		end
	end

	return true;

end

function _teamCheckTag(tag)

	
	for _, v in pairs(bad_symbols) do
		local bad = tostring(v);
		if string.find(tag, bad) then
			return false;
		end
	end

	if string.find(tag, " ") then
		return false;
	end

	if string.len(tag) == 3 then
		return true;
	end

end

function _getPlayerTeam(id)

	if Player[id].team ~= nil then
		for i = 1, 200 do
			if TEAM[i].name == Player[id].team then
				return i;
			end
		end
	end
	return nil;

end

function _saveTeam(id)

	local file = io.open("Database/Players/Team/"..Player[id].nickname, "w");

	if Player[id].team ~= nil then
		file:write(Player[id].team.."\n");
	else
		file:write("NULL\n");
	end

	if Player[id].team_pos ~= nil then
		file:write(Player[id].team_pos.."\n");
	else
		file:write("NULL\n");
	end

	file:close();

end


function _readTeam(id)

	local file = io.open("Database/Players/Team/"..Player[id].nickname, "r");
	if file then
		
		line = file:read("*l")
		local l, team_name = sscanf(line, "s");
		if l == 1 then
			if team_name == "NULL" then
				Player[id].team = nil;
			else
				Player[id].team = team_name;
			end
		end

		line = file:read("*l")
		local l, pos = sscanf(line, "s");
		if l == 1 then
			Player[id].team_pos = pos;
		end

		file:close();

	else
		local file = io.open("Database/Players/Team/"..Player[id].nickname, "w");
		file:write("NULL\nNULL");
		file:close()
	end

end

function _removeFromTeamsList(name)

	for i, v in pairs(TEAM_LIST) do
		if v ~= nil then
			if v == name then
				table.remove(TEAM_LIST, i);
				_saveTeamsList();
				break
			end
		end
	end

end

function _addToTeamsList(name)

	table.insert(TEAM_LIST, name);
	_saveTeamsList()

end

function _saveTeamsList()

	local file = io.open("Database/Team/teamlist.txt", "w");
	for _, v in pairs(TEAM_LIST) do
		if v ~= nil then
			file:write(v.."\n");
		end
	end
	file:close();


end

function _teamGetTime()

	time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	local rt = "("..rhour..":"..rminute.." / "..rday.."."..rmonth..")";
	return rt;

end

function _teamLog(name, text)

	local file = io.open("Database/Team/"..name.."/history", "a+");
	file:write(_teamGetTime().." "..text.."\n");
	file:close();


end

-- ==============================================================================================================================================================
-- ==============================================================================================================================================================
-- ==============================================================================================================================================================
-- ==============================================================================================================================================================

function _createNewTeam(id, sets)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team == nil then
			local cmd, team_name = sscanf(sets, "s");
			if cmd == 1 then
				if _teamCheckName(team_name) == true then
					if _teamCheckNilSlot() == true then
						Player[id].team = team_name;
						Player[id].team_pos = "Лидер";
						_saveTeam(id);
						_addToTeamsList(team_name);

						for i = 1, 200 do
							if TEAM[i].name == nil then
								TEAM[i].name = team_name;
								TEAM[i].tag = string.sub(team_name, 1,3);
								TEAM[i].leader = Player[id].nickname;
								TEAM[i].color = {255, 255, 255};
								TEAM[i].level = 0;
								table.insert(TEAM[i].ranks, "Лидер");
								table.insert(TEAM[i].players, Player[id].nickname);

								local x, y, z = GetPlayerPos(id); local angle = GetPlayerAngle(id); local armor = GetEquippedArmor(id);
								local tn = team_name.." (бот)"
								TEAM[i].bot = CreateNPC(tn);
								TEAM[i].bot_pos = {x, y, z};
								SpawnPlayer(TEAM[i].bot);
								SetPlayerWorld(TEAM[i].bot, GetPlayerWorld(id));
								SetPlayerPos(TEAM[i].bot, x, y, z);
								SetPlayerAngle(TEAM[i].bot, angle);
								SetPlayerMaxHealth(TEAM[i].bot, 999999999);
								SetPlayerHealth(TEAM[i].bot, 999999999);
								EquipArmor(TEAM[i].bot, armor);

								__CreateFolderTeam_s1(team_name);
								__CreateFolderTeam_s2(team_name, "players");

								local file = io.open("Database/Team/"..team_name.."/description", "w");
								for i = 1, 23 do
									if i == 10 then
										file:write("        Описание не задано. \n");
									else
										file:write("##\n");
									end
								end
								file:close();

								------------------------
								local file = io.open("Database/Team/"..team_name.."/players/list", "w");
								file:write(Player[id].nickname.."\n");
								file:close();

								local file = io.open("Database/Team/"..team_name.."/players/"..Player[id].nickname..".txt", "w");
								file:write(Player[id].nickname.."\n"..Player[id].team_pos);
								file:close();
								------------------------

								local file = io.open("Database/Team/"..team_name.."/preleaders", "w");
								file:close();

								local file = io.open("Database/Team/"..team_name.."/ranks", "w");
								file:write(TEAM[i].ranks[1].."\n");
								file:close();

								local file = io.open("Database/Team/"..team_name.."/items", "w");
								file:close();

								local file = io.open("Database/Team/"..team_name.."/bot", "w");
								file:write(x.." "..y.." "..z.." "..angle.." "..armor.." "..GetPlayerWorld(id));
								file:close();

								local file = io.open("Database/Team/"..team_name.."/zones", "w");
								file:close();

								local file = io.open("Database/Team/"..team_name.."/info", "w");
								file:write(TEAM[i].name.."\n"..TEAM[i].leader.."\n"..TEAM[i].tag.."\n"..TEAM[i].level.."\n"..TEAM[i].coins.."\n"..TEAM[i].color[1].." "..TEAM[i].color[2].." "..TEAM[i].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0")
								file:close();

								_teamLog(team_name, Player[id].nickname.." создал фракцию "..team_name);
								break
							end
						end

						SendPlayerMessage(id, 255, 255, 255, "Вы создали формирование "..team_name.." ("..string.sub(team_name, 1,3)..")");
						SendPlayerMessage(id, 255, 255, 255, "Подробная информация: /мф");

					else
						SendPlayerMessage(id, 255, 255, 255, "Невозможно создать фракцию: все занято.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Неправильно задано название: неверное кол-во символов (от 3 до 15 максимум) или есть недопустимые символы.")
					SendPlayerMessage(id, 255, 255, 255, "Так же причиной может быть то, что это название уже занято.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "/создать_фракцию (название)");
				SendPlayerMessage(id, 255, 255, 255, "Название от 3 до 15 символов. ")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вы уже состоите в фракции "..Player[id].team..". Чтобы создать свою - покиньте текущую.")
		end
	end
end

end
addCommandHandler({"/создать_фракцию", "/create_team"}, _createNewTeam)

function _showMyTeam(id)

	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				Player[id].team_open = true;
				Player[id].team_list = 1;

				ShowChat(id, 0);

				_updateTeamInfo(id, "update");

				for i = 1, 5 do
					SendPlayerMessage(id, 0, 0, 0, "");
				end

				Freeze(id);
				ShowTexture(id, tex1);
				ShowTexture(id, tex2);

				for i = 1, 8 do
					ShowPlayerDraw(id, Player[id].team_draws_list[i]);
				end

				_updateLeftListColor(id, 1);

				for i = 1, 20 do
					ShowPlayerDraw(id, Player[id].team_draws_players_names_list[i]);
					ShowPlayerDraw(id, Player[id].team_draws_players_pos_list[i]);
					ShowPlayerDraw(id, Player[id].team_draws_players_status_list[i]);
				end


			else

				ShowChat(id, 1);

				UnFreeze(id);

				if Player[id].team_list == 1 then
					_updateTeamInfo(id, "hide")
				end

				if Player[id].team_list == 2 then
					_updateTeamDescription(id, "hide")
				end

				if Player[id].team_list == 3 then
					_updateTeamPlayers(id, "hide");
				end

				if Player[id].team_list == 4 then
					_updateTeamRanks(id, "hide")
				end

				if Player[id].team_list == 5 then
					_updateTeamHistory(id, "hide")
				end

				if Player[id].team_list == 6 then
					_updateTeamZones(id, "hide")
				end

				if Player[id].team_list == 7 then
					_updateTeamMap(id, "hide")
				end

				if Player[id].team_list == 8 then
					_updateTeamItems(id, "hide")
				end

				Player[id].team_open = false;
				Player[id].team_list = 0;
				HideTexture(id, tex1);
				HideTexture(id, tex2);

				for i = 1, 8 do
					HidePlayerDraw(id, Player[id].team_draws_list[i]);
				end

				_resetLeftList(id);

				for i = 1, 20 do
					HidePlayerDraw(id, Player[id].team_draws_players_names_list[i]);
					HidePlayerDraw(id, Player[id].team_draws_players_pos_list[i]);
					HidePlayerDraw(id, Player[id].team_draws_players_status_list[i]);
				end

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вы не состоите в какой-либо фракции.")
		end
	end

end
addCommandHandler({"/мф", "/myteam"}, _showMyTeam);


function _myteamSetRank(id, sets)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, rank = sscanf(sets, "s");
					if cmd == 1 then
						if table.getn(TEAM[teamid].ranks) < 10 then
							if string.len(rank) > 3 and string.len(rank) < 30 then

								local orank = true;
								for _, v in pairs(TEAM[teamid].ranks) do
									if v == rank then
										orank = false;
									end
								end

								if orank == true then
									SendPlayerMessage(id, 255, 255, 255, "Должность ("..rank..") добавлена.")
									table.insert(TEAM[teamid].ranks, rank);
									_saveMyTeam(id);
									_teamLog(TEAM[teamid].name, Player[id].nickname.." создал ранг "..rank);
								else
									SendPlayerMessage(id, 255, 255, 255, "Должность с таким названием уже есть.")
								end
							else
								SendPlayerMessage(id, 255, 255, 255, "Длина названия должности должна быть не меньше 4 символов и не больше 30.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Превышен лимит возможных должностей (10).")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_дранг (название)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Добавлять должности может только лидер фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end

addCommandHandler({"/мф_дранг", "/mt_rank"}, _myteamSetRank);


function _myteamDelRank(id, sets)
	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, rank = sscanf(sets, "d");
					if cmd == 1 then
						if table.getn(TEAM[teamid].ranks) > 1 then

							local delacc = true;
							for i = 1, table.getn(TEAM[teamid].players) do
								if _getPlayerRank(TEAM[teamid].name, TEAM[teamid].players[i]) == TEAM[teamid].ranks[rank] then
									SendPlayerMessage(id, 255, 255, 255, "Вы не можете удалить должность, пока она кем-то занята:")
									SendPlayerMessage(id, 255, 255, 255, "Никнейм: "..TEAM[teamid].players[i].." / Должность: "..TEAM[teamid].ranks[rank]);
									delacc = false;
									break
								end
							end
							if delacc == true then
								SendPlayerMessage(id, 255, 255, 255, "Должность ("..TEAM[teamid].ranks[rank]..") удалена.")
								_teamLog(TEAM[teamid].name, Player[id].nickname.." удалил ранг "..TEAM[teamid].ranks[rank]);
								table.remove(TEAM[teamid].ranks, rank);
								_saveMyTeam(id);
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "В фракции должна быть минимум одна должность.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_уранг (номер)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Удалять должности может только лидер фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end
addCommandHandler({"/мф_уранг", "/mt_drank"}, _myteamDelRank);

function _myteamSetTag(id, sets)
	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, tag = sscanf(sets, "s");
					if cmd == 1 then
						if _teamCheckTag(tag) == true then
							TEAM[teamid].tag = tag;
							SendPlayerMessage(id, 255, 255, 255, "Вы обновили тег своей фракции на: "..tag);
							_teamLog(TEAM[teamid].name, Player[id].nickname.." обновил тег на: "..tag);
							_saveMyTeam(id);
						else
							SendPlayerMessage(id, 255, 255, 255, "Обязательная длина тега - 3 символа.")
							SendPlayerMessage(id, 255, 255, 255, "Без пробелов и цифр.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_тег (тег)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Задавать тег может только лидер фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end
addCommandHandler({"/мф_тег", "/mt_tag"}, _myteamSetTag);

function _myteamSetColor(id, sets)
	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, r, g, b = sscanf(sets, "ddd");
					if cmd == 1 then
						if r > 0 and r < 256 and g > 0 and g < 256 and b > 0 and b < 256 then
							TEAM[teamid].color[1] = r;
							TEAM[teamid].color[2] = g;
							TEAM[teamid].color[3] = b;
							SendPlayerMessage(id, r, g, b, "Цвет вашей фракции обновлен.");
							_teamLog(TEAM[teamid].name, Player[id].nickname.." обновил цвет на: "..r.." "..g.." "..b);
							_saveMyTeam(id);
						else
							SendPlayerMessage(id, 255, 255, 255, "Допустимые пороги: 1-255.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_цвет (р) (г) (б)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Задавать цвет может только лидер фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end
addCommandHandler({"/мф_цвет", "/mt_color"}, _myteamSetColor);

function _myteamSetDescription(id, sets)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				if Player[id].team_open == false then
					local teamid = _getPlayerTeam(id);
					if TEAM[teamid].leader == Player[id].nickname then
						local cmd, d, text = sscanf(sets, "ds");
						if cmd == 1 then
							if d > 0 and d < 24 then
								if string.len(text) > 0 and string.len(text) < 55 then
									TEAM[teamid].description[d] = text;
									SendPlayerMessage(id, 255, 255, 255, "Строка #"..d.." обновлена: "..text);
									SendPlayerMessage(id, 255, 255, 255, "Чтобы сделать строку пустой вводите две решетки (##).")
									_saveMyTeam(id);
									_teamLog(TEAM[teamid].name, Player[id].nickname.." обновил описание ("..d..") строка.");
								else
									SendPlayerMessage(id, 255, 255, 255, "Длина строки должна быть минимум 1 символ и не более 54.")
									SendPlayerMessage(id, 255, 255, 255, "Чтобы сделать строку пустой вводите две решетки (##).")
								end
							else
								SendPlayerMessage(id, 255, 255, 255, "Номер строки может должен быть минимум 1 и не более 23.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "/мф_описание (строка) (текст)")
							SendPlayerMessage(id, 255, 255, 255, "Чтобы сделать строку пустой вводите две решетки (##).")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Задавать описание может только лидер фракции.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
			end
		end
	end
end

addCommandHandler({"/мф_описание", "/mt_desc"}, _myteamSetDescription);


function _myteamLeave(id)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				if Player[id].team_open == false then
					local teamid = _getPlayerTeam(id);
					if TEAM[teamid].leader ~= Player[id].nickname then

						_teamLog(TEAM[teamid].name, Player[id].nickname.." покинул фракцию.");
						SendPlayerMessage(id, 255, 255, 255, "Вы покинули фракцию "..TEAM[teamid].name..".");

						for i, v in pairs(TEAM[teamid].players) do
							if v == Player[id].nickname then
								table.remove(TEAM[teamid].players, i);
							end
						end

						os.remove("Database/Team/"..TEAM[teamid].name.."/players/"..Player[id].nickname..".txt");

						_saveMyTeam(id);
						Player[id].team = nil;
						Player[id].team_pos = "NULL";
						_saveTeam(id);
					else
						SendPlayerMessage(id, 255, 255, 255, "Лидер не может покинуть собственную фракцию (открывайте тикет в дискорде).")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
			end
		end
	end
end
addCommandHandler({"/мф_уйти", "/mt_leave"}, _myteamLeave);

function _myteamKick(id, sets)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, pid, reason = sscanf(sets, "ds");
					if cmd == 1 then
						if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
							if pid ~= id then
								_teamLog(TEAM[teamid].name, Player[id].nickname.." выгнал игрока "..Player[pid].nickname);
								SendPlayerMessage(id, 255, 255, 255, "Вы выгнали игрока "..Player[pid].nickname.." из своей фракции.");

								for i, v in pairs(TEAM[teamid].players) do
									if v == Player[pid].nickname then
										table.remove(TEAM[teamid].players, i);
									end
								end

								os.remove("Database/Team/"..TEAM[teamid].name.."/players/"..Player[pid].nickname..".txt");

								_saveMyTeam(id);
								Player[pid].team = nil;
								Player[pid].team_pos = "NULL";
								_saveTeam(pid);
								SendPlayerMessage(pid, 255, 255, 255, "Вас выгнали из фракции по причине: "..reason);
							else
								SendPlayerMessage(id, 255, 255, 255, "Вы не можете выгнать самого себя.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Игрок не найден.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_выгнать (ид) (причина)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Выгонять из фракции может только лидер.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end

addCommandHandler({"/мф_выгнать", "/mt_kick"}, _myteamKick);

function _myteamInvite(id, sets)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, pid = sscanf(sets, "d");
					if cmd == 1 then
						if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
							if pid ~= id then
								if table.getn(TEAM[teamid].players) < 20 then
									SendPlayerMessage(id, 255, 255, 255, "Вы пригласили игрока "..Player[pid].nickname.." в свою фракцию.");
									SendPlayerMessage(pid, 255, 255, 255, "Вас пригласили в фракцию "..TEAM[teamid].name);
									SendPlayerMessage(pid, 255, 255, 255, "Для ответа введите фракцию: /мф_да или /мф_нет")
									Player[pid].team_invite = {teamid, id};
								else
									SendPlayerMessage(id, 255, 255, 255, "Ваша фракция полностью укомплектована.")
								end
							else
								SendPlayerMessage(id, 255, 255, 255, "Вы не можете пригласить самого себя.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Игрок не найден.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_пригласить (ид)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Приглашать в фракцию может только лидер.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end
addCommandHandler({"/мф_пригласить", "/mt_invite"}, _myteamInvite);


function _myteamYes(id)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team == nil then
			if Player[id].team_invite[1] ~= nil then
				local teamid = Player[id].team_invite[1];
				table.insert(TEAM[teamid].players, Player[id].nickname);
				Player[id].team = TEAM[teamid].name;
				Player[id].team_pos = TEAM[teamid].ranks[table.getn(TEAM[teamid].ranks)];

				local file = io.open("Database/Team/"..TEAM[teamid].name.."/players/"..Player[id].nickname..".txt", "w");
				file:write(Player[id].nickname.."\n"..Player[id].team_pos);
				file:close();

				_saveTeam(id);
				_saveMyTeam(id);

				_teamLog(TEAM[teamid].name, Player[id].nickname.." присоединился к фракции.");

				SendPlayerMessage(id, 255, 255, 255, "Вы приняли приглашение в фракцию "..TEAM[teamid].name);
				SendPlayerMessage(id, 255, 255, 255, "Используйте /мф");
				SendPlayerMessage(Player[id].team_invite[2], 255, 255, 255, "Игрок "..Player[id].nickname.." принял приглашение в фракцию.");

				Player[id].team_invite = {nil, nil};

			else
				SendPlayerMessage(id, 255, 255, 255, "Активных приглашений нет.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вы уже состоите в фракции. Уйти из текущей фракции - /мф_уйти")
		end
	end
end
end
addCommandHandler({"/мф_да", "/mt_yes"}, _myteamYes);


function _myteamNo(id)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team_invite[1] ~= nil then
			SendPlayerMessage(id, 255, 255, 255, "Вы отвергли приглашение в фракцию.");
			SendPlayerMessage(Player[id].team_invite[2], 255, 255, 255, "Игрок "..Player[id].nickname.." отверг приглашение в фракцию.");
			Player[id].team_invite = {nil, nil};
		else
			SendPlayerMessage(id, 255, 255, 255, "Активных приглашений нет.")
		end
	end
end
end
addCommandHandler({"/мф_нет", "/mt_no"}, _myteamNo);

function _myteamGive(id, sets)

	if TEAM_CAPTURE == false then
	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			if Player[id].team_open == false then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then
					local cmd, pid, name = sscanf(sets, "ds");
					if cmd == 1 then
						if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then

							local arank = false;
							for _, v in pairs(TEAM[teamid].ranks) do
								if v == name then
									arank = true;
								end
							end

							if arank == true then
								_teamLog(TEAM[teamid].name, Player[id].nickname.." дал ранг "..Player[pid].nickname..": "..name);
								SendPlayerMessage(id, 255, 255, 255, "Вы назначили игроку "..Player[pid].nickname.." ранг "..name);

								Player[pid].team_pos = name;

								local file = io.open("Database/Team/"..TEAM[teamid].name.."/players/"..Player[pid].nickname..".txt", "w");
								file:write(Player[pid].nickname.."\n"..Player[pid].team_pos);
								file:close();

								_saveMyTeam(id);
								_saveTeam(pid);
								SendPlayerMessage(pid, 255, 255, 255, "Вам назначили ранг: "..name);
							else
								SendPlayerMessage(id, 255, 255, 255, "Такой должности в фракции нет.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Игрок не найден.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "/мф_ранг (ид) (название)")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Выдавать должности может только лидер..")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Вначале закройте основное меню фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "У вас нет своей фракции.")
		end
	end
end
end
addCommandHandler({"/мф_ранг", "/mt_rank"}, _myteamGive);



-- ==============================================================================================================================================================
-- ==============================================================================================================================================================
-- ==============================================================================================================================================================
-- ==============================================================================================================================================================


function _saveMyTeam(id)

	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			local teamid = _getPlayerTeam(id);
			
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/description", "w");
			if table.getn(TEAM[teamid].description) > 0 then
				for i = 1, 23 do
					if TEAM[teamid].description[i] ~= nil then
						file:write(TEAM[teamid].description[i].."\n");
					else
						file:write("##\n");
					end
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/ranks", "w");
			if table.getn(TEAM[teamid].ranks) > 0 then
				for i = 1, table.getn(TEAM[teamid].ranks) do
					file:write(TEAM[teamid].ranks[i].."\n");
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/zones", "w");
			if table.getn(TEAM[teamid].zones) > 0 then
				for i = 1, table.getn(TEAM[teamid].zones) do
					file:write(TEAM[teamid].zones[i].."\n");
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/preleaders", "w");
			if table.getn(TEAM[teamid].preleaders) > 0 then
				for i = 1, table.getn(TEAM[teamid].preleaders) do
					file:write(TEAM[teamid].preleaders[i].."\n");
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/players/list", "w");
			if table.getn(TEAM[teamid].players) > 0 then
				for i = 1, table.getn(TEAM[teamid].players) do
					file:write(TEAM[teamid].players[i].."\n");
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/items", "w");
			if table.getn(TEAM[teamid].items[1]) > 0 then
				for i = 1, table.getn(TEAM[teamid].items[1]) do
					file:write(string.upper(TEAM[teamid].items[1][i]).." "..TEAM[teamid].items[2][i].."\n");
				end
			end
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/bot", "w");
			file:write(TEAM[teamid].bot_pos[1].." "..TEAM[teamid].bot_pos[2].." "..TEAM[teamid].bot_pos[3].." "..GetPlayerAngle(TEAM[teamid].bot).." "..GetEquippedArmor(TEAM[teamid].bot).." "..GetPlayerWorld(TEAM[teamid].bot));
			file:close();
			-----------------------------------------------------------------
			local file = io.open("Database/Team/"..TEAM[teamid].name.."/info", "w");
			file:write(TEAM[teamid].name.."\n");
			file:write(TEAM[teamid].leader.."\n");
			file:write(TEAM[teamid].tag.."\n");
			file:write(TEAM[teamid].level.."\n");
			file:write(TEAM[teamid].coins.."\n");
			file:write(TEAM[teamid].color[1].." "..TEAM[teamid].color[2].." "..TEAM[teamid].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
			file:close();
		end
	end

end

function _getPlayerTOnline(id)

	if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
		return true;
	end
	return false;

end

function _getPlayerRank(team_name, name)

	local file = io.open("Database/Team/"..team_name.."/players/"..name..".txt", "r");
	if file then
		line = file:read("*l");
		line = file:read("*l");
		local l, str = sscanf(line, "s");
		if l == 1 then
			file:close();
			return str;
		end
	end
	return nil;

end

function _getPlayerByName(name)

	name = string.lower(name);
	for i = 0, GetMaxPlayers() do
		if IsNPC(i) == 0 and IsPlayerConnected(i) == 1 then
			if Player[i].loggedIn == true then
				if string.lower(Player[i].nickname) == name then
					return true;
				end
			end
		end
	end
	return false;
end

function _updateTeamPlayers(id, how)

	if how == "update" then

		ShowPlayerDraw(id, Player[id].team_draws_players_names);
		ShowPlayerDraw(id, Player[id].team_draws_players_pos);
		ShowPlayerDraw(id, Player[id].team_draws_players_status);

		local teamid = _getPlayerTeam(id);
		if teamid ~= nil then
			for i = 1, 20 do
				if TEAM[teamid].players[i] ~= nil then
					UpdatePlayerDraw(id, Player[id].team_draws_players_names_list[i], 2740, 1780 + 200*i, string.format("%d%s%s",i,") ",TEAM[teamid].players[i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					UpdatePlayerDraw(id, Player[id].team_draws_players_pos_list[i], 4330, 1780 + 200*i, _getPlayerRank(TEAM[teamid].name, TEAM[teamid].players[i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					if _getPlayerByName(TEAM[teamid].players[i]) == true then
						UpdatePlayerDraw(id, Player[id].team_draws_players_status_list[i], 5500, 1780 + 200*i, "Онлайн", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					else
						UpdatePlayerDraw(id, Player[id].team_draws_players_status_list[i], 5500, 1780 + 200*i, "Оффлайн", "Font_Old_10_White_Hi.TGA", 255, 148, 148);
					end
				end
			end
		end
	else

		HidePlayerDraw(id, Player[id].team_draws_players_names);
		HidePlayerDraw(id, Player[id].team_draws_players_pos);
		HidePlayerDraw(id, Player[id].team_draws_players_status);

		for i = 1, 20 do
			UpdatePlayerDraw(id, Player[id].team_draws_players_names_list[i], 2740, 1780 + 200*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			UpdatePlayerDraw(id, Player[id].team_draws_players_pos_list[i], 4330, 1780 + 200*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			UpdatePlayerDraw(id, Player[id].team_draws_players_status_list[i], 5500, 1780 + 200*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		end
	end

end

function _updateTeamInfo(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		for i = 1, table.getn(Player[id].team_draws_info_p) do
			ShowPlayerDraw(id, Player[id].team_draws_info_p[i]);
		end

		for i = 1, 4 do
			ShowPlayerDraw(id, Player[id].team_draws_info[i]);
		end

		UpdatePlayerDraw(id, Player[id].team_draws_info[1], 2740, 1980, Player[id].team, "Font_Old_20_White_Hi.TGA", TEAM[teamid].color[1], TEAM[teamid].color[2], TEAM[teamid].color[3]);
		UpdatePlayerDraw(id, Player[id].team_draws_info[2], 2740, 2380, string.format("%s%s","Тег фракции: ", TEAM[teamid].tag), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id].team_draws_info[3], 2740, 2580, string.format("%s%d","Влияние фракции: ", TEAM[teamid].level), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id].team_draws_info[4], 2740, 2780, string.format("%s%d","Баланс фракции: ", TEAM[teamid].coins), "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	else

		for i = 1, table.getn(Player[id].team_draws_info_p) do
			HidePlayerDraw(id, Player[id].team_draws_info_p[i]);
		end

		for i = 1, 4 do
			HidePlayerDraw(id, Player[id].team_draws_info[i]);
		end

		UpdatePlayerDraw(id, Player[id].team_draws_info[1], 2740, 1980, " ", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id].team_draws_info[2], 2740, 2380, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id].team_draws_info[3], 2740, 2580, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id].team_draws_info[4], 2740, 2780, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

	end
end

function _updateTeamRanks(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		for i = 1, 3 do
			ShowPlayerDraw(id, Player[id].team_draws_ranks_p[i]);
		end

		for i = 1, 10 do
			ShowPlayerDraw(id, Player[id].team_draws_ranks[i]);

			if TEAM[teamid].ranks[i] ~= nil then
				UpdatePlayerDraw(id, Player[id].team_draws_ranks[i], 2740, 2030 + 250*i, string.format("%s%d%s%s","# ",i," - ", TEAM[teamid].ranks[i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			end

		end

	else

		for i = 1, 3 do
			HidePlayerDraw(id, Player[id].team_draws_ranks_p[i]);
		end

		for i = 1, 10 do
			HidePlayerDraw(id, Player[id].team_draws_ranks[i]);
			UpdatePlayerDraw(id, Player[id].team_draws_ranks[i], 2740, 2180, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end

	end

end

function _updateTeamDescription(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		for i = 1, 23 do
			ShowPlayerDraw(id, Player[id].team_draws_description[i]);
			if TEAM[teamid].description[i] ~= nil then
				if TEAM[teamid].description[i] == "##" then
					UpdatePlayerDraw(id, Player[id].team_draws_description[i], 2740, 1780 + 170*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				else
					UpdatePlayerDraw(id, Player[id].team_draws_description[i], 2740, 1780 + 170*i, TEAM[teamid].description[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end
			end
		end

	else

		for i = 1, 23 do
			HidePlayerDraw(id, Player[id].team_draws_description[i]);
			if TEAM[teamid].description[i] ~= nil then
				UpdatePlayerDraw(id, Player[id].team_draws_description[i], 2740, 1780 + 170*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			end
		end

	end


end

function _updateTeamHistory(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		local temparr = {};

		local file = io.open("Database/Team/"..TEAM[teamid].name.."/history", "r");
		if file then
			for line in file:lines() do
				local l, text = sscanf(line, "s");
				if l == 1 then
					table.insert(temparr, text);
				end
			end
			file:close();
		end

		if table.getn(temparr) < 24 then
			for i = 1, 23 do
				ShowPlayerDraw(id, Player[id].team_draws_history[i]);
				if temparr[i] ~= nil then
					UpdatePlayerDraw(id, Player[id].team_draws_history[i], 2740, 1780 + 170*i, temparr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end
			end

		elseif table.getn(temparr) > 23 then
			local c = 1;
	  		for i = table.getn(temparr), 1, -1 do
	  			if c == 23 then
	  				break
	  			else
	  				ShowPlayerDraw(id, Player[id].team_draws_history[c]);
					UpdatePlayerDraw(id, Player[id].team_draws_history[c], 2740, 1780 + 170*c, temparr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	  				c = c + 1;
	  			end
	  		end
		end

		

	else

		for i = 1, 23 do
			HidePlayerDraw(id, Player[id].team_draws_history[i]);
			UpdatePlayerDraw(id, Player[id].team_draws_history[i], 2740, 1780 + 170*i, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end

	end


end

function _updateTeamMap(id, how)

	if how == "update" then

		if GetPlayerWorld(id) == "ADDONWORLD2.ZEN" then
			ShowTexture(id, maptexture);

			for i = 1, TZONES_AMOUNT do
				ShowPlayerDraw(id, Player[id].team_draws_tagszones[i]);
				if TZONES[i].team ~= nil then
					local tid = TZONES[i].team;
					SetPlayerDrawText(id, Player[id].team_draws_tagszones[i], TEAM[tid].tag);
				else
					SetPlayerDrawText(id, Player[id].team_draws_tagszones[i], "----");
				end
			end
		else

		end

	else

		if GetPlayerWorld(id) == "ADDONWORLD2.ZEN" then

			HideTexture(id, maptexture);
			for i = 1, TZONES_AMOUNT do
				ShowPlayerDraw(id, Player[id].team_draws_tagszones[i]);
				SetPlayerDrawText(id, Player[id].team_draws_tagszones[i], " ");
			end

		else

		end
	end


end

function _updateTeamZones(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		ShowPlayerDraw(id, Player[id].team_draws_zones_title);
		local k = 1;
		for i = 1, TZONES_AMOUNT do
			ShowPlayerDraw(id, Player[id].team_draws_zones[i]);

			if TEAM[teamid].zones[k] ~= nil then
				UpdatePlayerDraw(id, Player[id].team_draws_zones[i], 2740, 2180 + 200 * k, string.format("%ds%s%s", k, ". ", TEAM[teamid].zones[k]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				k = k + 1;
			end

			if table.getn(TEAM[teamid].zones) < 1 then
				k = 5;
				UpdatePlayerDraw(id, Player[id].team_draws_zones[i], 2740, 2180 + 200 * k, "Нет территорий под контролем", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			end

		end

	else

		HidePlayerDraw(id, Player[id].team_draws_zones_title);

		for i = 1, TZONES_AMOUNT do
			UpdatePlayerDraw(id, Player[id].team_draws_zones[i], 0, 0, "", "", 0, 0, 0);
			HidePlayerDraw(id, Player[id].team_draws_zones[i]);
		end

	end


end

function _updateTeamItems(id, how)

	local teamid = _getPlayerTeam(id);
	if how == "update" then

		ShowPlayerDraw(id, Player[id].team_draws_items_title);
		ShowPlayerDraw(id, Player[id].team_draws_items_name);
		ShowPlayerDraw(id, Player[id].team_draws_items_amount);

		for i = 1, table.getn(Player[id].team_draws_items_p) do
			ShowPlayerDraw(id, Player[id].team_draws_items_p[i]);
		end

		if TEAM[teamid].leader == Player[id].nickname then
			if table.getn(TEAM[teamid].items[1]) > 0 then
				local k = 1;
				for i = 1, 10 do
					ShowPlayerDraw(id, Player[id].team_draws_items[i])
					ShowPlayerDraw(id, Player[id].team_draws_items_a[i])
					if TEAM[teamid].items[1][i] ~= nil then
						UpdatePlayerDraw(id, Player[id].team_draws_items[i], 2805, 2510 + 300 * k, string.format("%d%s%s",k,". ",GetItemName(TEAM[teamid].items[1][i])), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						UpdatePlayerDraw(id, Player[id].team_draws_items_a[i], 5410, 2510 + 300 * k, TEAM[teamid].items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						k = k + 1;
					end
				end
			end
		else
			ShowPlayerDraw(id, Player[id].team_draws_zones[1]);
			UpdatePlayerDraw(id, Player[id].team_draws_zones[1], 2740, 2180 + 200 * 5, "   ## Информация доступна только лидеру", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end

	else

		HidePlayerDraw(id, Player[id].team_draws_items_title);
		HidePlayerDraw(id, Player[id].team_draws_items_name);
		HidePlayerDraw(id, Player[id].team_draws_items_amount);

		for i = 1, table.getn(Player[id].team_draws_items_p) do
			HidePlayerDraw(id, Player[id].team_draws_items_p[i]);
		end

		if TEAM[teamid].leader == Player[id].nickname then
			if table.getn(TEAM[teamid].items[1]) > 0 then
				for i = 1, 10 do
					HidePlayerDraw(id, Player[id].team_draws_items[i])
					HidePlayerDraw(id, Player[id].team_draws_items_a[i])
					UpdatePlayerDraw(id, Player[id].team_draws_items[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					UpdatePlayerDraw(id, Player[id].team_draws_items_a[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				end
			end
		else
			HidePlayerDraw(id, Player[id].team_draws_zones[1]);
			UpdatePlayerDraw(id, Player[id].team_draws_zones[1], 2740, 2180 + 200 * 5, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end

	end

end


function _updateLeftList(id)

	local tempArr = {"Информация", "Описание", "Участники", "Должности", "История", "Территория", "Карта", "Склад"};
	for i = 1, 8 do
		UpdatePlayerDraw(id, Player[id].team_draws_list[i], 1540, 1515 + 400*i, tempArr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _updateLeftListColor(id, pos)

	local tempArr = {"Информация", "Описание", "Участники", "Должности", "История", "Территория", "Карта", "Склад"};
	for i = 1, 8 do
		if i == pos then
			UpdatePlayerDraw(id, Player[id].team_draws_list[i], 1540, 1515 + 400*i, tempArr[i], "Font_Old_10_White_Hi.TGA", 120, 255, 117);
		else
			UpdatePlayerDraw(id, Player[id].team_draws_list[i], 1540, 1515 + 400*i, tempArr[i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end

function _resetLeftList(id)

	for i = 1, 8 do
		UpdatePlayerDraw(id, Player[id].team_draws_list[i], 1540, 1515 + 400*i, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end


function _teamKey(id, down, up)


	if Player[id].loggedIn == true then
		if Player[id].team_open == true then

			if down == KEY_DOWN then

				_updateLeftList(id);
				Player[id].team_list = Player[id].team_list + 1;
				if Player[id].team_list > 8 then
					Player[id].team_list = 1;
				end
				_updateLeftListColor(id, Player[id].team_list);

				if Player[id].team_list == 1 then
					_updateTeamInfo(id, "update")
				else
					_updateTeamInfo(id, "hide")
				end

				if Player[id].team_list == 2 then
					_updateTeamDescription(id, "update")
				else
					_updateTeamDescription(id, "hide")
				end

				if Player[id].team_list == 3 then
					_updateTeamPlayers(id, "update");
				else
					_updateTeamPlayers(id, "hide");
				end

				if Player[id].team_list == 4 then
					_updateTeamRanks(id, "update")
				else
					_updateTeamRanks(id, "hide")
				end

				if Player[id].team_list == 5 then
					_updateTeamHistory(id, "update")
				else
					_updateTeamHistory(id, "hide")
				end

				if Player[id].team_list == 6 then
					_updateTeamZones(id, "update")
				else
					_updateTeamZones(id, "hide")
				end

				if Player[id].team_list == 7 then
					_updateTeamMap(id, "update")
				else
					_updateTeamMap(id, "hide")
				end

				if Player[id].team_list == 8 then
					_updateTeamItems(id, "update")
				else
					_updateTeamItems(id, "hide")
				end


			end

			if down == KEY_UP then

				_updateLeftList(id);
				Player[id].team_list = Player[id].team_list - 1;
				if Player[id].team_list < 1 then
					Player[id].team_list = 8;
				end
				_updateLeftListColor(id, Player[id].team_list);

				if Player[id].team_list == 1 then
					_updateTeamInfo(id, "update")
				else
					_updateTeamInfo(id, "hide")
				end

				if Player[id].team_list == 2 then
					_updateTeamDescription(id, "update")
				else
					_updateTeamDescription(id, "hide")
				end

				if Player[id].team_list == 3 then
					_updateTeamPlayers(id, "update");
				else
					_updateTeamPlayers(id, "hide");
				end

				if Player[id].team_list == 4 then
					_updateTeamRanks(id, "update")
				else
					_updateTeamRanks(id, "hide")
				end

				if Player[id].team_list == 5 then
					_updateTeamHistory(id, "update")
				else
					_updateTeamHistory(id, "hide")
				end

				if Player[id].team_list == 6 then
					_updateTeamZones(id, "update")
				else
					_updateTeamZones(id, "hide")
				end

				if Player[id].team_list == 7 then
					_updateTeamMap(id, "update")
				else
					_updateTeamMap(id, "hide")
				end

				if Player[id].team_list == 8 then
					_updateTeamItems(id, "update")
				else
					_updateTeamItems(id, "hide")
				end

			end

		end
	end

end

function _teamPlusGold(id, sets)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then

					local x, y, z = GetPlayerPos(id);

					if GetDistance3D(x, y, z, TEAM[teamid].bot_pos[1], TEAM[teamid].bot_pos[2], TEAM[teamid].bot_pos[3]) < 400 then
						local cmd, amount = sscanf(sets, "d");
						if cmd == 1 then

							if Player[id].gold >= amount then
								TEAM[teamid].coins = TEAM[teamid].coins + amount;
								Player[id].gold = Player[id].gold - amount;
								SavePlayer(id);
								_teamMessage(id, "Вы положили "..amount.." золота на баланс своей фракции.");
								--SendPlayerMessage(id, 255, 255, 255, "Вы положили "..amount.." золота на баланс своей фракции.")
								_saveMyTeam(id);
								_teamLog(TEAM[teamid].name, Player[id].nickname.." пополнил баланс на: "..amount.."з.");
							else
								_teamMessage(id, "У вас нет столько золота.");
								--SendPlayerMessage(id, 255, 255, 255, "У вас нет столько золота.");
							end

						else
							SendPlayerMessage(id, 255, 255, 255, "/мф_пзолото (значение)")
						end

					else
						SendPlayerMessage(id, 255, 255, 255, "Вы слишком далеко от бота своей фракции.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь лидером.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет фракции.");
			end
		end
	end
end
addCommandHandler({"/мф_пзолото"}, _teamPlusGold);

function _teamMinusGold(id, sets)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then

					local x, y, z = GetPlayerPos(id);

					if GetDistance3D(x, y, z, TEAM[teamid].bot_pos[1], TEAM[teamid].bot_pos[2], TEAM[teamid].bot_pos[3]) < 400 then
						local cmd, amount = sscanf(sets, "d");
						if cmd == 1 then

							if TEAM[teamid].coins >= amount then
								TEAM[teamid].coins = TEAM[teamid].coins - amount;
								Player[id].gold = Player[id].gold + amount;
								SavePlayer(id);
								_teamMessage(id,  "Вы забрали "..amount.." золота из баланса своей фракции.")
								_saveMyTeam(id);
								_teamLog(TEAM[teamid].name, Player[id].nickname.." снял с баланса: "..amount.."з.");
							else
								_teamMessage(id,  "На балансе фракции нет столько золота.");
							end

						else
							_teamMessage(id,  "/мф_взолото (значение)")
						end

					else
						SendPlayerMessage(id, 255, 255, 255, "Вы слишком далеко от бота своей фракции.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь лидером.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет фракции.");
			end
		end
	end
end
addCommandHandler({"/мф_взолото"}, _teamMinusGold);


function _teamPutItem(id, sets)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then

					local x, y, z = GetPlayerPos(id);

					if GetDistance3D(x, y, z, TEAM[teamid].bot_pos[1], TEAM[teamid].bot_pos[2], TEAM[teamid].bot_pos[3]) < 400 then
						local cmd, slot, amount = sscanf(sets, "dd");
						if cmd == 1 then
							if amount > 0 then
								Player[id].team_slot = slot;
								Player[id].team_amount = amount;
								Player[id].team_put = true;
								GetPlayerItem(id, slot);
							else
								_teamMessage(id, "Количество должно быть больше 0.")
							end
						else
							_teamMessage(id, "/мф_положить (слот) (количество)");
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Вы слишком далеко от бота своей фракции.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь лидером.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет фракции.");
			end
		end
	end
				
end
addCommandHandler({"/мф_положить"}, _teamPutItem);

function _teamResponse(id, slot, itemInstance, amount, equipped)

	itemInstance = string.upper(itemInstance);
	if Player[id].team_put == true then
		
		if itemInstance ~= "NULL" then
			if Player[id].team_amount <= amount then

				local teamid = _getPlayerTeam(id);
				local status = false;

				for _, v in pairs(TEAM[teamid].items[1]) do
					if v == itemInstance then
						status = true;
					end
				end

				if status == false then
					if table.getn(TEAM[teamid].items[1]) < 10 then

						table.insert(TEAM[teamid].items[1], itemInstance);
						table.insert(TEAM[teamid].items[2], amount);
						_saveMyTeam(id);

						RemoveItem(id, itemInstance, amount);
						SaveItems(id);
						_teamMessage(id, "Вы убрали на склад: "..GetItemName(itemInstance).." в количестве "..amount);
						Player[id].team_slot = nil;
						Player[id].team_amount = nil;
						Player[id].team_put = false;
					else
						_teamMessage(id, "Склад переполнен (максимум 10 предметов).")
						Player[id].team_put = false;
					end
				else
					for i, v in pairs(TEAM[teamid].items[1]) do
						if v == itemInstance then
							TEAM[teamid].items[2][i] = TEAM[teamid].items[2][i] + amount;
							RemoveItem(id, itemInstance, amount);
							SaveItems(id);
							_teamMessage(id, "Вы убрали на склад: "..GetItemName(itemInstance).." в количестве "..amount);
							Player[id].team_slot = nil;
							Player[id].team_amount = nil;
							Player[id].team_put = false;
							break
						end
					end
				end
			else
				_teamMessage(id, "У вас столько нет.")
				Player[id].team_put = false;
			end
		else
			_teamMessage(id, "Слот пуст.")
			Player[id].team_put = false;
		end
	end

end


function _teamTakeFrom(id, sets)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then

					local x, y, z = GetPlayerPos(id);

					if GetDistance3D(x, y, z, TEAM[teamid].bot_pos[1], TEAM[teamid].bot_pos[2], TEAM[teamid].bot_pos[3]) < 400 then
						local cmd, pos, amount = sscanf(sets, "dd");
						if cmd == 1 then

							if pos > 0 and pos < 11 then
								if TEAM[teamid].items[1][pos] ~= nil then
									if TEAM[teamid].items[2][pos] > amount then
										TEAM[teamid].items[2][pos] = TEAM[teamid].items[2][pos] - amount;
										GiveItem(id, TEAM[teamid].items[1][pos], amount);
										SaveItems(id);
										_saveMyTeam(id);
										_teamMessage(id, "Вы взяли "..GetItemName(TEAM[teamid].items[1][pos]).." в количестве x"..amount);

									elseif TEAM[teamid].items[2][pos] == amount then
										_teamMessage(id, "Вы взяли "..GetItemName(TEAM[teamid].items[1][pos]).." в количестве x"..amount);
										GiveItem(id, TEAM[teamid].items[1][pos], amount);
										table.remove(TEAM[teamid].items[1], pos);
										table.remove(TEAM[teamid].items[2], pos);
										SaveItems(id);
										_saveMyTeam(id);

									elseif TEAM[teamid].items[2][pos] < amount then
										_teamMessage(id, "На складе столько нет.")
									end
								else
									_teamMessage(id, "Слот пуст.")
								end
							else
								_teamMessage(id, "Неверно указан слот на складе.")
							end
						else
							_teamMessage(id, "/мф_взять (слот) (кол-во)")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Вы слишком далеко от бота своей фракции.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь лидером.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет фракции.");
			end
		end
	end
end
addCommandHandler({"/мф_взять"}, _teamTakeFrom);

function _teamTerritoryBonus(id)

	if TEAM_CAPTURE == false then
		if Player[id].loggedIn == true then
			if Player[id].team ~= nil then
				local teamid = _getPlayerTeam(id);
				if TEAM[teamid].leader == Player[id].nickname then

					local x, y, z = GetPlayerPos(id);
					if GetDistance3D(x, y, z, TEAM[teamid].bot_pos[1], TEAM[teamid].bot_pos[2], TEAM[teamid].bot_pos[3]) < 400 then

						for i = 1, TZONES_AMOUNT do
							if TZONES[i].team == teamid and TZONES[i].type == "income" then
								local skip_status = false;
								for _, w in pairs(TEAM_BOTS_LIST) do
									if w == i then
										skip_status = true;
										break
									end
								end
								if skip_status == false then
									if TZONES[i].bonus_type == "item" then
									
										for _, iN in pairs(TZONES[i].bonus) do
											GiveItem(id, string.upper(iN), 1);
										end

									elseif TZONES[i].bonus_type == "gold" then
										local brnd = math.random(TZONES[i].bonus[1], TZONES[i].bonus[2]);
										TEAM[teamid].coins = TEAM[teamid].coins + brnd;
										_teamLog(TEAM[teamid].name, "Бонус получен: "..brnd.." монет.");
										_teamMessage(id, "Бонус получен: "..brnd.." монет.");
									end

									local file = io.open("Database/Team/zones_bonus.txt", "a");
									file:write(i.."\n");
									file:close();
									table.insert(TEAM_BOTS_LIST, i);

								end
							end
						end
									
						_teamMessage(id, "(Фракции) Бонусы собраны.")
						SendPlayerMessage(id, 255, 255, 255, "(Фракции) Подсказка: золото начисляется на счет фракции, а предметы в инвентарь лидера.")
					else
						SendPlayerMessage(id, 255, 255, 255, "Вы слишком далеко от бота своей фракции.");
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Вы не являетесь лидером.");
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "У вас нет фракции.");
			end
		end
	end
end
addCommandHandler({"/мф_бонус"}, _teamTerritoryBonus)

function _teamSetOwnerTerr(id, sets)

	if Player[id].astatus > 3 then
		local cmd, team_name, zone_name = sscanf(sets, "ss");
		if cmd == 1 then

			local teamid_correct = {nil, false};
			for i = 1, 200 do
				if TEAM[i].name == team_name then
					teamid_correct[1] = i;
					teamid_correct[2] = true;
					break
				end
			end

			local zoneid_correct = {nil, false};
			for i = 1, TZONES_AMOUNT do
				if TZONES[i].name == zone_name then
					zoneid_correct[1] = i;
					zoneid_correct[2] = true;
					break
				end
			end

			if teamid_correct[2] == true and zoneid_correct[2] == true then

				local f1 = zoneid_correct[1];
				if TZONES[f1].team ~= nil then

					local tid = TZONES[f1].team;
					for i, v in pairs(TEAM[tid].zones) do
						if v == TZONES[f1].name then
							table.remove(TEAM[tid].zones, i);
							break
						end
					end

					local f2 = teamid_correct[1];
					table.insert(TEAM[f2].zones, zone_name);
					TZONES[f1].team = f2;

					local file = io.open("Database/Team/"..TEAM[tid].name.."/zones", "w");
					if table.getn(TEAM[tid].zones) > 0 then
						for i = 1, table.getn(TEAM[tid].zones) do
							file:write(TEAM[tid].zones[i].."\n");
						end
					else
						file:write("");
					end
					file:close();

					_teamLog(TEAM[tid].name, "(A) "..GetPlayerName(id).." забрал территорию "..zone_name);
					_teamLog(TEAM[f2].name, "(A) "..GetPlayerName(id).." выдал территорию "..zone_name);

					local file = io.open("Database/Team/"..TEAM[f2].name.."/zones", "w");
					if table.getn(TEAM[f2].zones) > 0 then
						for i = 1, table.getn(TEAM[f2].zones) do
							file:write(TEAM[f2].zones[i].."\n");
						end
					else
						file:write("");
					end
					file:close();

					for i = 0, GetMaxPlayers() do
						if Player[i].loggedIn == true and Player[i].team == TEAM[f2].name then
							SendPlayerMessage(i, 255, 255, 255, "(Территория) Администратор "..GetPlayerName(id).." отдал вашей фракции территорию: "..zone_name);
						end
					end

					for i = 0, GetMaxPlayers() do
						if Player[i].loggedIn == true and Player[i].team == TEAM[tid].name then
							SendPlayerMessage(i, 255, 255, 255, "(Территория) Администратор "..GetPlayerName(id).." забрал у вашей фракции территорию: "..zone_name);
						end
					end
					LogString("Logs/Admins/captureZones", "Администратор "..GetPlayerName(id).." отдал фракции "..TEAM[f2].name.." территорию: "..zone_name..", ранее фракции: "..TEAM[tid].name.." / ".._getRTime())
					SendPlayerMessage(id, 255, 255, 255, "Территория передана.")

					local syda = zoneid_correct[1];
					if TZONES[syda].type == "default" then
						TEAM[f2].level = TEAM[f2].level + 15;
						TEAM[tid].level = TEAM[tid].level - 15;

					elseif TZONES[syda].type == "income" then
						TEAM[f2].level = TEAM[f2].level + 30;
						TEAM[tid].level = TEAM[tid].level - 30;
					end

					if TEAM[tid].level < 1 then
						TEAM[tid].level = 0;
					end

					--#######################################################################
					local file = io.open("Database/Team/"..TEAM[f2].name.."/info", "w");
					file:write(TEAM[f2].name.."\n");
					file:write(TEAM[f2].leader.."\n");
					file:write(TEAM[f2].tag.."\n");
					file:write(TEAM[f2].level.."\n");
					file:write(TEAM[f2].coins.."\n");
					file:write(TEAM[f2].color[1].." "..TEAM[f2].color[2].." "..TEAM[f2].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
					file:close();
					-------------------------------------------------------------------------
					local file = io.open("Database/Team/"..TEAM[tid].name.."/info", "w");
					file:write(TEAM[tid].name.."\n");
					file:write(TEAM[tid].leader.."\n");
					file:write(TEAM[tid].tag.."\n");
					file:write(TEAM[tid].level.."\n");
					file:write(TEAM[tid].coins.."\n");
					file:write(TEAM[tid].color[1].." "..TEAM[tid].color[2].." "..TEAM[tid].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
					file:close()
					--#######################################################################

				else

					local f2 = teamid_correct[1];
					table.insert(TEAM[f2].zones, zone_name);
					TZONES[f1].team = f2;
					
					local file = io.open("Database/Team/"..TEAM[f2].name.."/zones", "w");
					if table.getn(TEAM[f2].zones) > 0 then
						for i = 1, table.getn(TEAM[f2].zones) do
							file:write(TEAM[f2].zones[i].."\n");
						end
					else
						file:write("");
					end
					file:close();

					_teamLog(TEAM[f2].name, "(A) "..GetPlayerName(id).." выдал территорию "..zone_name);

					for i = 0, GetMaxPlayers() do
						if Player[i].loggedIn == true and Player[i].team == TEAM[f2].name then
							SendPlayerMessage(i, 255, 255, 255, "(Территория) Администратор "..GetPlayerName(id).." отдал вашей фракции территорию: "..zone_name);
						end
					end
					LogString("Logs/Admins/captureZones", "Администратор "..GetPlayerName(id).." отдал фракции "..TEAM[f2].name.." территорию: "..zone_name.." / ".._getRTime())
					SendPlayerMessage(id, 255, 255, 255, "Территория передана.")

					local syda = zoneid_correct[1];
					if TZONES[syda].type == "default" then
						TEAM[f2].level = TEAM[f2].level + 15;

					elseif TZONES[syda].type == "income" then
						TEAM[f2].level = TEAM[f2].level + 30;
					end

					--#######################################################################
					local file = io.open("Database/Team/"..TEAM[f2].name.."/info", "w");
					file:write(TEAM[f2].name.."\n");
					file:write(TEAM[f2].leader.."\n");
					file:write(TEAM[f2].tag.."\n");
					file:write(TEAM[f2].level.."\n");
					file:write(TEAM[f2].coins.."\n");
					file:write(TEAM[f2].color[1].." "..TEAM[f2].color[2].." "..TEAM[f2].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
					file:close();
					--#######################################################################

				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Неверно указано название команды (кому отдать) или название территории (какую отдать).")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/а_территория (фракция) (территория)")
		end
	end
end
addCommandHandler({"/а_территория"}, _teamSetOwnerTerr);

TEAM_MESSAGE_TEXTURE = CreateTexture(1412.5, 6952.5, 6504.5, 7267.5, 'menu_ingame')
function _teamMessage(id, text)

	if text then
		GameTextForPlayer(id, 1552, 6991, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);
		ShowTexture(id, TEAM_MESSAGE_TEXTURE);
		SetTimerEx("_teamMessageHideTexture", 2500, 0, id);
	end

end

function _teamMessageHideTexture(id)
	HideTexture(id, TEAM_MESSAGE_TEXTURE);
end



------------------------------------------- capture

TEAM_CAPTURE = false; -- состояние активного капта
TEAM_FIGHTERS = {nil, nil} -- сражающиеся фракции
TEAM_CAPTURE_TIME = {0, 0}; -- время капта
TEAM_SCORE = {nil, nil}; -- счет
TEAM_ZONE = nil; -- за какую точку сражение
TEAM_CAPTURE_FREEZE = false; -- разрешение на захват
TEAM_CAPTURE_TIMER = nil;
TEAM_CHEKER_TIMER = nil;

function _getNearestTerritory(id)

	local x, y, z = GetPlayerPos(id);
	for i = 1, TZONES_AMOUNT do
		if TZONES[i] ~= nil then
			if GetDistance3D(x, y, z, TZONES[i].locate[1], TZONES[i].locate[2], TZONES[i].locate[3]) < 950 then
				return i;
			end
		end
	end
	return nil;

end

function _teamEndCD()
	TEAM_CAPTURE_FREEZE = false;
end

function _getIdFromNamememememememememem(name)

	for i = 0, GetMaxPlayers() do
		if GetPlayerName(i) == name then
			return i;
		end
	end
	return nil;

end


function _teamGetOnline(teamid)

	local team_players_amount = table.getn(TEAM[teamid].players)
	local team_players_online = 0;
	for i = 1, team_players_amount do
		local pid = _getIdFromNamememememememememem(TEAM[teamid].players[i])
		if pid ~= nil then
			if Player[pid].loggedIn == true then
				team_players_online = team_players_online + 1;
			end
		end
	end
	
	if team_players_amount == 1 and team_players_online == 1 then
		team_players_online = 5;
	end
	
	return team_players_online;

end

function _teamResetFullTimerDraw()

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true then
			UpdatePlayerDraw(i, Player[i].hud_twar_draws[1], 0, 0, "", "", 0, 0, 0);
			UpdatePlayerDraw(i, Player[i].hud_twar_draws[2], 0, 0, "", "", 0, 0, 0);
		end
	end

end

function _teamUpdateTimerDraw()

	for p = 0, GetMaxPlayers() do
		if Player[p].team ~= nil or Player[p].team ~= "NULL" then
			if TEAM_CAPTURE == true then
				local tempteam = _getPlayerTeam(p);
				
				if TEAM_FIGHTERS[1] == tempteam then
					if Player[p].team_war_hud == true then
						UpdatePlayerDraw(p, Player[p].hud_twar_draws[1], 6277, 7450, string.format("%s%d%s%d", "До окончания сражения: ",TEAM_CAPTURE_TIME[1],":",TEAM_CAPTURE_TIME[2]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						UpdatePlayerDraw(p, Player[p].hud_twar_draws[2], 6277, 7600, string.format("%s%s", "Зона: ",TZONES[TEAM_ZONE].name), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					end
				end
				
				if TEAM_FIGHTERS[2] == tempteam then
					if Player[p].team_war_hud == true then
						UpdatePlayerDraw(p, Player[p].hud_twar_draws[1], 6277, 7450, string.format("%s%d%s%d", "До окончания сражения: ",TEAM_CAPTURE_TIME[1],":",TEAM_CAPTURE_TIME[2]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
						UpdatePlayerDraw(p, Player[p].hud_twar_draws[2], 6277, 7600, string.format("%s%s", "Зона: ",TZONES[TEAM_ZONE].name), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
					end
				end
			end
		end
	end

end

function _teamChekerOtherPlayers()

	if TEAM_CAPTURE == true then
		for i = 0, GetMaxPlayers() do
			if Player[i].loggedIn == true and GetPlayerWorld(i) == "ADDONWORLD2.ZEN" then
				local x, y, z = GetPlayerPos(i);
				for z = 1, TZONES_AMOUNT do
					if GetDistance3D(x, y, z, TZONES[z].locate[1], TZONES[z].locate[2], TZONES[z].locate[3]) < 2000 then
						GameTextForPlayer(i, 5371, 60, "В этом районе проходит боевое столкновение.", "Font_Old_10_White_Hi.TGA", 252, 73, 73, 3000);
					end
				end
			end
		end
	end


end

CAPTURE_TEX = CreateTexture(6146.5, 7360, 8091, 7942.5, 'menu_ingame');
function _doCapture(id)

	local Ateamid = _getPlayerTeam(id);

	if _getNearestTerritory(id) ~= nil then
		local zone = _getNearestTerritory(id);
		local Bteamid = TZONES[zone].team;

		-- условие: если точка принадлежит какой-то фракции
		if Bteamid ~= nil then
			-- условие: терртория не защищена от захвата
			if TZONES[zone].pfreeze == false then
				-- условие: территория не принадлежит фракции нападающего
				if TZONES[zone].team ~= Ateamid then
					-- условие: если онлайн фракции у защитника >= 50% то
					local enemy_stack = table.getn(TEAM[Bteamid].players);
					local enemy_online = _teamGetOnline(Bteamid);
					local enemy_can = (enemy_stack / 2);
					if enemy_online >= enemy_can then
					if enemy_online ~= 0 then
						-- условие: если сейчас не идет капт
						if TEAM_CAPTURE == false then
							-- условие: если фракция имеет попытки захвата
							if TEAM[Ateamid].cancapture > 0 then
								-- условие: если точка имеет попытки захвата
								if TZONES[zone].try > 0 then
									-- условие: КД на захват не идет
									if TEAM_CAPTURE_FREEZE == false then

										TEAM_CAPTURE = true;
										TEAM_FIGHTERS = {Ateamid, Bteamid} -- нападающий/защищающийся

										if TZONES[zone].type == "default" then
											TEAM_CAPTURE_TIME = {15, 0}; -- 15
											SetTimer("_teamEndCD", 1805000, 0);

										elseif TZONES[zone].type == "income" then
											TEAM_CAPTURE_TIME = {20, 0}; -- 20
											SetTimer("_teamEndCD", 3005000, 0);
										end

										TEAM_CHEKER_TIMER = SetTimer("_teamChekerOtherPlayers", 5000, 1);
										TEAM_CAPTURE_TIMER = SetTimer("_teamCaptureTimer", 1000, 1);

										TEAM_SCORE = {0, 0};
										TEAM_ZONE = zone;
										TEAM_CAPTURE_FREEZE = true;

										TZONES[zone].try = TZONES[zone].try - 1;
										TEAM[Ateamid].cancapture = TEAM[Ateamid].cancapture - 1;

										for i = 0, GetMaxPlayers() do
											if Player[i].loggedIn == true then
												local tempteam = _getPlayerTeam(i);
												if (TEAM_FIGHTERS[1] == tempteam or TEAM_FIGHTERS[2] == tempteam) then
													Player[i].team_war_hud = true;
													ShowPlayerDraw(i, Player[i].hud_twar_draws[1])
													ShowPlayerDraw(i, Player[i].hud_twar_draws[2])
													ShowTexture(i, CAPTURE_TEX);
												end
											end
										end
										

										SendMessageToAll(168, 255, 117, "(Война) Фракция "..TEAM[Ateamid].name.." напала на территорию фракции "..TEAM[Bteamid].name)
										SendMessageToAll(168, 255, 117, "(Война) Территория: "..TZONES[zone].name.." # Длительность сражения: "..TEAM_CAPTURE_TIME[1]..":00.");
									else
										SendPlayerMessage(id, 255, 255, 255, "Сейчас нельзя захватывать территории.")
									end
								else
									SendPlayerMessage(id, 255, 255, 255, "Сегодня эту зону захватывать больше нельзя.")
								end
							else
								SendPlayerMessage(id, 255, 255, 255, "Ваша фракция исчерпала лимит захватов на сегодня.")
							end
						else
							SendPlayerMessage(id, 255, 255, 255, "Сейчас уже идет сражение.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "Онлайн в фракции защищающегося меньше половины (==0), захват невозможен.")
					end
					else
						SendPlayerMessage(id, 255, 255, 255, "Онлайн в фракции защищающегося меньше половины, захват невозможен.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Нельзя нападать на свои территории.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Эту территорию нельзя захватить.")
			end
		else
			if TZONES[zone].pfreeze == false then
				if TEAM_CAPTURE_FREEZE == false then
					if TEAM_CAPTURE == false then
						TEAM_CAPTURE_FREEZE = true;

						if TZONES[zone].type == "default" then
							TEAM[Ateamid].level = TEAM[Ateamid].level + 15;

						elseif TZONES[zone].type == "income" then
							TEAM[Ateamid].level = TEAM[Ateamid].level + 30;
						end

						if TZONES[zone].bonus_type ~= "nil" and TZONES[zone].type == "default" then
							if TZONES[zone].bonus_type == "item" then
								for i = 1, table.getn(TZONES[zone].bonus) do
									if table.getn(TEAM[Ateamid].items[1]) < 10 then

										local add = false;
										for p, k in pairs(TEAM[Ateamid].items[1]) do
											if k == TZONES[zone].bonus[i] then
												TEAM[Ateamid].items[2][p] = TEAM[Ateamid].items[2][p] + 1;
												add = true;
											end
										end
										if add == false then
											table.insert(TEAM[Ateamid].items[1], TZONES[zone].bonus[i]);
											table.insert(TEAM[Ateamid].items[2], 1);
										end

										_teamLog(TEAM[Ateamid].name, "Разовый бонус: "..GetItemName(TZONES[zone].bonus[i]));
									else
										local bonus = math.random(10, 50);
										TEAM[Ateamid].coins = TEAM[Ateamid].coins + bonus;
										_teamLog(TEAM[Ateamid].name, "Инвентарь фракции полон, поэтому...");
										_teamLog(TEAM[Ateamid].name, "Разовый бонус в виде золота: "..bonus);
										break
									end
								end
							end
						end

						TZONES[zone].try = TZONES[zone].try - 1;
						TZONES[zone].team = Ateamid;
						TEAM[Ateamid].cancapture = TEAM[Ateamid].cancapture - 1;
						table.insert(TEAM[Ateamid].zones, TZONES[zone].name);
						_saveMyTeam(id);
						_teamLog(TEAM[Ateamid].name, "Успешный захват "..TZONES[zone].name);
						SendMessageToAll(168, 255, 117, "(Война) Фракция "..TEAM[Ateamid].name.." заняла территорию "..TZONES[zone].name)
						SetTimer("_teamEndCD", 902500, 0);
					else
						SendPlayerMessage(id, 255, 255, 255, "Сейчас уже идет сражение.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "Сейчас нельзя захватывать территории.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "Эту территорию нельзя захватить.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "Рядом нет территорий.")
	end
end
addCommandHandler({"/захват", "/capture"}, _doCapture);

function _teamCaptureTimer()

	if TEAM_CAPTURE == true then
		TEAM_CAPTURE_TIME[2] = TEAM_CAPTURE_TIME[2] - 1;
		if TEAM_CAPTURE_TIME[2] < 1 then
			TEAM_CAPTURE_TIME[2] = 59;
			TEAM_CAPTURE_TIME[1] = TEAM_CAPTURE_TIME[1] - 1;
		end
		
		_teamUpdateTimerDraw();

		if TEAM_CAPTURE_TIME[1] == 0 then
			if TEAM_CAPTURE_TIME[2] == 1 then

				KillTimer(TEAM_CAPTURE_TIMER);
				KillTimer(TEAM_CHEKER_TIMER);
				TEAM_CAPTURE_TIMER = nil;
				TEAM_CHEKER_TIMER = nil;

				local team1 = TEAM_FIGHTERS[1];
				local team2 = TEAM_FIGHTERS[2];

				for i = 0, GetMaxPlayers() do
					local tempteam = _getPlayerTeam(i);
					if (TEAM_FIGHTERS[1] == tempteam or TEAM_FIGHTERS[2] == tempteam) then
						if Player[i].team_war_hud == true then
							Player[i].team_war_hud = false;
							HidePlayerDraw(i, Player[i].hud_twar_draws[1])
							HidePlayerDraw(i, Player[i].hud_twar_draws[2])
							HideTexture(i, CAPTURE_TEX);
						end
					end
				end

				_teamResetFullTimerDraw();

				-- условия победы нападавшего
				if (TEAM_SCORE[1] > TEAM_SCORE[2]) or (TEAM_SCORE[1] == TEAM_SCORE[2]) or (TEAM_SCORE[1] == 0 and TEAM_SCORE[2] == 0) then
					
					_teamLog(TEAM[team1].name, "Успешный захват "..TZONES[TEAM_ZONE].name);
					_teamLog(TEAM[team2].name, "Провал удержания "..TZONES[TEAM_ZONE].name);

					TZONES[TEAM_ZONE].team = team1;
					table.insert(TEAM[team1].zones, TZONES[TEAM_ZONE].name);

					for i = 1, table.getn(TEAM[team2].zones) do
						if TEAM[team2].zones[i] == TZONES[TEAM_ZONE].name then
							table.remove(TEAM[team2].zones, i);
							break
						end
					end
					--#######################################################################
					--#######################################################################
					if TZONES[TEAM_ZONE].type == "default" then
						TEAM[team1].level = TEAM[team1].level + 15;
						TEAM[team2].level = TEAM[team2].level - 15;

					elseif TZONES[TEAM_ZONE].type == "income" then
						TEAM[team1].level = TEAM[team1].level + 30;
						TEAM[team2].level = TEAM[team2].level - 30;
					end

					if TEAM[team2].level < 1 then
						TEAM[team2].level = 0;
					end

					if TZONES[TEAM_ZONE].bonus_type ~= "nil" and TZONES[TEAM_ZONE].type == "default" then
						
						if TZONES[TEAM_ZONE].bonus_type == "item" then
							for i = 1, table.getn(TZONES[TEAM_ZONE].bonus) do
							
								if table.getn(TEAM[team1].items[1]) < 10 then
				
									local add = false;
									for p, k in pairs(TEAM[team1].items[1]) do
										if k == TZONES[TEAM_ZONE].bonus[i] then
											TEAM[team1].items[2][p] = TEAM[team1].items[2][p] + 1;
											add = true;
										end
									end

									if add == false then
										table.insert(TEAM[team1].items[1], TZONES[TEAM_ZONE].bonus[i]);
										table.insert(TEAM[team1].items[2], 1);
									end
								else
								
									local bonus = math.random(20, 50);
									TEAM[team1].coins = TEAM[team1].coins + bonus;
									_teamLog(TEAM[team1].name, "Инвентарь фракции полон (замена в виде золота).");
									_teamLog(TEAM[team1].name, "Разовый бонус в виде золота: "..bonus);
									break
								end
							end
							
						elseif TZONES[TEAM_ZONE].bonus_type == "gold" then
							local bonus = math.random(20, 50);
							TEAM[team1].coins = TEAM[team1].coins + bonus;
							_teamLog(TEAM[team1].name, "Разовый бонус в виде золота: "..bonus);
						end
						
					end
					-------------------------------------------------------------------------
					local file = io.open("Database/Team/"..TEAM[team1].name.."/items", "w");
					if table.getn(TEAM[team1].items[1]) > 0 then
						for i = 1, table.getn(TEAM[team1].items[1]) do
							file:write(string.upper(TEAM[team1].items[1][i]).." "..TEAM[team1].items[2][i].."\n");
						end
					end
					file:close();
					-------------------------------------------------------------------------
					local file = io.open("Database/Team/"..TEAM[team1].name.."/info", "w");
					file:write(TEAM[team1].name.."\n");
					file:write(TEAM[team1].leader.."\n");
					file:write(TEAM[team1].tag.."\n");
					file:write(TEAM[team1].level.."\n");
					file:write(TEAM[team1].coins.."\n");
					file:write(TEAM[team1].color[1].." "..TEAM[team1].color[2].." "..TEAM[team1].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
					file:close();
					-------------------------------------------------------------------------
					local file = io.open("Database/Team/"..TEAM[team2].name.."/info", "w");
					file:write(TEAM[team2].name.."\n");
					file:write(TEAM[team2].leader.."\n");
					file:write(TEAM[team2].tag.."\n");
					file:write(TEAM[team2].level.."\n");
					file:write(TEAM[team2].coins.."\n");
					file:write(TEAM[team2].color[1].." "..TEAM[team2].color[2].." "..TEAM[team2].color[3].."\n0\n0\n0\n0\n0\n0\n0\n0\n0");
					file:close()
					--#######################################################################
					--#######################################################################
					local file = io.open("Database/Team/"..TEAM[team1].name.."/zones", "w");
					if table.getn(TEAM[team1].zones) > 0 then
						for i = 1, table.getn(TEAM[team1].zones) do
							file:write(TEAM[team1].zones[i].."\n");
						end
					else
						file:write("");
					end
					file:close();
					-------------------------------------------------------------------------
					local file = io.open("Database/Team/"..TEAM[team2].name.."/zones", "w");
					if table.getn(TEAM[team2].zones) > 0 then
						for i = 1, table.getn(TEAM[team2].zones) do
							file:write(TEAM[team2].zones[i].."\n");
						end
					else
						file:write("");
					end
					file:close();
					--#######################################################################

					SendMessageToAll(168, 255, 117, "(Война) Фракция "..TEAM[team1].name.." захватила территорию "..TZONES[TEAM_ZONE].name.." у фракции "..TEAM[team2].name);
					SendMessageToAll(168, 255, 117, "(Война) Счет: "..TEAM_SCORE[1]..":"..TEAM_SCORE[2]);

				-- условия сдерживания терртории
				elseif TEAM_SCORE[2] > TEAM_SCORE[1] then
					_teamLog(TEAM[team1].name, "Провал захвата "..TZONES[TEAM_ZONE].name);
					_teamLog(TEAM[team2].name, "Успешное удержание "..TZONES[TEAM_ZONE].name);
					SendMessageToAll(168, 255, 117, "(Война) Фракция "..TEAM[team2].name.." удержала территорию "..TZONES[TEAM_ZONE].name.." от фракции "..TEAM[team1].name);
					SendMessageToAll(168, 255, 117, "(Война) Счет: "..TEAM_SCORE[1]..":"..TEAM_SCORE[2]);
				end

				TEAM_CAPTURE = false;
				TEAM_FIGHTERS = {nil, nil}
				TEAM_CAPTURE_TIME = {0, 0};
				TEAM_SCORE = {nil, nil};
				TEAM_ZONE = nil; 

			end
		end
		

	end

end

function _teamPlayerDeath(pid, p_classid, kid, k_classid)
	
	if kid ~= -1 then
		if Player[kid].loggedIn == true and Player[pid].loggedIn == true then
			if TEAM_CAPTURE == true then
				local pteam = _getPlayerTeam(pid);
				local kteam = _getPlayerTeam(kid);
				if pteam ~= kteam then
					if (TEAM_FIGHTERS[1] == pteam or TEAM_FIGHTERS[2] == pteam) and (TEAM_FIGHTERS[1] == kteam or TEAM_FIGHTERS[2] == kteam) then

						local needpos = nil;
						for i = 1, 2 do
							if TEAM_FIGHTERS[i] == kteam then
								needpos = i;
								break
							end
						end

						
						if needpos ~= nil then
							TEAM_SCORE[needpos] = TEAM_SCORE[needpos] + 1;
							correct = true;
							SendPlayerMessage(kid, 255, 255, 255, "(Сражение) +1 очко в пользу вашей команды.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Вас убили, вы были телепортированы на лесопилку.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Команда противника получила +1 очко.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Вы можете вернуться битву или заняться своими делами.")
							SetPlayerPos(pid, -37844.3359375, -1908.4188232422, 17641.916015625);
							SetPlayerAngle(pid, math.random(1,360));
							SavePlayer(pid);
							CompleteHeal(pid);
							PlayAnimation(pid, "S_RUN");
							SaveStats(pid);
						end
						
					end
				end
			end
		end
	end
end

function _teamUncon(pid, p_classid, kid, k_classid)

	if IsNPC(pid) == 0 and IsNPC(kid) == 0 then
		if Player[kid].loggedIn == true and Player[pid].loggedIn == true then
			if TEAM_CAPTURE == true then
				local pteam = _getPlayerTeam(pid);
				local kteam = _getPlayerTeam(kid);
				if pteam ~= kteam then
					if (TEAM_FIGHTERS[1] == pteam or TEAM_FIGHTERS[2] == pteam) and (TEAM_FIGHTERS[1] == kteam or TEAM_FIGHTERS[2] == kteam) then

						local needpos = nil;
						for i = 1, 2 do
							if TEAM_FIGHTERS[i] == kteam then
								needpos = i;
								break
							end
						end

						
						if needpos ~= nil then
							TEAM_SCORE[needpos] = TEAM_SCORE[needpos] + 1;
							correct = true;
							SendPlayerMessage(kid, 255, 255, 255, "(Сражение) +1 очко в пользу вашей команды.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Вас убили, вы были телепортированы на лесопилку.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Команда противника получила +1 очко.")
							SendPlayerMessage(pid, 255, 255, 255, "(Сражение) Вы можете вернуться битву или заняться своими делами.")
							SetPlayerPos(pid, -37844.3359375, -1908.4188232422, 17641.916015625);
							SetPlayerAngle(pid, math.random(1,360));
							SavePlayer(pid);
							CompleteHeal(pid);
							SaveStats(pid);
						end

					end
				end
			end
		end
	end

end

function _teamChat(id, sets)

	if Player[id].loggedIn == true then
		if Player[id].team ~= nil then
			local teamid = _getPlayerTeam(id);
			local cmd, text = sscanf(sets, "s");
			if cmd == 1 then
				for i = 0, GetMaxPlayers() do
					if Player[i].team == TEAM[teamid].name then
						SendPlayerMessage(i, 119, 247, 84, "(Ф-Ч) "..Player[id].nickname..": "..text);
					end
				end
				LogString("Logs/PlayersAll/teamChat","("..TEAM[teamid].name..") "..Player[id].nickname..": "..text.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "/фчат (текст) - отправить сообщение в чат фракции.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Вы не состоите ни в какой фракции.")
		end
	end


end
addCommandHandler({"/фчат"}, _teamChat)