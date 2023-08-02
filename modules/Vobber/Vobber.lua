
--  #     Vobber by royclapton   #
--  #         version: 0.1       #

VOBBER_USE = false; -- ������ ������������� �������
VOBBER_DEFAULT = "NC_PLANKS_V01.3DS"; -- ������� ��� (���� �������� �����).
VOBBER_CATEGORY = {}; -- �������� ��������
VOBBER_VOBS_IDS = {};

VOBBER_VOB_OBJECTS = {}; VOBBER_VOB_COUNT = 0; -- ������ ��������� ����� � �� ���-��
VOBBER_MOBSI_OBJECTS = {}; VOBBER_MOBSI_COUNT = 0; -- ������ ��������� ����� � �� ���-��


VOBBER_TEXTURES = {}; -- ������� ��������
VOBBER_TEXTURES[1] = CreateTexture(6762, 142, 8104, 2806, 'menu_ingame')
VOBBER_TEXTURES[2] = CreateTexture(4623, 185, 6786, 405, 'menu_ingame')
VOBBER_TEXTURES[3] = CreateTexture(6763, 3070, 8107, 3490, 'menu_ingame') -- create
VOBBER_TEXTURES[4] = CreateTexture(6763, 3770, 8107, 4190, 'menu_ingame') -- save
VOBBER_TEXTURES[5] = CreateTexture(6763, 4470, 8107, 4890, 'menu_ingame') -- collision

function _vobberInit() -- ������������� ��������
	
	print(" ");
	print(" VOBBER LOAD....")
	-- ��������� ���� �� ������ (�������)
	local file = io.open("modules/Vobber/VobberBase/Objects/Vob_objs.txt", "r");
	if file then -- ���� ���� ������, ���������� ���������� ���� ����� � ��������.
		for line in file:lines() do
			local result, visual, x, y, z, r1, r2, r3, col, world  = sscanf(line, "sffffffds");
			if result == 1 then
				VOBBER_VOB_COUNT = VOBBER_VOB_COUNT + 1;
				VOBBER_VOB_OBJECTS[line] = Vob.Create(visual, world, x, y, z);
				Vob.SetRotation(VOBBER_VOB_OBJECTS[line], r1, r2, r3);
				Vob.SetCollision(VOBBER_VOB_OBJECTS[line], col);
			end
		end
		file:close();

	else -- ���� ���� �� ������, �� ���������.
		print("Cannot to open VobberBase/Objects/Vob_objs.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Objects/Vob_objs.txt", "w");
		fileW:close();
	end

	-----------------------------------------------------------------------------------

	-- ��������� ����� �� ������ (�������)
	local file = io.open("modules/Vobber/VobberBase/Objects/Mobsi_objs.txt", "r");
	if file then
		for line in file:lines() do
			local result, a = sscanf(line, "s");
			if result == 1 then
				--
			end
		end
		file:close();
	else -- ���� ���� �� ������, �� ���������.
		print("Cannot to open VobberBase/Objects/Mobsi_objs.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Objects/Mobsi_objs.txt", "w");
		fileW:close();
	end

	-- #######################################################################################

	-- ��������� ����������� ��������� (������)
	local file = io.open("modules/Vobber/VobberBase/Category/List.txt", "r");
	if file then
		for line in file:lines() do
			local result, list = sscanf(line, "s");
			if result == 1 then
				table.insert(VOBBER_CATEGORY, list);
			end
		end
		file:close();
	else -- ���� ���� �� ������, �� ���������.
		print("Cannot to open VobberBase/Category/List.txt (nil). File recreated.")
		local fileW = io.open("modules/Vobber/VobberBase/Category/List.txt", "w");
		fileW:close();
	end

	print(" VOBS LOAD: "..VOBBER_VOB_COUNT.." / MOBSI LOAD: "..VOBBER_MOBSI_COUNT);
	print(" Vobber load ");



end

function _vobberConnect(id) -- � OnPlayerConnect:

	-- other
	Player[id]._vober_open = false; -- �������� �� ���������� �������
	Player[id]._vober_type = "none"; -- ���������� ������� ��� ����� ����� (vob / mobsi / none)
	Player[id]._vober_timer = nil;
	Player[id]._vober_draws = {}; -- �����
	Player[id]._vober_draws[1] = CreatePlayerDraw(id, 4860, 204, ""); -- �������� ����
	Player[id]._vober_draws[2] = CreatePlayerDraw(id, 6854, 204, ""); -- ���� ����:
	Player[id]._vober_draws[3] = CreatePlayerDraw(id, 6854, 404, ""); -- ����. ��������:
	Player[id]._vober_draws[4] = CreatePlayerDraw(id, 6854, 604, ""); -- ����. ��������:
	Player[id]._vober_draws[5] = CreatePlayerDraw(id, 6854, 804, ""); -- ���������: 
	Player[id]._vober_draws[6] = CreatePlayerDraw(id, 6854, 1004, ""); -- id � ������: 
	Player[id]._vober_draws[7] = CreatePlayerDraw(id, 6854, 1204, ""); -- ��������: 
	Player[id]._vober_draws[8] = CreatePlayerDraw(id, 6854, 1204, ""); -- ����� 
	Player[id]._vober_draws[9] = CreatePlayerDraw(id, 7175, 3186, "�������"); -- �������
	Player[id]._vober_draws[10] = CreatePlayerDraw(id, 7255, 3884, "SAVE");
	Player[id]._vober_draws[11] = CreatePlayerDraw(id, 7175, 4582, "���-���");

	-- list
	Player[id]._vober_category = ""; -- ��������� ���������
	Player[id]._vober_category_n = 0; -- ��������� ��������� (�����)
	Player[id]._vober_cid = 0; -- ��������� ��� � ������ ���������

	-- main vars
	Player[id]._vober_vob = nil; -- ������� ������
	Player[id]._vober_speedmove = 0; -- �������� ��������
	Player[id]._vober_speedrotate = 0; -- �������� ��������
	Player[id]._vober_collision = 1; -- ������ ��������
	Player[id]._vober_current_id = 0; -- ���� �������
	Player[id]._vober_visual = ""; -- �������� ������
	Player[id]._vober_pos = {}; -- ������� ��������� �������
	Player[id]._vober_rotate = {}; -- ������� ������� �������

	-- mobsi
	Player[id]._vober_scheme = nil; -- ����� �����
	Player[id]._vober_obj_name = nil; -- ��� ������� (����: BED / CHEST etc)
	Player[id]._vober_withItem = nil; -- � ����� ��������� ����� ������������

	-- control
	Player[id]._vober_type = 0;
	Player[id]._vober_W = 0; -- ������
	Player[id]._vober_S = 0; -- �����
	Player[id]._vober_A = 0; -- �����
	Player[id]._vober_D = 0; -- ������
	Player[id]._vober_Q = 0; -- �����
	Player[id]._vober_E = 0; -- ����

end

function _vobberDefault(id) -- ������ �������������� ��������� (�� �������)

	Player[id]._vober_open = true; -- ���������� ������
	Player[id]._vober_speedmove = 5; -- ��������� �������� ��������
	Player[id]._vober_speedrotate = 5; -- ��������� �������� ��������
	Player[id]._vober_collision = 1; -- ��������� ������������� �������� (�������� ������������)
	Player[id]._vober_cid = 1; -- ���������� ��������� ����� �������
	Player[id]._vober_type = 1; -- ������ ����� ��������.

end

function _vobberEnd(id) -- �������� ��� ����������
	
	Player[id]._vober_open = false;
	Player[id]._vober_vob = nil;
	Player[id]._vober_type = "none";
	Player[id]._vober_category = "";
	Player[id]._vober_category_n = 0;
	Player[id]._vober_cid = 0;
	Player[id]._vober_speedmove = 0;
	Player[id]._vober_speedrotate = 0;
	Player[id]._vober_collision = 1;
	Player[id]._vober_current_id = 0;
	Player[id]._vober_visual = "";
	Player[id]._vober_pos = {};
	Player[id]._vober_rotate = {};
	Player[id]._vober_scheme = nil;
	Player[id]._vober_obj_name = nil;
	Player[id]._vober_withItem = nil;
	Player[id]._vober_type = 0;

end

function _voberUpdateDraw(id) -- ��������� ����� �� ���� �������������

	UpdatePlayerDraw(id, Player[id]._vober_draws[1],  4660, 204, string.lower(Player[id]._vober_visual), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._vober_draws[2],  6854, 204, string.format("%s%d", "ID: ", Player[id]._vober_current_id), "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	UpdatePlayerDraw(id, Player[id]._vober_draws[3],  6854, 404, string.format("%s%d", "����. ��������: ",Player[id]._vober_speedmove), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- ����. ��������:
	UpdatePlayerDraw(id, Player[id]._vober_draws[4],  6854, 604, string.format("%s%d", "����: ��������: ", Player[id]._vober_speedrotate), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- ����. ��������:
	UpdatePlayerDraw(id, Player[id]._vober_draws[5],  6854, 804, string.format("%s%s", "���������: ",Player[id]._vober_category), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- ���������: 
	UpdatePlayerDraw(id, Player[id]._vober_draws[6],  6854, 1004, string.format("%s%d", "ID � ���-�: ", Player[id]._vober_cid), "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- ID � ������: 

	if Player[id]._vober_collision == 1 then
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1204, "��������: ��", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	else
		UpdatePlayerDraw(id, Player[id]._vober_draws[7],  6854, 1204, "��������: ���", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

	if Player[id]._vober_type == 1 then
		UpdatePlayerDraw(id, Player[id]._vober_draws[8],  6854, 1404, "�����: ��������", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif Player[id]._vober_type == 2 then
		UpdatePlayerDraw(id, Player[id]._vober_draws[8],  6854, 1404, "�����: ��������", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	end

end

function _vobberOpen(id) -- ������ ������ � ��������
	
	if Player[id].astatus > 4 then
		if Player[id]._vober_open == false then -- ���� ������ ��������
			if VOBBER_USE == false then -- ������ ��������, ���������� �� ������ ���-�� � ������ ������

				VOBBER_USE = true; -- ������������� ������ ������ �������.
				_vobberDefault(id); -- ������ ������� ���������
				SetCursorVisible(id, 1); -- �������� ������
				SetPlayerScale(id, 0, 0, 0); -- ������� ����������� ������ �������� (� �.�. ������� ��������� ����� ������� FreezePlayer) + ������ ������������
				FreezePlayer(id, 1); -- ������������ ������������.
				Player[id]._vober_timer = SetTimerEx(_voberMove, 50, 1, id); -- ��������� ������ �� ��������
				ShowChat(id, 0); -- ������ ���

				for i = 1, table.getn(VOBBER_TEXTURES) do -- ���������� ������ ��������
					ShowTexture(id, VOBBER_TEXTURES[i]);
				end

				for i = 1, table.getn(Player[id]._vober_draws) do -- ���������� ������ �����
					ShowPlayerDraw(id, Player[id]._vober_draws[i]);
				end

				_voberUpdateDraw(id);
			else
				SendPlayerMessage(id, 255, 255, 255, "(VOBBER) ���-�� ��� ���������� ������������.")
			end

		else

			VOBBER_USE = false; -- ������������� ������ ������ �������.
			VOBBER_VOBS_IDS = {}; -- ���������� ������ �����
			_vobberEnd(id); -- ���������� �������� ����������
			SetCursorVisible(id, 0); -- ��������� ������
			SetPlayerScale(id, 1, 1, 1); -- �������� ����������� ��������
			FreezePlayer(id, 0); -- ������������� ������������
			SetDefaultCamera(id); -- ���������� ������ ������
			ShowChat(id, 1); -- �������� ���
			if Player[id]._vober_timer ~= nil then
				KillTimer(Player[id]._vober_timer); -- ������� ������
				Player[id]._vober_timer = nil;
			end


			for i = 1, table.getn(VOBBER_TEXTURES) do -- ���������� ������ ��������
				HideTexture(id, VOBBER_TEXTURES[i]);
			end

			for i = 1, table.getn(Player[id]._vober_draws) do -- ���������� ������ �����
				HidePlayerDraw(id, Player[id]._vober_draws[i]);
			end
		end
	end
end
addCommandHandler({"/vobber", "/������"}, _vobberOpen);

function _vobberCreate(id) -- �������� ������ �������

	local x, y, z = GetPlayerPos(id); -- �������� ������� ������
	local world = GetPlayerWorld(id); -- �������� ��� ������
	Player[id]._vober_pos = {x, y + 100, z}; -- ���������� ���������� �������

	if table.getn(VOBBER_CATEGORY) < 1 then -- ���� ��������� ��� - ������� ������� ���
		Player[id]._vober_visual = VOBBER_DEFAULT;
		Player[id]._vober_vob = Vob.Create(VOBBER_DEFAULT, world, x, y + 100, z);
		if table.getn(VOBBER_VOBS_IDS) > 0 then
			Player[id]._vober_current_id = table.getn(VOBBER_VOBS_IDS) + 1;
		else
			Player[id]._vober_current_id = 1;
		end
		_voberUpdateDraw(id);
	else
		Player[id]._vober_vob = Vob.Create(" ", world, x, y + 100, z);
		if Player[id]._vober_category_n == 0 then -- ���� ��������� ����� == 0, �� ������� ��� 1.
			Player[id]._vober_category_n = 1;
		end
		local c_n = Player[id]._vober_category_n; -- ���������� ����� � ���������� ��� ��������� �����
		Player[id]._vober_category = VOBBER_CATEGORY[c_n];
		
		local file = io.open("modules/Vobber/VobberBase/Category/"..VOBBER_CATEGORY[c_n]..".txt", "r"); -- ��������� ���� �� ������� (��������) �� ������ ���������
		if file then
			local i = 1;
			for line in file:lines() do
				local result, vob = sscanf(line, "s");
				if result == 1 then
					if Player[id]._vober_cid == i then
						Player[id]._vober_cid = i;
						Vob.SetVisual(Player[id]._vober_vob, vob);
						Player[id]._vober_visual = string.lower(vob);
						_voberUpdateDraw(id);
						break
					else
						i = i + 1;
					end
				end
			end
			file:close();
		else
			print("Cannot loading list #"..c_n.."! ERROR!");
		end


	end

	SetCameraBehindVob(id, Player[id]._vober_vob);

end

function _vobberKey(id, down, up) -- ������ �� �������

	if Player[id]._vober_open == true and Player[id]._vober_vob ~= nil then

		if down == KEY_Z then
			LogString("ship", Player[id]._vober_pos[1].." "..Player[id]._vober_pos[2].." "..Player[id]._vober_pos[3])
			SendPlayerMessage(id, 255, 255, 255, Player[id]._vober_pos[1].." "..Player[id]._vober_pos[2].." "..Player[id]._vober_pos[3])
		end

		-- ����������� + �������

		-- ������������ �������

		if down == KEY_1 then
			Player[id]._vober_type = 1;
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "������ ����� ��������!", "Font_Old_10_White_Hi.TGA", 255, 110, 110, 500)
		end

		if down == KEY_2 then
			Player[id]._vober_type = 2;
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "������ ����� ��������!", "Font_Old_10_White_Hi.TGA", 255, 110, 110, 500)
		end


		-- ��������

		-- ���� ������ ����������
		if down == KEY_W then
			Player[id]._vober_W = 1;
		end

		if down == KEY_S then
			Player[id]._vober_S = 1;
		end

		if down == KEY_A then
			Player[id]._vober_A = 1;
		end

		if down == KEY_D then
			Player[id]._vober_D = 1;
		end

		if down == KEY_Q then
			Player[id]._vober_Q = 1;
		end

		if down == KEY_E then
			Player[id]._vober_E = 1;
		end

		-- ���� ������ ���������
		if up == KEY_W then
			Player[id]._vober_W = 0;
		end

		if up == KEY_S then
			Player[id]._vober_S = 0;
		end

		if up == KEY_A then
			Player[id]._vober_A = 0;
		end

		if up == KEY_D then
			Player[id]._vober_D = 0;
		end

		if up == KEY_Q then
			Player[id]._vober_Q = 0;
		end

		if up == KEY_E then
			Player[id]._vober_E = 0;
		end

		-- ##########################################
		-- ��������

		if down == KEY_LEFT then

			if table.getn(VOBBER_CATEGORY) > 0 then
				local count = table.getn(VOBBER_CATEGORY);
				if Player[id]._vober_category_n ~= 0 then
					Player[id]._vober_category_n = Player[id]._vober_category_n - 1;
					if Player[id]._vober_category_n == 0 then
						Player[id]._vober_category_n = 1;
					end
					Player[id]._vober_cid = 1;
					local cid = Player[id]._vober_category_n; Player[id]._vober_category = VOBBER_CATEGORY[cid];
					_voberUpdateDraw(id);
					_vobberUpdateObject(id);
					GameTextForPlayer(id, 2224, 203, "������� ��������.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
				end
			end


		end

		if down == KEY_RIGHT then

			if table.getn(VOBBER_CATEGORY) > 0 then
				local count = table.getn(VOBBER_CATEGORY);
				if Player[id]._vober_category_n < count then
					Player[id]._vober_category_n = Player[id]._vober_category_n + 1;
					Player[id]._vober_cid = 1;
					local cid = Player[id]._vober_category_n; Player[id]._vober_category = VOBBER_CATEGORY[cid];
					_voberUpdateDraw(id);
					_vobberUpdateObject(id);
					GameTextForPlayer(id, 2224, 203, "������� ��������.", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
				end
			end

		end

		-- ##########################################
		-- �������

		if down == KEY_UP then

			if Player[id]._vober_cid > 0 then
				Player[id]._vober_cid = Player[id]._vober_cid - 1;
				if Player[id]._vober_cid == 0 then
					Player[id]._vober_cid = 1;
				end
			end
			_vobberUpdateObject(id);
			_voberUpdateDraw(id);

		end


		if down == KEY_DOWN then

			local oldVisual = Player[id]._vober_visual;
			Player[id]._vober_cid = Player[id]._vober_cid + 1;
			_vobberUpdateObject(id);
			_voberUpdateDraw(id);

			if oldVisual == Player[id]._vober_visual then
				Player[id]._vober_cid = 1;
				_vobberUpdateObject(id);
				_voberUpdateDraw(id);
			end

		end

		-- ##########################################
		-- ��������

		-- �������� ��������
		if down == KEY_MINUS then
			Player[id]._vober_speedmove = Player[id]._vober_speedmove - 1;
			if Player[id]._vober_speedmove < 1 then
				Player[id]._vober_speedmove = 1;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "�������� �������� ���������", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end


		if down == KEY_EQUALS then
			Player[id]._vober_speedmove = Player[id]._vober_speedmove + 1;
			if Player[id]._vober_speedmove > 50 then
				Player[id]._vober_speedmove = 50;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "�������� �������� ���������", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end

		-- �������� ��������
		if down == KEY_COMMA then
			Player[id]._vober_speedrotate = Player[id]._vober_speedrotate - 1;
			if Player[id]._vober_speedrotate < 1 then
				Player[id]._vober_speedrotate = 1;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "�������� �������� ���������", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end


		if down == KEY_PERIOD then
			Player[id]._vober_speedrotate = Player[id]._vober_speedrotate + 1;
			if Player[id]._vober_speedrotate > 10 then
				Player[id]._vober_speedrotate = 10;
			end
			_voberUpdateDraw(id);
			GameTextForPlayer(id, 2224, 203, "�������� �������� ���������", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
		end

	end

end

function _vobberUpdateObject(id) -- ��������� ������ ��� ������������

	local c_n = Player[id]._vober_category_n; -- ���������� ����� � ���������� ��� ��������� �����
	local file = io.open("modules/Vobber/VobberBase/Category/"..VOBBER_CATEGORY[c_n]..".txt", "r"); -- ��������� ���� �� ������� (��������) �� ������ ���������
	if file then
		local i = 1;
		for line in file:lines() do
			local result, vob = sscanf(line, "s");
			if result == 1 then
				if Player[id]._vober_cid == i then
					newVisual = Player[id]._vober_visual;
					Player[id]._vober_visual = vob;
					Vob.SetVisual(Player[id]._vober_vob, vob);
					_voberUpdateDraw(id);
					GameTextForPlayer(id, 2224, 203, "������ ����������! ����������..", "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
					break
				else
					i = i + 1;
				end
			end
		end
		file:close();
	end

end 

function _voberMove(id)

	local speedMove = Player[id]._vober_speedmove * 20;
	local speedRot  = Player[id]._vober_speedrotate * 5;

	if Player[id]._vober_type == 1 then -- ���� ������� ����� "��������"

		if Player[id]._vober_W == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x + Player[id]._vober_speedmove * _sin;
			z = z + Player[id]._vober_speedmove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._vober_pos = {x, y, z};
		end

		if Player[id]._vober_S == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			local x, y, z = vob:GetPosition();
			local _sin = math.sin(math.rad(r_y));
			local _cos = math.cos(math.rad(r_y));
			local v_x, v_y, v_z = vob:GetPosition()
			x = x - Player[id]._vober_speedmove * _sin;
			z = z - Player[id]._vober_speedmove * _cos;
			vob:SetPosition(x, y, z);
			Player[id]._vober_pos = {x, y, z};
		end

		if Player[id]._vober_A == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y - speedRot, r_z);
			Player[id]._vober_rotate = {r_x, r_y - speedRot, r_z}
		end

		if Player[id]._vober_D == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation()
			local v_x,v_y,v_z = vob:GetPosition()
			vob:SetRotation(r_x, r_y + speedRot, r_z);
			Player[id]._vober_rotate = {r_x, r_y + speedRot, r_z}
		end

		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)

	elseif Player[id]._vober_type == 2 then -- ���� ������� ����� "��������"

		if Player[id]._vober_W == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x + speedRot / 5, r_y, r_z);
		end

		if Player[id]._vober_S == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x - speedRot / 5, r_y, r_z);
		end

		if Player[id]._vober_A == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z + speedRot / 5);

		end

		if Player[id]._vober_D == 1 then
			local vob = Player[id]._vober_vob;
			local r_x, r_y, r_z = vob:GetRotation();
			vob:SetRotation(r_x, r_y, r_z - speedRot / 5);
		end

	end

	if Player[id]._vober_Q == 1 then
		local vob = Player[id]._vober_vob;
		local x, y, z = vob:GetPosition();
		vob:SetPosition(x, y + speedRot, z);
		Player[id]._vober_pos = {x, y + speedRot, z};
		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
	end

	if Player[id]._vober_E == 1 then
		local vob = Player[id]._vober_vob;
		local x, y, z = vob:GetPosition();
		vob:SetPosition(x, y - speedRot, z);
		Player[id]._vober_pos = {x, y - speedRot, z};
		local text = string.format("%s %s %s", Player[id]._vober_pos[1], Player[id]._vober_pos[2], Player[id]._vober_pos[3]);
		GameTextForPlayer(id, 2224, 203, text, "Font_Old_10_White_Hi.TGA", 255, 255, 255, 400)
	end

	

end

function _saveCurrentVob(id)

	if Player[id]._vober_vob ~= nil then
		local file = io.open("modules/Vobber/VobberBase/Objects/Vob_objs.txt", "a+");
		file:write(Player[id]._vober_visual.." "..Player[id]._vober_pos[1].." "..Player[id]._vober_pos[2].." "..Player[id]._vober_pos[3]..
				" "..Player[id]._vober_rotate[1].." "..Player[id]._vober_rotate[2].." "..Player[id]._vober_rotate[3].." "..Player[id]._vober_collision
					.." "..GetPlayerWorld(id).."\n");
		file:close();
		_vobberCreate(id);
		SendPlayerMessage(id, 255, 255, 255, "������ ��������.")
		LogString("Logs/Admins/Vobber", Player[id].nickname.." ������ ��� "..Player[id]._vober_visual.." / ".._getRTime())
	end

end

function _setVobColl(id)

	if Player[id]._vober_vob ~= nil then
		if Player[id]._vober_collision == 1 then
			Player[id]._vober_collision = 0;
			_voberUpdateDraw(id);
			Vob.SetCollision(Player[id]._vober_vob, 0); 
		else
			Player[id]._vober_collision = 1
			_voberUpdateDraw(id);
			Vob.SetCollision(Player[id]._vober_vob, 1); 
		end
	end

end

function _vobberMouse(id, button, pressed, posX, posY) -- ������ �� �����

	if Player[id]._vober_open == true then

		if button == MB_LEFT then
			if pressed == 0 then

				if posX > 3553 and posX < 8107 and posY > 3070 and posY < 3490 then -- ������ "�������"
					_vobberCreate(id);
				end

				if posX > 3553 and posX < 8107 and posY > 3770 and posY < 4190 then -- ������ "SAVE"
					_saveCurrentVob(id);
				end

				if posX > 3553 and posX < 8107 and posY > 4470 and posY < 4890 then -- ������ "COL-ON"
					_setVobColl(id);
				end

			end
		end
	end
end
