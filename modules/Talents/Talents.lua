
--  #   Talents system by royclapton  #
--  #           version: 1.0          #


TALENTS_BACKGROUND_TEX = CreateTexture(3069, 7563, 4843, 8077, 'menu_ingame')

TALENTS_BOXES_Y1 = 7605; TALENTS_BOXES_Y2 = 8025;

TALENTS_BOXES_TEX = {};
for i = 1, 6 do
    TALENTS_BOXES_TEX[i] = CreateTexture((2790 + i * 285) + 50, TALENTS_BOXES_Y1, 3070 + i * 285, TALENTS_BOXES_Y2, 'menu_ingame');
end


TALENTS_SKILLS_Y1 = 7630; TALENTS_SKILLS_Y2 = 8015;
for i = 0, GetMaxPlayers() do
    Player[i]._s_textures = {};
    Player[i]._s_textures[1] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_textures[2] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_textures[3] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_textures[4] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_textures[5] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_textures[6] = CreateTexture(0, 0, 0, 0, '');
end


for i = 0, GetMaxPlayers() do
    Player[i]._s_cd = {};
    Player[i]._s_cd[1] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_cd[2] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_cd[3] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_cd[4] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_cd[5] = CreateTexture(0, 0, 0, 0, '');
    Player[i]._s_cd[6] = CreateTexture(0, 0, 0, 0, '');
end

function _talentsConnect(id)

    

    Player[id]._s_show = false;
    Player[id]._s_menu = false;

    Player[id]._s_menu_draws = {};
    for i = 1, 20 do
        Player[id]._s_menu_draws[i] = CreatePlayerDraw(id, 0, 0, "");
    end

    UpdatePlayerDraw(id, Player[id]._s_menu_draws[1], 2410, 2670, "Сильный удар (доп. урон при атаке клинком)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    UpdatePlayerDraw(id, Player[id]._s_menu_draws[2], 2410, 3200, "Контратака (отразить долю урона во врага)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    UpdatePlayerDraw(id, Player[id]._s_menu_draws[3], 2410, 3700, "Мощный кулак (доп. урон при атаке кулаком)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    UpdatePlayerDraw(id, Player[id]._s_menu_draws[4], 2410, 4200, "Быстрый рывок (короткое увеличение скорости бега), активация - Z", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    UpdatePlayerDraw(id, Player[id]._s_menu_draws[5], 2410, 4700, "Регенерация жизни (восстановление ХП раз в минуту)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    UpdatePlayerDraw(id, Player[id]._s_menu_draws[6], 2410, 5200, "Регенерация маны (восстановление МП раз в минуту)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    

    Player[id]._s_sprint = 0;
    Player[id]._s_fist = 0;
    Player[id]._s_crit = 0;
    Player[id]._s_defense = 0;
    Player[id]._s_regHP = 0;
    Player[id]._s_regMP = 0;

    -- Таймера спринта
    Player[id]._s_UseSprint = false;
    Player[id]._s_UseSprintTimer = nil;
    Player[id]._s_UseSprintTimer_CD = nil;

    -- Таймера хитов
    Player[id]._s_DefenseTimer = nil;
    Player[id]._s_FistTimer = nil;
    Player[id]._s_CritTimer = nil;

    Player[id]._s_skillsTex = {};

end

function _talentsUpdateMySkills(id)

    Player[id]._s_skillsTex = {};

    if Player[id]._s_sprint ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_sprint");
    end

    if Player[id]._s_fist ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_fist");
    end

    if Player[id]._s_crit ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_crit");
    end

    if Player[id]._s_defense ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_defense");
    end

    if Player[id]._s_regHP ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_regHP");
    end

    if Player[id]._s_regMP ~= 0 then
        table.insert(Player[id]._s_skillsTex, "s_regMP");
    end

end

function _talentsShowMySkills(id)

    if Player[id].loggedIn == true then
        if Player[id]._s_show == false then

            Player[id]._s_show = true;
            _talentsUpdateMySkills(id);

            if table.getn(Player[id]._s_skillsTex) > 0 then
                ShowTexture(id, TALENTS_BACKGROUND_TEX);

                for i = 1, table.getn(Player[id]._s_skillsTex) do
                    ShowTexture(id, TALENTS_BOXES_TEX[i]);
                    ShowTexture(id, Player[id]._s_textures[i]);
                    UpdateTexture(Player[id]._s_textures[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, Player[id]._s_skillsTex[i]);
                end

                for i = 1, 6 do
                    ShowTexture(id, Player[id]._s_cd[i]);
                end
                
            end

        else

            Player[id]._s_show = false;

            if table.getn(Player[id]._s_skillsTex) > 0 then

                HideTexture(id, TALENTS_BACKGROUND_TEX);
                for i = 1, table.getn(Player[id]._s_skillsTex) do
                    HideTexture(id, TALENTS_BOXES_TEX[i]);
                    HideTexture(id, Player[id]._s_textures[i]);
                    UpdateTexture(Player[id]._s_textures[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, '');
                end

                for i = 1, 6 do
                    HideTexture(id, Player[id]._s_cd[i]);
                end

            end

        end
    end
end

-- REGENERATION
-- #################################################################### -- ####################################################################
-- #################################################################### -- ####################################################################

function _talentsRegeneration()

    for i = 0, GetMaxPlayers() do
        if Player[i].loggedIn == true then
            if GetPlayerInstance(i) == "PC_HERO" then
                if GetPlayerHealth(i) < GetPlayerMaxHealth(i) then

                    if Player[i]._s_regHP > 0 then

                        local frm = Player[i]._s_regHP * 3;
                        SetPlayerHealth(i, GetPlayerHealth(i) + frm);

                    end
                end

                if GetPlayerMana(i) < GetPlayerMaxMana(i) then

                    if Player[i]._s_regMP > 0 then

                        local frm = Player[i]._s_regMP * 2;
                        SetPlayerMana(i, GetPlayerMana(i) + frm);

                    end
                end

            end
        end

        if GetPlayerHealth(i) > GetPlayerMaxHealth(i) then
            SetPlayerHealth(i, GetPlayerMaxHealth(i));
        end

        if GetPlayerMana(i) > GetPlayerMaxMana(i) then
            SetPlayerMana(i, GetPlayerMaxMana(i));
        end
    end


end
SetTimer(_talentsRegeneration, 60000, 1);

-- SPRINT
-- #################################################################### -- ####################################################################
-- #################################################################### -- ####################################################################

function _talentsUseSprint(id)

    if Player[id].loggedIn == true then
        if Player[id]._s_UseSprint == false then
            if Player[id]._s_UseSprintTimer_CD == nil then
                if Player[id]._s_sprint > 0 then

                    if Player[id]._s_show == false then
                        _talentsShowMySkills(id);
                    end

                    Player[id]._s_UseSprint = true;

                    local time = Player[id]._s_sprint * 2000;
                    SetPlayerWalk(id, "HUMANS_SPRINT.MDS");

                    Player[id]._s_UseSprintTimer = SetTimerEx(_talentsSprintEnd, time, 0, id);

                    for i, v in pairs(Player[id]._s_skillsTex) do
                        if v == "s_sprint" then
                            UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, 's_cd');
                            break
                        end
                    end

                    LogString("Logs/newSkills/use", Player[id].nickname.." использовал спринт ("..time..") / ".._getRTime());

                end                      
            end
        end
    end

end

function _talentsSprintEnd(id)
    Player[id]._s_UseSprint = false;
    Player[id]._s_UseSprintTimer_CD = SetTimerEx(_talentsCD_Sprint, 60000, 0, id);
    RemovePlayerOverlay(id, GetPlayerWalk(id));
    SetPlayerWalk(id, Player[id].overlay);
end

function _talentsCD_Sprint(id)
    Player[id]._s_UseSprintTimer_CD = nil;

    if Player[id]._s_show == false then
        _talentsShowMySkills(id);
    end

    for i, v in pairs(Player[id]._s_skillsTex) do
        if v == "s_sprint" then
            UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, '');
            break
        end
    end

end


-- HITS
-- #################################################################### -- ####################################################################
-- #################################################################### -- ####################################################################


function _talentsHit(id, kid)

    -- defense
    if IsNPC(id) == 0 then
        if Player[id].loggedIn == true and GetPlayerInstance(id) == "PC_HERO" then
            if Player[id]._s_defense > 0 then
                if Player[id]._s_DefenseTimer == nil then
                    if GetPlayerHealth(id) > 100 then

                        local defense = Player[id]._s_defense * 5;
                        
                        if GetPlayerHealth(kid) > defense then

                            if Player[id]._s_show == false then
                                _talentsShowMySkills(id);
                            end

                            SetPlayerHealth(kid, GetPlayerHealth(kid) - defense);
                            GameTextForPlayer(id, math.random(3000, 6000), math.random(3000, 6000), "+"..defense.." КОНТРАТАКА", "Font_Old_10_White_Hi.TGA", 129, 255, 110, 1500);
                            GameTextForPlayer(kid, math.random(3000, 6000), math.random(3000, 6000), "-"..defense.." КОНТРАТАКА", "Font_Old_10_White_Hi.TGA", 250, 75, 75, 1500);
                            Player[id]._s_DefenseTimer = SetTimerEx(_talentsCD_Defense, 15000, 0, id);
                            
                            for i, v in pairs(Player[id]._s_skillsTex) do
                                if v == "s_defense" then
                                    UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, 's_cd');
                                    break
                                end
                            end

                            LogString("Logs/newSkills/use", Player[id].nickname.." отразил урон ("..defense..") по "..GetPlayerName(kid).." / ".._getRTime());

                        end

                    end
                end
            end
        end
    end

    -- fist
    if IsNPC(kid) == 0 then
        if Player[kid].loggedIn == true and GetPlayerInstance(kid) == "PC_HERO" then
            if Player[kid]._s_fist > 0 then
                if Player[kid]._s_FistTimer == nil then
                    if Player[kid]._weaponMode == 1 then
                        if GetPlayerHealth(id) >= 25 then

                            if Player[id]._s_show == false then
                                _talentsShowMySkills(id);
                            end

                            local fist = Player[kid]._s_fist * 3;
                            SetPlayerHealth(id, GetPlayerHealth(id) - fist);
                            GameTextForPlayer(kid, math.random(3000, 6000), math.random(3000, 6000), "+"..fist.." УРОН", "Font_Old_10_White_Hi.TGA", 250, 75, 75, 1500);
                            Player[kid]._s_FistTimer = SetTimerEx(_talentsCD_Fist, 8000, 0, kid);

                            LogString("Logs/newSkills/use", Player[kid].nickname.." доп. урон кулаком ("..fist..") по "..GetPlayerName(id).." / ".._getRTime());

                            
                            for i, v in pairs(Player[kid]._s_skillsTex) do
                                if v == "s_fist" then
                                    UpdateTexture(Player[kid]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, 's_cd');
                                    break
                                end
                            end

                        end
                    end
                end
            end
        end
    end

    -- crit
    if IsNPC(kid) == 0 then
        if Player[kid].loggedIn == true and GetPlayerInstance(kid) == "PC_HERO" then
            if Player[kid]._s_fist > 0 then
                if Player[kid]._s_CritTimer == nil then
                    if Player[kid]._weaponMode == 3 or Player[kid]._weaponMode == 4 then
                        if GetPlayerHealth(id) >= 125 then

                            if Player[id]._s_show == false then
                                _talentsShowMySkills(id);
                            end

                            local crit = Player[kid]._s_crit * 5;
                            SetPlayerHealth(id, GetPlayerHealth(id) - crit);
                            GameTextForPlayer(kid, math.random(3000, 6000), math.random(3000, 6000), "+"..crit.." УРОН", "Font_Old_10_White_Hi.TGA", 250, 75, 75, 1500);
                            Player[kid]._s_CritTimer = SetTimerEx(_talentsCD_Crit, 12000, 0, kid);

                            LogString("Logs/newSkills/use", Player[kid].nickname.." доп. урон мечом ("..crit..") по "..GetPlayerName(id).." / ".._getRTime());

                            for i, v in pairs(Player[kid]._s_skillsTex) do
                                if v == "s_crit" then
                                    UpdateTexture(Player[kid]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, 's_cd');
                                    break
                                end
                            end

                        end
                    end
                end
            end
        end
    end


end

function _talentsCD_Defense(id)
    Player[id]._s_DefenseTimer = nil;

    if Player[id]._s_show == false then
        _talentsShowMySkills(id);
    end
    
    for i, v in pairs(Player[id]._s_skillsTex) do
        if v == "s_defense" then
            UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, '');
            break
        end
    end

end

function _talentsCD_Fist(id)
    Player[id]._s_FistTimer = nil;

    if Player[id]._s_show == false then
        _talentsShowMySkills(id);
    end

    for i, v in pairs(Player[id]._s_skillsTex) do
        if v == "s_fist" then
            UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, '');
            break
        end
    end
    
end

function _talentsCD_Crit(id)
    Player[id]._s_CritTimer = nil;

    if Player[id]._s_show == false then
        _talentsShowMySkills(id);
    end

    for i, v in pairs(Player[id]._s_skillsTex) do
        if v == "s_crit" then
            UpdateTexture(Player[id]._s_cd[i], (2800 + i * 285) + 45, TALENTS_SKILLS_Y1, 3065  + i * 285, TALENTS_SKILLS_Y2, '');
            break
        end
    end
    
end

-- #################################################################### -- ####################################################################
-- #################################################################### -- ####################################################################


function _talentsKey(id, down, up)

    if Player[id].loggedIn == true then

        if down == KEY_F3 then
            _talentsShowMySkills(id);
        end

        if down == KEY_Z then
            _talentsUseSprint(id);
        end

    end
end

local talenttex = {};
talenttex[1] = CreateTexture(1931, 2389, 6422, 5736, 'menu_ingame')

talenttex[2] = CreateTexture(2115, 2700, 2381, 3100, 's_crit')
talenttex[3] = CreateTexture(2115, 3200, 2381, 3600, 's_defense')
talenttex[4] = CreateTexture(2115, 3700, 2381, 4100, 's_fist')
talenttex[5] = CreateTexture(2115, 4200, 2381, 4600, 's_sprint')
talenttex[6] = CreateTexture(2115, 4700, 2381, 5100, 's_regHP')
talenttex[7] = CreateTexture(2115, 5200, 2381, 5600, 's_regMP')


function _talentsShow(id)

    if Player[id].loggedIn == true then

        if Player[id]._s_menu == false then

            Player[id]._s_menu = true;

            for i = 1, 7 do
                ShowTexture(id, talenttex[i]);
            end

            for i = 1, 12 do
                ShowPlayerDraw(id, Player[id]._s_menu_draws[i]);
            end

            _talentsRefreshInfo(id);

        else

            Player[id]._s_menu = false;

            for i = 1, 7 do
                HideTexture(id, talenttex[i]);
            end

            for i = 1, 12 do
                HidePlayerDraw(id, Player[id]._s_menu_draws[i]);
            end

        end

    end
end
addCommandHandler({"/таланты"}, _talentsShow);

function _talentsRefreshInfo(id)


    if Player[id]._s_crit > 0 then
        local txt = "Изучено "..Player[id]._s_crit.."/".."5! (+"..tostring(Player[id]._s_crit * 5).." доп. урон)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[7], 2410, 2870, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[7], 2410, 2870, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end

    if Player[id]._s_defense > 0 then
        local txt = "Изучено "..Player[id]._s_defense.."/".."5! (+"..tostring(Player[id]._s_defense * 5).." отраж. урон)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[8], 2410, 3400, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[8], 2410, 3400, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end

    if Player[id]._s_fist > 0 then
        local txt = "Изучено "..Player[id]._s_fist.."/".."5! (+"..tostring(Player[id]._s_fist * 3).." доп. урон)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[9], 2410, 3900, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[9], 2410, 3900, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end

    if Player[id]._s_sprint > 0 then
        local txt = "Изучено "..Player[id]._s_sprint.."/".."5! (+"..tostring(Player[id]._s_sprint * 2).." длит. забега)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[10], 2410, 4400, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[10], 2410, 4400, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end

    if Player[id]._s_regHP > 0 then
        local txt = "Изучено "..Player[id]._s_regHP.."/".."5! (+"..tostring(Player[id]._s_regHP * 3).." тик в минуту)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[11], 2410, 4900, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[11], 2410, 4900, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end

    if Player[id]._s_regMP > 0 then
        local txt = "Изучено "..Player[id]._s_regMP.."/".."5! (+"..tostring(Player[id]._s_regMP * 2).." тик в минуту)";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[12], 2410, 5400, txt, "Font_Old_10_White_Hi.TGA", 90, 255, 87);
    else
        local txt = "Не изучено.";
        UpdatePlayerDraw(id, Player[id]._s_menu_draws[12], 2410, 5400, txt, "Font_Old_10_White_Hi.TGA", 255, 87, 87);
    end
        


end

function _saveNewSkills(id)

    local file = io.open("Database/Players/newSkills/"..Player[id].nickname..".txt", "w");
    file:write(Player[id]._s_sprint.."\n");
    file:write(Player[id]._s_fist.."\n");
    file:write(Player[id]._s_crit.."\n");
    file:write(Player[id]._s_defense.."\n");
    file:write(Player[id]._s_regHP.."\n");
    file:write(Player[id]._s_regMP.."\n");
    file:close();

end

function _readNewSkills(id)

    local file = io.open("Database/Players/newSkills/"..Player[id].nickname..".txt", "r");
    if file then

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_sprint = lvl;
        end

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_fist = lvl;
        end

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_crit = lvl;
        end

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_defense = lvl;
        end

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_regHP = lvl;
        end

        line = file:read("*l");
        local l, lvl = sscanf(line, "d");
        if l == 1 then
            Player[id]._s_regMP = lvl;
        end

        file:close();

    else
        _saveNewSkills(id);
    end

end

function _setNewSkills(id, sets)

    if Player[id].astatus > 3 then
        local cmd, pid, skill, lvl = sscanf(sets, "dsd");
        if cmd == 1 then

            if IsNPC(pid) == 0 then
                if Player[pid].loggedIn == true then

                    if lvl > -1 and lvl < 6 then

                        if skill == "кулак" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_fist = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Мощный кулак улучшен до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Мощный кулак улучшен до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());
                            
                        elseif skill == "удар" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_crit = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Сильный удар улучшен до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Сильный удар улучшен до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());

                        elseif skill == "контратака" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_defense = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Контратака улучшена до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Контратака улучшена до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());

                        elseif skill == "рывок" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_sprint = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Быстрый рывок улучшен до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Быстрый рывок улучшен до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());

                        elseif skill == "хп" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_regHP = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Регенерация ХП улучшена до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Регенерация ХП улучшена до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());

                        elseif skill == "мп" then

                            if Player[pid]._s_menu == true then
                                _talentsShow(pid);
                            end

                            if Player[pid]._s_open == true then
                                _talentsShowMySkills(pid);
                            end

                            Player[pid]._s_regMP = lvl;
                            SendPlayerMessage(pid, 255, 255, 255, "Регенерация МП улучшена до "..lvl.." администратором "..GetPlayerName(id));
                            SendPlayerMessage(id, 255, 255, 255, "Регенерация МП улучшена до "..lvl.." игроку "..GetPlayerName(pid));
                            _saveNewSkills(pid);
                            LogString("Logs/Admins/newSkillsSet",Player[id].nickname.." прокачал игроку "..Player[pid].nickname.." "..skill.." до "..lvl.." / ".._getRTime());

                        else
                            SendPlayerMessage(id, 255, 255, 255, "Талант не найден.")
                            SendPlayerMessage(id, 255, 255, 255, "Доступные таланты: кулак, рывок, хп, мп, контратака, удар (уровни от 0 до 5, где 0 - лишить")
                        end
                    else
                        SendPlayerMessage(id, 255, 255, 255, "Диапазон уровней от 0 до 5 (где 0 - лишить, 5 - макс. уровень)")
                    end
                else
                    SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
                end
            else
                SendPlayerMessage(id, 255, 255, 255, "Это НПС")
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "/талант (ид) (название) (уровень)")
        end
    end

end
addCommandHandler({"/талант", "/talent"}, _setNewSkills);

function _checkTalents(id, sets)

    if Player[id].astatus > 3 then
        local cmd, pid = sscanf(sets, "d");
        if cmd == 1 then
            if IsNPC(pid) == 0 then
                if Player[pid].loggedIn == true then
                    SendPlayerMessage(id, 0, 0, 0, "");
                    SendPlayerMessage(id, 255, 255, 255, "Таланты игрока "..GetPlayerName(pid)..":");
                    SendPlayerMessage(id, 255, 255, 255, "Быстрый рывок: "..Player[pid]._s_sprint);
                    SendPlayerMessage(id, 255, 255, 255, "Мощный кулак: "..Player[pid]._s_fist);
                    SendPlayerMessage(id, 255, 255, 255, "Сильный удар: "..Player[pid]._s_crit);
                    SendPlayerMessage(id, 255, 255, 255, "Контратака: "..Player[pid]._s_defense);
                    SendPlayerMessage(id, 255, 255, 255, "Реген. ХП: "..Player[pid]._s_regHP);
                    SendPlayerMessage(id, 255, 255, 255, "Реген. МП: "..Player[pid]._s_regMP);
                    SendPlayerMessage(id, 0, 0, 0, "");
                else
                    SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизован.")
                end
            else
                SendPlayerMessage(id, 255, 255, 255, "Это НПС.")
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "/таланты_чек (ид)")
        end
    end
end
addCommandHandler({"/таланты_чек", "/talents_check"}, _checkTalents);