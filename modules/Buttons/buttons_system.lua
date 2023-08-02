
-- / * Автор: royclapton.
-- / * Система анимированных кнопок (с эффектом нажатия).


local bclick = CreateSound("INV_OPEN.WAV");
tBUTTONS = {};
for i = 1, 400 do

    tBUTTONS[i] = {};
    tBUTTONS[i].xz = {nil, nil, nil, nil};
    tBUTTONS[i].tex = nil;
    tBUTTONS[i].func = nil;
    tBUTTONS[i].type = nil;
    tBUTTONS[i].text = {};
    tBUTTONS[i].rgb = {255, 255, 255};
    tBUTTONS[i].text[1] = CreateDraw(0, 0, "", "Font_Old_10_White_Hi.TGA", tBUTTONS[i].rgb[1], tBUTTONS[i].rgb[2], tBUTTONS[i].rgb[3]);
    tBUTTONS[i].text[2] = "";

end

function _buttonsConnect(id)

    Player[id]._bPressed = nil; -- на какую кнопку было нажатие
    Player[id]._bList = {}; -- список показанных игроку кнопок
    Player[id]._bTempList = {}; -- временный список кнопок

end


function _initButton()

    _createButton("MENU_CHOICE_BACK", 6782, 7882, 2900, 3100, 1, _openInfoGMP, "Персонаж")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 3200, 3400, 2, _openRPInventory, "РП-инвентарь")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 3500, 3700, 3, _openStatusGMP, "Статусы")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 3800, 4000, 4, _openCraftGMP, "Крафт")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 4100, 4300, 5, _openWikiGMP, "Википедия")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 4400, 4600, 6, _openSkinGMP, "Внешность")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 5000, 5200, 7, _openSettingsGMP, "Настройки")
    _createButton("MENU_CHOICE_BACK", 6782, 7882, 5300, 5500, 8, _openExitGMP, "Выход", 230, 60, 60)

end

function _buttonGetType(bid)
    
    local type = string.upper(tBUTTONS[bid].type);
    return type;

end


function _centeredDrawButton(x1, x2, y1, y2, text)

    local centerX = ((x1 / 2) + (x2 / 2)) - string.len(text) * 32;
    local centerY = ((y1 / 2) + (y2 / 2)) - 92;
    return centerX, centerY;

end

function _createButton(type, x1, x2, y1, y2, bid, func, text, r, g, b)

    tBUTTONS[bid].xz = {x1, x2, y1, y2};
    tBUTTONS[bid].func = func;
    tBUTTONS[bid].type = type;

    if r and g and b then
        tBUTTONS[bid].rgb = {r, g, b};
        SetDrawColor(tBUTTONS[bid].text[1], r, g, b);
    end

    if text then
        tBUTTONS[bid].text[2] = text;
        SetDrawText(tBUTTONS[bid].text[1], text);
        local dx, dy = _centeredDrawButton(x1, x2, y1, y2, text);
        SetDrawPos(tBUTTONS[bid].text[1], dx, dy)
    else
        SetDrawText(tBUTTONS[bid].text[1], "");
    end

    if type == "MENU_INGAME" then
        tBUTTONS[bid].tex = CreateTexture(x1, y1, x2, y2, "MENU_INGAME")

    elseif type == "MENU_CHOICE_BACK" then
        tBUTTONS[bid].tex = CreateTexture(x1, y1, x2, y2, "MENU_CHOICE_BACK")

    end

end

function _showButton(id, bid)

    ShowTexture(id, tBUTTONS[bid].tex);
    ShowDraw(id, tBUTTONS[bid].text[1]);
    table.insert(Player[id]._bList, bid);
    

end

function _hideButton(id, bid)

    HideDraw(id, tBUTTONS[bid].text[1]);
    for i, v in pairs(Player[id]._bList) do
        if v == bid then
            table.remove(Player[id]._bList, i);
        end
    end
    SetTimer(_buttonHideTexture, 130, 0, id, bid);

end


function _clickButton_B(id, bid)

    if _findButtonInArray(id, bid) == true then

        PlayPlayerSound(id, bclick);
        Player[id]._bPressed = bid;

        if tBUTTONS[bid].func ~= nil then
            SetTimerEx(tBUTTONS[bid].func, 200, 0, id);
            --tBUTTONS[bid].func(id);
        end

        HideTexture(id, tBUTTONS[bid].tex);
        SetDrawColor(tBUTTONS[bid].text[1], 197, 255, 150);

        if tBUTTONS[bid].type == "MENU_INGAME" then
            UpdateTexture(tBUTTONS[bid].tex, tBUTTONS[bid].xz[1], tBUTTONS[bid].xz[3], tBUTTONS[bid].xz[2], tBUTTONS[bid].xz[4], "dlg_conversation");
        end

        if tBUTTONS[bid].type == "MENU_CHOICE_BACK" then
            UpdateTexture(tBUTTONS[bid].tex, tBUTTONS[bid].xz[1], tBUTTONS[bid].xz[3], tBUTTONS[bid].xz[2], tBUTTONS[bid].xz[4], "dlg_conversation");
        end

        ShowTexture(id, tBUTTONS[bid].tex);
        SetTimerEx(_clickButton_A, 90, 0, id);
    end

end

function _clickButton_A(id)
    
    local bid = Player[id]._bPressed;
    HideTexture(id, tBUTTONS[bid].tex);
    SetDrawColor(tBUTTONS[bid].text[1], tBUTTONS[bid].rgb[1], tBUTTONS[bid].rgb[2], tBUTTONS[bid].rgb[3]);

    if tBUTTONS[bid].type == "MENU_INGAME" then
        UpdateTexture(tBUTTONS[bid].tex, tBUTTONS[bid].xz[1], tBUTTONS[bid].xz[3], tBUTTONS[bid].xz[2], tBUTTONS[bid].xz[4], "MENU_INGAME");
    end

    if tBUTTONS[bid].type == "MENU_CHOICE_BACK" then
        UpdateTexture(tBUTTONS[bid].tex, tBUTTONS[bid].xz[1], tBUTTONS[bid].xz[3], tBUTTONS[bid].xz[2], tBUTTONS[bid].xz[4], "MENU_CHOICE_BACK");
    end

    ShowTexture(id, tBUTTONS[bid].tex);
    Player[id]._bPressed = nil;

end

function _OnButtons(id, b, p, X, Y)

    if b == MB_LEFT then
        if p == 0 then
            for i = 1, 200 do
                if tBUTTONS[i].type ~= nil then
                    if (X > tBUTTONS[i].xz[1] and X < tBUTTONS[i].xz[2]) and (Y > tBUTTONS[i].xz[3] and Y < tBUTTONS[i].xz[4]) then
                        if _findButtonInArray(id, i) == true then
                            if Player[id]._bPressed == nil then
                                _clickButton_B(id, i);
                                break
                            end
                        end
                    end
                end
            end
        end
    end

end

function _buttonHideTexture(id, bid)
    HideTexture(id, tBUTTONS[bid].tex);
end

function _findButtonInArray(id, bid)

    if table.getn(Player[id]._bList) > 0 then
        for i, v in pairs(Player[id]._bList) do
            if v == bid then
                return true;
            end
        end
        return false;
    end
    return false;

end
