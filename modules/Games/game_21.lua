
--  #   21_game  by royclapton   #
--  #       version: 1.0         #

-- �������� ��� ���� ������.
game21_cards_up = {}
game21_cards_up[1] = {1710, 530, 2610, 2745};
game21_cards_up[2] = {2545, 530, 3445, 2745};
game21_cards_up[3] = {3380, 530, 4280, 2745};
game21_cards_up[4] = {4215, 530, 5115, 2745};
game21_cards_up[5] = {5050, 530, 5950, 2745};
game21_cards_up[6] = {5885, 530, 6785, 2745};

-- x ������� = 900 __ 65
-- y ������� = 2230

-- �������� ��� ���� �����.
game21_cards_down = {}
game21_cards_down[1] = {1710, 5345, 2610, 7575};
game21_cards_down[2] = {2545, 5345, 3445, 7575};
game21_cards_down[3] = {3380, 5345, 4280, 7575};
game21_cards_down[4] = {4215, 5345, 5115, 7575};
game21_cards_down[5] = {5050, 5345, 5950, 7575};
game21_cards_down[6] = {5885, 5345, 6785, 7575};

-- �������� ����������
local game21_background = CreateTexture(1394, 407, 7137, 7697, 'dlg_conversation')
local game21_playertwo = CreateTexture(1600, 5297, 6915, 7626, 'menu_ingame')
local game21_playerone = CreateTexture(1600, 460, 6915, 2794, 'menu_ingame')

-- �������� ������
game21_buttons_tex = {};
game21_buttons_tex[1] = CreateTexture(1645, 2950, 2685, 3500, 'menu_ingame')
game21_buttons_tex[2] = CreateTexture(1645, 3650, 2685, 4200, 'menu_ingame')
game21_buttons_tex[3] = CreateTexture(1645, 4350, 2685, 4900, 'menu_ingame')
-- y - 150; + 550;

-- ���������� ������
game21_buttons_xyz = {};
game21_buttons_xyz[1] = {1645, 2685, 2950, 3500};
game21_buttons_xyz[2] = {1645, 2685, 3650, 4200};
game21_buttons_xyz[3] = {1645, 2685, 4350, 4900};



function _21game_InitTexCards(id) -- ������� ������� ��� ������������ ����.

	Player[id]._21game_texdown = {};
	Player[id]._21game_texdown[1] = CreateTexture(game21_cards_down[1][1], game21_cards_down[1][2], game21_cards_down[1][3], game21_cards_down[1][4], '')
	Player[id]._21game_texdown[2] = CreateTexture(game21_cards_down[2][1], game21_cards_down[2][2], game21_cards_down[2][3], game21_cards_down[2][4], '')
	Player[id]._21game_texdown[3] = CreateTexture(game21_cards_down[3][1], game21_cards_down[3][2], game21_cards_down[3][3], game21_cards_down[3][4], '')
	Player[id]._21game_texdown[4] = CreateTexture(game21_cards_down[4][1], game21_cards_down[4][2], game21_cards_down[4][3], game21_cards_down[4][4], '')
	Player[id]._21game_texdown[5] = CreateTexture(game21_cards_down[5][1], game21_cards_down[5][2], game21_cards_down[5][3], game21_cards_down[5][4], '')
	Player[id]._21game_texdown[6] = CreateTexture(game21_cards_down[6][1], game21_cards_down[6][2], game21_cards_down[6][3], game21_cards_down[6][4], '')

	Player[id]._21game_texup = {};
	Player[id]._21game_texup[1] = CreateTexture(game21_cards_up[1][1], game21_cards_up[1][2], game21_cards_up[1][3], game21_cards_up[1][4], '')
	Player[id]._21game_texup[2] = CreateTexture(game21_cards_up[2][1], game21_cards_up[2][2], game21_cards_up[2][3], game21_cards_up[2][4], '')
	Player[id]._21game_texup[3] = CreateTexture(game21_cards_up[3][1], game21_cards_up[3][2], game21_cards_up[3][3], game21_cards_up[3][4], '')
	Player[id]._21game_texup[4] = CreateTexture(game21_cards_up[4][1], game21_cards_up[4][2], game21_cards_up[4][3], game21_cards_up[4][4], '')
	Player[id]._21game_texup[5] = CreateTexture(game21_cards_up[5][1], game21_cards_up[5][2], game21_cards_up[5][3], game21_cards_up[5][4], '')
	Player[id]._21game_texup[6] = CreateTexture(game21_cards_up[6][1], game21_cards_up[6][2], game21_cards_up[6][3], game21_cards_up[6][4], '')


end


function _21game_var(id) -- � OnPlayerConnect

	Player[id]._21game_play = false;
	Player[id]._21game_invite = {0, nil};
	Player[id]._21game_pos = 0;
	Player[id]._21game_enemy = nil;
	Player[id]._21game_score = {};
	Player[id]._21game_block = false;
	Player[id]._21game_turn = nil;
	Player[id]._21game_texup = {};
	Player[id]._21game_texdown = {};
	Player[id]._21game_cards = {

		"a6", "a7", "a8", "a9", "a10", "a3", "a4", "a5", "a11",
		"b6", "b7", "b8", "b9", "b10", "b3", "b4", "b5", "b11",
		"c6", "c7", "c8", "c9", "c10", "c3", "c4", "c5", "c11",
		"d6", "d7", "d8", "d9", "d10", "d3", "d4", "d5", "d11"


	};

	Player[id]._21game_draws = {};

end

function _21game_startGame(id) -- ������� ������ ����.

	ShowChat(id, 0);


	Player[id]._21game_play = true;
	Player[id]._21game_pos = Player[id]._21game_invite[1];
	Player[id]._21game_enemy = Player[id]._21game_invite[2];

	if Player[id]._21game_invite[1] == 1 then
		Player[id]._21game_turn = GetPlayerName(id);
	else
		Player[id]._21game_turn = GetPlayerName(Player[id]._21game_invite[2]);
	end

	-- buttons
	Player[id]._21game_draws[1] = CreatePlayerDraw(id, 1915, 3014, "�����", "Font_Old_20_White_Hi.TGA", 255, 255, 255); -- button 1
	Player[id]._21game_draws[4] = CreatePlayerDraw(id, 1867, 3740, "������", "Font_Old_20_White_Hi.TGA", 255, 255, 255); -- button 2
	Player[id]._21game_draws[5] = CreatePlayerDraw(id, 2000, 4433, "���", "Font_Old_20_White_Hi.TGA", 255, 255, 255); -- button 3
	-- names
	Player[id]._21game_draws[2] = CreatePlayerDraw(id, 5778, 2756, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255); -- nick up
	Player[id]._21game_draws[3] = CreatePlayerDraw(id, 5778, 4916, "", "Font_Old_20_White_Hi.TGA", 255, 255, 255); -- nick down

	local txt = string.format("%s%d", "����� ����� ����: ", _21game_CardsValue(id));
	Player[id]._21game_draws[6] = CreatePlayerDraw(id, 3010, 3020, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- value
	local txt = string.format("%s%s", "������� ���: ", _21game_GetTurn(id));
	Player[id]._21game_draws[7] = CreatePlayerDraw(id, 3010, 3220, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255); -- amount

	_21game_InitTexCards(id);

	_21game_updateTexCards(id);
	_21game_updateNames(id);

	SetCursorVisible(id, 1);
	Freeze(id);
	FreezeCamera(id, 1);

	ShowTexture(id, game21_background);
	ShowTexture(id, game21_playerone);
	ShowTexture(id, game21_playertwo);

	-- �������� ������
	for i = 1, table.getn(game21_buttons_tex) do
		ShowTexture(id, game21_buttons_tex[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_draws) do
		ShowPlayerDraw(id, Player[id]._21game_draws[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_texdown) do
		ShowTexture(id, Player[id]._21game_texdown[i]);
	end

	-- ����� ������
	for i = 1, table.getn(Player[id]._21game_texup) do
		ShowTexture(id, Player[id]._21game_texup[i]);
	end

end

function _21game_CardsValue(id) -- ������� ��� �������� ���� � ������.

	local value = 0;

	if table.getn(Player[id]._21game_score) > 0 then

		for i, v in pairs(Player[id]._21game_score) do
			if type(v) == "string" then
				local match = string.match(v, "%d+");
				value = value + match;
			end
		end

		return value;
	end
	return 0;

end

function _21game_CardsAmount(id) -- ������� ��� ����������� ���-�� ���� � ������.

	local value = 0;

	if table.getn(Player[id]._21game_score) > 0 then

		for _ in pairs(Player[id]._21game_score) do
			value = value + 1;
		end

		return value;
	end
	return 0;

end

function _21game_GetTurn(id) -- ������� ���������� ����, ��� ������ �����
	return Player[id]._21game_turn;
end

function _21game_updateDrawTurn(id) -- ������� ���������� ����� ����.

	local txt = string.format("%s%s", "������� ���: ", _21game_GetTurn(id)); 
	UpdatePlayerDraw(id, Player[id]._21game_draws[7], 3010, 3220, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end

function _21game_updateDrawValueCards(id) -- ������� ���������� ����� �����.

	local txt = string.format("%s%d", "����� ����� ����: ", _21game_CardsValue(id));
	UpdatePlayerDraw(id, Player[id]._21game_draws[6], 3010, 3020, txt, "Font_Old_10_White_Hi.TGA", 255, 255, 255);

end

function _21game_updateNames(id) -- ������� ���������� ����� �������.

	local nick_my = GetPlayerName(id);
	local nick_enemy = GetPlayerName(Player[id]._21game_enemy);

	if Player[id]._21game_pos == 1 then

		UpdatePlayerDraw(id, Player[id]._21game_draws[2], 5778, 2756, nick_my, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._21game_draws[3], 5778, 4916, nick_enemy, "Font_Old_20_White_Hi.TGA", 255, 255, 255);

	elseif Player[id]._21game_pos == 2 then

		UpdatePlayerDraw(id, Player[id]._21game_draws[2], 5778, 2756, nick_enemy, "Font_Old_20_White_Hi.TGA", 255, 255, 255);
		UpdatePlayerDraw(id, Player[id]._21game_draws[3], 5778, 4916, nick_my, "Font_Old_20_White_Hi.TGA", 255, 255, 255);

	end


end

function _21game_updateTexCards(id) -- ������� ���������� ���� �� ������.
	

	if Player[id]._21game_pos == 1 then
		local p1_cards = table.getn(Player[id]._21game_score);

		if p1_cards > 0 then

			for i = 1, p1_cards do
				UpdateTexture(Player[id]._21game_texup[i], game21_cards_up[i][1], game21_cards_up[i][2], game21_cards_up[i][3], game21_cards_up[i][4], Player[id]._21game_score[i]);
			end

		end

		local pid = Player[id]._21game_enemy;
		local p2_cards = table.getn(Player[pid]._21game_score);

		if p2_cards > 0 then

			for i = 1, p2_cards do
				UpdateTexture(Player[id]._21game_texdown[i], game21_cards_down[i][1], game21_cards_down[i][2], game21_cards_down[i][3], game21_cards_down[i][4], 'a_empty');
			end

		end

	elseif Player[id]._21game_pos == 2 then

		local pid = Player[id]._21game_enemy;
		local p1_cards = table.getn(Player[pid]._21game_score);

		if p1_cards > 0 then

			for i = 1, p1_cards do
				UpdateTexture(Player[id]._21game_texup[i], game21_cards_up[i][1], game21_cards_up[i][2], game21_cards_up[i][3], game21_cards_up[i][4], 'a_empty');
			end

		end

		local p2_cards = table.getn(Player[id]._21game_score);

		if p2_cards > 0 then

			for i = 1, p2_cards do
				UpdateTexture(Player[id]._21game_texdown[i], game21_cards_down[i][1], game21_cards_down[i][2], game21_cards_down[i][3], game21_cards_down[i][4], Player[id]._21game_score[i]);
			end

		end

	end

end

function _21game_refreshTurn(id) -- ������� ��� ���������� ���.

	if Player[id]._21game_turn == GetPlayerName(id) then

		local pid = Player[id]._21game_enemy;

		Player[id]._21game_turn = GetPlayerName(pid);
		Player[pid]._21game_turn = GetPlayerName(pid);

		_21game_gameText(id, "��� ��������.", 255, 255, 255, 1000);
		_21game_gameText(pid, "��� ��������.", 255, 255, 255, 1000);
	end


end

function _21game_randomCard(id) -- ������� ���������� ����� � ������������ �����

	local currentcards = table.getn(Player[id]._21game_cards); -- �������� ���-�� ���� � ������
	local random_card = math.random(1, currentcards); -- �������� ����� ���.
	local pid = Player[id]._21game_enemy; -- �� ����������.

	----------------------------------------------------
	-- ����� 1
	table.insert(Player[id]._21game_score, Player[id]._21game_cards[random_card]); -- ��������� ������ �����.
	table.remove(Player[id]._21game_cards, random_card); -- ������� �� ������� ����� ���� ������������� �����.
	----------------------------------------------------
	-- ����� 2
	table.remove(Player[pid]._21game_cards, random_card); -- ������� �� ������� ����� ���� ������������� �����.
	----------------------------------------------------

	_21game_updateTexCards(id); -- ��������� �����.

	local pid = Player[id]._21game_enemy;
	_21game_updateTexCards(pid);

	if Player[pid]._21game_block == false then 
		_21game_refreshTurn(id); -- ������ ���.
		_21game_updateDrawTurn(id); -- ��������� ���� � ����.
		_21game_updateDrawTurn(pid); -- ��������� ���� � ����.
	end

	_21game_updateDrawValueCards(id) -- ��������� ����� ���� � ������, ������� ���� �����.

	--[[for i = 0, GetMaxPlayers() do
		if GetDistancePlayers(id, i) <= 600 then
			SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." ���� ����� �� ������. ");         
		end
	end]]


end

function _21game_gameText(id, text, r, g, b, time) -- ����������� ����� ��� ������.
	
	if time then
		GameTextForPlayer(id, 3010, 4688, text, "Font_Old_10_White_Hi.TGA", r, g, b, time);
	else
		GameTextForPlayer(id, 3010, 4688, text, "Font_Old_10_White_Hi.TGA", r, g, b, 1500);
	end
end

function _21game_takeCard(id) -- ������� ������ "�����"

	if Player[id]._21game_turn == GetPlayerName(id) then
		if table.getn(Player[id]._21game_score) < 6 then
			_21game_randomCard(id);

			if GetPlayerAnimationID(id) == 631 or GetPlayerAnimationID(id) == 343 or GetPlayerAnimationID(id) == 277 or  GetPlayerAnimationID(id) == 679 then
			else
				PlayAnimation(id, "S_IDROP");
				PlayAnimation(id, "T_IDROP_2_STAND");
			end
		else
			_21game_gameText(id, "� ��� ������������ ���������� ����.", 255, 255, 255)
		end
	else
		_21game_gameText(id, "������ �� ��� ���.", 255, 255, 255)
	end


end

function _21game_final(id) -- �������� ����������.

	local pid = Player[id]._21game_enemy;

	local sum1 = _21game_CardsValue(id);
	local sum2 = _21game_CardsValue(pid);


	if sum1 == sum2 then
		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 600 then
				SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� �������� �����. ");      
			end
		end


	elseif sum1 <= 21 and sum2 <= 21 then

		if sum1 > sum2 then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					if Player[id].masked == false then
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." �������. ");
					else
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") �������. ");
					end
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum1 - sum2);
				end
			end

		elseif sum2 > sum1 then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					if Player[id].masked == false then
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(pid).." �������. ");
					else
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..pid..") �������. ");
					end
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum2 - sum1);       
				end
			end
		end

	elseif sum1 >= 21 and sum2 >= 21 then

		if sum1 < sum2 then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					if Player[id].masked == false then
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." �������. "); 
					else
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") �������. ");
					end
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum2 - sum1);     
				end
			end

		elseif sum2 < sum1 then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) <= 600 then
					if Player[id].masked == false then
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(pid).." �������. "); 
					else
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..pid..") �������. ");
					end
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum1 - sum2);       
				end
			end
		end

	elseif sum1 > 21 or sum2 > 21 then

		if sum1 > 21 then

			if sum1 > sum2 then
				for i = 0, GetMaxPlayers() do
					if GetDistancePlayers(id, i) <= 600 then
						if Player[id].masked == false then
							SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(pid).." �������. "); 
						else
							SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..pid..") �������. ");
						end 
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum1 - sum2);       
					end
				end
			end

		elseif sum2 > 21 then

			if sum2 > sum1 then
				for i = 0, GetMaxPlayers() do
					if GetDistancePlayers(id, i) <= 600 then
						if Player[id].masked == false then
							SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." �������. "); 
						else
							SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") �������. "); 
						end
						SendPlayerMessage(i, 255, 255, 255, "(21 �����) �������: "..sum2 - sum1);         
					end
				end
			end	
			
		end
	end

	_21game_finalOut(id)
	_21game_finalOut(pid)


end

function _21game_finalOut(id) -- �������� ������� � ������.

	SetCursorVisible(id, 0);
	UnFreeze(id);
	FreezeCamera(id, 0);
	ShowChat(id, 1);


	HideTexture(id, game21_background);
	HideTexture(id, game21_playerone);
	HideTexture(id, game21_playertwo);


	-- �������� ������
	for i = 1, table.getn(game21_buttons_tex) do
		HideTexture(id, game21_buttons_tex[i]);
	end


	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_draws) do
		HidePlayerDraw(id, Player[id]._21game_draws[i]);
		DestroyPlayerDraw(id, Player[id]._21game_draws[i]);
	end


	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_texdown) do
		HideTexture(id, Player[id]._21game_texdown[i]);
		--DestroyTexture(Player[id]._21game_texdown[i]);
	end


	-- ����� ������
	for i = 1, table.getn(Player[id]._21game_texup) do
		HideTexture(id, Player[id]._21game_texup[i]);
		--DestroyTexture(Player[id]._21game_texup[i]);
	end



	local pid = Player[id]._21game_enemy;
	SetCursorVisible(pid, 0);

	Player[id]._21game_play = false;
	Player[id]._21game_invite = {0, nil};
	Player[id]._21game_pos = 0;
	Player[id]._21game_enemy = nil;
	Player[id]._21game_score = {};
	Player[id]._21game_block = false;
	Player[id]._21game_turn = nil;
	Player[id]._21game_texup = {};
	Player[id]._21game_texdown = {};
	Player[id]._21game_cards = {

		"a6", "a7", "a8", "a9", "a10", "a3", "a4", "a5", "a11",
		"b6", "b7", "b8", "b9", "b10", "b3", "b4", "b5", "b11",
		"c6", "c7", "c8", "c9", "c10", "c3", "c4", "c5", "c11",
		"d6", "d7", "d8", "d9", "d10", "d3", "d4", "d5", "d11"


	};


	Player[id]._21game_draws = {};

	-----------------------------------------------------------------------

	UnFreeze(pid);
	FreezeCamera(pid, 0);
	ShowChat(pid, 1);

	HideTexture(pid, game21_background);
	HideTexture(pid, game21_playerone);
	HideTexture(pid, game21_playertwo);

	-- �������� ������
	for i = 1, table.getn(game21_buttons_tex) do
		HideTexture(pid, game21_buttons_tex[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[pid]._21game_draws) do
		HidePlayerDraw(pid, Player[pid]._21game_draws[i]);
		DestroyPlayerDraw(pid, Player[pid]._21game_draws[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[pid]._21game_texdown) do
		HideTexture(pid, Player[pid]._21game_texdown[i]);
		--DestroyTexture(Player[pid]._21game_texdown[i]);
	end

	-- ����� ������
	for i = 1, table.getn(Player[pid]._21game_texup) do
		HideTexture(pid, Player[pid]._21game_texup[i]);
		--DestroyTexture(Player[pid]._21game_texup[i]);
	end

	Player[pid]._21game_play = false;
	Player[pid]._21game_invite = {0, nil};
	Player[pid]._21game_pos = 0;
	Player[pid]._21game_enemy = nil;
	Player[pid]._21game_score = {};
	Player[pid]._21game_block = false;
	Player[pid]._21game_turn = nil;
	Player[pid]._21game_texup = {};
	Player[pid]._21game_texdown = {};
	Player[pid]._21game_cards = {

		"a6", "a7", "a8", "a9", "a10", "a3", "a4", "a5", "a11",
		"b6", "b7", "b8", "b9", "b10", "b3", "b4", "b5", "b11",
		"c6", "c7", "c8", "c9", "c10", "c3", "c4", "c5", "c11",
		"d6", "d7", "d8", "d9", "d10", "d3", "d4", "d5", "d11"


	};

	Player[pid]._21game_draws = {};


end


function _21game_stopCards(id) -- ������� ������ "������"

	if Player[id]._21game_block == false then
		Player[id]._21game_block = true;

		local pid = Player[id]._21game_enemy;
		_21game_gameText(id, "�� ��������� ����� ����.", 255, 255, 255, 2000);
		_21game_gameText(pid, "��������� �������� ����� ����.", 255, 255, 255, 2000);
		PlayAnimation(id, "T_NO");
		
		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(id, i) <= 600 then
				if Player[id].masked == false then
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." ������ �����. ");
				else
					SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") ������ �����. ");
				end
			end
		end

		if Player[pid]._21game_block == true then
			_21game_final(id);
		else
			Player[id]._21game_turn = GetPlayerName(pid);
			Player[pid]._21game_turn = GetPlayerName(pid);

			_21game_updateDrawTurn(id);
			_21game_updateDrawTurn(pid);
		end
	end

end

function _21game_leave(id) -- ������� ������ "���"

	for i = 0, GetMaxPlayers() do
		if GetDistancePlayers(id, i) <= 600 then
			if Player[id].masked == false then
				SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." ������. ");
			else
				SendPlayerMessage(i, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") ������. ");
			end         
		end
	end
	PlayAnimation(id, "T_NO");

	SetCursorVisible(id, 0);
	UnFreeze(id);
	FreezeCamera(id, 0);
	ShowChat(id, 1);



	HideTexture(id, game21_background);
	HideTexture(id, game21_playerone);
	HideTexture(id, game21_playertwo);


	-- �������� ������
	for i = 1, table.getn(game21_buttons_tex) do
		HideTexture(id, game21_buttons_tex[i]);
	end


	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_draws) do
		HidePlayerDraw(id, Player[id]._21game_draws[i]);
		DestroyPlayerDraw(id, Player[id]._21game_draws[i]);
	end


	-- ����� �����
	for i = 1, table.getn(Player[id]._21game_texdown) do
		HideTexture(id, Player[id]._21game_texdown[i]);
		--DestroyTexture(Player[id]._21game_texdown[i]);
	end


	-- ����� ������
	for i = 1, table.getn(Player[id]._21game_texup) do
		HideTexture(id, Player[id]._21game_texup[i]);
		--DestroyTexture(Player[id]._21game_texup[i]);
	end



	local pid = Player[id]._21game_enemy;

	Player[id]._21game_play = false;
	Player[id]._21game_invite = {0, nil};
	Player[id]._21game_pos = 0;
	Player[id]._21game_enemy = nil;
	Player[id]._21game_score = {};
	Player[id]._21game_block = false;
	Player[id]._21game_turn = nil;
	Player[id]._21game_texup = {};
	Player[id]._21game_texdown = {};
	Player[id]._21game_cards = {

		"a6", "a7", "a8", "a9", "a10", "a3", "a4", "a5", "a11",
		"b6", "b7", "b8", "b9", "b10", "b3", "b4", "b5", "b11",
		"c6", "c7", "c8", "c9", "c10", "c3", "c4", "c5", "c11",
		"d6", "d7", "d8", "d9", "d10", "d3", "d4", "d5", "d11"


	};


	Player[id]._21game_draws = {};

	-----------------------------------------------------------------------

	SetCursorVisible(pid, 0);
	UnFreeze(pid);
	FreezeCamera(pid, 0);
	ShowChat(pid, 1);

	HideTexture(pid, game21_background);
	HideTexture(pid, game21_playerone);
	HideTexture(pid, game21_playertwo);

	-- �������� ������
	for i = 1, table.getn(game21_buttons_tex) do
		HideTexture(pid, game21_buttons_tex[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[pid]._21game_draws) do
		HidePlayerDraw(pid, Player[pid]._21game_draws[i]);
		DestroyPlayerDraw(pid, Player[pid]._21game_draws[i]);
	end

	-- ����� �����
	for i = 1, table.getn(Player[pid]._21game_texdown) do
		HideTexture(pid, Player[pid]._21game_texdown[i]);
		--DestroyTexture(Player[pid]._21game_texdown[i]);
	end

	-- ����� ������
	for i = 1, table.getn(Player[pid]._21game_texup) do
		HideTexture(pid, Player[pid]._21game_texup[i]);
		--DestroyTexture(Player[pid]._21game_texup[i]);
	end

	Player[pid]._21game_play = false;
	Player[pid]._21game_invite = {0, nil};
	Player[pid]._21game_pos = 0;
	Player[pid]._21game_enemy = nil;
	Player[pid]._21game_score = {};
	Player[pid]._21game_block = false;
	Player[pid]._21game_turn = nil;
	Player[pid]._21game_texup = {};
	Player[pid]._21game_texdown = {};
	Player[pid]._21game_cards = {

		"a6", "a7", "a8", "a9", "a10", "a3", "a4", "a5", "a11",
		"b6", "b7", "b8", "b9", "b10", "b3", "b4", "b5", "b11",
		"c6", "c7", "c8", "c9", "c10", "c3", "c4", "c5", "c11",
		"d6", "d7", "d8", "d9", "d10", "d3", "d4", "d5", "d11"


	};

	Player[pid]._21game_draws = {};



end

function _21game_mouse(id, button, pressed, posX, posY) -- � OnPlayerMouse

	if Player[id]._21game_play == true then
		if button == MB_LEFT then
			if pressed == 0 then

				if posX > game21_buttons_xyz[1][1] and posX < game21_buttons_xyz[1][2] and posY > game21_buttons_xyz[1][3] and posY < game21_buttons_xyz[1][4] then
					if Player[id]._21game_block == false then
						_21game_takeCard(id);
					end
				end

				if posX > game21_buttons_xyz[2][1] and posX < game21_buttons_xyz[2][2] and posY > game21_buttons_xyz[2][3] and posY < game21_buttons_xyz[2][4] then
					_21game_stopCards(id)
				end

				if posX > game21_buttons_xyz[3][1] and posX < game21_buttons_xyz[3][2] and posY > game21_buttons_xyz[3][3] and posY < game21_buttons_xyz[3][4] then
					_21game_leave(id);
				end

			end
		end
	end

end

-- cmds
function _21game_invite(id, sets) -- ������� ��� �����������.

	local result, pid = sscanf(sets, "d");
	if result == 1 then
		if Player[id].loggedIn == true then
			if Player[pid]._21game_play == false then
				if IsNPC(pid) == 0 then
					if pid ~= id then
						if GetDistancePlayers(id, pid) <= 500 then
							if Player[id].masked == false then
								SendPlayerMessage(pid, 255, 255, 255, "(21 �����) ����� "..GetPlayerName(id).." ���������� ��� ������� � 21 ����. ");
							else
								SendPlayerMessage(pid, 255, 255, 255, "(21 �����) ����� ����������� ("..id..") ���������� ��� ������� � 21 ����. ");
							end
							SendPlayerMessage(pid, 255, 255, 255, "��� ������ �������: /����_�� ��� /����_���.")
							SendPlayerMessage(id, 255, 255, 255, "�� ��������� ����������� ������ "..GetPlayerName(pid)..".");
							SendPlayerMessage(id, 255, 255, 255, "��� �������� ���� �� ����� ���� ������� F12.");
							SendPlayerMessage(pid, 255, 255, 255, "��� �������� ���� �� ����� ���� ������� F12.");
							Player[id]._21game_invite = {1, pid};
							Player[pid]._21game_invite = {2, id};
						else
							SendPlayerMessage(id, 255, 255, 255, "����� ������ �� ���.")
						end
					else
						SendPlayerMessage(id, 255, 255, 255, "������ ��������� ���� ID.")
					end
				else
					SendPlayerMessage(id, 255, 255, 255, "��� ���.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� ��� ������.")
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/����21 (��)")
	end

end
addCommandHandler({"/����21", "/game21"}, _21game_invite);

function _21game_inviteYes(id) -- ������� ��� ��������.

	if Player[id].loggedIn == true then
		if Player[id]._21game_play == false then
			if Player[id]._21game_invite[1] ~= 0 then
				_21game_startGame(id);
				_21game_startGame(Player[id]._21game_invite[2]);

				for i = 0, GetMaxPlayers() do
					if GetDistancePlayers(id, i) <= 1000 then
						SendPlayerMessage(i, 255, 255, 255, "������ � 21 ���� ��������!");         
					end
				end

				--SetPlayerAngle(id, GetAngleToPlayer(id, Player[id]._21game_invite[2]));
				--SetPlayerAngle(Player[id]._21game_invite[2], GetAngleToPlayer(id, Player[id]._21game_invite[2]) - 180);

				--PlayAnimation(id, "S_HGUARD");
				--PlayAnimation(Player[id]._21game_invite[2], "S_HGUARD");

			end
		end
	end

end
addCommandHandler({"/����_��", "/game_yes"}, _21game_inviteYes);


function _21game_inviteNo(id) -- ������� ��� ������.

	if Player[id].loggedIn == true then
		if Player[id]._21game_play == false then
			if Player[id]._21game_invite[1] ~= 0 then
				local pid = Player[id]._21game_invite[2];
				SendPlayerMessage(id, 255, 255, 255, "(���� 21) �� ���������� �� ����.")
				SendPlayerMessage(pid, 255, 255, 255, "(���� 21) ����� ��������� �� ����.")
				Player[id]._21game_invite = {0, nil};
				Player[pid]._21game_invite = {0, nil};
			end
		end
	end

end
addCommandHandler({"/����_���", "/game_no"}, _21game_inviteNo);


