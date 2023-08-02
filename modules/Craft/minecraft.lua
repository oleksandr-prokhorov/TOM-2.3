
--  # ---------------------------------------------------- #
--  #  Craft system by DirkLoggan / rewrite by royclapton  #
--  #                     version: 1.0                     #
--  #----------------------------------------------------- #

function tLen(arg)
  return table.getn(arg)
end

function DeleteItem(playerid, item_instance, amountremove)
local oldValue;
local file = io.open("Database/Players/Items"..Player[playerid].nickname..".db","r+");
if file then
	for line in file:lines() do
		local result, item, value = sscanf(line,"sd");
		if result == 1 then
			if string.upper(item) == item_instance then
				oldValue = value;
			end
		end
	end
	file:close();
end
if oldValue == nil then
	oldValue = 0;
end
local newValue = oldValue - amountremove;
if newValue < 0 then
	newValue = 0;
end
local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
local tempString = file:read("*a");
file:close();
local tempString = string.gsub(tempString,string.upper(item_instance).." "..oldValue,string.upper(item_instance).." "..newValue);
local file = io.open("Database/Players/Items/"..Player[playerid].nickname..".db","r+");
file:write(tempString);
file:close();
RemoveItem(playerid, item_instance, amountremove);
end

function tCount(arg)
	local count = 0;
	for _ in pairs(arg) do
		count = count + 1;
	end
	return count;
end

local CraftCategory = {};
local CraftItem = {};
local CraftPenalty = {};
local PenaltyTimer = {};
local Workspace = {};

function AddAlchemyWorkspace(x, y, z)
	local size = tLen(Workspace);
	Workspace[size] = {};
	Workspace[size].x = x;
	Workspace[size].y = y;
	Workspace[size].z = z;
	Workspace[size].range = 9999999;
	Workspace[size].cat = {};
	AddWorkspaceCategory(size, "Повар (Домашняя утварь)");
	AddWorkspaceCategory(size, "Повар (1 уровень)");
	AddWorkspaceCategory(size, "Повар (2 уровень)");
	AddWorkspaceCategory(size, "Повар (3 уровень)");
	AddWorkspaceCategory(size, "Повар (4 уровень)");
	AddWorkspaceCategory(size, "Алхимия (Домашняя утварь)");
	AddWorkspaceCategory(size, "Алхимия (1 уровень)");
	AddWorkspaceCategory(size, "Алхимия (2 уровень)");
	AddWorkspaceCategory(size, "Алхимия (3 уровень)");
	AddWorkspaceCategory(size, "Алхимия (4 уровень)");
	AddWorkspaceCategory(size, "Оружейник (Домашняя утварь)");
	AddWorkspaceCategory(size, "Оружейник (1 уровень)");
	AddWorkspaceCategory(size, "Оружейник (2 уровень)");
	AddWorkspaceCategory(size, "Оружейник (3 уровень)");
	AddWorkspaceCategory(size, "Оружейник (4 уровень)");
	AddWorkspaceCategory(size, "Плотник (Домашняя утварь)");
	AddWorkspaceCategory(size, "Плотник (1 уровень)");
	AddWorkspaceCategory(size, "Плотник (2 уровень)");
	AddWorkspaceCategory(size, "Плотник (3 уровень)");
	AddWorkspaceCategory(size, "Плотник (4 уровень)");
	AddWorkspaceCategory(size, "Бронник (Домашняя утварь)");
	AddWorkspaceCategory(size, "Бронник (1 уровень)");
	AddWorkspaceCategory(size, "Бронник (2 уровень)");
	AddWorkspaceCategory(size, "Бронник (3 уровень)");
	AddWorkspaceCategory(size, "Бронник (4 уровень)");
	AddWorkspaceCategory(size, "Кожевник (Домашняя утварь)");
	AddWorkspaceCategory(size, "Кожевник (1 уровень)");
	AddWorkspaceCategory(size, "Кожевник (2 уровень)");
	AddWorkspaceCategory(size, "Кожевник (3 уровень)");
	AddWorkspaceCategory(size, "Кожевник (4 уровень)");
	AddWorkspaceCategory(size, "Портной (Домашняя утварь)");
	AddWorkspaceCategory(size, "Портной (1 уровень)");
	AddWorkspaceCategory(size, "Портной (2 уровень)");
	AddWorkspaceCategory(size, "Портной (3 уровень)");
	AddWorkspaceCategory(size, "Портной (4 уровень)");
	AddWorkspaceCategory(size, "Робы магов");
	AddWorkspaceCategory(size, "(Р) 1-й Круг");
	AddWorkspaceCategory(size, "(Р) 2-й Круг");
	AddWorkspaceCategory(size, "(Р) 3-й Круг");
	AddWorkspaceCategory(size, "(Р) 4-й Круг");
	AddWorkspaceCategory(size, "(Р) 5-й Круг");
	AddWorkspaceCategory(size, "(Р) 6-й Круг");
	AddWorkspaceCategory(size, "(С) 1-й Круг");
	AddWorkspaceCategory(size, "(С) 2-й Круг");
	AddWorkspaceCategory(size, "(С) 3-й Круг");
	AddWorkspaceCategory(size, "(С) 4-й Круг");
	AddWorkspaceCategory(size, "(С) 5-й Круг");
	AddWorkspaceCategory(size, "(С) 6-й Круг");
	AddWorkspaceCategory(size, "Зачарователь (Домашняя утварь)");
	AddWorkspaceCategory(size, "Зачарователь (1 уровень)");
	AddWorkspaceCategory(size, "Зачарователь (2 уровень)");
	AddWorkspaceCategory(size, "Зачарователь (3 уровень)");
end


function AddWorkspaceCategory(uid, category)
	table.insert(Workspace[uid].cat, category);
end

function WorkspaceReachable(pid, uid)
	local pX, pY, pZ = GetPlayerPos(pid);
	local tDist = GetDistance3D(pX, pY, pZ, Workspace[uid].x, Workspace[uid].y, Workspace[uid].z);
	if tDist <= Workspace[uid].range then
		return 1;
	else
		return 0;
	end
end

function WorkspaceHasCategory(uid, category)
	for k, v in pairs(Workspace[uid].cat) do
		if v == category then
			return 1;
		end
	end
	
	return 0;
end

function LoadPenaltyList()
	local iFile = io.open("dlbase/craftpenaltylist.me", "r+");
	local filestream = iFile:read();
	for line in io.lines("dlbase/craftpenaltylist.me") do
		local result, name, ptime = sscanf(filestream,"sd");
		if result == 1 then
			CraftPenalty[name] = ptime;
			PenaltyTimer[name] = SetTimerEx("DecreasePenalty", 60*1000, 1, name);
		end
		filestream = iFile:read("*l");
	end
	iFile:close();
end

function DecreasePenalty(name)
	CraftPenalty[name] = CraftPenalty[name] - 1;
	if CraftPenalty[name] <= 0 then
		KillTimer(PenaltyTimer[name]);
		CraftPenalty[name] = nil;
	end
end

function SavePenaltyList()
	local pFile = io.open("dlbase/craftpenaltylist.me", "w");
	
	for k, v in pairs(CraftPenalty) do
		pFile:write(k, " ");
		pFile:write(v, "\n");
	end
				
	pFile:close();
end

function InitCategory(name)
	if CraftCategory[name] == nil then
		CraftCategory[name] = {};
		CraftCategory[name].items = {};
		CraftCategory[name].acquire_workspace = false;
	end
end

function ToggleWorkspace(name)
	InitCategory(name);
	CraftCategory[name].acquire_workspace = true;
end

function AddCategoryScience(name, science)
	InitCategory(name)
	CraftCategory[name].science = science;
end


function InitItem(instance)
	instance = string.upper(instance);
	if CraftItem[instance] == nil then
		CraftItem[instance] = {};
		CraftItem[instance].exp = 0;
		CraftItem[instance].exp_skill = {};
		CraftItem[instance].amount = 0;
		CraftItem[instance].penalty = 0;
		CraftItem[instance].energy = 0;
		CraftItem[instance].ing = {};
		CraftItem[instance].altering = {};
		CraftItem[instance].tools = {};
		CraftItem[instance].science = {};
	end
end

function AddItemCategory(name, instance)
	instance = string.upper(instance);
	InitCategory(name);
	table.insert(CraftCategory[name].items, instance);
end

function AddTool(instance, tool_instance)
	instance = string.upper(instance);
	InitItem(instance);
	tool_instance = string.upper(tool_instance);
	CraftItem[instance].tools[tool_instance] = {};
	CraftItem[instance].tools[tool_instance].amount = 1;
end

function AddIngre(instance, ing_instance, amount)
	instance = string.upper(instance);
	InitItem(instance);
	ing_instance = string.upper(ing_instance);
	CraftItem[instance].ing[ing_instance] = {};
	CraftItem[instance].ing[ing_instance].amount = amount;
end

function AddAlterIngre(instance, ing_instance, amount)
    instance = string.upper(instance);
	InitItem(instance);
	ing_instance = string.upper(ing_instance);
	CraftItem[instance].altering[ing_instance] = {};
	CraftItem[instance].altering[ing_instance].amount = amount;
end

function SetCraftEXP(instance, value)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].exp = value;
end

function SetCraftEXP_SKILL(instance, skill)
	instance = string.upper(instance);
	InitItem(instance);
	table.insert(CraftItem[instance].exp_skill, tostring(skill));
end

function SetCraftAmount(instance, amount)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].amount = amount;
end

function SetCraftPenalty(instance, minutes)
	--instance = string.upper(instance);
	--InitItem(instance);
	--CraftItem[instance].penalty = minutes;
end

function SetenergyPenalty(instance, energy)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].energy = energy;
end

function SetCraftScience(instance, science, level)
	instance = string.upper(instance);
	InitItem(instance);
	CraftItem[instance].science[science] = level;
end

function InitCraftList()
	LoadPenaltyList();
	
	AddAlchemyWorkspace(-1250.7536621094, -778.23889160156, -6898.2431640625);

	ToggleWorkspace("Повар (Домашняя утварь)");
	ToggleWorkspace("Повар (1 уровень)");
	ToggleWorkspace("Повар (2 уровень)");
	ToggleWorkspace("Повар (3 уровень)");
	ToggleWorkspace("Повар (4 уровень)");
	ToggleWorkspace("Алхимия (Домашняя утварь)");
	ToggleWorkspace("Алхимия (1 уровень)");
	ToggleWorkspace("Алхимия (2 уровень)");
	ToggleWorkspace("Алхимия (3 уровень)");
	ToggleWorkspace("Алхимия (4 уровень)");
	ToggleWorkspace("Оружейник (Домашняя утварь)");
	ToggleWorkspace("Оружейник (1 уровень)");
	ToggleWorkspace("Оружейник (2 уровень)");
	ToggleWorkspace("Оружейник (3 уровень)");
	ToggleWorkspace("Оружейник (4 уровень)");
	ToggleWorkspace("Плотник (Домашняя утварь)");
	ToggleWorkspace("Плотник (1 уровень)");
	ToggleWorkspace("Плотник (2 уровень)");
	ToggleWorkspace("Плотник (3 уровень)");
	ToggleWorkspace("Плотник (4 уровень)");
	ToggleWorkspace("Кожевник (Домашняя утварь)");
	ToggleWorkspace("Кожевник (1 уровень)");
	ToggleWorkspace("Кожевник (2 уровень)");
	ToggleWorkspace("Кожевник (3 уровень)");
	ToggleWorkspace("Кожевник (4 уровень)");
	ToggleWorkspace("Бронник (Домашняя утварь)");
	ToggleWorkspace("Бронник (1 уровень)");
	ToggleWorkspace("Бронник (2 уровень)");
	ToggleWorkspace("Бронник (3 уровень)");
	ToggleWorkspace("Бронник (4 уровень)");
	ToggleWorkspace("Портной (Домашняя утварь)");
	ToggleWorkspace("Портной (1 уровень)");
	ToggleWorkspace("Портной (2 уровень)");
	ToggleWorkspace("Портной (3 уровень)");
	ToggleWorkspace("Портной (4 уровень)");
	ToggleWorkspace("Робы магов");
	ToggleWorkspace("(Р) 1-й Круг");
	ToggleWorkspace("(Р) 2-й Круг");
	ToggleWorkspace("(Р) 3-й Круг");
	ToggleWorkspace("(Р) 4-й Круг");
	ToggleWorkspace("(Р) 5-й Круг");
	ToggleWorkspace("(Р) 6-й Круг");
	ToggleWorkspace("(С) 1-й Круг");
	ToggleWorkspace("(С) 2-й Круг");
	ToggleWorkspace("(С) 3-й Круг");
	ToggleWorkspace("(С) 4-й Круг");
	ToggleWorkspace("(С) 5-й Круг");
	ToggleWorkspace("(С) 6-й Круг");
	ToggleWorkspace("Зачарователь (Домашняя утварь)");
	ToggleWorkspace("Зачарователь (1 уровень)");
	ToggleWorkspace("Зачарователь (2 уровень)");
	ToggleWorkspace("Зачарователь (3 уровень)");

	--[[ToggleWorkspace("(Р) 1-й Круг");
	ToggleWorkspace("(Р) 2-й Круг");
	ToggleWorkspace("(Р) 3-й Круг");
	ToggleWorkspace("(Р) 4-й Круг");
	ToggleWorkspace("(Р) 5-й Круг");
	ToggleWorkspace("(С) 1-й Круг");
	ToggleWorkspace("(С) 2-й Круг");
	ToggleWorkspace("(С) 3-й Круг");
	ToggleWorkspace("(С) 4-й Круг");
	ToggleWorkspace("(С) 5-й Круг");]]
	AddCategoryScience("Повар (Домашняя утварь)", "Повар");
	AddCategoryScience("Повар (1 уровень)", "Повар");
	AddCategoryScience("Повар (2 уровень)", "Повар");
	AddCategoryScience("Повар (3 уровень)", "Повар");
	AddCategoryScience("Повар (4 уровень)", "Повар");
	AddCategoryScience("Алхимия (Домашняя утварь)", "Алхимия");
	AddCategoryScience("Алхимия (1 уровень)", "Алхимия");
	AddCategoryScience("Алхимия (2 уровень)", "Алхимия");
	AddCategoryScience("Алхимия (3 уровень)", "Алхимия");
	AddCategoryScience("Алхимия (4 уровень)", "Алхимия");
	AddCategoryScience("Оружейник (Домашняя утварь)", "Оружейник");
	AddCategoryScience("Оружейник (1 уровень)", "Оружейник");
	AddCategoryScience("Оружейник (2 уровень)", "Оружейник");
	AddCategoryScience("Оружейник (3 уровень)", "Оружейник");
	AddCategoryScience("Оружейник (4 уровень)", "Оружейник");
	AddCategoryScience("Плотник (Домашняя утварь)", "Плотник");
	AddCategoryScience("Плотник (1 уровень)", "Плотник");
	AddCategoryScience("Плотник (2 уровень)", "Плотник");
	AddCategoryScience("Плотник (3 уровень)", "Плотник");
	AddCategoryScience("Плотник (4 уровень)", "Плотник");
	AddCategoryScience("Кожевник (Домашняя утварь)", "Кожевник");
	AddCategoryScience("Кожевник (1 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (2 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (3 уровень)", "Кожевник");
	AddCategoryScience("Кожевник (4 уровень)", "Кожевник");
	AddCategoryScience("Бронник (Домашняя утварь)", "Бронник");
	AddCategoryScience("Бронник (1 уровень)", "Бронник");
	AddCategoryScience("Бронник (2 уровень)", "Бронник");
	AddCategoryScience("Бронник (3 уровень)", "Бронник");
	AddCategoryScience("Бронник (4 уровень)", "Бронник");
	AddCategoryScience("Портной (Домашняя утварь)", "Портной");
	AddCategoryScience("Портной (1 уровень)", "Портной");
	AddCategoryScience("Портной (2 уровень)", "Портной");
	AddCategoryScience("Портной (3 уровень)", "Портной");
	AddCategoryScience("Портной (4 уровень)", "Портной");
	AddCategoryScience("Робы магов", "Портной");
	AddCategoryScience("(С) 1-й Круг", "Магия");
	AddCategoryScience("(С) 2-й Круг", "Магия");
	AddCategoryScience("(С) 3-й Круг", "Магия");
	AddCategoryScience("(С) 4-й Круг", "Магия");
	AddCategoryScience("(С) 5-й Круг", "Магия");
	AddCategoryScience("(С) 6-й Круг", "Магия");
	AddCategoryScience("(Р) 1-й Круг", "Магия");
	AddCategoryScience("(Р) 2-й Круг", "Магия");
	AddCategoryScience("(Р) 3-й Круг", "Магия");
	AddCategoryScience("(Р) 4-й Круг", "Магия");
	AddCategoryScience("(Р) 5-й Круг", "Магия");
	AddCategoryScience("(Р) 6-й Круг", "Магия");
	AddCategoryScience("Зачарователь (Домашняя утварь)", "Зачарователь");
	AddCategoryScience("Зачарователь (1 уровень)", "Зачарователь");
	AddCategoryScience("Зачарователь (2 уровень)", "Зачарователь");
	AddCategoryScience("Зачарователь (3 уровень)", "Зачарователь");
	
	--[[AddCategoryScience("(С) 1-й Круг", "Магия");

	AddCategoryScience("(С) 2-й Круг", "Магия");
	AddCategoryScience("(С) 3-й Круг", "Магия");
	AddCategoryScience("(С) 4-й Круг", "Магия");
	AddCategoryScience("(С) 5-й Круг", "Магия");
	AddCategoryScience("(Р) 1-й Круг", "Магия");
	AddCategoryScience("(Р) 2-й Круг", "Магия");
	AddCategoryScience("(Р) 3-й Круг", "Магия");
	AddCategoryScience("(Р) 4-й Круг", "Магия");
	AddCategoryScience("(Р) 5-й Круг", "Магия");]]
	
	
--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА
	
	-- БЕЗ ПРОФЕССИИ

AddItemCategory ("Без профессии", "ZDPWLA_ItFo_GrapeJuice"); ----- Виноградный сок
	SetCraftAmount("ZDPWLA_ItFo_GrapeJuice", 2);
     AddIngre("ZDPWLA_ItFo_GrapeJuice", "ZDPWLA_ITFO_WINEBERRYS2", 5);
	 AddIngre("ZDPWLA_ItFo_GrapeJuice", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_GrapeJuice", 5);
	SetCraftScience("ZDPWLA_ItFo_GrapeJuice", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_GrapeJuice", 25);
	
AddItemCategory ("Без профессии", "ZDPWLA_ItFo_MushroomOffal"); ----- Грибная требуха
    SetCraftAmount("ZDPWLA_ItFo_MushroomOffal", 2);
     AddIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_02", 5);
	 AddAlterIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_01", 5);
    SetCraftPenalty("ZDPWLA_ItFo_MushroomOffal", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomOffal", "Без профессии", 0);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomOffal", 25);
	
AddItemCategory ("Без профессии", "ZDPWLA_ItFo_FishFried"); ----- Жареная рыба
	SetCraftAmount("ZDPWLA_ItFo_FishFried", 2);
     AddIngre("ZDPWLA_ItFo_FishFried", "ZDPWLA_ItFo_Fish", 5);
	SetCraftPenalty("ZDPWLA_ItFo_FishFried", 5);
	SetCraftScience("ZDPWLA_ItFo_FishFried", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_FishFried", 25);

AddItemCategory ("Без профессии", "ZDPWLA_ItFoMutton"); ----- Жареное мясо
	SetCraftAmount("ZDPWLA_ItFoMutton", 2);
     AddIngre("ZDPWLA_ItFoMutton", "ZDPWLA_ItFoMuttonRaw", 5);
    SetCraftPenalty("ZDPWLA_ItFoMutton", 5);
	SetCraftScience("ZDPWLA_ItFoMutton", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFoMutton", 25);
	
AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Honey"); ----- Мед
	SetCraftAmount("ZDPWLA_ItFo_Honey", 2);
     AddIngre("ZDPWLA_ItFo_Honey", "OOLTYB_ITMI_HONEYCOMB", 5);
	SetCraftPenalty("ZDPWLA_ItFo_Honey", 5);
	SetCraftScience("ZDPWLA_ItFo_Honey", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Honey", 25);
	
AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Mors"); ----- Морс
	SetCraftAmount("ZDPWLA_ItFo_Mors", 2);
	 AddIngre("ZDPWLA_ItFo_Mors", "ZDPWLA_ItPl_Forestberry", 5);
	 AddIngre("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Mors", "ZDPWLA_ITFO_WINEBERRYS2", 5);
	 AddAlterIngre("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_Mors", 5);
	SetCraftScience("ZDPWLA_ItFo_Mors", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Mors", 25);

AddItemCategory ("Без профессии", "ZDPWLA_ItFo_Addon_Shellflesh"); ----- Мясо моллюска
	SetCraftAmount("ZDPWLA_ItFo_Addon_Shellflesh", 2);
     AddIngre("ZDPWLA_ItFo_Addon_Shellflesh", "OOLTYB_ItMi_ReMi2", 5);
	SetCraftPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_Shellflesh", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 25);
	
AddItemCategory ("Без профессии", "zdpwla_itfo_samogon"); ----- Самогон
	SetCraftAmount("zdpwla_itfo_samogon", 2);
     AddIngre("zdpwla_itfo_samogon", "zdpwla_itpl_temp_herb", 5);
	 AddIngre("zdpwla_itfo_samogon", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("zdpwla_itfo_samogon", "zdpwla_itfo_cane", 5);
	 AddAlterIngre("zdpwla_itfo_samogon", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("zdpwla_itfo_samogon", 5);
	SetCraftScience("zdpwla_itfo_samogon", "Без профессии", 0);
	SetenergyPenalty("zdpwla_itfo_samogon", 25);
	
AddItemCategory ("Без профессии", "ZDPWLA_ItFo_PoorSoup"); ----- Суп бедняка
	SetCraftAmount("ZDPWLA_ItFo_PoorSoup", 2);
	 AddIngre("ZDPWLA_ItFo_PoorSoup", "ZDPWLA_ItPl_Temp_Herb", 5);
	 AddAlterIngre("ZDPWLA_ItFo_PoorSoup", "zdpwla_itfo_cane", 5);
	SetCraftPenalty("ZDPWLA_ItFo_PoorSoup", 10);
	SetCraftScience("ZDPWLA_ItFo_PoorSoup", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ItFo_PoorSoup", 25);

AddItemCategory ("Без профессии", "ZDPWLA_ITFO_TEA"); ----- Чай
	SetCraftAmount("ZDPWLA_ITFO_TEA", 2);
	 AddIngre("ZDPWLA_ITFO_TEA", "ZDPWLA_ItPl_Mana_Herb_01", 5);
	 AddIngre("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("ZDPWLA_ITFO_TEA", "zdpwla_itpl_mana_herb_03", 2);
	 AddAlterIngre("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ITFO_TEA", 2);
	SetCraftScience("ZDPWLA_ITFO_TEA", "Без профессии", 0);
	SetenergyPenalty("ZDPWLA_ITFO_TEA", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ItMi_Joint"); ----- Самокрутка
	SetCraftAmount("OOLTYB_ItMi_Joint", 2);
     AddIngre("OOLTYB_ItMi_Joint", "ZDPWLA_ItPl_SwampHerb", 5);
     	AddTool("OOLTYB_ItMi_Joint", "ooltyb_itmi_jointrecipe1");
	SetCraftPenalty("OOLTYB_ItMi_Joint", 5);
	SetCraftScience("OOLTYB_ItMi_Joint", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ItMi_Joint", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ItMi_Coal"); ----- Уголь
	SetCraftAmount("OOLTYB_ItMi_Coal", 15);
     AddIngre("OOLTYB_ItMi_Coal", "OOLTYB_ITMI_WOOD", 25);
     AddAlterIngre("OOLTYB_ItMi_Coal", "OOLTYB_ITAT_CRAWLERPLATE", 15);
	SetCraftPenalty("OOLTYB_ItMi_Coal", 5);
	SetCraftScience("OOLTYB_ItMi_Coal", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ItMi_Coal", 25);
	
	AddItemCategory ("Без профессии", "OOLTYB_ITMI_Stroy"); ---- Строительные материалы
	SetCraftAmount("OOLTYB_ITMI_Stroy", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_OBRABOTDER", 1);
     AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_FIBER", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_LEATHER", 1);
	SetCraftPenalty("OOLTYB_ITMI_Stroy", 10);
	SetCraftScience("OOLTYB_ITMI_Stroy", "Без профессии", 0);
	SetenergyPenalty("OOLTYB_ITMI_Stroy", 25);
	
	AddItemCategory ("Без профессии", "itlstorch"); ---- Факел
	SetCraftAmount("itlstorch", 15);
	 AddIngre("itlstorch", "ooltyb_itmi_pitch", 1);
	 AddIngre("itlstorch", "jkztzd_itmw_1h_bau_mace", 1);
	SetCraftPenalty("itlstorch", 1);
	SetCraftScience("itlstorch", "Без профессии", 0);
	SetenergyPenalty("itlstorch", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk"); ---- Корзинка для зерна
	SetCraftAmount("yfauun_itar_koszyk", 1);
	 AddIngre("yfauun_itar_koszyk", "ooltyb_itmi_wheat", 1);
	SetCraftPenalty("yfauun_itar_koszyk", 1);
	SetCraftScience("yfauun_itar_koszyk", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk2"); ---- Корзинка для руды
	SetCraftAmount("yfauun_itar_koszyk2", 1);
	 AddIngre("yfauun_itar_koszyk2", "ooltyb_itmi_Iron", 1);
	SetCraftPenalty("yfauun_itar_koszyk2", 1);
	SetCraftScience("yfauun_itar_koszyk2", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk2", 10);
	
	AddItemCategory ("Без профессии", "yfauun_itar_koszyk3"); ---- Корзинка для травы
	SetCraftAmount("yfauun_itar_koszyk3", 1);
	 AddIngre("yfauun_itar_koszyk3", "zdpwla_itpl_temp_herb", 1);
	SetCraftPenalty("yfauun_itar_koszyk3", 1);
	SetCraftScience("yfauun_itar_koszyk2", "Без профессии", 0);
	SetenergyPenalty("yfauun_itar_koszyk3", 10);
	
--ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА	


-- Повар 1 домашняя утварь

AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_14"); ----- Деревянный кубок
	SetCraftAmount("rc_house_ware_14", 1);
	 AddIngre("rc_house_ware_14", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_ware_14", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_14", 10);
	SetCraftScience("rc_house_ware_14", "Повар", 1);
	SetenergyPenalty("rc_house_ware_14", 25);
	SetCraftEXP("rc_house_ware_14", 25)
	SetCraftEXP_SKILL("rc_house_ware_14", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_8"); ----- Кастрюля солянки
	SetCraftAmount("rc_house_ware_8", 1);
	 AddIngre("rc_house_ware_8", "ZDPWLA_ItFo_Addon_MeatSoup", 5);
	 AddIngre("rc_house_ware_8", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_8", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_8", 10);
	SetCraftScience("rc_house_ware_8", "Повар", 1);
	SetenergyPenalty("rc_house_ware_8", 25);
	SetCraftEXP("rc_house_ware_8", 25)
	SetCraftEXP_SKILL("rc_house_ware_8", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_7"); ----- Кастрюля ухи
	SetCraftAmount("rc_house_ware_7", 1);
	 AddIngre("rc_house_ware_7", "ZDPWLA_ItFo_FishSouP", 5);
	 AddIngre("rc_house_ware_7", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_7", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_7", 10);
	SetCraftScience("rc_house_ware_7", "Повар", 1);
	SetenergyPenalty("rc_house_ware_7", 25);
	SetCraftEXP("rc_house_ware_7", 25)
	SetCraftEXP_SKILL("rc_house_ware_7", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_5"); ----- Корзинка с пивом
	SetCraftAmount("rc_house_ware_5", 1);
	 AddIngre("rc_house_ware_5", "ZDPWLA_ItFo_Beer", 5);
	 AddIngre("rc_house_ware_5", "zdpwla_itpl_temp_herb", 10);
    AddTool("rc_house_ware_5", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_5", 10);
	SetCraftScience("rc_house_ware_5", "Повар", 1);
	SetenergyPenalty("rc_house_ware_5", 25);
	SetCraftEXP("rc_house_ware_5", 25)
	SetCraftEXP_SKILL("rc_house_ware_5", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_6"); ----- Маленькое блюдо
	SetCraftAmount("rc_house_ware_6", 1);
	 AddIngre("rc_house_ware_6", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_ware_6", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_6", 10);
	SetCraftScience("rc_house_ware_6", "Повар", 1);
	SetenergyPenalty("rc_house_ware_6", 25);
	SetCraftEXP("rc_house_ware_6", 25)
	SetCraftEXP_SKILL("rc_house_ware_6", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_create_5"); ----- Разбитый ящик
	SetCraftAmount("rc_house_create_5", 1);
	 AddIngre("rc_house_create_5", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_create_5", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_5", 10);
	SetCraftScience("rc_house_create_5", "Повар", 1);
	SetenergyPenalty("rc_house_create_5", 25);
	SetCraftEXP("rc_house_create_5", 25)
	SetCraftEXP_SKILL("rc_house_create_5", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_create_6"); ----- Старый ящик
	SetCraftAmount("rc_house_create_6", 1);
	 AddIngre("rc_house_create_6", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_create_6", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_6", 10);
	SetCraftScience("rc_house_create_6", "Повар", 1);
	SetenergyPenalty("rc_house_create_6", 25);
	SetCraftEXP("rc_house_create_6", 25)
	SetCraftEXP_SKILL("rc_house_create_6", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_11"); ----- Сушеные овощи на веревке
	SetCraftAmount("rc_house_ware_11", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_temp_herb", 5);
	 AddIngre("rc_house_ware_11", "zdpwla_itfo_plants_seraphis_01", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_mana_herb_01", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_health_herb_01", 1);
    AddTool("rc_house_ware_11", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_11", 10);
	SetCraftScience("rc_house_ware_11", "Повар", 1);
	SetenergyPenalty("rc_house_ware_11", 25);
	SetCraftEXP("rc_house_ware_11", 25)
	SetCraftEXP_SKILL("rc_house_ware_11", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_26"); ----- Тарелка каши
	SetCraftAmount("rc_house_ware_26", 1);
	 AddIngre("rc_house_ware_26", "ooltyb_itmi_wood", 5);
	 AddIngre("rc_house_ware_26", "zdpwla_itfo_millet", 10);
    AddTool("rc_house_ware_26", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_26", 10);
	SetCraftScience("rc_house_ware_26", "Повар", 1);
	SetenergyPenalty("rc_house_ware_26", 25);
	SetCraftEXP("rc_house_ware_26", 25)
	SetCraftEXP_SKILL("rc_house_ware_26", "Повар")
	
AddItemCategory ("Повар (Домашняя утварь)", "rc_house_ware_2"); ----- Тарелка с голубцами
	SetCraftAmount("rc_house_ware_2", 1);
	 AddIngre("rc_house_ware_2", "ZDPWLA_ItFo_MushroomCutlet", 5);
	 AddIngre("rc_house_ware_2", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_2", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("rc_house_ware_2", 10);
	SetCraftScience("rc_house_ware_2", "Повар", 1);
	SetenergyPenalty("rc_house_ware_2", 25);
	SetCraftEXP("rc_house_ware_2", 25)
	SetCraftEXP_SKILL("rc_house_ware_2", "Повар")

AddItemCategory ("Повар (Домашняя утварь)", "rc_house_create_4"); ----- Ящик с дровами
	SetCraftAmount("rc_house_create_4", 1);
	 AddIngre("rc_house_create_4", "ooltyb_itmi_wood", 20);
    AddTool("rc_house_create_4", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_4", 10);
	SetCraftScience("rc_house_create_4", "Повар", 1);
	SetenergyPenalty("rc_house_create_4", 25);
	SetCraftEXP("rc_house_create_4", 25)
	SetCraftEXP_SKILL("rc_house_create_4", "Повар")


-- ПОВАР 1 УРОВЕНЬ

AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_ACORNBOOZE"); ----- Желудевка
	SetCraftAmount("ZDPWLA_ITFO_ACORNBOOZE", 4);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 4);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_FlasK", 4);
    AddTool("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_ACORNBOOZE", 20);
	SetCraftScience("ZDPWLA_ITFO_ACORNBOOZE", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_ACORNBOOZE", 25);
	SetCraftEXP("ZDPWLA_ITFO_ACORNBOOZE", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_ACORNBOOZE", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_SmokedFish"); ----- Копченая рыба
	SetCraftAmount("ZDPWLA_ItFo_SmokedFish", 4);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "ZDPWLA_ItFo_Fish", 4);
	 AddTool("ZDPWLA_ItFo_SmokedFish", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_SmokedFish", 10);
	SetCraftScience("ZDPWLA_ItFo_SmokedFish", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_SmokedFish", 25);	
	SetCraftEXP("ZDPWLA_ItFo_SmokedFish", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_SmokedFish", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_MarinMushroom"); ----- Маринованные грибы
	SetCraftAmount("ZDPWLA_ItFo_MarinMushroom", 4);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_01", 4);
	 AddAlterIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_02", 4);
    AddTool("ZDPWLA_ItFo_MarinMushroom", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MarinMushroom", 5);
	SetCraftScience("ZDPWLA_ItFo_MarinMushroom", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_MarinMushroom", 25);	
	SetCraftEXP("ZDPWLA_ItFo_MarinMushroom", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MarinMushroom", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Addon_MeatSoup"); ----- Мясная похлебка
	SetCraftAmount("ZDPWLA_ItFo_Addon_MeatSoup", 4);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "ZDPWLA_ItFoMuttonRaw", 4);
    AddTool("ZDPWLA_ItFo_Addon_MeatSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_MeatSoup", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 25);
	SetCraftEXP("ZDPWLA_ItFo_Addon_MeatSoup", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Addon_MeatSoup", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Beer"); ----- пиво
	SetCraftAmount("ZDPWLA_ItFo_Beer", 4);
	 AddIngre("ZDPWLA_ItFo_Beer", "ooltyb_itmi_wheat", 4);
	 AddIngre("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Flask", 4);
	 AddAlterIngre("ZDPWLA_ItFo_Beer", "zdpwla_itpl_temp_herb", 4);
	 AddAlterIngre("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Flask", 4);
    AddTool("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Beer", 20);
	SetCraftScience("ZDPWLA_ItFo_Beer", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Beer", 25);
	SetCraftEXP("ZDPWLA_ItFo_Beer", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Beer", "Повар")

AddItemCategory ("Повар (1 уровень)", "zdpwla_itfo_addon_rum"); ----- пиво
	SetCraftAmount("zdpwla_itfo_addon_rum", 4);
	 AddIngre("zdpwla_itfo_addon_rum", "zdpwla_itfo_cane", 4);
	 AddIngre("zdpwla_itfo_addon_rum", "OOLTYB_ItMi_Flask", 4);
    AddTool("zdpwla_itfo_addon_rum", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("zdpwla_itfo_addon_rum", 20);
	SetCraftScience("zdpwla_itfo_addon_rum", "Повар", 1);
	SetenergyPenalty("zdpwla_itfo_addon_rum", 25);
	SetCraftEXP("zdpwla_itfo_addon_rum", 25)
	SetCraftEXP_SKILL("zdpwla_itfo_addon_rum", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ITFO_SOUP"); ----- Суп из кореньев
	SetCraftAmount("ZDPWLA_ITFO_SOUP", 4);
	 AddIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	 AddAlterIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ItPl_Strength_Herb_01", 1);
    AddTool("ZDPWLA_ITFO_SOUP", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_SOUP", 20);
	SetCraftScience("ZDPWLA_ITFO_SOUP", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ITFO_SOUP", 25);	
	SetCraftEXP("ZDPWLA_ITFO_SOUP", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_SOUP", "Повар")

AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_Cheese"); ----- Сыр
	SetCraftAmount("ZDPWLA_ItFo_Cheese", 4);
	 AddIngre("ZDPWLA_ItFo_Cheese", "ZDPWLA_ItFo_Milk", 4);
    AddTool("ZDPWLA_ItFo_Cheese", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Cheese", 5);
	SetCraftScience("ZDPWLA_ItFo_Cheese", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Cheese", 25);
	SetCraftEXP("ZDPWLA_ItFo_Cheese", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Cheese", "Повар")
	
AddItemCategory ("Повар (1 уровень)", "ZDPWLA_ItFo_AcornBread"); ----- Желудевый хлеб
	SetCraftAmount("ZDPWLA_ItFo_AcornBread", 4);
	 AddIngre("ZDPWLA_ItFo_AcornBread", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 4);
	 AddTool("ZDPWLA_ItFo_AcornBread", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_AcornBread", 20);
	SetCraftScience("ZDPWLA_ItFo_AcornBread", "Повар", 1);
	SetenergyPenalty("ZDPWLA_ItFo_AcornBread", 25);
	SetCraftEXP("ZDPWLA_ItFo_AcornBread", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_AcornBread", "Повар")

AddItemCategory ("Повар (1 уровень)", "zdpwla_itfo_ricebooze"); ----- шнапс
	SetCraftAmount("zdpwla_itfo_ricebooze", 4);
	 AddIngre("zdpwla_itfo_ricebooze", "ooltyb_itmi_wheat", 4);
	 AddIngre("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Flask", 4);
	 AddAlterIngre("zdpwla_itfo_ricebooze", "zdpwla_itfo_plants_seraphis_01", 4);
	 AddAlterIngre("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Flask", 4);
    AddTool("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("zdpwla_itfo_ricebooze", 20);
	SetCraftScience("zdpwla_itfo_ricebooze", "Повар", 1);
	SetenergyPenalty("zdpwla_itfo_ricebooze", 25);
	SetCraftEXP("zdpwla_itfo_ricebooze", 25)
	SetCraftEXP_SKILL("zdpwla_itfo_ricebooze", "Повар")

-- ПОВАР 2 УРОВЕНЬ

AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MBlinchik"); ----- Блины с медом
	SetCraftAmount("ZDPWLA_ItFo_MBlinchik", 6);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_wheat", 3);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_honeycomb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_MBlinchik", "zdpwla_itpl_temp_herb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_honeycomb", 3);
	 AddTool("ZDPWLA_ItFo_MBlinchik", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_MBlinchik", 20);
	SetCraftScience("ZDPWLA_ItFo_MBlinchik", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_MBlinchik", 50);
	SetCraftEXP("ZDPWLA_ItFo_MBlinchik", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MBlinchik", "Повар")

AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_MushroomCutlet"); ----- Грибная котлета
    SetCraftAmount("ZDPWLA_ItFo_MushroomCutlet", 6);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_01", 3);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_02", 3);
     AddAlterIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_01", 3);
     AddAlterIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mana_herb_03", 1);
    AddTool("ZDPWLA_ItFo_MushroomCutlet", "OOLTYB_ItMi_PaN");
    SetCraftPenalty("ZDPWLA_ItFo_MushroomCutlet", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomCutlet", "Повар", 2);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomCutlet", 50);
    SetCraftEXP("ZDPWLA_ItFo_MushroomCutlet", 50)
    SetCraftEXP_SKILL("ZDPWLA_ItFo_MushroomCutlet", "Повар")	
	
AddItemCategory ("Повар (2 уровень)", "zdpwla_itfo_addon_grog"); ----- Грог
    SetCraftAmount("zdpwla_itfo_addon_grog", 6);
     AddIngre("zdpwla_itfo_addon_grog", "zdpwla_itfo_cane", 3);
     AddIngre("zdpwla_itfo_addon_grog", "ooltyb_itmi_honeycomb", 3);
     AddIngre("zdpwla_itfo_addon_grog", "ooltyb_itmi_flask", 6);
    AddTool("zdpwla_itfo_addon_grog", "OOLTYB_ItMi_PaN");
    SetCraftPenalty("zdpwla_itfo_addon_grog", 10);
    SetCraftScience("zdpwla_itfo_addon_grog", "Повар", 2);
    SetenergyPenalty("zdpwla_itfo_addon_grog", 50);
    SetCraftEXP("zdpwla_itfo_addon_grog", 50)
    SetCraftEXP_SKILL("zdpwla_itfo_addon_grog", "Повар")	
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_BoozE"); ----- Джин
	SetCraftAmount("ZDPWLA_ItFo_BoozE", 6);
     AddIngre("ZDPWLA_ItFo_BoozE", "ooltyb_itmi_remi1", 3);
     AddIngre("ZDPWLA_ItFo_BoozE", "zdpwla_itpl_mana_herb_03", 3);
     AddIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_FlasK", 6);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "ooltyb_itmi_remi", 3);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "zdpwla_itfo_plants_towerwood_01", 3);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_FlasK", 6);
	 AddTool("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BoozE", 10);
	SetCraftScience("ZDPWLA_ItFo_BoozE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_BoozE", 50);
	SetCraftEXP("ZDPWLA_ItFo_BoozE", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BoozE", "Повар")

AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_Bread"); ----- Хлеб
	SetCraftAmount("ZDPWLA_ItFo_Bread", 6);
	 AddIngre("ZDPWLA_ItFo_Bread", "zdpwla_itfo_millet", 3);
	 AddIngre("ZDPWLA_ItFo_Bread", "zdpwla_itfo_egg", 3);
    AddTool("ZDPWLA_ItFo_Bread", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Bread", 5);
	SetCraftScience("ZDPWLA_ItFo_Bread", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Bread", 50);
	SetCraftEXP("ZDPWLA_ItFo_Bread", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bread", "Повар")
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_SausagE"); ----- Колбаса
	SetCraftAmount("ZDPWLA_ItFo_SausagE", 6);
	 AddIngre("ZDPWLA_ItFo_SausagE", "ZDPWLA_ItFoMuttonRaW", 3);
	 AddIngre("ZDPWLA_ItFo_SausagE", "OOLTYB_ItAt_Fat", 3);
    AddTool("ZDPWLA_ItFo_SausagE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_SausagE", 10);
	SetCraftScience("ZDPWLA_ItFo_SausagE", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_SausagE", 50);
	SetCraftEXP("ZDPWLA_ItFo_SausagE", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_SausagE", "Повар")
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_Medovuha"); ----- Медовуха
	SetCraftAmount("ZDPWLA_ItFo_Medovuha", 6);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ooltyb_itmi_honeycomb", 3);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ZDPWLA_ItPl_Forestberry", 3);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_FlasK", 6);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "ooltyb_itmi_honeycomb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "zdpwla_itpl_dex_herb_01", 3);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_FlasK", 6);
    AddTool("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Medovuha", 20);
	SetCraftScience("ZDPWLA_ItFo_Medovuha", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Medovuha", 50);
	SetCraftEXP("ZDPWLA_ItFo_Medovuha", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Medovuha", "Повар")	
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_FishBatter"); ----- Рыба в кляре
	SetCraftAmount("ZDPWLA_ItFo_FishBatter", 6);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "ZDPWLA_ItFo_Fish", 3);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "zdpwla_itfo_millet", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishBatter", "ZDPWLA_ItFo_Fish", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishBatter", "ooltyb_itmi_remi", 3);
    AddTool("ZDPWLA_ItFo_FishBatter", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_FishBatter", 10);
	SetCraftScience("ZDPWLA_ItFo_FishBatter", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_FishBatter", 50);
	SetCraftEXP("ZDPWLA_ItFo_FishBatter", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_FishBatter", "Повар")
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ItFo_FishSouP"); ----- Уха
	SetCraftAmount("ZDPWLA_ItFo_FishSouP", 6);
     AddIngre("ZDPWLA_ItFo_FishSouP", "ZDPWLA_ItFo_Fish", 3);
     AddIngre("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ReMi", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishSouP", "ooltyb_itmi_remi2", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishSouP", "zdpwla_itpl_mushroom_01", 3);
	 AddTool("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_FishSouP", 10);
	SetCraftScience("ZDPWLA_ItFo_FishSouP", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ItFo_FishSouP", 50);
	SetCraftEXP("ZDPWLA_ItFo_FishSouP", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_FishSouP", "Повар")	
	
AddItemCategory ("Повар (2 уровень)", "ZDPWLA_ITFO_BERRYSALAD"); ----- Ягодный салат
	SetCraftAmount("ZDPWLA_ITFO_BERRYSALAD", 6);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "ZDPWLA_ItPl_Forestberry", 3);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itpl_dex_herb_01", 3);
	 AddAlterIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itfo_plants_seraphis_01", 3);
	 AddAlterIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itfo_plants_trollberrys_01", 3);
    AddTool("ZDPWLA_ITFO_BERRYSALAD", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_BERRYSALAD", 5);
	SetCraftScience("ZDPWLA_ITFO_BERRYSALAD", "Повар", 2);
	SetenergyPenalty("ZDPWLA_ITFO_BERRYSALAD", 50);
	SetCraftEXP("ZDPWLA_ITFO_BERRYSALAD", 50)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BERRYSALAD", "Повар")
	
-- ПОВАР 3 УРОВЕНЬ
	
AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Bomber"); ----- Бомбер
	SetCraftAmount("ZDPWLA_ItFo_Bomber", 8);
     AddIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itpl_strength_herb_01", 2);
     AddIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itpl_mana_herb_03", 2);
     AddIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itfo_plants_stoneroot_01", 2);
     AddIngre("ZDPWLA_ItFo_Bomber", "OOLTYB_ItMi_FlasK", 8);
     AddAlterIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itfo_plants_towerwood_01", 2);
     AddAlterIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itpl_mushroom_04", 2);
     AddAlterIngre("ZDPWLA_ItFo_Bomber", "zdpwla_itfo_plants_stoneroot_01", 2);
     AddAlterIngre("ZDPWLA_ItFo_Bomber", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_Bomber", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_Bomber", 20);
	SetCraftScience("ZDPWLA_ItFo_Bomber", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bomber", 75);
	SetCraftEXP("ZDPWLA_ItFo_Bomber", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bomber", "Повар")
	

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_WinE"); ----- Вино
	SetCraftAmount("ZDPWLA_ItFo_WinE", 8);
     AddIngre("ZDPWLA_ItFo_WinE", "zdpwla_itfo_wineberrys2", 2);
	 AddIngre("ZDPWLA_ItFo_WinE", "zdpwla_itpl_forestberry", 2);
	 AddIngre("ZDPWLA_ItFo_WinE", "zdpwla_itfo_plants_seraphis_01", 2);
     AddIngre("ZDPWLA_ItFo_WinE", "OOLTYB_ItMi_FlasK", 8);
     AddAlterIngre("ZDPWLA_ItFo_WinE", "zdpwla_itfo_wineberrys2", 2);
	 AddAlterIngre("ZDPWLA_ItFo_WinE", "zdpwla_itfo_plants_trollberrys_01", 2);
	 AddAlterIngre("ZDPWLA_ItFo_WinE", "zdpwla_itfo_plants_seraphis_01", 2);
     AddAlterIngre("ZDPWLA_ItFo_WinE", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_WinE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_WinE", 20);
	SetCraftScience("ZDPWLA_ItFo_WinE", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_WinE", 75);
	SetCraftEXP("ZDPWLA_ItFo_WinE", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_WinE", "Повар")	
	
AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_HoneyMeat"); ----- Мясо в медовом соусе
	SetCraftAmount("ZDPWLA_ItFo_HoneyMeat", 8);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_HoneyMeat", "ooltyb_itmi_honeycomb", 2);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 2);
     AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "ooltyb_itmi_honeycomb", 2);
     AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "zdpwla_itpl_mana_herb_01", 2);
	 AddTool("ZDPWLA_ItFo_HoneyMeat", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_HoneyMeat", 10);
	SetCraftScience("ZDPWLA_ItFo_HoneyMeat", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_HoneyMeat", 75);
	SetCraftEXP("ZDPWLA_ItFo_HoneyMeat", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_HoneyMeat", "Повар")	

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Bacon"); ----- Окорок
	SetCraftAmount("ZDPWLA_ItFo_Bacon", 8);
	 AddIngre("ZDPWLA_ItFo_Bacon", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itpl_mana_herb_01", 2);
	 AddIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itfo_plants_seraphis_01", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Bacon", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Bacon", "ooltyb_itmi_remi1", 2);
     AddAlterIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itfo_plants_seraphis_01", 2);
	 AddTool("ZDPWLA_ItFo_Bacon", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_Bacon", 10);
	SetCraftScience("ZDPWLA_ItFo_Bacon", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bacon", 75);	
	SetCraftEXP("ZDPWLA_ItFo_Bacon", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bacon", "Повар")	

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BeafPie"); ----- Пирог со шкварками
	SetCraftAmount("ZDPWLA_ItFo_BeafPie", 8);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_millet", 2);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_egg", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BeafPie", "ooltyb_itat_fat", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_millet", 2);
     AddAlterIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_egg", 2);
	 AddTool("ZDPWLA_ItFo_BeafPie", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_BeafPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BeafPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BeafPie", 75);	
	SetCraftEXP("ZDPWLA_ItFo_BeafPie", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BeafPie", "Повар")	

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_Casserole"); ----- Фермерская запеканка
	SetCraftAmount("ZDPWLA_ItFo_Casserole", 8);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itpl_mushroom_04", 2);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_egg", 2);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_millet", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Casserole", "ooltyb_itat_fat", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_millet", 2);
     AddAlterIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_plants_stoneroot_01", 2);
	 AddTool("ZDPWLA_ItFo_Casserole", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_Casserole", 10);
	SetCraftScience("ZDPWLA_ItFo_Casserole", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Casserole", 75);	
	SetCraftEXP("ZDPWLA_ItFo_Casserole", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Casserole", "Повар")	

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_BARBECUE"); ----- Шашлык
	SetCraftAmount("ZDPWLA_ITFO_BARBECUE", 8);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "zdpwla_itpl_mushroom_02", 2);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "zdpwla_itpl_temp_herb", 2);
    AddTool("ZDPWLA_ITFO_BARBECUE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ITFO_BARBECUE", 10);
	SetCraftScience("ZDPWLA_ITFO_BARBECUE", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_BARBECUE", 75);
	SetCraftEXP("ZDPWLA_ITFO_BARBECUE", 75)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BARBECUE", "Повар")		
	
AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BerryLiqueur"); ----- Ягодная наливка
	SetCraftAmount("ZDPWLA_ItFo_BerryLiqueur", 8);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "zdpwla_itfo_plants_seraphis_01", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Forestberry", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Dex_Herb_01", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BerryLiqueur", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryLiqueur", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryLiqueur", 75);
	SetCraftEXP("ZDPWLA_ItFo_BerryLiqueur", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BerryLiqueur", "Повар")

AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ItFo_BerryPie"); ----- Ягодный пирог
	SetCraftAmount("ZDPWLA_ItFo_BerryPie", 8);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_millet", 2);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "ZDPWLA_ItPl_Forestberry", 2);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_egg", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_millet", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itpl_dex_herb_01", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_egg", 2);
	 AddTool("ZDPWLA_ItFo_BerryPie", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_BerryPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryPie", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryPie", 75);	
	SetCraftEXP("ZZDPWLA_ItFo_BerryPie", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BerryPie", "Повар")
	
AddItemCategory ("Повар (3 уровень)", "ZDPWLA_ITFO_FRIEDEGG"); ----- Яичница с колбасой
	SetCraftAmount("ZDPWLA_ITFO_FRIEDEGG", 8);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ITFO_EGG", 2);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfo_plants_stoneroot_01", 2);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfomuttonraw", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ITFO_EGG", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfo_milk", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfomuttonraw", 2);
	 AddTool("ZDPWLA_ITFO_FRIEDEGG", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ITFO_FRIEDEGG", 5);
	SetCraftScience("ZDPWLA_ITFO_FRIEDEGG", "Повар", 3);
	SetenergyPenalty("ZDPWLA_ITFO_FRIEDEGG", 75);		
	SetCraftEXP("ZDPWLA_ITFO_FRIEDEGG", 75)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_FRIEDEGG", "Повар")

-- ПОВАР 4 УРОВЕНЬ

AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ITFO_SHAURMA"); ----- Амброзия в лаваше
	SetCraftAmount("ZDPWLA_ITFO_SHAURMA", 10);
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "ZDPWLA_ItFoMuttonRaW", 1); 
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "zdpwla_itfo_millet", 1);
     AddIngre("ZDPWLA_ITFO_SHAURMA", "zdpwla_itpl_mushroom_02", 1);	 
     AddIngre("ZDPWLA_ITFO_SHAURMA", "ooltyb_itat_fat", 1);	 
	 AddTool("ZDPWLA_ITFO_SHAURMA", "JKZTZD_ITMW_1H_KNIFE_01");
	SetCraftPenalty("ZDPWLA_ITFO_SHAURMA", 20);
	SetCraftScience("ZDPWLA_ITFO_SHAURMA", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ITFO_SHAURMA", 100);
	
AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ItFo_MagicSoup"); ----- Волшебный суп
	SetCraftAmount("ZDPWLA_ItFo_MagicSoup", 10);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itpl_mushroom_04", 1);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itpl_temp_herb", 1);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itfo_plants_trollberrys_01", 1);
	 AddIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itfo_plants_towerwood_01", 1);
	 AddAlterIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itpl_mushroom_04", 1);
	 AddAlterIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itpl_strength_herb_01", 1);
	 AddAlterIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itpl_mushroom_01", 1);
	 AddAlterIngre("ZDPWLA_ItFo_MagicSoup", "zdpwla_itfo_plants_towerwood_01", 1);
	 AddTool("ZDPWLA_ItFo_MagicSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MagicSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_MagicSoup", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ItFo_MagicSoup", 100);
	
AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ItFo_Managa"); ----- Манага
	SetCraftAmount("ZDPWLA_ItFo_Managa", 10);
	 AddIngre("ZDPWLA_ItFo_Managa", "ZDPWLA_ItFo_Milk", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "ooltyb_itmi_remi1", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "zdpwla_itpl_mushroom_04", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "zdpwla_itpl_mana_herb_03", 1);
	 AddTool("ZDPWLA_ItFo_Managa", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Managa", 10);
	SetCraftScience("ZDPWLA_ItFo_Managa", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ItFo_Managa", 100);	

AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ITFO_HONEYBISCUIT"); ----- Медовое печенье
	SetCraftAmount("ZDPWLA_ITFO_HONEYBISCUIT", 10);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "ooltyb_itmi_honeycomb", 1);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "zdpwla_itfo_millet", 1);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "zdpwla_itfo_egg", 1);
	 AddIngre("ZDPWLA_ITFO_HONEYBISCUIT", "zdpwla_itfo_milk", 1);
	 AddAlterIngre("ZDPWLA_ITFO_HONEYBISCUIT", "ooltyb_itmi_honeycomb", 1);
	 AddAlterIngre("ZDPWLA_ITFO_HONEYBISCUIT", "zdpwla_itfo_millet", 1);
	 AddAlterIngre("ZDPWLA_ITFO_HONEYBISCUIT", "ooltyb_itat_fat", 1);
	 AddAlterIngre("ZDPWLA_ITFO_HONEYBISCUIT", "zdpwla_itfo_milk", 1);
	 AddTool("ZDPWLA_ITFO_HONEYBISCUIT", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 20);
	SetCraftScience("ZDPWLA_ITFO_HONEYBISCUIT", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 100);
	
AddItemCategory ("Повар (4 уровень)", "zdpwla_itfo_monk_wine"); ----- Монастырское вино
	SetCraftAmount("zdpwla_itfo_monk_wine", 10);
	 AddIngre("zdpwla_itfo_monk_wine", "zdpwla_itfo_wineberrys2", 1);
	 AddIngre("zdpwla_itfo_monk_wine", "zdpwla_itpl_strength_herb_01", 1);
	 AddIngre("zdpwla_itfo_monk_wine", "zdpwla_itpl_dex_herb_01", 1);
	 AddIngre("zdpwla_itfo_monk_wine", "zdpwla_itfo_plants_trollberrys_01", 1);
	 AddIngre("zdpwla_itfo_monk_wine", "ooltyb_itmi_flask", 10);
	 AddAlterIngre("zdpwla_itfo_monk_wine", "zdpwla_itpl_mana_herb_01", 1);
	 AddAlterIngre("zdpwla_itfo_monk_wine", "zdpwla_itpl_mana_herb_03", 1);
	 AddAlterIngre("zdpwla_itfo_monk_wine", "zdpwla_itfo_plants_trollberrys_01", 1);
	 AddAlterIngre("zdpwla_itfo_monk_wine", "zdpwla_itfo_wineberrys2", 1);
	 AddAlterIngre("zdpwla_itfo_monk_wine", "ooltyb_itmi_flask", 10);
	 AddTool("zdpwla_itfo_monk_wine", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("zdpwla_itfo_monk_wine", 20);
	SetCraftScience("zdpwla_itfo_monk_wine", "Повар", 4);
	SetenergyPenalty("zdpwla_itfo_monk_wine", 100);

AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ITFO_SEASALAD"); ----- Морской салат
	SetCraftAmount("ZDPWLA_ITFO_SEASALAD", 10);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi1", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi2", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "zdpwla_itfo_cane", 1);
	 AddTool("ZDPWLA_ITFO_SEASALAD", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ITFO_SEASALAD", 10);
	SetCraftScience("ZDPWLA_ITFO_SEASALAD", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ITFO_SEASALAD", 100);
	
AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ItFo_Addon_FireSteW"); ----- Пламенная нарезка
	SetCraftAmount("ZDPWLA_ItFo_Addon_FireSteW", 10);
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "zdpwla_itpl_mana_herb_01", 1); 
	 AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "ooltyb_itmi_remi2", 1);
     AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "ooltyb_itat_fat", 1);	 
     AddIngre("ZDPWLA_ItFo_Addon_FireSteW", "zdpwla_itfo_plants_stoneroot_01", 1);	 
	 AddAlterIngre("ZDPWLA_ItFo_Addon_FireSteW", "ooltyb_itmi_remi1", 1); 
	 AddAlterIngre("ZDPWLA_ItFo_Addon_FireSteW", "ooltyb_itmi_remi2", 1);
     AddAlterIngre("ZDPWLA_ItFo_Addon_FireSteW", "zdpwla_itpl_strength_herb_01", 1);	 
     AddAlterIngre("ZDPWLA_ItFo_Addon_FireSteW", "zdpwla_itfo_milk", 1);	 
	 AddTool("ZDPWLA_ItFo_Addon_FireSteW", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_FireSteW", 10);
	SetCraftScience("ZDPWLA_ItFo_Addon_FireSteW", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_FireSteW", 100);
	
AddItemCategory ("Повар (4 уровень)", "zdpwla_itfo_cake"); ----- Сладкий рулет
	SetCraftAmount("zdpwla_itfo_cake", 10);
	 AddIngre("zdpwla_itfo_cake", "zdpwla_itfo_millet", 1); 
	 AddIngre("zdpwla_itfo_cake", "zdpwla_itfo_egg", 1);
     AddIngre("zdpwla_itfo_cake", "zdpwla_itfo_wineberrys2", 1);	 
     AddIngre("zdpwla_itfo_cake", "zdpwla_itfo_milk", 1);	 
	 AddAlterIngre("zdpwla_itfo_cake", "zdpwla_itfo_millet", 1); 
	 AddAlterIngre("zdpwla_itfo_cake", "zdpwla_itfo_egg", 1);
     AddAlterIngre("zdpwla_itfo_cake", "zdpwla_itpl_dex_herb_01", 1);	 
     AddAlterIngre("zdpwla_itfo_cake", "zdpwla_itfo_milk", 1);	 
	 AddTool("zdpwla_itfo_cake", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("zdpwla_itfo_cake", 10);
	SetCraftScience("zdpwla_itfo_cake", "Повар", 4);
	SetenergyPenalty("zdpwla_itfo_cake", 100);
	
AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ItFo_OysterSoup"); ----- Суп из устриц
	SetCraftAmount("ZDPWLA_ItFo_OysterSoup", 10);
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ooltyb_itmi_remi", 1); 
	 AddIngre("ZDPWLA_ItFo_OysterSoup", "ooltyb_itmi_remi1", 1);
     AddIngre("ZDPWLA_ItFo_OysterSoup", "ooltyb_itmi_remi2", 1);	 
     AddIngre("ZDPWLA_ItFo_OysterSoup", "zdpwla_itfo_plants_seraphis_01", 1);	 
	 AddAlterIngre("ZDPWLA_ItFo_OysterSoup", "ooltyb_itmi_remi", 1); 
	 AddAlterIngre("ZDPWLA_ItFo_OysterSoup", "zdpwla_itfo_fish", 1);
     AddAlterIngre("ZDPWLA_ItFo_OysterSoup", "zdpwla_itpl_mana_herb_01", 1);	 
     AddAlterIngre("ZDPWLA_ItFo_OysterSoup", "ooltyb_itmi_remi2", 1);	 
	 AddTool("ZDPWLA_ItFo_OysterSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_OysterSoup", 20);
	SetCraftScience("ZDPWLA_ItFo_OysterSoup", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ItFo_OysterSoup", 100);	
	
AddItemCategory ("Повар (4 уровень)", "ZDPWLA_ItFo_WineStew"); ----- Тушеное мясо в вине
	SetCraftAmount("ZDPWLA_ItFo_WineStew", 10);
	 AddIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfomuttonraw", 1); 
	 AddIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfo_wineberrys2", 1);
     AddIngre("ZDPWLA_ItFo_WineStew", "ooltyb_itat_fat", 1);	 
     AddIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itpl_strength_herb_01", 1);	 
	 AddAlterIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfomuttonraw", 1); 
	 AddAlterIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfo_wineberrys2", 1);
     AddAlterIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfo_plants_trollberrys_01", 1);	 
     AddAlterIngre("ZDPWLA_ItFo_WineStew", "zdpwla_itfo_cane", 1);	 
	 AddTool("ZDPWLA_ItFo_WineStew", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_WineStew", 10);
	SetCraftScience("ZDPWLA_ItFo_WineStew", "Повар", 4);
	SetenergyPenalty("ZDPWLA_ItFo_WineStew", 100);		

-- АЛХИМИЯ ДОМАШНЯЯ УТВАРЬ

AddItemCategory ("Алхимия (Домашняя утварь)", "rc_house_ware_20"); ----- Бутыль браги
	SetCraftAmount("rc_house_ware_20", 1);
	 AddIngre("rc_house_ware_20", "ZDPWLA_ItPl_Temp_Herb", 5);
	 AddIngre("rc_house_ware_20", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_20", 10);
	SetCraftScience("rc_house_ware_20", "Алхимия", 1);
	SetenergyPenalty("rc_house_ware_20", 25);
	SetCraftEXP("rc_house_ware_20", 25)
	SetCraftEXP_SKILL("rc_house_ware_20", "Алхимия")
	
AddItemCategory ("Алхимия (Домашняя утварь)", "rc_house_ware_12"); ----- Бутыль вина
	SetCraftAmount("rc_house_ware_12", 1);
	 AddIngre("rc_house_ware_12", "zdpwla_itfo_wineberrys2", 5);
	 AddIngre("rc_house_ware_12", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_12", 10);
	SetCraftScience("rc_house_ware_12", "Алхимия", 1);
	SetenergyPenalty("rc_house_ware_12", 25);
	SetCraftEXP("rc_house_ware_12", 25)
	SetCraftEXP_SKILL("rc_house_ware_12", "Алхимия")
	
AddItemCategory ("Алхимия (Домашняя утварь)", "rc_house_ware_25"); ----- Бутыль воды
	SetCraftAmount("rc_house_ware_25", 1);
	 AddIngre("rc_house_ware_25", "ooltyb_itmi_coal", 5);
	 AddIngre("rc_house_ware_25", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("rc_house_ware_25", 10);
	SetCraftScience("rc_house_ware_25", "Алхимия", 1);
	SetenergyPenalty("rc_house_ware_25", 25);
	SetCraftEXP("rc_house_ware_25", 25)
	SetCraftEXP_SKILL("rc_house_ware_25", "Алхимия")
	
AddItemCategory ("Алхимия (Домашняя утварь)", "rc_house_ware_15"); ----- Бутыль джина
	SetCraftAmount("rc_house_ware_15", 1);
	 AddIngre("rc_house_ware_15", "ooltyb_itmi_remi1", 5);
	 AddIngre("rc_house_ware_15", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_15", 10);
	SetCraftScience("rc_house_ware_15", "Алхимия", 1);
	SetenergyPenalty("rc_house_ware_15", 25);
	SetCraftEXP("rc_house_ware_15", 25)
	SetCraftEXP_SKILL("rc_house_ware_15", "Алхимия")

AddItemCategory ("Алхимия (Домашняя утварь)", "rc_house_ware_13"); ----- Бутыль пива
	SetCraftAmount("rc_house_ware_13", 1);
	 AddIngre("rc_house_ware_13", "ooltyb_itmi_wheat", 5);
	 AddIngre("rc_house_ware_13", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_13", 10);
	SetCraftScience("rc_house_ware_13", "Алхимия", 1);
	SetenergyPenalty("rc_house_ware_13", 25);
	SetCraftEXP("rc_house_ware_13", 25)
	SetCraftEXP_SKILL("rc_house_ware_13", "Алхимия")

-- АЛХИМИЯ 1 УРОВЕНЬ

AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_AlchBasis"); ----- Алхимическая основа
	SetCraftAmount("ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ItMi_ReMi1", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Strength_Herb_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 1);
    AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Perm_Herb", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ItPl_Dex_Herb_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchBasis", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 1)
	SetCraftPenalty("ZDPWLA_ItMi_AlchBasis", 10);
	SetCraftScience("ZDPWLA_ItMi_AlchBasis", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchBasis", 25);
	SetCraftEXP("ZDPWLA_ItMi_AlchBasis", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_AlchBasis", "Алхимия")

AddItemCategory ("Алхимия (1 уровень)", "ZDPWLA_ItMi_AlchSub"); ----- Алхимический субстрат
	SetCraftAmount("ZDPWLA_ItMi_AlchSub", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_BugMandibles", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_WaranFiretongue", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	AddIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Perm_Herb", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_CrawlerMandibles", 1);
    AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItAt_Wing", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Mushroom_04", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "ZDPWLA_ItPl_Strength_Herb_01", 1);
	AddAlterIngre("ZDPWLA_ItMi_AlchSub", "OOLTYB_ItMi_ReMi", 1)
	SetCraftPenalty("ZDPWLA_ItMi_AlchSub", 10);
	SetCraftScience("ZDPWLA_ItMi_AlchSub", "Алхимия", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchSub", 25);
	SetCraftEXP("ZDPWLA_ItMi_AlchSub", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_AlchSub", "Алхимия")

AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_JOINT_1");  ----- Вялый Джо
	SetCraftAmount("OOLTYB_ITMI_JOINT_1", 4);
	 AddIngre("OOLTYB_ITMI_JOINT_1", "ZDPWLA_ItPl_SwampHerb", 4);
	 AddTool("OOLTYB_ITMI_JOINT_1", "OOLTYB_ITMI_JOINTRECIPE1");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_1", 5);
	SetCraftScience("OOLTYB_ITMI_JOINT_1", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_1", 25);
	SetCraftEXP("OOLTYB_ITMI_JOINT_1", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_JOINT_1", "Алхимия")

AddItemCategory ("Алхимия (1 уровень)", "ZEQFRN_ItPo_Health_01");  ----- Лечебная эссенция
	SetCraftAmount("ZEQFRN_ItPo_Health_01", 5);
	AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Health_01", "ZDPWLA_ItPl_Health_Herb_01", 5);
    AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITAT_CRAWLERMANDIBLES", 3);
    AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("ZEQFRN_ItPo_Health_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_01", "Алхимия", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Health_01", 25);
	SetCraftEXP("ZEQFRN_ItPo_Health_01", 25)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Health_01", "Алхимия")

AddItemCategory ("Алхимия (1 уровень)", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01");  ---- Спирт
	SetCraftAmount("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 5);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "ZDPWLA_ItPl_Temp_Herb", 5);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "zdpwla_itfo_plants_seraphis_01", 5);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 5);
	SetCraftScience("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "Алхимия", 1);
	SetenergyPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 25);
	SetCraftEXP("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "Алхимия")

AddItemCategory ("Алхимия (1 уровень)", "ZEQFRN_ItPo_Mana_01"); ---- Эссенция маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_01", 5);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Mana_01", "ZDPWLA_ItPl_Mana_Herb_01", 5);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITAT_CRAWLERMANDIBLES", 3);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_01", "Алхимия", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_01", 25);
	SetCraftEXP("ZEQFRN_ItPo_Mana_01", 25)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Mana_01", "Алхимия")
	

-- АЛХИМИЯ 2 УРОВЕНЬ

AddItemCategory ("Алхимия (2 уровень)", "ZDPWLA_ItMi_Glue");  ---- Клей
	SetCraftAmount("ZDPWLA_ItMi_Glue", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Sulfur", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Pitch", 1);
	SetCraftPenalty("ZDPWLA_ItMi_Glue", 10);
	SetCraftScience("ZDPWLA_ItMi_Glue", "Алхимия", 2);
	SetenergyPenalty("ZDPWLA_ItMi_Glue", 50);
	SetCraftEXP("ZDPWLA_ItMi_Glue", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_Glue", "Алхимия")

AddItemCategory ("Алхимия (2 уровень)", "ZDPWLA_ItMi_Dye");  ---- Краска
	SetCraftAmount("ZDPWLA_ItMi_Dye", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "OOLTYB_ItMi_ReMi2", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 1);	
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_EGG", 1);
	SetCraftPenalty("ZDPWLA_ItMi_Dye", 10);
	SetCraftScience("ZDPWLA_ItMi_Dye", "Алхимия", 2);
	SetenergyPenalty("ZDPWLA_ItMi_Dye", 50);
	SetCraftEXP("ZDPWLA_ItMi_Dye", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_Dye", "Алхимия")
	
AddItemCategory ("Алхимия (2 уровень)", "ZEQFRN_ItPo_Health_02"); ----- Лечебный экстракт
	SetCraftAmount("ZEQFRN_ItPo_Health_02", 10);
	AddIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Health_02", "ZEQFRN_ItPo_Health_01", 1);
	AddIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItPl_Health_Herb_02", 5);
	AddIngre("ZEQFRN_ItPo_Health_02", "OOLTYB_ItMi_FlasK", 10);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "ZEQFRN_ItPo_Health_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "ZDPWLA_ItPl_Health_Herb_02", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_02", "OOLTYB_ItMi_FlasK", 10);
	SetCraftPenalty("ZEQFRN_ItPo_Health_02", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_02", "Алхимия", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Health_02", 50);
	SetCraftEXP("ZEQFRN_ItPo_Health_02", 50)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Health_02", "Алхимия")

AddItemCategory ("Алхимия (2 уровень)", "OOLTYB_ITMI_JOINT_2");  ----- Северный темный
	SetCraftAmount("OOLTYB_ITMI_JOINT_2", 6);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ItPl_SwampHerb", 3);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 3);
	 AddTool("OOLTYB_ITMI_JOINT_2", "OOLTYB_ITMI_JOINTRECIPE2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_2", 10);
	SetCraftScience("OOLTYB_ITMI_JOINT_2", "Алхимия", 2);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_2", 50);
	SetCraftEXP("OOLTYB_ITMI_JOINT_2", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_JOINT_2", "Алхимия")

AddItemCategory ("Алхимия (2 уровень)", "ZEQFRN_ItPo_Mana_02"); --- Экстракт маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_02", 10);
	AddIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Mana_02", "ZEQFRN_ItPo_Mana_01", 1);
	AddIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItPl_Mana_Herb_02", 5);
	AddIngre("ZEQFRN_ItPo_Mana_02", "OOLTYB_ItMi_FlasK", 10);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "ZEQFRN_ItPo_Mana_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "ZDPWLA_ItPl_Mana_Herb_02", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_02", "OOLTYB_ItMi_FlasK", 10);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_02", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_02", "Алхимия", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_02", 50);
	SetCraftEXP("ZEQFRN_ItPo_Mana_02", 50)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Mana_02", "Алхимия")

-- АЛХИМИЯ 3 УРОВЕНЬ

AddItemCategory ("Алхимия (3 уровень)", "OOLTYB_ITMI_JOINT_3");  ----- Мечта рудокопа
	SetCraftAmount("OOLTYB_ITMI_JOINT_3", 8);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_SwampHerb", 2);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "zdpwla_itpl_mushroom_02", 2);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_Mushroom_04", 2);
	 AddTool("OOLTYB_ITMI_JOINT_3", "OOLTYB_ITMI_JOINTRECIPE2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_3", 20);
	SetCraftScience("OOLTYB_ITMI_JOINT_3", "Алхимия", 3);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_3", 75);
	
	
AddItemCategory ("Алхимия (3 уровень)", "ZDPWLA_ItFo_Opus");  ----- Опус Максима
	SetCraftAmount("ZDPWLA_ItFo_Opus", 8);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchBasis", 1);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchSub", 1);
	 AddIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_Opus", "OOLTYB_ITMI_OPUSRECIPE");
	SetCraftPenalty("ZDPWLA_ItFo_Opus", 20);
	SetCraftScience("ZDPWLA_ItFo_Opus", "Алхимия", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Opus", 75);	


AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ItPo_Health_03"); ---- Лечебный эликсир
	SetCraftAmount("ZEQFRN_ItPo_Health_03", 15);
	AddIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Health_03", "ZEQFRN_ItPo_Health_02", 1);
	AddIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 20);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "ZEQFRN_ItPo_Health_02", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 15);
	SetCraftPenalty("ZEQFRN_ItPo_Health_03", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_03", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Health_03", 75);


AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ItPo_Mana_03"); ---- Эликсир маны
	SetCraftAmount("ZEQFRN_ItPo_Mana_03", 15);
	AddIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItMi_AlchBasis", 1);
	AddIngre("ZEQFRN_ItPo_Mana_03", "ZEQFRN_ItPo_Mana_02", 1);
	AddIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItPl_Mana_Herb_03", 5);
	AddIngre("ZEQFRN_ItPo_Mana_03", "OOLTYB_ItMi_FlasK", 15);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItMi_AlchSub", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "ZEQFRN_ItPo_Mana_02", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "ZDPWLA_ItPl_Mana_Herb_03", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_03", "OOLTYB_ItMi_FlasK", 15);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_03", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_03", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_03", 75);
	

AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_SON");  ---- Снотворное
	SetCraftAmount("ZEQFRN_ITPO_SON", 1);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ItPl_SwampHerb", 6);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 5);
	AddIngre("ZEQFRN_ITPO_SON", "OOLTYB_ItMi_FlasK", 1);
	SetCraftPenalty("ZEQFRN_ITPO_SON", 20);
	SetCraftScience("ZEQFRN_ITPO_SON", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_SON", 75);

	
AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_IAD");  ---- Яд
	SetCraftAmount("ZEQFRN_ITPO_IAD", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_SharkTeeth", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	SetCraftPenalty("ZEQFRN_ITPO_IAD", 20);
	SetCraftScience("ZEQFRN_ITPO_IAD", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_IAD", 75);
	
	
AddItemCategory ("Алхимия (3 уровень)", "ZEQFRN_ITPO_ANTIDOTE");  ---- Антидот
	SetCraftAmount("ZEQFRN_ITPO_ANTIDOTE", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_SharkTeeth", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 3);
	SetCraftPenalty("ZEQFRN_ITPO_ANTIDOTE", 20);
	SetCraftScience("ZEQFRN_ITPO_ANTIDOTE", "Алхимия", 3);
	SetenergyPenalty("ZEQFRN_ITPO_ANTIDOTE", 75);


-- ОРУЖЕЙНИК 1 ДОМАШНЯЯ УТВАРЬ

AddItemCategory ("Оружейник (Домашняя утварь)", "rc_house_ware_1"); ----- Железный бокал
	SetCraftAmount("rc_house_ware_1", 1);
	 AddIngre("rc_house_ware_1", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_1", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_ware_1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_1", 5);
	SetCraftScience("rc_house_ware_1", "Оружейник", 1);
	SetenergyPenalty("rc_house_ware_1", 25);
	SetCraftEXP("rc_house_ware_1", 25)
	SetCraftEXP_SKILL("rc_house_ware_1", "Оружейник")
	
AddItemCategory ("Оружейник (Домашняя утварь)", "rc_house_ware_3"); ----- Тарелка под еду
	SetCraftAmount("rc_house_ware_3", 1);
	 AddIngre("rc_house_ware_3", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_3", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_ware_3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_3", 5);
	SetCraftScience("rc_house_ware_3", "Оружейник", 1);
	SetenergyPenalty("rc_house_ware_3", 25);
	SetCraftEXP("rc_house_ware_3", 25)
	SetCraftEXP_SKILL("rc_house_ware_3", "Оружейник")
	
AddItemCategory ("Оружейник (Домашняя утварь)", "rc_house_ware_10"); ----- Кастрюля с ручкой
	SetCraftAmount("rc_house_ware_10", 1);
	 AddIngre("rc_house_ware_10", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_10", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_ware_10", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_10", 5);
	SetCraftScience("rc_house_ware_10", "Оружейник", 1);
	SetenergyPenalty("rc_house_ware_10", 25);
	SetCraftEXP("rc_house_ware_10", 25)
	SetCraftEXP_SKILL("rc_house_ware_10", "Оружейник")
	
AddItemCategory ("Оружейник (Домашняя утварь)", "rc_house_ware_4"); ----- Столовые приборы
	SetCraftAmount("rc_house_ware_4", 1);
	 AddIngre("rc_house_ware_4", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_3", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_ware_4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_4", 5);
	SetCraftScience("rc_house_ware_4", "Оружейник", 1);
	SetenergyPenalty("rc_house_ware_4", 25);
	SetCraftEXP("rc_house_ware_4", 25)
	SetCraftEXP_SKILL("rc_house_ware_4", "Оружейник")
	
AddItemCategory ("Оружейник (Домашняя утварь)", "rc_house_ware_9"); ----- Железный контейнер с картошкой
	SetCraftAmount("rc_house_ware_9", 1);
	 AddIngre("rc_house_ware_9", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_9", "zdpwla_itpl_temp_herb", 5);
	 AddTool("rc_house_ware_9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_9", 5);
	SetCraftScience("rc_house_ware_9", "Оружейник", 1);
	SetenergyPenalty("rc_house_ware_9", 25);
	SetCraftEXP("rc_house_ware_9", 25)
	SetCraftEXP_SKILL("rc_house_ware_9", "Оружейник")

-- ОРУЖЕЙНИК 1 УРОВЕНЬ РАСХОДНИКИ И ИНСТРУМЕНТЫ
	
AddItemCategory ("Оружейник (1 уровень)", "ooltyb_itmiswordrawhot"); ----- Закаленная сталь
	SetCraftAmount("ooltyb_itmiswordrawhot", 1);
	 AddIngre("ooltyb_itmiswordrawhot", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("ooltyb_itmiswordrawhot", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("ooltyb_itmiswordrawhot", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmiswordrawhot", 5);
	SetCraftScience("ooltyb_itmiswordrawhot", "Оружейник", 1);
	SetenergyPenalty("ooltyb_itmiswordrawhot", 25);
	SetCraftEXP("ooltyb_itmiswordrawhot", 25)
	SetCraftEXP_SKILL("ooltyb_itmiswordrawhot", "Оружейник")

AddItemCategory ("Оружейник (1 уровень)", "yvnzmz_itmi_bolvanka"); --- Болванка ключей
	SetCraftAmount("yvnzmz_itmi_bolvanka", 5);
	 AddIngre("yvnzmz_itmi_bolvanka", "ooltyb_itmiswordrawhot", 1);
	 AddTool("yvnzmz_itmi_bolvanka", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yvnzmz_itmi_bolvanka", 5);
	SetCraftScience("yvnzmz_itmi_bolvanka", "Оружейник", 1);
	SetenergyPenalty("yvnzmz_itmi_bolvanka", 25);
	SetCraftEXP("yvnzmz_itmi_bolvanka", 25)
	SetCraftEXP_SKILL("yvnzmz_itmi_bolvanka", "Оружейник")

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1h_Vlk_AxE"); ---- Топорик
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Axe", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Axe", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_Axe", "Оружейник")	
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1H_Mace_L_04"); ---- Молот кузнеца
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_04", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_04", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Mace_L_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_04", 2);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_04", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_04", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Mace_L_04", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Mace_L_04", "Оружейник")
	
	
--AddItemCategory ("Оружейник (1 уровень)", "ooltyb_itmi_saw"); ---- Пила
	--SetCraftAmount("ooltyb_itmi_saw", 1);
	-- AddIngre("ooltyb_itmi_saw", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("ooltyb_itmi_saw", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("ooltyb_itmi_saw", "JKZTZD_ItMw_1H_Mace_L_04");
	--SetCraftPenalty("ooltyb_itmi_saw", 2);
	--SetCraftScience("ooltyb_itmi_saw", "Оружейник", 1);
	--SetenergyPenalty("ooltyb_itmi_saw", 10);
	--SetCraftEXP("ooltyb_itmi_saw", 10)
	--SetCraftEXP_SKILL("ooltyb_itmi_saw", "Оружейник")	


AddItemCategory ("Оружейник (1 уровень)", "jkztzd_itmw_1h_knife_01"); ---- Нож
	SetCraftAmount("jkztzd_itmw_1h_knife_01", 1);
	 AddIngre("jkztzd_itmw_1h_knife_01", "ooltyb_itmiswordrawhot", 2);
	 AddTool("jkztzd_itmw_1h_knife_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jkztzd_itmw_1h_knife_01", 2);
	SetCraftScience("jkztzd_itmw_1h_knife_01", "Оружейник", 1);
	SetenergyPenalty("jkztzd_itmw_1h_knife_01", 25);
	SetCraftEXP("jkztzd_itmw_1h_knife_01", 25)
	SetCraftEXP_SKILL("jkztzd_itmw_1h_knife_01", "Оружейник")		

	
-- ОРУЖЕЙНИК 1 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ НА 20 УРОНА

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1h_Vlk_DaggeR"); ---- Кинжал
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_DaggeR", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_DaggeR", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_DaggeR", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_DaggeR", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_DaggeR", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_DaggeR", "Оружейник")

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1H_Sword_L_03"); ---- Волчий нож
	SetCraftAmount("JKZTZD_ItMw_1H_Sword_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Sword_L_03", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Sword_L_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Sword_L_03", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Sword_L_03", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Sword_L_03", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Sword_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Sword_L_03", "Оружейник")
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Nagelkeule2"); ---- Тяжелая дубина с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule2", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule2", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Nagelkeule2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule2", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule2", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule2", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelkeule2", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelkeule2", "Оружейник")
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Sense"); ---- Малая коса
	SetCraftAmount("JKZTZD_ItMw_Sense", 1);
	 AddIngre("JKZTZD_ItMw_Sense", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Sense", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sense", 10);
	SetCraftScience("JKZTZD_ItMw_Sense", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Sense", 25);
	SetCraftEXP("JKZTZD_ItMw_Sense", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Sense", "Оружейник")

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_ShortSword1"); --- Короткий меч ополчения
	SetCraftAmount("JKZTZD_ItMw_ShortSword1", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword1", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword1", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword1", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword1", "Оружейник")


AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_ShortSword2"); --- Военный короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword2", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword2", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword2", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword2", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword2", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword2", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword2", "Оружейник")


AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1h_Vlk_SworD"); ---- Шпага
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_SworD", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_SworD", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_SworD", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_SworD", "Оружейник")


AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1h_Sld_AxE"); ---- Солдатский топор
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_AxE", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Sld_AxE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_AxE", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_AxE", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_AxE", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Sld_AxE", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Sld_AxE", "Оружейник")


AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_ShortSword3"); --- Короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword3", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword3", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword3", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword3", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword3", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword3", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword3", "Оружейник")


AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_ShortSword4"); --- Волчий зуб
	SetCraftAmount("JKZTZD_ItMw_ShortSword4", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword4", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword4", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword4", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword4", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword4", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword4", "Оружейник")
	

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_SchiffsaxT"); --- Корабельный топор
	SetCraftAmount("JKZTZD_ItMw_SchiffsaxT", 1);
     AddIngre("JKZTZD_ItMw_SchiffsaxT", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_SchiffsaxT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_SchiffsaxT", 10);
	SetCraftScience("JKZTZD_ItMw_SchiffsaxT", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_SchiffsaxT", 25);
	SetCraftEXP("JKZTZD_ItMw_SchiffsaxT", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_SchiffsaxT", "Оружейник")
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_1H_Common_01"); --- Простой меч
	SetCraftAmount("JKZTZD_ItMw_1H_Common_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Common_01", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Common_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Common_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Common_01", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Common_01", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Common_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Common_01", "Оружейник")

AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Folteraxt"); --- Топор палача
	SetCraftAmount("JKZTZD_ItMw_Folteraxt", 1);
     AddIngre("JKZTZD_ItMw_Folteraxt", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Folteraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Folteraxt", 10);
	SetCraftScience("JKZTZD_ItMw_Folteraxt", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Folteraxt", 25);	
	SetCraftEXP("JKZTZD_ItMw_Folteraxt", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Folteraxt", "Оружейник")
	
-- ОРУЖЕЙНИК 1 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 30 УРОНА
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_2h_Bau_Axe"); ---- Двуручный топор лесоруба
	SetCraftAmount("JKZTZD_ItMw_2h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Bau_Axe", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_2h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Bau_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Bau_Axe", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_2h_Bau_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_2h_Bau_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Bau_Axe", "Оружейник")
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_HellebardE");  ---  Двуручная алебадра
	SetCraftAmount("JKZTZD_ItMw_HellebardE", 1);
     AddIngre("JKZTZD_ItMw_HellebardE", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_HellebardE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_HellebardE", 10);
	SetCraftScience("JKZTZD_ItMw_HellebardE", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_HellebardE", 25);
	SetCraftEXP("JKZTZD_ItMw_HellebardE", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_HellebardE", "Оружейник")
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Stabkeule");  ---  Двуручная палица
	SetCraftAmount("JKZTZD_ItMw_Stabkeule", 1);
     AddIngre("JKZTZD_ItMw_Stabkeule", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Stabkeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Stabkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Stabkeule", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Stabkeule", 25);
	SetCraftEXP("JKZTZD_ItMw_Stabkeule", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Stabkeule", "Оружейник")	
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Zweihaender1"); ---- Легкий двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender1", 1);
     AddIngre("JKZTZD_ItMw_Zweihaender1", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Zweihaender1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender1", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender1", 25);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender1", "Оружейник")		
	
AddItemCategory ("Оружейник (1 уровень)", "JKZTZD_ItMw_Streitaxt1"); --- Легкий двуручный топор
	SetCraftAmount("JKZTZD_ItMw_Streitaxt1", 1);
     AddIngre("JKZTZD_ItMw_Streitaxt1", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Streitaxt1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt1", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt1", "Оружейник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt1", 25);
	SetCraftEXP("JKZTZD_ItMw_Streitaxt1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitaxt1", "Оружейник")		

	
-- ОРУЖЕЙНИК 2 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Оружейник (2 уровень)", "ooltyb_itmiswordblade"); ----- Клинок
	SetCraftAmount("ooltyb_itmiswordblade", 1);
	 AddIngre("ooltyb_itmiswordblade", "ooltyb_itmiswordrawhot", 2);
	 AddTool("ooltyb_itmiswordblade", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmiswordblade", 10);
	SetCraftScience("ooltyb_itmiswordblade", "Оружейник", 2);
	SetenergyPenalty("ooltyb_itmiswordblade", 50);
	SetCraftEXP("ooltyb_itmiswordblade", 50)
	SetCraftEXP_SKILL("ooltyb_itmiswordblade", "Оружейник")
	
AddItemCategory ("Оружейник (2 уровень)", "ooltyb_itmi_m_wire"); ----- Проволока
	SetCraftAmount("ooltyb_itmi_m_wire", 1);
	 AddIngre("ooltyb_itmi_m_wire", "ooltyb_itmiswordrawhot", 1);
	 AddTool("ooltyb_itmi_m_wire", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmi_m_wire", 10);
	SetCraftScience("ooltyb_itmi_m_wire", "Оружейник", 2);
	SetenergyPenalty("ooltyb_itmi_m_wire", 50);
	SetCraftEXP("ooltyb_itmi_m_wire", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_m_wire", "Оружейник")
	
-- ОРУЖЕЙНИК 2 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ 30 УРОНА
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Franciss"); ---- Хороший кинжал
	SetCraftAmount("JKZTZD_ItMw_Franciss", 1);
	 AddIngre("JKZTZD_ItMw_Franciss", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Franciss", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Franciss", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Franciss", 10);
	SetCraftScience("JKZTZD_ItMw_Franciss", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Franciss", 50);
	SetCraftEXP("JKZTZD_ItMw_Franciss", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Franciss", "Оружейник")

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_ShortSword5"); ---- Изысканный короткий меч
	SetCraftAmount("JKZTZD_ItMw_ShortSword5", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword5", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_ShortSword5", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_ShortSword5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword5", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword5", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword5", 50);
	SetCraftEXP("JKZTZD_ItMw_ShortSword5", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword5", "Оружейник")
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_1h_Mil_SworD"); --- Грубый палаш
	SetCraftAmount("JKZTZD_ItMw_1h_Mil_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Mil_SworD", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1h_Mil_SworD", "ooltyb_itmi_t_leather", 1);	 
	 AddTool("JKZTZD_ItMw_1h_Mil_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Mil_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Mil_SworD", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Mil_SworD", 50);
	SetCraftEXP("JKZTZD_ItMw_1h_Mil_SworD", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Mil_SworD", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_1h_Sld_Sword"); --- Военный меч
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_Sword", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1h_Sld_Sword", "ooltyb_itmi_t_leather", 1);	 	 
	 AddTool("JKZTZD_ItMw_1h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_1h_Sld_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Sld_Sword", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Kriegskeule"); --- Военная дубина
	SetCraftAmount("JKZTZD_ItMw_Kriegskeule", 1);
	 AddIngre("JKZTZD_ItMw_Kriegskeule", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Kriegskeule", "ooltyb_itmi_t_leather", 1);	 
	 AddTool("JKZTZD_ItMw_Kriegskeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegskeule", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegskeule", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegskeule", 50);
	SetCraftEXP("JKZTZD_ItMw_Kriegskeule", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegskeule", "Оружейник")	 

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Kriegshammer1"); --- Боевой молот
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer1", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer1", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Kriegshammer1", "ooltyb_itmi_t_leather", 1);	
	 AddTool("JKZTZD_ItMw_Kriegshammer1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer1", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer1", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer1", 50);
	SetCraftEXP("JKZTZD_ItMw_Kriegshammer1", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegshammer1", "Оружейник")		

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Piratensaebel"); --- Пиратская абордажная сабля
	SetCraftAmount("JKZTZD_ItMw_Piratensaebel", 1);
	 AddIngre("JKZTZD_ItMw_Piratensaebel", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Piratensaebel", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Piratensaebel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Piratensaebel", 10);
	SetCraftScience("JKZTZD_ItMw_Piratensaebel", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Piratensaebel", 50);
	SetCraftEXP("JKZTZD_ItMw_Piratensaebel", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Piratensaebel", "Оружейник")		
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Schwert"); --- Грубый длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert", 1);
	 AddIngre("JKZTZD_ItMw_Schwert", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert", "Оружейник")		

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Steinbrecher"); --- Дробитель камней
	SetCraftAmount("JKZTZD_ItMw_Steinbrecher", 1);
	 AddIngre("JKZTZD_ItMw_Steinbrecher", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Steinbrecher", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Steinbrecher", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Steinbrecher", 10);
	SetCraftScience("JKZTZD_ItMw_Steinbrecher", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Steinbrecher", 50);
	SetCraftEXP("JKZTZD_ItMw_Steinbrecher", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Steinbrecher", "Оружейник")		
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Spicker"); --- Раскалыватель черепов
	SetCraftAmount("JKZTZD_ItMw_Spicker", 1);
	 AddIngre("JKZTZD_ItMw_Spicker", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Spicker", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Spicker", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Spicker", 10);
	SetCraftScience("JKZTZD_ItMw_Spicker", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Spicker", 50);
	SetCraftEXP("JKZTZD_ItMw_Spicker", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Spicker", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Schwert1"); --- Изысканный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert1", 1);
	 AddIngre("JKZTZD_ItMw_Schwert1", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert1", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert1", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert1", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert1", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert1", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert1", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Schwert2"); --- Длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert2", 1);
	 AddIngre("JKZTZD_ItMw_Schwert2", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert2", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert2", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert2", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Schwert3"); --- Грубый полуторный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert3", 1);
	 AddIngre("JKZTZD_ItMw_Schwert3", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert3", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert3", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert3", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert3", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert3", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert3", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Rapier"); --- Рапира
	SetCraftAmount("JKZTZD_ItMw_Rapier", 1);
	 AddIngre("JKZTZD_ItMw_Rapier", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Rapier", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Rapier", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rapier", 10);
	SetCraftScience("JKZTZD_ItMw_Rapier", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rapier", 50);
	SetCraftEXP("JKZTZD_ItMw_Rapier", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rapier", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Rubinklinge"); --- Рубиновый клинок
	SetCraftAmount("JKZTZD_ItMw_Rubinklinge", 1);
	 AddIngre("JKZTZD_ItMw_Rubinklinge", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Rubinklinge", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Rubinklinge", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rubinklinge", 10);
	SetCraftScience("JKZTZD_ItMw_Rubinklinge", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rubinklinge", 50);
	SetCraftEXP("JKZTZD_ItMw_Rubinklinge", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rubinklinge", "Оружейник")	

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_1H_Special_01"); --- Длинный рудный меч
	SetCraftAmount("JKZTZD_ItMw_1H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_01", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_01", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_1H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Special_01", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_01", 50);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_01", "Оружейник")		
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Addon_PIR1hm"); --- Абордажный нож
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR1hm", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hm", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hm", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Addon_PIR1hm", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR1hm", 10);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR1hm", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR1hm", 50);
	SetCraftEXP("JKZTZD_ItMw_Addon_PIR1hm", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_PIR1hm", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMW_Hacker_01"); --- Мачете
	SetCraftAmount("JKZTZD_ItMW_Hacker_01", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_01", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMW_Hacker_01", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMW_Hacker_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_01", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_01", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_01", 50);
	SetCraftEXP("JKZTZD_ItMW_Hacker_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Hacker_01", "Оружейник")	

-- ОРУЖЕЙНИК 2 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 40 УРОНА

AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_2h_Sld_Axe"); --- Солдатский двуручный топор
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Axe", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Axe", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Sld_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Axe", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Axe", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Sld_Axe", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Sld_Axe", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_2h_Sld_Sword"); --- Солдатский двуручный меч
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Sword", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Sword", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Sld_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Sld_Sword", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_2h_Pal_Sword"); --- Изысканный двуручный меч
	SetCraftAmount("JKZTZD_ItMw_2h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Pal_Sword", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Pal_Sword", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Pal_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Pal_Sword", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Pal_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Pal_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Pal_Sword", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Zweihaender2"); --- Двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender2", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender2", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Zweihaender2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender2", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender2", 50);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender2", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Streitaxt2"); --- Двуручный боевой топор
	SetCraftAmount("JKZTZD_ItMw_Streitaxt2", 1);
	 AddIngre("JKZTZD_ItMw_Streitaxt2", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Streitaxt2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Streitaxt2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt2", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt2", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt2", 50);
	SetCraftEXP("JKZTZD_ItMw_Streitaxt2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitaxt2", "Оружейник")		
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Zweihaender4"); --- Тяжелый двуручный меч
	SetCraftAmount("JKZTZD_ItMw_Zweihaender4", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender4", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Zweihaender4", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender4", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender4", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender4", 50);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender4", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender4", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMw_Schlachtaxt"); --- Двуручный военный топор
	SetCraftAmount("JKZTZD_ItMw_Schlachtaxt", 1);
	 AddIngre("JKZTZD_ItMw_Schlachtaxt", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Schlachtaxt", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schlachtaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schlachtaxt", 10);
	SetCraftScience("JKZTZD_ItMw_Schlachtaxt", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schlachtaxt", 50);
	SetCraftEXP("JKZTZD_ItMw_Schlachtaxt", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schlachtaxt", "Оружейник")	
	
AddItemCategory ("Оружейник (2 уровень)", "JKZTZD_ItMW_Hacker_03"); --- Гигантское мачете
	SetCraftAmount("JKZTZD_ItMW_Hacker_03", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_03", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMW_Hacker_03", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMW_Hacker_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_03", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_03", "Оружейник", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_03", 50);
	SetCraftEXP("JKZTZD_ItMW_Hacker_03", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Hacker_03", "Оружейник")	

	
-- ОРУЖЕЙНИК 3 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ НА 40 УРОНА
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Morgenstern"); --- Булава с шипами
	SetCraftAmount("JKZTZD_ItMw_Morgenstern", 1);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Morgenstern", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Morgenstern", 20);
	SetCraftScience("JKZTZD_ItMw_Morgenstern", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Morgenstern", 75);
	SetCraftEXP("JKZTZD_ItMw_Morgenstern", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Morgenstern", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Doppelaxt"); --- Двойной топор
	SetCraftAmount("JKZTZD_ItMw_Doppelaxt", 1);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Doppelaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Doppelaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Doppelaxt", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Doppelaxt", 75);	
	SetCraftEXP("JKZTZD_ItMw_Doppelaxt", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Doppelaxt", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_1h_Pal_Sword"); --- Меч офицера
	SetCraftAmount("JKZTZD_ItMw_1h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Pal_Sword", 20);
	SetCraftScience("JKZTZD_ItMw_1h_Pal_Sword", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1h_Pal_Sword", 75);	
	SetCraftEXP("JKZTZD_ItMw_1h_Pal_Sword", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Pal_Sword", "Оружейник")	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Bartaxt"); --- Короткий бердыш
	SetCraftAmount("JKZTZD_ItMw_Bartaxt", 1);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Bartaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Bartaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Bartaxt", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Bartaxt", 75);		
	SetCraftEXP("JKZTZD_ItMw_Bartaxt", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Bartaxt", "Оружейник")

AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Schwert4"); --- Изысканный длинный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert4", 1);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Schwert4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert4", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert4", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert4", 75);			
	SetCraftEXP("JKZTZD_ItMw_Schwert4", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert4", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Streitkolben"); --- Булава
	SetCraftAmount("JKZTZD_ItMw_Streitkolben", 1);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Streitkolben", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitkolben", 20);
	SetCraftScience("JKZTZD_ItMw_Streitkolben", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Streitkolben", 75);	
	SetCraftEXP("JKZTZD_ItMw_Streitkolben", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitkolben", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Runenschwert"); --- Рунный меч
	SetCraftAmount("JKZTZD_ItMw_Runenschwert", 1);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Runenschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Runenschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Runenschwert", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Runenschwert", 75);	
	SetCraftEXP("JKZTZD_ItMw_Runenschwert", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Runenschwert", "Оружейник")	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Rabenschnabel"); --- Клюв ворона
	SetCraftAmount("JKZTZD_ItMw_Rabenschnabel", 1);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Rabenschnabel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rabenschnabel", 20);
	SetCraftScience("JKZTZD_ItMw_Rabenschnabel", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Rabenschnabel", 75);
	SetCraftEXP("JKZTZD_ItMw_Rabenschnabel", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rabenschnabel", "Оружейник")	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Schwert5"); --- Изысканный полуторный меч
	SetCraftAmount("JKZTZD_ItMw_Schwert5", 1);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Schwert5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert5", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert5", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert5", 75);
	SetCraftEXP("JKZTZD_ItMw_Schwert5", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert5", "Оружейник")	

AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Inquisitor"); --- Инквизитор
	SetCraftAmount("JKZTZD_ItMw_Inquisitor", 1);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Inquisitor", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Inquisitor", 20);
	SetCraftScience("JKZTZD_ItMw_Inquisitor", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Inquisitor", 75);	
	SetCraftEXP("JKZTZD_ItMw_Inquisitor", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Inquisitor", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_ElBastardo"); --- Эль-бастардо
	SetCraftAmount("JKZTZD_ItMw_ElBastardo", 1);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_ElBastardo", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ElBastardo", 20);
	SetCraftScience("JKZTZD_ItMw_ElBastardo", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_ElBastardo", 75);		
	SetCraftEXP("JKZTZD_ItMw_ElBastardo", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ElBastardo", "Оружейник")	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Kriegshammer2"); --- Тяжелый боевой молот
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer2", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Kriegshammer2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer2", 20);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer2", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer2", 75);
	SetCraftEXP("JKZTZD_ItMw_Kriegshammer2", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegshammer2", "Оружейник")		
	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Meisterdegen"); --- Шпага мастера
	SetCraftAmount("JKZTZD_ItMw_Meisterdegen", 1);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Meisterdegen", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Meisterdegen", 20);
	SetCraftScience("JKZTZD_ItMw_Meisterdegen", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Meisterdegen", 75);	
	SetCraftEXP("JKZTZD_ItMw_Meisterdegen", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Meisterdegen", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Orkschlaecht"); --- Убийца орков
	SetCraftAmount("JKZTZD_ItMw_Orkschlaecht", 1);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Orkschlaecht", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Orkschlaecht", 20);
	SetCraftScience("JKZTZD_ItMw_Orkschlaecht", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Orkschlaecht", 75);	
	SetCraftEXP("JKZTZD_ItMw_Orkschlaecht", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Orkschlaecht", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_1H_Blessed_01"); --- Одноручный рудный клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_01", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Blessed_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Blessed_01", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_1H_Special_02"); --- Полуторный рудный меч
	SetCraftAmount("JKZTZD_ItMw_1H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_02", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_02", "Оружейник")			
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_1H_Special_03"); --- Рудный боевой клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Special_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Special_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_03", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_03", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_03", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_03", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_03", "Оружейник")	
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Addon_Betty"); --- Бетти
	SetCraftAmount("JKZTZD_ItMw_Addon_Betty", 1);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Addon_Betty", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_Betty", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_Betty", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_Betty", 75);
	SetCraftEXP("JKZTZD_ItMw_Addon_Betty", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_Betty", "Оружейник")

-- ОРУЖЕЙНИК 3 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 50 УРОНА

AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Krummschwert"); --- Двуручная абордажная сабля
	SetCraftAmount("JKZTZD_ItMw_Krummschwert", 1);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Krummschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Krummschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Krummschwert", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Krummschwert", 75);
	SetCraftEXP("JKZTZD_ItMw_Krummschwert", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Krummschwert", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_2H_Special_01"); --- Двуручный Королевский клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_01", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Special_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Special_01", "Оружейник")
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Sturmbringer"); --- Двуручник Верный Друг
	SetCraftAmount("JKZTZD_ItMw_Sturmbringer", 1);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Sturmbringer", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sturmbringer", 20);
	SetCraftScience("JKZTZD_ItMw_Sturmbringer", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Sturmbringer", 75);
	SetCraftEXP("JKZTZD_ItMw_Sturmbringer", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Sturmbringer", "Оружейник")

AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_2H_Blessed_01"); --- Двуручный грубый рудный клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_01", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_01", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Blessed_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Blessed_01", "Оружейник")

AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_2H_Blessed_02"); --- Двуручный меч ордена
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_02", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Blessed_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Blessed_02", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_2H_Special_02"); --- Тяжелый рудный двуручник
	SetCraftAmount("JKZTZD_ItMw_2H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_02", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_02", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Special_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Special_02", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "JKZTZD_ItMw_Addon_PIR2hAx"); --- Двуручный крушитель досок
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR2hAx", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Addon_PIR2hAx", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR2hAx", "Оружейник", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 75);
	SetCraftEXP("JKZTZD_ItMw_Addon_PIR2hAx", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_PIR2hAx", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "itmw_2h_molotzac_02"); --- Двуручный молот Ордена Заката
	SetCraftAmount("itmw_2h_molotzac_02", 1);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmi_nail", 3);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("itmw_2h_molotzac_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itmw_2h_molotzac_02", 20);
	SetCraftScience("itmw_2h_molotzac_02", "Оружейник", 3);
	SetenergyPenalty("itmw_2h_molotzac_02", 75);
	SetCraftEXP("itmw_2h_molotzac_02", 75)
	SetCraftEXP_SKILL("itmw_2h_molotzac_02", "Оружейник")		
	
AddItemCategory ("Оружейник (3 уровень)", "itmw_2h_molotzac_01"); --- Двуручный боевой Ордена Заката
	SetCraftAmount("itmw_2h_molotzac_01", 1);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmi_nail", 3);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("itmw_2h_molotzac_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itmw_2h_molotzac_01", 20);
	SetCraftScience("itmw_2h_molotzac_01", "Оружейник", 3);
	SetenergyPenalty("itmw_2h_molotzac_01", 75);
	SetCraftEXP("itmw_2h_molotzac_01", 75)
	SetCraftEXP_SKILL("itmw_2h_molotzac_01", "Оружейник")	
	
-- ОРУЖЕЙНИК 4 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ НА 60 УРОНА

AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_1H_Blessed_02"); --- Освященный рудный клинок
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_1H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_02", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_02", 100);		
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_mace"); --- Боевая булава
	SetCraftAmount("JKZTZD_mace", 1);
	 AddIngre("JKZTZD_mace", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_mace", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_mace", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_mace", 20);
	SetCraftScience("JKZTZD_mace", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_mace", 100);	
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_mastersword"); --- Меч мастера
	SetCraftAmount("JKZTZD_mastersword", 1);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_mastersword", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_mastersword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_mastersword", 20);
	SetCraftScience("JKZTZD_mastersword", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_mastersword", 100);	
	
AddItemCategory ("Оружейник (4 уровень)", "jkztzd_itmw_1h_special_04"); --- Убийца драконов
	SetCraftAmount("jkztzd_itmw_1h_special_04", 1);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmiswordblade", 15);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_1h_special_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jkztzd_itmw_1h_special_04", 20);
	SetCraftScience("jkztzd_itmw_1h_special_04", "Оружейник", 4);
	SetenergyPenalty("jkztzd_itmw_1h_special_04", 100);	

-- ОРУЖЕЙНИК 4 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 70 УРОНА

AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_Zweihaender3"); --- Сила рун (двуручный)
	SetCraftAmount("JKZTZD_ItMw_Zweihaender3", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender3", 20);
	SetCraftScience("JKZTZD_ItMw_Zweihaender3", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender3", 100);
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_Drachenschne"); --- Двуручный убийца драконов
	SetCraftAmount("JKZTZD_ItMw_Drachenschne", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne", 100);	
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_2H_Blessed_03"); --- Двуручный святой палач
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Blessed_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_03", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_03", 100);	
	
		
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_2H_Special03"); --- Двуручный рудный боевой клинок
	SetCraftAmount("JKZTZD_ItMw_2H_Special03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special03", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special03", 100);	
	
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_2H_Special_04"); --- Двуручный Убийца Драконов
	SetCraftAmount("JKZTZD_ItMw_2H_Special_04", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_04", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_04", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_04", 100);	
	
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_Drachenschne1"); --- Двуручный меч генерала
	SetCraftAmount("JKZTZD_ItMw_Drachenschne1", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne1", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne1", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne1", 100);	
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_Barbarenstr"); --- Двуручный топор варваров
	SetCraftAmount("JKZTZD_ItMw_Barbarenstr", 1);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Barbarenstr", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Barbarenstr", 20);
	SetCraftScience("JKZTZD_ItMw_Barbarenstr", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_Barbarenstr", 100);		
	
AddItemCategory ("Оружейник (4 уровень)", "JKZTZD_ItMw_Berserkeraxt"); --- Двуручный топор берсеркера
	SetCraftAmount("JKZTZD_ItMw_Berserkeraxt", 1);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Berserkeraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Berserkeraxt", 20);
	SetCraftScience("JKZTZD_ItMw_Berserkeraxt", "Оружейник", 4);
	SetenergyPenalty("JKZTZD_ItMw_Berserkeraxt", 100);	


-- ПЛОТНИК 1 ДОМАШНЯЯ УТВАРЬ

AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_TABLE_LOW"); --- Низкий стол
	SetCraftAmount("RC_HOUSE_TABLE_LOW", 1);
	 AddIngre("RC_HOUSE_TABLE_LOW", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_TABLE_LOW", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_TABLE_LOW", 5);
	SetCraftScience("RC_HOUSE_TABLE_LOW", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_TABLE_LOW", 25);
	SetCraftEXP("RC_HOUSE_TABLE_LOW", 25)
	SetCraftEXP_SKILL("RC_HOUSE_TABLE_LOW", "Плотник")	
	
AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_TABLE_POOR"); --- Дешевый стол
	SetCraftAmount("RC_HOUSE_TABLE_POOR", 1);
	 AddIngre("RC_HOUSE_TABLE_POOR", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_TABLE_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_TABLE_POOR", 5);
	SetCraftScience("RC_HOUSE_TABLE_POOR", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_TABLE_POOR", 25);
	SetCraftEXP("RC_HOUSE_TABLE_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_TABLE_POOR", "Плотник")	
	
AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_CUPBOARD_POOR"); --- Дешевый шкаф
	SetCraftAmount("RC_HOUSE_CUPBOARD_POOR", 1);
	 AddIngre("RC_HOUSE_CUPBOARD_POOR", "OOLTYB_ITMI_WOOD", 25);
	 AddTool("RC_HOUSE_CUPBOARD_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_CUPBOARD_POOR", 5);
	SetCraftScience("RC_HOUSE_CUPBOARD_POOR", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_CUPBOARD_POOR", 25);
	SetCraftEXP("RC_HOUSE_CUPBOARD_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_CUPBOARD_POOR", "Плотник")

AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_CUPBOARDLOW_POOR"); --- Дешевый комод
	SetCraftAmount("RC_HOUSE_CUPBOARDLOW_POOR", 1);
	 AddIngre("RC_HOUSE_CUPBOARDLOW_POOR", "OOLTYB_ITMI_WOOD", 25);
	 AddTool("RC_HOUSE_CUPBOARDLOW_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_CUPBOARDLOW_POOR", 5);
	SetCraftScience("RC_HOUSE_CUPBOARDLOW_POOR", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_CUPBOARDLOW_POOR", 25);
	SetCraftEXP("RC_HOUSE_CUPBOARDLOW_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_CUPBOARDLOW_POOR", "Плотник")

AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_LOWCHAIR_POOR"); --- Дешевый табурет
	SetCraftAmount("RC_HOUSE_LOWCHAIR_POOR", 1);
	 AddIngre("RC_HOUSE_LOWCHAIR_POOR", "OOLTYB_ITMI_WOOD", 15);
	 AddTool("RC_HOUSE_LOWCHAIR_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_LOWCHAIR_POOR", 5);
	SetCraftScience("RC_HOUSE_LOWCHAIR_POOR", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_LOWCHAIR_POOR", 25);
	SetCraftEXP("RC_HOUSE_LOWCHAIR_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_LOWCHAIR_POOR", "Плотник")
	
--AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_SHELFBIG"); --- Широкая полка
	--SetCraftAmount("RC_HOUSE_SHELFBIG", 1);
	-- AddIngre("RC_HOUSE_SHELFBIG", "OOLTYB_ITMI_OBRABOTDER", 1);
	-- AddTool("RC_HOUSE_SHELFBIG", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_SHELFBIG", 5);
	--SetCraftScience("RC_HOUSE_SHELFBIG", "Плотник", 1);
	--SetenergyPenalty("RC_HOUSE_SHELFBIG", 25);
	--SetCraftEXP("RC_HOUSE_SHELFBIG", 25)
--	SetCraftEXP_SKILL("RC_HOUSE_SHELFBIG", "Плотник")
	
-- AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_SHELFWALL_1"); --- Настенная полка
	-- SetCraftAmount("RC_HOUSE_SHELFWALL_1", 1);
	-- AddIngre("RC_HOUSE_SHELFWALL_1", "OOLTYB_ITMI_WOOD", 15);
	-- AddTool("RC_HOUSE_SHELFWALL_1", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_SHELFWALL_1", 5);
	--SetCraftScience("RC_HOUSE_SHELFWALL_1", "Плотник", 1);
	--SetenergyPenalty("RC_HOUSE_SHELFWALL_1", 15);
	--SetCraftEXP("RC_HOUSE_SHELFWALL_1", 15)
	--SetCraftEXP_SKILL("RC_HOUSE_SHELFWALL_1", "Плотник")

AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_LOWCHAIR_WOOD"); --- Пенек
	SetCraftAmount("RC_HOUSE_LOWCHAIR_WOOD", 1);
	 AddIngre("RC_HOUSE_LOWCHAIR_WOOD", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("RC_HOUSE_LOWCHAIR_WOOD", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_LOWCHAIR_WOOD", 5);
	SetCraftScience("RC_HOUSE_LOWCHAIR_WOOD", "Плотник", 1);
	SetenergyPenalty("RC_HOUSE_LOWCHAIR_WOOD", 25);
	SetCraftEXP("RC_HOUSE_LOWCHAIR_WOOD", 25)
	SetCraftEXP_SKILL("RC_HOUSE_LOWCHAIR_WOOD", "Плотник")
	
--AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_CREATE_1"); --- Обычный ящик
	--SetCraftAmount("RC_HOUSE_CREATE_1", 1);
	-- AddIngre("RC_HOUSE_CREATE_1", "OOLTYB_ITMI_WOOD", 15);
	-- AddTool("RC_HOUSE_CREATE_1", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_CREATE_1", 5);
	--SetCraftScience("RC_HOUSE_CREATE_1", "Плотник", 1);
	--SetenergyPenalty("RC_HOUSE_CREATE_1", 25);
	--SetCraftEXP("RC_HOUSE_CREATE_1", 25)
	--SetCraftEXP_SKILL("RC_HOUSE_CREATE_1", "Плотник")	
	
--AddItemCategory ("Плотник (Домашняя утварь)", "RC_HOUSE_CREATE_3"); --- Малый ящик
	--SetCraftAmount("RC_HOUSE_CREATE_3", 1);
	-- AddIngre("RC_HOUSE_CREATE_3", "OOLTYB_ITMI_WOOD", 10);
	-- AddTool("RC_HOUSE_CREATE_3", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_CREATE_3", 5);
--	SetCraftScience("RC_HOUSE_CREATE_3", "Плотник", 1);
--	SetenergyPenalty("RC_HOUSE_CREATE_3", 25);
	--SetCraftEXP("RC_HOUSE_CREATE_3", 25)
	--SetCraftEXP_SKILL("RC_HOUSE_CREATE_3", "Плотник")	
	

AddItemCategory ("Плотник (Домашняя утварь)", "ooltyb_itmi_chest1"); --- Сундук
	SetCraftAmount("ooltyb_itmi_chest1", 1);
	 AddIngre("ooltyb_itmi_chest1", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("ooltyb_itmi_chest1", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest1", 5);
	SetCraftScience("ooltyb_itmi_chest1", "Плотник", 1);
	SetenergyPenalty("ooltyb_itmi_chest1", 25);
	SetCraftEXP("ooltyb_itmi_chest1", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest1", "Плотник")	
	
AddItemCategory ("Плотник (Домашняя утварь)", "ooltyb_itmi_chest2"); --- Крепкий сундук
	SetCraftAmount("ooltyb_itmi_chest2", 1);
	 AddIngre("ooltyb_itmi_chest2", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddIngre("ooltyb_itmi_chest2", "yvnzmz_itmi_zamok", 1);
	 AddTool("ooltyb_itmi_chest2", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest2", 5);
	SetCraftScience("ooltyb_itmi_chest2", "Плотник", 2);
	SetenergyPenalty("ooltyb_itmi_chest2", 25);
	SetCraftEXP("ooltyb_itmi_chest2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest2", "Плотник")
	
AddItemCategory ("Плотник (Домашняя утварь)", "ooltyb_itmi_chest3"); --- Прочный сундук
	SetCraftAmount("ooltyb_itmi_chest3", 1);
	 AddIngre("ooltyb_itmi_chest3", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddIngre("ooltyb_itmi_chest3", "yvnzmz_itmi_zamok", 1);
	 AddTool("ooltyb_itmi_chest3", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest3", 5);
	SetCraftScience("ooltyb_itmi_chest3", "Плотник", 3);
	SetenergyPenalty("ooltyb_itmi_chest3", 25);
	SetCraftEXP("ooltyb_itmi_chest3", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest3", "Плотник")	

-- ПЛОТНИК РАСХОДНИКИ

--AddItemCategory ("Плотник (1 уровень)", "ZDPWLA_ITMI_BUCKET"); ---- Ведро
	--SetCraftAmount("ZDPWLA_ITMI_BUCKET", 1);
	-- AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("ZDPWLA_ITMI_BUCKET", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("ZDPWLA_ITMI_BUCKET", 2);
	--SetCraftScience("ZDPWLA_ITMI_BUCKET", "Плотник", 1);
	--SetenergyPenalty("ZDPWLA_ITMI_BUCKET", 10);
	--SetCraftEXP("ZDPWLA_ITMI_BUCKET", 10)
	--SetCraftEXP_SKILL("ZDPWLA_ITMI_BUCKET", "Плотник")

AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ITMI_OBRABOTDER"); --- Обработанная древесина
	SetCraftAmount("OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ItMi_Coal", 5);
	 AddAlterIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ITAT_CRAWLERPLATE", 10);
	 AddAlterIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ItMi_Coal", 5);
	 AddTool("OOLTYB_ITMI_OBRABOTDER", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_OBRABOTDER", 5);
	SetCraftScience("OOLTYB_ITMI_OBRABOTDER", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ITMI_OBRABOTDER", 25);
	SetCraftEXP("OOLTYB_ITMI_OBRABOTDER", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_OBRABOTDER", "Плотник")

AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ItMi_FlasK"); --- Мензурка
	SetCraftAmount("OOLTYB_ItMi_FlasK", 40);
	 AddIngre("OOLTYB_ItMi_FlasK", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("OOLTYB_ItMi_FlasK", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_FlasK", 5);
	SetCraftScience("OOLTYB_ItMi_FlasK", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ItMi_FlasK", 25);
	SetCraftEXP("OOLTYB_ItMi_FlasK", 25)
	SetCraftEXP_SKILL("OOLTYB_ItMi_FlasK", "Плотник")
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Arrow"); --- Стрела
	SetCraftAmount("JKZTZD_ItRw_Arrow", 40);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ITMI_WOOD", 5);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Iron", 5);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "jkztzd_itmw_1h_bau_mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Iron", 5);
	 AddTool("JKZTZD_ItRw_Arrow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Arrow", 5);
	SetCraftScience("JKZTZD_ItRw_Arrow", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Arrow", 10);
	SetCraftEXP("JKZTZD_ItRw_Arrow", 10)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Arrow", "Плотник")	
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Bolt"); --- Болт
	SetCraftAmount("JKZTZD_ItRw_Bolt", 40);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ITMI_WOOD", 5);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Iron", 5);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "jkztzd_itmw_1h_bau_mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Iron", 5);
	 AddTool("JKZTZD_ItRw_Bolt", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bolt", 5);
	SetCraftScience("JKZTZD_ItRw_Bolt", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bolt", 10);
	SetCraftEXP("JKZTZD_ItRw_Bolt", 10)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bolt", "Плотник")	

AddItemCategory ("Плотник (1 уровень)", "ooltyb_itmi_paper"); --- Бумага
	SetCraftAmount("ooltyb_itmi_paper", 25);
	 AddIngre("ooltyb_itmi_paper", "OOLTYB_ITMI_WOOD", 15);
	SetCraftPenalty("ooltyb_itmi_paper", 5);
	SetCraftScience("ooltyb_itmi_paper", "Плотник", 1);
	SetenergyPenalty("ooltyb_itmi_paper", 10);
	SetCraftEXP("ooltyb_itmi_paper", 10)
	SetCraftEXP_SKILL("ooltyb_itmi_paper", "Плотник")	

	
-- ПЛОТНИК 1 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ НА 20 УРОНА
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_1h_Vlk_Mace"); --- Трость
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Mace", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Mace", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_Mace", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_Mace", "Плотник")		

AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_1H_Mace_L_03"); --- Дубина
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_03", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1H_Mace_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_03", 5);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_03", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_03", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Mace_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Mace_L_03", "Плотник")	

AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_Nagelknueppel"); --- Палица с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelknueppel", 1);
	 AddIngre("JKZTZD_ItMw_Nagelknueppel", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_Nagelknueppel", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelknueppel", 5);
	SetCraftScience("JKZTZD_ItMw_Nagelknueppel", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelknueppel", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelknueppel", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelknueppel", "Плотник")	

	AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_Nagelkeule"); --- Дубина с шипами
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_Nagelkeule", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelkeule", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelkeule", "Плотник")
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMw_1h_Nov_Mace"); --- Боевой посох
	SetCraftAmount("JKZTZD_ItMw_1h_Nov_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Nov_Mace", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1h_Nov_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Nov_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Nov_Mace", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Nov_Mace", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Nov_Mace", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Nov_Mace", "Плотник")
	
-- ПЛОТНИК 1 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 30 УРОНА И СТРЕЛКОВОЕ НА 20 УРОНА

AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItMW_Addon2h"); --- Двуручная дубинка бури
	SetCraftAmount("JKZTZD_ItMW_Addon2h", 1);
	 AddIngre("JKZTZD_ItMW_Addon2h", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddTool("JKZTZD_ItMW_Addon2h", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_Addon2h", 10);
	SetCraftScience("JKZTZD_ItMW_Addon2h", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItMW_Addon2h", 25);
	SetCraftEXP("JKZTZD_ItMW_Addon2h", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Addon2h", "Плотник")

AddItemCategory ("Плотник (1 уровень)", "jkztzd_itmw_addon_stab06"); --- Посох послушника
	SetCraftAmount("jkztzd_itmw_addon_stab06", 1);
     AddIngre("jkztzd_itmw_addon_stab06", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddIngre("jkztzd_itmw_addon_stab06", "ooltyb_itmi_s_ignot", 1);
	 AddIngre("jkztzd_itmw_addon_stab06", "ooltyb_itmi_mage1", 1);
	 AddTool("jkztzd_itmw_addon_stab06", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab06", 10);
	SetCraftScience("jkztzd_itmw_addon_stab06", "Плотник", 1);
	SetenergyPenalty("jkztzd_itmw_addon_stab06", 25);
	SetCraftEXP("jkztzd_itmw_addon_stab06", 25)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab06", "Плотник")	
		
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Bow_L_01"); --- Короткий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_01", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Bow_L_01", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_01", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_01", "Плотник")	
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Bow_L_03"); --- Охотничий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_03", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_03", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_03", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_03", "Плотник")

AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Bow_L_02"); --- Ивовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_02", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_02", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_02", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_02", "Плотник")

AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Crossbow_L_01"); --- Охотничий арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_01", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_01", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_01", 25);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_L_01", "Плотник")


AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Mil_Crossbow"); --- Арбалет
	SetCraftAmount("JKZTZD_ItRw_Mil_Crossbow", 1);
	 AddIngre("JKZTZD_ItRw_Mil_Crossbow", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Mil_Crossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Mil_Crossbow", 10);
	SetCraftScience("JKZTZD_ItRw_Mil_Crossbow", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Mil_Crossbow", 25);
	SetCraftEXP("JKZTZD_ItRw_Mil_Crossbow", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Mil_Crossbow", "Плотник")	
	
	
AddItemCategory ("Плотник (1 уровень)", "JKZTZD_ItRw_Crossbow_L_02"); --- Легкий арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_02", "Плотник", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_02", 25);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_L_02", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_L_02", "Плотник")	

AddItemCategory ("Плотник (1 уровень)", "yfauun_itsh_shield_01"); --- Деревянный щит
	SetCraftAmount("yfauun_itsh_shield_01", 1);
	 AddIngre("yfauun_itsh_shield_01", "ooltyb_itmi_obrabotder", 2);
	 AddTool("yfauun_itsh_shield_01", "jkztzd_itmw_1h_vlk_axe");
	SetCraftPenalty("yfauun_itsh_shield_01", 10);
	SetCraftScience("yfauun_itsh_shield_01", "Плотник", 1);
	SetenergyPenalty("yfauun_itsh_shield_01", 25);
	SetCraftEXP("yfauun_itsh_shield_01", 25)
	SetCraftEXP_SKILL("yfauun_itsh_shield_01", "Плотник")
	
AddItemCategory ("Плотник (1 уровень)", "ooltyb_itmi_lute"); --- Лютня
	SetCraftAmount("ooltyb_itmi_lute", 1);
	 AddIngre("ooltyb_itmi_lute", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("ooltyb_itmi_lute", "ZDPWLA_ItMi_Glue", 1);
	 AddTool("ooltyb_itmi_lute", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_lute", 10);
	SetCraftScience("ooltyb_itmi_lute", "Плотник", 1);
	SetenergyPenalty("ooltyb_itmi_lute", 10);
	SetCraftEXP("ooltyb_itmi_lute", 10)
	SetCraftEXP_SKILL("ooltyb_itmi_lute", "Плотник")
	
--AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ITMI_FISHING"); --- Удочка
	--SetCraftAmount("OOLTYB_ITMI_FISHING", 1);
	-- AddIngre("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Bau_Mace", 1);
	-- AddIngre("OOLTYB_ITMI_FISHING", "OOLTYB_ITMI_SHEEP", 1);
	-- AddTool("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Vlk_AxE");
--	SetCraftPenalty("OOLTYB_ITMI_FISHING", 5);
--	SetCraftScience("OOLTYB_ITMI_FISHING", "Плотник", 1);
--	SetenergyPenalty("OOLTYB_ITMI_FISHING", 10);
--	SetCraftEXP("OOLTYB_ITMI_FISHING", 10)
--	SetCraftEXP_SKILL("OOLTYB_ITMI_FISHING", "Плотник")	

AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ItMi_Scoop"); --- Ложка
	SetCraftAmount("OOLTYB_ItMi_Scoop", 1);
	 AddIngre("OOLTYB_ItMi_Scoop", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("OOLTYB_ItMi_Scoop", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_Scoop", 5);
	SetCraftScience("OOLTYB_ItMi_Scoop", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ItMi_Scoop", 10);
	SetCraftEXP("OOLTYB_ItMi_Scoop", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Scoop", "Плотник")		
	
AddItemCategory ("Плотник (1 уровень)", "OOLTYB_ItMi_Broom"); --- Метла
	SetCraftAmount("OOLTYB_ItMi_Broom", 1);
	 AddIngre("OOLTYB_ItMi_Broom", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("OOLTYB_ItMi_Broom", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_Broom", 5);
	SetCraftScience("OOLTYB_ItMi_Broom", "Плотник", 1);
	SetenergyPenalty("OOLTYB_ItMi_Broom", 10);
	SetCraftEXP("OOLTYB_ItMi_Broom", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Broom", "Плотник")	

-- ПЛОТНИК 2 РАСХОДНИКИ

AddItemCategory ("Плотник (2 уровень)", "OOLTYB_ITMI_HANDLE"); --- Рукоять
	SetCraftAmount("OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("OOLTYB_ITMI_HANDLE", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("OOLTYB_ITMI_HANDLE", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_HANDLE", 10);
	SetCraftScience("OOLTYB_ITMI_HANDLE", "Плотник", 2);
	SetenergyPenalty("OOLTYB_ITMI_HANDLE", 50);
	SetCraftEXP("OOLTYB_ITMI_HANDLE", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_HANDLE", "Плотник")

AddItemCategory ("Плотник (2 уровень)", "ooltyb_itmi_alchemy_syrianoil_01"); --- Деготь
	SetCraftAmount("ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddIngre("ooltyb_itmi_alchemy_syrianoil_01", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("ooltyb_itmi_alchemy_syrianoil_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_alchemy_syrianoil_01", 10);
	SetCraftScience("ooltyb_itmi_alchemy_syrianoil_01", "Плотник", 2);
	SetenergyPenalty("ooltyb_itmi_alchemy_syrianoil_01", 50);
	SetCraftEXP("ooltyb_itmi_alchemy_syrianoil_01", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_alchemy_syrianoil_01", "Плотник")

-- ПЛОТНИК 2 УРОВЕНЬ ОДНОРУЧНОЕ ОРУЖИЕ НА 30 УРОНА

AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItMW_AddonKeu"); --- Дубинка ветра
	SetCraftAmount("JKZTZD_ItMW_AddonKeu", 1);
	 AddIngre("JKZTZD_ItMW_AddonKeu", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItMW_AddonKeu", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItMW_AddonKeu", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_AddonKeu", 10);
	SetCraftScience("JKZTZD_ItMW_AddonKeu", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItMW_AddonKeu", 50);
	SetCraftEXP("JKZTZD_ItMW_AddonKeu", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_AddonKeu", "Плотник")

-- ПЛОТНИК 2 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 40 УРОНА И СТРЕЛКОВОЕ НА 30 УРОНА

AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItMw_Richtstab"); --- Посох судьи
	SetCraftAmount("JKZTZD_ItMw_Richtstab", 1);
     AddIngre("JKZTZD_ItMw_Richtstab", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("JKZTZD_ItMw_Richtstab", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItMw_Richtstab", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Richtstab", 10);
	SetCraftScience("JKZTZD_ItMw_Richtstab", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItMw_Richtstab", 50);
	SetCraftEXP("JKZTZD_ItMw_Richtstab", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Richtstab", "Плотник")		

AddItemCategory ("Плотник (2 уровень)", "jkztzd_itmw_rangerstaff"); --- Укрепленный боевой посох
	SetCraftAmount("jkztzd_itmw_rangerstaff", 1);
     AddIngre("jkztzd_itmw_rangerstaff", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("jkztzd_itmw_rangerstaff", "ooltyb_itmi_nail", 1);
	 AddTool("jkztzd_itmw_rangerstaff", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_rangerstaff", 10);
	SetCraftScience("jkztzd_itmw_rangerstaff", "Плотник", 2);
	SetenergyPenalty("jkztzd_itmw_rangerstaff", 50);
	SetCraftEXP("jkztzd_itmw_rangerstaff", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_rangerstaff", "Плотник")	
	
AddItemCategory ("Плотник (2 уровень)", "jkztzd_itmw_addon_stab01"); --- Посох мага огня
	SetCraftAmount("jkztzd_itmw_addon_stab01", 1);
     AddIngre("jkztzd_itmw_addon_stab01", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddIngre("jkztzd_itmw_addon_stab01", "ooltyb_itmi_whool_holst", 2);
	 AddIngre("jkztzd_itmw_addon_stab01", "ooltyb_itmi_mage2", 1);
	 AddTool("jkztzd_itmw_addon_stab01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab01", 10);
	SetCraftScience("jkztzd_itmw_addon_stab01", "Плотник", 2);
	SetenergyPenalty("jkztzd_itmw_addon_stab01", 50);
	SetCraftEXP("jkztzd_itmw_addon_stab01", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab01", "Плотник")	
	
AddItemCategory ("Плотник (2 уровень)", "jkztzd_itmw_addon_stab02"); --- Посох мага воды
	SetCraftAmount("jkztzd_itmw_addon_stab02", 1);
     AddIngre("jkztzd_itmw_addon_stab02", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("jkztzd_itmw_addon_stab02", "ooltyb_itmi_whool_holst", 2);
	 AddIngre("jkztzd_itmw_addon_stab02", "ooltyb_itmi_mage2", 1);
	 AddTool("jkztzd_itmw_addon_stab02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab02", 10);
	SetCraftScience("jkztzd_itmw_addon_stab02", "Плотник", 2);
	SetenergyPenalty("jkztzd_itmw_addon_stab02", 50);
	SetCraftEXP("jkztzd_itmw_addon_stab02", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab02", "Плотник")	


AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Sld_Bow"); --- Солдатский лук
	SetCraftAmount("JKZTZD_ItRw_Sld_Bow", 1);
	 AddIngre("JKZTZD_ItRw_Sld_Bow", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Sld_Bow", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Sld_Bow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Sld_Bow", 10);
	SetCraftScience("JKZTZD_ItRw_Sld_Bow", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Sld_Bow", 50);
	SetCraftEXP("JKZTZD_ItRw_Sld_Bow", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Sld_Bow", "Плотник")
	
AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_L_04"); --- Вязовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_L_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_04", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_L_04", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_L_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_04", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_04", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_04", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_04", "Плотник")
	
	
AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_02"); --- Ясеневый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_02", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_02", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_02", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_02", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_02", "Плотник")
	
	
AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_03"); --- Длинный лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_03", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_03", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_03", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_03", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_03", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_03", "Плотник")
	
	
AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Bow_M_04"); --- Буковый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_M_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_04", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_04", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_04", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_04", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_04", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_04", "Плотник")


AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Crossbow_M_01"); --- Арбалет ополчения
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_01", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_01", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_M_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_01", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_01", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_01", 50);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_M_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_M_01", "Плотник")	
	
	
AddItemCategory ("Плотник (2 уровень)", "JKZTZD_ItRw_Crossbow_M_02"); --- Военный арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_02", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_02", "Плотник", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_02", 50);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_M_02", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_M_02", "Плотник")	
	
	
AddItemCategory ("Плотник (2 уровень)", "YFAUUN_ITSH_SHIELD_02"); --- Круглый щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_02", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("YFAUUN_ITSH_SHIELD_02", "ooltyb_itmi_nail", 1);
	 AddTool("YFAUUN_ITSH_SHIELD_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_02", 10);
	SetCraftScience("YFAUUN_ITSH_SHIELD_02", "Плотник", 2);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_02", 50);
	SetCraftEXP("YFAUUN_ITSH_SHIELD_02", 50)
	SetCraftEXP_SKILL("YFAUUN_ITSH_SHIELD_02", "Плотник")		
	

-- ПЛОТНИК 3 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 50 УРОНА И СТРЕЛКОВОЕ НА 40 УРОНА

AddItemCategory ("Плотник (3 уровень)", "jkztzd_itmw_addon_stab08"); --- Посох с кристаллом
	SetCraftAmount("jkztzd_itmw_addon_stab08", 1);
	 AddIngre("jkztzd_itmw_addon_stab08", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("jkztzd_itmw_addon_stab08", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("jkztzd_itmw_addon_stab08", "ooltyb_itmi_mage3", 1);
	 AddTool("jkztzd_itmw_addon_stab08", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab08", 20);
	SetCraftScience("jkztzd_itmw_addon_stab08", "Плотник", 3);
	SetenergyPenalty("jkztzd_itmw_addon_stab08", 75);
	SetCraftEXP("jkztzd_itmw_addon_stab08", 75)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab08", "Плотник")	
	
AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItMW_Addon_Stab09"); --- Фокусирующий посох
	SetCraftAmount("JKZTZD_ItMW_Addon_Stab09", 1);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "ooltyb_itmi_mage3", 1);
	 AddTool("JKZTZD_ItMW_Addon_Stab09", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_Addon_Stab09", 20);
	SetCraftScience("JKZTZD_ItMW_Addon_Stab09", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItMW_Addon_Stab09", 75);
	SetCraftEXP("JKZTZD_ItMW_Addon_Stab09", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Addon_Stab09", "Плотник")	
	
AddItemCategory ("Плотник (3 уровень)", "jkztzd_itmw_addon_stab07"); --- Магический посох
	SetCraftAmount("jkztzd_itmw_addon_stab07", 1);
	 AddIngre("jkztzd_itmw_addon_stab07", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("jkztzd_itmw_addon_stab07", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("jkztzd_itmw_addon_stab07", "ooltyb_itmi_mage3", 1);
	 AddTool("jkztzd_itmw_addon_stab07", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab07", 20);
	SetCraftScience("jkztzd_itmw_addon_stab07", "Плотник", 3);
	SetenergyPenalty("jkztzd_itmw_addon_stab07", 75);
	SetCraftEXP("jkztzd_itmw_addon_stab07", 75)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab07", "Плотник")

AddItemCategory ("Плотник (3 уровень)", "jkztzd_itrw_bow_m_01"); --- Композитный лук
	SetCraftAmount("jkztzd_itrw_bow_m_01", 1);
	 AddIngre("jkztzd_itrw_bow_m_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("jkztzd_itrw_bow_m_01", "ooltyb_itmi_nail", 2);
	 AddIngre("jkztzd_itrw_bow_m_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("jkztzd_itrw_bow_m_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itrw_bow_m_01", 20);
	SetCraftScience("jkztzd_itrw_bow_m_01", "Плотник", 3);
	SetenergyPenalty("jkztzd_itrw_bow_m_01", 75);
	SetCraftEXP("jkztzd_itrw_bow_m_01", 75)
	SetCraftEXP_SKILL("jkztzd_itrw_bow_m_01", "Плотник")


AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_01"); --- Костяной лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_01", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_01", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_01", "Плотник")

AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_02"); --- Дубовый лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_02", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_02", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_02", "Плотник")


AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Bow_H_03"); --- Военный лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_03", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_03", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_03", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_03", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_03", "Плотник")
	
AddItemCategory ("Плотник (3 уровень)", "JKZTZD_ItRw_Crossbow_H_01"); --- Тяжелый арбалет
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_01", "Плотник", 3);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_01", 75);	
	SetCraftEXP("JKZTZD_ItRw_Crossbow_H_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_H_01", "Плотник")
	
AddItemCategory ("Плотник (3 уровень)", "YFAUUN_ITSH_SHIELD_03"); --- Железный щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_03", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "ooltyb_itmi_nail", 2);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "ooltyb_itmi_whool_holst", 2);
	 AddTool("YFAUUN_ITSH_SHIELD_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_03", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_03", "Плотник", 3);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_03", 75);	
	SetCraftEXP("YFAUUN_ITSH_SHIELD_03", 75)
	SetCraftEXP_SKILL("YFAUUN_ITSH_SHIELD_03", "Плотник")
	
-- ПЛОТНИК 4 УРОВЕНЬ ДВУРУЧНОЕ ОРУЖИЕ НА 70 УРОНА И СТРЕЛКОВОЕ НА 60 УРОНА
	
AddItemCategory ("Плотник (4 уровень)", "jkztzd_itmw_addon_stab05"); --- Тайфун
	SetCraftAmount("jkztzd_itmw_addon_stab05", 1);
     AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_m_wire", 10);
	 AddIngre("jkztzd_itmw_addon_stab05", "OOLTYB_ITMI_HANDLE", 20);
	 AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_whool_holst", 10);
	 AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_mage4", 1);
	 AddIngre("jkztzd_itmw_addon_stab05", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_addon_stab05", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab05", 20);
	SetCraftScience("jkztzd_itmw_addon_stab05", "Плотник", 4);
	SetenergyPenalty("jkztzd_itmw_addon_stab05", 100);	

AddItemCategory ("Плотник (4 уровень)", "jkztzd_itmw_2h_mudreccw"); --- Мудрец
	SetCraftAmount("jkztzd_itmw_2h_mudreccw", 1);
     AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_m_wire", 10);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "OOLTYB_ITMI_HANDLE", 20);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_whool_holst", 10);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_mage4", 1);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_2h_mudreccw", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_2h_mudreccw", 20);
	SetCraftScience("jkztzd_itmw_2h_mudreccw", "Плотник", 4);
	SetenergyPenalty("jkztzd_itmw_2h_mudreccw", 100);	
	
AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Crossbow_H_02"); --- Арбалет охотника на драконов
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_RIVET", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_02", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_02", 100);	
	
	
AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_MagicCrossbow"); --- Магический арбалет
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicCrossbow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_RIVET", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicCrossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicCrossbow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 100);	
	
	
AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Bow_H_04"); --- Драконий лук
	SetCraftAmount("JKZTZD_ItRw_Bow_H_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Bow_H_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_04", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_04", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_04", 100);	
	
	
AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_MagicBow"); --- Магический лук
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicBow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicBow", 100);	
	
	
AddItemCategory ("Плотник (4 уровень)", "JKZTZD_ItRw_Addon_FireBow"); --- Огненный лук
	SetCraftAmount("JKZTZD_ItRw_Addon_FireBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_FireBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_FireBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_FireBow", "Плотник", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_FireBow", 100);	
	

AddItemCategory ("Плотник (4 уровень)", "YFAUUN_ITSH_SHIELD_04"); --- Костяной щит
	SetCraftAmount("YFAUUN_ITSH_SHIELD_04", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_handle", 15);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_nail", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("YFAUUN_ITSH_SHIELD_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_04", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_04", "Плотник", 4);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_04", 100);	
	
-- КОЖЕВНИК 1 ДОМАШНЯЯ УТВАРЬ
AddItemCategory ("Кожевник (Домашняя утварь)", "rc_house_armchair_wood"); --- Деревянное кресло с обшивкой
	SetCraftAmount("rc_house_armchair_wood", 1);
	 AddIngre("rc_house_armchair_wood", "OOLTYB_ItAt_WolfFur", 2);
	 AddIngre("rc_house_armchair_wood", "ooltyb_itmi_wood", 10);
	 AddAlterIngre("rc_house_armchair_wood", "OOLTYB_itat_LurkerSkin", 2);
	 AddAlterIngre("rc_house_armchair_wood", "ooltyb_itmi_wood", 10);
	SetCraftPenalty("rc_house_armchair_wood", 5);
	SetCraftScience("rc_house_armchair_wood", "Кожевник", 1);
	SetenergyPenalty("rc_house_armchair_wood", 25);
	SetCraftEXP("rc_house_armchair_wood", 25)
	SetCraftEXP_SKILL("rc_house_armchair_wood ", "Кожевник")
	
AddItemCategory ("Кожевник (Домашняя утварь)", "rc_house_armchair_rich"); --- Кожаное кресло
	SetCraftAmount("rc_house_armchair_rich ", 1);
	 AddIngre("rc_house_armchair_rich ", "OOLTYB_ITMI_LEATHER", 2);
	 AddIngre("rc_house_armchair_rich ", "ooltyb_itmi_wood", 5);
	SetCraftPenalty("rc_house_armchair_rich ", 5);
	SetCraftScience("rc_house_armchair_rich ", "Кожевник", 1);
	SetenergyPenalty("rc_house_armchair_rich ", 25);
	SetCraftEXP("rc_house_armchair_rich ", 25)
	SetCraftEXP_SKILL("rc_house_armchair_rich ", "Кожевник")
	
-- КОЖЕВНИК 1 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Кожевник (1 уровень)", "OOLTYB_ITMI_LEATHER"); --- Кожа
	SetCraftAmount("OOLTYB_ITMI_LEATHER", 1);
	 AddIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_ItAt_WolfFur", 2);
	 AddAlterIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_itat_LurkerSkin", 2);
	SetCraftPenalty("OOLTYB_ITMI_LEATHER", 5);
	SetCraftScience("OOLTYB_ITMI_LEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_LEATHER", 25);
	SetCraftEXP("OOLTYB_ITMI_LEATHER", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_LEATHER", "Кожевник")

--[[	AddItemCategory ("Кожевник (Расходники)", "OOLTYB_ITMI_QLEATHER"); --- Качественная кожа
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 2);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "Кожевник", 1);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);]]
	
	
-- КОЖЕВНИК 1 УРОВЕНЬ ДОСПЕХИ НА 10 ЗАЩИТЫ

AddItemCategory ("Кожевник (1 уровень)", "yfauun_itar_islam1"); --- Одеяние охотника
	SetCraftAmount("yfauun_itar_islam1", 1);
	 AddIngre("yfauun_itar_islam1", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("yfauun_itar_islam1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam1", 10);
	SetCraftScience("yfauun_itar_islam1", "Кожевник", 1);
	SetenergyPenalty("yfauun_itar_islam1", 25);
	SetCraftEXP("yfauun_itar_islam1", 25)
	SetCraftEXP_SKILL("yfauun_itar_islam1", "Кожевник")

AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ItAr_FRONTIER10"); --- Ламеллярное одеяние
	SetCraftAmount("YFAUUN_ItAr_FRONTIER10", 1);
	 AddIngre("YFAUUN_ItAr_FRONTIER10", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ItAr_FRONTIER10", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_FRONTIER10", 10);
	SetCraftScience("YFAUUN_ItAr_FRONTIER10", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ItAr_FRONTIER10", 25);
	SetCraftEXP("YFAUUN_ItAr_FRONTIER10", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_FRONTIER10", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_WOODCUTTER"); --- Одежда лесоруба
	SetCraftAmount("YFAUUN_ITAR_WOODCUTTER", 1);
	 AddIngre("YFAUUN_ITAR_WOODCUTTER", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_WOODCUTTER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	SetCraftScience("YFAUUN_ITAR_WOODCUTTER", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_WOODCUTTER", 25);
	SetCraftEXP("YFAUUN_ITAR_WOODCUTTER", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WOODCUTTER", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_Leather_L"); --- Кожаное одеяние
	SetCraftAmount("YFAUUN_ITAR_Leather_L", 1);
	 AddIngre("YFAUUN_ITAR_Leather_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_Leather_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Leather_L", 10);
	SetCraftScience("YFAUUN_ITAR_Leather_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_Leather_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Leather_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Leather_L", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_BABE_LEATHER_L"); --- Кожаное одеяние жен
	SetCraftAmount("YFAUUN_ITAR_BABE_LEATHER_L", 1);
	 AddIngre("YFAUUN_ITAR_BABE_LEATHER_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_BABE_LEATHER_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 10);
	SetCraftScience("YFAUUN_ITAR_BABE_LEATHER_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 25);
	SetCraftEXP("YFAUUN_ITAR_BABE_LEATHER_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BABE_LEATHER_L", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ItAr_HNT_L"); --- Одежда охотника
	SetCraftAmount("YFAUUN_ItAr_HNT_L", 1);
	 AddIngre("YFAUUN_ItAr_HNT_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ItAr_HNT_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_HNT_L", 10);
	SetCraftScience("YFAUUN_ItAr_HNT_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ItAr_HNT_L", 25);
	SetCraftEXP("YFAUUN_ItAr_HNT_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_HNT_L", "Кожевник")

AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_PIR_M_HORINIS"); --- Одежда моряка
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 25);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_HORINIS", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_HORINIS", "Кожевник")

AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_OLDCAMP_L"); --- Одежда Тени
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMP_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMP_L", "Кожевник")
	
	
AddItemCategory ("Кожевник (1 уровень)", "YFAUUN_ITAR_NEWCAMP_L"); --- Одежда вора
	SetCraftAmount("YFAUUN_ITAR_NEWCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMP_L", "Кожевник", 1);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMP_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMP_L", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "yfauun_itar_babe_bandit"); --- Доспехи воровки
	SetCraftAmount("yfauun_itar_babe_bandit", 1);
	 AddIngre("yfauun_itar_babe_bandit", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("yfauun_itar_babe_bandit", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_babe_bandit", 10);
	SetCraftScience("yfauun_itar_babe_bandit", "Кожевник", 1);
	SetenergyPenalty("yfauun_itar_babe_bandit", 25);
	SetCraftEXP("yfauun_itar_babe_bandit", 25)
	SetCraftEXP_SKILL("yfauun_itar_babe_bandit", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "itar_arx_r_l"); --- Одеяние гонца Араксос
	SetCraftAmount("itar_arx_r_l", 1);
	 AddIngre("itar_arx_r_l", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("itar_arx_r_l", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_r_l", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_arx_r_l", 10);
	SetCraftScience("itar_arx_r_l", "Кожевник", 1);
	SetenergyPenalty("itar_arx_r_l", 25);
	SetCraftEXP("itar_arx_r_l", 25)
	SetCraftEXP_SKILL("itar_arx_r_l", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "ITAR_BES_DOSP1"); --- Одеяние воина Бессмертных
	SetCraftAmount("ITAR_BES_DOSP1", 1);
	 AddIngre("ITAR_BES_DOSP1", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("ITAR_BES_DOSP1", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_BES_DOSP1", 10);
	SetCraftScience("ITAR_BES_DOSP1", "Кожевник", 1);
	SetenergyPenalty("ITAR_BES_DOSP1", 25);
	SetCraftEXP("ITAR_BES_DOSP1", 25)
	SetCraftEXP_SKILL("ITAR_BES_DOSP1", "Кожевник")
	
AddItemCategory ("Кожевник (1 уровень)", "itar_syn_ldosp"); --- Одеяние Синдиката
	SetCraftAmount("itar_syn_ldosp", 1);
	 AddIngre("itar_syn_ldosp", "OOLTYB_ITMI_LEATHER", 4);
	 AddTool("itar_syn_ldosp", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_ldosp", 10);
	SetCraftScience("itar_syn_ldosp", "Кожевник", 1);
	SetenergyPenalty("itar_syn_ldosp", 25);
	SetCraftEXP("itar_syn_ldosp", 25)
	SetCraftEXP_SKILL("itar_syn_ldosp", "Кожевник")

-- КОЖЕВНИК 2 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Кожевник (2 уровень)", "OOLTYB_ITMI_QLEATHER"); --- Качественная кожа
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "ooltyb_itat_shadowfur", 2);
	 AddAlterIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "Кожевник", 2);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);
	SetCraftEXP("OOLTYB_ITMI_QLEATHER", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_QLEATHER", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "ooltyb_itmi_t_leather"); --- Тонкая кожа
	SetCraftAmount("ooltyb_itmi_t_leather", 1);
	 AddIngre("ooltyb_itmi_t_leather", "OOLTYB_ITMI_LEATHER", 1);
	SetCraftPenalty("ooltyb_itmi_t_leather", 10);
	SetCraftScience("ooltyb_itmi_t_leather", "Кожевник", 2);
	SetenergyPenalty("ooltyb_itmi_t_leather", 50);
	SetCraftEXP("ooltyb_itmi_t_leather", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_t_leather", "Кожевник")
	
	
-- КОЖЕВНИК 2 УРОВЕНЬ ДОСПЕХИ НА 20 ЗАЩИТЫ

AddItemCategory ("Кожевник (2 уровень)", "yfauun_itar_islam2"); --- Легкие доспехи охотника
	SetCraftAmount("yfauun_itar_islam2", 1);
	 AddIngre("yfauun_itar_islam2", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("yfauun_itar_islam2", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("yfauun_itar_islam2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam2", 10);
	SetCraftScience("yfauun_itar_islam2", "Кожевник", 2);
	SetenergyPenalty("yfauun_itar_islam2", 50);
	SetCraftEXP("yfauun_itar_islam2", 50)
	SetCraftEXP_SKILL("yfauun_itar_islam2", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL11"); --- Легкие кожаные доспехи
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL11", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL11", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL11", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL11", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL11", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL11", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL11", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ItAr_COL"); --- Легкие доспехи колониста
	SetCraftAmount("YFAUUN_ItAr_COL", 1);
	 AddIngre("YFAUUN_ItAr_COL", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ItAr_COL", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ItAr_COL", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_COL", 10);
	SetCraftScience("YFAUUN_ItAr_COL", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ItAr_COL", 50);
	SetCraftEXP("YFAUUN_ItAr_COL", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_COL", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_HUNTER3"); --- Прошитая куртка охотника
	SetCraftAmount("YFAUUN_ITAR_HUNTER3", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_HUNTER3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER3", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER3", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER3", 50);
	SetCraftEXP("YFAUUN_ITAR_HUNTER3", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_HUNTER3", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_PIR_L_Addon"); --- Легкие доспехи пирата
	SetCraftAmount("YFAUUN_ITAR_PIR_L_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_PIR_L_Addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_L_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_L_Addon", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_L_Addon", 50);
	SetCraftEXP("YFAUUN_ITAR_PIR_L_Addon", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_L_Addon", "Кожевник")
		
AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_WALKER"); --- Кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_WALKER", 1);
	 AddIngre("YFAUUN_ITAR_WALKER", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_WALKER", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_WALKER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WALKER", 10);
	SetCraftScience("YFAUUN_ITAR_WALKER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_WALKER", 50);
	SetCraftEXP("YFAUUN_ITAR_WALKER", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WALKER", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_TRAVELER"); --- Толстый кожаный плащ
	SetCraftAmount("YFAUUN_ITAR_TRAVELER", 1);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_TRAVELER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_TRAVELER", 10);
	SetCraftScience("YFAUUN_ITAR_TRAVELER", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_TRAVELER", 50);
	SetCraftEXP("YFAUUN_ITAR_TRAVELER", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_TRAVELER", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_NEUTRAL"); --- Куртка охотника
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ItAr_LARM_M"); --- Легкие доспехи лесника
	SetCraftAmount("YFAUUN_ItAr_LARM_M", 1);
	 AddIngre("YFAUUN_ItAr_LARM_M", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ItAr_LARM_M", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ItAr_LARM_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_LARM_M", 10);	
	SetCraftScience("YFAUUN_ItAr_LARM_M", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ItAr_LARM_M", 50);
	SetCraftEXP("YFAUUN_ItAr_LARM_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_LARM_M", "Кожевник")

AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ITAR_REDSHAR"); --- Легкие доспехи призрака
	SetCraftAmount("YFAUUN_ITAR_REDSHAR", 1);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_REDSHAR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_REDSHAR", 10);
	SetCraftScience("YFAUUN_ITAR_REDSHAR", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ITAR_REDSHAR", 50);
	SetCraftEXP("YFAUUN_ITAR_REDSHAR", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_REDSHAR", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "YFAUUN_ORG_NEWCAMP_M"); --- Легкие доспехи вора
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_M", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_M", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_M", "Кожевник", 2);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_M", 50);
	SetCraftEXP("YFAUUN_ORG_NEWCAMP_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ORG_NEWCAMP_M", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "itar_arx_h1"); --- Легкие доспехи охотника Араксос
	SetCraftAmount("itar_arx_h1", 1);
	 AddIngre("itar_arx_h1", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_arx_h1", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_arx_h1", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_h1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_arx_h1", 10);
	SetCraftScience("itar_arx_h1", "Кожевник", 2);
	SetenergyPenalty("itar_arx_h1", 50);
	SetCraftEXP("itar_arx_h1", 50)
	SetCraftEXP_SKILL("itar_arx_h1", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "ITAR_BES_DOSP7"); --- Облачение торговца Бессмертных
	SetCraftAmount("ITAR_BES_DOSP7", 1);
	 AddIngre("ITAR_BES_DOSP7", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("ITAR_BES_DOSP7", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("ITAR_BES_DOSP7", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP7", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_BES_DOSP7", 10);
	SetCraftScience("ITAR_BES_DOSP7", "Кожевник", 2);
	SetenergyPenalty("ITAR_BES_DOSP7", 50);
	SetCraftEXP("ITAR_BES_DOSP7", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP7", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "itar_mil_a_l"); --- Капральские доспехи стражника
	SetCraftAmount("itar_mil_a_l", 1);
	 AddIngre("itar_mil_a_l", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_mil_a_l", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_mil_a_l", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l", 10);
	SetCraftScience("itar_mil_a_l", "Кожевник", 2);
	SetenergyPenalty("itar_mil_a_l", 50);
	SetCraftEXP("itar_mil_a_l", 50)
	SetCraftEXP_SKILL("itar_mil_a_l", "Кожевник")
	
AddItemCategory ("Кожевник (2 уровень)", "itar_syn_marmor"); --- Легкие доспехи синдиката
	SetCraftAmount("itar_syn_marmor", 1);
	 AddIngre("itar_syn_marmor", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_syn_marmor", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_syn_marmor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_marmor", 10);
	SetCraftScience("itar_syn_marmor", "Кожевник", 2);
	SetenergyPenalty("itar_syn_marmor", 50);
	SetCraftEXP("itar_syn_marmor", 50)
	SetCraftEXP_SKILL("itar_syn_marmor", "Кожевник")

-- КОЖЕВНИК 3 УРОВНЯ ДОСПЕХИ НА 30 ЗАЩИТЫ

AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_VALLEY_M"); --- Броня степного воина
	SetCraftAmount("YFAUUN_VALLEY_M", 1);
	 AddIngre("YFAUUN_VALLEY_M", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_VALLEY_M", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_VALLEY_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_VALLEY_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_VALLEY_M", 10);
	SetCraftScience("YFAUUN_VALLEY_M", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_VALLEY_M", 75);
	SetCraftEXP("YFAUUN_VALLEY_M", 75)
	SetCraftEXP_SKILL("YFAUUN_VALLEY_M", "Кожевник")

AddItemCategory ("Кожевник (3 уровень)", "yfauun_itar_islam3"); --- Средние доспехи охотника
	SetCraftAmount("yfauun_itar_islam3", 1);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_qleather", 5);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_islam3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam3", 10);
	SetCraftScience("yfauun_itar_islam3", "Кожевник", 3);
	SetenergyPenalty("yfauun_itar_islam3", 75);
	SetCraftEXP("yfauun_itar_islam3", 75)
	SetCraftEXP_SKILL("yfauun_itar_islam3", "Кожевник")

AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ItAr_BDT_H"); --- Средние доспехи из шкур с шарфом
	SetCraftAmount("YFAUUN_ItAr_BDT_H", 1);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_BDT_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_BDT_H", 10);
	SetCraftScience("YFAUUN_ItAr_BDT_H", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ItAr_BDT_H", 75);
	SetCraftEXP("YFAUUN_ItAr_BDT_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_BDT_H", "Кожевник")
	
	
AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_HUNTER4"); --- Куртка охотника из качественных шкур
	SetCraftAmount("YFAUUN_ITAR_HUNTER4", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_HUNTER4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER4", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER4", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER4", 75);
	SetCraftEXP("YFAUUN_ITAR_HUNTER4", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_HUNTER4", "Кожевник")
	
AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_NEUTRALM"); --- Средние доспехи убийцы
	SetCraftAmount("YFAUUN_ITAR_NEUTRALM", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_NEUTRALM", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRALM", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRALM", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRALM", 75);
	SetCraftEXP("YFAUUN_ITAR_NEUTRALM", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRALM", "Кожевник")
	
AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_PIR_M_Addon"); --- Средние доспехи пирата
	SetCraftAmount("YFAUUN_ITAR_PIR_M_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_Addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_Addon", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_Addon", 75);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_Addon", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_Addon", "Кожевник")
	
AddItemCategory ("Кожевник (3 уровень)", "yfauun_itar_sld_l_g2"); --- Меховые доспехи наемника
	SetCraftAmount("yfauun_itar_sld_l_g2", 1);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_qleather", 5);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_sld_l_g2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_sld_l_g2", 10);
	SetCraftScience("yfauun_itar_sld_l_g2", "Кожевник", 3);
	SetenergyPenalty("yfauun_itar_sld_l_g2", 75);
	SetCraftEXP("yfauun_itar_sld_l_g2", 75)
	SetCraftEXP_SKILL("yfauun_itar_sld_l_g2", "Кожевник")	
	
AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ORG_NEWCAMP_H"); --- Средние доспехи вора 
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_H", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ORG_NEWCAMP_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_H", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_H", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_H", 75);
	SetCraftEXP("YFAUUN_ORG_NEWCAMP_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ORG_NEWCAMP_H", "Кожевник")
	
AddItemCategory ("Кожевник (3 уровень)", "YFAUUN_ITAR_OLDCAMP_M"); --- Средние Доспехи призрака
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_M", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_M", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_M", "Кожевник", 3);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_M", 75);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMP_M", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMP_M", "Кожевник")

AddItemCategory ("Кожевник (3 уровень)", "jar_itar_popochka3"); --- Средние доспехи конкистадора
	SetCraftAmount("jar_itar_popochka3", 1);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_qleather", 5);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_m_wire", 3);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("jar_itar_popochka3", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("jar_itar_popochka3", "OOLTYB_ITMI_JAR1");
	SetCraftPenalty("jar_itar_popochka3", 10);
	SetCraftScience("jar_itar_popochka3", "Кожевник", 3);
	SetenergyPenalty("jar_itar_popochka3", 75);
	SetCraftEXP("jar_itar_popochka3", 75)
	SetCraftEXP_SKILL("jar_itar_popochka3", "Кожевник")

AddItemCategory ("Кожевник (3 уровень)", "ITAR_ARX_H2"); --- Средние доспехи охотника Араксос
	SetCraftAmount("ITAR_ARX_H2", 1);
	 AddIngre("ITAR_ARX_H2", "ooltyb_itmi_qleather", 5);
	 AddIngre("ITAR_ARX_H2", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("ITAR_ARX_H2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("ITAR_ARX_H2", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("ITAR_ARX_H2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_ARX_H2", 10);
	SetCraftScience("ITAR_ARX_H2", "Кожевник", 3);
	SetenergyPenalty("ITAR_ARX_H2", 75);
	SetCraftEXP("ITAR_ARX_H2", 75)
	SetCraftEXP_SKILL("ITAR_ARX_H2", "Кожевник")
	
AddItemCategory ("Кожевник (3 уровень)", "itar_syn_djgl"); --- Средние доспехи Синдиката
	SetCraftAmount("itar_syn_djgl", 1);
	 AddIngre("itar_syn_djgl", "ooltyb_itmi_qleather", 5);
	 AddIngre("itar_syn_djgl", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("itar_syn_djgl", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_syn_djgl", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_djgl", 10);
	SetCraftScience("itar_syn_djgl", "Кожевник", 3);
	SetenergyPenalty("itar_syn_djgl", 75);
	SetCraftEXP("itar_syn_djgl", 75)
	SetCraftEXP_SKILL("itar_syn_djgl", "Кожевник")

-- КОЖЕВНИК 4 УРОВНЯ ДОСПЕХИ НА 40 ЗАЩИТЫ

AddItemCategory ("Кожевник (4 уровень)", "yfauun_itar_pir_h_addon"); --- Тяжелые доспехи пирата
	SetCraftAmount("yfauun_itar_pir_h_addon", 1);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_pir_h_addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_pir_h_addon", 10);
	SetCraftScience("yfauun_itar_pir_h_addon", "Кожевник", 4);
	SetenergyPenalty("yfauun_itar_pir_h_addon", 100);

AddItemCategory ("Кожевник (4 уровень)", "yfauun_itar_kllr_h"); --- Тяжелые доспехи убийцы
	SetCraftAmount("yfauun_itar_kllr_h", 1);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_kllr_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kllr_h", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_kllr_h", 10);
	SetCraftScience("yfauun_itar_kllr_h", "Кожевник", 4);
	SetenergyPenalty("yfauun_itar_kllr_h", 100);

AddItemCategory ("Кожевник (4 уровень)", "yfauun_itar_orchunterh"); --- Броня нордмарца
	SetCraftAmount("yfauun_itar_orchunterh", 1);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_orchunterh", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_orchunterh", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_orchunterh", 10);
	SetCraftScience("yfauun_itar_orchunterh", "Кожевник", 4);
	SetenergyPenalty("yfauun_itar_orchunterh", 100);
	
AddItemCategory ("Кожевник (4 уровень)", "yfauun_itar_neutral12"); --- Мастерская кожаная броня
	SetCraftAmount("yfauun_itar_neutral12", 1);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_neutral12", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_neutral12", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_neutral12", 10);
	SetCraftScience("yfauun_itar_neutral12", "Кожевник", 4);
	SetenergyPenalty("yfauun_itar_neutral12", 100);

-- БРОННИК 1 домашняя утварь

AddItemCategory ("Бронник (Домашняя утварь)", "rc_house_otherstand"); ----- Стойка для вещей
	SetCraftAmount("rc_house_otherstand", 1);
	 AddIngre("rc_house_otherstand", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("rc_house_otherstand", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_otherstand", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_otherstand", 5);
	SetCraftScience("rc_house_otherstand", "Бронник", 1);
	SetenergyPenalty("rc_house_otherstand", 25);
	SetCraftEXP("rc_house_otherstand", 25)
	SetCraftEXP_SKILL("rc_house_otherstand", "Бронник")
	
AddItemCategory ("Бронник (Домашняя утварь)", "rc_house_armchair_rofl"); ----- Кресло с шипами
	SetCraftAmount("rc_house_armchair_rofl", 1);
	 AddIngre("rc_house_armchair_rofl", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_armchair_rofl", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_armchair_rofl", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_armchair_rofl", 5);
	SetCraftScience("rc_house_armchair_rofl", "Бронник", 1);
	SetenergyPenalty("rc_house_armchair_rofl", 25);
	SetCraftEXP("rc_house_armchair_rofl", 25)
	SetCraftEXP_SKILL("rc_house_armchair_rofl", "Бронник")
	
AddItemCategory ("Бронник (Домашняя утварь)", "rc_house_stand_armor_9"); ----- Настенный стенд с сапогами
	SetCraftAmount("rc_house_stand_armor_9", 1);
	 AddIngre("rc_house_stand_armor_9", "ooltyb_itat_wolffur", 2);
	 AddIngre("rc_house_stand_armor_9", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_stand_armor_9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_stand_armor_9", 5);
	SetCraftScience("rc_house_stand_armor_9", "Бронник", 1);
	SetenergyPenalty("rc_house_stand_armor_9", 25);
	SetCraftEXP("rc_house_stand_armor_9", 25)
	SetCraftEXP_SKILL("rc_house_stand_armor_9", "Бронник")

-- БРОННИК 1 УРОВНЯ РАСХОДНИКИ И ИНСТРУМЕНТЫ

AddItemCategory ("Бронник (1 уровень)", "OOLTYB_ITMI_S_IGNOT"); ----- Слиток
	SetCraftAmount("OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("OOLTYB_ITMI_S_IGNOT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_S_IGNOT", 5);
	SetCraftScience("OOLTYB_ITMI_S_IGNOT", "Бронник", 1);
	SetenergyPenalty("OOLTYB_ITMI_S_IGNOT", 25);
	SetCraftEXP("OOLTYB_ITMI_S_IGNOT", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_S_IGNOT", "Бронник")
	

AddItemCategory ("Бронник (1 уровень)", "yvnzmz_itmi_zamok"); --- Замок
	SetCraftAmount("yvnzmz_itmi_zamok", 1);
	 AddIngre("yvnzmz_itmi_zamok", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("yvnzmz_itmi_zamok", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yvnzmz_itmi_zamok", 5);
	SetCraftScience("yvnzmz_itmi_zamok", "Бронник", 1);
	SetenergyPenalty("yvnzmz_itmi_zamok", 25);
	SetCraftEXP("yvnzmz_itmi_zamok", 25)
	SetCraftEXP_SKILL("yvnzmz_itmi_zamok", "Бронник")


AddItemCategory ("Бронник (1 уровень)", "JKZTZD_ItMw_2H_Axe_L_01"); ---- Кирка
	SetCraftAmount("JKZTZD_ItMw_2H_Axe_L_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Axe_L_01", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_2H_Axe_L_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Axe_L_01", 2);
	SetCraftScience("JKZTZD_ItMw_2H_Axe_L_01", "Бронник", 1);
	SetenergyPenalty("JKZTZD_ItMw_2H_Axe_L_01", 25);
	SetCraftEXP("JKZTZD_ItMw_2H_Axe_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Axe_L_01", "Бронник")
	
AddItemCategory ("Бронник (1 уровень)", "JKZTZD_ItMw_1h_Bau_Axe"); ---- Серп
	SetCraftAmount("JKZTZD_ItMw_1h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_1h_Bau_Axe", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_1h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Bau_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Bau_Axe", "Бронник", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Bau_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Bau_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Bau_Axe", "Бронник")

	
AddItemCategory ("Бронник (1 уровень)", "OOLTYB_ItMi_PaN"); --- Сковородка
	SetCraftAmount("OOLTYB_ItMi_PaN", 1);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ItMi_Iron", 5);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("OOLTYB_ItMi_Pan", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMi_Pan", 2);
	SetCraftScience("OOLTYB_ItMi_Pan", "Бронник", 1);
	SetenergyPenalty("OOLTYB_ItMi_Pan", 10);
	SetCraftEXP("OOLTYB_ItMi_Pan", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Pan", "Бронник")

	
--AddItemCategory ("Бронник (1 уровень)", "OOLTYB_ITMI_SCISSORS"); ---- Ножницы
	--SetCraftAmount("OOLTYB_ITMI_SCISSORS", 1);
	-- AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("OOLTYB_ITMI_SCISSORS", "JKZTZD_ItMw_1H_Mace_L_04");
	--SetCraftPenalty("OOLTYB_ITMI_SCISSORS", 2);
	--SetCraftScience("OOLTYB_ITMI_SCISSORS", "Бронник", 1);
	--SetenergyPenalty("OOLTYB_ITMI_SCISSORS", 10);
	--SetCraftEXP("OOLTYB_ITMI_SCISSORS", 10)
	--SetCraftEXP_SKILL("OOLTYB_ITMI_SCISSORS", "Бронник")	
	
	
AddItemCategory ("Бронник (1 уровень)", "YVNZMZ_ITMI_NEEDLE"); --- Игла
	SetCraftAmount("YVNZMZ_ITMI_NEEDLE", 1);
	 AddIngre("YVNZMZ_ITMI_NEEDLE", "OOLTYB_ItMi_Iron", 5);
	 AddTool("YVNZMZ_ITMI_NEEDLE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YVNZMZ_ITMI_NEEDLE", 2);
	SetCraftScience("YVNZMZ_ITMI_NEEDLE", "Бронник", 1);
	SetenergyPenalty("YVNZMZ_ITMI_NEEDLE", 10);	
	SetCraftEXP("YVNZMZ_ITMI_NEEDLE", 10)
	SetCraftEXP_SKILL("YVNZMZ_ITMI_NEEDLE", "Бронник")	

-- БРОННИК 1 УРОВНЯ БРОНЯ НА 10 ЗАЩИТЫ

AddItemCategory ("Бронник (1 уровень)", "YFAUUN_ItAr_RANGER_H"); --- Кольчуга с кожаной курткой
	SetCraftAmount("YFAUUN_ItAr_RANGER_H", 1);
	 AddIngre("YFAUUN_ItAr_RANGER_H", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_RANGER_H", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_RANGER_H", 10);
	SetCraftScience("YFAUUN_ItAr_RANGER_H", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_RANGER_H", 25);
	SetCraftEXP("YFAUUN_ItAr_RANGER_H", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_RANGER_H", "Бронник")

AddItemCategory ("Бронник (1 уровень)", "YFAUUN_ItAr_GHRB"); --- Кольчужное одеяние
	SetCraftAmount("YFAUUN_ItAr_GHRB", 1);
	 AddIngre("YFAUUN_ItAr_GHRB", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_GHRB", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_GHRB", 10);
	SetCraftScience("YFAUUN_ItAr_GHRB", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ItAr_GHRB", 25);
	SetCraftEXP("YFAUUN_ItAr_GHRB", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_GHRB", "Бронник")

AddItemCategory ("Бронник (1 уровень)", "YFAUUN_SLD_ARMOR_L3"); --- Наплечник наемника
	SetCraftAmount("YFAUUN_SLD_ARMOR_L3", 1);
	 AddIngre("YFAUUN_SLD_ARMOR_L3", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_SLD_ARMOR_L3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_SLD_ARMOR_L3", 10);
	SetCraftScience("YFAUUN_SLD_ARMOR_L3", "Бронник", 1);
	SetenergyPenalty("yfauun_sld_armor_l3", 25);
	SetCraftEXP("YFAUUN_SLD_ARMOR_L3", 25)
	SetCraftEXP_SKILL("YFAUUN_SLD_ARMOR_L3", "Бронник")
	
AddItemCategory ("Бронник (1 уровень)", "YFAUUN_ITAR_OLDCAMPG_L"); --- Доспехи стражника-новобранца
	SetCraftAmount("YFAUUN_ITAR_OLDCAMPG_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMPG_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMPG_L", "Бронник", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMPG_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMPG_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMPG_L", "Бронник")

AddItemCategory ("Бронник (1 уровень)", "jar_ithl_yznik"); --- Кандалы узника
	SetCraftAmount("jar_ithl_yznik", 1);
	 AddIngre("jar_ithl_yznik", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("jar_ithl_yznik", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jar_ithl_yznik", 10);
	SetCraftScience("jar_ithl_yznik", "Бронник", 1);
	SetenergyPenalty("jar_ithl_yznik", 25);
	SetCraftEXP("jar_ithl_yznik", 25)
	SetCraftEXP_SKILL("jar_ithl_yznik", "Бронник")

-- БРОННИК 2 УРОВНЯ РАСХОДНИКИ

AddItemCategory ("Бронник (2 уровень)", "OOLTYB_ItMiSwordraw"); ----- Обработанная сталь
	SetCraftAmount("OOLTYB_ItMiSwordraw", 1);
	 AddIngre("OOLTYB_ItMiSwordraw", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("OOLTYB_ItMiSwordraw", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMiSwordraw", 10);
	SetCraftScience("OOLTYB_ItMiSwordraw", "Бронник", 2);
	SetenergyPenalty("OOLTYB_ItMiSwordraw", 50);
	SetCraftEXP("OOLTYB_ItMiSwordraw", 50)
	SetCraftEXP_SKILL("OOLTYB_ItMiSwordraw", "Бронник")
	
AddItemCategory ("Бронник (2 уровень)", "OOLTYB_ITMI_RIVET"); ----- Заклепка
	SetCraftAmount("OOLTYB_ITMI_RIVET", 1);
	 AddIngre("OOLTYB_ITMI_RIVET", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("OOLTYB_ITMI_RIVET", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_RIVET", 10);
	SetCraftScience("OOLTYB_ITMI_RIVET", "Бронник", 2);
	SetenergyPenalty("OOLTYB_ITMI_RIVET", 50);
	SetCraftEXP("OOLTYB_ITMI_RIVET", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_RIVET", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "ooltyb_itmi_nail"); ----- Гвоздь
	SetCraftAmount("ooltyb_itmi_nail", 1);
	 AddIngre("ooltyb_itmi_nail", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("ooltyb_itmi_nail", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmi_nail", 10);
	SetCraftScience("ooltyb_itmi_nail", "Бронник", 2);
	SetenergyPenalty("ooltyb_itmi_nail", 50);
	SetCraftEXP("ooltyb_itmi_nail", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_nail", "Бронник")

-- БРОННИК 2 УРОВНЯ ДОСПЕХИ НА 20 ЗАЩИТЫ

AddItemCategory ("Бронник (2 уровень)", "YFAUUN_ITAR_CHAINMAIL"); --- Легкая кольчуга
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ITAR_CHAINMAIL", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL", 50);
	SetCraftEXP("YFAUUN_ITAR_CHAINMAIL", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_CHAINMAIL", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "YFAUUN_ItAr_ALBINO"); --- Доспехи альбиноса
	SetCraftAmount("YFAUUN_ItAr_ALBINO", 1);
	 AddIngre("YFAUUN_ItAr_ALBINO", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ItAr_ALBINO", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_ALBINO", 10);
	SetCraftScience("YFAUUN_ItAr_ALBINO", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ItAr_ALBINO", 50);
	SetCraftEXP("YFAUUN_ItAr_ALBINO", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_ALBINO", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_itar_oldcampg_m"); --- Легкие доспехи стражника
	SetCraftAmount("yfauun_itar_oldcampg_m", 1);
	 AddIngre("yfauun_itar_oldcampg_m", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("yfauun_itar_oldcampg_m", "ooltyb_itmi_m_wire", 1);
	 AddTool("yfauun_itar_oldcampg_m", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_oldcampg_m", 10);
	SetCraftScience("yfauun_itar_oldcampg_m", "Бронник", 2);
	SetenergyPenalty("yfauun_itar_oldcampg_m", 50);
	SetCraftEXP("yfauun_itar_oldcampg_m", 50)
	SetCraftEXP_SKILL("yfauun_itar_oldcampg_m", "Бронник")	
	
AddItemCategory ("Бронник (2 уровень)", "YFAUUN_ITAR_NEWCAMPM_L"); --- Легкие доспехи наемника
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_L", "Бронник", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_L", 50);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMPM_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMPM_L", "Бронник")	
	
AddItemCategory ("Бронник (2 уровень)", "itar_arx_b"); --- Легкие доспехи наемника Араксос
	SetCraftAmount("itar_arx_b", 1);
	 AddIngre("itar_arx_b", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("itar_arx_b", "ooltyb_itmi_m_wire", 1);
	 AddTool("itar_arx_b", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("itar_arx_b", "OOLTYB_ITMI_RECIPEAR");
	SetCraftPenalty("itar_arx_b", 10);
	SetCraftScience("itar_arx_b", "Бронник", 2);
	SetenergyPenalty("itar_arx_b", 50);
	SetCraftEXP("itar_arx_b", 50)
	SetCraftEXP_SKILL("itar_arx_b", "Бронник")
	
AddItemCategory ("Бронник (2 уровень)", "ITAR_BES_DOSP2"); --- Легкие доспехи воина Бессмертных
	SetCraftAmount("ITAR_BES_DOSP2", 1);
	 AddIngre("ITAR_BES_DOSP2", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("ITAR_BES_DOSP2", "ooltyb_itmi_m_wire", 1);
	 AddTool("ITAR_BES_DOSP2", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("ITAR_BES_DOSP2", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP2", 10);
	SetCraftScience("ITAR_BES_DOSP2", "Бронник", 2);
	SetenergyPenalty("ITAR_BES_DOSP2", 50);
	SetCraftEXP("ITAR_BES_DOSP2", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP2", "Бронник")
	
AddItemCategory ("Бронник (2 уровень)", "yfauun_itar_circlewl"); --- Легкие доспехи Круга Воды
	SetCraftAmount("yfauun_itar_circlewl", 1);
	 AddIngre("yfauun_itar_circlewl", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("yfauun_itar_circlewl", "ooltyb_itmi_m_wire", 1);
	 AddTool("yfauun_itar_circlewl", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("yfauun_itar_circlewl", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_circlewl", 10);
	SetCraftScience("yfauun_itar_circlewl", "Бронник", 2);
	SetenergyPenalty("yfauun_itar_circlewl", 50);
	SetCraftEXP("yfauun_itar_circlewl", 50)
	SetCraftEXP_SKILL("yfauun_itar_circlewl", "Бронник")
	
AddItemCategory ("Бронник (2 уровень)", "itar_pal_zact2"); --- Легкие доспехи Ордена Заката
	SetCraftAmount("itar_pal_zact2", 1);
	 AddIngre("itar_pal_zact2", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("itar_pal_zact2", "ooltyb_itmi_m_wire", 1);
	 AddTool("itar_pal_zact2", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("itar_pal_zact2", "ooltyb_itmi_recipe2");
	SetCraftPenalty("itar_pal_zact2", 10);
	SetCraftScience("itar_pal_zact2", "Бронник", 2);
	SetenergyPenalty("itar_pal_zact2", 50);
	SetCraftEXP("itar_pal_zact2", 50)
	SetCraftEXP_SKILL("itar_pal_zact2", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_ithl_m_helmet1"); -- Железный шлем
   SetCraftAmount("yfauun_ithl_m_helmet1", 1);
    AddIngre("yfauun_ithl_m_helmet1", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet1", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet1", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet1", 10);
   SetCraftScience("yfauun_ithl_m_helmet1", "Бронник", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet1", 25);
   SetCraftEXP("yfauun_ithl_m_helmet1", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet1", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_ithl_m_helmet2"); -- Шлем наемника
   SetCraftAmount("yfauun_ithl_m_helmet2", 1);
    AddIngre("yfauun_ithl_m_helmet2", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet2", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet2", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet2", 10);
   SetCraftScience("yfauun_ithl_m_helmet2", "Бронник", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet2", 25);
   SetCraftEXP("yfauun_ithl_m_helmet2", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet2", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_ithl_m_helmet3"); -- Шлем солдата
   SetCraftAmount("yfauun_ithl_m_helmet3", 1);
    AddIngre("yfauun_ithl_m_helmet3", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet3", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet3", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet3", 10);
   SetCraftScience("yfauun_ithl_m_helmet3", "Бронник", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet3", 25);
   SetCraftEXP("yfauun_ithl_m_helmet3", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet3", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_ithl_m_helmet4"); -- Красный шлем
   SetCraftAmount("yfauun_ithl_m_helmet4", 1);
    AddIngre("yfauun_ithl_m_helmet4", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet4", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet4", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet4", 10);
   SetCraftScience("yfauun_ithl_m_helmet4", "Бронник", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet4", 25);
   SetCraftEXP("yfauun_ithl_m_helmet4", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet4", "Бронник")

AddItemCategory ("Бронник (2 уровень)", "yfauun_ithl_m_helmet5"); -- Легкий шлем
   SetCraftAmount("yfauun_ithl_m_helmet5", 1);
    AddIngre("yfauun_ithl_m_helmet5", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet5", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet5", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet5", 10);
   SetCraftScience("yfauun_ithl_m_helmet5", "Бронник", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet5", 25);
   SetCraftEXP("yfauun_ithl_m_helmet5", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet5", "Бронник")

-- БРОННИК 3 УРОВНЯ РАСХОДНИКИ

AddItemCategory ("Бронник (3 уровень)", "ooltyb_itke_lockpick"); --- Отмычка
	SetCraftAmount("ooltyb_itke_lockpick", 1);
	 AddIngre("ooltyb_itke_lockpick", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("ooltyb_itke_lockpick", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itke_lockpick", 5);
	SetCraftScience("ooltyb_itke_lockpick", "Бронник", 3);
	SetenergyPenalty("ooltyb_itke_lockpick", 50);
	SetCraftEXP("ooltyb_itke_lockpick", 50)
	SetCraftEXP_SKILL("ooltyb_itke_lockpick", "Бронник")

AddItemCategory ("Бронник (3 уровень)", "OOLTYB_ITMI_BIJOUTERIE"); ----- Бижутерия
	SetCraftAmount("OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_GoldNugget_Addon", 2);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_SilverNugget", 2);
	 AddTool("OOLTYB_ITMI_BIJOUTERIE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_BIJOUTERIE", 10);
	SetCraftScience("OOLTYB_ITMI_BIJOUTERIE", "Бронник", 3);
	SetenergyPenalty("OOLTYB_ITMI_BIJOUTERIE", 50);
	SetCraftEXP("OOLTYB_ITMI_BIJOUTERIE", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_BIJOUTERIE", "Бронник")
	
-- БРОННИК 3 УРОВНЯ ДОСПЕХИ НА 30 ЗАЩИТЫ
	
AddItemCategory ("Бронник (3 уровень)", "YFAUUN_ItAr_FKNGHT"); --- Броня вольного рыцаря
	SetCraftAmount("YFAUUN_ItAr_FKNGHT", 1);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_FKNGHT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_FKNGHT", 10);
	SetCraftScience("YFAUUN_ItAr_FKNGHT", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ItAr_FKNGHT", 75);
	SetCraftEXP("YFAUUN_ItAr_FKNGHT", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_FKNGHT", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "yfauun_grd_armor_hb"); --- Средняя кольчуга
	SetCraftAmount("yfauun_grd_armor_hb", 1);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_grd_armor_hb", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_grd_armor_hb", 10);
	SetCraftScience("yfauun_grd_armor_hb", "Бронник", 3);
	SetenergyPenalty("yfauun_grd_armor_hb", 75);
	SetCraftEXP("yfauun_grd_armor_hb", 75)
	SetCraftEXP_SKILL("yfauun_grd_armor_hb", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "YFAUUN_ItAr_HRB_H"); --- Средняя кольчуга
	SetCraftAmount("YFAUUN_ItAr_HRB_H", 1);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_HRB_H", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_HRB_H", 10);
	SetCraftScience("YFAUUN_ItAr_HRB_H", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ItAr_HRB_H", 75);
	SetCraftEXP("YFAUUN_ItAr_HRB_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_HRB_H", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "YFAUUN_ITAR_CHAINMAIL2"); --- Кольчуга с наплечником
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL2", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_CHAINMAIL2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL2", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL2", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL2", 75);
	SetCraftEXP("YFAUUN_ITAR_CHAINMAIL2", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_CHAINMAIL2", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "YFAUUN_ITAR_NEWCAMPM_M"); --- Средние доспехи наемника
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_M", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_M", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_M", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_M", "Бронник", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_M", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMPM_M", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMPM_M", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "yfauun_grd_armor_h"); --- Средние доспехи стражника
	SetCraftAmount("yfauun_grd_armor_h", 1);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_grd_armor_h", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_grd_armor_h", 10);
	SetCraftScience("yfauun_grd_armor_h", "Бронник", 3);
	SetenergyPenalty("yfauun_grd_armor_h", 75);
	SetCraftEXP("yfauun_grd_armor_h", 75)
	SetCraftEXP_SKILL("yfauun_grd_armor_h", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "itar_arx_w1"); --- Средние доспехи наемника Араксос
	SetCraftAmount("itar_arx_w1", 1);
	 AddIngre("itar_arx_w1", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_arx_w1", "ooltyb_itmi_m_wire", 3);
	 AddIngre("itar_arx_w1", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_arx_w1", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_w1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_arx_w1", 10);
	SetCraftScience("itar_arx_w1", "Бронник", 3);
	SetenergyPenalty("itar_arx_w1", 75);
	SetCraftEXP("itar_arx_w1", 75)
	SetCraftEXP_SKILL("itar_arx_w1", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "ITAR_BES_DOSP3"); --- Средние доспехи воина Бессмертных
	SetCraftAmount("ITAR_BES_DOSP3", 1);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmiswordraw", 4);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("ITAR_BES_DOSP3", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ITAR_BES_DOSP3", 10);
	SetCraftScience("ITAR_BES_DOSP3", "Бронник", 3);
	SetenergyPenalty("ITAR_BES_DOSP3", 75);
	SetCraftEXP("ITAR_BES_DOSP3", 75)
	SetCraftEXP_SKILL("ITAR_BES_DOSP3", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "itar_mil_a_l2"); --- Сержантские доспехи стражника-арбалетчика
	SetCraftAmount("itar_mil_a_l2", 1);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_mil_a_l2", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l2", 10);
	SetCraftScience("itar_mil_a_l2", "Бронник", 3);
	SetenergyPenalty("itar_mil_a_l2", 75);
	SetCraftEXP("itar_mil_a_l2", 75)
	SetCraftEXP_SKILL("itar_mil_a_l2", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "itar_mil_a_l7"); --- Сержантские доспехи стражника-мечника
	SetCraftAmount("itar_mil_a_l7", 1);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_mil_a_l7", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l7", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l7", 10);
	SetCraftScience("itar_mil_a_l7", "Бронник", 3);
	SetenergyPenalty("itar_mil_a_l7", 75);
	SetCraftEXP("Yitar_mil_a_l7", 75)
	SetCraftEXP_SKILL("itar_mil_a_l7", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "yfauun_itar_circlewh"); --- Средние доспехи Круга Воды
	SetCraftAmount("yfauun_itar_circlewh", 1);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_circlewh", "ooltyb_itmi_recipe1");
	 AddTool("yfauun_itar_circlewh", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_circlewh", 10);
	SetCraftScience("yfauun_itar_circlewh", "Бронник", 3);
	SetenergyPenalty("yfauun_itar_circlewh", 75);
	SetCraftEXP("Yyfauun_itar_circlewh", 75)
	SetCraftEXP_SKILL("yfauun_itar_circlewh", "Бронник")
	
AddItemCategory ("Бронник (3 уровень)", "itar_pal_zact3"); --- Средние доспехи Ордена Заката
	SetCraftAmount("itar_pal_zact3", 1);
	 AddIngre("itar_pal_zact3", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_pal_zact3", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_pal_zact3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_pal_zact3", "ooltyb_itmi_recipe2");
	 AddTool("itar_pal_zact3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_pal_zact3", 10);
	SetCraftScience("itar_pal_zact3", "Бронник", 3);
	SetenergyPenalty("itar_pal_zact3", 75);
	SetCraftEXP("Yitar_pal_zact3", 75)
	SetCraftEXP_SKILL("itar_pal_zact3", "Бронник")
	
-- БРОННИК 4 УРОВНЯ ДОСПЕХИ НА 40 ЗАЩИТЫ

AddItemCategory ("Бронник (4 уровень)", "yfauun_itar_neutral16"); --- Укрепленные латные доспехи
	SetCraftAmount("yfauun_itar_neutral16", 1);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_neutral16", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_neutral16", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_neutral16", 10);
	SetCraftScience("yfauun_itar_neutral16", "Бронник", 4);
	SetenergyPenalty("yfauun_itar_neutral16", 100);

AddItemCategory ("Бронник (4 уровень)", "yfauun_itar_champion"); --- Броня чемпиона
	SetCraftAmount("yfauun_itar_champion", 1);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_champion", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_champion", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_champion", 10);
	SetCraftScience("yfauun_itar_champion", "Бронник", 4);
	SetenergyPenalty("yfauun_itar_champion", 100);
	
AddItemCategory ("Бронник (4 уровень)", "yfauun_itar_frontier9"); --- Отличные бригатные доспехи
	SetCraftAmount("yfauun_itar_frontier9", 1);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_frontier9", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_frontier9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_frontier9", 10);
	SetCraftScience("yfauun_itar_frontier9", "Бронник", 4);
	SetenergyPenalty("yfauun_itar_frontier9", 100);
	
AddItemCategory ("Бронник (4 уровень)", "yfauun_itar_dospcoman"); --- Броня командира
	SetCraftAmount("yfauun_itar_dospcoman", 1);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_dospcoman", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_dospcoman", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_dospcoman", 10);
	SetCraftScience("yfauun_itar_dospcoman", "Бронник", 4);
	SetenergyPenalty("yfauun_itar_dospcoman", 100);	

AddItemCategory ("Бронник (4 уровень)", "itar_arx_w2"); --- Тяжелые доспехи наемника Араксос
	SetCraftAmount("itar_arx_w2", 1);
	 AddIngre("itar_arx_w2", "ooltyb_itmiswordraw", 15);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_m_wire", 6);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("itar_arx_w2", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("itar_arx_w2", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_w2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_arx_w2", 10);
	SetCraftScience("itar_arx_w2", "Бронник", 4);
	SetenergyPenalty("itar_arx_w2", 100);
	
AddItemCategory ("Бронник (4 уровень)", "yfauun_itar_pal_m"); --- Доспехи рыцаря-паладина
	SetCraftAmount("yfauun_itar_pal_m", 1);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_pal_m", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_pal_m", "ooltyb_itmi_recipe2");
	 AddTool("yfauun_itar_pal_m", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_pal_m", 10);
	SetCraftScience("yfauun_itar_pal_m", "Бронник", 4);
	SetenergyPenalty("yfauun_itar_pal_m", 100);
	
AddItemCategory ("Бронник (4 уровень)", "jar_itar_popochka4_1"); --- Тяжелые доспехи конкистадора
	SetCraftAmount("jar_itar_popochka4_1", 1);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmiswordraw", 15);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_m_wire", 6);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("jar_itar_popochka4_1", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jar_itar_popochka4_1", "OOLTYB_ITMI_JAR1");
	 AddTool("jar_itar_popochka4_1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jar_itar_popochka4_1", 10);
	SetCraftScience("jar_itar_popochka4_1", "Бронник", 4);
	SetenergyPenalty("jar_itar_popochka4_1", 100);
	
AddItemCategory ("Бронник (4 уровень)", "itar_mil_a_l8n"); --- Офицерские доспехи стражника
	SetCraftAmount("itar_mil_a_l8n", 1);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmiswordraw", 15);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_m_wire", 6);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("itar_mil_a_l8n", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("itar_mil_a_l8n", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l8n", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l8n", 10);
	SetCraftScience("itar_mil_a_l8n", "Бронник", 4);
	SetenergyPenalty("itar_mil_a_l8n", 100);

-- ПОРТНОЙ 1 Домашняя утварь

AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_BED_BAD"); --- Плохая кровать
	SetCraftAmount("RC_HOUSE_BED_BAD", 1);
	 AddIngre("RC_HOUSE_BED_BAD", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_BED_BAD", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_BED_BAD", 5);
	SetCraftScience("RC_HOUSE_BED_BAD", "Портной", 1);
	SetenergyPenalty("RC_HOUSE_BED_BAD", 25);
	SetCraftEXP("RC_HOUSE_BED_BAD", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BED_BAD", "Портной")
	
AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_BED_POOR"); --- Бедная кровать
	SetCraftAmount("RC_HOUSE_BED_POOR", 1);
	 AddIngre("RC_HOUSE_BED_POOR", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("RC_HOUSE_BED_POOR", "OOLTYB_ITMI_SHEEP", 5);
	 AddTool("RC_HOUSE_BED_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_BED_POOR", 5);
	SetCraftScience("RC_HOUSE_BED_POOR", "Портной", 1);
	SetenergyPenalty("RC_HOUSE_BED_POOR", 25);
	SetCraftEXP("RC_HOUSE_BED_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BED_POOR", "Портной")

AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_CARPET_8"); --- Обычный ковер 1
    SetCraftAmount("RC_HOUSE_CARPET_8", 1);
     AddIngre("RC_HOUSE_CARPET_8", "OOLTYB_ITMI_SHEEP", 30);
    SetCraftPenalty("RC_HOUSE_CARPET_8", 10);
    SetCraftScience("RC_HOUSE_CARPET_8", "Портной", 1);
    SetenergyPenalty("RC_HOUSE_CARPET_8", 25);
    SetCraftEXP("RC_HOUSE_CARPET_8", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CARPET_8", "Портной")
	
AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_CARPET_9"); --- Обычный ковер 2
    SetCraftAmount("RC_HOUSE_CARPET_9", 1);
     AddIngre("RC_HOUSE_CARPET_9", "OOLTYB_ITMI_SHEEP", 30);
    SetCraftPenalty("RC_HOUSE_CARPET_9", 10);
    SetCraftScience("RC_HOUSE_CARPET_9", "Портной", 1);
    SetenergyPenalty("RC_HOUSE_CARPET_9", 25);
    SetCraftEXP("RC_HOUSE_CARPET_9", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CARPET_9", "Портной")
	
AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_CANVAS_WHITE"); --- Белая тряпка (на стену)
    SetCraftAmount("RC_HOUSE_CANVAS_WHITE", 1);
     AddIngre("RC_HOUSE_CANVAS_WHITE", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_HOUSE_CANVAS_WHITE", 10);
    SetCraftScience("RC_HOUSE_CANVAS_WHITE", "Портной", 1);
    SetenergyPenalty("RC_HOUSE_CANVAS_WHITE", 25);
    SetCraftEXP("RC_HOUSE_CANVAS_WHITE", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CANVAS_WHITE", "Портной")
	
AddItemCategory ("Портной (Домашняя утварь)", "RC_HOUSE_WARE_33"); --- Запечатанный тюк
    SetCraftAmount("RC_HOUSE_WARE_33", 1);
     AddIngre("RC_HOUSE_WARE_33", "ooltyb_itmi_fiber", 1);
	 AddIngre("RC_HOUSE_WARE_33", "ooltyb_itmi_wood", 10);
    SetCraftPenalty("RC_HOUSE_WARE_33", 10);
    SetCraftScience("RC_HOUSE_WARE_33", "Портной", 1);
    SetenergyPenalty("RC_HOUSE_WARE_33", 25);
    SetCraftEXP("RC_HOUSE_WARE_33", 25)
    SetCraftEXP_SKILL("RC_HOUSE_WARE_33", "Портной")

-- ПОРТНОЙ 1 УРОВЕНЬ КАСТОМИЗАЦИЯ

AddItemCategory ("Портной (1 уровень)", "RC_BLUE_MASK"); --- синяя маска
    SetCraftAmount("RC_BLUE_MASK", 1);
     AddIngre("RC_BLUE_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_BLUE_MASK", 10);
    SetCraftScience("RC_BLUE_MASK", "Портной", 1);
    SetenergyPenalty("RC_BLUE_MASK", 25);
    SetCraftEXP("RC_BLUE_MASK", 25)
    SetCraftEXP_SKILL("RC_BLUE_MASK", "Портной")

AddItemCategory ("Портной (1 уровень)", "RC_DBLUE_MASK"); --- темно-синяя маска
    SetCraftAmount("RC_DBLUE_MASK", 1);
     AddIngre("RC_DBLUE_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_DBLUE_MASK", 10);
    SetCraftScience("RC_DBLUE_MASK", "Портной", 1);
    SetenergyPenalty("RC_DBLUE_MASK", 25);
    SetCraftEXP("RC_DBLUE_MASK", 25)
    SetCraftEXP_SKILL("RC_DBLUE_MASK", "Портной")

AddItemCategory ("Портной (1 уровень)", "RC_GRAY_MASK"); --- серая маска
    SetCraftAmount("RC_GRAY_MASK", 1);
     AddIngre("RC_GRAY_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_GRAY_MASK", 10);
    SetCraftScience("RC_GRAY_MASK", "Портной", 1);
    SetenergyPenalty("RC_GRAY_MASK", 25);
    SetCraftEXP("RC_GRAY_MASK", 25)
    SetCraftEXP_SKILL("RC_GRAY_MASK", "Портной")

AddItemCategory ("Портной (1 уровень)", "RC_DGREEN_MASK"); --- зеленая маска
    SetCraftAmount("RC_DGREEN_MASK", 1);
     AddIngre("RC_DGREEN_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_DGREEN_MASK", 10);
    SetCraftScience("RC_DGREEN_MASK", "Портной", 1);
    SetenergyPenalty("RC_DGREEN_MASK", 25);
    SetCraftEXP("RC_DGREEN_MASK", 25)
    SetCraftEXP_SKILL("RC_DGREEN_MASK", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "yfauun_ithl_l_band"); --- Бандана 
    SetCraftAmount("yfauun_ithl_l_band", 1);
     AddIngre("yfauun_ithl_l_band", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("yfauun_ithl_l_band", 10);
    SetCraftScience("yfauun_ithl_l_band", "Портной", 1);
    SetenergyPenalty("yfauun_ithl_l_band", 25);
    SetCraftEXP("yfauun_ithl_l_band", 25)
    SetCraftEXP_SKILL("yfauun_ithl_l_band", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "ooltyb_itmi_palatka"); --- Палатка
	SetCraftAmount("ooltyb_itmi_palatka", 1);
	 AddIngre("ooltyb_itmi_palatka", "ooltyb_itmi_fiber", 2);
	 AddTool("ooltyb_itmi_palatka", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_palatka", 5);
	SetCraftScience("ooltyb_itmi_palatka", "Портной", 1);
	SetenergyPenalty("ooltyb_itmi_palatka", 25);
	SetCraftEXP("ooltyb_itmi_palatka", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_palatka", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "yfauun_itar_torba"); --- Сумка
	SetCraftAmount("yfauun_itar_torba", 1);
	 AddIngre("yfauun_itar_torba", "ooltyb_itmi_sheep", 10);
	 AddTool("yfauun_itar_torba", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_torba", 5);
	SetCraftScience("yfauun_itar_torba", "Портной", 1);
	SetenergyPenalty("yfauun_itar_torba", 15);
	SetCraftEXP("yfauun_itar_torba", 15)
	SetCraftEXP_SKILL("yfauun_itar_torba", "Портной")

-- ПОРТНОЙ 1 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Портной (1 уровень)", "ooltyb_itmi_fiber"); --- Нить
	SetCraftAmount("ooltyb_itmi_fiber", 1);
	 AddIngre("ooltyb_itmi_fiber", "OOLTYB_ITMI_SHEEP", 10);
	 AddAlterIngre("ooltyb_itmi_fiber", "zdpwla_itpl_swampherb", 10);
	 AddTool("ooltyb_itmi_fiber", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_fiber", 5);
	SetCraftScience("ooltyb_itmi_fiber", "Портной", 1);
	SetenergyPenalty("ooltyb_itmi_fiber", 25);
	SetCraftEXP("ooltyb_itmi_fiber", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_fiber", "Портной")
	
	
-- -- ПОРТНОЙ 1 УРОВЕНЬ ДОСПЕХИ НА 10 ЗАЩИТЫ

AddItemCategory ("Портной (1 уровень)", "yfauun_itar_underarmor"); --- Поддоспешник
	SetCraftAmount("yfauun_itar_underarmor", 1);
	 AddIngre("yfauun_itar_underarmor", "ooltyb_itmi_fiber", 3);
	 AddTool("yfauun_itar_underarmor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_underarmor", 10);
	SetCraftScience("yfauun_itar_underarmor", "Портной", 1);
	SetenergyPenalty("yfauun_itar_underarmor", 25);
	SetCraftEXP("yfauun_itar_underarmor", 25)
	SetCraftEXP_SKILL("yfauun_itar_underarmor", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Smith"); --- Одежда кузнеца
	SetCraftAmount("YFAUUN_ITAR_Smith", 1);
	 AddIngre("YFAUUN_ITAR_Smith", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Smith", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Smith", 10);
	SetCraftScience("YFAUUN_ITAR_Smith", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Smith", 25);
	SetCraftEXP("YFAUUN_ITAR_Smith", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Smith", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Barkeeper"); --- Одежда трактирщика
	SetCraftAmount("YFAUUN_ITAR_Barkeeper", 1);
	 AddIngre("YFAUUN_ITAR_Barkeeper", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Barkeeper", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Barkeeper", 10);
	SetCraftScience("YFAUUN_ITAR_Barkeeper", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Barkeeper", 25);
	SetCraftEXP("YFAUUN_ITAR_Barkeeper", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Barkeeper", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Bau_L"); --- Простая фермерская одежда
	SetCraftAmount("YFAUUN_ITAR_Bau_L", 1);
	 AddIngre("YFAUUN_ITAR_Bau_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Bau_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Bau_L", 10);
	SetCraftScience("YFAUUN_ITAR_Bau_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Bau_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Bau_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Bau_L", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_M"); --- Добротная крестьянская одежда
	SetCraftAmount("YFAUUN_ITAR_BAU_M", 1);
	 AddIngre("YFAUUN_ITAR_BAU_M", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_M", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_M", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_M", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_M", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_A"); --- Зеленая одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_A", 1);
	 AddIngre("YFAUUN_ITAR_BAU_A", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_A", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_A", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_A", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_A", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_A", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_C"); --- Оранжевая одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_C", 1);
	 AddIngre("YFAUUN_ITAR_BAU_C", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_C", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_C", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_C", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_C", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_C", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BAU_B"); --- Коричневая одежда фермера
	SetCraftAmount("YFAUUN_ITAR_BAU_B", 1);
	 AddIngre("YFAUUN_ITAR_BAU_B", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_B", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_B", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_B", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_B", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_B", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_B", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Prisoner"); --- Штаны рудокопа
	SetCraftAmount("YFAUUN_ITAR_Prisoner", 1);
	 AddIngre("YFAUUN_ITAR_Prisoner", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Prisoner", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Prisoner", 10);
	SetCraftScience("YFAUUN_ITAR_Prisoner", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Prisoner", 25);
	SetCraftEXP("YFAUUN_ITAR_Prisoner", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Prisoner", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_STANI"); --- Штаны моряка
	SetCraftAmount("YFAUUN_ITAR_STANI", 1);
	 AddIngre("YFAUUN_ITAR_STANI", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_STANI", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_STANI", 10);
	SetCraftScience("YFAUUN_ITAR_STANI", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_STANI", 25);
	SetCraftEXP("YFAUUN_ITAR_STANI", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_STANI", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_SAILOR"); --- Зеленая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_SAILOR1"); --- Голубая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR1", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR1", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR1", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR1", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR1", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR1", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR1", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_SAILOR2"); --- Коричневая одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR2", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR2", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR2", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR2", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR2", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR2", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR2", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_SAILOR3"); --- Черная одежда рабочего
	SetCraftAmount("YFAUUN_ITAR_SAILOR3", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR3", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR3", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR3", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR3", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR3", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR3", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Vlk_L"); --- Коричневый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_L", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Vlk_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_L", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Vlk_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_L", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_Vlk_H"); --- Бежевый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_H", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_H", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Vlk_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_H", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_H", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_H", 25);
	SetCraftEXP("YFAUUN_ITAR_Vlk_H", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_H", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VLK_Y"); --- Черный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Y", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VLK_Q"); --- Желтый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Q", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Q", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Q", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Q", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Q", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Q", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Q", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Q", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VLK_W"); --- Серый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_W", 1);
	 AddIngre("YFAUUN_ITAR_VLK_W", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_W", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_W", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_W", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_W", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_W", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_W", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VLK_Y1"); --- Красный дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Y1", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y1", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Y1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y1", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y1", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y1", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y1", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y1", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VLK_P"); --- Коричневый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_P", 1);
	 AddIngre("YFAUUN_ITAR_VLK_P", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_P", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_P", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_P", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_P", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_P", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_P", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BauBabe_L"); --- Бежевое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BauBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_L", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_L", 25);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_L", "Портной")

AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_BauBabe_M"); --- Зеленое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_M", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BauBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_M", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_M", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_M", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_M", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "YFAUUN_ITAR_VlkBabe_L"); --- Голубое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VlkBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_L", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_L", "Портной", 1);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_L", 25);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_L", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "jar_itar_popochka1"); --- Одежда конкистадора
	SetCraftAmount("jar_itar_popochka1", 1);
	 AddIngre("jar_itar_popochka1", "ooltyb_itmi_fiber", 3);
	 AddTool("jar_itar_popochka1", "OOLTYB_ITMI_JAR1");
	 AddTool("jar_itar_popochka1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("jar_itar_popochka1", 10);
	SetCraftScience("jar_itar_popochka1", "Портной", 1);
	SetenergyPenalty("jar_itar_popochka1", 25);
	SetCraftEXP("jar_itar_popochka1", 25)
	SetCraftEXP_SKILL("jar_itar_popochka1", "Портной")

AddItemCategory ("Портной (1 уровень)", "itar_km_rm_hat_02"); --- Повседневная одежда Араксос
	SetCraftAmount("itar_km_rm_hat_02", 1);
	 AddIngre("itar_km_rm_hat_02", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_km_rm_hat_02", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_km_rm_hat_02", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_km_rm_hat_02", 20);
	SetCraftScience("itar_km_rm_hat_02", "Портной", 1);
	SetenergyPenalty("itar_km_rm_hat_02", 25);
	SetCraftEXP("itar_km_rm_hat_02", 25)
	SetCraftEXP_SKILL("itar_km_rm_hat_02", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "itar_syn_rab"); --- Рабочая одежда Синдиката
	SetCraftAmount("itar_syn_rab", 1);
	 AddIngre("itar_syn_rab", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_syn_rab", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_rab", 20);
	SetCraftScience("itar_syn_rab", "Портной", 1);
	SetenergyPenalty("itar_syn_rab", 25);
	SetCraftEXP("itar_syn_rab", 25)
	SetCraftEXP_SKILL("itar_syn_rab", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "ITAR_SYN_DB1"); --- Дублет Синдиката 1
	SetCraftAmount("ITAR_SYN_DB1", 1);
	 AddIngre("ITAR_SYN_DB1", "ooltyb_itmi_fiber", 3);
	 AddTool("ITAR_SYN_DB1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_SYN_DB1", 20);
	SetCraftScience("ITAR_SYN_DB1", "Портной", 1);
	SetenergyPenalty("ITAR_SYN_DB1", 25);
	SetCraftEXP("ITAR_SYN_DB1", 25)
	SetCraftEXP_SKILL("ITAR_SYN_DB1", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "ITAR_SYN_DB2"); --- Дублет Синдиката 2
	SetCraftAmount("ITAR_SYN_DB2", 1);
	 AddIngre("ITAR_SYN_DB2", "ooltyb_itmi_fiber", 3);
	 AddTool("ITAR_SYN_DB2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_SYN_DB2", 20);
	SetCraftScience("ITAR_SYN_DB2", "Портной", 1);
	SetenergyPenalty("ITAR_SYN_DB2", 25);
	SetCraftEXP("ITAR_SYN_DB2", 25)
	SetCraftEXP_SKILL("ITAR_SYN_DB2", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "itar_mil_a_l4"); --- Рекрутское одеяние стражника
	SetCraftAmount("itar_mil_a_l4", 1);
	 AddIngre("itar_mil_a_l4", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_mil_a_l4", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l4", 20);
	SetCraftScience("itar_mil_a_l4", "Портной", 1);
	SetenergyPenalty("itar_mil_a_l4", 25);
	SetCraftEXP("itar_mil_a_l4", 25)
	SetCraftEXP_SKILL("itar_mil_a_l4", "Портной")
	
AddItemCategory ("Портной (1 уровень)", "itar_mil_a_l6"); --- Рекрутское одеяние стражника-медика
	SetCraftAmount("itar_mil_a_l6", 1);
	 AddIngre("itar_mil_a_l6", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_mil_a_l6", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l6", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l6", 20);
	SetCraftScience("itar_mil_a_l6", "Портной", 1);
	SetenergyPenalty("itar_mil_a_l6", 25);
	SetCraftEXP("itar_mil_a_l6", 25)
	SetCraftEXP_SKILL("itar_mil_a_l6", "Портной")

-- ПОРТНОЙ 2 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Портной (2 уровень)", "ooltyb_itmi_whool_holst"); --- Сукно
	SetCraftAmount("ooltyb_itmi_whool_holst", 1);
	 AddIngre("ooltyb_itmi_whool_holst", "ooltyb_itmi_fiber", 2);
	 AddTool("ooltyb_itmi_whool_holst", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_whool_holst", 5);
	SetCraftScience("ooltyb_itmi_whool_holst", "Портной", 2);
	SetenergyPenalty("ooltyb_itmi_whool_holst", 50);
	SetCraftEXP("ooltyb_itmi_whool_holst", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_whool_holst", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "ooltyb_itmi_linen_holst"); --- Льняная ткань
	SetCraftAmount("ooltyb_itmi_linen_holst", 1);
	 AddIngre("ooltyb_itmi_linen_holst", "ooltyb_itmi_fiber", 1);
	 AddTool("ooltyb_itmi_linen_holst", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_linen_holst", 5);
	SetCraftScience("ooltyb_itmi_linen_holst", "Портной", 2);
	SetenergyPenalty("ooltyb_itmi_linen_holst", 50);
	SetCraftEXP("ooltyb_itmi_linen_holst", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_linen_holst", "Портной")

-- ПОРТНОЙ 2 УРОВЕНЬ ДОСПЕХИ НА 20 ЗАЩИТЫ

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_NEUTRAL22"); --- Бригантина
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL22", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL22", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL22", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL22", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL22", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL22", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL22", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VAV"); --- Одеяние алхимика
	SetCraftAmount("YFAUUN_ITAR_VAV", 1);
	 AddIngre("YFAUUN_ITAR_VAV", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VAV", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VAV", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VAV", 10);
	SetCraftScience("YFAUUN_ITAR_VAV", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VAV", 50);
	SetCraftEXP("YFAUUN_ITAR_VAV", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VAV", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_DARKROBE"); --- Плащ из плотной ткани
	SetCraftAmount("YFAUUN_ITAR_DARKROBE", 1);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_DARKROBE", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_DARKROBE", 10);
	SetCraftScience("YFAUUN_ITAR_DARKROBE", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_DARKROBE", 50);
	SetCraftEXP("YFAUUN_ITAR_DARKROBE", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_DARKROBE", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_Khr01"); --- Короткий стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_Khr01", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_Vlk_Khr01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_Khr01", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_Khr01", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_Khr01", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_Khr01", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_Khr01", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_D"); --- Синий стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_D", 1);
	 AddIngre("YFAUUN_ITAR_VLK_D", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_D", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_D", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_D", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_D", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_D", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_D", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_D", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_Vlk_M"); --- Розовый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_Vlk_M", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_Vlk_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_M", 20);
	SetCraftScience("YFAUUN_ITAR_Vlk_M", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_M", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_M", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_J"); --- Стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_J", 1);
	 AddIngre("YFAUUN_ITAR_VLK_J", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_J", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_J", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_J", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_J", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_J", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_J", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_J", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_Z"); --- Бежевый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_Z", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_Z", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Z", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_Z", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Z", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_Z", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Z", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_A"); --- Серый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_A", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_A", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_A", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VLK_C"); --- Темно-зеленый стеганый дублет
	SetCraftAmount("YFAUUN_ITAR_VLK_C", 1);
	 AddIngre("YFAUUN_ITAR_VLK_C", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_C", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_C", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_C", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_C", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_C", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_C", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VlkBabe_M"); --- Дорогое белое платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VlkBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_M", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_M", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_M", 50);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_M", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_VlkBabe_H"); --- Дорогое черное платье
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_H", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VlkBabe_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_H", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_H", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_H", 50);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_H", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_H", "Портной")

AddItemCategory ("Портной (2 уровень)", "YFAUUN_ITAR_BauBabe_N"); --- Дорогое сиреневое платье
	SetCraftAmount("YFAUUN_ITAR_BauBabe_N", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_N", 20);
	SetCraftScience("YFAUUN_ITAR_BauBabe_N", "Портной", 2);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_N", 50);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_N", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_N", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "itar_f_armor15"); --- Темно-красная одежда (ж)
	SetCraftAmount("itar_f_armor15", 1);
	 AddIngre("itar_f_armor15", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor15", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor15", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor15", 20);
	SetCraftScience("itar_f_armor15", "Портной", 2);
	SetenergyPenalty("itar_f_armor15", 50);
	SetCraftEXP("itar_f_armor15", 50)
	SetCraftEXP_SKILL("itar_f_armor15", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "itar_f_armor16"); --- Темно-коричневая одежда (ж)
	SetCraftAmount("itar_f_armor16", 1);
	 AddIngre("itar_f_armor16", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor16", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor16", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor16", 20);
	SetCraftScience("itar_f_armor16", "Портной", 2);
	SetenergyPenalty("itar_f_armor16", 50);
	SetCraftEXP("itar_f_armor16", 50)
	SetCraftEXP_SKILL("itar_f_armor16", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "itar_f_armor17"); --- Темная женская одежда
	SetCraftAmount("itar_f_armor17", 1);
	 AddIngre("itar_f_armor17", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor17", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor17", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor17", 20);
	SetCraftScience("itar_f_armor17", "Портной", 2);
	SetenergyPenalty("itar_f_armor17", 50);
	SetCraftEXP("itar_f_armor17", 50)
	SetCraftEXP_SKILL("itar_f_armor17", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "itar_syn_plash"); --- Плащ Синдиката
	SetCraftAmount("itar_syn_plash", 1);
	 AddIngre("itar_syn_plash", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_syn_plash", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_syn_plash", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_plash", 20);
	SetCraftScience("itar_syn_plash", "Портной", 2);
	SetenergyPenalty("itar_syn_plash", 50);
	SetCraftEXP("itar_syn_plash", 50)
	SetCraftEXP_SKILL("itar_syn_plash", "Портной")
	
AddItemCategory ("Портной (2 уровень)", "jar_itar_popochka2"); --- Легкие доспехи конкистадора
	SetCraftAmount("jar_itar_popochka2", 1);
	 AddIngre("jar_itar_popochka2", "ooltyb_itmi_fiber", 4);
	 AddIngre("jar_itar_popochka2", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("jar_itar_popochka2", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("jar_itar_popochka2", "OOLTYB_ITMI_JAR1");
	SetCraftPenalty("jar_itar_popochka2", 20);
	SetCraftScience("jar_itar_popochka2", "Портной", 2);
	SetenergyPenalty("jar_itar_popochka2", 50);
	SetCraftEXP("jar_itar_popochka2", 50)
	SetCraftEXP_SKILL("jar_itar_popochka2", "Портной")


-- -- ПОРТНОЙ 3 УРОВЕНЬ ДОСПЕХИ НА 30 ЗАЩИТЫ

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_F"); --- Дворянский белый плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_F", 1);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_VLK_F", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_F", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_F", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_VLK_F", 75);
	SetCraftEXP("YFAUUN_ITAR_VLK_F", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_F", "Портной")
	
AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_VLK_N"); --- Дворянский черный плащ
	SetCraftAmount("YFAUUN_ITAR_VLK_N", 1);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_VLK_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_N", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_N", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_VLK_N", 75);
	SetCraftEXP("YFAUUN_ITAR_VLK_N", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_N", "Портной")
	
AddItemCategory ("Портной (3 уровень)", "yfauun_itar_vlk_e"); --- Дворянский бежевый плащ
	SetCraftAmount("yfauun_itar_vlk_e", 1);
	 AddIngre("yfauun_itar_vlk_e", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("yfauun_itar_vlk_e", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("yfauun_itar_vlk_e", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("yfauun_itar_vlk_e", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_vlk_e", 10);
	SetCraftScience("yfauun_itar_vlk_e", "Портной", 3);
	SetenergyPenalty("yfauun_itar_vlk_e", 75);
	SetCraftEXP("yfauun_itar_vlk_e", 75)
	SetCraftEXP_SKILL("yfauun_itar_vlk_e", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Judge"); ---  Мантия судьи
	SetCraftAmount("YFAUUN_ITAR_Judge", 1);
	 AddIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_Judge", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_Judge", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Judge", 10);
	SetCraftScience("YFAUUN_ITAR_Judge", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_Judge", 75);
	SetCraftEXP("YFAUUN_ITAR_Judge", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Judge", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_NEWPLAT_05"); --- Дворянское красное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_05", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_05", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_05", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_05", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_05", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_05", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_05", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_NEWPLAT_04"); --- Дворянское черное платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_04", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_04", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_04", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_04", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_04", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_04", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_04", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_NEWPLAT_03"); --- Дворянское зеленое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_03", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_03", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_03", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_03", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_03", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_03", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_03", "Портной")


AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_NEWPLAT_02"); --- Дворянское бордовое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_02", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_02", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_02", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_02", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_02", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_02", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_02", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_NEWPLAT_01"); --- Дворянское голубое платье
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_01", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_01", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_01", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_01", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_01", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_01", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_BURG4"); --- Хорошая одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_BURG4", 1);
	 AddIngre("YFAUUN_ITAR_BURG4", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_BURG4", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_BURG4", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_BURG4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BURG4", 10);
	SetCraftScience("YFAUUN_ITAR_BURG4", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_BURG4", 75);
	SetCraftEXP("YFAUUN_ITAR_BURG4", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BURG4", "Портной")

AddItemCategory ("Портной (3 уровень)", "YFAUUN_ITAR_Governor"); --- Богатая красная одежда горожанина
	SetCraftAmount("YFAUUN_ITAR_Governor", 1);
	 AddIngre("YFAUUN_ITAR_Governor", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_Governor", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_Governor", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_Governor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Governor", 10);
	SetCraftScience("YFAUUN_ITAR_Governor", "Портной", 3);
	SetenergyPenalty("YFAUUN_ITAR_Governor", 75);
	SetCraftEXP("YFAUUN_ITAR_Governor", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Governor", "Портной")

-- робы магов

AddItemCategory ("Робы магов", "yfauun_itar_kdw_s"); --- Роба послушника круга воды
	SetCraftAmount("yfauun_itar_kdw_s", 1);
	 AddIngre("yfauun_itar_kdw_s", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_kdw_s", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("yfauun_itar_kdw_s", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_s", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_s", 5);
	SetCraftScience("yfauun_itar_kdw_s", "Портной", 1);
	SetenergyPenalty("yfauun_itar_kdw_s", 25);
	SetCraftEXP("yfauun_itar_kdw_s", 25)
	SetCraftEXP_SKILL("yfauun_itar_kdw_s", "Портной")
	
AddItemCategory ("Робы магов", "yfauun_itar_nov_l"); --- Роба послушника круга огня
	SetCraftAmount("yfauun_itar_nov_l", 1);
	 AddIngre("yfauun_itar_nov_l", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_nov_l", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("yfauun_itar_nov_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_nov_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_nov_l", 5);
	SetCraftScience("yfauun_itar_nov_l", "Портной", 1);
	SetenergyPenalty("yfauun_itar_nov_l", 25);
	SetCraftEXP("yfauun_itar_nov_l", 25)
	SetCraftEXP_SKILL("yfauun_itar_nov_l", "Портной")
	
AddItemCategory ("Робы магов", "ITAR_BES_DOSP4"); --- Роба послушника Бессмертных
	SetCraftAmount("ITAR_BES_DOSP4", 1);
	 AddIngre("ITAR_BES_DOSP4", "ooltyb_itmi_fiber", 3);
	 AddIngre("ITAR_BES_DOSP4", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("ITAR_BES_DOSP4", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP4", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP4", 5);
	SetCraftScience("ITAR_BES_DOSP4", "Портной", 1);
	SetenergyPenalty("ITAR_BES_DOSP4", 25);
	SetCraftEXP("ITAR_BES_DOSP4", 25)
	SetCraftEXP_SKILL("ITAR_BES_DOSP4", "Портной")

AddItemCategory ("Робы магов", "YFAUUN_KDF_ARMOR_L"); --- Мантия ученика круга огня
	SetCraftAmount("YFAUUN_KDF_ARMOR_L", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "ooltyb_itmi_fiber", 3);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "zdpwla_itmi_dye", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "zdpwla_itmi_beltlm", 1);
	 AddTool("YFAUUN_KDF_ARMOR_L", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("YFAUUN_KDF_ARMOR_L", "ooltyb_itmi_recipe2");
	SetCraftPenalty("YFAUUN_KDF_ARMOR_L", 5);
	SetCraftScience("YFAUUN_KDF_ARMOR_L", "Портной", 2);
	SetenergyPenalty("YFAUUN_KDF_ARMOR_L", 50);
	SetCraftEXP("YFAUUN_KDF_ARMOR_L", 50)
	SetCraftEXP_SKILL("YFAUUN_KDF_ARMOR_L", "Портной")

AddItemCategory ("Робы магов", "yfauun_itar_kdw_l"); --- Мантия ученика мага воды
	SetCraftAmount("yfauun_itar_kdw_l", 1);
	 AddIngre("yfauun_itar_kdw_l", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_kdw_l", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdw_l", "zdpwla_itmi_beltlm", 1);
	 AddTool("yfauun_itar_kdw_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_l", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l", 5);
	SetCraftScience("yfauun_itar_kdw_l", "Портной", 2);
	SetenergyPenalty("yfauun_itar_kdw_l", 50);
	SetCraftEXP("yfauun_itar_kdw_l", 50)
	SetCraftEXP_SKILL("yfauun_itar_kdw_l", "Портной")
	
AddItemCategory ("Робы магов", "ITAR_BES_DOSP5"); --- Мантия ученика Бессмертных
	SetCraftAmount("ITAR_BES_DOSP5", 1);
	 AddIngre("ITAR_BES_DOSP5", "ooltyb_itmi_fiber", 3);
	 AddIngre("ITAR_BES_DOSP5", "zdpwla_itmi_dye", 1);
	 AddIngre("ITAR_BES_DOSP5", "zdpwla_itmi_beltlm", 1);
	 AddTool("ITAR_BES_DOSP5", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP5", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP5", 5);
	SetCraftScience("ITAR_BES_DOSP5", "Портной", 2);
	SetenergyPenalty("ITAR_BES_DOSP5", 50);
	SetCraftEXP("ITAR_BES_DOSP5", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP5", "Портной")
	
AddItemCategory ("Робы магов", "yfauun_itar_kdw_l_addon"); --- Мантия мага воды
	SetCraftAmount("yfauun_itar_kdw_l_addon", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("yfauun_itar_kdw_l_addon", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("yfauun_itar_kdw_l_addon", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_l_addon", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l_addon", 5);
	SetCraftScience("yfauun_itar_kdw_l_addon", "Портной", 3);
	SetenergyPenalty("yfauun_itar_kdw_l_addon", 75);
	
	
AddItemCategory ("Робы магов", "yfauun_itar_kdf_l"); --- Мантия мага огня
	SetCraftAmount("yfauun_itar_kdf_l", 1);
	 AddIngre("yfauun_itar_kdf_l", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("yfauun_itar_kdf_l", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdf_l", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdf_l", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("yfauun_itar_kdf_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdf_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_kdf_l", 5);
	SetCraftScience("yfauun_itar_kdf_l", "Портной", 3);
	SetenergyPenalty("yfauun_itar_kdf_l", 75);
	
AddItemCategory ("Робы магов", "ITAR_BES_DOSP6"); --- Мантия пророка Бессмертных
	SetCraftAmount("ITAR_BES_DOSP6", 1);
	 AddIngre("ITAR_BES_DOSP6", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("ITAR_BES_DOSP6", "zdpwla_itmi_dye", 1);
	 AddIngre("ITAR_BES_DOSP6", "zdpwla_itmi_belthm", 1);
	 AddIngre("ITAR_BES_DOSP6", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("ITAR_BES_DOSP6", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP6", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP6", 5);
	SetCraftScience("ITAR_BES_DOSP6", "Портной", 3);
	SetenergyPenalty("ITAR_BES_DOSP6", 75);
	
AddItemCategory ("Робы магов", "yfauun_itar_kdw_h"); --- Мантия магистра воды
	SetCraftAmount("yfauun_itar_kdw_h", 1);
	 AddIngre("yfauun_itar_kdw_h", "ooltyb_itmi_linen_holst", 10);
	 AddIngre("yfauun_itar_kdw_h", "zdpwla_itmi_dye", 3);
	 AddIngre("yfauun_itar_kdw_h", "zdpwla_itmi_beltum", 1);
	 AddIngre("yfauun_itar_kdw_h", "OOLTYB_ITMI_BIJOUTERIE", 2);
	 AddIngre("yfauun_itar_kdw_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kdw_h", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_h", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_h", 5);
	SetCraftScience("yfauun_itar_kdw_h", "Портной", 4);
	SetenergyPenalty("yfauun_itar_kdw_h", 100);
	
AddItemCategory ("Робы магов", "yfauun_itar_kdf_h"); --- Мантия магистра огня
	SetCraftAmount("yfauun_itar_kdf_h", 1);
	 AddIngre("yfauun_itar_kdf_h", "ooltyb_itmi_linen_holst", 10);
	 AddIngre("yfauun_itar_kdf_h", "zdpwla_itmi_dye", 3);
	 AddIngre("yfauun_itar_kdf_h", "zdpwla_itmi_beltum", 1);
	 AddIngre("yfauun_itar_kdf_h", "OOLTYB_ITMI_BIJOUTERIE", 2);
	 AddIngre("yfauun_itar_kdf_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kdf_h", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdf_h", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_kdf_h", 5);
	SetCraftScience("yfauun_itar_kdf_h", "Портной", 4);
	SetenergyPenalty("yfauun_itar_kdf_h", 100);
	
	
-- СВИТКИ 1 КРУГ

AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Firebolt"); ----- Свиток огненная стрела
	SetCraftAmount("IHPIWN_ItSc_Firebolt", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_paper", 2);
	AddTool("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_kft1");
    AddTool("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_kscf");
	SetCraftPenalty("IHPIWN_ItSc_Firebolt", 5);
	SetCraftScience("IHPIWN_ItSc_Firebolt", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Firebolt", 25);
	
AddItemCategory ("(С) 1-й Круг", "ihpiwn_itsc_icebolt"); ----- Свиток ледяная стрела
	SetCraftAmount("ihpiwn_itsc_icebolt", 1);
	 AddIngre("ihpiwn_itsc_icebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_icebolt", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_icebolt", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_icebolt", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icebolt", 5);
	SetCraftScience("ihpiwn_itsc_icebolt", "Магия", 1);
	SetenergyPenalty("ihpiwn_itsc_icebolt", 25);

AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Zap"); ----- Свиток малая молния
	SetCraftAmount("IHPIWN_ItSc_Zap", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Zap", "ooltyb_itmi_kft1");
	AddTool("IHPIWN_ItSc_Zap", "ooltyb_itmi_kscs");
	SetCraftPenalty("IHPIWN_ItSc_Zap", 5);
	SetCraftScience("IHPIWN_ItSc_Zap", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Zap", 25);
	
AddItemCategory ("(С) 1-й Круг", "ihpiwn_itsc_palholybolt"); ----- Свиток святая стрела
	SetCraftAmount("ihpiwn_itsc_palholybolt", 1);
	 AddIngre("ihpiwn_itsc_palholybolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_palholybolt", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_palholybolt", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_palholybolt", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palholybolt", 5);
	SetCraftScience("ihpiwn_itsc_palholybolt", "Магия", 1);
	SetenergyPenalty("ihpiwn_itsc_palholybolt", 25);
	
AddItemCategory ("(С) 1-й Круг", "ihpiwn_itsc_pallight"); ----- Свиток святой свет
	SetCraftAmount("ihpiwn_itsc_pallight", 1);
	 AddIngre("ihpiwn_itsc_pallight", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_pallight", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_pallight", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_pallight", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_pallight", 5);
	SetCraftScience("ihpiwn_itsc_pallight", "Магия", 1);
	SetenergyPenalty("ihpiwn_itsc_pallight", 25);
	
AddItemCategory ("(С) 1-й Круг", "ihpiwn_itsc_pallightheal"); ----- Cвиток малое исцеление
	SetCraftAmount("ihpiwn_itsc_pallightheal", 1);
	 AddIngre("ihpiwn_itsc_pallightheal", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_pallightheal", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_pallightheal", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_pallightheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_pallightheal", 5);
	SetCraftScience("ihpiwn_itsc_pallightheal", "Магия", 1);
	SetenergyPenalty("ihpiwn_itsc_pallightheal", 25);

AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_Light"); ----- Свиток свет
	SetCraftAmount("IHPIWN_ItSc_Light", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Light", "ooltyb_itmi_kft1");
	SetCraftPenalty("IHPIWN_ItSc_Light", 5);
	SetCraftScience("IHPIWN_ItSc_Light", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_Light", 25);
	
AddItemCategory ("(С) 1-й Круг", "IHPIWN_ItSc_LightHeal"); ----- Свиток легкое лечение
	SetCraftAmount("IHPIWN_ItSc_LightHeal", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_kft1");
	SetCraftPenalty("IHPIWN_ItSc_LightHeal", 5);
	SetCraftScience("IHPIWN_ItSc_LightHeal", "Магия", 1);
	SetenergyPenalty("IHPIWN_ItSc_LightHeal", 25);
	
AddItemCategory ("(С) 1-й Круг", "ihpiwn_itsc_lightfocheal"); ----- Свиток легкое лечение таргет
	SetCraftAmount("ihpiwn_itsc_lightfocheal", 1);
	 AddIngre("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("ihpiwn_itsc_lightfocheal", 5);
	SetCraftScience("ihpiwn_itsc_lightfocheal", "Магия", 1);
	SetenergyPenalty("ihpiwn_itsc_lightfocheal", 25);
	
------- СВИТКИ 2 КРУГ

AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_instantfireball"); ----- Свиток огненный шар
	SetCraftAmount("ihpiwn_itsc_instantfireball", 1);
	 AddIngre("ihpiwn_itsc_instantfireball", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_instantfireball", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_instantfireball", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_instantfireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_instantfireball", 5);
	SetCraftScience("ihpiwn_itsc_instantfireball", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_instantfireball", 25);
	
AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_waterfist"); ----- Свиток кулак воды
	SetCraftAmount("ihpiwn_itsc_waterfist", 1);
	 AddIngre("ihpiwn_itsc_waterfist", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_waterfist", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_waterfist", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_waterfist", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_waterfist", 5);
	SetCraftScience("ihpiwn_itsc_waterfist", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_waterfist", 25);
	
AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_lightningflash"); ----- Свиток молния
	SetCraftAmount("ihpiwn_itsc_lightningflash", 1);
	 AddIngre("ihpiwn_itsc_lightningflash", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_lightningflash", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_lightningflash", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_lightningflash", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_lightningflash", 5);
	SetCraftScience("ihpiwn_itsc_lightningflash", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_lightningflash", 25);
	
AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_palmediumheal"); ----- Свиток среднее исцеление
	SetCraftAmount("ihpiwn_itsc_palmediumheal", 1);
	 AddIngre("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palmediumheal", 5);
	SetCraftScience("ihpiwn_itsc_palmediumheal", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_palmediumheal", 25);
	
AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_palrepelevil"); ----- Свиток изгнание зла
	SetCraftAmount("ihpiwn_itsc_palrepelevil", 1);
	 AddIngre("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palrepelevil", 5);
	SetCraftScience("ihpiwn_itsc_palrepelevil", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_palrepelevil", 25);
	
AddItemCategory ("(С) 2-й Круг", "ihpiwn_itsc_sleep"); ----- Свиток сон
	SetCraftAmount("ihpiwn_itsc_sleep", 1);
	 AddIngre("ihpiwn_itsc_sleep", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_sleep", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_sleep", "ooltyb_itmi_kft2");
	SetCraftPenalty("ihpiwn_itsc_sleep", 5);
	SetCraftScience("ihpiwn_itsc_sleep", "Магия", 2);
	SetenergyPenalty("ihpiwn_itsc_sleep", 25);
	
	------- СВИТКИ 3 КРУГ
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_chargefireball"); ----- Свиток большой огненный шар
	SetCraftAmount("ihpiwn_itsc_chargefireball", 1);
	 AddIngre("ihpiwn_itsc_chargefireball", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_chargefireball", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_chargefireball", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_chargefireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_chargefireball", 5);
	SetCraftScience("ihpiwn_itsc_chargefireball", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_chargefireball", 50);

AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_icecube"); ----- Свиток ледяной блок
	SetCraftAmount("ihpiwn_itsc_icecube", 1);
	 AddIngre("ihpiwn_itsc_icecube", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_icecube", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_icecube", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_icecube", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icecube", 5);
	SetCraftScience("ihpiwn_itsc_icecube", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_icecube", 50);
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_breathofdeath"); ----- Свиток дыхание смерти
	SetCraftAmount("ihpiwn_itsc_breathofdeath", 1);
	 AddIngre("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_breathofdeath", 5);
	SetCraftScience("ihpiwn_itsc_breathofdeath", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_breathofdeath", 50);
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_fear"); ----- Свиток страх
	SetCraftAmount("ihpiwn_itsc_fear", 1);
	 AddIngre("ihpiwn_itsc_fear", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_fear", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_fear", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_fear", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_fear", 5);
	SetCraftScience("ihpiwn_itsc_fear", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_fear", 50);

AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_palfullheal"); ----- Свиток полное исцеление
	SetCraftAmount("ihpiwn_itsc_palfullheal", 1);
	 AddIngre("ihpiwn_itsc_palfullheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_palfullheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_palfullheal", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_palfullheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palfullheal", 5);
	SetCraftScience("ihpiwn_itsc_palfullheal", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_palfullheal", 50);
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_paldestroyevil"); ----- Свиток уничтожение зла
	SetCraftAmount("ihpiwn_itsc_paldestroyevil", 1);
	 AddIngre("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_paldestroyevil", 5);
	SetCraftScience("ihpiwn_itsc_paldestroyevil", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_paldestroyevil", 50);

AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_harmundead"); ----- Свиток уничтожение нежити
	SetCraftAmount("ihpiwn_itsc_harmundead", 1);
	 AddIngre("ihpiwn_itsc_harmundead", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_harmundead", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_harmundead", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_harmundead", 5);
	SetCraftScience("ihpiwn_itsc_harmundead", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_harmundead", 50);
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_mediumheal"); ----- Свиток среднее лечение
	SetCraftAmount("ihpiwn_itsc_mediumheal", 1);
	 AddIngre("ihpiwn_itsc_mediumheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_mediumheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_mediumheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_mediumheal", 5);
	SetCraftScience("ihpiwn_itsc_mediumheal", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_mediumheal", 50);
	
AddItemCategory ("(С) 3-й Круг", "ihpiwn_itsc_mediumfocheal"); ----- Свиток среднее лечение таргет
	SetCraftAmount("ihpiwn_itsc_mediumfocheal", 1);
	 AddIngre("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_mediumfocheal", 5);
	SetCraftScience("ihpiwn_itsc_mediumfocheal", "Магия", 3);
	SetenergyPenalty("ihpiwn_itsc_mediumfocheal", 50);
	
	------- СВИТКИ 4 КРУГ
	
AddItemCategory ("(С) 4-й Круг", "ihpiwn_itsc_InstantFireStorm"); ----- Свиток малая огненная буря
	SetCraftAmount("ihpiwn_itsc_InstantFireStorm", 1);
	 AddIngre("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_kft4");
    AddTool("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_InstantFireStorm", 5);
	SetCraftScience("ihpiwn_itsc_InstantFireStorm", "Магия", 4);
	SetenergyPenalty("ihpiwn_itsc_InstantFireStorm", 75);
	
AddItemCategory ("(С) 4-й Круг", "ihpiwn_itsc_icelance"); ----- Свиток ледяное копье
	SetCraftAmount("ihpiwn_itsc_icelance", 1);
	 AddIngre("ihpiwn_itsc_icelance", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_icelance", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_icelance", "ooltyb_itmi_kft4");
    AddTool("ihpiwn_itsc_icelance", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icelance", 5);
	SetCraftScience("ihpiwn_itsc_icelance", "Магия", 4);
	SetenergyPenalty("ihpiwn_itsc_icelance", 75);
	
AddItemCategory ("(С) 4-й Круг", "ihpiwn_itsc_thunderball"); ----- Свиток шаровая молния
	SetCraftAmount("ihpiwn_itsc_thunderball", 1);
	 AddIngre("ihpiwn_itsc_thunderball", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_thunderball", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_thunderball", "ooltyb_itmi_kft4");
	AddTool("ihpiwn_itsc_thunderball", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_thunderball", 5);
	SetCraftScience("ihpiwn_itsc_thunderball", "Магия", 4);
	SetenergyPenalty("ihpiwn_itsc_thunderball", 75);
	
	------- СВИТКИ 5 КРУГ

AddItemCategory ("(С) 5-й Круг", "ihpiwn_itsc_pyrokinesis"); ----- Свиток большая огненная буря
	SetCraftAmount("ihpiwn_itsc_pyrokinesis", 1);
	 AddIngre("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_pyrokinesis", 5);
	SetCraftScience("ihpiwn_itsc_pyrokinesis", "Магия", 5);
	SetenergyPenalty("ihpiwn_itsc_pyrokinesis", 100);	

AddItemCategory ("(С) 5-й Круг", "ihpiwn_itsc_geyser"); ----- Свиток гейзер
	SetCraftAmount("ihpiwn_itsc_geyser", 1);
	 AddIngre("ihpiwn_itsc_geyser", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_geyser", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_geyser", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_geyser", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_geyser", 5);
	SetCraftScience("ihpiwn_itsc_geyser", "Магия", 5);
	SetenergyPenalty("ihpiwn_itsc_geyser", 100);
	
AddItemCategory ("(С) 5-й Круг", "ihpiwn_itsc_beliarsrage"); ----- Свиток гнев белиара
	SetCraftAmount("ihpiwn_itsc_beliarsrage", 1);
	 AddIngre("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_beliarsrage", 5);
	SetCraftScience("ihpiwn_itsc_beliarsrage", "Магия", 5);
	SetenergyPenalty("ihpiwn_itsc_beliarsrage", 100);
	
AddItemCategory ("(С) 5-й Круг", "ihpiwn_itsc_fullheal"); ----- Свиток полное лечение
	SetCraftAmount("ihpiwn_itsc_fullheal", 1);
	 AddIngre("ihpiwn_itsc_fullheal", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_fullheal", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_fullheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("ihpiwn_itsc_fullheal", 5);
	SetCraftScience("ihpiwn_itsc_fullheal", "Магия", 5);
	SetenergyPenalty("ihpiwn_itsc_fullheal", 100);

AddItemCategory ("(С) 5-й Круг", "ihpiwn_itsc_fullfocheal"); ----- Свиток полное лечение таргет
	SetCraftAmount("ihpiwn_itsc_fullfocheal", 1);
	 AddIngre("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("ihpiwn_itsc_fullfocheal", 5);
	SetCraftScience("ihpiwn_itsc_fullfocheal", "Магия", 5);
	SetenergyPenalty("ihpiwn_itsc_fullfocheal", 100);

	------- СВИТКИ 6 КРУГ
	
AddItemCategory ("(С) 6-й Круг", "ihpiwn_itsc_firerain"); ----- Свиток огненный дождь
	SetCraftAmount("ihpiwn_itsc_firerain", 1);
	 AddIngre("ihpiwn_itsc_firerain", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_firerain", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_firerain", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_firerain", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_firerain", 5);
	SetCraftScience("ihpiwn_itsc_firerain", "Магия", 6);
	SetenergyPenalty("ihpiwn_itsc_firerain", 100);
	
AddItemCategory ("(С) 6-й Круг", "ihpiwn_itsc_icewave"); ----- Свиток ледяная волна
	SetCraftAmount("ihpiwn_itsc_icewave", 1);
	 AddIngre("ihpiwn_itsc_icewave", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_icewave", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_icewave", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_icewave", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icewave", 5);
	SetCraftScience("ihpiwn_itsc_icewave", "Магия", 6);
	SetenergyPenalty("ihpiwn_itsc_icewave", 100);
	
AddItemCategory ("(С) 6-й Круг", "ihpiwn_itsc_massdeath"); ----- Свиток волна смерти
	SetCraftAmount("ihpiwn_itsc_massdeath", 1);
	 AddIngre("ihpiwn_itsc_massdeath", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_massdeath", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_massdeath", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_massdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_massdeath", 5);
	SetCraftScience("ihpiwn_itsc_massdeath", "Магия", 6);
	SetenergyPenalty("ihpiwn_itsc_massdeath", 100);

----- РУНЫ 1 КРУГ
	
AddItemCategory ("(Р) 1-й Круг", "book_garrypotter1"); ----- Первый круг магии
	SetCraftAmount("book_garrypotter1", 1);
	 AddIngre("book_garrypotter1", "zdpwla_itmi_dye", 1);
	 AddIngre("book_garrypotter1", "ooltyb_itmi_paper", 10);
	 AddIngre("book_garrypotter1", "ooltyb_itmi_magicore", 5);
	AddTool("book_garrypotter1", "ooltyb_itmi_kft1");
	SetCraftPenalty("book_garrypotter1", 5);
	SetCraftScience("book_garrypotter1", "Магия", 1);
	SetenergyPenalty("book_garrypotter1", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_firebolt"); ----- Руна огненная стрела
	SetCraftAmount("saqtsh_itru_firebolt", 1);
	 AddIngre("saqtsh_itru_firebolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_firebolt", "ooltyb_itmi_rubin", 1);
	 AddIngre("saqtsh_itru_firebolt", "ihpiwn_itsc_firebolt", 1);
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_firebolt", 5);
	SetCraftScience("saqtsh_itru_firebolt", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_firebolt", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_icebolt"); ----- Руна ледяная стрела
	SetCraftAmount("saqtsh_itru_icebolt", 1);
	 AddIngre("saqtsh_itru_icebolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_icebolt", "ooltyb_itmi_aquamarine", 1);
	 AddIngre("saqtsh_itru_icebolt", "ihpiwn_itsc_icebolt", 1);
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icebolt", 5);
	SetCraftScience("saqtsh_itru_icebolt", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_icebolt", 25);

AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_zap"); ----- Руна малая молния
	SetCraftAmount("saqtsh_itru_zap", 1);
	 AddIngre("saqtsh_itru_zap", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_zap", "ooltyb_itmi_sulfur", 1);
	 AddIngre("saqtsh_itru_zap", "ihpiwn_itsc_zap", 1);
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_zap", 5);
	SetCraftScience("saqtsh_itru_zap", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_zap", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_palholybolt"); ----- Руна святая стрела
	SetCraftAmount("saqtsh_itru_palholybolt", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ihpiwn_itsc_palholybolt", 1);
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palholybolt", 5);
	SetCraftScience("saqtsh_itru_palholybolt", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_palholybolt", 25);

AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_pallight"); ----- Руна святой свет
	SetCraftAmount("saqtsh_itru_pallight", 1);
	 AddIngre("saqtsh_itru_pallight", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_pallight", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_pallight", "ihpiwn_itsc_pallight", 1);
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_pallight", 5);
	SetCraftScience("saqtsh_itru_pallight", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_pallight", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_pallightheal"); ----- Руна малое исцеление
	SetCraftAmount("saqtsh_itru_pallightheal", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ihpiwn_itsc_pallightheal", 1);
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_pallightheal", 5);
	SetCraftScience("saqtsh_itru_pallightheal", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_pallightheal", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_light"); ----- Руна свет
	SetCraftAmount("saqtsh_itru_light", 1);
	 AddIngre("saqtsh_itru_light", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_light", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_light", "ihpiwn_itsc_light", 1);
    AddTool("saqtsh_itru_light", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_light", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_light", 5);
	SetCraftScience("saqtsh_itru_light", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_light", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_lightheal"); ----- Руна легкое лечение
	SetCraftAmount("saqtsh_itru_lightheal", 1);
	 AddIngre("saqtsh_itru_lightheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_lightheal", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_lightheal", "ihpiwn_itsc_lightheal", 1);
    AddTool("saqtsh_itru_lightheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_lightheal", 5);
	SetCraftScience("saqtsh_itru_lightheal", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_lightheal", 25);
	
AddItemCategory ("(Р) 1-й Круг", "saqtsh_itru_lightfocheal"); ----- Руна легкое лечение таргет
	SetCraftAmount("saqtsh_itru_lightfocheal", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ihpiwn_itsc_lightfocheal", 1);
    AddTool("saqtsh_itru_lightfocheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightfocheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_lightfocheal", 5);
	SetCraftScience("saqtsh_itru_lightfocheal", "Магия", 1);
	SetenergyPenalty("saqtsh_itru_lightfocheal", 25);
	
----- РУНЫ 2 КРУГ

AddItemCategory ("(Р) 2-й Круг", "book_garrypotter2"); ----- Второй круг магии
	SetCraftAmount("book_garrypotter2", 1);
	 AddIngre("book_garrypotter2", "zdpwla_itmi_dye", 2);
	 AddIngre("book_garrypotter2", "ooltyb_itmi_paper", 20);
	 AddIngre("book_garrypotter2", "ooltyb_itmi_magicore", 10);
	AddTool("book_garrypotter2", "ooltyb_itmi_kft2");
	SetCraftPenalty("book_garrypotter2", 5);
	SetCraftScience("book_garrypotter2", "Магия", 2);
	SetenergyPenalty("book_garrypotter2", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_instantfireball"); ----- Руна огненный шар
	SetCraftAmount("saqtsh_itru_instantfireball", 1);
	 AddIngre("saqtsh_itru_instantfireball", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_instantfireball", "ooltyb_itmi_rubin", 2);
	 AddIngre("saqtsh_itru_instantfireball", "ihpiwn_itsc_instantfireball", 1);
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_instantfireball", 5);
	SetCraftScience("saqtsh_itru_instantfireball", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_instantfireball", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_waterfist"); ----- Руна кулак воды
	SetCraftAmount("saqtsh_itru_waterfist", 1);
	 AddIngre("saqtsh_itru_waterfist", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_waterfist", "ooltyb_itmi_aquamarine", 2);
	 AddIngre("saqtsh_itru_waterfist", "ihpiwn_itsc_waterfist", 1);
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_waterfist", 5);
	SetCraftScience("saqtsh_itru_waterfist", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_waterfist", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_lightningflash"); ----- Руна молния
	SetCraftAmount("saqtsh_itru_lightningflash", 1);
	 AddIngre("saqtsh_itru_lightningflash", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_lightningflash", "ooltyb_itmi_sulfur", 2);
	 AddIngre("saqtsh_itru_lightningflash", "ihpiwn_itsc_lightningflash", 1);
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_lightningflash", 5);
	SetCraftScience("saqtsh_itru_lightningflash", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_lightningflash", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_palmediumheal"); ----- Руна среднее исцеление
	SetCraftAmount("saqtsh_itru_palmediumheal", 1);
	 AddIngre("saqtsh_itru_palmediumheal", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_palmediumheal", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("saqtsh_itru_palmediumheal", "ihpiwn_itsc_palmediumheal", 1);
    AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_kft2");
    AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palmediumheal", 5);
	SetCraftScience("saqtsh_itru_palmediumheal", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_palmediumheal", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_palrepelevil"); ----- Руна изгнание зла
	SetCraftAmount("saqtsh_itru_palrepelevil", 1);
	 AddIngre("saqtsh_itru_palrepelevil", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_palrepelevil", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("saqtsh_itru_palrepelevil", "ihpiwn_itsc_palrepelevil", 1);
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_kft2");
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palrepelevil", 5);
	SetCraftScience("saqtsh_itru_palrepelevil", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_palrepelevil", 25);
	
AddItemCategory ("(Р) 2-й Круг", "saqtsh_itru_sleep"); ----- Руна сон
	SetCraftAmount("saqtsh_itru_sleep", 1);
	 AddIngre("saqtsh_itru_sleep", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_sleep", "ooltyb_itmi_quartz", 2);
	 AddIngre("saqtsh_itru_sleep", "ihpiwn_itsc_sleep", 1);
    AddTool("saqtsh_itru_sleep", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_sleep", "ooltyb_itmi_kft2");
	SetCraftPenalty("saqtsh_itru_sleep", 5);
	SetCraftScience("saqtsh_itru_sleep", "Магия", 2);
	SetenergyPenalty("saqtsh_itru_sleep", 25);
	
----- РУНЫ 3 КРУГ


AddItemCategory ("(Р) 3-й Круг", "book_garrypotter3"); ----- Третий круг магии
	SetCraftAmount("book_garrypotter3", 1);
	 AddIngre("book_garrypotter3", "zdpwla_itmi_dye", 3);
	 AddIngre("book_garrypotter3", "ooltyb_itmi_paper", 30);
	 AddIngre("book_garrypotter3", "ooltyb_itmi_magicore", 15);
	AddTool("book_garrypotter3", "ooltyb_itmi_kft3");
	SetCraftPenalty("book_garrypotter3", 5);
	SetCraftScience("book_garrypotter3", "Магия", 3);
	SetenergyPenalty("book_garrypotter3", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_chargefireball"); ----- Руна большой огненный шар
	SetCraftAmount("saqtsh_itru_chargefireball", 1);
	 AddIngre("saqtsh_itru_chargefireball", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_chargefireball", "ooltyb_itmi_rubin", 3);
	 AddIngre("saqtsh_itru_chargefireball", "ihpiwn_itsc_chargefireball", 1);
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_pliers");	
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_chargefireball", 15);
	SetCraftScience("saqtsh_itru_chargefireball", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_chargefireball", 50);

AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_icecube"); ----- Руна ледяной блок
	SetCraftAmount("saqtsh_itru_icecube", 1);
	 AddIngre("saqtsh_itru_icecube", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_icecube", "OOLTYB_ItMi_AquamarinE", 3);
	 AddIngre("saqtsh_itru_icecube", "ihpiwn_itsc_icecube", 1);
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icecube", 15);
	SetCraftScience("saqtsh_itru_icecube", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_icecube", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_breathofdeath"); ----- Руна дыхание смерти
	SetCraftAmount("saqtsh_itru_breathofdeath", 1);
	 AddIngre("saqtsh_itru_breathofdeath", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_breathofdeath", "ooltyb_itmi_sulfur", 3);
	 AddIngre("saqtsh_itru_breathofdeath", "ihpiwn_itsc_breathofdeath", 1);
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_kft3");
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_breathofdeath", 5);
	SetCraftScience("saqtsh_itru_breathofdeath", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_breathofdeath", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_fear"); ----- Руна страх
	SetCraftAmount("saqtsh_itru_fear", 1);
	 AddIngre("saqtsh_itru_fear", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_fear", "ooltyb_itmi_sulfur", 3);
	 AddIngre("saqtsh_itru_fear", "ihpiwn_itsc_fear", 1);
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_fear", 5);
	SetCraftScience("saqtsh_itru_fear", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_fear", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_palfullheal"); ----- Руна полное исцеление
	SetCraftAmount("saqtsh_itru_palfullheal", 1);
	 AddIngre("saqtsh_itru_palfullheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_palfullheal", "ooltyb_itmi_rockcrystal", 3);
	 AddIngre("saqtsh_itru_palfullheal", "ihpiwn_itsc_palfullheal", 1);
	AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palfullheal", 5);
	SetCraftScience("saqtsh_itru_palfullheal", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_palfullheal", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_paldestroyevil"); ----- Руна уничтожение зла
	SetCraftAmount("saqtsh_itru_paldestroyevil", 1);
	 AddIngre("saqtsh_itru_paldestroyevil", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_paldestroyevil", "ooltyb_itmi_rockcrystal", 3);
	 AddIngre("saqtsh_itru_paldestroyevil", "ihpiwn_itsc_paldestroyevil", 1);
	AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_paldestroyevil", 5);
	SetCraftScience("saqtsh_itru_paldestroyevil", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_paldestroyevil", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_harmundead"); ----- Руна уничтожение нежити
	SetCraftAmount("saqtsh_itru_harmundead", 1);
	 AddIngre("saqtsh_itru_harmundead", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_harmundead", "OOLTYB_ItMi_Quartz", 3);
	 AddIngre("saqtsh_itru_harmundead", "ihpiwn_itsc_harmundead", 1);
	AddTool("saqtsh_itru_harmundead", "ooltyb_itmi_pliers");	
	AddTool("saqtsh_itru_harmundead", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_harmundead", 15);
	SetCraftScience("saqtsh_itru_harmundead", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_harmundead", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_mediumheal"); ----- Руна среднее лечение
	SetCraftAmount("saqtsh_itru_mediumheal", 1);
	 AddIngre("saqtsh_itru_mediumheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_mediumheal", "ooltyb_itmi_quartz", 3);
	 AddIngre("saqtsh_itru_mediumheal", "ihpiwn_itsc_mediumheal", 1);
	AddTool("saqtsh_itru_mediumheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_mediumheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_mediumheal", 15);
	SetCraftScience("saqtsh_itru_mediumheal", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_mediumheal", 50);
	
AddItemCategory ("(Р) 3-й Круг", "saqtsh_itru_mediumfocheal"); ----- Руна среднее лечение таргет
	SetCraftAmount("saqtsh_itru_mediumfocheal", 1);
	 AddIngre("saqtsh_itru_mediumfocheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_mediumfocheal", "ooltyb_itmi_quartz", 3);
	 AddIngre("saqtsh_itru_mediumfocheal", "ihpiwn_itsc_mediumfocheal", 1);
    AddTool("saqtsh_itru_mediumfocheal", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_mediumfocheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_mediumfocheal", 5);
	SetCraftScience("saqtsh_itru_mediumfocheal", "Магия", 3);
	SetenergyPenalty("saqtsh_itru_mediumfocheal", 50);
	
----- РУНЫ 4 КРУГ
	
AddItemCategory ("(Р) 4-й Круг", "book_garrypotter4"); ----- Четвертый круг магии
	SetCraftAmount("book_garrypotter4", 1);
	 AddIngre("book_garrypotter4", "zdpwla_itmi_dye", 4);
	 AddIngre("book_garrypotter4", "ooltyb_itmi_paper", 40);
	 AddIngre("book_garrypotter4", "ooltyb_itmi_magicore", 20);
	AddTool("book_garrypotter4", "ooltyb_itmi_kft4");
	SetCraftPenalty("book_garrypotter4", 5);
	SetCraftScience("book_garrypotter4", "Магия", 4);
	SetenergyPenalty("book_garrypotter4", 75);
	
AddItemCategory ("(Р) 4-й Круг", "saqtsh_itru_InstantFireStorm"); ----- Руна малая огненная буря
	SetCraftAmount("saqtsh_itru_InstantFireStorm", 1);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_rubin", 4);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ihpiwn_itsc_InstantFireStorm", 1);
	AddTool("saqtsh_itru_InstantFireStorm","ooltyb_itmi_pliers");	
    AddTool("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_InstantFireStorm", 15);
	SetCraftScience("saqtsh_itru_InstantFireStorm", "Магия", 4);
	SetenergyPenalty("saqtsh_itru_InstantFireStorm", 75);
	
AddItemCategory ("(Р) 4-й Круг", "saqtsh_itru_icelance"); ----- Руна ледяное копье
	SetCraftAmount("saqtsh_itru_icelance", 1);
	 AddIngre("saqtsh_itru_icelance", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_icelance", "OOLTYB_ItMi_AquamarinE", 4);
	 AddIngre("saqtsh_itru_icelance", "ihpiwn_itsc_icelance", 1);
    AddTool("saqtsh_itru_icelance", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_icelance", "ooltyb_itmi_kscw");
	AddTool("saqtsh_itru_icelance","ooltyb_itmi_pliers");	
	SetCraftPenalty("saqtsh_itru_icelance", 15);
	SetCraftScience("saqtsh_itru_icelance", "Магия", 4);
	SetenergyPenalty("saqtsh_itru_icelance", 75);
	
AddItemCategory ("(Р) 4-й Круг", "saqtsh_itru_thunderball"); ----- Руна шаровая молния
	SetCraftAmount("saqtsh_itru_thunderball", 1);
	 AddIngre("saqtsh_itru_thunderball", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_thunderball", "ooltyb_itmi_sulfur", 4);
	 AddIngre("saqtsh_itru_thunderball", "ihpiwn_itsc_thunderball", 1);
    AddTool("saqtsh_itru_thunderball", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_thunderball", "ooltyb_itmi_kscs");
	AddTool("saqtsh_itru_thunderball","ooltyb_itmi_pliers");
	SetCraftPenalty("saqtsh_itru_thunderball", 15);
	SetCraftScience("saqtsh_itru_thunderball", "Магия", 4);
	SetenergyPenalty("saqtsh_itru_thunderball", 75);

----- РУНЫ 5 КРУГ

AddItemCategory ("(Р) 5-й Круг", "book_garrypotter5"); ----- Пятый круг магии
	SetCraftAmount("book_garrypotter5", 1);
	 AddIngre("book_garrypotter5", "zdpwla_itmi_dye", 5);
	 AddIngre("book_garrypotter5", "ooltyb_itmi_paper", 50);
	 AddIngre("book_garrypotter5", "ooltyb_itmi_magicore", 25);
	AddTool("book_garrypotter5", "ooltyb_itmi_kft5");
	SetCraftPenalty("book_garrypotter5", 5);
	SetCraftScience("book_garrypotter5", "Магия", 5);
	SetenergyPenalty("book_garrypotter5", 100);

AddItemCategory ("(Р) 5-й Круг", "saqtsh_itru_pyrokinesis"); ----- Руна большая огненная буря
	SetCraftAmount("saqtsh_itru_pyrokinesis", 1);
	 AddIngre("saqtsh_itru_pyrokinesis", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_pyrokinesis", "ooltyb_itmi_rubin", 5);
	 AddIngre("saqtsh_itru_pyrokinesis", "ihpiwn_itsc_pyrokinesis", 1);
	AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_pyrokinesis", 5);
	SetCraftScience("saqtsh_itru_pyrokinesis", "Магия", 5);
	SetenergyPenalty("saqtsh_itru_pyrokinesis", 100);

AddItemCategory ("(Р) 5-й Круг", "saqtsh_itru_geyser"); ----- Руна гейзер
	SetCraftAmount("saqtsh_itru_geyser", 1);
	 AddIngre("saqtsh_itru_geyser", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_geyser", "ooltyb_itmi_aquamarine", 5);
	 AddIngre("saqtsh_itru_geyser", "saqtsh_itru_geyser", 1);
	AddTool("saqtsh_itru_geyser", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_geyser", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_geyser", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_geyser", 5);
	SetCraftScience("saqtsh_itru_geyser", "Магия", 5);
	SetenergyPenalty("saqtsh_itru_geyser", 100);
	
AddItemCategory ("(Р) 5-й Круг", "saqtsh_itru_beliarsrage"); ----- Руна гнев белиара
	SetCraftAmount("saqtsh_itru_beliarsrage", 1);
	 AddIngre("saqtsh_itru_beliarsrage", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_beliarsrage", "ooltyb_itmi_sulfur", 5);
	 AddIngre("saqtsh_itru_beliarsrage", "ihpiwn_itsc_beliarsrage", 1);
	AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_beliarsrage", 5);
	SetCraftScience("saqtsh_itru_beliarsrage", "Магия", 5);
	SetenergyPenalty("saqtsh_itru_beliarsrage", 100);
	
AddItemCategory ("(Р) 5-й Круг", "saqtsh_itru_fullheal"); ----- Руна полное лечение
	SetCraftAmount("saqtsh_itru_fullheal", 1);
	 AddIngre("saqtsh_itru_fullheal", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_fullheal", "ooltyb_itmi_quartz", 5);
	 AddIngre("saqtsh_itru_fullheal", "ihpiwn_itsc_fullheal", 1);
	AddTool("saqtsh_itru_fullheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fullheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("saqtsh_itru_fullheal", 5);
	SetCraftScience("saqtsh_itru_fullheal", "Магия", 5);
	SetenergyPenalty("saqtsh_itru_fullheal", 100);

AddItemCategory ("(Р) 5-й Круг", "saqtsh_itru_fullfocheal"); ----- Руна полное лечение таргет
	SetCraftAmount("saqtsh_itru_fullfocheal", 1);
	 AddIngre("saqtsh_itru_fullfocheal", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_fullfocheal", "ooltyb_itmi_quartz", 5);
	 AddIngre("saqtsh_itru_fullfocheal", "ihpiwn_itsc_fullfocheal", 1);
	AddTool("saqtsh_itru_fullfocheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fullfocheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("saqtsh_itru_fullfocheal", 5);
	SetCraftScience("saqtsh_itru_fullfocheal", "Магия", 5);
	SetenergyPenalty("saqtsh_itru_fullfocheal", 100);
	
----- РУНЫ 6 КРУГ

AddItemCategory ("(Р) 6-й Круг", "saqtsh_itru_firerain"); ----- Руна огненный дождь
	SetCraftAmount("saqtsh_itru_firerain", 1);
	 AddIngre("saqtsh_itru_firerain", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_firerain", "ooltyb_itmi_rubin", 6);
	 AddIngre("saqtsh_itru_firerain", "ihpiwn_itsc_firerain", 1);
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_firerain", 5);
	SetCraftScience("saqtsh_itru_firerain", "Магия", 6);
	SetenergyPenalty("saqtsh_itru_firerain", 100);
	
AddItemCategory ("(Р) 6-й Круг", "saqtsh_itru_icewave"); ----- Руна ледяная волна
	SetCraftAmount("saqtsh_itru_icewave", 1);
	 AddIngre("saqtsh_itru_icewave", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_icewave", "ooltyb_itmi_aquamarine", 6);
	 AddIngre("saqtsh_itru_icewave", "ihpiwn_itsc_icewave", 1);
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icewave", 5);
	SetCraftScience("saqtsh_itru_icewave", "Магия", 6);
	SetenergyPenalty("saqtsh_itru_icewave", 100);
	
AddItemCategory ("(Р) 6-й Круг", "saqtsh_itru_massdeath"); ----- Руна волна смерти
	SetCraftAmount("saqtsh_itru_massdeath", 1);
	 AddIngre("saqtsh_itru_massdeath", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_massdeath", "ooltyb_itmi_rubin", 6);
	 AddIngre("saqtsh_itru_massdeath", "ihpiwn_itsc_massdeath", 1);
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_massdeath", 5);
	SetCraftScience("saqtsh_itru_massdeath", "Магия", 6);
	SetenergyPenalty("saqtsh_itru_massdeath", 100);	

---- Зачарователь 1 Домашняя утварь

AddItemCategory ("Зачарователь (Домашняя утварь)", "RC_HOUSE_BOOKS_1"); ----- Стопка книг (1)
	SetCraftAmount("RC_HOUSE_BOOKS_1", 1);
	 AddIngre("RC_HOUSE_BOOKS_1", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_1", "ooltyb_itmi_paper", 10);
	SetCraftPenalty("RC_HOUSE_BOOKS_1", 25);
	SetCraftScience("RC_HOUSE_BOOKS_1", "Зачарователь", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_1", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_1", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_1", "Зачарователь")
	
AddItemCategory ("Зачарователь (Домашняя утварь)", "RC_HOUSE_BOOKS_7"); ----- Пустой свиток
	SetCraftAmount("RC_HOUSE_BOOKS_7", 1);
	 AddIngre("RC_HOUSE_BOOKS_7", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_7", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_7", 25);
	SetCraftScience("RC_HOUSE_BOOKS_7", "Зачарователь", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_7", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_7", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_7", "Зачарователь")
	
AddItemCategory ("Зачарователь (Домашняя утварь)", "RC_HOUSE_BOOKS_3"); ----- Маленькая карта Хориниса
	SetCraftAmount("RC_HOUSE_BOOKS_3", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftScience("RC_HOUSE_BOOKS_3", "Зачарователь", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_3", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_3", "Зачарователь")

AddItemCategory ("Зачарователь (Домашняя утварь)", "RC_HOUSE_BOOKS_3"); ----- Завернутый пергамент с печатью
	SetCraftAmount("RC_HOUSE_BOOKS_3", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_magicore", 2);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftScience("RC_HOUSE_BOOKS_3", "Зачарователь", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_3", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_3", "Зачарователь")

AddItemCategory ("Зачарователь (Домашняя утварь)", "rc_house_bookshelf_6"); ----- Завернутый пергамент с печатью
	SetCraftAmount("rc_house_bookshelf_6", 1);
	 AddIngre("rc_house_bookshelf_6", "ooltyb_itmi_wood", 10);
	 AddIngre("rc_house_bookshelf_6", "ooltyb_itmi_paper", 5);
	SetCraftPenalty("rc_house_bookshelf_6", 25);
	SetCraftScience("rc_house_bookshelf_6", "Зачарователь", 1);
	SetenergyPenalty("rc_house_bookshelf_6", 25);
	SetCraftEXP("rc_house_bookshelf_6", 25)
	SetCraftEXP_SKILL("rc_house_bookshelf_6", "Зачарователь")

----- ЗАЧАРОВАТЕЛЬ 1 УРОВЕНЬ КНИГИ

AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_kft1"); ----- Книга формул том 1
	SetCraftAmount("ooltyb_itmi_kft1", 1);
	 AddIngre("ooltyb_itmi_kft1", "zdpwla_itmi_dye", 1);
	 AddIngre("ooltyb_itmi_kft1", "ooltyb_itmi_paper", 10);
	 AddIngre("ooltyb_itmi_kft1", "ooltyb_itmi_magicore", 5);
    AddTool("ooltyb_itmi_kft1", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft1", "ooltyb_itmi_kft1");
	SetCraftPenalty("ooltyb_itmi_kft1", 25);
	SetCraftScience("ooltyb_itmi_kft1", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_kft1", 25);
	SetCraftEXP("ooltyb_itmi_kft1", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kft1", "Зачарователь")

AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_kft2"); ----- Книга формул том 2
	SetCraftAmount("ooltyb_itmi_kft2", 1);
	 AddIngre("ooltyb_itmi_kft2", "zdpwla_itmi_dye", 2);
	 AddIngre("ooltyb_itmi_kft2", "ooltyb_itmi_paper", 20);
	 AddIngre("ooltyb_itmi_kft2", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_kft2", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft2", "ooltyb_itmi_kft2");
	SetCraftPenalty("ooltyb_itmi_kft2", 25);
	SetCraftScience("ooltyb_itmi_kft2", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_kft2", 25);
	SetCraftEXP("ooltyb_itmi_kft2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kft2", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_kscl"); ----- Книга заклинаний круга света
	SetCraftAmount("ooltyb_itmi_kscl", 1);
	 AddIngre("ooltyb_itmi_kscl", "zdpwla_itmi_dye", 2);
	 AddIngre("ooltyb_itmi_kscl", "ooltyb_itmi_paper", 20);
	 AddIngre("ooltyb_itmi_kscl", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_kscl", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscl", "ooltyb_itmi_kscl");
	SetCraftPenalty("ooltyb_itmi_kscl", 25);
	SetCraftScience("ooltyb_itmi_kscl", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_kscl", 25);
	SetCraftEXP("ooltyb_itmi_kscl", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kscl", "Зачарователь")
	
----- ЗАЧАРОВАТЕЛЬ 1 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_magicore"); ----- Магическая крошка
	SetCraftAmount("ooltyb_itmi_magicore", 5);
	 AddIngre("ooltyb_itmi_magicore", "ooltyb_itmi_addon_whitepearl", 1);
	 AddAlterIngre("ooltyb_itmi_magicore", "ooltyb_itmi_quartz", 1);
    AddTool("ooltyb_itmi_magicore", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_magicore", 25);
	SetCraftScience("ooltyb_itmi_magicore", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_magicore", 25);
	SetCraftEXP("ooltyb_itmi_magicore", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_magicore", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_m_ignot"); ----- Магический слиток
	SetCraftAmount("ooltyb_itmi_m_ignot", 1);
	 AddIngre("ooltyb_itmi_m_ignot", "OOLTYB_ITMI_Iron", 5);
	 AddIngre("ooltyb_itmi_m_ignot", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_m_ignot", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_m_ignot", 25);
	SetCraftScience("ooltyb_itmi_m_ignot", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_m_ignot", 25);
	SetCraftEXP("ooltyb_itmi_m_ignot", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_m_ignot", "Зачарователь")

AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_runeblank"); ----- Заготовка руны 1 круга
	SetCraftAmount("ooltyb_itmi_runeblank", 1);
	 AddIngre("ooltyb_itmi_runeblank", "ooltyb_itmi_magicore", 25);
    AddTool("ooltyb_itmi_runeblank", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_runeblank", 25);
	SetCraftScience("ooltyb_itmi_runeblank", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_runeblank", 25);
	SetCraftEXP("ooltyb_itmi_runeblank", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_runeblank", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_mage2"); ----- Заготовка руны 2 круга
	SetCraftAmount("ooltyb_itmi_mage2", 1);
	 AddIngre("ooltyb_itmi_mage2", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("ooltyb_itmi_mage2", "ooltyb_itmi_runeblank", 1);
    AddTool("ooltyb_itmi_mage2", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage2", 25);
	SetCraftScience("ooltyb_itmi_mage2", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_mage2", 25);
	SetCraftEXP("ooltyb_itmi_mage2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_mage2", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "zdpwla_itmi_beltlm"); ----- Рунный пояс ученика
	SetCraftAmount("zdpwla_itmi_beltlm", 1);
	 AddIngre("zdpwla_itmi_beltlm", "ooltyb_itmi_runeblank", 1);
	 AddIngre("zdpwla_itmi_beltlm", "OOLTYB_ITMI_LEATHER", 1);
	AddTool("zdpwla_itmi_beltlm","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltlm", 5);
	SetCraftScience("zdpwla_itmi_beltlm", "Зачарователь", 1);
	SetenergyPenalty("zdpwla_itmi_beltlm", 25);
	SetCraftEXP("zdpwla_itmi_beltlm", 25)
	SetCraftEXP_SKILL("zdpwla_itmi_beltlm", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "ooltyb_itmi_enchantset"); ----- Набор для зачарования
	SetCraftAmount("ooltyb_itmi_enchantset", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_sulfur", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_addon_whitepearl", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_paper", 5);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_magicore", 25);
	 AddIngre("ooltyb_itmi_enchantset", "zdpwla_itmi_dye", 1);
	AddTool("ooltyb_itmi_enchantset", "ooltyb_itmi_pliers");	
	SetCraftPenalty("ooltyb_itmi_enchantset", 25);
	SetCraftScience("ooltyb_itmi_enchantset", "Зачарователь", 1);
	SetenergyPenalty("ooltyb_itmi_enchantset", 25);
	SetCraftEXP("ooltyb_itmi_enchantset", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_enchantset", "Зачарователь")
	
----- ЗАЧАРОВАТЕЛЬ 1 УРОВЕНЬ БИЖУТЕРИЯ

AddItemCategory ("Зачарователь (1 уровень)", "rmymew_itam_prot_mage_01"); ----- Защитный кулон
	SetCraftAmount("rmymew_itam_prot_mage_01", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_quartz", 2);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itam_prot_mage_01","ooltyb_itmi_enchantset");	
	SetCraftPenalty("rmymew_itam_prot_mage_01", 25);
	SetCraftScience("rmymew_itam_prot_mage_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itam_prot_mage_01", 25);
	SetCraftEXP("rmymew_itam_prot_mage_01", 25)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_01", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "rmymew_itri_dex_01"); ----- Малое кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_01", 1);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_dex_01","ooltyb_itmi_enchantset");	
	SetCraftPenalty("rmymew_itri_dex_01", 25);
	SetCraftScience("rmymew_itri_dex_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_dex_01", 25);
	SetCraftEXP("rmymew_itri_dex_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_dex_01", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "rmymew_itri_hp_01"); ----- Малое кольцо жизни
	SetCraftAmount("rmymew_itri_hp_01", 1);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_rubin", 2);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_hp_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_01", 25);
	SetCraftScience("rmymew_itri_hp_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_hp_01", 25);
	SetCraftEXP("rmymew_itri_hp_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_hp_01", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "rmymew_itri_str_01"); ----- Малое кольцо силы
	SetCraftAmount("rmymew_itri_str_01", 1);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_sulfur", 2);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_str_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_01", 25);
	SetCraftScience("rmymew_itri_str_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_str_01", 25);
	SetCraftEXP("rmymew_itri_str_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_str_01", "Зачарователь")
	
AddItemCategory ("Зачарователь (1 уровень)", "rmymew_itri_mana_01"); ----- Кольцо ученика
	SetCraftAmount("rmymew_itri_mana_01", 1);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_aquamarine", 2);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_mana_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_01", 25);
	SetCraftScience("rmymew_itri_mana_01", "Зачарователь", 1);
	SetenergyPenalty("rmymew_itri_mana_01", 25);
	SetCraftEXP("rmymew_itri_mana_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_mana_01", "Зачарователь")

----- ЗАЧАРОВАТЕЛЬ 2 УРОВЕНЬ КНИГИ

AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_kft3"); ----- Книга формул том 3
	SetCraftAmount("ooltyb_itmi_kft3", 1);
	 AddIngre("ooltyb_itmi_kft3", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kft3", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kft3", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kft3", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft3", "ooltyb_itmi_kft3");
	SetCraftPenalty("ooltyb_itmi_kft3", 15);
	SetCraftScience("ooltyb_itmi_kft3", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kft3", 50);
	SetCraftEXP("ooltyb_itmi_kft3", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kft3", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_kscs"); ----- Книга заклинаний круга тьмы
	SetCraftAmount("ooltyb_itmi_kscs", 1);
	 AddIngre("ooltyb_itmi_kscs", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscs", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscs", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscs", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscs", "ooltyb_itmi_kscs");
	SetCraftPenalty("ooltyb_itmi_kscs", 15);
	SetCraftScience("ooltyb_itmi_kscs", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kscs", 50);
	SetCraftEXP("ooltyb_itmi_kscs", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscs", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_kscf"); ----- Книга заклинаний круга огня
	SetCraftAmount("ooltyb_itmi_kscf", 1);
	 AddIngre("ooltyb_itmi_kscf", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscf", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscf", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscf", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscf", "ooltyb_itmi_kscf");
	SetCraftPenalty("ooltyb_itmi_kscf", 15);
	SetCraftScience("ooltyb_itmi_kscf", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kscf", 50);
	SetCraftEXP("ooltyb_itmi_kscf", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscf", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_kscw"); ----- Книга заклинаний круга воды
	SetCraftAmount("ooltyb_itmi_kscw", 1);
	 AddIngre("ooltyb_itmi_kscw", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscw", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscw", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscw", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscw", "ooltyb_itmi_kscw");
	SetCraftPenalty("ooltyb_itmi_kscw", 15);
	SetCraftScience("ooltyb_itmi_kscw", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kscw", 50);
	SetCraftEXP("ooltyb_itmi_kscw", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscw", "Зачарователь")

AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_kft4"); ----- Книга формул том 4
	SetCraftAmount("ooltyb_itmi_kft4", 1);
	 AddIngre("ooltyb_itmi_kft4", "zdpwla_itmi_dye", 4);
	 AddIngre("ooltyb_itmi_kft4", "ooltyb_itmi_paper", 40);
	 AddIngre("ooltyb_itmi_kft4", "ooltyb_itmi_magicore", 20);
    AddTool("ooltyb_itmi_kft4", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft4", "ooltyb_itmi_kft4");
	SetCraftPenalty("ooltyb_itmi_kft4", 15);
	SetCraftScience("ooltyb_itmi_kft4", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kft4", 50);
	SetCraftEXP("ooltyb_itmi_kft4", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kft4", "Зачарователь")

----- ЗАЧАРОВАТЕЛЬ 2 УРОВЕНЬ РАСХОДНИКИ

AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_mage3"); ----- Заготовка руны 3 круг
	SetCraftAmount("ooltyb_itmi_mage3", 1);
	 AddIngre("ooltyb_itmi_mage3", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("ooltyb_itmi_mage3", "ooltyb_itmi_mage2", 1);
    AddTool("ooltyb_itmi_mage3", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage3", 15);
	SetCraftScience("ooltyb_itmi_mage3", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_mage3", 50);
	SetCraftEXP("ooltyb_itmi_mage3", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_mage3", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "ooltyb_itmi_mage4"); ----- Заготовка руны 4 круг
	SetCraftAmount("ooltyb_itmi_mage4", 1);
	 AddIngre("ooltyb_itmi_mage4", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("ooltyb_itmi_mage4", "ooltyb_itmi_mage3", 1);
    AddTool("ooltyb_itmi_mage4", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage4", 15);
	SetCraftScience("ooltyb_itmi_mage4", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_mage4", 50);
	SetCraftEXP("ooltyb_itmi_mage4", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_mage4", "Зачарователь")

AddItemCategory ("Зачарователь (2 уровень)", "zdpwla_itmi_belthm"); ----- Рунный пояс мага
	SetCraftAmount("zdpwla_itmi_belthm", 1);
	 AddIngre("zdpwla_itmi_belthm", "ooltyb_itmi_mage3", 1);
	 AddIngre("zdpwla_itmi_belthm", "OOLTYB_ITMI_LEATHER", 2);
	AddTool("zdpwla_itmi_belthm","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_belthm", 5);
	SetCraftScience("zdpwla_itmi_belthm", "Зачарователь", 2);
	SetenergyPenalty("zdpwla_itmi_belthm", 50);
	SetCraftEXP("zdpwla_itmi_belthm", 50)
	SetCraftEXP_SKILL("zdpwla_itmi_belthm", "Зачарователь")
	
----- ЗАЧАРОВАТЕЛЬ 2 УРОВЕНЬ БИЖУТЕРИЯ

AddItemCategory ("Зачарователь (2 уровень)", "rmymew_itam_prot_mage_02"); ----- Защитный оберег
	SetCraftAmount("rmymew_itam_prot_mage_02", 1);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_quartz", 4);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itam_prot_mage_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itam_prot_mage_02", 15);
	SetCraftScience("rmymew_itam_prot_mage_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itam_prot_mage_02", 50);
	SetCraftEXP("rmymew_itam_prot_mage_02", 50)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_02", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "rmymew_itri_dex_02"); ----- Среднее кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_02", 1);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_rockcrystal", 4);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_dex_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_dex_02", 15);
	SetCraftScience("rmymew_itri_dex_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_dex_02", 50);
	SetCraftEXP("rmymew_itri_dex_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_dex_02", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "rmymew_itri_hp_02"); ----- Среднее кольцо жизни
	SetCraftAmount("rmymew_itri_hp_02", 1);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_rubin", 4);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_hp_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_02", 15);
	SetCraftScience("rmymew_itri_hp_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_hp_02", 50);
	SetCraftEXP("rmymew_itri_hp_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_hp_02", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "rmymew_itri_str_02"); ----- Среднее кольцо силы
	SetCraftAmount("rmymew_itri_str_02", 1);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_sulfur", 4);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_str_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_02", 15);
	SetCraftScience("rmymew_itri_str_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_str_02", 50);
	SetCraftEXP("rmymew_itri_str_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_str_02", "Зачарователь")
	
AddItemCategory ("Зачарователь (2 уровень)", "rmymew_itri_mana_02"); ----- Кольцо мага
	SetCraftAmount("rmymew_itri_mana_02", 1);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_aquamarine", 4);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_mana_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_02", 15);
	SetCraftScience("rmymew_itri_mana_02", "Зачарователь", 2);
	SetenergyPenalty("rmymew_itri_mana_02", 50);
	SetCraftEXP("rmymew_itri_mana_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_mana_02", "Зачарователь")

----- ЗАЧАРОВАТЕЛЬ 3 УРОВЕНЬ КНИГИ

AddItemCategory ("Зачарователь (3 уровень)", "ooltyb_itmi_kft5"); ----- Книга формул том 5
	SetCraftAmount("ooltyb_itmi_kft5", 1);
	 AddIngre("ooltyb_itmi_kft5", "zdpwla_itmi_dye", 5);
	 AddIngre("ooltyb_itmi_kft5", "ooltyb_itmi_paper", 50);
	 AddIngre("ooltyb_itmi_kft5", "ooltyb_itmi_magicore", 25);
    AddTool("ooltyb_itmi_kft5", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft5", "ooltyb_itmi_kft5");
	SetCraftPenalty("ooltyb_itmi_kft5", 15);
	SetCraftScience("ooltyb_itmi_kft5", "Зачарователь", 2);
	SetenergyPenalty("ooltyb_itmi_kft5", 75);

AddItemCategory ("Зачарователь (3 уровень)", "ooltyb_itmi_kft6"); ----- Книга формул том 6
	SetCraftAmount("ooltyb_itmi_kft6", 1);
	 AddIngre("ooltyb_itmi_kft6", "zdpwla_itmi_dye", 6);
	 AddIngre("ooltyb_itmi_kft6", "ooltyb_itmi_paper", 60);
	 AddIngre("ooltyb_itmi_kft6", "ooltyb_itmi_magicore", 30);
    AddTool("ooltyb_itmi_kft6", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft6", "ooltyb_itmi_kft6");
	SetCraftPenalty("ooltyb_itmi_kft6", 15);
	SetCraftScience("ooltyb_itmi_kft6", "Зачарователь", 3);
	SetenergyPenalty("ooltyb_itmi_kft6", 75);

----- ЗАЧАРОВАТЕЛЬ 3 УРОВЕНЬ РАСХОДНИКИ
	
AddItemCategory ("Зачарователь (3 уровень)", "ooltyb_itmi_mage5"); ----- Заготовка руны 5 круг
	SetCraftAmount("ooltyb_itmi_mage5", 1);
	 AddIngre("ooltyb_itmi_mage5", "ooltyb_itmi_m_ignot", 4);
	 AddIngre("ooltyb_itmi_mage5", "ooltyb_itmi_mage4", 1);
    AddTool("ooltyb_itmi_mage5", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage5", 15);
	SetCraftScience("ooltyb_itmi_mage5", "Зачарователь", 3);
	SetenergyPenalty("ooltyb_itmi_mage5", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "ooltyb_itmi_mage6"); ----- Заготовка руны 6 круг
	SetCraftAmount("ooltyb_itmi_mage6", 1);
	 AddIngre("ooltyb_itmi_mage6", "ooltyb_itmi_m_ignot", 5);
	 AddIngre("ooltyb_itmi_mage6", "ooltyb_itmi_mage5", 1);
    AddTool("ooltyb_itmi_mage6", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage6", 15);
	SetCraftScience("ooltyb_itmi_mage6", "Зачарователь", 3);
	SetenergyPenalty("ooltyb_itmi_mage6", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "zdpwla_itmi_beltum"); ----- Рунный пояс мастера
	SetCraftAmount("zdpwla_itmi_beltum", 1);
	 AddIngre("zdpwla_itmi_beltum", "ooltyb_itmi_mage5", 1);
	 AddIngre("zdpwla_itmi_beltum", "ooltyb_itmi_t_leather", 1);
	AddTool("zdpwla_itmi_beltum","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltum", 5);
	SetCraftScience("zdpwla_itmi_beltum", "Зачарователь", 3);
	SetenergyPenalty("zdpwla_itmi_beltum", 75);
	
----- ЗАЧАРОВАТЕЛЬ 3 УРОВЕНЬ БИЖУТЕРИЯ
	
AddItemCategory ("Зачарователь (3 уровень)", "rmymew_itam_prot_mage_03"); ----- Защитный амулет
	SetCraftAmount("rmymew_itam_prot_mage_03", 1);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_quartz", 8);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itam_prot_mage_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itam_prot_mage_03", 15);
	SetCraftScience("rmymew_itam_prot_mage_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itam_prot_mage_03", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "rmymew_itri_dex_03"); ----- Большое кольцо ловкости
	SetCraftAmount("rmymew_itri_dex_03", 1);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_rockcrystal", 8);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_dex_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_dex_03", 15);
	SetCraftScience("rmymew_itri_dex_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_dex_03", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "rmymew_itri_hp_03"); ----- Большое кольцо жизни
	SetCraftAmount("rmymew_itri_hp_03", 1);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_rubin", 8);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_hp_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_03", 15);
	SetCraftScience("rmymew_itri_hp_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_hp_03", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "rmymew_itri_str_03"); ----- Большое кольцо силы
	SetCraftAmount("rmymew_itri_str_03", 1);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_sulfur", 8);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_str_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_03", 15);
	SetCraftScience("rmymew_itri_str_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_str_03", 75);
	
AddItemCategory ("Зачарователь (3 уровень)", "rmymew_itri_mana_03"); ----- Кольцо мастера
	SetCraftAmount("rmymew_itri_mana_03", 1);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_aquamarine", 8);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_mana_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_03", 15);
	SetCraftScience("rmymew_itri_mana_03", "Зачарователь", 3);
	SetenergyPenalty("rmymew_itri_mana_03", 75);
	
-- ААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААААА

	
	--CheckCraftBase();
	SetTimer("SavePenaltyList", 10*60*1000, 1);
	
	repeat
		GUI_Craft_cat_bg = CreateTexture(200, 200, 2400, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_cat_bg ~= 0;
	repeat
		GUI_Craft_it_bg = CreateTexture(2400, 200, 5500, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_it_bg ~= 0;
	repeat
		GUI_Craft_add_bg = CreateTexture(5475, 200, 8100, 7000, "MENU_INGAME.TGA");
	until GUI_Craft_add_bg ~= 0;
	repeat
		GUI_Craft_exit_bg = CreateTexture(2400, 7000, 5500, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_exit_bg ~= 0;
	repeat
		GUI_Craft_produce_bg = CreateTexture(5475, 7000, 8100, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_produce_bg ~= 0;
	repeat
		GUI_Craft_ptime_bg = CreateTexture(200, 7000, 2400, 7500, "MENU_INGAME.TGA");
	until GUI_Craft_ptime_bg ~= 0;
end

GUI_Craft_cat_bg = 0;
GUI_Craft_it_bg = 0;
GUI_Craft_add_bg = 0;
GUI_Craft_exit_bg = 0;
GUI_Craft_produce_bg = 0;
GUI_Craft_ptime_bg = 0;


function CheckCraftBase()
	--for k, v in pairs(CraftCategory) do
		local k = "Без профессии"
		print("Category: "..k);
		for ki, vi in pairs(CraftCategory[k].items) do
			print(vi);
			--for kci, vci in pairs(CraftItem[vi]) do
				print("Amount: "..CraftItem[vi].amount);
				for kii, vii in pairs(CraftItem[vi].tools) do
					print("Tool:"..kii);
				end
				for kii, vii in pairs(CraftItem[vi].ing) do
					print("Ingredient:"..kii);
					print("Ingredient amount: "..CraftItem[vi].ing[kii].amount);
				end
			--end`
		end
	--end
end

GUI_Craft = {};

function DestroyCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		for k, v in pairs(GUI_Craft[pid].cat) do
			for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
				if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
					DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				end
				if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
					for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
						if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
							DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
						end
					end
				end
			end
		end
		
		if GUI_Craft[pid].ptime_draw ~= nil then
			DestroyPlayerDraw(pid, GUI_Craft[pid].ptime_draw);
		end
		
		DestroyPlayerDraw(pid, GUI_Craft[pid].cat_cur);

		DestroyPlayerDraw(pid, GUI_Craft[pid].it_cur);
		DestroyPlayerDraw(pid, GUI_Craft[pid].cat_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].it_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].add_title);
		DestroyPlayerDraw(pid, GUI_Craft[pid].exit_draw);
		DestroyPlayerDraw(pid, GUI_Craft[pid].produce_draw);
		GUI_Craft[pid] = nil;
	end
end

function GenerateCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		DestroyCraftGUI(pid);
		GUI_Craft[pid] = nil;
	end
	
	GUI_Craft[pid] = {}
	GUI_Craft[pid].current_cat = 0;
	GUI_Craft[pid].current_item = 0;
	GUI_Craft[pid].level = -1;
	
	
	GUI_Craft[pid].cat_title = CreatePlayerDraw(pid, 500, 50, "Категория", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].it_title = CreatePlayerDraw(pid, 2900, 50, "Предмет", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	GUI_Craft[pid].add_title = CreatePlayerDraw(pid, 5775, 50, "Требования", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].exit_draw = CreatePlayerDraw(pid, 2900, 7200, "Выйти (ESC)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
	GUI_Craft[pid].produce_draw = CreatePlayerDraw(pid, 5775, 7200, "Изготовить (Enter)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
			
	GUI_Craft[pid].cat_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	GUI_Craft[pid].it_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
			
	GUI_Craft[pid].cat = {};
	local i = 0;
	
	GameTextForPlayer(pid, 1500, 7500, "Загрузка. Подождите...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 1000);
	for k, v in pairs(CraftCategory) do
		if CraftCategory[k].acquire_workspace ~= true then
			if CraftCategory[k].science ~= nil then
				if GetScienceLevel(pid, CraftCategory[k].science) > 0 then
					GUI_Craft[pid].cat[i] = {};
					--GUI_Craft[pid].cat[i].name = CraftCategory[k];
					GUI_Craft[pid].cat[i].items = {};
					GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
					
					local j = 0;
					
					for ki, vi in pairs(CraftCategory[k].items) do
						GUI_Craft[pid].cat[i].items[j] = {};
						GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
						--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
						--[[GUI_Craft[pid].cat[i].items[j].addition = {};
						local k = 0;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end]]
						
						j = j + 1;
					end
					
					i = i + 1;
				end
			else
					GUI_Craft[pid].cat[i] = {};
					--GUI_Craft[pid].cat[i].name = CraftCategory[k];
					GUI_Craft[pid].cat[i].items = {};
					GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
					
					local j = 0;
					
					for ki, vi in pairs(CraftCategory[k].items) do
						GUI_Craft[pid].cat[i].items[j] = {};
						GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
						--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
						--[[GUI_Craft[pid].cat[i].items[j].addition = {};
						local k = 0;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
												
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end]]
						
						j = j + 1;
					end
					
					i = i + 1;
			end
		else
			for wk in pairs(Workspace) do
				if WorkspaceReachable(pid, wk) == 1 and WorkspaceHasCategory(wk, k) == 1 then
					if CraftCategory[k].science ~= nil then
						if GetScienceLevel(pid, CraftCategory[k].science) > 0 then
							GUI_Craft[pid].cat[i] = {};
							--GUI_Craft[pid].cat[i].name = CraftCategory[k];
							GUI_Craft[pid].cat[i].items = {};
							GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
							
							local j = 0;
							
							for ki, vi in pairs(CraftCategory[k].items) do
								GUI_Craft[pid].cat[i].items[j] = {};
								GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
								--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
								
								--[[GUI_Craft[pid].cat[i].items[j].addition = {};
								local k = 0;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;

								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end]]
								
								j = j + 1;
							end
							
							i = i + 1;
						end
					else
							GUI_Craft[pid].cat[i] = {};
							--GUI_Craft[pid].cat[i].name = CraftCategory[k];
							GUI_Craft[pid].cat[i].items = {};
							GUI_Craft[pid].cat[i].draw = CreatePlayerDraw(pid, 545, 500 + 300*i, k, "Font_Old_10_White_Hi.TGA", 240, 230, 140);
							
							local j = 0;
							
							for ki, vi in pairs(CraftCategory[k].items) do
								GUI_Craft[pid].cat[i].items[j] = {};
								GUI_Craft[pid].cat[i].items[j].instance = CraftCategory[k].items[ki];
								--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(CraftCategory[k].items[ki]), CraftItem[CraftCategory[k].items[ki]].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
								
								--[[GUI_Craft[pid].cat[i].items[j].addition = {};
								local k = 0;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф времени: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d минут", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end]]
								
								j = j + 1;
							end
							
							i = i + 1;
					end
				end
			end
		end
	end
end

function ShowCraftGUI(pid)
	Player[pid].onGUI = true;
	ShowChat(pid, 0);
	FreezePlayer(pid, 1);
	GUI_Craft[pid].level = 0;
	
	GameTextForPlayer(pid, 1500, 7500, "Загружаю список каталогов...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat) do
		ShowPlayerDraw(pid, GUI_Craft[pid].cat[k].draw);
	end
	
	if CraftPenalty[GetPlayerName(pid)] ~= nil then
		--ShowPlayerDraw(pid, GUI_Craft[pid].ptime_draw);
		--ShowTexture(pid, GUI_Craft_ptime_bg);
	end
	
	ShowPlayerDraw(pid, GUI_Craft[pid].cat_cur);
	ShowPlayerDraw(pid, GUI_Craft[pid].cat_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].it_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].add_title);
	ShowPlayerDraw(pid, GUI_Craft[pid].exit_draw);
	ShowTexture(pid, GUI_Craft_exit_bg);
	ShowTexture(pid, GUI_Craft_cat_bg);
	ShowTexture(pid, GUI_Craft_it_bg);
	ShowTexture(pid, GUI_Craft_add_bg);
	ShowCategoryGUI(pid);
	
end

function ShowCategoryGUI(pid)
if GUI_Craft[pid].current_cat ~= nil then
if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items ~= nil then
	GameTextForPlayer(pid, 1500, 7500, "Загружаю список предметов каталога...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items) do
		if v ~= nil then
			GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw = CreatePlayerDraw(pid, 2545, 500 + 300*k, string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
			ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);
		end
	end
end
end
	
end

function ShowItemAddition(pid)
	GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition = {};
	
	local k = 0;
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Инструменты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;
	
	local count = 0;			
	for _ in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].tools) do
		count = count + 1;
	end

	if count > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].tools) do
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Ингредиенты: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing) do				
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Альтернативные инг.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
												
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
												
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Штраф выносливости: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;							
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ед.", CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
	k = k + 1;
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "Навыки: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s Ур.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - Отсутствуют", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition) do
		ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
	end
	ShowPlayerDraw(pid, GUI_Craft[pid].produce_draw);
	ShowTexture(pid, GUI_Craft_produce_bg);
end


function HideItemAddition(pid)
	if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition ~= nil then
		for k, v in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition) do
			HidePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
			DestroyPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k]);
			GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition[k] = nil;
		end
		GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition = nil;
	end
end

function HideCategoriesInfo(pid)
	GameTextForPlayer(pid, 1500, 7500, "Обнуляю список вещей каталога...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
	for k, v in pairs(GUI_Craft[pid].cat) do
		for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
			if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
				HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
				GUI_Craft[pid].cat[k].items[ki].draw = nil;
			end
			if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
				for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
					if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
						HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
						DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
					end
				end
				GUI_Craft[pid].cat[k].items[ki].addition = nil;
			end
		end
	end
	
	GUI_Craft[pid].current_item = 0;
end

function HideCraftGUI(pid)
	if GUI_Craft[pid] ~= nil then
		GameTextForPlayer(pid, 1500, 7500, "Закрываю каталог...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
		for k, v in pairs(GUI_Craft[pid].cat) do
			if v ~= nil then
				HidePlayerDraw(pid, GUI_Craft[pid].cat[k].draw);
				for ki, vi in pairs(GUI_Craft[pid].cat[k].items) do
					if GUI_Craft[pid].cat[k].items[ki].draw ~= nil then
						HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
						DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].draw);
						GUI_Craft[pid].cat[k].items[ki].draw = nil;
					end
					if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
						for kii, vii in pairs(GUI_Craft[pid].cat[k].items[ki].addition) do
							if GUI_Craft[pid].cat[k].items[ki].addition ~= nil then
								HidePlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
								DestroyPlayerDraw(pid, GUI_Craft[pid].cat[k].items[ki].addition[kii]);
							end
						end
						GUI_Craft[pid].cat[k].items[ki].addition = nil;
					end
				end
			end
		end
		
		if CraftPenalty[GetPlayerName(pid)] ~= nil and GUI_Craft[pid].ptime_draw ~= nil then
			--HidePlayerDraw(pid, GUI_Craft[pid].ptime_draw);
			--HideTexture(pid, GUI_Craft_ptime_bg);
		end
		
		HidePlayerDraw(pid, GUI_Craft[pid].cat_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].it_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].cat_title);
		HidePlayerDraw(pid, GUI_Craft[pid].it_title);
		HidePlayerDraw(pid, GUI_Craft[pid].add_title);
		HidePlayerDraw(pid, GUI_Craft[pid].exit_draw);
		HidePlayerDraw(pid, GUI_Craft[pid].produce_draw);
		HideTexture(pid, GUI_Craft_exit_bg);
		HideTexture(pid, GUI_Craft_produce_bg);
		HideTexture(pid, GUI_Craft_cat_bg);
		HideTexture(pid, GUI_Craft_it_bg);
		HideTexture(pid, GUI_Craft_add_bg);
		
		GUI_Craft[pid].current_item = 0;
		GUI_Craft[pid].current_cat = 0;
		GUI_Craft[pid].level = -1;
		ShowChat(pid, 1);
		FreezePlayer(pid, 0);
		Player[pid].onGUI = false;
	end
end

function CraftGUIMoveUp(pid)
	if(GUI_Craft[pid].level == 0) then
		if(GUI_Craft[pid].current_cat > 0) then
			HideCategoriesInfo(pid);
			GUI_Craft[pid].current_cat = GUI_Craft[pid].current_cat - 1;
			ShowCategoryGUI(pid);
			GUI_Craft[pid].current_item = 0;
		end
	elseif(GUI_Craft[pid].level == 1) then
		if(GUI_Craft[pid].current_item > 0) then
			HideItemAddition(pid);
			GUI_Craft[pid].current_item = GUI_Craft[pid].current_item - 1;
			ShowItemAddition(pid);
		end
	end
end

function CraftGUIMoveDown(pid)
	if(GUI_Craft[pid].level == 0) then
		if(GUI_Craft[pid].current_cat < tLen(GUI_Craft[pid].cat)) then
			HideCategoriesInfo(pid);
			GUI_Craft[pid].current_cat = GUI_Craft[pid].current_cat + 1;
			ShowCategoryGUI(pid);
			GUI_Craft[pid].current_item = 0;
		end
	elseif(GUI_Craft[pid].level == 1) then
		if(GUI_Craft[pid].current_item < tLen(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items)) then
			HideItemAddition(pid);
			GUI_Craft[pid].current_item = GUI_Craft[pid].current_item + 1;
			ShowItemAddition(pid);
		end
	end
end


function CraftGUILevel(pid, level)
	GUI_Craft[pid].level = level;
	HideCategoriesInfo(pid);
	ShowCategoryGUI(pid);
	if level == 1 then
		HideItemAddition(pid);
		ShowItemAddition(pid);
		ShowPlayerDraw(pid, GUI_Craft[pid].it_cur);
	elseif level == 0 then
		HidePlayerDraw(pid, GUI_Craft[pid].it_cur);
		HidePlayerDraw(pid, GUI_Craft[pid].produce_draw);
		HideTexture(pid, GUI_Craft_produce_bg);
	end
end

function UpdateCraftCursor(pid)
	if GUI_Craft[pid].level == 0 then
		UpdatePlayerDraw(pid, GUI_Craft[pid].cat_cur, 450, 500 + 300*GUI_Craft[pid].current_cat, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	--elseif GUI_Craft[pid].level == 1 then
		--UpdatePlayerDraw(pid, GUI_Craft[pid].it_cur, 2450, 500 + 300*GUI_Craft[pid].current_item, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	end
		UpdatePlayerDraw(pid, GUI_Craft[pid].it_cur, 2450, 1100, '>>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
		for k in pairs(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items) do
			--GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance = CraftCategory[k].items[ki];
			--GUI_Craft[pid].cat[i].items[j].draw = CreatePlayerDraw(pid, 2545, 500 + 300*j, string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
						
			if GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw ~= nil then
				UpdatePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw, 2545, 500 + 300*(2 + k - GUI_Craft[pid].current_item), string.format("%s x%d", GetItemName(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].instance].amount), "Font_Old_10_White_Hi.TGA", 240, 230, 140);
				if (k - GUI_Craft[pid].current_item) < -2 or (k - GUI_Craft[pid].current_item) > 17 then
					HidePlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);
				else
					ShowPlayerDraw(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[k].draw);			
				end
			end
		
		end
	--end
end

function ProceedAlterCraft(pid, instance)
	if Player[pid].energy >= CraftItem[instance].energy then
		if CheckTools(pid, instance) == true and CheckScience(pid, instance) == true and CheckAlterIng(pid, instance) == true and CraftPenalty[GetPlayerName(pid)] == nil then
			for k, v in pairs(CraftItem[instance].altering) do
				RemoveItem(pid, k, CraftItem[instance].altering[k].amount);
				SaveItems(pid);
			end
			
			GiveItem(pid, instance,  CraftItem[instance].amount);
			HideCraftGUI(pid);
			CraftPenalty[GetPlayerName(pid)] =  CraftItem[instance].penalty;
			Player[pid].energy = Player[pid].energy - CraftItem[instance].energy;
			UpdateEnergyBar(pid);
			SavePlayer(pid);
			SaveItems(pid);
			_saveEnergy(pid);
			PenaltyTimer[GetPlayerName(pid)] = SetTimerEx("DecreasePenalty", 1000, 1, GetPlayerName(pid));
			PlayAnimation(pid, "T_1HSINSPECT");
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." изготовил предмет: "..GetItemName(instance));
			_logCraft(pid, instance,  CraftItem[instance].amount);

			if CraftItem[instance].exp > 0 then
				for i, v in pairs(CraftItem[instance].exp_skill) do
					local skill = v;
					if skill ~= nil then
						_craftGiveEXP(pid, skill, CraftItem[instance].exp);
					end
				end

			end
		else
			PlayAnimation(pid, "T_DONTKNOW");
		end
	else
	
	end

end


function Checkenergy(pid, instance)
	if CraftItem[instance].energy <= Player[pid].energy then
		return true;
	else
		GameTextForPlayer(pid, 1500, 7500, "Недостаточно выносливости","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		return false;
	end
end

function CheckScience(pid, instance)
	local count = 0;
	for _ in pairs(CraftItem[instance].science) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	if max_matches > 0 then
		for k in pairs(CraftItem[instance].science) do
			if GetScienceLevel(pid, k) >= CraftItem[instance].science[k] then
				matches = matches + 1;
			end
		end
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid, 1500, 7500, "Недостаточный уровень навыка","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);

	return false;
end

----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------
function _craftExpSkillConnect(id)

	Player[id].scraft_povar = {0, 0};
	Player[id].scraft_plotnik = {0, 0};
	Player[id].scraft_bronnik = {0, 0};
	Player[id].scraft_oryjeynik = {0, 0};
	Player[id].scraft_magic = {0, 0};
	Player[id].scraft_portnoy = {0, 0};
	Player[id].scraft_alhimic = {0, 0};
	Player[id].scraft_kozhevnik = {0, 0};
	Player[id].scraft_zacharovatel = {0, 0};
	Player[id].scraft_lekar = {0, 0};
	Player[id].scraft_empty1 = {0, 0};
	Player[id].scraft_empty2 = {0, 0};
	Player[id].scraft_empty3 = {0, 0};

end

function _craftSaveEXP(id)

	local file = io.open("Database/Players/Craft/"..Player[id].nickname..".txt", "w+");
	file:write(GetScienceLevel(id, "Повар").." "..Player[id].scraft_povar[2].."\n");
	file:write(GetScienceLevel(id, "Плотник").." "..Player[id].scraft_plotnik[2].."\n");
	file:write(GetScienceLevel(id, "Бронник").." "..Player[id].scraft_bronnik[2].."\n");

	file:write(GetScienceLevel(id, "Оружейник").." "..Player[id].scraft_oryjeynik[2].."\n");
	file:write(GetScienceLevel(id, "Портной").." "..Player[id].scraft_portnoy[2].."\n");
	file:write(GetScienceLevel(id, "Алхимия").." "..Player[id].scraft_alhimic[2].."\n");

	file:write(GetScienceLevel(id, "Кожевник").." "..Player[id].scraft_kozhevnik[2].."\n");
	file:write(GetScienceLevel(id, "Зачарователь").." "..Player[id].scraft_zacharovatel[2].."\n");
	file:write(GetScienceLevel(id, "Магия").." "..Player[id].scraft_magic[2].."\n");

	file:write(GetScienceLevel(id, "Лекарь").." "..Player[id].scraft_lekar[2].."\n");

	file:close();

end

function _craftReadEXP(id)

	local file = io.open("Database/Players/Craft/"..Player[id].nickname..".txt", "r");
	if file then

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_povar = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_plotnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_bronnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
		  Player[id].scraft_oryjeynik= {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			 Player[id].scraft_portnoy = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
		 Player[id].scraft_alhimic = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_kozhevnik = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_zacharovatel = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_magic = {lvl, exp};
		end

		line = file:read("*l");
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_lekar = {lvl, exp};
		end

			line = file:read("*l");
		if line then
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_empty1 = {lvl, exp};
		end
		end

			line = file:read("*l");
		if line then
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_empty2 = {lvl, exp};
		end
		end

			line = file:read("*l");
		if line then
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_empty3 = {lvl, exp};
		end
		end

		line = file:read("*l");
		if line then
		local result, lvl, exp = sscanf(line, "dd");
		if result == 1 then
			Player[id].scraft_empty4 = {lvl, exp};
		end
		end


		
		file:close();
		
	else
		_craftSaveEXP(id);
	end

end

CRAFT_POVAR_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_PLOTNIK_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_BRONNIK_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_ORYJEYNIK_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_PORTNOY_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_ALHIMIC_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_KOZHEVNIK_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_MAGIC_LEVELS = {1000, 2000, 4000, 8000};
CRAFT_ZACHAROVATEL_LEVELS = {1000, 2000, 4000, 8000};

function _getCraftExpCMD(id)

	local nexp = 0;
	for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
		if Player[id].scraft_kozhevnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_kozhevnik[2].."/"..nexp..". Уровень профессии кожевника: "..GetScienceLevel(id, "Кожевник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
		if Player[id].scraft_alhimic[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_alhimic[2].."/"..nexp..". Уровень профессии алхимика: "..GetScienceLevel(id, "Алхимия"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
		if Player[id].scraft_portnoy[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_portnoy[2].."/"..nexp..". Уровень профессии портного: "..GetScienceLevel(id, "Портной"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
		if Player[id].scraft_oryjeynik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_oryjeynik[2].."/"..nexp..". Уровень профессии оружейника: "..GetScienceLevel(id, "Оружейник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_POVAR_LEVELS) do
		if Player[id].scraft_povar[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_povar[2].."/"..nexp..". Уровень профессии повара: "..GetScienceLevel(id, "Повар"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
		if Player[id].scraft_plotnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_plotnik[2].."/"..nexp..". Уровень профессии плотника: "..GetScienceLevel(id, "Плотник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
		if Player[id].scraft_bronnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_bronnik[2].."/"..nexp..". Уровень профессии бронника: "..GetScienceLevel(id, "Бронник"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_MAGIC_LEVELS) do
		if Player[id].scraft_magic[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_magic[2].."/"..nexp..". Уровень профессии магия: "..GetScienceLevel(id, "Магия"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ZACHAROVATEL_LEVELS) do
		if Player[id].scraft_zacharovatel[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..Player[id].scraft_zacharovatel[2].."/"..nexp..". Уровень профессии зачарователя: "..GetScienceLevel(id, "Зачарователь"));
		end
	end

end
addCommandHandler({"/копыт"}, _getCraftExpCMD);

function _craftGiveEXP(id, skill, exp)

	--#######################################################################################################
	if skill == "Повар" then

			if GetScienceLevel(id, "Повар") > 0 then
				local oldValue = Player[id].scraft_povar[2]; Player[id].scraft_povar[2] = Player[id].scraft_povar[2] + exp; local newValue = Player[id].scraft_povar[2];
				_craftSaveEXP(id);

				local nexp = 0;
				for i, v in ipairs(CRAFT_POVAR_LEVELS) do
					if Player[id].scraft_povar[1] == i then
						nexp = v;
						SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
					end
				end

				if Player[id].scraft_povar[2] >= nexp then
					Player[id].scraft_povar[1] = Player[id].scraft_povar[1] + 1; Player[id].scraft_povar[2] = 0;
					AddScience(id, "Повар", Player[id].scraft_povar[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень повара повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end
		--#######################################################################################################
	elseif skill == "Плотник" then

		if GetScienceLevel(id, "Плотник") > 0 then
			local oldValue = Player[id].scraft_plotnik[2]; Player[id].scraft_plotnik[2] = Player[id].scraft_plotnik[2] + exp; local newValue = Player[id].scraft_plotnik[2];
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
				if Player[id].scraft_plotnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_plotnik[2] >= nexp then
				Player[id].scraft_plotnik[1] = Player[id].scraft_plotnik[1] + 1; Player[id].scraft_plotnik[2] = 0;
				AddScience(id, "Плотник", Player[id].scraft_plotnik[1]);
				SendPlayerMessage(id, 255, 255, 255, "Уровень плотника повышен!");
				_craftSaveEXP(id);
				SaveDLPlayerInfo(id);
			end
		end
		--#######################################################################################################
	elseif skill == "Портной" then

		if GetScienceLevel(id, "Портной") > 0 then
				local oldValue = Player[id].scraft_portnoy[2]; Player[id].scraft_portnoy[2] = Player[id].scraft_portnoy[2] + exp; local newValue = Player[id].scraft_portnoy[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
				if Player[id].scraft_portnoy[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_portnoy[2] >= nexp then

					Player[id].scraft_portnoy[1] = Player[id].scraft_portnoy[1] + 1; Player[id].scraft_portnoy[2] = 0;
					AddScience(id, "Портной", Player[id].scraft_portnoy[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень портного повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "Оружейник" then
		if GetScienceLevel(id, "Оружейник") > 0 then
			local oldValue = Player[id].scraft_oryjeynik[2]; Player[id].scraft_oryjeynik[2] = Player[id].scraft_oryjeynik[2] + exp; local newValue = Player[id].scraft_oryjeynik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
				if Player[id].scraft_oryjeynik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_oryjeynik[2] >= nexp then

					Player[id].scraft_oryjeynik[1] = Player[id].scraft_oryjeynik[1] + 1; Player[id].scraft_oryjeynik[2] = 0;
					AddScience(id, "Оружейник", Player[id].scraft_oryjeynik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень оружейника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "Бронник" then
		if GetScienceLevel(id, "Бронник") > 0 then
			local oldValue = Player[id].scraft_bronnik[2]; Player[id].scraft_bronnik[2] = Player[id].scraft_bronnik[2] + exp; local newValue = Player[id].scraft_bronnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
				if Player[id].scraft_bronnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_bronnik[2] >= nexp then

					Player[id].scraft_bronnik[1] = Player[id].scraft_bronnik[1] + 1; Player[id].scraft_bronnik[2] = 0;
					AddScience(id, "Бронник", Player[id].scraft_bronnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень бронника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "Кожевник" then
		if GetScienceLevel(id, "Кожевник") > 0 then

			local oldValue = Player[id].scraft_kozhevnik[2]; Player[id].scraft_kozhevnik[2] = Player[id].scraft_kozhevnik[2] + exp; local newValue = Player[id].scraft_kozhevnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
				if Player[id].scraft_kozhevnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_kozhevnik[2] >= nexp then

					Player[id].scraft_kozhevnik[1] = Player[id].scraft_kozhevnik[1] + 1; Player[id].scraft_kozhevnik[2] = 0;
					AddScience(id, "Кожевник", Player[id].scraft_kozhevnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень кожевника повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "Алхимия" then
		if GetScienceLevel(id, "Алхимия") > 0 then

			local oldValue = Player[id].scraft_alhimic[2]; Player[id].scraft_alhimic[2] = Player[id].scraft_alhimic[2] + exp; local newValue = Player[id].scraft_alhimic[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
				if Player[id].scraft_alhimic[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_alhimic[2] >= nexp then
				
					Player[id].scraft_alhimic[1] = Player[id].scraft_alhimic[1] + 1; Player[id].scraft_alhimic[2] = 0;
					AddScience(id, "Алхимия", Player[id].scraft_alhimic[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень алхимика повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				
			end
		end
		--#######################################################################################################
	elseif skill == "Магия" then
		if GetScienceLevel(id, "Магия") > 0 then

			local oldValue = Player[id].scraft_magic[2]; Player[id].scraft_magic[2] = Player[id].scraft_magic[2] + exp; local newValue = Player[id].scraft_magic[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_MAGIC_LEVELS) do
				if Player[id].scraft_magic[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_magic[2] >= nexp then
				
					Player[id].scraft_magic[1] = Player[id].scraft_magic[1] + 1; Player[id].scraft_magic[2] = 0;
					AddScience(id, "Магия", Player[id].scraft_magic[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень магии повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				
			end
		end
		--#######################################################################################################
	--#######################################################################################################
	elseif skill == "Зачарователь" then
		if GetScienceLevel(id, "Зачарователь") > 0 then

			local oldValue = Player[id].scraft_zacharovatel[2]; Player[id].scraft_zacharovatel[2] = Player[id].scraft_zacharovatel[2] + exp; local newValue = Player[id].scraft_zacharovatel[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ZACHAROVATEL_LEVELS) do
				if Player[id].scraft_zacharovatel[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "Текущий опыт: "..newValue.."/"..nexp.." (получено опыта: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_zacharovatel[2] >= nexp then
			
					Player[id].scraft_zacharovatel[1] = Player[id].scraft_zacharovatel[1] + 1; Player[id].scraft_zacharovatel[2] = 0;
					AddScience(id, "Зачарователь", Player[id].scraft_zacharovatel[1]);
					SendPlayerMessage(id, 255, 255, 255, "Уровень зачарователя повышен!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				
			end
		end
		--#######################################################################################################
	elseif skill == "-------------" then
	end


end
----------------------------------------------------------------
----------------------------------------------------------------
----------------------------------------------------------------

function ProceedCraft(pid, instance)
	if Player[pid].energy >= CraftItem[instance].energy then
		if CheckTools(pid, instance) == true and CheckScience(pid, instance) == true and CheckIng(pid, instance) == true and CraftPenalty[GetPlayerName(pid)] == nil then
			for k, v in pairs(CraftItem[instance].ing) do
				RemoveItem(pid, k, CraftItem[instance].ing[k].amount);
				SaveItems(pid);
			end

			GiveItem(pid, instance,  CraftItem[instance].amount);
			SaveItems(pid);
			HideCraftGUI(pid);
			CraftPenalty[GetPlayerName(pid)] =  CraftItem[instance].penalty;
			Player[pid].energy = Player[pid].energy - CraftItem[instance].energy;
			UpdateEnergyBar(pid);
			_saveEnergy(pid);
			SavePlayer(pid);
			PenaltyTimer[GetPlayerName(pid)] = SetTimerEx("DecreasePenalty", 1000, 1, GetPlayerName(pid));
			local name = GetPlayerName(pid)
			PlayAnimation(pid, "T_1HSINSPECT");
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." изготовил предмет: "..GetItemName(instance));
			_logCraft(pid, instance,  CraftItem[instance].amount);

			if CraftItem[instance].exp > 0 then
				for i, v in pairs(CraftItem[instance].exp_skill) do
					local skill = v;
					if skill ~= nil then
						_craftGiveEXP(pid, skill, CraftItem[instance].exp);
					end
				end
			end

		else
			PlayAnimation(pid, "T_DONTKNOW");
		end
	end
end

function CheckTools(pid, instance)
	local count = 0;
	for _ in pairs(CraftItem[instance].tools) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].tools[items[key].instance] ~= nil then
					matches = matches + 1;
				end
			end
		end
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Нет необходимых инструментов","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckIng(pid, instance)

	local count = 0;
	for _ in pairs(CraftItem[instance].ing) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	--local max_matches = tLen(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item]].ing);
	
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].ing[items[key].instance] ~= nil then
					if CraftItem[instance].ing[items[key].instance].amount <=  items[key].amount then
						matches = matches + 1;
					end
				end
			end
		end
	else
		return false;
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Недостаточно ресурсов","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckAlterIng(pid, instance)

	local count = 0;
	for _ in pairs(CraftItem[instance].ing) do
			count = count + 1
	end

	local matches = 0;
	local items = getPlayerItems(pid);
	local max_matches = count;
	
	if max_matches > 0 then
		if items then
			for key in pairs(items) do
				if CraftItem[instance].altering[items[key].instance] ~= nil then
					if CraftItem[instance].altering[items[key].instance].amount <=  items[key].amount then
						matches = matches + 1;
					end
				end
			end
		end
	else
		GameTextForPlayer(pid,  1500, 7500, "Альтернативных ингредиентов не существует для этого крафта", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		return false;
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "Недостаточно альтернативных ресурсов", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
	return false;
end

function CheckCraftGUI (pid, keydown, keyup)

	if Player[pid].loggedIn == true then

		if keydown == KEY_K then
			--[[if GUI_Craft[pid] == nil and Player[pid].onGUI == false then
				GUIPlayerinfoInit(pid, pid);
				ShowDLPlayerinfo(pid);
				HideDLPlayerinfo(pid);
				DestroyDLPlayerinfo(pid);
				GenerateCraftGUI(pid);
				ShowCraftGUI(pid);
			else
				HideCraftGUI(pid);
				DestroyCraftGUI(pid);
			end]]
		end
		if GUI_Craft[pid] ~= nil then
			if keydown == KEY_LEFT and GUI_Craft[pid].level >= 0 then
				if GUI_Craft[pid].level == 1 then
					CraftGUILevel(pid, 0);
				end
			elseif keydown == KEY_RETURN and GUI_Craft[pid].level == 1  then

				ProceedCraft(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance);

			elseif keydown == KEY_RSHIFT and GUI_Craft[pid].level == 1 then

				ProceedAlterCraft(pid, GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance);

			elseif keydown == KEY_RIGHT and GUI_Craft[pid].level >= 0 then
				if GUI_Craft[pid].level == 0 then
					CraftGUILevel(pid, 1);
				end
			elseif keydown == KEY_DOWN and GUI_Craft[pid].level >= 0  then
				CraftGUIMoveDown(pid);
			elseif keydown == KEY_UP and GUI_Craft[pid].level >= 0  then
				CraftGUIMoveUp(pid);
			end
		end
		
		if GUI_Craft[pid] ~= nil then
			if GUI_Craft[pid].level >= 0 then
				UpdateCraftCursor(pid)
			end
		end
	end
end