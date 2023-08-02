
--  #  Sheeps system by royclapton  #
--  #          version: 1.0         #

function _sheepsSpawn()

	print(" ");

	local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "FULLWORLD2.ZEN");
	SetPlayerPos(sheep, 15622.10546875, 1837.7017822266, -16185.2421875)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);
	SetPlayerAngle(sheep, math.random(1,360))

	local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "FULLWORLD2.ZEN");
	SetPlayerPos(sheep, 15230.974609375, 1810.6170654297, -16060.265625)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);
	SetPlayerAngle(sheep, math.random(1,360))

	--[[local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "KOLONIE.ZEN");
	SetPlayerPos(sheep, -58460.49609375, 5923.5263671875, 5396.7895507813)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);
	SetPlayerAngle(sheep, math.random(1,360))

	local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "KOLONIE.ZEN");
	SetPlayerPos(sheep, -59064.4921875, 5893.1015625, 4832.6293945313)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);
	SetPlayerAngle(sheep, math.random(1,360))

	local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "KOLONIE.ZEN");
	SetPlayerPos(sheep, -58121.21875, 5901.3911132813, 4963.6147460938)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);

	local sheep = CreateNPC("����");
	SpawnPlayer(sheep);
	SetPlayerWorld(sheep, "KOLONIE.ZEN");
	SetPlayerPos(sheep, -58545.4921875, 5887.5532226563, 4469.435546875)
	SetPlayerInstance(sheep, "SHEEP");
	SetPlayerMaxHealth(sheep, 9999);
	SetPlayerHealth(sheep, 9999);
	SetPlayerAngle(sheep, math.random(1,360))]]


end

function _sheepsFocus(id, bot)

	if bot ~= -1 then
		if IsNPC(bot) == 1 and GetPlayerName(bot) == "����" then
			ShowTexture(id, Player[id].sheep_focus_tex);
			ShowPlayerDraw(id, Player[id].sheep_focus_draw);
			Player[id].sheep_focus = 1;
		end
	else
		Player[id].sheep_focus = 0;
		HideTexture(id, Player[id].sheep_focus_tex);
		HidePlayerDraw(id, Player[id].sheep_focus_draw);
	end

end



function _sheepConnect(id)
	

	Player[id].sheep_focus = 0;
	Player[id].sheep_focus_tex = CreateTexture(2997, 6223, 5189, 6620, 'menu_ingame')
	Player[id].sheep_focus_draw = CreatePlayerDraw(id, 3290, 6320, "����������������� - CTRL");

	Player[id].sheep_open = false;
	Player[id].sheep_use = 0;
	Player[id].sheep_prog = nil;

end

createGUIMenu("SHEEP_MENU", {
	{ "1. ������� ���� (������)" },
	{ "2. �������� ���� (������)" },
	{ "3. ������� ����" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_20_White_Hi.TGA", CreateTexture(5295, 3365, 8130, 4440, 'menu_ingame'), 3);


function _sheepKey(id, down, up)

	if down == KEY_LCONTROL then
		if Player[id].sheep_focus ~= 0 then
			if Player[id].loggedIn == true then
				HideTexture(id, Player[id].sheep_focus_tex);
				HidePlayerDraw(id, Player[id].sheep_focus_draw);
				Player[id].sheep_focus = nil;
				showGUIMenu(id, "SHEEP_MENU");
				Player[id].sheep_open = true;
				Freeze(id);
			end
		end
	end

	if down == KEY_UP then
		switchGUIMenuUp(id, "SHEEP_MENU");
	end

	if down == KEY_DOWN then
		switchGUIMenuDown(id, "SHEEP_MENU");
	end

	if down == KEY_ESCAPE then
		if Player[id].loggedIn == true then
			if Player[id].sheep_open == true then
				UnFreeze(id);
				hideGUIMenu(id, "SHEEP_MENU");
				Player[id].sheep_open = false;
			end
		end
	end

	if down == KEY_RETURN then
		if Player[id].loggedIn == true then
			if Player[id].sheep_open == true then

				if getPlayerOptionID(id, "SHEEP_MENU") == 1 then
					_mGetOnline();
					if ONLINE > 0 then
						_shMilk(id);
					else
						SendPlayerMessage(id, 255, 255, 255, "������ �������� ��� ������� ���� 5.")
					end

				elseif getPlayerOptionID(id, "SHEEP_MENU") == 2 then
					_mGetOnline();
					if ONLINE > 0 then
						_shWool(id);
					else
						SendPlayerMessage(id, 255, 255, 255, "������ �������� ��� ������� ���� 5.")
					end

				elseif getPlayerOptionID(id, "SHEEP_MENU") == 3 then
					UnFreeze(id);
					hideGUIMenu(id, "SHEEP_MENU");
					Player[id].sheep_open = false;
					Player[id].sheep_focus = nil;
					Player[id].sheep_use = 0;
				end
			end
		end
	end
end

function _shCheckItem(id, item)

	local it = string.upper(item);
	local file = io.open("Database/Players/Items/"..Player[id].nickname..".db", "r");
	for line in file:lines() do
		local result, code, amount = sscanf(line, "sd");
		if result == 1 then
			if code == it then
				file:close();
				return true;
			end
		end
	end
	file:close();
	return false;

end

function _shMilk(id)

	if _shCheckItem(id, "ZDPWLA_ITMI_BUCKET") == true then
		if Player[id].energy >= 5 then

			Player[id].sheep_use = 1;
			Player[id].energy = Player[id].energy - 5;
			_updateHud(id);
			GameTextForPlayer(id, 50, 6000, "�� ������ ���� ������.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
			PlayAnimation(id, "T_CHESTBIG_STAND_2_S0");
			FreezePlayer(id, 1);
			hideGUIMenu(id, "SHEEP_MENU");
			ShowTexture(id, Player[id].prog_background_f);
			ShowTexture(id, Player[id].prog_f);
			SetDefaultCamera(id);
			_newSetCameraBeforePlayer(id, 1);
			SetTimerEx("freezeCameraTimer", 400, 0, id);
			Player[id].sheep_prog = SetTimerEx("_shT", 100, 1, id);

			_saveEnergy(id);

		else
			GameTextForPlayer(id, 50, 6000, "������������ �������","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
		end
	else
		GameTextForPlayer(id, 50, 6000, "� ��� ��� �����","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
	end


end

function _shWool(id)

	if _shCheckItem(id, "OOLTYB_ITMI_SCISSORS") == true then
		if Player[id].energy >= 5 then

			Player[id].sheep_use = 2;
			Player[id].energy = Player[id].energy - 5;
			_updateHud(id);
			GameTextForPlayer(id, 50, 6000, "�� ������ ������ ����.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
			PlayAnimation(id, "T_CHESTBIG_STAND_2_S0");
			FreezePlayer(id, 1);
			hideGUIMenu(id, "SHEEP_MENU");
			ShowTexture(id, Player[id].prog_background_f);
			ShowTexture(id, Player[id].prog_f);
			SetDefaultCamera(id);
			_newSetCameraBeforePlayer(id, 1);
			SetTimerEx("freezeCameraTimer", 400, 0, id);
			Player[id].sheep_prog = SetTimerEx("_shT", 100, 1, id);

			_saveEnergy(id);

		else
			GameTextForPlayer(id, 50, 6000, "������������ �������","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
		end
	else
		GameTextForPlayer(id, 50, 6000, "� ��� ��� ������","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
	end

end

function _shT(id)

	if Player[id].current_size_f > Player[id].zero_size_f then
		Player[id].current_size_f = Player[id].current_size_f - 20;
		UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].current_size_f, 7469, 'PROGRESS_BLUE_BAR');
	else
		KillTimer(Player[id].sheep_prog);
		UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].start_size_f, 7469, 'PROGRESS_BLUE_BAR');
		Player[id].current_size_f = Player[id].start_size_f;
		Player[id].sheep_prog = nil;
		HideTexture(id, Player[id].prog_f)
		HideTexture(id, Player[id].prog_background_f);
		FreezeCamera(id, 0);
		SetDefaultCamera(id);
		UnFreeze(id);
		PlayAnimation(id, "S_CHESTBIG_S0");
		PlayAnimation(id, "T_CHESTBIG_S0_2_STAND");

		if Player[id].sheep_use == 1 then
			local rnd = math.random(1, 100);
			if rnd <= 40 then
				SendPlayerMessage(id, 255, 255, 255, "��� �� ������� ������� ������.")
				Player[id].sheep_open = false;
				Player[id].sheep_focus = nil;
				Player[id].sheep_use = 0;

			elseif rnd > 40 and rnd < 90 then
				SendPlayerMessage(id, 255, 255, 255, "�� ������� ������ (x1).")
				GiveItem(id, "ZDPWLA_ITFO_MILK", 1);
				SaveItems(id);
				SavePlayer(id);
				_saveEnergy(id);
				Player[id].sheep_open = false;
				Player[id].sheep_focus = nil;
				Player[id].sheep_use = 0;

			elseif rnd >= 90 and rnd <= 100 then
				SendPlayerMessage(id, 255, 255, 255, "�� ������� ������ (x2).")
				GiveItem(id, "ZDPWLA_ITFO_MILK", 2);
				SaveItems(id);
				SavePlayer(id);
				_saveEnergy(id);
				Player[id].sheep_open = false;
				Player[id].sheep_focus = nil;
				Player[id].sheep_use = 0;
			end

		elseif Player[id].sheep_use == 2 then
			local rnd = math.random(1, 100);
			if rnd <= 80 then
				SendPlayerMessage(id, 255, 255, 255, "�� ��������� ���� (x1)")
				GiveItem(id, "OOLTYB_ITMI_SHEEP", 1);
				SaveItems(id);
				Player[id].sheep_open = false;
				Player[id].sheep_focus = nil;
				Player[id].sheep_use = 0;

			elseif rnd > 80 then
				SendPlayerMessage(id, 255, 255, 255, "�� ��������� ���� (x2)")
				GiveItem(id, "OOLTYB_ITMI_SHEEP", 2);
				SaveItems(id);
				SavePlayer(id);
				_saveEnergy(id);
				Player[id].sheep_open = false;
				Player[id].sheep_focus = nil;
				Player[id].sheep_use = 0;
			end
		end
	end
end