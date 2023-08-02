
function _ac_chatInit(id)

	Player[id].chat_lens = 50;
	Player[id].chatpos = {80, 130};
	Player[id].chatpos_edit = false;
	Player[id].chatpos_edit_pos = {0, 0};
	Player[id].str_size = 5;
	Player[id].strc = {};

	for i = 1, Player[id].str_size do
		Player[id].strc[#Player[id].strc+1] = " ";
	end

	Player[id].chatdraw = {};

	local pos = Player[id].chatpos[2];
	for i = 1, Player[id].str_size do
		Player[id].chatdraw[i] = CreatePlayerDraw(id, Player[id].chatpos[1], pos, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 200;
	end
	--ShowChat(id, 0);

end

function _reloadChatDraws(id)

	for i = 1, Player[id].str_size do
		HidePlayerDraw(id, Player[id].chatdraw[i]);
		DestroyPlayerDraw(id, Player[id].chatdraw[i]);
	end
	Player[id].chatdraw = {};

	local pos = Player[id].chatpos[2];
	for i = 1, Player[id].str_size do
		Player[id].chatdraw[i] = CreatePlayerDraw(id, Player[id].chatpos[1], pos, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 200;
	end

	_showChat(id);

end

function _showChat(id)

	for i = 1, Player[id].str_size do
		ShowPlayerDraw(id, Player[id].chatdraw[i]);
	end

end

function _sendMessageToPlayer(id, text)

	table.remove(Player[id].strc, 1);
	Player[id].strc[#Player[id].strc+1] = text;
	_updatePlayerChat(id);

end

function _sendSystemMessageToChat(text)

	for i = 0, GetMaxPlayers() do
		if Player[i].astatus > 2 then
			table.remove(Player[i].strc, 1);
			Player[i].strc[#Player[i].strc+1] = text;
		end
	end
	_updateChat();

end

function _sendMessageToChat(id, sets)
	
	if Player[id].astatus > 2 then
		local cmd, text = sscanf(sets, "s");
		if cmd == 1 then

			local sub = {}; local msg = {}; local double = false;
			local name = string.sub(Player[id].nickname, 1, 10)

			if string.len(text) > Player[id].chat_lens then
				double = true;
				sub[1] = string.sub(text, 1, Player[id].chat_lens);
				sub[2] = string.sub(text, Player[id].chat_lens+1, string.len(text));

				msg[1] = name..": "..sub[1].."-";
				msg[2] = sub[2];

			else
				msg[1] = name..": "..text;
			end

			if double == false then

				for i = 0, GetMaxPlayers() do
					if Player[i].astatus > 2 then
						table.remove(Player[i].strc, 1);
						Player[i].strc[#Player[i].strc+1] = msg[1];
						_updatePlayerChat(i);
					end
				end
				_updateChat();
				LogString("Logs/Admins/achat", Player[playerid].nickname..": "..text.." / ".._getRTime())
			else

				for i = 0, GetMaxPlayers() do
					if Player[i].astatus > 2 then
						table.remove(Player[i].strc, 1);
						Player[i].strc[#Player[i].strc+1] = msg[1];
						table.remove(Player[i].strc, 1);
						Player[i].strc[#Player[i].strc+1] = msg[2];
						_updatePlayerChat(i);
					end
				end
				_updateChat();

				LogString("Logs/Admins/achat", Player[playerid].nickname..": "..text.." / ".._getRTime());

			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/а (текст)");
		end
	end

end
--addCommandHandler({"/а"}, _sendMessageToChat);

function _updatePlayerChat(id)

	local pos = Player[id].chatpos[2];
	for d = 1, Player[id].str_size do
		UpdatePlayerDraw(id, Player[id].chatdraw[d], Player[id].chatpos[1], pos, Player[id].strc[d], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 200;
	end

end

function _updateChat()

	for i = 0, GetMaxPlayers() do
		if Player[i].astatus > 2 then
			local pos = Player[i].chatpos[2];
			for d = 1, Player[i].str_size do
				UpdatePlayerDraw(i, Player[i].chatdraw[d], Player[i].chatpos[1], pos, Player[i].strc[d], "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 200;
			end
		end
	end
end

function _tempClearChat(id)

	local pos = Player[id].chatpos[2];
	for d = 1, Player[id].str_size do
		UpdatePlayerDraw(id, Player[id].chatdraw[d], Player[id].chatpos[1], pos, " ", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		pos = pos + 200;
	end

end

-- edit pos
function _chatEditPos(id)

	if Player[id].astatus > 2 then
		if Player[id].chatpos_edit == false then
			Player[id].chatpos_edit = true;
			SetCursorVisible(id, 1);
			FreezeCamera(id, 1);
		else
			Player[id].chatpos_edit = false;
			SetCursorVisible(id, 0);
			FreezeCamera(id, 0);
			SetDefaultCamera(id);
		end
	end

end
addCommandHandler({"/чат_поз"}, _chatEditPos);

function _setChatPosition(id)

	if Player[id].chatpos_edit == true then
		Player[id].chatpos[1] = Player[id].chatpos_edit_pos[1];
		Player[id].chatpos[2] = Player[id].chatpos_edit_pos[2];
		_updatePlayerChat(id)
	end

end

function _chatMouse(id, button, pressed, posX, posY)

	if Player[id].chatpos_edit == true then
		if button == MB_LEFT then
			if pressed == 0 then
				Player[id].chatpos_edit_pos[1] = posX;
				Player[id].chatpos_edit_pos[2] = posY;
				_setChatPosition(id);
			end
		end
	end
end

-- edit lines
function _chatEditLines(id, params)

	if Player[id].astatus > 2 then
		local result, n = sscanf(params, "d");
		if result == 1 then

			local size = 0;
			for i, _ in pairs(Player[id].strc) do
				size = size + 1;
			end

			local oldsize = Player[id].str_size;
			if oldsize < n then
				local plus = n - oldsize;
				for i = 1, plus do
					table.insert(Player[id].strc, 1, " ");
				end
			else
				local minus = oldsize - n;
				for i = 1, minus do
					table.remove(Player[id].strc, 1);
				end
			end

			local size = 0;
			for i, _ in pairs(Player[id].strc) do
				size = size + 1;
			end

			for i = 1, Player[id].str_size do
				HidePlayerDraw(id, Player[id].chatdraw[i]);
				DestroyPlayerDraw(id, Player[id].chatdraw[i]);
			end
			Player[id].chatdraw = {};
			Player[id].str_size = size;

			local pos = Player[id].chatpos[2];
			for i = 1, Player[id].str_size do
				Player[id].chatdraw[i] = CreatePlayerDraw(id, Player[id].chatpos[1], pos, "", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
				pos = pos + 200;
			end

			_showChat(id);
			_updatePlayerChat(id);
			_sendMessageToPlayer(id, "Вы изменили кол-во строк до "..n);

		end
	end

end
addCommandHandler({"/чат_строки"}, _chatEditLines);


-- edit lens
function _chatEditLens(id, params)

	local result, n = sscanf(params, "d");
	if result == 1 then
		if n < 0 then
			Player[id].chat_lens = Player[id].chat_lens + n;
			_updateMessagesLens(id, minus);
		else
			Player[id].chat_lens = Player[id].chat_lens + n;
			_updateMessagesLens(id, plus);
		end
	end
end
addCommandHandler({"/чат_широта"}, _chatEditLens);

function _updateMessagesLens(id, set)
	
	if set == minus then

		local tempStr = {};


		for _, v in pairs(Player[id].strc) do
			if string.len(v) <= Player[id].chat_lens then
				tempStr[#tempStr+1] = v;
			else
				local text = {}; 
				text[1] = string.sub(v, 1, Player[id].chat_lens);
				text[2] = string.sub(v, Player[id].chat_lens+1, string.len(v));
				tempStr[#tempStr+1] = text[1]; tempStr[#tempStr+1] = text[2];
			end

		end

		_tempClearChat(id);

		Player[id].strc = {};
		local lines = 0;
		for i, v in pairs(tempStr) do
			Player[id].strc[#Player[id].strc + 1] = v;
			lines = lines + 1;
		end

		if lines > Player[id].str_size then
			local del = lines - Player[id].str_size;
			for i = 1, del do
				table.remove(Player[id].strc, 1);
			end
		end

		_updatePlayerChat(id);
		_sendMessageToPlayer(id, "Вы изменили широту чата до "..Player[id].chat_lens);

	elseif set == plus then

		_updatePlayerChat(id);
		_sendMessageToPlayer(id, "Вы изменили широту чата до "..Player[id].chat_lens);

	end

end