CITY_CASH = 0;
CITY_GOVERNOR = nil;
CITY_ASSISTANT = nil;
CITY_ASSISTANT_POS = {14369.7421875, 1194.4234619141, -562.72479248047}
CITY_BIZNES_TAX = 5;

CITY_BANSHIK = nil;
CITY_BANYA_CASH = 0;
CITY_BANYA_OWNER = "�������";
CITY_BANYA_PRICE = 0;
CITY_BANYA_TAX = 0;
CITY_BANYA_PLAYERS = {};
CITY_BANYA_ARREST = 0;
CITY_BANYA_LEVEL = 1;
CITY_BANYA_ZAMESTITEL = "NULL";
CITY_BANYA_TRADER = "NULL";

CITY_BORDEL_BOT = nil;
CITY_BORDEL_CASH = 0;
CITY_BORDEL_OWNER = "�������";
CITY_BORDEL_PRICE = 0;
CITY_BORDEL_LEVEL = 1;
CITY_BORDEL_TAX = 30;
CITY_BORDEL_PLAYERS = {};
CITY_BORDEL_ARREST = 0;


function _initCity()
	
	local file = io.open("Database/City/City.txt", "r");
	if file then

		line = file:read("*l");
		local l, cash = sscanf(line, "f");
		if l == 1 then
			CITY_CASH = cash;
		end

		line = file:read("*l");
		local l, gov = sscanf(line, "s");
		if l == 1 then
			CITY_GOVERNOR = gov;
		end

		file:close();

		_assistantGov()
		print(" ");
		print(" City load ");
		print(" City cash: "..CITY_CASH);
		print(" City gov: "..CITY_GOVERNOR);
	end


end

function _initBanya()

	local file = io.open("Database/City/Banya.txt", "r");
	if file then

		line = file:read("*l");
		local l, price = sscanf(line, "d");
		if l == 1 then
			CITY_BANYA_PRICE = price;
		end

		line = file:read("*l");
		local l, tax = sscanf(line, "d");
		if l == 1 then
			CITY_BANYA_TAX = tax;
		end

		line = file:read("*l");
		local l, own = sscanf(line, "s");
		if l == 1 then
			CITY_BANYA_OWNER = own;
		end

		line = file:read("*l");
		local l, cash = sscanf(line, "f");
		if l == 1 then
			CITY_BANYA_CASH = cash;
		end

		line = file:read("*l");
		local l, arrest = sscanf(line, "d");
		if l == 1 then
			CITY_BANYA_ARREST = arrest;
		end

		line = file:read("*l");
		local l, lvl = sscanf(line, "d");
		if l == 1 then
			CITY_BANYA_LEVEL = lvl;
		end

		line = file:read("*l");
		local l, name = sscanf(line, "s");
		if l == 1 then
			CITY_BANYA_ZAMESTITEL = name;
		end

		file:close();

		_theBanshikBot()

		print(" ");
		print(" Banya load ");
		print(" Banya cash: "..CITY_BANYA_CASH.." / Price: "..CITY_BANYA_PRICE);
		print(" Banya tax: "..CITY_BANYA_TAX.." / Owner: "..CITY_BANYA_OWNER);
		print(" Banya level: "..CITY_BANYA_LEVEL.." / Arrest: "..CITY_BANYA_ARREST);
	end

end

function _saveCity()

	local file = io.open("Database/City/City.txt", "w");
	file:write(CITY_CASH.."\n");
	file:write(CITY_GOVERNOR);
	file:close();

	local file = io.open("Database/City/Banya.txt", "w");
	file:write(CITY_BANYA_PRICE.."\n");
	file:write(CITY_BANYA_TAX.."\n");
	file:write(CITY_BANYA_OWNER.."\n");
	file:write(CITY_BANYA_CASH.."\n");
	file:write(CITY_BANYA_ARREST.."\n")
	file:write(CITY_BANYA_LEVEL.."\n")
	file:write(CITY_BANYA_ZAMESTITEL.."\n")
	file:close();

end

function _assistantGov()

	CITY_ASSISTANT = CreateNPC("��������� �����������");
	SpawnPlayer(CITY_ASSISTANT);
	SetPlayerWorld(CITY_ASSISTANT, "FULLWORLD2.ZEN");
	SetPlayerPos(CITY_ASSISTANT, CITY_ASSISTANT_POS[1], CITY_ASSISTANT_POS[2], CITY_ASSISTANT_POS[3]);
	SetPlayerAngle(CITY_ASSISTANT, 133);
	EquipArmor(CITY_ASSISTANT, "yfauun_itar_governor");
	SetPlayerMaxHealth(CITY_ASSISTANT, 99999999);
	SetPlayerHealth(CITY_ASSISTANT, 99999999)

end

function _theBanshikBot()

	CITY_BANSHIK = CreateNPC("������");
	SpawnPlayer(CITY_BANSHIK);
	SetPlayerWorld(CITY_BANSHIK, "FULLWORLD2.ZEN")
	SetPlayerPos(CITY_BANSHIK, 5009.421875, 364.38180541992, -2422.03125);
	SetPlayerAngle(CITY_BANSHIK, 156);
	SetPlayerAdditionalVisual(CITY_BANSHIK, "Hum_Body_Naked0", 18, "Hum_Head_Bald", 25);
	PlayAnimation(CITY_BANSHIK, "S_LGUARD");
	SetPlayerMaxHealth(CITY_BANSHIK, 99999999);
	SetPlayerHealth(CITY_BANSHIK, 99999999)

end

local cityfocus_tex = CreateTexture(2997, 6223, 5189, 6620, 'menu_ingame')

function _assistConnect(id)
	Player[id]._assistDrawInfo = CreatePlayerDraw(id, 3280, 6320, " ����������� ������� - CTRL");
	Player[id]._banshikDrawInfo = CreatePlayerDraw(id, 3280, 6320, " ����������� ������� - CTRL");
end

function _focusAssist(id, fid)

	if GetFocus(id) == CITY_ASSISTANT then
		ShowTexture(id, cityfocus_tex);
		ShowPlayerDraw(id, Player[id]._assistDrawInfo);
	else
		HideTexture(id, cityfocus_tex);
		HidePlayerDraw(id, Player[id]._assistDrawInfo);
	end

	if GetFocus(id) == CITY_BANSHIK then
		ShowTexture(id, cityfocus_tex);
		ShowPlayerDraw(id, Player[id]._banshikDrawInfo);
	else
		HideTexture(id, cityfocus_tex);
		HidePlayerDraw(id, Player[id]._banshikDrawInfo);
	end

end

function _assistKey(id, down, up)

	if down == KEY_LCONTROL then
		if GetFocus(id) == CITY_ASSISTANT then
			if GetPlayerName(id) == CITY_GOVERNOR or Player[id].astatus > 2 then
				SendPlayerMessage(id, 255, 255, 255, "����-���������� ������: "..CITY_GOVERNOR);
				SendPlayerMessage(id, 255, 255, 255, "���������� ��������� ����: /�����_���");
				SendPlayerMessage(id, 255, 255, 255, "����� ������: "..CITY_CASH);
				SendPlayerMessage(id, 255, 255, 255, "������� ������ �� ����� - /�����_���� (���-��)");
				SendPlayerMessage(id, 255, 255, 255, "��������� ���������� ������ �������� - /���_����� (�������) # ����� ���� � ������� � ����� #")
				SendPlayerMessage(id, 255, 255, 255, "��������� ���������� ������ ����: /����_����� (�������) # ����� ���� � ���� #")
				SendPlayerMessage(id, 255, 255, 255, "��������� ���������: /�����������_����, /�����������_���, /��������_����")

				if Player[id].astatus > 2 then
					SendPlayerMessage(id, 255, 255, 255, "���������� ������ �� ����� � �������: "..TRADERS_TAX);
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����-���������� ������: "..CITY_GOVERNOR);
				SendPlayerMessage(id, 255, 255, 255, "���������� ��������� ����: /�����_���");
			end
		end
	end

	if down == KEY_LCONTROL then
		if GetFocus(id) == CITY_BANSHIK then
			if CITY_BANYA_ARREST == 1 then
				SendPlayerMessage(id, 255, 255, 255, "������: ������������� ���������� ����, ������ ��� ������� ������.")
			else
				PlayGesticulation(CITY_BANSHIK);
				local status = false;
				SendPlayerMessage(id, 255, 255, 255, "������: ����� ���������� � ���� ������, "..GetPlayerName(id).."!");
				SendPlayerMessage(id, 255, 255, 255, "������: ��������� �������� ������ - "..CITY_BANYA_PRICE);
				if CITY_BANYA_OWNER ~= "�������" then
					SendPlayerMessage(id, 255, 255, 255, "������: �������� ������ - "..CITY_BANYA_OWNER);
				else
					SendPlayerMessage(id, 255, 255, 255, "������: ��������� � ������ ���, ������ ��� � ������������� � ������.")
				end

				for _, name in pairs(CITY_BANYA_PLAYERS) do
					if name == Player[id].nickname then
						status = true;
					end
				end

				if status == true then
					SendPlayerMessage(id, 255, 255, 255, "������: ������� �� ��� ���������� �����, ������ ��������� ���������!")
				else
					SendPlayerMessage(id, 255, 255, 255, "������: � �������� ������ ������� ������!")
					SendPlayerMessage(id, 255, 255, 255, "(������) ����� �������� ����� � ������ ������� ������� /�����")
				end

				PlayGesticulation(CITY_BANSHIK);

				if Player[id].astatus > 2 or CITY_BANYA_OWNER == Player[id].nickname or CITY_GOVERNOR == Player[id].nickname then
					SendPlayerMessage(id, 255, 255, 255, "���������� ������ �� ����� � �������: "..CITY_BIZNES_TAX.."%");
					SendPlayerMessage(id, 255, 255, 255, "���������� ������ (�����): "..CITY_BANYA_TAX.."%");
					SendPlayerMessage(id, 255, 255, 255, "������ ����: "..CITY_BANYA_CASH..".");
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..CITY_BANYA_LEVEL..".");
					SendPlayerMessage(id, 255, 255, 255, "/����_���� - ������� ������");
					SendPlayerMessage(id, 255, 255, 255, "/����_���� - ���������� ����");
					SendPlayerMessage(id, 255, 255, 255, "/����_����� - ���������� �����");
					SendPlayerMessage(id, 255, 255, 255, "/����_���� - �������� �����");
					SendPlayerMessage(id, 255, 255, 255, "/����_�������� - ������ ������������");
				end
			end
		end
	end

end

function _takeTex(id, sets)

	local cmd, value = sscanf(sets, "f");
	if cmd == 1 then
		if Player[id].astatus > 2 or GetPlayerName(id) == CITY_GOVERNOR then
			local x, y, z = GetPlayerPos(id);
			if GetDistance3D(x, y, z, CITY_ASSISTANT_POS[1], CITY_ASSISTANT_POS[2], CITY_ASSISTANT_POS[3]) < 350 then
				if CITY_CASH >= value then
					CITY_CASH = CITY_CASH - value;
					Player[id].gold = Player[id].gold + value;
					SendPlayerMessage(id, 255, 255, 255, "�� ������� � ����� ������ "..value.." ������� �����.")
					for i = 0, GetMaxPlayers() do
						if Player[i].astatus > 2 then
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id).." ������ � ����� ������ "..value.." ������� �����.")
						end
					end
					_saveCity();
					SavePlayer(id);
					LogString("Logs/Admins/governer", Player[id].nickname.." ������ � ����� "..value.." ������� ����� / ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "� ����� ������ ������� ���.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� ������� ������ �� ����� ����� ���� ����� ����������.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/�����_���� (���-��)")
	end

end
addCommandHandler({"/�����_����"}, _takeTex);

function _setGoverner(id, sets)

	if Player[id].astatus > 3 then
		local cmd, pid = sscanf(sets, "d");
		if cmd == 1 then
			CITY_GOVERNOR = Player[pid].nickname;	
			SendMessageToAll(0, 255, 0, Player[id].nickname.." �������� ������ "..GetPlayerName(pid).." ����-������������ ������.")
			LogString("Logs/Admins/governer",Player[id].nickname.." �������� ������ "..GetPlayerName(pid).." ����-������������ ������ / ".._getRTime());
			_saveCity();
		else
			SendPlayerMessage(id, 255, 255, 255, "/���������� (��)")
		end
	end

end
addCommandHandler({"/����������"}, _setGoverner);

function _houseSetOwner(id, sets)

	local cmd, house, player = sscanf(sets, "ds");
	if cmd == 1 then
		if Player[id].astatus > 2 or GetPlayerName(id) == CITY_GOVERNOR then
			local x, y, z = GetPlayerPos(id);
			if GetDistance3D(x, y, z, CITY_ASSISTANT_POS[1], CITY_ASSISTANT_POS[2], CITY_ASSISTANT_POS[3]) < 350 then
				if _HOUSE[house] ~= nil then
					_HOUSE[house].owner = player;
					_house_Save(house);
					SendMessageToAll(0, 255, 0, GetPlayerName(id).." �������� ������ "..player.." ���������� ���� #"..house);
					LogString("Logs/Admins/governer",Player[id].nickname.." �������� ������ "..player.." ���������� ���� �"..house.." / ".._getRTime());
				else
					SendPlayerMessage(id, 255, 255, 255, "������ � ����������� ������ ����.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "������� �������� ������ � ������ (����� ����������).")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/�����_��� (����� ����) (��� ������)")
	end

end
addCommandHandler({"/���_��������"}, _houseSetOwner);

local CITY_HOUSE_TEX = CreateTexture(5598, 2125, 8026.5, 6282, 'menu_ingame')
function _checkHouses(id)

	if Player[id].loggedIn == true then
		local x, y, z = GetPlayerPos(id);

		if GetDistance3D(x, y, z, CITY_ASSISTANT_POS[1], CITY_ASSISTANT_POS[2], CITY_ASSISTANT_POS[3]) < 350 then
			if Player[id]._cityCheckHouse == false then

				Player[id]._cityCheckHouse = true;
				ShowTexture(id, CITY_HOUSE_TEX);
				Freeze(id);

				local x = 5734; local y = 2337; local k = 1;
				for i = 1, table.getn(Player[id]._cityCheckHouseDraws_h) do
					if Player[id]._cityCheckHouseDraws_h[i] ~= nil then
						ShowPlayerDraw(id, Player[id]._cityCheckHouseDraws_h[i]);
						ShowPlayerDraw(id, Player[id]._cityCheckHouseDraws_o[i]);
						local text_id = "# "..i;
						local text_owner = _HOUSE[i].owner;
						if not string.find(text_owner, "�����") then
							UpdatePlayerDraw(id, Player[id]._cityCheckHouseDraws_h[i], x, y  + 170 * k, text_id, "Font_Old_10_White_Hi.TGA", 71, 255, 172);
							UpdatePlayerDraw(id, Player[id]._cityCheckHouseDraws_o[i], x + 1000, y  + 170 * k, text_owner, "Font_Old_10_White_Hi.TGA", 71, 255, 172);
						else
							UpdatePlayerDraw(id, Player[id]._cityCheckHouseDraws_h[i], x, y  + 170 * k, text_id, "Font_Old_10_White_Hi.TGA", 166, 166, 166);
							UpdatePlayerDraw(id, Player[id]._cityCheckHouseDraws_o[i], x + 1000, y  + 170 * k, text_owner, "Font_Old_10_White_Hi.TGA", 166, 166, 166);
						end
						if _HOUSE[i] ~= nil then
							k = k + 1;
						end

					end
				end

				for i = 1, table.getn(Player[id]._cityCheckHouseDraws_title) do
					ShowPlayerDraw(id, Player[id]._cityCheckHouseDraws_title[i]);
				end

			else

				UnFreeze(id);
				Player[id]._cityCheckHouse = false;
				HideTexture(id, CITY_HOUSE_TEX);

				for i = 1, table.getn(Player[id]._cityCheckHouseDraws_h) do
					if Player[id]._cityCheckHouseDraws_h ~= nil then
						if _HOUSE[i] ~= nil then
							HidePlayerDraw(id, Player[id]._cityCheckHouseDraws_h[i]);
							HidePlayerDraw(id, Player[id]._cityCheckHouseDraws_o[i]);
						end
					end
				end

				for i = 1, table.getn(Player[id]._cityCheckHouseDraws_title) do
					HidePlayerDraw(id, Player[id]._cityCheckHouseDraws_title[i]);
				end

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "���������� ���� ����� ������ � ������ (� ����������).")
		end
	end

end
addCommandHandler({"/�����_���"}, _checkHouses);

function _cityHouseConnect(id)
	Player[id]._cityCheckHouse = false;
	Player[id]._cityCheckHouseDraws_title = {};
	Player[id]._cityCheckHouseDraws_title[1] = CreatePlayerDraw(id, 5734, 2337, "����� ����");
	Player[id]._cityCheckHouseDraws_title[2] = CreatePlayerDraw(id, 6700, 2337, "�����");

	Player[id]._cityCheckHouseDraws_h = {};
	for i = 1, table.getn(_HOUSE) do
		if _HOUSE[i] ~= nil then
			Player[id]._cityCheckHouseDraws_h[i] = CreatePlayerDraw(id, 0, 0, "");
		end
	end

	Player[id]._cityCheckHouseDraws_o = {};
	for i = 1, table.getn(_HOUSE) do
		if _HOUSE[i] ~= nil then
			Player[id]._cityCheckHouseDraws_o[i] = CreatePlayerDraw(id, 0, 0, "");
		end
	end

end

------------------------------------------------------------------------------------------------------------------------------------
function _setBanyaArrest(id, sets)

	if Player[id].astatus > 3 or CITY_GOVERNOR == Player[id].nickname then
		local cmd, arrest = sscanf(sets, "d");
		if cmd == 1 then
			if arrest == 1 then
				CITY_BANYA_ARREST = 1;
				SendMessageToAll(0, 255, 0, Player[id].nickname.." ��������� ����!")
				LogString("Logs/Admins/banya",Player[id].nickname.." ��������� ����! / ".._getRTime());
				_saveCity();

			elseif arrest == 0 then
				CITY_BANYA_ARREST = 0;
				SendMessageToAll(0, 255, 0, Player[id].nickname.." ���� ����� � ����.")
				LogString("Logs/Admins/banya",Player[id].nickname.." ���� ����� � ���� / ".._getRTime());
				_saveCity();
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/����_���� (0-1)")
		end
	end

end
addCommandHandler({"/����_����"}, _setBanyaArrest);

function _setBanyaOwner(id, sets)

	if Player[id].astatus > 3 or CITY_GOVERNOR == Player[id].nickname then
		local cmd, pid = sscanf(sets, "d");
		if cmd == 1 then
			CITY_BANYA_OWNER = Player[pid].nickname;	
			SendMessageToAll(0, 255, 0, Player[id].nickname.." �������� ������ "..GetPlayerName(pid).." ����������� ����.")
			LogString("Logs/Admins/banya",Player[id].nickname.." �������� ������ "..GetPlayerName(pid).." ����������� ���� / ".._getRTime());
			_saveCity();
		else
			SendPlayerMessage(id, 255, 255, 255, "/����_�������� (��)")
		end
	end

end
addCommandHandler({"/����_��������"}, _setBanyaOwner);

function _setBanyaPrice(id, sets)

	if Player[id].astatus > 3 or CITY_BANYA_OWNER == Player[id].nickname then
		local cmd, p = sscanf(sets, "d");
		if cmd == 1 then
			CITY_BANYA_PRICE = p;	
			SendPlayerMessage(id, 255, 255, 255, "�� ���������� ���� ������ � ���� �: "..p);
			LogString("Logs/Admins/banya",Player[id].nickname.." ��������� ���� � "..p.." ����� �� ����� � ���� / ".._getRTime());
			_saveCity();
		else
			SendPlayerMessage(id, 255, 255, 255, "/����_���� (����� �� 1 �� 30)")
		end
	end

end
addCommandHandler({"/����_����"}, _setBanyaPrice);

function _setBanyaTax(id, sets)

	if Player[id].astatus > 3 or CITY_GOVERNOR == Player[id].nickname then
		local cmd, tax = sscanf(sets, "d");
		if cmd == 1 then
			CITY_BANYA_TAX = tax;
			SendMessageToAll(0, 255, 0, Player[id].nickname.." ��������� ������� ������ � "..tax.."% ��� ����.")
			LogString("Logs/Admins/banya", Player[id].nickname.." ��������� ������� ������ � "..tax.."% ��� ���� / ".._getRTime());
			_saveCity();
		else
			SendPlayerMessage(id, 255, 255, 255, "/����_����� (����� � ���������)")
		end
	end

end
addCommandHandler({"/����_�����"}, _setBanyaTax);


function _takeBanyaCash(id, sets)

	local cmd, value = sscanf(sets, "f");
	if cmd == 1 then
		if Player[id].astatus > 3 or Player[id].nickname == CITY_BANYA_OWNER then
			local x, y, z = GetPlayerPos(id);
			if GetDistance3D(x, y, z, 5009.421875, 364.38180541992, -2422.03125) < 350 then
				if CITY_BANYA_ARREST == 0 then
					if CITY_BANYA_CASH >= value then
						CITY_BANYA_CASH = CITY_BANYA_CASH - value;
						Player[id].gold = Player[id].gold + value;
						SendPlayerMessage(id, 255, 255, 255, "�� ������� �� ����� ���� "..value.." ������� �����.")
						for i = 0, GetMaxPlayers() do
							if Player[i].astatus > 2 then
								SendPlayerMessage(i, 255, 255, 255, Player[id].nickname.." ������ �� ����� ���� "..value.." ������� �����.")
							end
						end
						_saveCity();
						SavePlayer(id);
						LogString("Logs/Admins/banya", Player[id].nickname.." ������ �� ����� ���� "..value.." ������� ����� / ".._getRTime());
					else
						SendPlayerMessage(id, 255, 255, 255, "� ���� ������� ���.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "���� ����������, ������� �������� �� ����� ������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� ������� ������ �� ���� ����� ���� ����� �������.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/����_���� (���-��)")
	end

end
addCommandHandler({"/����_����"}, _takeBanyaCash);

function _goBanya(id)

	if CITY_BANYA_ARREST == 0 then
		if Player[id].loggedIn == true then
			if Player[id].gold >= CITY_BANYA_PRICE then
				local x, y, z = GetPlayerPos(id);
				if GetDistance3D(x, y, z, 5009.421875, 364.38180541992, -2422.03125) < 350 then
					table.insert(CITY_BANYA_PLAYERS, Player[id].nickname);
					SendPlayerMessage(id, 255, 255, 255, "������: ��������� ������ (-"..CITY_BANYA_PRICE.." ������� �����).")
					Player[id].gold = Player[id].gold - CITY_BANYA_PRICE;
					SavePlayer(id);
					--------------------------------------
					local oldbalance = CITY_BANYA_CASH;
					CITY_BANYA_CASH = CITY_BANYA_CASH + CITY_BANYA_PRICE;
					local balance = CITY_BANYA_CASH;
					CITY_BANYA_CASH = CITY_BANYA_CASH - _tradersGetTax(CITY_BANYA_TAX, CITY_BANYA_PRICE); -- ��������� �����
					CITY_CASH = CITY_CASH + _tradersTaxCity(balance, oldbalance, CITY_BANYA_TAX);
					CITY_BANYA_CASH = CITY_BANYA_CASH - _tradersGetTax(CITY_BIZNES_TAX, CITY_BANYA_PRICE); -- ��������� �����
					LogString("Database/City/Tax","������ ������ � "..CITY_BANYA_TAX.."% - ".._tradersTaxCity(balance, oldbalance, CITY_BANYA_TAX).." �� ������� ������ � ���� ������� "..GetPlayerName(id).." / �������� �� ���� �� ������ � "..CITY_BIZNES_TAX.."% - ".._tradersTaxCity(balance, oldbalance, CITY_BIZNES_TAX).." / ������ ������: "..CITY_CASH.." / ����: ".._getRTime());
					_saveCity();
				else
					SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ����� �������.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "������: � ��� �� ������� ������.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "�� ���� ������� �����! ��������� �������.")
	end

end
addCommandHandler({"/�����"}, _goBanya);

local banya_down = {4880.294921875, 354.95486450195, -3280.2866210938};
local banya_up = {5125.9584960938, 753.68273925781, -2988.9272460938};

function _banyaRegen()
 
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and GetPlayerHealth(i) > 0 then
			if Player[i]._useBed == false then
				local x, y, z = GetPlayerPos(i);
				if GetDistance3D(x, y, z, banya_down[1], banya_down[2], banya_down[3]) < 600 or GetDistance3D(x, y, z, banya_up[1], banya_up[2], banya_up[3]) < 600 then

					local tick = false;
					for _, name in pairs(CITY_BANYA_PLAYERS) do
						if name == Player[i].nickname then
							tick = true;
						end
					end
	
					if tick == true then
						
						--------------------------------------------------
						local maxHp = GetPlayerMaxHealth(i);
						local hpForm = (maxHp / 100) * 3;
					
						if GetPlayerHealth(i) < maxHp then
							SetPlayerHealth(i, GetPlayerHealth(i) + hpForm);
							if GetPlayerHealth(i) > maxHp then
								SetPlayerMaxHealth(i, maxHp);
							end
							SaveStats(i);
							SavePlayer(i);
						end
						--------------------------------------------------
						local maxMp = GetPlayerMaxMana(i);
						local mpForm = (maxMp / 100) * 2;

						if GetPlayerMana(i) < maxMp then
							SetPlayerMana(i, GetPlayerMana(i) + mpForm);
							if GetPlayerMana(i) > maxMp then
								SetPlayerMaxMana(i, maxMp);
							end
							SaveStats(i);
							SavePlayer(i);
						end
						--------------------------------------------------
						GameTextForPlayer(i, 6004, 5357, "�� ������������ ������� �� � ��.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 1000);
					end
				end
			end
		end
	end
end
SetTimer(_banyaRegen, 10000, 1);
 























function _getRTime()
	time = os.date('*t');
	local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);
	return rday.."."..rmonth.."."..ryear.." "..rhour..":"..rminute;
end