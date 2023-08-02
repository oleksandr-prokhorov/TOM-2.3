
--  # DR system by royclapton #
--  #      version: 0.5       #


DR_NPC_BASE = {};
DR_NPC_LIMIT = 150;
DR = nil;

for i = 1, DR_NPC_LIMIT do

    DR_NPC_BASE[i] = {};
    DR_NPC_BASE[i].id = nil;
    DR_NPC_BASE[i].bot = nil;
    DR_NPC_BASE[i].visual = {nil, nil, nil, nil};
    DR_NPC_BASE[i].inventory = {"NULL", "NULL", "NULL"} -- melee/range/armor
    DR_NPC_BASE[i].routine = {};
    for k = 1, 50 do
        DR_NPC_BASE[i].routine[k] = {};
        DR_NPC_BASE[i].routine[k]._time = {nil, nil};
        DR_NPC_BASE[i].routine[k]._wp = nil;
        DR_NPC_BASE[i].routine[k]._anim = nil;
    end
    DR_NPC_BASE[i].current_twp = {nil, nil};
    DR_NPC_BASE[i].last_wp = nil;
    DR_NPC_BASE[i].start_wp = nil;
    DR_NPC_BASE[i].overlay = nil;
    DR_NPC_BASE[i].timer = nil;

end

DR_WP_BASE = {};

-- Патрульный (ворота1 - кузница_ремесленный)
DR_WP_BASE[1] = {7494.1040039062, 365.34771728516, -5477.953125, 49};
DR_WP_BASE[2] = {6870.5, 366.13619995117, -4273.6528320312, 59};
DR_WP_BASE[3] = {5830.1938476562, 368.30517578125, -2242.2475585938, 237};
DR_WP_BASE[4] = {7197.734375, 367.95550537109, -3167.5654296875, 245};
DR_WP_BASE[5] = {8169.00390625, 368.30249023438, -5402.7192382812, 261};
DR_WP_BASE[6] = {7952.216796875, 365.60580444336, -4480.3227539062, 39};

-- Два статика возле бани/сада в ремесленном
DR_WP_BASE[7] = {8012.1298828125, 368.30642700195, -4429.2705078125, 218};
DR_WP_BASE[8] = {5714.1494140625, 368.31552124023, -2351.794921875, 58};


-- Патрульный рынок-сад
DR_WP_BASE[9] = {8589.2861328125, 368.41976928711, -3104.11328125, 318};
DR_WP_BASE[10] = {9401.443359375, 364.63452148438, -1894.5344238281, 322};
DR_WP_BASE[11] = {9210.3681640625, 225.30430603027, 91.828643798828, 284};
DR_WP_BASE[12] = {7430.701171875, 224.16970825195, 699.17907714844, 56};
DR_WP_BASE[13] = {7473.9916992188, 224.84541320801, 1622.7520751953, 174};
DR_WP_BASE[14] = {8173.0668945312, 225.2897644043, 1623.9362792969, 226};
DR_WP_BASE[15] = {9408.2412109375, 225.41038513184, 200.59692382812, 289};
DR_WP_BASE[16] = {9267.91796875, 361.63537597656, -2063.2331542969, 333};

-- Патруль казармы
DR_WP_BASE[17] = {2321.2770996094, 845.30267333984, 5890.9453125, 148};
DR_WP_BASE[18] = {3662.0786132812, 847.48980712891, 4071.4523925781, 186};
DR_WP_BASE[19] = {5956.2045898438, 848.20983886719, 4933.1884765625, 150};
DR_WP_BASE[20] = {7716.4135742188, 846.29266357422, 6058.3330078125, 173};
DR_WP_BASE[21] = {7420.7919921875, 845.12225341797, 7819.8676757812, 52};
DR_WP_BASE[22] = {6417.8676757812, 847.28643798828, 9575.2822265625, 53};
DR_WP_BASE[23] = {7420.7919921875, 845.12225341797, 7819.8676757812, 52};
DR_WP_BASE[24] = {7716.4135742188, 846.29266357422, 6058.3330078125, 173};
DR_WP_BASE[25] = {5956.2045898438, 848.20983886719, 4933.1884765625, 150};
DR_WP_BASE[26] = {3662.0786132812, 847.48980712891, 4071.4523925781, 186};

----------------------------

-- Ворота2 стражники
DR_WP_BASE[27] = {10635.383789062, 364.64309692383, 6223.4521484375, 80};
DR_WP_BASE[28] = {10959.349609375, 365.98733520508, 5738.9672851562, 26};

DR_WP_BASE[29] = {10868.159179688, 367.51715087891, 5718.2114257812, 17};
DR_WP_BASE[30] = {10517.374023438, 366.38073730469, 6300.6782226562, 106};

-- Ворота1 стражники
DR_WP_BASE[31] = {7651.3305664062, 367.98309326172, -6585.720703125, 123};
DR_WP_BASE[32] = {8260.630859375, 365.75384521484, -6679.7045898438, 234};

DR_WP_BASE[33] = {8271.173828125, 368.25717163086, -6598.115234375, 210};
DR_WP_BASE[34] = {7769.8505859375, 370.04681396484, -6495.1840820312, 156};

-- Патруль ремесленный-ворота2
DR_WP_BASE[35] = {10127.127929688, 366.60110473633, 5905.4331054688, 209};
DR_WP_BASE[36] = {8772.8984375, 365.84265136719, 4750.1123046875, 330};
DR_WP_BASE[37] = {7752.50390625, 367.56503295898, 4842.1333007812, 156};
DR_WP_BASE[38] = {5793.8266601562, 397.16470336914, 3072.1381835938, 66};
DR_WP_BASE[39] = {5452.5327148438, 400.11669921875, 3805.1396484375, 105};
DR_WP_BASE[40] = {7437.859375, 377.77648925781, 4961.8330078125, 158};
DR_WP_BASE[41] = {8620.2919921875, 365.6178894043, 4588.6357421875, 337};
DR_WP_BASE[42] = {7437.859375, 377.77648925781, 4961.8330078125, 158};
DR_WP_BASE[43] = {5452.5327148438, 400.11669921875, 3805.1396484375, 105};
DR_WP_BASE[44] = {5793.8266601562, 397.16470336914, 3072.1381835938, 66};
DR_WP_BASE[45] = {7752.50390625, 367.56503295898, 4842.1333007812, 156};
DR_WP_BASE[46] = {8772.8984375, 365.84265136719, 4750.1123046875, 330};

-- Стражник ворота в верхний
DR_WP_BASE[47] = {9137.82421875, 684.83056640625, -4448.7963867188, 231};
DR_WP_BASE[48] = {9225.12109375, 685.75494384766, -5004.0942382812, 296};

--[[-- Патруль верхний вокруг фонтана
DR_WP_BASE[40] = {13013.309570312, 996.58062744141, -3782.4357910156, 321};
DR_WP_BASE[41] = {12025.463867188, 996.46563720703, -3741.4497070312, 324};
DR_WP_BASE[42] = {11301.26953125, 995.91180419922, -2737.7797851562, 121};
DR_WP_BASE[43] = {12324.719726562, 994.76025390625, -1883.5699462891, 172};
DR_WP_BASE[44] = {13453.407226562, 995.54498291016, -2729.384765625, 256};

-- Патруль верхний ходит через арку
DR_WP_BASE[45] = {11305.06640625, 996.42889404297, 782.68188476562, 107};
DR_WP_BASE[46] = {10849.834960938, 995.11553955078, -558.09460449219, 74};
DR_WP_BASE[47] = {12591.243164062, 995.67205810547, -2531.9892578125, 6};

-- Патруль ворота в порт - площадь порт
DR_WP_BASE[48] = {3554.1127929688, 287.1608581543, -2254.6918945312, 250};
DR_WP_BASE[49] = {2109.1345214844, -41.180351257324, -998.58227539062, 230};
DR_WP_BASE[50] = {1465.3106689453, -80.063789367676, -1482.4193115234, 25};
DR_WP_BASE[51] = {1352.1861572266, -94.806449890137, -887.25207519531, 202};
DR_WP_BASE[52] = {-757.17120361328, -89.188957214355, -1046.4429931641, 197};
DR_WP_BASE[53] = {2635.1857910156, 268.58636474609, -1403.35546875, 8};
DR_WP_BASE[54] = {3793.5109863281, 285.12249755859, -1679.3811035156, 260};]]

function _setRandomGuardAnim()

    if math.random(1, 2) == 1 then
        return "S_HGUARD";
    else
        return "S_LGUARD";
    end

end

function _dailyRoutineInit()


    print(" ");
    print("=====================")
    print(" Daily Routine init")

    --#######################################################################################################
    print("----------------------")

    -- Ремесленный вдоль бани и ворот1.
    _createDRNPC(1, "Патрульный", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 115, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l", 1, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    local prevAnim = "S_HGUARD"; local _wp = 2;

    for i = 1, 23 do
        _setBotRoutine(1, i, i, 0, _wp, prevAnim);
        
 
        if prevAnim == "S_HGUARD" then
            prevAnim = "S_LGUARD";
        else
            prevAnim = "S_HGUARD";
        end
        _wp = _wp + 1;
        if _wp == 7 then
            _wp = 1;
        end
    end

    --#######################################################################################################
    print("----------------------")

    -- Ремесленный, вдоль бани до ворот1

    _createDRNPC(2, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 116, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l4", 7, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    _setBotRoutine(2, 1, 17, 0, 8, "S_RUN");
    _setBotRoutine(2, 2, 23, 0, 7, "S_RUN");

    _createDRNPC(3, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 117, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l4", 8, "HUMANS_G1MILITIA.mds", "S_LGUARD")
    _setBotRoutine(3, 1, 16, 58, 7, "S_RUN");
    _setBotRoutine(3, 2, 23, 0, 8, "S_RUN");

    print("----------------------")
    --#######################################################################################################

    -- Рынок-сад

    _createDRNPC(4, "Патрульный", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 118, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l6", 13, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    prevAnim = "S_HGUARD"; _wp = 10;

    for i = 1, 23 do
         _setBotRoutine(4, i, i, 0, _wp, prevAnim);
        
        if prevAnim == "S_HGUARD" then
            prevAnim = "S_LGUARD";
        else
            prevAnim = "S_HGUARD";
        end
        _wp = _wp + 1;
        if _wp == 17 then
            _wp = 9;
        end
    end




    print("----------------------")
    --#######################################################################################################

    -- Казармы

    _createDRNPC(5, "Патрульный", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 119, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l2", 17, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    _setBotRoutine(5, 1, 13, 0, 18, _setRandomGuardAnim());
    _setBotRoutine(5, 2, 15, 0, 19, _setRandomGuardAnim());
    _setBotRoutine(5, 3, 17, 0, 20, _setRandomGuardAnim());
    _setBotRoutine(5, 4, 18, 0, 21, _setRandomGuardAnim());
    _setBotRoutine(5, 5, 19, 0, 22, _setRandomGuardAnim());
    _setBotRoutine(5, 6, 21, 0, 23, _setRandomGuardAnim());
    _setBotRoutine(5, 7, 22, 0, 24, _setRandomGuardAnim());
    _setBotRoutine(5, 8, 0, 0, 25, _setRandomGuardAnim());
    _setBotRoutine(5, 9, 1, 0, 26, _setRandomGuardAnim());

    _setBotRoutine(5, 10, 2, 0, 25, _setRandomGuardAnim());
    _setBotRoutine(5, 11, 4, 0, 24, _setRandomGuardAnim());
    _setBotRoutine(5, 12, 5, 0, 23, _setRandomGuardAnim());
    _setBotRoutine(5, 13, 6, 0, 22, _setRandomGuardAnim());
    _setBotRoutine(5, 14, 7, 0, 21, _setRandomGuardAnim());
    _setBotRoutine(5, 15, 8, 0, 20, _setRandomGuardAnim());
    _setBotRoutine(5, 16, 10, 0, 19, _setRandomGuardAnim());
    _setBotRoutine(5, 17, 11, 0, 18, _setRandomGuardAnim());
    _setBotRoutine(5, 18, 12, 0, 17, _setRandomGuardAnim());


    print("----------------------")
    --#######################################################################################################

    -- Ворота2 стражники

    _createDRNPC(6, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 120, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l2", 27, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    _createDRNPC(7, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 121, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l7", 29, "HUMANS_G1MILITIA.mds", "S_LGUARD")

    local _wp5 = 28; local _wp6 = 30;
    for i = 1, 23 do

        _setBotRoutine(6, i, i, 0, _wp5, "S_HGUARD");
        _setBotRoutine(7, i, i, 0, _wp6, "S_LGUARD");
        
    
        _wp5 = _wp5 + 1;
        _wp6 = _wp6 + 1;

        if _wp5 == 29 then
            _wp5 = 27;
        end

        if _wp6 == 31 then
            _wp6 = 29;
        end

    end


    print("----------------------")
    --#######################################################################################################

    -- Ворота1 стражники

    _createDRNPC(8, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 122, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l2", 31, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    _createDRNPC(9, "Постовой", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 123, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l7", 33, "HUMANS_G1MILITIA.mds", "S_LGUARD")

    local _wp5 = 32; local _wp6 = 34;
    for i = 1, 23 do

        _setBotRoutine(8, i, i, 0, _wp5, "S_HGUARD");
        _setBotRoutine(9, i, i, 0, _wp6, "S_LGUARD");

        _wp5 = _wp5 + 1;
        _wp6 = _wp6 + 1;

        if _wp5 == 33 then
            _wp5 = 31;
        end

        if _wp6 == 35 then
            _wp6 = 33;
        end

    end




    print("----------------------")
    --#######################################################################################################

    -- Ремесленный мимо казарм

    _createDRNPC(10, "Патрульный", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 124, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l", 41, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    prevAnim = "S_HGUARD"; _wp = 36;
    for i = 1, 24, 2 do

        _setBotRoutine(10, i, i, 0, _wp, prevAnim);
        if prevAnim == "S_HGUARD" then
            prevAnim = "S_LGUARD";
        else
            prevAnim = "S_HGUARD";
        end
        _wp = _wp + 1;
        if _wp == 47 then
            _wp = 35;
        end
    end


    print("----------------------")
    --#######################################################################################################

    -- Ворота в верхний квартал

    _createDRNPC(11, "Патрульный", "Hum_Body_Naked0", 38, "Hum_Head_Bald", 125, "NULL", "jkztzd_itmw_1h_common_01", "itar_mil_a_l7", 47, "HUMANS_G1MILITIA.mds", "S_HGUARD")
    prevAnim = "S_HGUARD"; _wp = 48;
    for i = 1, 24, 2 do
        _setBotRoutine(11, i, i, 0, _wp, prevAnim);
        if prevAnim == "S_HGUARD" then
            prevAnim = "S_LGUARD";
        else
            prevAnim = "S_HGUARD";
        end
        _wp = _wp + 1;
        if _wp == 49 then
            _wp = 47;
        end
    end

    print("----------------------")
    --#######################################################################################################



    print("----------------------")
    --#######################################################################################################



    print("----------------------")
    --#######################################################################################################


    DR = SetTimer(_DR, 500, 1);

    SetTimer(_DR_DEBUG, 30000, 1);

    print("=====================")
    print(" ");


end

function _DR()

    for i = 1, table.getn(DR_NPC_BASE) do
        if DR_NPC_BASE[i].bot ~= nil then

            local gH, gM = GetTime();

            local armor = GetEquippedArmor(DR_NPC_BASE[i].bot);
            armor = string.lower(armor);
            if string.find(armor, "mil") then
                if gH > 21  then
                    --SetPlayerHand(DR_NPC_BASE[i].bot, 2, "NULL");
                    --SetPlayerHand(DR_NPC_BASE[i].bot, 2, "ITLSTORCHBURNING");

                elseif gH > 7 then
                    --SetPlayerHand(DR_NPC_BASE[i].bot, 2, "NULL");
                end
            end


            for k = 1, 150 do
                if DR_NPC_BASE[i].routine[k] ~= nil then
                    if DR_NPC_BASE[i].last_wp ~= DR_NPC_BASE[i].routine[k]._wp then
                        if DR_NPC_BASE[i].routine[k]._time[1] == gH and DR_NPC_BASE[i].routine[k]._time[2] == gM then
                            if DR_NPC_BASE[i].timer == nil then

                                local wp = DR_NPC_BASE[i].routine[k]._wp;
                                local _npcID = DR_NPC_BASE[i].id;

                                DR_NPC_BASE[i].current_twp = {wp, DR_NPC_BASE[i].routine[k]._anim};
                                DR_NPC_BASE[i].timer = SetTimerEx(_DR_NPC, 300, 1, _npcID);

                            end
                        end
                    end
                end
            end

        end
    end


end

function _DR_NPC(_npcID)

    if _npcID ~= nil then
        local _b = nil;
        for i = 1, table.getn(DR_NPC_BASE) do
            if DR_NPC_BASE[i].id == _npcID then
                _b = i;
                break
            end
        end

        local x, y, z = GetPlayerPos(DR_NPC_BASE[_b].bot);
        local wp = DR_NPC_BASE[_b].current_twp[1];
        local nAngle = GetAngleToPos(x, z, DR_WP_BASE[wp][1], DR_WP_BASE[wp][3]);

        SetPlayerAngle(DR_NPC_BASE[_b].bot, nAngle);
        PlayAnimation(DR_NPC_BASE[_b].bot, "S_WALKL")

        if GetPlayerAngle(DR_NPC_BASE[_b].bot) ~= nAngle then
            SetPlayerAngle(DR_NPC_BASE[_b].bot, nAngle);
        end

        if GetDistance3D(x, y, z, DR_WP_BASE[wp][1], DR_WP_BASE[wp][2], DR_WP_BASE[wp][3]) <= 80 then    
            SetPlayerAngle(DR_NPC_BASE[_b].bot, DR_WP_BASE[wp][4]);
            DR_NPC_BASE[_b].last_wp = wp;
            KillTimer(DR_NPC_BASE[_b].timer);
            DR_NPC_BASE[_b].timer = nil;

            PlayAnimation(DR_NPC_BASE[_b].bot, "S_RUN");

            local gH, gM = GetTime();
            if gH > 21  then
                PlayAnimation(DR_NPC_BASE[_b].bot, "S_RUN");

            elseif gH > 7 then
                PlayAnimation(DR_NPC_BASE[_b].bot, DR_NPC_BASE[_b].current_twp[2]);
            end

            DR_NPC_BASE[_b].current_twp = {nil, nil};

        end
    end

end

function _DR_DEBUG()

   --[[ for i = 1, table.getn(DR_NPC_BASE) do
        if DR_NPC_BASE[i].bot ~= nil then
            local x, y, z = GetPlayerPos(DR_NPC_BASE[i].bot);
            local wp = DR_NPC_BASE[i].last_wp;
            local twp = DR_NPC_BASE[i].current_twp[1];

            if twp ~= nil then
                if GetDistance3D(x, y, z, DR_WP_BASE[twp][1], DR_WP_BASE[twp][2], DR_WP_BASE[twp][3]) > 200 then
                    PlayAnimation(DR_NPC_BASE[i].bot, "S_RUN");
                    SetPlayerPos(DR_NPC_BASE[i].bot, DR_WP_BASE[twp][1], DR_WP_BASE[twp][2], DR_WP_BASE[twp][3]);
                    SetPlayerAngle(DR_NPC_BASE[i].bot, DR_WP_BASE[twp][4])
                    
                    if DR_NPC_BASE[i].timer ~= nil then
                        KillTimer(DR_NPC_BASE[i].timer);
                        DR_NPC_BASE[i].timer = nil;
                    end
                end
            else
                if GetDistance3D(x, y, z, DR_WP_BASE[wp][1], DR_WP_BASE[wp][2], DR_WP_BASE[wp][3]) > 200 then
                    PlayAnimation(DR_NPC_BASE[i].bot, "S_RUN");
                    SetPlayerPos(DR_NPC_BASE[i].bot, DR_WP_BASE[wp][1], DR_WP_BASE[wp][2], DR_WP_BASE[wp][3]);
                    SetPlayerAngle(DR_NPC_BASE[i].bot, DR_WP_BASE[wp][4])

                    if DR_NPC_BASE[i].timer ~= nil then
                        KillTimer(DR_NPC_BASE[i].timer);
                        DR_NPC_BASE[i].timer = nil;
                    end
                end
            end
        end
    end]]


            
end

function _createDRNPC(_b, _bName, _bV1, _bV2, _bV3, _bV4, _bI1, _bI2, _bI3, _bStart, _bOverlay, _bAnim)

    if DR_NPC_BASE[_b].bot == nil then

        DR_NPC_BASE[_b].bot = CreateNPC(_bName);

        SpawnPlayer(DR_NPC_BASE[_b].bot);
        SetPlayerWorld(DR_NPC_BASE[_b].bot, "FULLWORLD2.ZEN");
        SetPlayerAdditionalVisual(DR_NPC_BASE[_b].bot, _bV1, _bV2, _bV3, _bV4);
        EquipMeleeWeapon(DR_NPC_BASE[_b].bot, _bI1);
        EquipRangedWeapon(DR_NPC_BASE[_b].bot, _bI2);
        EquipArmor(DR_NPC_BASE[_b].bot, _bI3);
        SetPlayerWalk(DR_NPC_BASE[_b].bot, _bOverlay);
        SetPlayerAngle(DR_NPC_BASE[_b].bot, DR_WP_BASE[_bStart][4])

        SetPlayerMaxHealth(DR_NPC_BASE[_b].bot, 100000);
        SetPlayerHealth(DR_NPC_BASE[_b].bot, 100000);

        local x, y, z = DR_WP_BASE[_bStart][1], DR_WP_BASE[_bStart][2], DR_WP_BASE[_bStart][3];
        SetPlayerPos(DR_NPC_BASE[_b].bot, x, y, z)

        if _bAnim then
            PlayAnimation(DR_NPC_BASE[_b].bot, _bAnim);
        end

        DR_NPC_BASE[_b].id = DR_NPC_BASE[_b].bot;
        DR_NPC_BASE[_b].visual = {_bV1, _bV2, _bV3, _bV4};
        DR_NPC_BASE[_b].inventory = {_bI1, _bI2, _bI3};
        DR_NPC_BASE[_b].last_wp = _bStart;
        DR_NPC_BASE[_b].start_wp = _bStart;
        DR_NPC_BASE[_b].overlay = _bOverlay;
        DR_NPC_BASE[_b].current_twp = {nil, nil};

        print(_bName.." (s".._b..") - load.")
    end

end

function _setBotRoutine(_b, _aP, _t1, _t2, _wp, _anim)

    DR_NPC_BASE[_b].routine[_aP]._wp = _wp;
    DR_NPC_BASE[_b].routine[_aP]._time = {_t1, _t2};
    DR_NPC_BASE[_b].routine[_aP]._anim = _anim;
    print("# Added routine (".._aP.."): WP-".._wp.." / Time: ".._t1.."-".._t2.." / Anim: ".._anim)

end

function _DR_XYZ(id)

    local x, y, z = GetPlayerPos(id);
    local angle = GetPlayerAngle(id);
    local file = io.open("XYZ.txt", "a+");

    file:write("DR_WP_BASE[] = {"..x..", "..y..", "..z..", "..angle.."};\n");
    file:close();
    SendPlayerMessage(id, 255, 255, 255, x..", "..y..", "..z..", "..angle)


end
--addCommandHandler({"/кд"}, _DR_XYZ)

function _hitDR(id, kid)

   --[[ if IsNPC(id) == 1 then
        if IsNPC(kid) == 0 then
            if Player[kid].loggedIn == true then

                for i = 1, table.getn(DR_NPC_BASE) do
                    if DR_NPC_BASE[i].id == id then
                        SetPlayerHealth(kid, 1);
                        PlayAnimation(kid, "T_FALLDOWN_LONG");

                        SetPlayerMaxHealth(id, 100000);
                        SetPlayerHealth(id, 100000);
                        break
                    end
                end
            end
        end
    end]]
end