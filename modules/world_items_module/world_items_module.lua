local world_items_module = {}

local item_spots = {}

-- ���� � ����� � ������ / berry_plants
item_spots[1] = {-24715.560546875, -910.47668457031, 18855.208984375}
item_spots[2] = {-23643.91015625, -1037.1077880859, 17912.158203125}
item_spots[3] = {-22951.796875, -673.68682861328, 19174.197265625}
item_spots[4] = {-22011.4140625, -1081.8541259766, 17802.13671875}
item_spots[5] = {-21826.66015625, -1208.984375, 16565.158203125}
item_spots[6] = {-22961.826171875, -1024.7237548828, 15598.309570313}
item_spots[7] = {-24312.81640625, -824.68658447266, 14545.092773438}

-- ���� � ������� / mana_plants
item_spots[8] = {-10806.837890625, -4268.6782226563, 28331.021484375}
item_spots[9] = {-7956.4975585938, -4258.4174804688, 27590.205078125}
item_spots[10] = {-9105.046875, -3735.8679199219, 26155.708984375}
item_spots[11] = {-11665.805664063, -4048.83203125, 23199.3671875}
item_spots[12] = {-13516.783203125, -3571.8991699219, 26188.3125}
item_spots[13] = {-13107.151367188, -4091.6569824219, 28497.5703125}
item_spots[14] = {-8522.2021484375, -3910.5224609375, 28515.078125}

-- ������� ������ ����� �������� � ������� / cave_plants
item_spots[15] = {-2955.3591308594, -2517.0500488281, 13546.444335938}
item_spots[16] = {-1984.8138427734, -2642.0991210938, 15659.404296875}
item_spots[17] = {-905.94537353516, -2727.1728515625, 16523.26953125}
item_spots[18] = {-404.59341430664, -2841.0151367188, 14577.759765625}
item_spots[19] = {1259.9079589844, -2772.4267578125, 16239.780273438}
item_spots[20] = {3532.1379394531, -2626.9282226563, 16670.607421875}
item_spots[21] = {4862.3530273438, -2840.6281738281, 15564.868164063}
item_spots[22] = {6475.8969726563, -2759.328125, 15601.671875}
item_spots[23] = {5290.9008789063, -2912.8425292969, 14381.484375}
item_spots[24] = {36.117351531982, -2760.8259277344, 12327.205078125}
item_spots[25] = {3209.4560546875, -2560.9982910156, 10966.818359375}
item_spots[26] = {1492.5048828125, -2552.3996582031, 11512.241210938}

-- ������ / swamp_plants
item_spots[27] = {19568.712890625, -5064.2158203125, 3061.9555664063}
item_spots[28] = {23448.26953125, -5064.8354492188, -977.45880126953}
item_spots[29] = {16984.29296875, -4951.7329101563, -8363.94921875}
item_spots[30] = {33439.734375, -5170.9165039063, -1716.6735839844}
item_spots[31] = {36037.19140625, -5114.1977539063, -4977.255859375}
item_spots[32] = {31147.638671875, -4336.8876953125, -8072.50390625}
item_spots[33] = {28043.28515625, -2809.5283203125, -15420.208984375}
item_spots[34] = {23576.0390625, -4462.05078125, -8691.5048828125}
item_spots[35] = {25399.150390625, -5125.5834960938, -5020.9448242188}
item_spots[36] = {21843.58984375, -5061.17578125, 6387.6254882813}
item_spots[37] = {17569.86328125, -4966.3999023438, 8686.9921875}
item_spots[38] = {14499.694335938, -4964.8701171875, 9079.5869140625}
item_spots[39] = {10498.221679688, -5047.5493164063, 12068.203125}
item_spots[40] = {12532.4765625, -5060.0346679688, 14075.947265625}
item_spots[41] = {14144.474609375, -5171.646484375, 4063.9729003906}

-- �������� �������� / ruin_plants
item_spots[42] = {2041.2351074219, -737.10168457031, -7867.6469726563}
item_spots[43] = {2185.8513183594, -675.38488769531, -8937.3046875}
item_spots[44] = {2338.5122070313, -671.36010742188, -10445.034179688}
item_spots[45] = {2179.3566894531, -672.66558837891, -11224.58984375}
item_spots[46] = {3312.1420898438, -917.81030273438, -10650.74609375}
item_spots[47] = {-2527.0708007813, -754.06903076172, -8602.4375}
item_spots[48] = {-2005.2485351563, -686.91125488281, -10249.404296875}
item_spots[49] = {-2752.6079101563, -627.95458984375, -11391.1328125}
item_spots[50] = {-3276.4384765625, -662.17010498047, -8932.802734375}
item_spots[51] = {-4466.0966796875, -908.65075683594, -11258.536132813}
item_spots[52] = {-4822.4501953125, -1020.1500854492, -8525.82421875}
item_spots[53] = {-829.39587402344, -763.61181640625, -13597.21875}
item_spots[54] = {855.33605957031, -747.51776123047, -13096.9296875}
item_spots[55] = {-582.59997558594, -1774.4442138672, -15114.258789063}
item_spots[56] = {4236.376953125, -1317.3784179688, -6683.9233398438}

-- ����������� ������ ���������� / health_plants
item_spots[57] = {-17685.107421875, -2819.7775878906, -11247.293945313}
item_spots[58] = {-19052.65625, -2885.4362792969, -11027.00390625}
item_spots[59] = {-19906.708984375, -2878.6440429688, -12897.076171875}
item_spots[60] = {-19313.822265625, -2509.8828125, -15706.110351563}
item_spots[61] = {-22215.095703125, -3700.8305664063, -12262.142578125}
item_spots[62] = {-22465.0390625, -3358.4462890625, -11513.08984375}
item_spots[63] = {-20050.29296875, -3697.9714355469, -11025.193359375}
item_spots[64] = {-21325.662109375, -4168.7373046875, -9366.4248046875}
item_spots[65] = {-21222.205078125, -3841.5102539063, -8974.125}
item_spots[66] = {-20192.310546875, -3600.5803222656, -7926.9189453125}
item_spots[67] = {-22375.57421875, -3532.6215820313, -6881.5405273438}
item_spots[68] = {-18286.578125, -4364.9091796875, -9565.7431640625}

-- ���� � ������ ��� ������ / lake_plants
item_spots[69] = {-30249.474609375, -4356.521484375, 8492.2236328125}
item_spots[70] = {-27518.212890625, -4088.1086425781, 9032.8701171875}
item_spots[71] = {-30606.84765625, -3929.0244140625, 5386.3305664063}
item_spots[72] = {-27462.58203125, -4357.2221679688, 4970.318359375}
item_spots[73] = {-25878.279296875, -3715.3840332031, 8145.2407226563}
item_spots[74] = {-24135.955078125, -2999.0385742188, 7164.0161132813}
item_spots[75] = {-30224.208984375, -4496.7685546875, 9997.9443359375}

-- ����� / beach_plants
item_spots[76] = {-32164.09765625, -1938.5152587891, 5471.5874023438};
item_spots[77] = {-37810.51171875, -1951.5284423828, 6462.1333007813};
item_spots[78] = {-38467.81640625, -2007.4715576172, 8199.8544921875};
item_spots[79] = {-38273.63671875, -2000.2553710938, 10069.647460938};
item_spots[80] = {-36363.05859375, -1893.8924560547, 11360.393554688};
item_spots[81] = {-37687.62109375, -1903.0167236328, 17499.15234375};
item_spots[82] = {-36208.65625, -1874.6809082031, 21016.568359375};
item_spots[83] = {-35121.70703125, -1899.0402832031, 23491.357421875};
item_spots[84] = {-32751.05078125, -1974.1264648438, 25052.880859375};
item_spots[85] = {-29648.962890625, -1987.5979003906, 27174.720703125};



berry_plants = {"ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITPL_FORESTBERRY", "ZDPWLA_ITFO_WINEBERRYS2", "ZDPWLA_ITFO_WINEBERRYS2", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", "ZDPWLA_ITPL_DEX_HERB_01", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", "OOLTYB_ITMI_SILVERNUGGET"}
mana_plants = {"ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITPL_MANA_HERB_01",  "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_MANA_HERB_02", "ZDPWLA_ITPL_MANA_HERB_02", "ZDPWLA_ITPL_MANA_HERB_03", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_SILVERNUGGET"}
cave_plants = {"ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", "ZDPWLA_ITPL_MUSHROOM_04", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_MAGICORE", "OOLTYB_ITMI_MAGICORE"}
swamp_plants = {"ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITPL_SWAMPHERB", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI1", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITPL_STRENGTH_HERB_01", "OOLTYB_ITMI_REMI2", "ZDPWLA_ITPL_PERM_HERB", "OOLTYB_ITMI_ADDON_WHITEPEARL"}
ruin_plants = {"ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "OOLTYB_ITMI_HONEYCOMB", "OOLTYB_ITMI_HONEYCOMB", "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_MUSHROOM_02", "ZDPWLA_ITPL_DEX_HERB_01", "ZDPWLA_ITPL_STRENGTH_HERB_01", "ZDPWLA_ITFO_WINEBERRYS2", "ZDPWLA_ITFO_WINEBERRYS2", "OOLTYB_ITMI_MAGICORE"}
health_plants = {"ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_HEALTH_HERB_02", "ZDPWLA_ITPL_HEALTH_HERB_02", "ZDPWLA_ITPL_HEALTH_HERB_02", "ZDPWLA_ITPL_HEALTH_HERB_03", "ZDPWLA_ITPL_HEALTH_HERB_03", "OOLTYB_ITMI_SILVERNUGGET", "ZDPWLA_ITPL_MANA_HERB_01", "ZDPWLA_ITPL_MANA_HERB_02"}
lake_plants = {"ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITPL_TEMP_HERB", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", "ZDPWLA_ITPL_HEALTH_HERB_01", "ZDPWLA_ITPL_MANA_HERB_01", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_AQUAMARINE", "ZDPWLA_ITPL_SWAMPHERB", "ZDPWLA_ITFO_CANE", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", "OOLTYB_ITMI_SILVERNUGGET", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "OOLTYB_ITMI_GOLDNUGGET_ADDON"}
beach_plants = {"ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "ZDPWLA_ITFO_FISH", "OOLTYB_ITMI_REMI1", "OOLTYB_ITMI_REMI", "OOLTYB_ITMI_REMI2", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_WOOD", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_FLASK", "OOLTYB_ITMI_COAL", "OOLTYB_ITMI_GOLDNUGGET_ADDON", "ZDPWLA_ITPL_PERM_HERB", "ZDPWLA_ITPL_DEX_HERB_01", "ZDPWLA_ITPL_STRENGTH_HERB_01", "ZDPWLA_ITPL_MUSHROOM_01", "ZDPWLA_ITPL_MUSHROOM_02"}


local empty_item_spots = {}
local itemId_to_placeId = {}



local function spawnPlantBasedOnLocation(index)

    local itemName = nil

    if index >= 1 and index <= 7 then
        itemName = berry_plants[math.random(1, table.getn(berry_plants))]

    elseif index >= 8 and index <= 14 then
        itemName = mana_plants[math.random(1, table.getn(mana_plants))]

    elseif index >= 15 and index <= 26 then
        itemName = cave_plants[math.random(1, table.getn(cave_plants))]

    elseif index >= 27 and index <= 41 then
        itemName = swamp_plants[math.random(1, table.getn(swamp_plants))]

    elseif index >= 42 and index <= 56 then
        itemName = ruin_plants[math.random(1, table.getn(ruin_plants))]

    elseif index >= 57 and index <= 68 then
        itemName = health_plants[math.random(1, table.getn(health_plants))]

    elseif index >= 69 and index <= 75 then
        itemName = lake_plants[math.random(1, table.getn(lake_plants))]

    elseif index >= 76 and index <= 85 then
        itemName = beach_plants[math.random(1, table.getn(beach_plants))]
   
    end
    
    if itemName ~= nil then
        local itemId = CreateItem(itemName, 1, item_spots[index][1], item_spots[index][2], item_spots[index][3], "ADDONWORLD2.ZEN")
        itemId_to_placeId[itemId] = index
    end

end

function RespawnPlants()

	local time = os.date('*t');
	if time.hour >= 18 and time.hour <= 23 then
	    for key, value in pairs(empty_item_spots) do
	        empty_item_spots[key] = nil
	        spawnPlantBasedOnLocation(value)
	    end
	end

end


function world_items_module.OnGamemodeInit()

    for i = 1, table.getn(item_spots) do
        spawnPlantBasedOnLocation(i)
    end

    Plant_Respawn_Timer_Id = SetTimer("RespawnPlants", 5400000, 1);

end


function world_items_module.OnPlayerTakeItem(id, itemID, itemInstance, amount, x, y, z, world)

    if itemID >= 0 and itemId_to_placeId[itemID] ~= nil then
        table.insert(empty_item_spots, itemId_to_placeId[itemID])
        itemId_to_placeId[itemID] = nil
    end

end




return world_items_module


