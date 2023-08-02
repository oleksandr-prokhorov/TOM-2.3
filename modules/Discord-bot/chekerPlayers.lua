--[[
function directory_exists(directory)
	return os.rename(directory, directory)
end

function _chekerPlayers()
	
	if directory_exists("Database/Discord/players") == nil then
		os.execute("mkdir " .. "Database\\Discord\\players")
	end

	for i = 0, GetMaxPlayers() do
		if IsNPC(i) == 0 and IsPlayerConnected(i) == 1 then
			if Player[i].loggedIn == true then
				local file = io.open("Database/Discord/players/"..GetPlayerName(i), "w");
				file:write("* **Предметы игрока:**\n");
				--------------------------------------------------------------------------
				local items = getPlayerItems(i);
				if items then
					for i in pairs(items) do
						file:write("- "..GetItemName(items[i].instance).." x"..items[i].amount.."\n");
					end
				end
				-------------------------------------------------
				file:write(" \n");
				-------------------------------------------------
				file:write("* **Характеристики игрока:**\n");
				file:write("- Сила: "..Player[i].str.."\n");
				file:write("- Ловкость: "..Player[i].dex.."\n");
				file:write("- Макс. ХП: "..Player[i].hp.."\n");
				file:write("- Макс. МП: "..Player[i].mp.."\n");
				file:write("- Одноручное: "..Player[i].h1.."\n");
				file:write("- Двуручное: "..Player[i].h2.."\n");
				file:write("- Арбалет: "..Player[i].cbow.."\n");
				file:write("- Лук: "..Player[i].bow.."\n");
				file:write("- Круг: "..Player[i].mag.."\n");
				file:write("- Текущее ХП: "..GetPlayerHealth(i).."\n");
				file:write("- Текущее МП: "..GetPlayerMana(i).."\n");
				-------------------------------------------------
				file:write(" \n");
				-------------------------------------------------
				file:write("* **Прочее игрока:**\n");
				file:write("- Золото: "..Player[i].gold.."\n");
				file:write("- ОС: "..Player[i].hpoints.."\n");
				file:write("- Текущ. энергия: "..Player[i].energy.." / Доступ. лимит: "..Player[i].energyblock.."\n");
				-------------------------------------------------
				file:write(" \n");
				-------------------------------------------------
				file:write("* **РП-инвентарь игрока:**\n");
				local tempArr = {};
				for k, v in pairs(TInventory[i].item) do
					table.insert(tempArr, "- "..k.." x"..TInventory[i].item[k].amount)
				end
				if table.getn(tempArr) > 0 then
					for i = 1, table.getn(tempArr) do
						file:write(tempArr[i].."\n");
					end
				else
					file:write("- Пусто");
				end
				file:close();
			end
		end
	end
end
SetTimer(_chekerPlayers, 50000, 1);]]