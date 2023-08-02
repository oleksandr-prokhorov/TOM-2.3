
local PLAYERS = {};

function _discordUpdateIDsKick()

	local file = io.open("Database/Discord/IDs", "w");
	file:close();
	
	for i = 0, GetMaxPlayers() do
		if IsNPC(i) == 0 and IsPlayerConnected(i) == 1 then
			table.insert(PLAYERS, i);
		end
	end

	if table.getn(PLAYERS) > 0 then
		local file = io.open("Database/Discord/IDs", "w");
		for _, v in pairs(PLAYERS) do
			file:write(v.."\n");
		end
		file:close();
		PLAYERS = {};
	end

end
SetTimer(_discordUpdateIDsKick, 10000, 1);

function _discordKickPlayer()

	local id = nil;
	local reason = "";

	local file = io.open("Database/Discord/kick", "r");
	if file then

		str = file:read("*l");
		if str then
			local l, pid = sscanf(str, "d")
			if l == 1 then
				id = pid;
			end
		end

		str = file:read("*l");
		if str then
			local l, reas = sscanf(str, "s")
			if l == 1 then
				reason = reas;
			end
		end
		file:close();
	end

	if id ~= nil then
		local file = io.open("Database/Discord/kick", "w");
		file:close();
		if IsNPC(id) == 0 and IsPlayerConnected(id) == 1 then
			SendPlayerMessage(id, 187, 105, 255, "(Gothic Online) Вы были кикнуты по причине: "..reason.." (дискорд).");
			Kick(id);
		end
	end

end
SetTimer(_discordKickPlayer, 3000, 1);