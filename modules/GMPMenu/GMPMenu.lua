
local gbc = CreateTexture(6685, 2548, 7976, 5961, 'menu_ingame');


function _gmpMenuConnect(id)
    Player[id]._gmpMenu = false;
end

function _gmpMenuOpen(id)

    if Player[id]._gmpMenu == false then
    
        Player[id]._gmpMenu = true;
        ShowTexture(id, gbc);

        _showButton(id, 1);
        _showButton(id, 2);
        _showButton(id, 3);
        _showButton(id, 4);
        _showButton(id, 5);
        _showButton(id, 6);
        _showButton(id, 7);
        _showButton(id, 8);

        ShowChat(id, 0);
        FreezeCamera(id, 1);
        Freeze(id);
        SetCursorVisible(id, 1);

        if Player[id].hud == true then
            _hud(id);
        end

    else

        Player[id]._gmpMenu = false;
        HideTexture(id, gbc);
        
        _hideButton(id, 1);
        _hideButton(id, 2);
        _hideButton(id, 3);
        _hideButton(id, 4);
        _hideButton(id, 5);
        _hideButton(id, 6);
        _hideButton(id, 7);
        _hideButton(id, 8);

        ShowChat(id, 1);
        FreezeCamera(id, 0);
        UnFreeze(id);
        SetCursorVisible(id, 0);

        if Player[id].hud == false then
            _hud(id);
        end


    end

end

function _gmpMenuKey(id, down, up)

    if Player[id].loggedIn == true then

        if down == KEY_ESCAPE then

            if Player[id]._globalMenu == 0 then
                _gmpMenuOpen(id);

            elseif Player[id]._heroinfo_open == true then
                _heroMenu(id);
            
            elseif GUI_Inventory[id].current_item ~= -1 then
                Player[id]._globalMenu = 0;
                HideInventoryGUI(id);

            elseif Player[id]._globalMenu == 228 then
                Player[id]._globalMenu = 0;
                HideCraftGUI(id);
                DestroyCraftGUI(id);

            elseif Player[id]._wiki_open == true then
                _openWiki(id);

            elseif Player[id].openinv == true then
                OpenRPInventory(id);

            elseif Player[id].skinset == true then
                OpenSkinSet(id);

            end
        end

    end

end

function _openSettingsGMP(id)
    _gmpMenuOpen(id);
    OpenGMPMenu(id);
end

function _openInfoGMP(id)
    _gmpMenuOpen(id);
    _heroMenu(id);
end

function _openRPInventory(id)
    _gmpMenuOpen(id);
    if GUI_Inventory[id] ~= nil and GUI_Inventory[id].current_item == -1 and Player[id].onGUI == false then
        if Player[id]._globalMenu == 0 then
            GUIInventoryInit(id);
            ShowInventoryGUI(id);
            InventoryScrollUpdate(id);
            Player[id]._globalMenu = 1;
        end
    else
        Player[id]._globalMenu = 0;
        HideInventoryGUI(id);
    end
end

function _openExitGMP(id)

    _gmpMenuOpen(id);

    if Player[id].exitf8[1] == false then
        if GetPlayerInstance(id) == "PC_HERO" and GetPlayerName(id) == Player[id].nickname then
            if Player[id].hero_use[1] == false and Player[id].IsInstance == false then
                SavePlayer(id);
                SaveStats(id);
				_doubleSaveStats(id)
                SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
                SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
                Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
                Player[id].exitf8[1] = true;
            else
                SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
                SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
                Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
                Player[id].exitf8[1] = true;
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "Выход через 5 секунд.")
            SendPlayerMessage(id, 255, 255, 255, "Отменить выход можно повторным нажатием кнопки выхода.")
            Player[id].exitf8[2] = SetTimerEx(_timerToExit, 5000, 0, id);
            Player[id].exitf8[1] = true;
        end
    else
        KillTimer(Player[id].exitf8[2]);
        Player[id].exitf8[1] = false;
        Player[id].exitf8[2] = nil;
        SendPlayerMessage(id, 255, 255, 255, "Выход отменен.")
    end

end

function _openCraftGMP(id)

    _gmpMenuOpen(id);

    if Player[id]._globalMenu == 0 then
        Player[id]._globalMenu = 228;
        GUIPlayerinfoInit(id, id);
        ShowDLPlayerinfo(id);
        HideDLPlayerinfo(id);
        DestroyDLPlayerinfo(id);
        GenerateCraftGUI(id);
        ShowCraftGUI(id);
    end

end

function _openSkinGMP(id)
    _gmpMenuOpen(id);
    OpenSkinSet(id);
end

function _openWikiGMP(id)
    _gmpMenuOpen(id);
    _openWiki(id);
end

function _openStatusGMP(id)
    _gmpMenuOpen(id);
    OpenRPInventory(id);
end

function OnPlayerTogglePause(id, toggle)

    if toggle == 0 then
        if Player[id].loggedIn == true then
            SetPlayerEnableGMPMenu(id, 0);
        end
    end

end