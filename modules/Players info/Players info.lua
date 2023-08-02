
--  #   Players info by royclapton   #
--  #           version: 0.3         #

function _playersInfoDisconnect(id)

	for i = 0, GetMaxPlayers() do
		if Player[i]._playersinfo_open == true then
			----------------------------------------
			for i = 1, table.getn(playersinfo_tex) do
				HideTexture(id, playersinfo_tex[i]);
			end
			----------------------------------------
			for i = 1, table.getn(Player[id]._playersinfo_main_draws) do
				HidePlayerDraw(id, Player[id]._playersinfo_main_draws[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_ids[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_players[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_status[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_pm[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_hp[i]);
			end
			----------------------------------------
			for i = 0, 14 do
				HidePlayerDraw(id, Player[id]._playersinfo_ping[i]);
			end
			----------------------------------------

			Player[id]._playersinfo_open = false;
			Player[id]._playersinfo_page = 0;
			Player[id]._playersinfo_arr_ids = {};
			Player[id]._playersinfo_arr_names = {};
			Player[id]._playersinfo_arr_status = {};
			Player[id]._playersinfo_arr_pm = {};
			Player[id]._playersinfo_arr_hp = {};
			Player[id]._playersinfo_arr_ping = {};
			ShowChat(id, 1);
			UnFreeze(id);
		end
	end
end

playersinfo_tex = {};
playersinfo_tex[1] = CreateTexture(1667, 1749, 6583, 6509, 'menu_ingame');


function _playersInfoConnect(id)
	
	Player[id]._playersinfo_open = false;
	Player[id]._playersinfo_page = 0;

	Player[id]._playersinfo_arr_ids = {};
	Player[id]._playersinfo_arr_names = {};
	Player[id]._playersinfo_arr_status = {};
	Player[id]._playersinfo_arr_pm = {};
	Player[id]._playersinfo_arr_hp = {};
	Player[id]._playersinfo_arr_ping = {};
	Player[id]._playersinfocount = 0;


	Player[id]._playersinfo_main_draws = {};
	Player[id]._playersinfo_main_draws[1] = CreatePlayerDraw(id, 1850, 2366, "��");
	Player[id]._playersinfo_main_draws[2] = CreatePlayerDraw(id, 2150, 2366, "�������");
	Player[id]._playersinfo_main_draws[3] = CreatePlayerDraw(id, 3350, 2366, "���������");
	Player[id]._playersinfo_main_draws[4] = CreatePlayerDraw(id, 4570, 2366, "������");
	Player[id]._playersinfo_main_draws[5] = CreatePlayerDraw(id, 5500, 2366, "������");
	Player[id]._playersinfo_main_draws[6] = CreatePlayerDraw(id, 6000, 2366, "����");
	Player[id]._playersinfo_main_draws[7] = CreatePlayerDraw(id, 3809, 1907, string.format("%s%d","�������: ",_playersInfo_online()));
	Player[id]._playersinfo_main_draws[8] = CreatePlayerDraw(id, 5710, 1907, string.format("%s%d","��������: ",Player[id]._playersinfo_page));
	Player[id]._playersinfo_main_draws[9] = CreatePlayerDraw(id, 1772, 6499, string.format("%s%d","��� �� - ",id));

	----------------------------------------
	Player[id]._playersinfo_ids = {};
	for i = 0, 14 do
		Player[id]._playersinfo_ids[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------
	Player[id]._playersinfo_players = {};
	for i = 0, 14 do
		Player[id]._playersinfo_players[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------
	Player[id]._playersinfo_status = {};
	for i = 0, 14 do
		Player[id]._playersinfo_status[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------
	Player[id]._playersinfo_pm = {};
	for i = 0, 14 do
		Player[id]._playersinfo_pm[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------
	Player[id]._playersinfo_hp = {};
	for i = 0, 14 do
		Player[id]._playersinfo_hp[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------
	Player[id]._playersinfo_ping = {};
	for i = 0, 14 do
		Player[id]._playersinfo_ping[i] = CreatePlayerDraw(id, 0, 0, "");
	end
	----------------------------------------


end

function _playersInfo_online()

	local count = 0;
	for i = 0, GetMaxPlayers() do
		if IsPlayerConnected(i) == 1 and Player[i].loggedIn == true then
			count = count + 1;
		end
	end
	return count;

end


function _openPlayersInfo(id)

	if Player[id]._playersinfo_open == false then

		----------------------------------------
		for i = 1, table.getn(playersinfo_tex) do
			ShowTexture(id, playersinfo_tex[i]);
		end
		----------------------------------------
		for i = 1, table.getn(Player[id]._playersinfo_main_draws) do
			ShowPlayerDraw(id, Player[id]._playersinfo_main_draws[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_ids) do
			ShowPlayerDraw(id, Player[id]._playersinfo_ids[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_players) do
			ShowPlayerDraw(id, Player[id]._playersinfo_players[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_status) do
			ShowPlayerDraw(id, Player[id]._playersinfo_status[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_pm) do
			ShowPlayerDraw(id, Player[id]._playersinfo_pm[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_hp) do
			ShowPlayerDraw(id, Player[id]._playersinfo_hp[i]);
		end
		----------------------------------------
		for i = 0, table.getn(Player[id]._playersinfo_ping) do
			ShowPlayerDraw(id, Player[id]._playersinfo_ping[i]);
		end
		----------------------------------------

		UpdatePlayerDraw(id, Player[id]._playersinfo_main_draws[7], 3809, 1907, string.format("%s%d","�������: ",_playersInfo_online()), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_main_draws[8], 5710, 1907, string.format("%s%d","��������: ",Player[id]._playersinfo_page), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		_initPlayersInfo(id);
		_updatePlayersInfo(id);
		Player[id]._playersinfo_open = true;
		Player[id]._playersinfo_page = 1;
		ShowChat(id, 0);
		Freeze(id);
	else

		----------------------------------------
		for i = 1, table.getn(playersinfo_tex) do
			HideTexture(id, playersinfo_tex[i]);
		end
		----------------------------------------
		for i = 1, table.getn(Player[id]._playersinfo_main_draws) do
			HidePlayerDraw(id, Player[id]._playersinfo_main_draws[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_ids[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_players[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_status[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_pm[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_hp[i]);
		end
		----------------------------------------
		for i = 0, 14 do
			HidePlayerDraw(id, Player[id]._playersinfo_ping[i]);
		end
		----------------------------------------

		Player[id]._playersinfo_open = false;
		Player[id]._playersinfo_page = 0;
		Player[id]._playersinfo_arr_ids = {};
		Player[id]._playersinfo_arr_names = {};
		Player[id]._playersinfo_arr_status = {};
		Player[id]._playersinfo_arr_pm = {};
		Player[id]._playersinfo_arr_hp = {};
		Player[id]._playersinfo_arr_ping = {};
		ShowChat(id, 1);
		UnFreeze(id);
	end

end

function _playersInfoCheckConnectsDisconnects(id)

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and Player[i]._playersinfo_open == true then
			_reloadPlayersInfo(i);
		end
	end

end

function _reloadPlayersInfo(id)

	----------------------------------------
	for i = 1, table.getn(playersinfo_tex) do
		HideTexture(id, playersinfo_tex[i]);
	end
	----------------------------------------
	for i = 1, table.getn(Player[id]._playersinfo_main_draws) do
		HidePlayerDraw(id, Player[id]._playersinfo_main_draws[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_ids[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_players[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_status[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_pm[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_hp[i]);
	end
	----------------------------------------
	for i = 0, 14 do
		HidePlayerDraw(id, Player[id]._playersinfo_ping[i]);
	end
	----------------------------------------

	Player[id]._playersinfo_open = false;
	Player[id]._playersinfo_page = 0;
	Player[id]._playersinfo_arr_ids = {};
	Player[id]._playersinfo_arr_names = {};
	Player[id]._playersinfo_arr_status = {};
	Player[id]._playersinfo_arr_pm = {};
	Player[id]._playersinfo_arr_hp = {};
	Player[id]._playersinfo_arr_ping = {};

	_initPlayersInfo(id);
	_updatePlayersInfo(id);
	UnFreeze(id);
	ShowChat(id, 1);

end


function _initPlayersInfo(id)

	Player[id]._playersinfo_page = 1;
	Player[id]._playersinfo_arr_ids = {};
	Player[id]._playersinfo_arr_names = {};
	Player[id]._playersinfo_arr_status = {};
	Player[id]._playersinfo_arr_pm = {};
	Player[id]._playersinfo_arr_hp = {};
	Player[id]._playersinfo_arr_ping = {};
	Player[id]._playersinfocount = 0;

	for i = 0, 100 do
		table.insert(Player[id]._playersinfo_arr_ids, i, "-------");
		table.insert(Player[id]._playersinfo_arr_names, i, "-------");
		table.insert(Player[id]._playersinfo_arr_status, i, "-------");
		table.insert(Player[id]._playersinfo_arr_pm, i, "-------");
		table.insert(Player[id]._playersinfo_arr_hp, i, "-------");
		table.insert(Player[id]._playersinfo_arr_ping, i, "-------");
	end

	for i = 0, GetMaxPlayers() do
		if IsPlayerConnected(i) == 1 and Player[i].loggedIn == true and IsNPC(i) == 0 then
			table.remove(Player[id]._playersinfo_arr_ids, i);
			table.remove(Player[id]._playersinfo_arr_names, i);
			table.remove(Player[id]._playersinfo_arr_status, i);
			table.remove(Player[id]._playersinfo_arr_pm, i);
			table.remove(Player[id]._playersinfo_arr_hp, i);
			table.remove(Player[id]._playersinfo_arr_ping, i);

			table.insert(Player[id]._playersinfo_arr_ids, i, i);

			if string.len(Player[i].nickname) > 13 then
				local line_01 = string.sub(Player[i].nickname, 1, 13);
				local line_02 = line_01.."..";
				if Player[i].masked == false then
					table.insert(Player[id]._playersinfo_arr_names, i, line_02);
				else
					table.insert(Player[id]._playersinfo_arr_names, i, "�����������")
				end
			else
				if Player[i].masked == false then
					table.insert(Player[id]._playersinfo_arr_names, i, Player[i].nickname);
				else
					table.insert(Player[id]._playersinfo_arr_names, i, "�����������")
				end
			end

			table.insert(Player[id]._playersinfo_arr_status, i, _playersInfo_status(i));
			table.insert(Player[id]._playersinfo_arr_pm, i, _playersInfo_timeInGame(i));
			table.insert(Player[id]._playersinfo_arr_hp, i, _playersInfo_hp(i));
			table.insert(Player[id]._playersinfo_arr_ping, i, tostring(GetPlayerPing(i)));
			Player[id]._playersinfocount = Player[id]._playersinfocount + 1;
		end
	end

end

function _getIDbyNick(nickname)

	for i = 0, GetMaxPlayers() do
		if Player[i].nickname == nickname then
			return i;
		end
	end

end

function _updatePlayersInfo(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[i], "Font_Old_10_White_Hi.TGA", Player[i].colorf5[1], Player[i].colorf5[2], Player[i].colorf5[3]);
	end


end

function _playersInfoUpdatePage_2(id)

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[15+i], "Font_Old_10_White_Hi.TGA", Player[15+i].colorf5[1], Player[15+i].colorf5[2], Player[15+i].colorf5[3]);
	end


end

function _playersInfoUpdatePage_3(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[29+i], "Font_Old_10_White_Hi.TGA", Player[29+i].colorf5[1], Player[29+i].colorf5[2], Player[29+i].colorf5[3]);
	end

end

function _playersInfoUpdatePage_4(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[44+i], "Font_Old_10_White_Hi.TGA", Player[44+i].colorf5[1], Player[44+i].colorf5[2], Player[44+i].colorf5[3]);
	end

end

function _playersInfoUpdatePage_5(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[58+i], "Font_Old_10_White_Hi.TGA", Player[58+i].colorf5[1], Player[58+i].colorf5[2], Player[58+i].colorf5[3]);
	end

end

function _playersInfoUpdatePage_6(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[73+i], "Font_Old_10_White_Hi.TGA", Player[73+i].colorf5[1], Player[73+i].colorf5[2], Player[73+i].colorf5[3]);
	end

end

function _playersInfoUpdatePage_7(id)


	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 1850, 2616+250*i, Player[id]._playersinfo_arr_ids[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 2150, 2616+250*i, Player[id]._playersinfo_arr_names[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 3350, 2616+250*i, Player[id]._playersinfo_arr_status[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 4570, 2616+250*i, Player[id]._playersinfo_arr_pm[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 5500, 2616+250*i, Player[id]._playersinfo_arr_hp[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 6000, 2616+250*i, Player[id]._playersinfo_arr_ping[86+i], "Font_Old_10_White_Hi.TGA", Player[86+i].colorf5[1], Player[86+i].colorf5[2], Player[86+i].colorf5[3]);
	end

end


function _playersInfo_resetDraws(id)

	for i = 0, 14 do
		UpdatePlayerDraw(id, Player[id]._playersinfo_ids[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_players[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_status[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_pm[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_hp[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._playersinfo_ping[i], 0, 0, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _playersInfo_hp(player)

	if Player[player].afk == false then
		return "������";

	elseif Player[player].afk == true then
		return "���";
	end

end

function _playersInfo_timeInGame(player)

	return Player[player]._timeInGameNow[1]..":"..Player[player]._timeInGameNow[2]..":"..Player[player]._timeInGameNow[3];

end

function _playersInfo_pm(player)

	if Player[player].blockpm == false then
		return "��������";
	else
		return "���������";
	end

end

function _playersInfo_status(player)

	if Player[player].astatus == 0 then
		return "�����";

	elseif Player[player].astatus == 1 then
		return "������� ������";

	elseif Player[player].astatus == 2 then
		return "�����";

	elseif Player[player].astatus == 3 then
		return "�������� �������";

	elseif Player[player].astatus == 4 then
		return "������� ������";
	
	elseif Player[player].astatus == 5 then
		return "�����������";
	
	elseif Player[player].astatus == 6 then
		return "�.�";

	end

end

function _playersInfo_page(id, page)

	_playersInfo_resetDraws(id);

	if page == 1 then
		_updatePlayersInfo(id);

	elseif page == 2 then
		_playersInfoUpdatePage_2(id);

	elseif page == 3 then
		_playersInfoUpdatePage_3(id);

	elseif page == 4 then
		_playersInfoUpdatePage_4(id);

	elseif page == 5 then
		_playersInfoUpdatePage_5(id);

	elseif page == 6 then
		_playersInfoUpdatePage_6(id);

	elseif page == 7 then
		_playersInfoUpdatePage_7(id);
	end

	UpdatePlayerDraw(id, Player[id]._playersinfo_main_draws[8], 5710, 1907, string.format("%s%d","��������: ",Player[id]._playersinfo_page), "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end

function _playersInfoKey(id, down, up)

	if Player[id].loggedIn == true then

		if down == KEY_F5 then
			_openPlayersInfo(id);
		end

		if Player[id]._playersinfo_open == true then
			if down == KEY_LEFT then
				if Player[id]._playersinfo_page == 1 then
					Player[id]._playersinfo_page = 7;
					_playersInfo_page(id, Player[id]._playersinfo_page);
				else
					Player[id]._playersinfo_page = Player[id]._playersinfo_page - 1;
					_playersInfo_page(id, Player[id]._playersinfo_page);
				end


			end

			if down == KEY_RIGHT then

				if Player[id]._playersinfo_page == 7 then
					Player[id]._playersinfo_page = 1;
					_playersInfo_page(id, Player[id]._playersinfo_page);

				else
					Player[id]._playersinfo_page = Player[id]._playersinfo_page + 1;
					_playersInfo_page(id, Player[id]._playersinfo_page);
				end

			end
		end

	end

end

function _setColorToPlayer(id, sets)

	if Player[id].astatus > 4 then
		local cmd, pid, r, g, b = sscanf(sets, "dddd");
		if cmd == 1 then
			Player[pid].colorf5 = {r, g, b};
			SavePlayer(pid);
			SendPlayerMessage(pid, 255, 255, 255, "��� ���� ��������.")
			SendPlayerMessage(id, 255, 255, 255, "���� ����������.")
		else
			SendPlayerMessage(id, 255, 255, 255, "/�����5 (��) (�) (�) (�)")
		end
	end

end
addCommandHandler({"/�����5"}, _setColorToPlayer);