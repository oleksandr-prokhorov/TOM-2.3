
--  #   Hud system by royclapton  #
--  #         version: 1.0        #

local t_hud1 = CreateTexture(96, 7516, 1160, 8063, 'tom_hud_text')
local t_hud2 = CreateTexture(96, 7516, 1160, 8063, 'tom_hud_text_v2')
local t_logo = CreateTexture(7532, 172, 8032, 1068, 'tom_logo')

function _hudConnect(id)

	Player[id].hud_draw = {};
	Player[id].hud = false;
	Player[id].h_hp = 0;
	Player[id].h_mp = 0;
	Player[id].hud_texturename = "NULL";
	Player[id].hud_other = nil;
	Player[id].hud_textures = 1;
	Player[id].hud_current = "server";

end

function _setHud(id, sets)

	local cmd, hud = sscanf(sets, "d");
	if cmd == 1 then
		if Player[id].loggedIn == true then
			if hud > 0 and hud < 3 then

				if Player[id].hud_current ~= "server" then
					HideTexture(id, Player[id].hud_other);
				else
					if Player[id].hud_textures == 1 then
						HideTexture(id, t_hud1);
					elseif Player[id].hud_textures == 2 then
						HideTexture(id, t_hud2);
					end
				end

				Player[id].hud_current = "server";
				Player[id].hud_textures = hud;
				if Player[id].hud_textures == 1 then
					ShowTexture(id, t_hud1);
				elseif Player[id].hud_textures == 2 then
					ShowTexture(id, t_hud2);
				end
				SendPlayerMessage(id, 255, 255, 255, "Установлен HUD #"..hud);
				_saveHud(id);
			else
				SendPlayerMessage(id, 255, 255, 255, "Для использования доступна 2 худа, выберите число 1 или 2.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/худ (1-2)")
	end
end
addCommandHandler({"/худ"}, _setHud);

function _setHudPlayer(id, sets)

	local cmd, texname = sscanf(sets, "s");
	if cmd == 1 then
		if Player[id].loggedIn == true then
			Player[id].hud_texturename = texname;
			if Player[id].hud_current == "server" then
				if Player[id].hud_textures == 1 then
					HideTexture(id, t_hud1);
				elseif Player[id].hud_textures == 2 then
					HideTexture(id, t_hud2);
				end
				ShowTexture(id, Player[id].hud_other);
				UpdateTexture(Player[id].hud_other, 96, 7516, 1160, 8063, texname);
			else
				if Player[id].hud_texturename ~= "NULL" then
					UpdateTexture(Player[id].hud_other, 96, 7516, 1160, 8063, texname);
				end
			end
			Player[id].hud_current = "player";
			SendPlayerMessage(id, 255, 255, 255, "Установлен пользовательский HUD: "..texname);
			_saveHud(id);
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/схуд (название текстуры)")
	end

end
addCommandHandler({"/схуд"}, _setHudPlayer)


function _saveHud(id)

	local file = io.open("Database/Players/Hud/"..Player[id].nickname..".txt.", "w");
	file:write(Player[id].hud_current.." "..Player[id].hud_textures.." "..Player[id].hud_texturename)
	file:close();

end

function _readHud(id)

	local file = io.open("Database/Players/Hud/"..Player[id].nickname..".txt.", "r");
	if file then

		line = file:read("*l")
		local hudinfo, current, textures, texturename = sscanf(line, "sds");
		if hudinfo == 1 then
			Player[id].hud_current = current;
			Player[id].hud_textures = textures;
			Player[id].hud_texturename = texturename;
			if Player[id].hud_textures ~= "NULL" then
				Player[id].hud_other = CreateTexture(96, 7516, 1160, 8063, texturename);
			end
		end

		file:close();

	else
		_saveHud(id);
		_readHud(id);
	end
end

-- init
function _hudInit(id)

	for i = 1, 3 do
		Player[id].hud_draw[i] = CreatePlayerDraw(id, 0, 0, "");
	end

	_hud(id);

end

function _hud(id)

	if Player[id].hud == false then

		for i = 1, 3 do
			ShowPlayerDraw(id, Player[id].hud_draw[i]);
		end
		_updateHud(id);
		Player[id].hud = true;

		if Player[id].hud_current == "server" then
			if Player[id].hud_textures == 1 then
				ShowTexture(id, t_hud1);
			elseif Player[id].hud_textures == 2 then
				ShowTexture(id, t_hud2);
			end
		else
			if Player[id].hud_texturename ~= "NULL" then
				ShowTexture(id, Player[id].hud_other);
			end
		end

		ShowPlayerDraw(id, gtdraw);
		ShowPlayerDraw(id, rtdraw);
		ShowPlayerDraw(id, weatherdraw);
		UpdateTTable(id);
		Player[id].animtimer = SetTimerEx("UpdateTTable", 1000, 1, id);

		ShowPlayerDraw(id, Player[id].medraw);
		ShowPlayerDraw(id, Player[id].namedraw);

	else

		for i = 1, 3 do
			HidePlayerDraw(id, Player[id].hud_draw[i]);
		end
		_updateHud(id)
		Player[id].hud = false;

		if Player[id].hud_current == "server" then
			if Player[id].hud_textures == 1 then
				HideTexture(id, t_hud1);
			elseif Player[id].hud_textures == 2 then
				HideTexture(id, t_hud2);
			end
		else
			if Player[id].hud_texturename ~= "NULL" then
				HideTexture(id, Player[id].hud_other);
			end
		end

		HidePlayerDraw(id, gtdraw);
		HidePlayerDraw(id, rtdraw);
		HidePlayerDraw(id, weatherdraw);
		KillTimer(Player[id].animtimer);

		HidePlayerDraw(id, Player[id].medraw);
		HidePlayerDraw(id, Player[id].namedraw);
		
	end

end


function _hudKey(id, down, up)

	if Player[id].loggedIn == true then
		if down == KEY_F4 then
			_hud(id);
		end
	end

end

function _updateHud(id)
	
	if Player[id].loggedIn == true then

		if Player[id].hud_draw[1] ~= nil then

			if Player[id].h_hp > 99 then
				UpdatePlayerDraw(id, Player[id].hud_draw[1], 165, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			elseif Player[id].h_hp > 9 and Player[id].h_hp < 100 then
				UpdatePlayerDraw(id, Player[id].hud_draw[1], 165+30, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			elseif Player[id].h_hp < 10 then
				UpdatePlayerDraw(id, Player[id].hud_draw[1], 165+50, 7370, GetPlayerHealth(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			end

			if Player[id].h_mp > 99 then
				UpdatePlayerDraw(id, Player[id].hud_draw[2], 560, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			elseif Player[id].h_mp > 9 and Player[id].h_mp < 100 then
				UpdatePlayerDraw(id, Player[id].hud_draw[2], 560+30, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			elseif Player[id].h_mp < 10 then
				UpdatePlayerDraw(id, Player[id].hud_draw[2], 560+50, 7370, GetPlayerMana(id), "Font_Old_10_White_Hi.TGA", 255, 255, 255)
			end
		
			
			if Player[id].energy > 99 then
				UpdatePlayerDraw(id, Player[id].hud_draw[3], 937, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 255, 255, 255)

			elseif Player[id].energy > 9 and Player[id].energy < 100 then
				UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+30, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 255, 255, 255)

			elseif Player[id].energy < 10 then
				UpdatePlayerDraw(id, Player[id].hud_draw[3], 937+50, 7370, Player[id].energy, "Font_Old_10_White_Hi.TGA", 247, 77, 77)
				
			end
		else
			ShowChat(id, 1);
			for i = 1, 5 do
				SendPlayerMessage(id, 255, 255, 255, "");
			end
			SendPlayerMessage(id, 255, 255, 255, "Ваш аккаунт поврежден. Обратитесь к администрации за помощью.")
			Kick(id);
		end
	end


end

function _updateHealth(id)

	local proc = GetPlayerHealth(id) / GetPlayerMaxHealth(id);
	local formula = (proc * 100);

	Player[id].h_hp = GetPlayerHealth(id);
	_updateHud(id);

end


function _checkHealth(id, new, old)

	if new ~= old then
		_updateHealth(id)
	end

end

function _updateMana(id)

	local proc = GetPlayerMana(id) / GetPlayerMaxMana(id);
	local formula = (proc * 100);

	Player[id].h_mp = GetPlayerMana(id);
	_updateHud(id);

end

function _checkMana(id, new, old)

	if new ~= old then
		_updateMana(id)
	end

end


