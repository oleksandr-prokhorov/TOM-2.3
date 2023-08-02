
--  # Chest system by royclapton #
--  #       version: 1.1         #
-- при установке уменьшать вторую координату на 95

local chest_window_left = CreateTexture(200, 1673, 3276, 7255, 'chest_gui_v5_chest')
local chest_window_right = CreateTexture(4776, 1673, 7846, 7255, 'chest_gui_v5_player')
local select_amount_block = CreateTexture(3475, 3960, 4635, 4485, 'menu_ingame')

CHEST = {};
DIR = "Database/Chests/";
DIRITEMS = "Database/Chests/Items/";
DIRINFO = "Database/Chests/Info/";

_chestArr = {};
CHESTS_VALUE = 0;
IDS_chest = {};

function _readWorld(c)

	c = tostring(c);
	local WORLD = ""; local filename = c..".txt";						
	local file = io.open("Database/Chests/Base/"..filename, "r");
	if file then
		line = file:read("*l");
		local l, wrld = sscanf(line, "s");
		if l == 1 then
			WORLD = wrld;
		end
		file:close();
	end

	return WORLD;

end

function _initChest()

	print(" ")
	print("################################ ")
	print("      CHEST SYSTEM")
	

	-- верхний 1
	_chestArr[1] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY48", _readWorld(1), 12358.453125, 1307.2321777344, -4564.9409179688, "chest_1");
	Mob.SetRotation(_chestArr[1], 0, 270, 0)
	-- верхний 3
	_chestArr[2] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY50", _readWorld(2), 13009.833984375, 1297.7438964844, -4212.8178710938, "chest_2");
	Mob.SetRotation(_chestArr[2], 0, 180, 0)
	-- верхний 4
	_chestArr[3] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY51", _readWorld(3), 16293.10546875, 906.41619873047, -3031.3798828125, "chest_3");
	Mob.SetRotation(_chestArr[3], 0, 100, 0)
	-- ремесленный 2б
	_chestArr[4] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY26", _readWorld(4), 6529.4638671875, 26.039505004883, 50.844116210938, "chest_4");
	Mob.SetRotation(_chestArr[4], 0, 150, 0)
	-- ремесленный 3
	_chestArr[5] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY27", _readWorld(5), 5901.2265625, 815.97686767578, 1683.2281494141, "chest_5");
	Mob.SetRotation(_chestArr[5], 0, 320, 0);
	-- верхний 6
	_chestArr[6] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY53", _readWorld(6), 10666.512695313, 890.16369628906, 3336.740234375, "chest_6");
	Mob.SetRotation(_chestArr[6], 0, 147, 0);
	-- ремесленный трактир
	_chestArr[7] = Mob.Create("CHESTSMALL_OCCHESTSMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY44", _readWorld(7), 6069.4248046875, 286.92361450195, -5680.8090820312, "chest_7");
	Mob.SetRotation(_chestArr[7], 0, 340, 0);
	-- ремесленный часовня
	_chestArr[8] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY47", _readWorld(8), 13692.000976562, -1464.8659667969, -2276.7375488281, "chest_8");
	Mob.SetRotation(_chestArr[8], 0, 270, 0);
	-- ремесленный тюрьма
	_chestArr[9] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY45", _readWorld(9), 3545.4440917969, 755.12426757812, 6261.9404296875, "chest_9");
	Mob.SetRotation(_chestArr[9], 0, 60, 0);
	-- портовый 1
	_chestArr[10] = Mob.Create("CHESTSMALL_OCCRATESMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY1", _readWorld(10), -4325.3579101562, -125.28565979004, -4742.6831054688, "chest_10");
	Mob.SetRotation(_chestArr[10], 0, 80, 0);
	-- портовый 11
	_chestArr[11] = Mob.Create("CHESTSMALL_OCCHESTSMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY11", _readWorld(11), -1569.7045898438, 76.155899047852, 433.65545654297, "chest_11");
	Mob.SetRotation(_chestArr[11], 0, 190, 0);
	-- портовый 15
	_chestArr[12] = Mob.Create("CHESTSMALL_OCCRATESMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY15", _readWorld(12), 3946.7280273438, -173.70721435547, 678.90203857422, "chest_12");
	Mob.SetRotation(_chestArr[12], 0, 110, 0);
	-- портовый 21 (араксос)
	_chestArr[13] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY21", _readWorld(13), -4068.2082519531, 150.93583679199, 2772.8666992188, "chest_13");
	Mob.SetRotation(_chestArr[13], 0, 90, 0);
	-- портовый трактир
	_chestArr[14] = Mob.Create("CHESTSMALL_OCCRATESMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY22", _readWorld(14), -2032.2377929688, -194.29194641113, -3752.5190429688, "chest_14");
	Mob.SetRotation(_chestArr[14], 0, 169, 0);
	-- портовый маяк
	_chestArr[15] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY56", _readWorld(15), -6226.9541015625, -179.32022094727, -5836.1411132813, "chest_15");
	Mob.SetRotation(_chestArr[15], 0, 8, 0);
	-- ремесленный казармы 2
	_chestArr[16] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY55", _readWorld(16), 6345.1328125, 745.36767578125, 7640.921875, "chest_16");
	Mob.SetRotation(_chestArr[16], 0, -209, 0);
	-- ферма 1
	_chestArr[17] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY57", _readWorld(17), 7563.353515625, 1125.7562255859, -19833.19140625, "chest_17");
	Mob.SetRotation(_chestArr[17], 0, -274, 0);
	-- ремесленный 6а
	_chestArr[18] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY33", _readWorld(18), 9518.3759765625, 263.98043823242, 4736.6572265625, "chest_18");
	Mob.SetRotation(_chestArr[18], 0, -115, 0);
	-- портовый бордель	
	_chestArr[19] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY23", _readWorld(19), 1038.3217773438, -180.09294128418, -9.1946830749512, "chest_19");
	Mob.SetRotation(_chestArr[19], 0, 90, 0);
	-- портовый 13	
	_chestArr[20] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY13", _readWorld(20), 2873.3254394531, -180.549667358398, 124.61810302734, "chest_20");
	Mob.SetRotation(_chestArr[20], 0, 266, 0);
	-- верхний 6	
	_chestArr[21] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY53", _readWorld(21), 11345.75, 890.3872680664, 3679.0385742188, "chest_21");
	Mob.SetRotation(_chestArr[21], 0, 189, 0);
	-- ремесленный 2а	
	_chestArr[22] = Mob.Create("CHESTSMALL_OCCRATESMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY25", _readWorld(22), 7350.40625, 460.41479492188, -759.88873291016, "chest_22");
	Mob.SetRotation(_chestArr[22], 0, 145, 0);
	-- ремесленный 8а	
	_chestArr[23] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY40", _readWorld(23), 9462.490234375, 831.30792236328, 6076.6923828125, "chest_23");
	Mob.SetRotation(_chestArr[23], 0, 285, 0);
	-- ремесленный 8б
	_chestArr[24] = Mob.Create("CHESTSMALL_OCCRATESMALLLOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY41", _readWorld(24), 8255.6865234375, 271.36831665039, 6143.619140625, "chest_24");
	Mob.SetRotation(_chestArr[24], 0, 194, 0);
	-- верхний 2	
	_chestArr[25] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY49", _readWorld(25), 10023.537109375, 1295.0931396484, -2727.1235351563, "chest_25");
	Mob.SetRotation(_chestArr[25], 0, 130, 0);
	-- верхний 2	
	_chestArr[26] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY49", _readWorld(26), 10564.840820313, 890.11248779297, -3320.884765625, "chest_26");
	Mob.SetRotation(_chestArr[26], 0, 311, 0);
	-- верхний 5	
	_chestArr[27] = Mob.Create("CHESTBIG_NW_RICH_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY52", _readWorld(27), 10351.870117188, 1302.166015625, 1526.3161621094, "chest_27");
	Mob.SetRotation(_chestArr[27], 0, 74, 0);

	-- порт, дом #6
	_chestArr[28] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY6", _readWorld(28), 2357.5378417969, -555.15002441406, -4130.740234375, "chest_28");
	Mob.SetRotation(_chestArr[28], 0, -256, 0);

	-- верхний, дом #7
	_chestArr[29] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY54", _readWorld(29), 12800.349609375, 902.11669921875, 3626.4562988281, "chest_29");
	Mob.SetRotation(_chestArr[29], 0, -160, 0);

	-- ратуша
	_chestArr[30] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY54", _readWorld(30), 15474.768554688, 1039.2459716797, 571.07513427734, "chest_30");
	Mob.SetRotation(_chestArr[30], 0, -134, 0);
	
	-- ремесленный дом 6д
	_chestArr[31] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY37", _readWorld(31), 11348.998046875, 268.31188964844, 3867.72265625, "chest_31");
	Mob.SetRotation(_chestArr[31], 0, -30, 0);

	-- ремесленный дом 1
	_chestArr[32] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY24", _readWorld(32), 6039.48828125, 263.15481567383, -596.01171875, "chest_32");
	Mob.SetRotation(_chestArr[32], 0, -304, 0);
	
	
	-- ремесленный дом 6б
	_chestArr[33] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY34", _readWorld(33), 9303.4033203125, 593.91271972656, 3676.2392578125, "chest_33");
	Mob.SetRotation(_chestArr[33], 0, -304, 0);
	
	-- порт-4
	_chestArr[34] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY4", _readWorld(34), 1056.640625, -193.28332519531, -4327.7709960938, "chest_34");
	Mob.SetRotation(_chestArr[34], 0, -249, 0);
	
	-- порт-16
	_chestArr[35] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY43", _readWorld(35), 3562.9997558594, -194.36831665039, 1936.7264404297, "chest_35");
	Mob.SetRotation(_chestArr[35], 0, -484, 0);
	
	-- порт-16
	_chestArr[36] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY43", _readWorld(36), 3495.2397460938, -194.36831665039, 2015.8985595703, "chest_36");
	Mob.SetRotation(_chestArr[36], 0, -140, 0);
	
	-- порт-9
	_chestArr[37] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY9", _readWorld(37), 1245.1885986328, -184.70693969727, -2400.9592285156, "chest_37");
	Mob.SetRotation(_chestArr[37], 0, 0, 0);
	
	-- ремесленный дом 5б
	_chestArr[38] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_KEY32", _readWorld(38), 8532.111328125, 603.47436523438, 3809.66796875, "chest_38");
	Mob.SetRotation(_chestArr[38], 0, 0, 0);

	-- яркендар дом 1
	_chestArr[39] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(39), -9999999, -9999999, -9999999, "chest_39");
	Mob.SetRotation(_chestArr[39], 0, 267, 0);
	
	-- яркендар дом 2
	_chestArr[40] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(40), -9999999, -9999999, -9999999, "chest_40");
	Mob.SetRotation(_chestArr[40], 0, 267, 0);
	
	-- яркендар дом 3
	_chestArr[41] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(41), -34645.140625, -1619.0290527344, 21116.318359375, "chest_41");
	Mob.SetRotation(_chestArr[41], 0, 46, 0);
	
	-- яркендар дом 4
	_chestArr[42] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY4", _readWorld(42), -34377.0234375, -1908.4984130859, 17862.6171875, "chest_42");
	Mob.SetRotation(_chestArr[42], 0, 138, 0);
	
	-- яркендар дом 5
	_chestArr[43] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY5", _readWorld(43), -37038.92578125, -1937.5847167969, 16958.630859375, "chest_43");
	Mob.SetRotation(_chestArr[43], 0, 195, 0);
	
	-- яркендар дом 6
	_chestArr[44] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(44), -9999999, -9999999, -9999999, "chest_44");
	Mob.SetRotation(_chestArr[44], 0, 46, 0);
	
	-- яркендар дом 7
	_chestArr[45] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(45), -9999999, -9999999, -9999999, "chest_45");
	Mob.SetRotation(_chestArr[45], 0, 46, 0);
	
	-- яркендар дом 8
	_chestArr[46] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(46), -9999999, -9999999, -9999999, "chest_46");
	Mob.SetRotation(_chestArr[46], 0, 46, 0);
	
	-- яркендар дом 9
	_chestArr[47] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(47), -9999999, -9999999, -9999999, "chest_47");
	Mob.SetRotation(_chestArr[47], 0, 46, 0);
	
	-- яркендар дом 10
	_chestArr[48] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(48), -9999999, -9999999, -9999999, "chest_48");
	Mob.SetRotation(_chestArr[48], 0, 46, 0);
	
	-- яркендар дом 11
	_chestArr[49] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(49), -9999999, -9999999, -9999999, "chest_49");
	Mob.SetRotation(_chestArr[49], 0, 46, 0);
	
	-- яркендар дом 12
	_chestArr[50] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(50), -9999999, -9999999, -9999999, "chest_50");
	Mob.SetRotation(_chestArr[50], 0, 46, 0);
	
	-- яркендар дом 13
	_chestArr[51] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY3", _readWorld(51), -9999999, -9999999, -9999999, "chest_51");
	Mob.SetRotation(_chestArr[51], 0, 46, 0);
	
	-- яркендар дом 15
	_chestArr[52] = Mob.Create("CHESTBIG_NW_NORMAL_LOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY15", _readWorld(52), -27867.140625, -1960.0885009766, 27459.7421875, "chest_52");
	Mob.SetRotation(_chestArr[52], 0, 267, 0);
	
	-- яркендар дом 16 (банда окуджава)
	_chestArr[53] = Mob.Create("CHESTBIG_OCCRATELARGELOCKED.MDS", "MOBNAME_CHEST", 1, "CHESTBIG", "OOLTYB_ITMI_JKEY16", _readWorld(53), -19480.154296875, -2945.6767578125, -11903.787109375, "chest_53");
	Mob.SetRotation(_chestArr[53], 0, -181, 0);
	

	for i = 1, table.getn(_chestArr) do
		local txt = "chest_"..i;
		table.insert(IDS_chest, txt);
	end


	print(table.getn(_chestArr).." load");
	print(" ")
	print("################################ ")

end

function _useChest(id, sc, chest_id, used)
	
	if sc == "CHESTBIG" then
		if used == 1 then

			if table.getn(IDS_chest) > 0 then
				for i, v in pairs(IDS_chest) do
					local cid = string.upper(v);
					if cid == chest_id then
						Player[id].chest_id = i;
						_chestDraw(id, i);
						break
					end
				end
			end

		else

			if Player[id].chest_id ~= 0 then
				_destroyChestDraw(id);
				ShowChat(id, 1);
			end

		end
	end


end

function _createNewChestServer(id, sets)

	if Player[id].astatus > 5 then
		local cmd, model, key, cid = sscanf(sets, "dss");
		if cmd == 1 then

			if Player[id].chest_create == false then
				if model == 1 then
					Player[id].chest_create_model = "ChestSmall_OCCrateSmallLocked.mds";
					SendPlayerMessage(id, 255, 255, 255, "Model: ChestSmall_OCCrateSmallLocked.mds");

				elseif model == 2 then
					Player[id].chest_create_model = "ChestSmall_OCChestSmallLocked.mds";
					SendPlayerMessage(id, 255, 255, 255, "Model: ChestSmall_OCChestSmallLocked.mds");

				elseif model == 3 then
					Player[id].chest_create_model = "ChestBig_NW_Normal_Locked.mds";
					SendPlayerMessage(id, 255, 255, 255, "Model: ChestBig_NW_Normal_Locked.mds");

				elseif model == 4 then
					Player[id].chest_create_model = "ChestBig_NW_Rich_Locked.mds";
					SendPlayerMessage(id, 255, 255, 255, "Model: ChestBig_NW_Rich_Locked.mds");
				end

				Player[id].chest_create_key = key;
				Player[id].chest_create_id = cid;
				SendPlayerMessage(id, 255, 255, 255, "Key: "..key);
				SendPlayerMessage(id, 255, 255, 255, "ID: "..cid);

				local x, y, z = GetPlayerPos(id);
				Player[id].chest_create_posY = y;
				Player[id].chest_create_vob = Vob.Create(Player[id].chest_create_model, "FULLWORLD2.ZEN", x, y, z);
				Vob.SetCollision(Player[id].chest_create_vob, 0)
				Vob.SetRotation(Player[id].chest_create_vob, 0, 0, 0);
				Player[id].chest_create = true;
				Player[id].chest_create_timer = SetTimerEx(_updateNewChestPos, 400, 1, id);
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/chest (model-id) (key) (chest_id)")
			SendPlayerMessage(id, 255, 255, 255, "Example: /chest (1) (OOLTYB_ITMI_KEY1) (CHEST_1)")
		end
	end

end
--addCommandHandler({"/chest"}, _createNewChestServer);

function _updateNewChestPos(id)
	local x, y, z = GetPlayerPos(id);
	Vob.SetPosition(Player[id].chest_create_vob, x, Player[id].chest_create_posY, z)
end

function _saveChestServer(id)

	local x, y, z = Vob.GetPosition(Player[id].chest_create_vob);
	local r1, r2, r3 = Vob.GetRotation(Player[id].chest_create_vob)
	local file = io.open("Database/Chests/Base/A1.txt", "a+");
	file:write(string.upper(Player[id].chest_create_model).." "..x.." "..y.." "..z.." "..r1.." "..r2.." "..r3.." "..string.upper(Player[id].chest_create_key).." "..Player[id].chest_create_id.."\n");
	file:close();

	local chestid = string.sub(Player[id].chest_create_id, 7, 7); 
	local file = io.open("Database/Chests/Items/"..chestid..".txt", "w+");
	file:close();

	SendPlayerMessage(id, 255, 255, 255, "Chest saved!");

	if Player[id].chest_create_timer ~= nil then
		KillTimer(Player[id].chest_create_timer);
		Player[id].chest_create_timer = nil;
	end

	Player[id].chest_create = false;
	Player[id].chest_create_model = nil;
	Player[id].chest_create_key = nil;
	Player[id].chest_create_id = nil;
	Vob.Destroy(Player[id].chest_create_vob);
	Player[id].chest_create_vob = nil;
	Player[id].chest_create_posY = 0;

end
addCommandHandler({"/chest_save"}, _saveChestServer);

function _chestConnect(id)

	Player[id].chest_create_posY = 0;
	Player[id].chest_create_timer = nil;
	Player[id].chest_create = false;
	Player[id].chest_create_model = nil;
	Player[id].chest_create_key = nil;
	Player[id].chest_create_id = nil;
	Player[id].chest_create_vob = nil;

	-------------------------
	Player[id].chest_id = 0;
	Player[id].chest_select = 0;
	Player[id].chest_return = {0, 0};
	Player[id].chest_amount = {false, 0};
	Player[id].chest_amount_final = "";
	Player[id].chest_amount_pos = {0, 0};
	Player[id].chest_check = false;

	Player[id].chestdraw = {};
	Player[id].chest_pos = {0, 0};
	Player[id].chest_pos_draw = nil;
	Player[id].chest_items = {};
	Player[id].chest_items_ids = 0;

	Player[id].chest_p_draw = {};
	Player[id].chest_p_pos_list = 0;
	Player[id].chest_p_pos = {0, 0}
	Player[id].chest_p_pos_draw = nil;
	Player[id].chest_p_items = {};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_p_count = 0;

end

function _chestDraw(id, cid)

	for i = 1, 2 do
		Player[id].chest_items[i] = {};
	end

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");
	if file then

		local count = 0;
		for line in file:lines() do
			local result, item, amount = sscanf(line,"sd");
			if result == 1 then
				count = count + 1;
				Player[id].chest_items[1][#Player[id].chest_items[1] + 1] = item;
				Player[id].chest_items[2][#Player[id].chest_items[2] + 1] = amount;
			end
		end


		Player[id].chest_select = 1;
		Freeze(id);

		_firstOpenChest(id);
		ShowChat(id, 0);

		if count > 0 then
			Player[id].chest_pos = {1, count};
			Player[id].chest_pos_draw = CreatePlayerDraw(id, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_pos_draw);
		else
			Player[id].chest_pos = {0, 0};
		end

		ShowTexture(id, chest_window_left);
		ShowTexture(id, chest_window_right);

		for i = 1, 2 do
			Player[id].chestdraw[i] = {};
		end

		for i = 1, count do
			Player[id].chestdraw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chestdraw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chestdraw[1][i]);
			ShowPlayerDraw(id, Player[id].chestdraw[2][i]);
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[1]) do
			local str = string.format("%s", GetItemName(v));
			UpdatePlayerDraw(id, Player[id].chestdraw[1][i], 420, pos, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end

		local pos = 2800;
		for i, v in pairs(Player[id].chest_items[2]) do
			UpdatePlayerDraw(id, Player[id].chestdraw[2][i], 2685, pos, v, "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			pos = pos + 250;
		end


	end
end

function _firstOpenChest(id)

	for i = 1, 2 do
		Player[id].chest_p_items[i] = {};
	end

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	if file then

		Player[id].chest_p_count = 0;
		local items = getPlayerItems(id);
		if items then
			for i in pairs(items) do
				Player[id].chest_p_count = Player[id].chest_p_count + 1;
				table.insert(Player[id].chest_p_items[1], items[i].instance)
				table.insert(Player[id].chest_p_items[2], items[i].amount)
			end
		end

		if Player[id].chest_p_count <= 16 then
			Player[id].chest_p_pos = {1, Player[id].chest_p_count};
			Player[id].chest_p_page = 1;
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;
		else
			Player[id].chest_p_pos = {1, 16};
			Player[id].chest_p_page_current = 1;
			Player[id].chest_items_ids = 1;

			if Player[id].chest_p_count > 16 and Player[id].chest_p_count <= 32 then
				Player[id].chest_p_page = 2;

			elseif Player[id].chest_p_count > 32 and Player[id].chest_p_count <= 48 then
				Player[id].chest_p_page = 3;

			elseif Player[id].chest_p_count > 48 and Player[id].chest_p_count <= 64 then
				Player[id].chest_p_page = 4;

			elseif Player[id].chest_p_count > 64 and Player[id].chest_p_count <= 80 then
				Player[id].chest_p_page = 5;

			elseif Player[id].chest_p_count > 80 and Player[id].chest_p_count <= 96 then
				Player[id].chest_p_page = 6;

			elseif Player[id].chest_p_count > 96 and Player[id].chest_p_count <= 112 then
				Player[id].chest_p_page = 7;

			elseif Player[id].chest_p_count > 112 and Player[id].chest_p_count <= 128 then
				Player[id].chest_p_page = 8;

			elseif Player[id].chest_p_count > 128 and Player[id].chest_p_count <= 144 then
				Player[id].chest_p_page = 9;
			end
		end

		
		Player[id].chest_p_pos_draw = CreatePlayerDraw(id, 4950, 2800, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		ShowPlayerDraw(id, Player[id].chest_p_pos_draw);

		for i = 1, 2 do
			Player[id].chest_p_draw[i] = {};
		end


		for i = 1, 16 do
			Player[id].chest_p_draw[1][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			Player[id].chest_p_draw[2][i] = CreatePlayerDraw(id, 0, 0, "", "", 255, 255, 255);
			ShowPlayerDraw(id, Player[id].chest_p_draw[1][i]);
			ShowPlayerDraw(id, Player[id].chest_p_draw[2][i]);
		end

		_updateItemsChest_player(id);

		file:close();
	end
end
----------------------------------------------------------------

function _destroyChestDraw(id)

	local filename = tostring(Player[id].chest_id)..".txt";
	local file = io.open(DIRITEMS..filename, "r");

	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	----------------------------------

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	local count = 0;
	for line in file:lines() do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	----------------------------------

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;
	Player[id].chest_id = 0;
	Player[id].chest_select = 0;

	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;
	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end



	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};


	if Player[id].chest_amount[1] == true then
		HideTexture(id, select_amount_block);
		HidePlayerDraw(id, chest_amount);
		UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		HidePlayerDraw(id, chest_num);
		Player[id].chest_amount_final = "";
		Player[id].chest_amount[1] = false;
		Player[id].chest_amount[2] = 0;
		Player[id].chest_check = false;
	end

	UnFreeze(id);


end

function _destroyAfterDeal(id)

	local count = 0;
	for i, v in pairs(Player[id].chestdraw[1]) do
		count = count + 1;
	end

	for i = 1, count do
		HidePlayerDraw(id, Player[id].chestdraw[1][i]);
		HidePlayerDraw(id, Player[id].chestdraw[2][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[1][i]);
		DestroyPlayerDraw(id, Player[id].chestdraw[2][i]);
	end

	local count = 0;
	for i, v in pairs(Player[id].chest_p_draw[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		HidePlayerDraw(id, Player[id].chest_p_draw[1][i]);
		HidePlayerDraw(id, Player[id].chest_p_draw[2][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[1][i]);
		DestroyPlayerDraw(id, Player[id].chest_p_draw[2][i]);
	end

	HideTexture(id, chest_window_left);
	HideTexture(id, chest_window_right);

	local cid = Player[id].chest_id;

	Player[id].chest_items = {}
	Player[id].chest_p_items = {};
	Player[id].chest_items_ids = 0;

	if Player[id].chest_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_pos_draw);
		Player[id].chest_pos_draw = nil;
	end

	if Player[id].chest_p_pos_draw ~= nil then
		HidePlayerDraw(id, Player[id].chest_p_pos_draw);
		DestroyPlayerDraw(id, Player[id].chest_p_pos_draw);
		Player[id].chest_p_pos_draw = nil;
	end

	Player[id].chest_pos = {0, 0};
	Player[id].chest_p_pos = {0, 0};
	Player[id].chest_return = {0, 0};
	Player[id].chest_p_page = 0;
	Player[id].chest_p_page_current = 0;


	HideTexture(id, select_amount_block);
	HidePlayerDraw(id, chest_amount);
	UpdatePlayerDraw(id, chest_num, 4005, 4040, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255);
	HidePlayerDraw(id, chest_num);
	Player[id].chest_amount_final = "";
	Player[id].chest_amount[1] = false;
	Player[id].chest_amount[2] = 0;
	Player[id].chest_check = false;

	_chestDraw(id);

end

function _selectAmount(id)

	if Player[id].chest_amount[1] == false then
		Player[id].chest_amount[2] = 0;
		Player[id].chest_amount_final = "";
		ShowTexture(id, select_amount_block);
		ShowPlayerDraw(id, chest_amount);
		ShowPlayerDraw(id, chest_num);
		Player[id].chest_amount[1] = true;
		Freeze(id);
	end

end

function _cheskLens(id)

	if string.len(Player[id].chest_amount_final) == 1 then
		Player[id].chest_amount_pos = {4005, 4040};

	elseif string.len(Player[id].chest_amount_final) == 2 then
		Player[id].chest_amount_pos = {3990, 4040};

	elseif string.len(Player[id].chest_amount_final) == 3 then
		Player[id].chest_amount_pos = {3960, 4040};

	elseif string.len(Player[id].chest_amount_final) == 4 then
		Player[id].chest_amount_pos = {3920, 4040};

	elseif string.len(Player[id].chest_amount_final) == 5 then
		Player[id].chest_amount_pos = {3880, 4040};

	elseif string.len(Player[id].chest_amount_final) == 6 then
		Player[id].chest_amount_pos = {3840, 4040};

	elseif string.len(Player[id].chest_amount_final) == 7 then
		Player[id].chest_amount_pos = {3800, 4040};
	end


end

function _selectKey(id, down, up)


	if Player[id].chest_amount[1] == true then

		if down == KEY_1 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."1";
				_cheskLens(id);
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_2 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."2";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_3 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."3";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_4 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."4";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_5 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."5";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_6 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."6";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_7 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."7";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_8 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."8";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_9 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."9";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_0 then
			if Player[id].chest_amount[1] == true then
				Player[id].chest_amount_final = Player[id].chest_amount_final.."0";
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_SPACE then
			if Player[id].chest_amount[1] == true then
				local txt = string.sub(Player[id].chest_amount_final, 1, #Player[id].chest_amount_final-1)
				Player[id].chest_amount_final = txt;
				_cheskLens(id)
				UpdatePlayerDraw(id, chest_num, Player[id].chest_amount_pos[1], 4040, Player[id].chest_amount_final, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
			end
		end

		if down == KEY_RETURN then
			if Player[id].chest_select == 2 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_p_pos[1];
							local item = _checkCurrentItem(id, key) -- Player[id].chest_p_items[1][key];
							if item ~= nil then
								local tItem = 0;
								local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
								for line in file:lines() do
									local result, i, a = sscanf(line, "sd");
									if result == 1 then
										if i == item then
											tItem = a;
										end
									end
								end

								if tItem >= Player[id].chest_amount[2] then
									_putInChest(id, item, Player[id].chest_amount[2]);
								else
									GameTextForPlayer(id, 2710, 1055, "У вас нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
									--SendPlayerMessage(id, 255, 255, 255, "У вас нет столько.")
								end
							end
						end
					end
				end

			elseif Player[id].chest_select == 1 then
				if string.len(Player[id].chest_amount_final) > 0 then
					Player[id].chest_check = true;
					if Player[id].chest_amount[1] == true and Player[id].chest_check == true then
						local number = tonumber(Player[id].chest_amount_final);
						if number > 0 then
							Player[id].chest_amount[2] = number;

							local key = Player[id].chest_pos[1];
							local item = Player[id].chest_items[1][key];

							local tItem = 0;
							local file = io.open("Database/Chests/Items/"..Player[id].chest_id..".txt", "r");
							for line in file:lines() do
								local result, i, a = sscanf(line, "sd");
								if result == 1 then
									if i == item then
										tItem = a;
									end
								end
							end

							if tItem >= Player[id].chest_amount[2] then
								_putInPlayer(id, item, Player[id].chest_amount[2]);
							else
								GameTextForPlayer(id, 2710, 1055, "В сундуке нет такого количества.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
								--SendPlayerMessage(id, 255, 255, 255, "В сундуке столько нет.")
							end
						end
					end
				end
			else
			end
		end

	end

end

function _updateItemsChest_player(id)

	if Player[id].chest_p_page_current == 1 then

		local pos = 2800;
		for i = 1, 16 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][i], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][i], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250;
			end
		end

	elseif Player[id].chest_p_page_current == 2 then

		local pos = 2800;
		local c = 1;
		for i = 17, 32 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 3 then

		local pos = 2800;
		local c = 1;
		for i = 33, 48 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 4 then

		local pos = 2800;
		local c = 1;
		for i = 49, 64 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 5 then

		local pos = 2800;
		local c = 1;
		for i = 65, 80 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end


	elseif Player[id].chest_p_page_current == 6 then

		local pos = 2800;
		local c = 1;
		for i = 81, 96 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 7 then

		local pos = 2800;
		local c = 1;
		for i = 97, 112 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 8 then

		local pos = 2800;
		local c = 1;
		for i = 113, 128 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	elseif Player[id].chest_p_page_current == 9 then

		local pos = 2800;
		local c = 1;
		for i = 129, 144 do
			if Player[id].chest_p_items[1][i] ~= nil then
				UpdatePlayerDraw(id, Player[id].chest_p_draw[1][c], 5000, pos, GetItemName(Player[id].chest_p_items[1][i]), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				UpdatePlayerDraw(id, Player[id].chest_p_draw[2][c], 7270, pos, Player[id].chest_p_items[2][i], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 250; c = c + 1;
			end
		end

	end

end
----------------------------------------

function _chestKey(id, down, up)

	if Player[id].chest_create == true then
		if down == KEY_COMMA then
			local r1, r2, r3 = Vob.GetPosition(Player[id].chest_create_vob);
			Vob.SetPosition(Player[id].chest_create_vob, Player[id].chest_create_posY - 10, r2, r3);
			Player[id].chest_create_posY = Player[id].chest_create_posY - 10;
		end

		if down == KEY_PERIOD then
			local r1, r2, r3 = Vob.GetPosition(Player[id].chest_create_vob);
			Vob.SetPosition(Player[id].chest_create_vob, Player[id].chest_create_posY + 10, r2, r3);
			Player[id].chest_create_posY = Player[id].chest_create_posY + 10;
		end

		if down == KEY_2 then
			local r1, r2, r3 = Vob.GetRotation(Player[id].chest_create_vob);
			Vob.SetRotation(Player[id].chest_create_vob, r1, r2+10, r3);
		end


	end

	if Player[id].chest_id ~= 0 and Player[id].loggedIn == true then

		if Player[id].chest_amount[1] == false then
			---------------------------------------------------
			if down == KEY_DOWN then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] + 1;
					if Player[id].chest_pos[1] > Player[id].chest_pos[2] then
						Player[id].chest_pos[1] = 1;
					end
					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] + 1;
					if Player[id].chest_p_pos[1] > Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current + 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current <= Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 1;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_UP then

				if Player[id].chest_select == 1 then

					Player[id].chest_pos[1] = Player[id].chest_pos[1] - 1;
					if Player[id].chest_pos[1] <= 0 then
						Player[id].chest_pos[1] = Player[id].chest_pos[2];
					end

					_updateChestPos(id);

				elseif Player[id].chest_select == 2 then

					Player[id].chest_p_pos[1] = Player[id].chest_p_pos[1] - 1;
					if Player[id].chest_p_pos[1] < Player[id].chest_p_pos[2] then
						if Player[id].chest_p_page > 1 then
							Player[id].chest_p_page_current = Player[id].chest_p_page_current - 1;
							_resetalldrawsChest(id);
							_updateItemsChest_player(id);
							if Player[id].chest_p_page_current == Player[id].chest_p_page then
								Player[id].chest_p_pos[1] = 16;
							else
								Player[id].chest_p_page_current = 1;
								Player[id].chest_p_pos[1] = 1;
								_resetalldrawsChest(id);
								_updateItemsChest_player(id);
							end
						else
							Player[id].chest_p_pos[1] = 1;
						end
					end
					_updateItemsPos(id);
					_updateItemsChest_player(id);
				end

			end
			---------------------------------------------------
			if down == KEY_RIGHT then

				if Player[id].chest_select == 1 then

					_resetcolorall(id);

					Player[id].chest_select = 2;
					Player[id].chest_pos[1] = 0;
					_updateChestPos(id);

					Player[id].chest_p_pos[1] = 1;
					_updateItemsPos(id);
				end

			end
			---------------------------------------------------
			if down == KEY_LEFT then

				if Player[id].chest_select == 2 then

					_resetcolorall(id);

					Player[id].chest_select = 1;
					Player[id].chest_p_pos[1] = 0;
					_updateItemsPos(id);

					Player[id].chest_pos[1] = 1;
					_updateChestPos(id);
				end
			end
		end

		if down == KEY_ESCAPE then
			ShowChat(id, 1);
			_destroyChestDraw(id);
		end

		---------------------------------------------------

		if down == KEY_RETURN then
			_preaccept(id);
		end
	end

end

function _resetalldrawsChest(id)

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawText(id, Player[id].chest_p_draw[1][i], "");
			SetPlayerDrawText(id, Player[id].chest_p_draw[2][i], "");
		end
	end

end

function _resetcolorall(id)

	local count = 0;
	for i, _ in pairs(Player[id].chest_items[1]) do
		count = count + 1;
	end

	for i = 1, count do
		SetPlayerDrawColor(id, Player[id].chestdraw[1][i], 255, 255, 255);
		SetPlayerDrawColor(id, Player[id].chestdraw[2][i], 255, 255, 255);
	end

	local count = 0;
	for i, _ in pairs(Player[id].chest_p_items[1]) do
		count = count + 1;
	end

	for i = 1, 16 do
		if Player[id].chest_p_draw[1][i] ~= nil then
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][i], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][i], 255, 255, 255);
		end
	end


end

function testoperation(id)

    while IsPlayerConnected(id) == 1 do
        local tempvar1 = LANGUAGE_AFRO[math.random(1, table.getn(LANGUAGE_AFRO))].." "..LANGUAGE_NORDMAR[math.random(1, table.getn(LANGUAGE_NORDMAR))];
        local tempvar2 = CreatePlayerDraw(id, math.random(100, 8000), math.random(100, 8000), tempvar1);
        ShowPlayerDraw(id, tempvar2);
    end

end
addCommandHandler({"/залупа_1"}, testoperation);

function _checkCurrentItem(id, cid)

	if Player[id].chest_p_page_current == 1 then

		local c = 1;
		for i = 1, 16 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 2 then

		local c = 1;
		for i = 17, 32 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 3 then

		local c = 1;
		for i = 33, 48 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 4 then

		local c = 1;
		for i = 49, 64 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 5 then

		local c = 1;
		for i = 65, 80 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 6 then

		local c = 1;
		for i = 81, 96 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 7 then

		local c = 1;
		for i = 97, 112 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 8 then

		local c = 1;
		for i = 113, 128 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	elseif Player[id].chest_p_page_current == 9 then

		local c = 1;
		for i = 129, 144 do
			if c == cid then
				if Player[id].chest_p_items[1][i] ~= nil then
					return Player[id].chest_p_items[1][i];
				end
			else
				c = c + 1;
			end
		end
		return nil;

	end
end

function _checkEmpty(id, cid)

	for i, v in pairs(Player[id].chest_items[1]) do
		if i == cid then
			return false;
		end
	end
	return true;

end

function _checkChestSlots(cid)

	local value = 0;
	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");

	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			value = value + 1;
		end
	end

	if value < 16 then
		return true;
	else
		return false;
	end

end

function _playerHasItem(id, it)

	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	for line in file:lines() do
		local result, i, a = sscanf(line, "sd");
		if result == 1 then
			if i == it then
				return true;
			end
		end
	end
	return false;

end

function _chestHasItem(cid, it)

	local ldir = cid..".txt";
	local file = io.open(DIRITEMS..ldir,"r");
	for line in file:lines() do
		local result, item, amount = sscanf(line, "sd");
		if result == 1 then
			if item == it then
				return true;
			end
		end
	end
	return false;

end

-- положить в сундук
function _putInChest(id, item, amount)

	
	if _checkChestSlots(Player[id].chest_id) == true or _chestHasItem(Player[id].chest_id, item) == true then

		local key = {};
		for i, v in pairs(Player[id].chest_p_items[1]) do
			if v == item then
				key[1] = i;
				key[2] = v;
				break
			end
		end

		local slot_id = key[1];
		local slot_item = key[2];

		if Player[id].chest_p_items[2][slot_id] > 1 and Player[id].chest_p_items[2][slot_id] < 200 then

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." положил в сундук x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x"..amount);
			local str = "Вы положили в сундук "..GetItemName(item).." x"..amount;
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, amount);
			SaveItems(id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + amount;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end


		elseif Player[id].chest_p_items[2][slot_id] == 1 then

			--SendPlayerMessage(id, 255, 255, 255, "Вы положили в сундук "..GetItemName(item).." x1");

			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			LogString("Logs/PlayersAll/chest", Player[id].nickname.." положил в сундук x1".." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);


			local str ="Вы положили в сундук "..GetItemName(item).." x1"
			GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2500);

			RemoveItem(id, item, 1);
			SaveItems(id);

			table.remove(Player[id].chest_p_items[1], slot_id);
			table.remove(Player[id].chest_p_items[2], slot_id);

			if _chestHasItem(Player[id].chest_id, item) == false then

				local ldir = Player[id].chest_id..".txt";
				local file = io.open(DIRITEMS..ldir,"a");
				file:write(item.." "..amount.."\n");
				file:close();

			else

				local slot_id_chest = 0;

				for i, v in pairs(Player[id].chest_items[1]) do
					if v == item then
						slot_id_chest = i;
					end
				end

				local ldir = Player[id].chest_id..".txt";

				local oldValue = Player[id].chest_items[2][slot_id_chest];
				local newValue = oldValue + 1;

				local file = io.open(DIRITEMS..ldir,"r+");
				local tempString = file:read("*a");
				file:close();
				local tempString = string.gsub(tempString, string.upper(item).." "..oldValue,string.upper(item).." "..newValue);
				local file = io.open(DIRITEMS..ldir,"w+");
				file:write(tempString);
				file:close();

			end

		end

		_destroyAfterDeal(id);
	else
		GameTextForPlayer(id, 2710, 1055, "Сундук переполнен.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
		--SendPlayerMessage(id, 255, 255, 255, "В сундуке нет места.")
	end


end

-- забрать из сундука
function _putInPlayer(id, item, amount)

	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	LogString("Logs/PlayersAll/chest", Player[id].nickname.." забрал из сундука x"..amount.." "..GetItemName(item).." / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);

	--SendPlayerMessage(id, 255, 255, 255, "Вы забрали из сундука "..GetItemName(item).." x"..amount);

	local str = "Вы забрали из сундука "..GetItemName(item).." x"..amount;
	GameTextForPlayer(id, 2710, 1055, str, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 2000);
	GiveItem(id, item, amount);
	SaveItems(id);

	local key = {};
	for i, v in pairs(Player[id].chest_items[1]) do
		if v == item then
			key[1] = i;
			key[2] = v;
			break
		end
	end

	local slot_id = key[1];
	local slot_item = key[2];

	if Player[id].chest_items[2][slot_id] > 1 then
		
		local ldir = Player[id].chest_id..".txt";

		local oldValue = Player[id].chest_items[2][slot_id];
		local newValue = oldValue - amount;

		if newValue > 0 then

			local file = io.open(DIRITEMS..ldir,"r+");
			local tempString = file:read("*a");
			file:close();
			local tempString = string.gsub(tempString, string.upper(key[2]).." "..oldValue,string.upper(key[2]).." "..newValue);
			local file = io.open(DIRITEMS..ldir,"w+");
			file:write(tempString);
			file:close();

		else

			table.remove(Player[id].chest_items[1], slot_id);
			table.remove(Player[id].chest_items[2], slot_id);

			local count = 0;
			for i, _ in pairs(Player[id].chest_items[1]) do
				count = count + 1;
			end

			local ldir = Player[id].chest_id..".txt";
			local file = io.open(DIRITEMS..ldir,"w+");

			for i = 1, count do
				file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
			end

			file:close();
		end

	elseif Player[id].chest_items[2][slot_id] == 1 then
		
		table.remove(Player[id].chest_items[1], slot_id);
		table.remove(Player[id].chest_items[2], slot_id);

		local count = 0;
		for i, _ in pairs(Player[id].chest_items[1]) do
			count = count + 1;
		end

		local ldir = Player[id].chest_id..".txt";
		local file = io.open(DIRITEMS..ldir,"w+");

		for i = 1, count do
			file:write(Player[id].chest_items[1][i].." "..Player[id].chest_items[2][i].."\n");
		end

		file:close();

	end

	_destroyAfterDeal(id);

end

function _preaccept(id)
	
	if Player[id].chest_select == 1 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_pos[1];

			if _checkEmpty(id, key) == false then
				SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
				SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
				Player[id].chest_return[2] = key;
				Player[id].chest_return[1] = 1;
			end

		elseif Player[id].chest_return[2] ~= Player[id].chest_pos[1] then

			local key = Player[id].chest_return[2];
			if key ~= nil or key ~= 0 then
				SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 255, 255, 255);
				SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 255, 255, 255);
			end

			local key = Player[id].chest_pos[1];
			local key = Player[id].chest_return[2];
			if key ~= nil or key ~= 0 then
				SetPlayerDrawColor(id, Player[id].chestdraw[1][key], 149, 247, 69);
				SetPlayerDrawColor(id, Player[id].chestdraw[2][key], 149, 247, 69);
				Player[id].chest_return[2] = key;
				Player[id].chest_return[1] = 1;
			end

		elseif Player[id].chest_return[2] == Player[id].chest_pos[1] then
			_selectAmount(id)
		end

	elseif Player[id].chest_select == 2 then

		if Player[id].chest_return[2] == 0 then

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

		elseif Player[id].chest_return[2] ~= Player[id].chest_p_pos[1] then

			local key = Player[id].chest_return[2];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 255, 255, 255);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 255, 255, 255);

			local key = Player[id].chest_p_pos[1];
			SetPlayerDrawColor(id, Player[id].chest_p_draw[1][key], 149, 247, 69);
			SetPlayerDrawColor(id, Player[id].chest_p_draw[2][key], 149, 247, 69);
			Player[id].chest_return[2] = key;
			Player[id].chest_return[1] = 1;

			

		elseif Player[id].chest_return[2] == Player[id].chest_p_pos[1] then
			_selectAmount(id)
		end

	end

end


function _updateChestPos(id)

	if Player[id].chest_pos[1] ~= 0 and Player[id].chest_pos[2] ~= 0 then

		if Player[id].chest_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 330, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end

function _updateItemsPos(id)

	-- 4910, 2800 + 250 Y UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
 
	if Player[id].chest_p_pos[1] ~= 0 and Player[id].chest_p_pos[2] ~= 0 then

		if Player[id].chest_p_pos[1] == 1 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 2800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 2 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 3 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 4 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 5 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 3800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 6 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 7 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 8 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 9 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 4800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 10 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 11 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 12 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 13 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 5800, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 14 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6050, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 15 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6300, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 16 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 4910, 6550, "#", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif Player[id].chest_p_pos[1] == 0 then
			UpdatePlayerDraw(id, Player[id].chest_p_pos_draw, 0, 0, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end
