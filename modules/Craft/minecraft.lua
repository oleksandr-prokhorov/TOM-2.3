
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
	AddWorkspaceCategory(size, "����� (�������� ������)");
	AddWorkspaceCategory(size, "����� (1 �������)");
	AddWorkspaceCategory(size, "����� (2 �������)");
	AddWorkspaceCategory(size, "����� (3 �������)");
	AddWorkspaceCategory(size, "����� (4 �������)");
	AddWorkspaceCategory(size, "������� (�������� ������)");
	AddWorkspaceCategory(size, "������� (1 �������)");
	AddWorkspaceCategory(size, "������� (2 �������)");
	AddWorkspaceCategory(size, "������� (3 �������)");
	AddWorkspaceCategory(size, "������� (4 �������)");
	AddWorkspaceCategory(size, "��������� (�������� ������)");
	AddWorkspaceCategory(size, "��������� (1 �������)");
	AddWorkspaceCategory(size, "��������� (2 �������)");
	AddWorkspaceCategory(size, "��������� (3 �������)");
	AddWorkspaceCategory(size, "��������� (4 �������)");
	AddWorkspaceCategory(size, "������� (�������� ������)");
	AddWorkspaceCategory(size, "������� (1 �������)");
	AddWorkspaceCategory(size, "������� (2 �������)");
	AddWorkspaceCategory(size, "������� (3 �������)");
	AddWorkspaceCategory(size, "������� (4 �������)");
	AddWorkspaceCategory(size, "������� (�������� ������)");
	AddWorkspaceCategory(size, "������� (1 �������)");
	AddWorkspaceCategory(size, "������� (2 �������)");
	AddWorkspaceCategory(size, "������� (3 �������)");
	AddWorkspaceCategory(size, "������� (4 �������)");
	AddWorkspaceCategory(size, "�������� (�������� ������)");
	AddWorkspaceCategory(size, "�������� (1 �������)");
	AddWorkspaceCategory(size, "�������� (2 �������)");
	AddWorkspaceCategory(size, "�������� (3 �������)");
	AddWorkspaceCategory(size, "�������� (4 �������)");
	AddWorkspaceCategory(size, "������� (�������� ������)");
	AddWorkspaceCategory(size, "������� (1 �������)");
	AddWorkspaceCategory(size, "������� (2 �������)");
	AddWorkspaceCategory(size, "������� (3 �������)");
	AddWorkspaceCategory(size, "������� (4 �������)");
	AddWorkspaceCategory(size, "���� �����");
	AddWorkspaceCategory(size, "(�) 1-� ����");
	AddWorkspaceCategory(size, "(�) 2-� ����");
	AddWorkspaceCategory(size, "(�) 3-� ����");
	AddWorkspaceCategory(size, "(�) 4-� ����");
	AddWorkspaceCategory(size, "(�) 5-� ����");
	AddWorkspaceCategory(size, "(�) 6-� ����");
	AddWorkspaceCategory(size, "(�) 1-� ����");
	AddWorkspaceCategory(size, "(�) 2-� ����");
	AddWorkspaceCategory(size, "(�) 3-� ����");
	AddWorkspaceCategory(size, "(�) 4-� ����");
	AddWorkspaceCategory(size, "(�) 5-� ����");
	AddWorkspaceCategory(size, "(�) 6-� ����");
	AddWorkspaceCategory(size, "������������ (�������� ������)");
	AddWorkspaceCategory(size, "������������ (1 �������)");
	AddWorkspaceCategory(size, "������������ (2 �������)");
	AddWorkspaceCategory(size, "������������ (3 �������)");
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

	ToggleWorkspace("����� (�������� ������)");
	ToggleWorkspace("����� (1 �������)");
	ToggleWorkspace("����� (2 �������)");
	ToggleWorkspace("����� (3 �������)");
	ToggleWorkspace("����� (4 �������)");
	ToggleWorkspace("������� (�������� ������)");
	ToggleWorkspace("������� (1 �������)");
	ToggleWorkspace("������� (2 �������)");
	ToggleWorkspace("������� (3 �������)");
	ToggleWorkspace("������� (4 �������)");
	ToggleWorkspace("��������� (�������� ������)");
	ToggleWorkspace("��������� (1 �������)");
	ToggleWorkspace("��������� (2 �������)");
	ToggleWorkspace("��������� (3 �������)");
	ToggleWorkspace("��������� (4 �������)");
	ToggleWorkspace("������� (�������� ������)");
	ToggleWorkspace("������� (1 �������)");
	ToggleWorkspace("������� (2 �������)");
	ToggleWorkspace("������� (3 �������)");
	ToggleWorkspace("������� (4 �������)");
	ToggleWorkspace("�������� (�������� ������)");
	ToggleWorkspace("�������� (1 �������)");
	ToggleWorkspace("�������� (2 �������)");
	ToggleWorkspace("�������� (3 �������)");
	ToggleWorkspace("�������� (4 �������)");
	ToggleWorkspace("������� (�������� ������)");
	ToggleWorkspace("������� (1 �������)");
	ToggleWorkspace("������� (2 �������)");
	ToggleWorkspace("������� (3 �������)");
	ToggleWorkspace("������� (4 �������)");
	ToggleWorkspace("������� (�������� ������)");
	ToggleWorkspace("������� (1 �������)");
	ToggleWorkspace("������� (2 �������)");
	ToggleWorkspace("������� (3 �������)");
	ToggleWorkspace("������� (4 �������)");
	ToggleWorkspace("���� �����");
	ToggleWorkspace("(�) 1-� ����");
	ToggleWorkspace("(�) 2-� ����");
	ToggleWorkspace("(�) 3-� ����");
	ToggleWorkspace("(�) 4-� ����");
	ToggleWorkspace("(�) 5-� ����");
	ToggleWorkspace("(�) 6-� ����");
	ToggleWorkspace("(�) 1-� ����");
	ToggleWorkspace("(�) 2-� ����");
	ToggleWorkspace("(�) 3-� ����");
	ToggleWorkspace("(�) 4-� ����");
	ToggleWorkspace("(�) 5-� ����");
	ToggleWorkspace("(�) 6-� ����");
	ToggleWorkspace("������������ (�������� ������)");
	ToggleWorkspace("������������ (1 �������)");
	ToggleWorkspace("������������ (2 �������)");
	ToggleWorkspace("������������ (3 �������)");

	--[[ToggleWorkspace("(�) 1-� ����");
	ToggleWorkspace("(�) 2-� ����");
	ToggleWorkspace("(�) 3-� ����");
	ToggleWorkspace("(�) 4-� ����");
	ToggleWorkspace("(�) 5-� ����");
	ToggleWorkspace("(�) 1-� ����");
	ToggleWorkspace("(�) 2-� ����");
	ToggleWorkspace("(�) 3-� ����");
	ToggleWorkspace("(�) 4-� ����");
	ToggleWorkspace("(�) 5-� ����");]]
	AddCategoryScience("����� (�������� ������)", "�����");
	AddCategoryScience("����� (1 �������)", "�����");
	AddCategoryScience("����� (2 �������)", "�����");
	AddCategoryScience("����� (3 �������)", "�����");
	AddCategoryScience("����� (4 �������)", "�����");
	AddCategoryScience("������� (�������� ������)", "�������");
	AddCategoryScience("������� (1 �������)", "�������");
	AddCategoryScience("������� (2 �������)", "�������");
	AddCategoryScience("������� (3 �������)", "�������");
	AddCategoryScience("������� (4 �������)", "�������");
	AddCategoryScience("��������� (�������� ������)", "���������");
	AddCategoryScience("��������� (1 �������)", "���������");
	AddCategoryScience("��������� (2 �������)", "���������");
	AddCategoryScience("��������� (3 �������)", "���������");
	AddCategoryScience("��������� (4 �������)", "���������");
	AddCategoryScience("������� (�������� ������)", "�������");
	AddCategoryScience("������� (1 �������)", "�������");
	AddCategoryScience("������� (2 �������)", "�������");
	AddCategoryScience("������� (3 �������)", "�������");
	AddCategoryScience("������� (4 �������)", "�������");
	AddCategoryScience("�������� (�������� ������)", "��������");
	AddCategoryScience("�������� (1 �������)", "��������");
	AddCategoryScience("�������� (2 �������)", "��������");
	AddCategoryScience("�������� (3 �������)", "��������");
	AddCategoryScience("�������� (4 �������)", "��������");
	AddCategoryScience("������� (�������� ������)", "�������");
	AddCategoryScience("������� (1 �������)", "�������");
	AddCategoryScience("������� (2 �������)", "�������");
	AddCategoryScience("������� (3 �������)", "�������");
	AddCategoryScience("������� (4 �������)", "�������");
	AddCategoryScience("������� (�������� ������)", "�������");
	AddCategoryScience("������� (1 �������)", "�������");
	AddCategoryScience("������� (2 �������)", "�������");
	AddCategoryScience("������� (3 �������)", "�������");
	AddCategoryScience("������� (4 �������)", "�������");
	AddCategoryScience("���� �����", "�������");
	AddCategoryScience("(�) 1-� ����", "�����");
	AddCategoryScience("(�) 2-� ����", "�����");
	AddCategoryScience("(�) 3-� ����", "�����");
	AddCategoryScience("(�) 4-� ����", "�����");
	AddCategoryScience("(�) 5-� ����", "�����");
	AddCategoryScience("(�) 6-� ����", "�����");
	AddCategoryScience("(�) 1-� ����", "�����");
	AddCategoryScience("(�) 2-� ����", "�����");
	AddCategoryScience("(�) 3-� ����", "�����");
	AddCategoryScience("(�) 4-� ����", "�����");
	AddCategoryScience("(�) 5-� ����", "�����");
	AddCategoryScience("(�) 6-� ����", "�����");
	AddCategoryScience("������������ (�������� ������)", "������������");
	AddCategoryScience("������������ (1 �������)", "������������");
	AddCategoryScience("������������ (2 �������)", "������������");
	AddCategoryScience("������������ (3 �������)", "������������");
	
	--[[AddCategoryScience("(�) 1-� ����", "�����");

	AddCategoryScience("(�) 2-� ����", "�����");
	AddCategoryScience("(�) 3-� ����", "�����");
	AddCategoryScience("(�) 4-� ����", "�����");
	AddCategoryScience("(�) 5-� ����", "�����");
	AddCategoryScience("(�) 1-� ����", "�����");
	AddCategoryScience("(�) 2-� ����", "�����");
	AddCategoryScience("(�) 3-� ����", "�����");
	AddCategoryScience("(�) 4-� ����", "�����");
	AddCategoryScience("(�) 5-� ����", "�����");]]
	
	
--�����������������������������������������������������������������������������������������������������������������������������������������������������
	
	-- ��� ���������

AddItemCategory ("��� ���������", "ZDPWLA_ItFo_GrapeJuice"); ----- ����������� ���
	SetCraftAmount("ZDPWLA_ItFo_GrapeJuice", 2);
     AddIngre("ZDPWLA_ItFo_GrapeJuice", "ZDPWLA_ITFO_WINEBERRYS2", 5);
	 AddIngre("ZDPWLA_ItFo_GrapeJuice", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_GrapeJuice", 5);
	SetCraftScience("ZDPWLA_ItFo_GrapeJuice", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_GrapeJuice", 25);
	
AddItemCategory ("��� ���������", "ZDPWLA_ItFo_MushroomOffal"); ----- ������� �������
    SetCraftAmount("ZDPWLA_ItFo_MushroomOffal", 2);
     AddIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_02", 5);
	 AddAlterIngre("ZDPWLA_ItFo_MushroomOffal", "ZDPWLA_ItPl_Mushroom_01", 5);
    SetCraftPenalty("ZDPWLA_ItFo_MushroomOffal", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomOffal", "��� ���������", 0);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomOffal", 25);
	
AddItemCategory ("��� ���������", "ZDPWLA_ItFo_FishFried"); ----- ������� ����
	SetCraftAmount("ZDPWLA_ItFo_FishFried", 2);
     AddIngre("ZDPWLA_ItFo_FishFried", "ZDPWLA_ItFo_Fish", 5);
	SetCraftPenalty("ZDPWLA_ItFo_FishFried", 5);
	SetCraftScience("ZDPWLA_ItFo_FishFried", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_FishFried", 25);

AddItemCategory ("��� ���������", "ZDPWLA_ItFoMutton"); ----- ������� ����
	SetCraftAmount("ZDPWLA_ItFoMutton", 2);
     AddIngre("ZDPWLA_ItFoMutton", "ZDPWLA_ItFoMuttonRaw", 5);
    SetCraftPenalty("ZDPWLA_ItFoMutton", 5);
	SetCraftScience("ZDPWLA_ItFoMutton", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFoMutton", 25);
	
AddItemCategory ("��� ���������", "ZDPWLA_ItFo_Honey"); ----- ���
	SetCraftAmount("ZDPWLA_ItFo_Honey", 2);
     AddIngre("ZDPWLA_ItFo_Honey", "OOLTYB_ITMI_HONEYCOMB", 5);
	SetCraftPenalty("ZDPWLA_ItFo_Honey", 5);
	SetCraftScience("ZDPWLA_ItFo_Honey", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Honey", 25);
	
AddItemCategory ("��� ���������", "ZDPWLA_ItFo_Mors"); ----- ����
	SetCraftAmount("ZDPWLA_ItFo_Mors", 2);
	 AddIngre("ZDPWLA_ItFo_Mors", "ZDPWLA_ItPl_Forestberry", 5);
	 AddIngre("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Mors", "ZDPWLA_ITFO_WINEBERRYS2", 5);
	 AddAlterIngre("ZDPWLA_ItFo_Mors", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ItFo_Mors", 5);
	SetCraftScience("ZDPWLA_ItFo_Mors", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Mors", 25);

AddItemCategory ("��� ���������", "ZDPWLA_ItFo_Addon_Shellflesh"); ----- ���� ��������
	SetCraftAmount("ZDPWLA_ItFo_Addon_Shellflesh", 2);
     AddIngre("ZDPWLA_ItFo_Addon_Shellflesh", "OOLTYB_ItMi_ReMi2", 5);
	SetCraftPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_Shellflesh", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_Shellflesh", 25);
	
AddItemCategory ("��� ���������", "zdpwla_itfo_samogon"); ----- �������
	SetCraftAmount("zdpwla_itfo_samogon", 2);
     AddIngre("zdpwla_itfo_samogon", "zdpwla_itpl_temp_herb", 5);
	 AddIngre("zdpwla_itfo_samogon", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("zdpwla_itfo_samogon", "zdpwla_itfo_cane", 5);
	 AddAlterIngre("zdpwla_itfo_samogon", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("zdpwla_itfo_samogon", 5);
	SetCraftScience("zdpwla_itfo_samogon", "��� ���������", 0);
	SetenergyPenalty("zdpwla_itfo_samogon", 25);
	
AddItemCategory ("��� ���������", "ZDPWLA_ItFo_PoorSoup"); ----- ��� �������
	SetCraftAmount("ZDPWLA_ItFo_PoorSoup", 2);
	 AddIngre("ZDPWLA_ItFo_PoorSoup", "ZDPWLA_ItPl_Temp_Herb", 5);
	 AddAlterIngre("ZDPWLA_ItFo_PoorSoup", "zdpwla_itfo_cane", 5);
	SetCraftPenalty("ZDPWLA_ItFo_PoorSoup", 10);
	SetCraftScience("ZDPWLA_ItFo_PoorSoup", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ItFo_PoorSoup", 25);

AddItemCategory ("��� ���������", "ZDPWLA_ITFO_TEA"); ----- ���
	SetCraftAmount("ZDPWLA_ITFO_TEA", 2);
	 AddIngre("ZDPWLA_ITFO_TEA", "ZDPWLA_ItPl_Mana_Herb_01", 5);
	 AddIngre("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Flask", 2);
	 AddAlterIngre("ZDPWLA_ITFO_TEA", "zdpwla_itpl_mana_herb_03", 2);
	 AddAlterIngre("ZDPWLA_ITFO_TEA", "OOLTYB_ItMi_Flask", 2);
	SetCraftPenalty("ZDPWLA_ITFO_TEA", 2);
	SetCraftScience("ZDPWLA_ITFO_TEA", "��� ���������", 0);
	SetenergyPenalty("ZDPWLA_ITFO_TEA", 25);
	
	AddItemCategory ("��� ���������", "OOLTYB_ItMi_Joint"); ----- ����������
	SetCraftAmount("OOLTYB_ItMi_Joint", 2);
     AddIngre("OOLTYB_ItMi_Joint", "ZDPWLA_ItPl_SwampHerb", 5);
     	AddTool("OOLTYB_ItMi_Joint", "ooltyb_itmi_jointrecipe1");
	SetCraftPenalty("OOLTYB_ItMi_Joint", 5);
	SetCraftScience("OOLTYB_ItMi_Joint", "��� ���������", 0);
	SetenergyPenalty("OOLTYB_ItMi_Joint", 25);
	
	AddItemCategory ("��� ���������", "OOLTYB_ItMi_Coal"); ----- �����
	SetCraftAmount("OOLTYB_ItMi_Coal", 15);
     AddIngre("OOLTYB_ItMi_Coal", "OOLTYB_ITMI_WOOD", 25);
     AddAlterIngre("OOLTYB_ItMi_Coal", "OOLTYB_ITAT_CRAWLERPLATE", 15);
	SetCraftPenalty("OOLTYB_ItMi_Coal", 5);
	SetCraftScience("OOLTYB_ItMi_Coal", "��� ���������", 0);
	SetenergyPenalty("OOLTYB_ItMi_Coal", 25);
	
	AddItemCategory ("��� ���������", "OOLTYB_ITMI_Stroy"); ---- ������������ ���������
	SetCraftAmount("OOLTYB_ITMI_Stroy", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_OBRABOTDER", 1);
     AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_FIBER", 1);
	 AddIngre("OOLTYB_ITMI_Stroy", "OOLTYB_ITMI_LEATHER", 1);
	SetCraftPenalty("OOLTYB_ITMI_Stroy", 10);
	SetCraftScience("OOLTYB_ITMI_Stroy", "��� ���������", 0);
	SetenergyPenalty("OOLTYB_ITMI_Stroy", 25);
	
	AddItemCategory ("��� ���������", "itlstorch"); ---- �����
	SetCraftAmount("itlstorch", 15);
	 AddIngre("itlstorch", "ooltyb_itmi_pitch", 1);
	 AddIngre("itlstorch", "jkztzd_itmw_1h_bau_mace", 1);
	SetCraftPenalty("itlstorch", 1);
	SetCraftScience("itlstorch", "��� ���������", 0);
	SetenergyPenalty("itlstorch", 10);
	
	AddItemCategory ("��� ���������", "yfauun_itar_koszyk"); ---- �������� ��� �����
	SetCraftAmount("yfauun_itar_koszyk", 1);
	 AddIngre("yfauun_itar_koszyk", "ooltyb_itmi_wheat", 1);
	SetCraftPenalty("yfauun_itar_koszyk", 1);
	SetCraftScience("yfauun_itar_koszyk", "��� ���������", 0);
	SetenergyPenalty("yfauun_itar_koszyk", 10);
	
	AddItemCategory ("��� ���������", "yfauun_itar_koszyk2"); ---- �������� ��� ����
	SetCraftAmount("yfauun_itar_koszyk2", 1);
	 AddIngre("yfauun_itar_koszyk2", "ooltyb_itmi_Iron", 1);
	SetCraftPenalty("yfauun_itar_koszyk2", 1);
	SetCraftScience("yfauun_itar_koszyk2", "��� ���������", 0);
	SetenergyPenalty("yfauun_itar_koszyk2", 10);
	
	AddItemCategory ("��� ���������", "yfauun_itar_koszyk3"); ---- �������� ��� �����
	SetCraftAmount("yfauun_itar_koszyk3", 1);
	 AddIngre("yfauun_itar_koszyk3", "zdpwla_itpl_temp_herb", 1);
	SetCraftPenalty("yfauun_itar_koszyk3", 1);
	SetCraftScience("yfauun_itar_koszyk2", "��� ���������", 0);
	SetenergyPenalty("yfauun_itar_koszyk3", 10);
	
--�����������������������������������������������������������������������������������������������������������������������������������������������������������	


-- ����� 1 �������� ������

AddItemCategory ("����� (�������� ������)", "rc_house_ware_14"); ----- ���������� �����
	SetCraftAmount("rc_house_ware_14", 1);
	 AddIngre("rc_house_ware_14", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_ware_14", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_14", 10);
	SetCraftScience("rc_house_ware_14", "�����", 1);
	SetenergyPenalty("rc_house_ware_14", 25);
	SetCraftEXP("rc_house_ware_14", 25)
	SetCraftEXP_SKILL("rc_house_ware_14", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_8"); ----- �������� �������
	SetCraftAmount("rc_house_ware_8", 1);
	 AddIngre("rc_house_ware_8", "ZDPWLA_ItFo_Addon_MeatSoup", 5);
	 AddIngre("rc_house_ware_8", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_8", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_8", 10);
	SetCraftScience("rc_house_ware_8", "�����", 1);
	SetenergyPenalty("rc_house_ware_8", 25);
	SetCraftEXP("rc_house_ware_8", 25)
	SetCraftEXP_SKILL("rc_house_ware_8", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_7"); ----- �������� ���
	SetCraftAmount("rc_house_ware_7", 1);
	 AddIngre("rc_house_ware_7", "ZDPWLA_ItFo_FishSouP", 5);
	 AddIngre("rc_house_ware_7", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_7", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_7", 10);
	SetCraftScience("rc_house_ware_7", "�����", 1);
	SetenergyPenalty("rc_house_ware_7", 25);
	SetCraftEXP("rc_house_ware_7", 25)
	SetCraftEXP_SKILL("rc_house_ware_7", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_5"); ----- �������� � �����
	SetCraftAmount("rc_house_ware_5", 1);
	 AddIngre("rc_house_ware_5", "ZDPWLA_ItFo_Beer", 5);
	 AddIngre("rc_house_ware_5", "zdpwla_itpl_temp_herb", 10);
    AddTool("rc_house_ware_5", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_5", 10);
	SetCraftScience("rc_house_ware_5", "�����", 1);
	SetenergyPenalty("rc_house_ware_5", 25);
	SetCraftEXP("rc_house_ware_5", 25)
	SetCraftEXP_SKILL("rc_house_ware_5", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_6"); ----- ��������� �����
	SetCraftAmount("rc_house_ware_6", 1);
	 AddIngre("rc_house_ware_6", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_ware_6", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_6", 10);
	SetCraftScience("rc_house_ware_6", "�����", 1);
	SetenergyPenalty("rc_house_ware_6", 25);
	SetCraftEXP("rc_house_ware_6", 25)
	SetCraftEXP_SKILL("rc_house_ware_6", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_create_5"); ----- �������� ����
	SetCraftAmount("rc_house_create_5", 1);
	 AddIngre("rc_house_create_5", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_create_5", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_5", 10);
	SetCraftScience("rc_house_create_5", "�����", 1);
	SetenergyPenalty("rc_house_create_5", 25);
	SetCraftEXP("rc_house_create_5", 25)
	SetCraftEXP_SKILL("rc_house_create_5", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_create_6"); ----- ������ ����
	SetCraftAmount("rc_house_create_6", 1);
	 AddIngre("rc_house_create_6", "ooltyb_itmi_wood", 15);
    AddTool("rc_house_create_6", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_6", 10);
	SetCraftScience("rc_house_create_6", "�����", 1);
	SetenergyPenalty("rc_house_create_6", 25);
	SetCraftEXP("rc_house_create_6", 25)
	SetCraftEXP_SKILL("rc_house_create_6", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_11"); ----- ������� ����� �� �������
	SetCraftAmount("rc_house_ware_11", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_temp_herb", 5);
	 AddIngre("rc_house_ware_11", "zdpwla_itfo_plants_seraphis_01", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_mana_herb_01", 1);
	 AddIngre("rc_house_ware_11", "zdpwla_itpl_health_herb_01", 1);
    AddTool("rc_house_ware_11", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_ware_11", 10);
	SetCraftScience("rc_house_ware_11", "�����", 1);
	SetenergyPenalty("rc_house_ware_11", 25);
	SetCraftEXP("rc_house_ware_11", 25)
	SetCraftEXP_SKILL("rc_house_ware_11", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_26"); ----- ������� ����
	SetCraftAmount("rc_house_ware_26", 1);
	 AddIngre("rc_house_ware_26", "ooltyb_itmi_wood", 5);
	 AddIngre("rc_house_ware_26", "zdpwla_itfo_millet", 10);
    AddTool("rc_house_ware_26", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("rc_house_ware_26", 10);
	SetCraftScience("rc_house_ware_26", "�����", 1);
	SetenergyPenalty("rc_house_ware_26", 25);
	SetCraftEXP("rc_house_ware_26", 25)
	SetCraftEXP_SKILL("rc_house_ware_26", "�����")
	
AddItemCategory ("����� (�������� ������)", "rc_house_ware_2"); ----- ������� � ���������
	SetCraftAmount("rc_house_ware_2", 1);
	 AddIngre("rc_house_ware_2", "ZDPWLA_ItFo_MushroomCutlet", 5);
	 AddIngre("rc_house_ware_2", "ooltyb_itmi_wood", 10);
    AddTool("rc_house_ware_2", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("rc_house_ware_2", 10);
	SetCraftScience("rc_house_ware_2", "�����", 1);
	SetenergyPenalty("rc_house_ware_2", 25);
	SetCraftEXP("rc_house_ware_2", 25)
	SetCraftEXP_SKILL("rc_house_ware_2", "�����")

AddItemCategory ("����� (�������� ������)", "rc_house_create_4"); ----- ���� � �������
	SetCraftAmount("rc_house_create_4", 1);
	 AddIngre("rc_house_create_4", "ooltyb_itmi_wood", 20);
    AddTool("rc_house_create_4", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("rc_house_create_4", 10);
	SetCraftScience("rc_house_create_4", "�����", 1);
	SetenergyPenalty("rc_house_create_4", 25);
	SetCraftEXP("rc_house_create_4", 25)
	SetCraftEXP_SKILL("rc_house_create_4", "�����")


-- ����� 1 �������

AddItemCategory ("����� (1 �������)", "ZDPWLA_ITFO_ACORNBOOZE"); ----- ���������
	SetCraftAmount("ZDPWLA_ITFO_ACORNBOOZE", 4);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 4);
	 AddIngre("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_FlasK", 4);
    AddTool("ZDPWLA_ITFO_ACORNBOOZE", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_ACORNBOOZE", 20);
	SetCraftScience("ZDPWLA_ITFO_ACORNBOOZE", "�����", 1);
	SetenergyPenalty("ZDPWLA_ITFO_ACORNBOOZE", 25);
	SetCraftEXP("ZDPWLA_ITFO_ACORNBOOZE", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_ACORNBOOZE", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_SmokedFish"); ----- �������� ����
	SetCraftAmount("ZDPWLA_ItFo_SmokedFish", 4);
	 AddIngre("ZDPWLA_ItFo_SmokedFish", "ZDPWLA_ItFo_Fish", 4);
	 AddTool("ZDPWLA_ItFo_SmokedFish", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_SmokedFish", 10);
	SetCraftScience("ZDPWLA_ItFo_SmokedFish", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_SmokedFish", 25);	
	SetCraftEXP("ZDPWLA_ItFo_SmokedFish", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_SmokedFish", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_MarinMushroom"); ----- ������������ �����
	SetCraftAmount("ZDPWLA_ItFo_MarinMushroom", 4);
	 AddIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_01", 4);
	 AddAlterIngre("ZDPWLA_ItFo_MarinMushroom", "ZDPWLA_ItPl_Mushroom_02", 4);
    AddTool("ZDPWLA_ItFo_MarinMushroom", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_MarinMushroom", 5);
	SetCraftScience("ZDPWLA_ItFo_MarinMushroom", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_MarinMushroom", 25);	
	SetCraftEXP("ZDPWLA_ItFo_MarinMushroom", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MarinMushroom", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_Addon_MeatSoup"); ----- ������ ��������
	SetCraftAmount("ZDPWLA_ItFo_Addon_MeatSoup", 4);
	 AddIngre("ZDPWLA_ItFo_Addon_MeatSoup", "ZDPWLA_ItFoMuttonRaw", 4);
    AddTool("ZDPWLA_ItFo_Addon_MeatSoup", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 5);
	SetCraftScience("ZDPWLA_ItFo_Addon_MeatSoup", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_MeatSoup", 25);
	SetCraftEXP("ZDPWLA_ItFo_Addon_MeatSoup", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Addon_MeatSoup", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_Beer"); ----- ����
	SetCraftAmount("ZDPWLA_ItFo_Beer", 4);
	 AddIngre("ZDPWLA_ItFo_Beer", "ooltyb_itmi_wheat", 4);
	 AddIngre("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Flask", 4);
	 AddAlterIngre("ZDPWLA_ItFo_Beer", "zdpwla_itpl_temp_herb", 4);
	 AddAlterIngre("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Flask", 4);
    AddTool("ZDPWLA_ItFo_Beer", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Beer", 20);
	SetCraftScience("ZDPWLA_ItFo_Beer", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Beer", 25);
	SetCraftEXP("ZDPWLA_ItFo_Beer", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Beer", "�����")

AddItemCategory ("����� (1 �������)", "zdpwla_itfo_addon_rum"); ----- ����
	SetCraftAmount("zdpwla_itfo_addon_rum", 4);
	 AddIngre("zdpwla_itfo_addon_rum", "zdpwla_itfo_cane", 4);
	 AddIngre("zdpwla_itfo_addon_rum", "OOLTYB_ItMi_Flask", 4);
    AddTool("zdpwla_itfo_addon_rum", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("zdpwla_itfo_addon_rum", 20);
	SetCraftScience("zdpwla_itfo_addon_rum", "�����", 1);
	SetenergyPenalty("zdpwla_itfo_addon_rum", 25);
	SetCraftEXP("zdpwla_itfo_addon_rum", 25)
	SetCraftEXP_SKILL("zdpwla_itfo_addon_rum", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ITFO_SOUP"); ----- ��� �� ��������
	SetCraftAmount("ZDPWLA_ITFO_SOUP", 4);
	 AddIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
	 AddAlterIngre("ZDPWLA_ITFO_SOUP", "ZDPWLA_ItPl_Strength_Herb_01", 1);
    AddTool("ZDPWLA_ITFO_SOUP", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_SOUP", 20);
	SetCraftScience("ZDPWLA_ITFO_SOUP", "�����", 1);
	SetenergyPenalty("ZDPWLA_ITFO_SOUP", 25);	
	SetCraftEXP("ZDPWLA_ITFO_SOUP", 25)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_SOUP", "�����")

AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_Cheese"); ----- ���
	SetCraftAmount("ZDPWLA_ItFo_Cheese", 4);
	 AddIngre("ZDPWLA_ItFo_Cheese", "ZDPWLA_ItFo_Milk", 4);
    AddTool("ZDPWLA_ItFo_Cheese", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Cheese", 5);
	SetCraftScience("ZDPWLA_ItFo_Cheese", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_Cheese", 25);
	SetCraftEXP("ZDPWLA_ItFo_Cheese", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Cheese", "�����")
	
AddItemCategory ("����� (1 �������)", "ZDPWLA_ItFo_AcornBread"); ----- ��������� ����
	SetCraftAmount("ZDPWLA_ItFo_AcornBread", 4);
	 AddIngre("ZDPWLA_ItFo_AcornBread", "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 4);
	 AddTool("ZDPWLA_ItFo_AcornBread", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_AcornBread", 20);
	SetCraftScience("ZDPWLA_ItFo_AcornBread", "�����", 1);
	SetenergyPenalty("ZDPWLA_ItFo_AcornBread", 25);
	SetCraftEXP("ZDPWLA_ItFo_AcornBread", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_AcornBread", "�����")

AddItemCategory ("����� (1 �������)", "zdpwla_itfo_ricebooze"); ----- �����
	SetCraftAmount("zdpwla_itfo_ricebooze", 4);
	 AddIngre("zdpwla_itfo_ricebooze", "ooltyb_itmi_wheat", 4);
	 AddIngre("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Flask", 4);
	 AddAlterIngre("zdpwla_itfo_ricebooze", "zdpwla_itfo_plants_seraphis_01", 4);
	 AddAlterIngre("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Flask", 4);
    AddTool("zdpwla_itfo_ricebooze", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("zdpwla_itfo_ricebooze", 20);
	SetCraftScience("zdpwla_itfo_ricebooze", "�����", 1);
	SetenergyPenalty("zdpwla_itfo_ricebooze", 25);
	SetCraftEXP("zdpwla_itfo_ricebooze", 25)
	SetCraftEXP_SKILL("zdpwla_itfo_ricebooze", "�����")

-- ����� 2 �������

AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_MBlinchik"); ----- ����� � �����
	SetCraftAmount("ZDPWLA_ItFo_MBlinchik", 6);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_wheat", 3);
	 AddIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_honeycomb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_MBlinchik", "zdpwla_itpl_temp_herb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_MBlinchik", "ooltyb_itmi_honeycomb", 3);
	 AddTool("ZDPWLA_ItFo_MBlinchik", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_MBlinchik", 20);
	SetCraftScience("ZDPWLA_ItFo_MBlinchik", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_MBlinchik", 50);
	SetCraftEXP("ZDPWLA_ItFo_MBlinchik", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_MBlinchik", "�����")

AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_MushroomCutlet"); ----- ������� �������
    SetCraftAmount("ZDPWLA_ItFo_MushroomCutlet", 6);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_01", 3);
     AddIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_02", 3);
     AddAlterIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mushroom_01", 3);
     AddAlterIngre("ZDPWLA_ItFo_MushroomCutlet", "zdpwla_itpl_mana_herb_03", 1);
    AddTool("ZDPWLA_ItFo_MushroomCutlet", "OOLTYB_ItMi_PaN");
    SetCraftPenalty("ZDPWLA_ItFo_MushroomCutlet", 10);
    SetCraftScience("ZDPWLA_ItFo_MushroomCutlet", "�����", 2);
    SetenergyPenalty("ZDPWLA_ItFo_MushroomCutlet", 50);
    SetCraftEXP("ZDPWLA_ItFo_MushroomCutlet", 50)
    SetCraftEXP_SKILL("ZDPWLA_ItFo_MushroomCutlet", "�����")	
	
AddItemCategory ("����� (2 �������)", "zdpwla_itfo_addon_grog"); ----- ����
    SetCraftAmount("zdpwla_itfo_addon_grog", 6);
     AddIngre("zdpwla_itfo_addon_grog", "zdpwla_itfo_cane", 3);
     AddIngre("zdpwla_itfo_addon_grog", "ooltyb_itmi_honeycomb", 3);
     AddIngre("zdpwla_itfo_addon_grog", "ooltyb_itmi_flask", 6);
    AddTool("zdpwla_itfo_addon_grog", "OOLTYB_ItMi_PaN");
    SetCraftPenalty("zdpwla_itfo_addon_grog", 10);
    SetCraftScience("zdpwla_itfo_addon_grog", "�����", 2);
    SetenergyPenalty("zdpwla_itfo_addon_grog", 50);
    SetCraftEXP("zdpwla_itfo_addon_grog", 50)
    SetCraftEXP_SKILL("zdpwla_itfo_addon_grog", "�����")	
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_BoozE"); ----- ����
	SetCraftAmount("ZDPWLA_ItFo_BoozE", 6);
     AddIngre("ZDPWLA_ItFo_BoozE", "ooltyb_itmi_remi1", 3);
     AddIngre("ZDPWLA_ItFo_BoozE", "zdpwla_itpl_mana_herb_03", 3);
     AddIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_FlasK", 6);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "ooltyb_itmi_remi", 3);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "zdpwla_itfo_plants_towerwood_01", 3);
     AddAlterIngre("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_FlasK", 6);
	 AddTool("ZDPWLA_ItFo_BoozE", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BoozE", 10);
	SetCraftScience("ZDPWLA_ItFo_BoozE", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_BoozE", 50);
	SetCraftEXP("ZDPWLA_ItFo_BoozE", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BoozE", "�����")

AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_Bread"); ----- ����
	SetCraftAmount("ZDPWLA_ItFo_Bread", 6);
	 AddIngre("ZDPWLA_ItFo_Bread", "zdpwla_itfo_millet", 3);
	 AddIngre("ZDPWLA_ItFo_Bread", "zdpwla_itfo_egg", 3);
    AddTool("ZDPWLA_ItFo_Bread", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Bread", 5);
	SetCraftScience("ZDPWLA_ItFo_Bread", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Bread", 50);
	SetCraftEXP("ZDPWLA_ItFo_Bread", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bread", "�����")
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_SausagE"); ----- �������
	SetCraftAmount("ZDPWLA_ItFo_SausagE", 6);
	 AddIngre("ZDPWLA_ItFo_SausagE", "ZDPWLA_ItFoMuttonRaW", 3);
	 AddIngre("ZDPWLA_ItFo_SausagE", "OOLTYB_ItAt_Fat", 3);
    AddTool("ZDPWLA_ItFo_SausagE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_SausagE", 10);
	SetCraftScience("ZDPWLA_ItFo_SausagE", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_SausagE", 50);
	SetCraftEXP("ZDPWLA_ItFo_SausagE", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_SausagE", "�����")
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_Medovuha"); ----- ��������
	SetCraftAmount("ZDPWLA_ItFo_Medovuha", 6);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ooltyb_itmi_honeycomb", 3);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "ZDPWLA_ItPl_Forestberry", 3);
	 AddIngre("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_FlasK", 6);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "ooltyb_itmi_honeycomb", 3);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "zdpwla_itpl_dex_herb_01", 3);
	 AddAlterIngre("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_FlasK", 6);
    AddTool("ZDPWLA_ItFo_Medovuha", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Medovuha", 20);
	SetCraftScience("ZDPWLA_ItFo_Medovuha", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_Medovuha", 50);
	SetCraftEXP("ZDPWLA_ItFo_Medovuha", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Medovuha", "�����")	
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_FishBatter"); ----- ���� � �����
	SetCraftAmount("ZDPWLA_ItFo_FishBatter", 6);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "ZDPWLA_ItFo_Fish", 3);
	 AddIngre("ZDPWLA_ItFo_FishBatter", "zdpwla_itfo_millet", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishBatter", "ZDPWLA_ItFo_Fish", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishBatter", "ooltyb_itmi_remi", 3);
    AddTool("ZDPWLA_ItFo_FishBatter", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_FishBatter", 10);
	SetCraftScience("ZDPWLA_ItFo_FishBatter", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_FishBatter", 50);
	SetCraftEXP("ZDPWLA_ItFo_FishBatter", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_FishBatter", "�����")
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ItFo_FishSouP"); ----- ���
	SetCraftAmount("ZDPWLA_ItFo_FishSouP", 6);
     AddIngre("ZDPWLA_ItFo_FishSouP", "ZDPWLA_ItFo_Fish", 3);
     AddIngre("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ReMi", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishSouP", "ooltyb_itmi_remi2", 3);
	 AddAlterIngre("ZDPWLA_ItFo_FishSouP", "zdpwla_itpl_mushroom_01", 3);
	 AddTool("ZDPWLA_ItFo_FishSouP", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_FishSouP", 10);
	SetCraftScience("ZDPWLA_ItFo_FishSouP", "�����", 2);
	SetenergyPenalty("ZDPWLA_ItFo_FishSouP", 50);
	SetCraftEXP("ZDPWLA_ItFo_FishSouP", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_FishSouP", "�����")	
	
AddItemCategory ("����� (2 �������)", "ZDPWLA_ITFO_BERRYSALAD"); ----- ������� �����
	SetCraftAmount("ZDPWLA_ITFO_BERRYSALAD", 6);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "ZDPWLA_ItPl_Forestberry", 3);
	 AddIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itpl_dex_herb_01", 3);
	 AddAlterIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itfo_plants_seraphis_01", 3);
	 AddAlterIngre("ZDPWLA_ITFO_BERRYSALAD", "zdpwla_itfo_plants_trollberrys_01", 3);
    AddTool("ZDPWLA_ITFO_BERRYSALAD", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ITFO_BERRYSALAD", 5);
	SetCraftScience("ZDPWLA_ITFO_BERRYSALAD", "�����", 2);
	SetenergyPenalty("ZDPWLA_ITFO_BERRYSALAD", 50);
	SetCraftEXP("ZDPWLA_ITFO_BERRYSALAD", 50)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BERRYSALAD", "�����")
	
-- ����� 3 �������
	
AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_Bomber"); ----- ������
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
	SetCraftScience("ZDPWLA_ItFo_Bomber", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bomber", 75);
	SetCraftEXP("ZDPWLA_ItFo_Bomber", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bomber", "�����")
	

AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_WinE"); ----- ����
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
	SetCraftScience("ZDPWLA_ItFo_WinE", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_WinE", 75);
	SetCraftEXP("ZDPWLA_ItFo_WinE", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_WinE", "�����")	
	
AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_HoneyMeat"); ----- ���� � ������� �����
	SetCraftAmount("ZDPWLA_ItFo_HoneyMeat", 8);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_HoneyMeat", "ooltyb_itmi_honeycomb", 2);
     AddIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ITFO_PLANTS_TROLLBERRYS_01", 2);
     AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "ooltyb_itmi_honeycomb", 2);
     AddAlterIngre("ZDPWLA_ItFo_HoneyMeat", "zdpwla_itpl_mana_herb_01", 2);
	 AddTool("ZDPWLA_ItFo_HoneyMeat", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_HoneyMeat", 10);
	SetCraftScience("ZDPWLA_ItFo_HoneyMeat", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_HoneyMeat", 75);
	SetCraftEXP("ZDPWLA_ItFo_HoneyMeat", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_HoneyMeat", "�����")	

AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_Bacon"); ----- ������
	SetCraftAmount("ZDPWLA_ItFo_Bacon", 8);
	 AddIngre("ZDPWLA_ItFo_Bacon", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itpl_mana_herb_01", 2);
	 AddIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itfo_plants_seraphis_01", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Bacon", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Bacon", "ooltyb_itmi_remi1", 2);
     AddAlterIngre("ZDPWLA_ItFo_Bacon", "zdpwla_itfo_plants_seraphis_01", 2);
	 AddTool("ZDPWLA_ItFo_Bacon", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_Bacon", 10);
	SetCraftScience("ZDPWLA_ItFo_Bacon", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Bacon", 75);	
	SetCraftEXP("ZDPWLA_ItFo_Bacon", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Bacon", "�����")	

AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_BeafPie"); ----- ����� �� ���������
	SetCraftAmount("ZDPWLA_ItFo_BeafPie", 8);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_millet", 2);
	 AddIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_egg", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BeafPie", "ooltyb_itat_fat", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_millet", 2);
     AddAlterIngre("ZDPWLA_ItFo_BeafPie", "zdpwla_itfo_egg", 2);
	 AddTool("ZDPWLA_ItFo_BeafPie", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_BeafPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BeafPie", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BeafPie", 75);	
	SetCraftEXP("ZDPWLA_ItFo_BeafPie", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BeafPie", "�����")	

AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_Casserole"); ----- ���������� ���������
	SetCraftAmount("ZDPWLA_ItFo_Casserole", 8);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itpl_mushroom_04", 2);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_egg", 2);
	 AddIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_millet", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Casserole", "ooltyb_itat_fat", 2);
	 AddAlterIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_millet", 2);
     AddAlterIngre("ZDPWLA_ItFo_Casserole", "zdpwla_itfo_plants_stoneroot_01", 2);
	 AddTool("ZDPWLA_ItFo_Casserole", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ItFo_Casserole", 10);
	SetCraftScience("ZDPWLA_ItFo_Casserole", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Casserole", 75);	
	SetCraftEXP("ZDPWLA_ItFo_Casserole", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_Casserole", "�����")	

AddItemCategory ("����� (3 �������)", "ZDPWLA_ITFO_BARBECUE"); ----- ������
	SetCraftAmount("ZDPWLA_ITFO_BARBECUE", 8);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "ZDPWLA_ItFoMuttonRaW", 2);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "zdpwla_itpl_mushroom_02", 2);
	 AddIngre("ZDPWLA_ITFO_BARBECUE", "zdpwla_itpl_temp_herb", 2);
    AddTool("ZDPWLA_ITFO_BARBECUE", "jkztzd_itmw_1h_knife_01");
	SetCraftPenalty("ZDPWLA_ITFO_BARBECUE", 10);
	SetCraftScience("ZDPWLA_ITFO_BARBECUE", "�����", 3);
	SetenergyPenalty("ZDPWLA_ITFO_BARBECUE", 75);
	SetCraftEXP("ZDPWLA_ITFO_BARBECUE", 75)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_BARBECUE", "�����")		
	
AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_BerryLiqueur"); ----- ������� �������
	SetCraftAmount("ZDPWLA_ItFo_BerryLiqueur", 8);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "zdpwla_itfo_plants_seraphis_01", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Forestberry", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "ZDPWLA_ItPl_Dex_Herb_01", 2);
     AddIngre("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_BerryLiqueur", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ItFo_BerryLiqueur", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryLiqueur", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryLiqueur", 75);
	SetCraftEXP("ZDPWLA_ItFo_BerryLiqueur", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BerryLiqueur", "�����")

AddItemCategory ("����� (3 �������)", "ZDPWLA_ItFo_BerryPie"); ----- ������� �����
	SetCraftAmount("ZDPWLA_ItFo_BerryPie", 8);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_millet", 2);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "ZDPWLA_ItPl_Forestberry", 2);
	 AddIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_egg", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_millet", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itpl_dex_herb_01", 2);
	 AddAlterIngre("ZDPWLA_ItFo_BerryPie", "zdpwla_itfo_egg", 2);
	 AddTool("ZDPWLA_ItFo_BerryPie", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ItFo_BerryPie", 10);
	SetCraftScience("ZDPWLA_ItFo_BerryPie", "�����", 3);
	SetenergyPenalty("ZDPWLA_ItFo_BerryPie", 75);	
	SetCraftEXP("ZZDPWLA_ItFo_BerryPie", 75)
	SetCraftEXP_SKILL("ZDPWLA_ItFo_BerryPie", "�����")
	
AddItemCategory ("����� (3 �������)", "ZDPWLA_ITFO_FRIEDEGG"); ----- ������� � ��������
	SetCraftAmount("ZDPWLA_ITFO_FRIEDEGG", 8);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ITFO_EGG", 2);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfo_plants_stoneroot_01", 2);
	 AddIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfomuttonraw", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "ZDPWLA_ITFO_EGG", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfo_milk", 2);
	 AddAlterIngre("ZDPWLA_ITFO_FRIEDEGG", "zdpwla_itfomuttonraw", 2);
	 AddTool("ZDPWLA_ITFO_FRIEDEGG", "OOLTYB_ItMi_PaN");
	SetCraftPenalty("ZDPWLA_ITFO_FRIEDEGG", 5);
	SetCraftScience("ZDPWLA_ITFO_FRIEDEGG", "�����", 3);
	SetenergyPenalty("ZDPWLA_ITFO_FRIEDEGG", 75);		
	SetCraftEXP("ZDPWLA_ITFO_FRIEDEGG", 75)
	SetCraftEXP_SKILL("ZDPWLA_ITFO_FRIEDEGG", "�����")

-- ����� 4 �������

AddItemCategory ("����� (4 �������)", "ZDPWLA_ITFO_SHAURMA"); ----- �������� � ������
	SetCraftAmount("ZDPWLA_ITFO_SHAURMA", 10);
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "ZDPWLA_ItFoMuttonRaW", 1); 
	 AddIngre("ZDPWLA_ITFO_SHAURMA", "zdpwla_itfo_millet", 1);
     AddIngre("ZDPWLA_ITFO_SHAURMA", "zdpwla_itpl_mushroom_02", 1);	 
     AddIngre("ZDPWLA_ITFO_SHAURMA", "ooltyb_itat_fat", 1);	 
	 AddTool("ZDPWLA_ITFO_SHAURMA", "JKZTZD_ITMW_1H_KNIFE_01");
	SetCraftPenalty("ZDPWLA_ITFO_SHAURMA", 20);
	SetCraftScience("ZDPWLA_ITFO_SHAURMA", "�����", 4);
	SetenergyPenalty("ZDPWLA_ITFO_SHAURMA", 100);
	
AddItemCategory ("����� (4 �������)", "ZDPWLA_ItFo_MagicSoup"); ----- ��������� ���
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
	SetCraftScience("ZDPWLA_ItFo_MagicSoup", "�����", 4);
	SetenergyPenalty("ZDPWLA_ItFo_MagicSoup", 100);
	
AddItemCategory ("����� (4 �������)", "ZDPWLA_ItFo_Managa"); ----- ������
	SetCraftAmount("ZDPWLA_ItFo_Managa", 10);
	 AddIngre("ZDPWLA_ItFo_Managa", "ZDPWLA_ItFo_Milk", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "ooltyb_itmi_remi1", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "zdpwla_itpl_mushroom_04", 1);
	 AddIngre("ZDPWLA_ItFo_Managa", "zdpwla_itpl_mana_herb_03", 1);
	 AddTool("ZDPWLA_ItFo_Managa", "OOLTYB_ItMi_Scoop");
	SetCraftPenalty("ZDPWLA_ItFo_Managa", 10);
	SetCraftScience("ZDPWLA_ItFo_Managa", "�����", 4);
	SetenergyPenalty("ZDPWLA_ItFo_Managa", 100);	

AddItemCategory ("����� (4 �������)", "ZDPWLA_ITFO_HONEYBISCUIT"); ----- ������� �������
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
	SetCraftScience("ZDPWLA_ITFO_HONEYBISCUIT", "�����", 4);
	SetenergyPenalty("ZDPWLA_ITFO_HONEYBISCUIT", 100);
	
AddItemCategory ("����� (4 �������)", "zdpwla_itfo_monk_wine"); ----- ������������ ����
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
	SetCraftScience("zdpwla_itfo_monk_wine", "�����", 4);
	SetenergyPenalty("zdpwla_itfo_monk_wine", 100);

AddItemCategory ("����� (4 �������)", "ZDPWLA_ITFO_SEASALAD"); ----- ������� �����
	SetCraftAmount("ZDPWLA_ITFO_SEASALAD", 10);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi1", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "ooltyb_itmi_remi2", 1);
     AddIngre("ZDPWLA_ITFO_SEASALAD", "zdpwla_itfo_cane", 1);
	 AddTool("ZDPWLA_ITFO_SEASALAD", "OOLTYB_ItMi_ScooP");
	SetCraftPenalty("ZDPWLA_ITFO_SEASALAD", 10);
	SetCraftScience("ZDPWLA_ITFO_SEASALAD", "�����", 4);
	SetenergyPenalty("ZDPWLA_ITFO_SEASALAD", 100);
	
AddItemCategory ("����� (4 �������)", "ZDPWLA_ItFo_Addon_FireSteW"); ----- ��������� �������
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
	SetCraftScience("ZDPWLA_ItFo_Addon_FireSteW", "�����", 4);
	SetenergyPenalty("ZDPWLA_ItFo_Addon_FireSteW", 100);
	
AddItemCategory ("����� (4 �������)", "zdpwla_itfo_cake"); ----- ������� �����
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
	SetCraftScience("zdpwla_itfo_cake", "�����", 4);
	SetenergyPenalty("zdpwla_itfo_cake", 100);
	
AddItemCategory ("����� (4 �������)", "ZDPWLA_ItFo_OysterSoup"); ----- ��� �� ������
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
	SetCraftScience("ZDPWLA_ItFo_OysterSoup", "�����", 4);
	SetenergyPenalty("ZDPWLA_ItFo_OysterSoup", 100);	
	
AddItemCategory ("����� (4 �������)", "ZDPWLA_ItFo_WineStew"); ----- ������� ���� � ����
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
	SetCraftScience("ZDPWLA_ItFo_WineStew", "�����", 4);
	SetenergyPenalty("ZDPWLA_ItFo_WineStew", 100);		

-- ������� �������� ������

AddItemCategory ("������� (�������� ������)", "rc_house_ware_20"); ----- ������ �����
	SetCraftAmount("rc_house_ware_20", 1);
	 AddIngre("rc_house_ware_20", "ZDPWLA_ItPl_Temp_Herb", 5);
	 AddIngre("rc_house_ware_20", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_20", 10);
	SetCraftScience("rc_house_ware_20", "�������", 1);
	SetenergyPenalty("rc_house_ware_20", 25);
	SetCraftEXP("rc_house_ware_20", 25)
	SetCraftEXP_SKILL("rc_house_ware_20", "�������")
	
AddItemCategory ("������� (�������� ������)", "rc_house_ware_12"); ----- ������ ����
	SetCraftAmount("rc_house_ware_12", 1);
	 AddIngre("rc_house_ware_12", "zdpwla_itfo_wineberrys2", 5);
	 AddIngre("rc_house_ware_12", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_12", 10);
	SetCraftScience("rc_house_ware_12", "�������", 1);
	SetenergyPenalty("rc_house_ware_12", 25);
	SetCraftEXP("rc_house_ware_12", 25)
	SetCraftEXP_SKILL("rc_house_ware_12", "�������")
	
AddItemCategory ("������� (�������� ������)", "rc_house_ware_25"); ----- ������ ����
	SetCraftAmount("rc_house_ware_25", 1);
	 AddIngre("rc_house_ware_25", "ooltyb_itmi_coal", 5);
	 AddIngre("rc_house_ware_25", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("rc_house_ware_25", 10);
	SetCraftScience("rc_house_ware_25", "�������", 1);
	SetenergyPenalty("rc_house_ware_25", 25);
	SetCraftEXP("rc_house_ware_25", 25)
	SetCraftEXP_SKILL("rc_house_ware_25", "�������")
	
AddItemCategory ("������� (�������� ������)", "rc_house_ware_15"); ----- ������ �����
	SetCraftAmount("rc_house_ware_15", 1);
	 AddIngre("rc_house_ware_15", "ooltyb_itmi_remi1", 5);
	 AddIngre("rc_house_ware_15", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_15", 10);
	SetCraftScience("rc_house_ware_15", "�������", 1);
	SetenergyPenalty("rc_house_ware_15", 25);
	SetCraftEXP("rc_house_ware_15", 25)
	SetCraftEXP_SKILL("rc_house_ware_15", "�������")

AddItemCategory ("������� (�������� ������)", "rc_house_ware_13"); ----- ������ ����
	SetCraftAmount("rc_house_ware_13", 1);
	 AddIngre("rc_house_ware_13", "ooltyb_itmi_wheat", 5);
	 AddIngre("rc_house_ware_13", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 2);
	SetCraftPenalty("rc_house_ware_13", 10);
	SetCraftScience("rc_house_ware_13", "�������", 1);
	SetenergyPenalty("rc_house_ware_13", 25);
	SetCraftEXP("rc_house_ware_13", 25)
	SetCraftEXP_SKILL("rc_house_ware_13", "�������")

-- ������� 1 �������

AddItemCategory ("������� (1 �������)", "ZDPWLA_ItMi_AlchBasis"); ----- ������������ ������
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
	SetCraftScience("ZDPWLA_ItMi_AlchBasis", "�������", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchBasis", 25);
	SetCraftEXP("ZDPWLA_ItMi_AlchBasis", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_AlchBasis", "�������")

AddItemCategory ("������� (1 �������)", "ZDPWLA_ItMi_AlchSub"); ----- ������������ ��������
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
	SetCraftScience("ZDPWLA_ItMi_AlchSub", "�������", 1);
	SetenergyPenalty("ZDPWLA_ItMi_AlchSub", 25);
	SetCraftEXP("ZDPWLA_ItMi_AlchSub", 25)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_AlchSub", "�������")

AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_JOINT_1");  ----- ����� ���
	SetCraftAmount("OOLTYB_ITMI_JOINT_1", 4);
	 AddIngre("OOLTYB_ITMI_JOINT_1", "ZDPWLA_ItPl_SwampHerb", 4);
	 AddTool("OOLTYB_ITMI_JOINT_1", "OOLTYB_ITMI_JOINTRECIPE1");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_1", 5);
	SetCraftScience("OOLTYB_ITMI_JOINT_1", "�������", 1);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_1", 25);
	SetCraftEXP("OOLTYB_ITMI_JOINT_1", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_JOINT_1", "�������")

AddItemCategory ("������� (1 �������)", "ZEQFRN_ItPo_Health_01");  ----- �������� ��������
	SetCraftAmount("ZEQFRN_ItPo_Health_01", 5);
	AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Health_01", "ZDPWLA_ItPl_Health_Herb_01", 5);
    AddIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ITAT_CRAWLERMANDIBLES", 3);
    AddAlterIngre("ZEQFRN_ItPo_Health_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("ZEQFRN_ItPo_Health_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Health_01", "�������", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Health_01", 25);
	SetCraftEXP("ZEQFRN_ItPo_Health_01", 25)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Health_01", "�������")

AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01");  ---- �����
	SetCraftAmount("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 5);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "ZDPWLA_ItPl_Temp_Herb", 5);
	AddIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "zdpwla_itfo_plants_seraphis_01", 5);
	AddAlterIngre("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 5);
	SetCraftScience("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "�������", 1);
	SetenergyPenalty("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 25);
	SetCraftEXP("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", "�������")

AddItemCategory ("������� (1 �������)", "ZEQFRN_ItPo_Mana_01"); ---- �������� ����
	SetCraftAmount("ZEQFRN_ItPo_Mana_01", 5);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZEQFRN_ItPo_Mana_01", "ZDPWLA_ItPl_Mana_Herb_01", 5);
	AddIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ItMi_FlasK", 5);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ITAT_CRAWLERMANDIBLES", 3);
	AddAlterIngre("ZEQFRN_ItPo_Mana_01", "OOLTYB_ItMi_FlasK", 5);
	SetCraftPenalty("ZEQFRN_ItPo_Mana_01", 20);
	SetCraftScience("ZEQFRN_ItPo_Mana_01", "�������", 1);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_01", 25);
	SetCraftEXP("ZEQFRN_ItPo_Mana_01", 25)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Mana_01", "�������")
	

-- ������� 2 �������

AddItemCategory ("������� (2 �������)", "ZDPWLA_ItMi_Glue");  ---- ����
	SetCraftAmount("ZDPWLA_ItMi_Glue", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Sulfur", 1);
	AddIngre("ZDPWLA_ItMi_Glue", "OOLTYB_ItMi_Pitch", 1);
	SetCraftPenalty("ZDPWLA_ItMi_Glue", 10);
	SetCraftScience("ZDPWLA_ItMi_Glue", "�������", 2);
	SetenergyPenalty("ZDPWLA_ItMi_Glue", 50);
	SetCraftEXP("ZDPWLA_ItMi_Glue", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_Glue", "�������")

AddItemCategory ("������� (2 �������)", "ZDPWLA_ItMi_Dye");  ---- ������
	SetCraftAmount("ZDPWLA_ItMi_Dye", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "OOLTYB_ItMi_ReMi2", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 1);
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 1);	
	AddIngre("ZDPWLA_ItMi_Dye", "ZDPWLA_ITFO_EGG", 1);
	SetCraftPenalty("ZDPWLA_ItMi_Dye", 10);
	SetCraftScience("ZDPWLA_ItMi_Dye", "�������", 2);
	SetenergyPenalty("ZDPWLA_ItMi_Dye", 50);
	SetCraftEXP("ZDPWLA_ItMi_Dye", 50)
	SetCraftEXP_SKILL("ZDPWLA_ItMi_Dye", "�������")
	
AddItemCategory ("������� (2 �������)", "ZEQFRN_ItPo_Health_02"); ----- �������� ��������
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
	SetCraftScience("ZEQFRN_ItPo_Health_02", "�������", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Health_02", 50);
	SetCraftEXP("ZEQFRN_ItPo_Health_02", 50)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Health_02", "�������")

AddItemCategory ("������� (2 �������)", "OOLTYB_ITMI_JOINT_2");  ----- �������� ������
	SetCraftAmount("OOLTYB_ITMI_JOINT_2", 6);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ItPl_SwampHerb", 3);
	 AddIngre("OOLTYB_ITMI_JOINT_2", "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 3);
	 AddTool("OOLTYB_ITMI_JOINT_2", "OOLTYB_ITMI_JOINTRECIPE2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_2", 10);
	SetCraftScience("OOLTYB_ITMI_JOINT_2", "�������", 2);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_2", 50);
	SetCraftEXP("OOLTYB_ITMI_JOINT_2", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_JOINT_2", "�������")

AddItemCategory ("������� (2 �������)", "ZEQFRN_ItPo_Mana_02"); --- �������� ����
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
	SetCraftScience("ZEQFRN_ItPo_Mana_02", "�������", 2);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_02", 50);
	SetCraftEXP("ZEQFRN_ItPo_Mana_02", 50)
	SetCraftEXP_SKILL("ZEQFRN_ItPo_Mana_02", "�������")

-- ������� 3 �������

AddItemCategory ("������� (3 �������)", "OOLTYB_ITMI_JOINT_3");  ----- ����� ��������
	SetCraftAmount("OOLTYB_ITMI_JOINT_3", 8);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_SwampHerb", 2);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "zdpwla_itpl_mushroom_02", 2);
	 AddIngre("OOLTYB_ITMI_JOINT_3", "ZDPWLA_ItPl_Mushroom_04", 2);
	 AddTool("OOLTYB_ITMI_JOINT_3", "OOLTYB_ITMI_JOINTRECIPE2");
	SetCraftPenalty("OOLTYB_ITMI_JOINT_3", 20);
	SetCraftScience("OOLTYB_ITMI_JOINT_3", "�������", 3);
	SetenergyPenalty("OOLTYB_ITMI_JOINT_3", 75);
	
	
AddItemCategory ("������� (3 �������)", "ZDPWLA_ItFo_Opus");  ----- ���� �������
	SetCraftAmount("ZDPWLA_ItFo_Opus", 8);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchBasis", 1);
	 AddIngre("ZDPWLA_ItFo_Opus", "ZDPWLA_ItMi_AlchSub", 1);
	 AddIngre("ZEQFRN_ItPo_Health_03", "OOLTYB_ItMi_FlasK", 8);
	 AddTool("ZDPWLA_ItFo_Opus", "OOLTYB_ITMI_OPUSRECIPE");
	SetCraftPenalty("ZDPWLA_ItFo_Opus", 20);
	SetCraftScience("ZDPWLA_ItFo_Opus", "�������", 3);
	SetenergyPenalty("ZDPWLA_ItFo_Opus", 75);	


AddItemCategory ("������� (3 �������)", "ZEQFRN_ItPo_Health_03"); ---- �������� �������
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
	SetCraftScience("ZEQFRN_ItPo_Health_03", "�������", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Health_03", 75);


AddItemCategory ("������� (3 �������)", "ZEQFRN_ItPo_Mana_03"); ---- ������� ����
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
	SetCraftScience("ZEQFRN_ItPo_Mana_03", "�������", 3);
	SetenergyPenalty("ZEQFRN_ItPo_Mana_03", 75);
	

AddItemCategory ("������� (3 �������)", "ZEQFRN_ITPO_SON");  ---- ����������
	SetCraftAmount("ZEQFRN_ITPO_SON", 1);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ItPl_SwampHerb", 6);
	AddIngre("ZEQFRN_ITPO_SON", "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 5);
	AddIngre("ZEQFRN_ITPO_SON", "OOLTYB_ItMi_FlasK", 1);
	SetCraftPenalty("ZEQFRN_ITPO_SON", 20);
	SetCraftScience("ZEQFRN_ITPO_SON", "�������", 3);
	SetenergyPenalty("ZEQFRN_ITPO_SON", 75);

	
AddItemCategory ("������� (3 �������)", "ZEQFRN_ITPO_IAD");  ---- ��
	SetCraftAmount("ZEQFRN_ITPO_IAD", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_SharkTeeth", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_IAD", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 1);
	SetCraftPenalty("ZEQFRN_ITPO_IAD", 20);
	SetCraftScience("ZEQFRN_ITPO_IAD", "�������", 3);
	SetenergyPenalty("ZEQFRN_ITPO_IAD", 75);
	
	
AddItemCategory ("������� (3 �������)", "ZEQFRN_ITPO_ANTIDOTE");  ---- �������
	SetCraftAmount("ZEQFRN_ITPO_ANTIDOTE", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_SharkTeeth", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ItAt_Sting", 1);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "ZDPWLA_ItPl_Health_Herb_03", 5);
	AddIngre("ZEQFRN_ITPO_ANTIDOTE", "OOLTYB_ITMI_ALCHEMY_ALCOHOL_01", 3);
	SetCraftPenalty("ZEQFRN_ITPO_ANTIDOTE", 20);
	SetCraftScience("ZEQFRN_ITPO_ANTIDOTE", "�������", 3);
	SetenergyPenalty("ZEQFRN_ITPO_ANTIDOTE", 75);


-- ��������� 1 �������� ������

AddItemCategory ("��������� (�������� ������)", "rc_house_ware_1"); ----- �������� �����
	SetCraftAmount("rc_house_ware_1", 1);
	 AddIngre("rc_house_ware_1", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_1", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_ware_1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_1", 5);
	SetCraftScience("rc_house_ware_1", "���������", 1);
	SetenergyPenalty("rc_house_ware_1", 25);
	SetCraftEXP("rc_house_ware_1", 25)
	SetCraftEXP_SKILL("rc_house_ware_1", "���������")
	
AddItemCategory ("��������� (�������� ������)", "rc_house_ware_3"); ----- ������� ��� ���
	SetCraftAmount("rc_house_ware_3", 1);
	 AddIngre("rc_house_ware_3", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_3", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_ware_3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_3", 5);
	SetCraftScience("rc_house_ware_3", "���������", 1);
	SetenergyPenalty("rc_house_ware_3", 25);
	SetCraftEXP("rc_house_ware_3", 25)
	SetCraftEXP_SKILL("rc_house_ware_3", "���������")
	
AddItemCategory ("��������� (�������� ������)", "rc_house_ware_10"); ----- �������� � ������
	SetCraftAmount("rc_house_ware_10", 1);
	 AddIngre("rc_house_ware_10", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_10", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_ware_10", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_10", 5);
	SetCraftScience("rc_house_ware_10", "���������", 1);
	SetenergyPenalty("rc_house_ware_10", 25);
	SetCraftEXP("rc_house_ware_10", 25)
	SetCraftEXP_SKILL("rc_house_ware_10", "���������")
	
AddItemCategory ("��������� (�������� ������)", "rc_house_ware_4"); ----- �������� �������
	SetCraftAmount("rc_house_ware_4", 1);
	 AddIngre("rc_house_ware_4", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_3", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_ware_4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_4", 5);
	SetCraftScience("rc_house_ware_4", "���������", 1);
	SetenergyPenalty("rc_house_ware_4", 25);
	SetCraftEXP("rc_house_ware_4", 25)
	SetCraftEXP_SKILL("rc_house_ware_4", "���������")
	
AddItemCategory ("��������� (�������� ������)", "rc_house_ware_9"); ----- �������� ��������� � ���������
	SetCraftAmount("rc_house_ware_9", 1);
	 AddIngre("rc_house_ware_9", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_ware_9", "zdpwla_itpl_temp_herb", 5);
	 AddTool("rc_house_ware_9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_ware_9", 5);
	SetCraftScience("rc_house_ware_9", "���������", 1);
	SetenergyPenalty("rc_house_ware_9", 25);
	SetCraftEXP("rc_house_ware_9", 25)
	SetCraftEXP_SKILL("rc_house_ware_9", "���������")

-- ��������� 1 ������� ���������� � �����������
	
AddItemCategory ("��������� (1 �������)", "ooltyb_itmiswordrawhot"); ----- ���������� �����
	SetCraftAmount("ooltyb_itmiswordrawhot", 1);
	 AddIngre("ooltyb_itmiswordrawhot", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("ooltyb_itmiswordrawhot", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("ooltyb_itmiswordrawhot", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmiswordrawhot", 5);
	SetCraftScience("ooltyb_itmiswordrawhot", "���������", 1);
	SetenergyPenalty("ooltyb_itmiswordrawhot", 25);
	SetCraftEXP("ooltyb_itmiswordrawhot", 25)
	SetCraftEXP_SKILL("ooltyb_itmiswordrawhot", "���������")

AddItemCategory ("��������� (1 �������)", "yvnzmz_itmi_bolvanka"); --- �������� ������
	SetCraftAmount("yvnzmz_itmi_bolvanka", 5);
	 AddIngre("yvnzmz_itmi_bolvanka", "ooltyb_itmiswordrawhot", 1);
	 AddTool("yvnzmz_itmi_bolvanka", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yvnzmz_itmi_bolvanka", 5);
	SetCraftScience("yvnzmz_itmi_bolvanka", "���������", 1);
	SetenergyPenalty("yvnzmz_itmi_bolvanka", 25);
	SetCraftEXP("yvnzmz_itmi_bolvanka", 25)
	SetCraftEXP_SKILL("yvnzmz_itmi_bolvanka", "���������")

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1h_Vlk_AxE"); ---- �������
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Axe", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Axe", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_Axe", "���������")	
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1H_Mace_L_04"); ---- ����� �������
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_04", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_04", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Mace_L_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_04", 2);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_04", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_04", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Mace_L_04", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Mace_L_04", "���������")
	
	
--AddItemCategory ("��������� (1 �������)", "ooltyb_itmi_saw"); ---- ����
	--SetCraftAmount("ooltyb_itmi_saw", 1);
	-- AddIngre("ooltyb_itmi_saw", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("ooltyb_itmi_saw", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("ooltyb_itmi_saw", "JKZTZD_ItMw_1H_Mace_L_04");
	--SetCraftPenalty("ooltyb_itmi_saw", 2);
	--SetCraftScience("ooltyb_itmi_saw", "���������", 1);
	--SetenergyPenalty("ooltyb_itmi_saw", 10);
	--SetCraftEXP("ooltyb_itmi_saw", 10)
	--SetCraftEXP_SKILL("ooltyb_itmi_saw", "���������")	


AddItemCategory ("��������� (1 �������)", "jkztzd_itmw_1h_knife_01"); ---- ���
	SetCraftAmount("jkztzd_itmw_1h_knife_01", 1);
	 AddIngre("jkztzd_itmw_1h_knife_01", "ooltyb_itmiswordrawhot", 2);
	 AddTool("jkztzd_itmw_1h_knife_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jkztzd_itmw_1h_knife_01", 2);
	SetCraftScience("jkztzd_itmw_1h_knife_01", "���������", 1);
	SetenergyPenalty("jkztzd_itmw_1h_knife_01", 25);
	SetCraftEXP("jkztzd_itmw_1h_knife_01", 25)
	SetCraftEXP_SKILL("jkztzd_itmw_1h_knife_01", "���������")		

	
-- ��������� 1 ������� ���������� ������ �� 20 �����

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1h_Vlk_DaggeR"); ---- ������
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_DaggeR", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_DaggeR", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_DaggeR", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_DaggeR", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_DaggeR", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_DaggeR", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_DaggeR", "���������")

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1H_Sword_L_03"); ---- ������ ���
	SetCraftAmount("JKZTZD_ItMw_1H_Sword_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Sword_L_03", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Sword_L_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Sword_L_03", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Sword_L_03", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Sword_L_03", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Sword_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Sword_L_03", "���������")
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Nagelkeule2"); ---- ������� ������ � ������
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule2", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule2", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Nagelkeule2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule2", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule2", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule2", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelkeule2", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelkeule2", "���������")
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Sense"); ---- ����� ����
	SetCraftAmount("JKZTZD_ItMw_Sense", 1);
	 AddIngre("JKZTZD_ItMw_Sense", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Sense", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sense", 10);
	SetCraftScience("JKZTZD_ItMw_Sense", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Sense", 25);
	SetCraftEXP("JKZTZD_ItMw_Sense", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Sense", "���������")

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_ShortSword1"); --- �������� ��� ���������
	SetCraftAmount("JKZTZD_ItMw_ShortSword1", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword1", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword1", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword1", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword1", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword1", "���������")


AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_ShortSword2"); --- ������� �������� ���
	SetCraftAmount("JKZTZD_ItMw_ShortSword2", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword2", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword2", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword2", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword2", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword2", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword2", "���������")


AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1h_Vlk_SworD"); ---- �����
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_SworD", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_SworD", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_SworD", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_SworD", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_SworD", "���������")


AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1h_Sld_AxE"); ---- ���������� �����
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_AxE", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_AxE", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1h_Sld_AxE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_AxE", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_AxE", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_AxE", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Sld_AxE", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Sld_AxE", "���������")


AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_ShortSword3"); --- �������� ���
	SetCraftAmount("JKZTZD_ItMw_ShortSword3", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword3", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword3", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword3", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword3", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword3", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword3", "���������")


AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_ShortSword4"); --- ������ ���
	SetCraftAmount("JKZTZD_ItMw_ShortSword4", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword4", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_ShortSword4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword4", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword4", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword4", 25);
	SetCraftEXP("JKZTZD_ItMw_ShortSword4", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword4", "���������")
	

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_SchiffsaxT"); --- ����������� �����
	SetCraftAmount("JKZTZD_ItMw_SchiffsaxT", 1);
     AddIngre("JKZTZD_ItMw_SchiffsaxT", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_SchiffsaxT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_SchiffsaxT", 10);
	SetCraftScience("JKZTZD_ItMw_SchiffsaxT", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_SchiffsaxT", 25);
	SetCraftEXP("JKZTZD_ItMw_SchiffsaxT", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_SchiffsaxT", "���������")
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_1H_Common_01"); --- ������� ���
	SetCraftAmount("JKZTZD_ItMw_1H_Common_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Common_01", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_1H_Common_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Common_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Common_01", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Common_01", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Common_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Common_01", "���������")

AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Folteraxt"); --- ����� ������
	SetCraftAmount("JKZTZD_ItMw_Folteraxt", 1);
     AddIngre("JKZTZD_ItMw_Folteraxt", "ooltyb_itmiswordrawhot", 2);
	 AddTool("JKZTZD_ItMw_Folteraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Folteraxt", 10);
	SetCraftScience("JKZTZD_ItMw_Folteraxt", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Folteraxt", 25);	
	SetCraftEXP("JKZTZD_ItMw_Folteraxt", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Folteraxt", "���������")
	
-- ��������� 1 ������� ��������� ������ �� 30 �����
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_2h_Bau_Axe"); ---- ��������� ����� ��������
	SetCraftAmount("JKZTZD_ItMw_2h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Bau_Axe", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_2h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Bau_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Bau_Axe", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_2h_Bau_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_2h_Bau_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Bau_Axe", "���������")
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_HellebardE");  ---  ��������� ��������
	SetCraftAmount("JKZTZD_ItMw_HellebardE", 1);
     AddIngre("JKZTZD_ItMw_HellebardE", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_HellebardE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_HellebardE", 10);
	SetCraftScience("JKZTZD_ItMw_HellebardE", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_HellebardE", 25);
	SetCraftEXP("JKZTZD_ItMw_HellebardE", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_HellebardE", "���������")
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Stabkeule");  ---  ��������� ������
	SetCraftAmount("JKZTZD_ItMw_Stabkeule", 1);
     AddIngre("JKZTZD_ItMw_Stabkeule", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Stabkeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Stabkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Stabkeule", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Stabkeule", 25);
	SetCraftEXP("JKZTZD_ItMw_Stabkeule", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Stabkeule", "���������")	
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Zweihaender1"); ---- ������ ��������� ���
	SetCraftAmount("JKZTZD_ItMw_Zweihaender1", 1);
     AddIngre("JKZTZD_ItMw_Zweihaender1", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Zweihaender1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender1", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender1", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender1", 25);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender1", "���������")		
	
AddItemCategory ("��������� (1 �������)", "JKZTZD_ItMw_Streitaxt1"); --- ������ ��������� �����
	SetCraftAmount("JKZTZD_ItMw_Streitaxt1", 1);
     AddIngre("JKZTZD_ItMw_Streitaxt1", "ooltyb_itmiswordrawhot", 3);
	 AddTool("JKZTZD_ItMw_Streitaxt1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt1", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt1", "���������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt1", 25);
	SetCraftEXP("JKZTZD_ItMw_Streitaxt1", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitaxt1", "���������")		

	
-- ��������� 2 ������� ����������

AddItemCategory ("��������� (2 �������)", "ooltyb_itmiswordblade"); ----- ������
	SetCraftAmount("ooltyb_itmiswordblade", 1);
	 AddIngre("ooltyb_itmiswordblade", "ooltyb_itmiswordrawhot", 2);
	 AddTool("ooltyb_itmiswordblade", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmiswordblade", 10);
	SetCraftScience("ooltyb_itmiswordblade", "���������", 2);
	SetenergyPenalty("ooltyb_itmiswordblade", 50);
	SetCraftEXP("ooltyb_itmiswordblade", 50)
	SetCraftEXP_SKILL("ooltyb_itmiswordblade", "���������")
	
AddItemCategory ("��������� (2 �������)", "ooltyb_itmi_m_wire"); ----- ���������
	SetCraftAmount("ooltyb_itmi_m_wire", 1);
	 AddIngre("ooltyb_itmi_m_wire", "ooltyb_itmiswordrawhot", 1);
	 AddTool("ooltyb_itmi_m_wire", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmi_m_wire", 10);
	SetCraftScience("ooltyb_itmi_m_wire", "���������", 2);
	SetenergyPenalty("ooltyb_itmi_m_wire", 50);
	SetCraftEXP("ooltyb_itmi_m_wire", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_m_wire", "���������")
	
-- ��������� 2 ������� ���������� ������ 30 �����
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Franciss"); ---- ������� ������
	SetCraftAmount("JKZTZD_ItMw_Franciss", 1);
	 AddIngre("JKZTZD_ItMw_Franciss", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Franciss", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Franciss", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Franciss", 10);
	SetCraftScience("JKZTZD_ItMw_Franciss", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Franciss", 50);
	SetCraftEXP("JKZTZD_ItMw_Franciss", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Franciss", "���������")

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_ShortSword5"); ---- ���������� �������� ���
	SetCraftAmount("JKZTZD_ItMw_ShortSword5", 1);
	 AddIngre("JKZTZD_ItMw_ShortSword5", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_ShortSword5", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_ShortSword5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ShortSword5", 10);
	SetCraftScience("JKZTZD_ItMw_ShortSword5", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_ShortSword5", 50);
	SetCraftEXP("JKZTZD_ItMw_ShortSword5", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ShortSword5", "���������")
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_1h_Mil_SworD"); --- ������ �����
	SetCraftAmount("JKZTZD_ItMw_1h_Mil_SworD", 1);
	 AddIngre("JKZTZD_ItMw_1h_Mil_SworD", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1h_Mil_SworD", "ooltyb_itmi_t_leather", 1);	 
	 AddTool("JKZTZD_ItMw_1h_Mil_SworD", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Mil_SworD", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Mil_SworD", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Mil_SworD", 50);
	SetCraftEXP("JKZTZD_ItMw_1h_Mil_SworD", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Mil_SworD", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_1h_Sld_Sword"); --- ������� ���
	SetCraftAmount("JKZTZD_ItMw_1h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Sld_Sword", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1h_Sld_Sword", "ooltyb_itmi_t_leather", 1);	 	 
	 AddTool("JKZTZD_ItMw_1h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_1h_Sld_Sword", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_1h_Sld_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_1h_Sld_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Sld_Sword", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Kriegskeule"); --- ������� ������
	SetCraftAmount("JKZTZD_ItMw_Kriegskeule", 1);
	 AddIngre("JKZTZD_ItMw_Kriegskeule", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Kriegskeule", "ooltyb_itmi_t_leather", 1);	 
	 AddTool("JKZTZD_ItMw_Kriegskeule", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegskeule", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegskeule", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegskeule", 50);
	SetCraftEXP("JKZTZD_ItMw_Kriegskeule", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegskeule", "���������")	 

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Kriegshammer1"); --- ������ �����
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer1", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer1", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Kriegshammer1", "ooltyb_itmi_t_leather", 1);	
	 AddTool("JKZTZD_ItMw_Kriegshammer1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer1", 10);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer1", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer1", 50);
	SetCraftEXP("JKZTZD_ItMw_Kriegshammer1", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegshammer1", "���������")		

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Piratensaebel"); --- ��������� ���������� �����
	SetCraftAmount("JKZTZD_ItMw_Piratensaebel", 1);
	 AddIngre("JKZTZD_ItMw_Piratensaebel", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Piratensaebel", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Piratensaebel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Piratensaebel", 10);
	SetCraftScience("JKZTZD_ItMw_Piratensaebel", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Piratensaebel", 50);
	SetCraftEXP("JKZTZD_ItMw_Piratensaebel", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Piratensaebel", "���������")		
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Schwert"); --- ������ ������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert", 1);
	 AddIngre("JKZTZD_ItMw_Schwert", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert", "���������")		

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Steinbrecher"); --- ��������� ������
	SetCraftAmount("JKZTZD_ItMw_Steinbrecher", 1);
	 AddIngre("JKZTZD_ItMw_Steinbrecher", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Steinbrecher", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Steinbrecher", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Steinbrecher", 10);
	SetCraftScience("JKZTZD_ItMw_Steinbrecher", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Steinbrecher", 50);
	SetCraftEXP("JKZTZD_ItMw_Steinbrecher", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Steinbrecher", "���������")		
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Spicker"); --- ������������� �������
	SetCraftAmount("JKZTZD_ItMw_Spicker", 1);
	 AddIngre("JKZTZD_ItMw_Spicker", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Spicker", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Spicker", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Spicker", 10);
	SetCraftScience("JKZTZD_ItMw_Spicker", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Spicker", 50);
	SetCraftEXP("JKZTZD_ItMw_Spicker", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Spicker", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Schwert1"); --- ���������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert1", 1);
	 AddIngre("JKZTZD_ItMw_Schwert1", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert1", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert1", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert1", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert1", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert1", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert1", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Schwert2"); --- ������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert2", 1);
	 AddIngre("JKZTZD_ItMw_Schwert2", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert2", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert2", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert2", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert2", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Schwert3"); --- ������ ���������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert3", 1);
	 AddIngre("JKZTZD_ItMw_Schwert3", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Schwert3", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schwert3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert3", 10);
	SetCraftScience("JKZTZD_ItMw_Schwert3", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schwert3", 50);
	SetCraftEXP("JKZTZD_ItMw_Schwert3", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert3", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Rapier"); --- ������
	SetCraftAmount("JKZTZD_ItMw_Rapier", 1);
	 AddIngre("JKZTZD_ItMw_Rapier", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Rapier", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Rapier", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rapier", 10);
	SetCraftScience("JKZTZD_ItMw_Rapier", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rapier", 50);
	SetCraftEXP("JKZTZD_ItMw_Rapier", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rapier", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Rubinklinge"); --- ��������� ������
	SetCraftAmount("JKZTZD_ItMw_Rubinklinge", 1);
	 AddIngre("JKZTZD_ItMw_Rubinklinge", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Rubinklinge", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Rubinklinge", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rubinklinge", 10);
	SetCraftScience("JKZTZD_ItMw_Rubinklinge", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Rubinklinge", 50);
	SetCraftEXP("JKZTZD_ItMw_Rubinklinge", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rubinklinge", "���������")	

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_1H_Special_01"); --- ������� ������ ���
	SetCraftAmount("JKZTZD_ItMw_1H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_01", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_01", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_1H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_01", 10);
	SetCraftScience("JKZTZD_ItMw_1H_Special_01", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_01", 50);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_01", "���������")		
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Addon_PIR1hm"); --- ���������� ���
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR1hm", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hm", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMw_Addon_PIR1hm", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Addon_PIR1hm", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR1hm", 10);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR1hm", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR1hm", 50);
	SetCraftEXP("JKZTZD_ItMw_Addon_PIR1hm", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_PIR1hm", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMW_Hacker_01"); --- ������
	SetCraftAmount("JKZTZD_ItMW_Hacker_01", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_01", "ooltyb_itmiswordrawhot", 4);
	 AddIngre("JKZTZD_ItMW_Hacker_01", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMW_Hacker_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_01", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_01", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_01", 50);
	SetCraftEXP("JKZTZD_ItMW_Hacker_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Hacker_01", "���������")	

-- ��������� 2 ������� ��������� ������ �� 40 �����

AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_2h_Sld_Axe"); --- ���������� ��������� �����
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Axe", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Axe", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Axe", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Sld_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Axe", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Axe", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Axe", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Sld_Axe", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Sld_Axe", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_2h_Sld_Sword"); --- ���������� ��������� ���
	SetCraftAmount("JKZTZD_ItMw_2h_Sld_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Sword", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Sld_Sword", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Sld_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Sld_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Sld_Sword", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Sld_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Sld_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Sld_Sword", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_2h_Pal_Sword"); --- ���������� ��������� ���
	SetCraftAmount("JKZTZD_ItMw_2h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_2h_Pal_Sword", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_2h_Pal_Sword", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_2h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2h_Pal_Sword", 10);
	SetCraftScience("JKZTZD_ItMw_2h_Pal_Sword", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_2h_Pal_Sword", 50);
	SetCraftEXP("JKZTZD_ItMw_2h_Pal_Sword", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2h_Pal_Sword", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Zweihaender2"); --- ��������� ���
	SetCraftAmount("JKZTZD_ItMw_Zweihaender2", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender2", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Zweihaender2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender2", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender2", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender2", 50);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender2", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Streitaxt2"); --- ��������� ������ �����
	SetCraftAmount("JKZTZD_ItMw_Streitaxt2", 1);
	 AddIngre("JKZTZD_ItMw_Streitaxt2", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Streitaxt2", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Streitaxt2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitaxt2", 10);
	SetCraftScience("JKZTZD_ItMw_Streitaxt2", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Streitaxt2", 50);
	SetCraftEXP("JKZTZD_ItMw_Streitaxt2", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitaxt2", "���������")		
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Zweihaender4"); --- ������� ��������� ���
	SetCraftAmount("JKZTZD_ItMw_Zweihaender4", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender4", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Zweihaender4", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender4", 10);
	SetCraftScience("JKZTZD_ItMw_Zweihaender4", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender4", 50);
	SetCraftEXP("JKZTZD_ItMw_Zweihaender4", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Zweihaender4", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMw_Schlachtaxt"); --- ��������� ������� �����
	SetCraftAmount("JKZTZD_ItMw_Schlachtaxt", 1);
	 AddIngre("JKZTZD_ItMw_Schlachtaxt", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMw_Schlachtaxt", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMw_Schlachtaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schlachtaxt", 10);
	SetCraftScience("JKZTZD_ItMw_Schlachtaxt", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Schlachtaxt", 50);
	SetCraftEXP("JKZTZD_ItMw_Schlachtaxt", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schlachtaxt", "���������")	
	
AddItemCategory ("��������� (2 �������)", "JKZTZD_ItMW_Hacker_03"); --- ���������� ������
	SetCraftAmount("JKZTZD_ItMW_Hacker_03", 1);
	 AddIngre("JKZTZD_ItMW_Hacker_03", "ooltyb_itmiswordrawhot", 5);
	 AddIngre("JKZTZD_ItMW_Hacker_03", "ooltyb_itmi_t_leather", 1);
	 AddTool("JKZTZD_ItMW_Hacker_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMW_Hacker_03", 10);
	SetCraftScience("JKZTZD_ItMW_Hacker_03", "���������", 2);
	SetenergyPenalty("JKZTZD_ItMW_Hacker_03", 50);
	SetCraftEXP("JKZTZD_ItMW_Hacker_03", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Hacker_03", "���������")	

	
-- ��������� 3 ������� ���������� ������ �� 40 �����
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Morgenstern"); --- ������ � ������
	SetCraftAmount("JKZTZD_ItMw_Morgenstern", 1);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Morgenstern", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Morgenstern", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Morgenstern", 20);
	SetCraftScience("JKZTZD_ItMw_Morgenstern", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Morgenstern", 75);
	SetCraftEXP("JKZTZD_ItMw_Morgenstern", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Morgenstern", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Doppelaxt"); --- ������� �����
	SetCraftAmount("JKZTZD_ItMw_Doppelaxt", 1);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Doppelaxt", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Doppelaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Doppelaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Doppelaxt", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Doppelaxt", 75);	
	SetCraftEXP("JKZTZD_ItMw_Doppelaxt", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Doppelaxt", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_1h_Pal_Sword"); --- ��� �������
	SetCraftAmount("JKZTZD_ItMw_1h_Pal_Sword", 1);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1h_Pal_Sword", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1h_Pal_Sword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Pal_Sword", 20);
	SetCraftScience("JKZTZD_ItMw_1h_Pal_Sword", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_1h_Pal_Sword", 75);	
	SetCraftEXP("JKZTZD_ItMw_1h_Pal_Sword", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Pal_Sword", "���������")	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Bartaxt"); --- �������� ������
	SetCraftAmount("JKZTZD_ItMw_Bartaxt", 1);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Bartaxt", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Bartaxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Bartaxt", 20);
	SetCraftScience("JKZTZD_ItMw_Bartaxt", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Bartaxt", 75);		
	SetCraftEXP("JKZTZD_ItMw_Bartaxt", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Bartaxt", "���������")

AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Schwert4"); --- ���������� ������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert4", 1);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Schwert4", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Schwert4", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert4", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert4", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert4", 75);			
	SetCraftEXP("JKZTZD_ItMw_Schwert4", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert4", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Streitkolben"); --- ������
	SetCraftAmount("JKZTZD_ItMw_Streitkolben", 1);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Streitkolben", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Streitkolben", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Streitkolben", 20);
	SetCraftScience("JKZTZD_ItMw_Streitkolben", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Streitkolben", 75);	
	SetCraftEXP("JKZTZD_ItMw_Streitkolben", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Streitkolben", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Runenschwert"); --- ������ ���
	SetCraftAmount("JKZTZD_ItMw_Runenschwert", 1);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Runenschwert", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Runenschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Runenschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Runenschwert", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Runenschwert", 75);	
	SetCraftEXP("JKZTZD_ItMw_Runenschwert", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Runenschwert", "���������")	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Rabenschnabel"); --- ���� ������
	SetCraftAmount("JKZTZD_ItMw_Rabenschnabel", 1);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Rabenschnabel", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Rabenschnabel", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Rabenschnabel", 20);
	SetCraftScience("JKZTZD_ItMw_Rabenschnabel", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Rabenschnabel", 75);
	SetCraftEXP("JKZTZD_ItMw_Rabenschnabel", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Rabenschnabel", "���������")	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Schwert5"); --- ���������� ���������� ���
	SetCraftAmount("JKZTZD_ItMw_Schwert5", 1);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Schwert5", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Schwert5", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Schwert5", 20);
	SetCraftScience("JKZTZD_ItMw_Schwert5", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Schwert5", 75);
	SetCraftEXP("JKZTZD_ItMw_Schwert5", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Schwert5", "���������")	

AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Inquisitor"); --- ����������
	SetCraftAmount("JKZTZD_ItMw_Inquisitor", 1);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Inquisitor", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Inquisitor", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Inquisitor", 20);
	SetCraftScience("JKZTZD_ItMw_Inquisitor", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Inquisitor", 75);	
	SetCraftEXP("JKZTZD_ItMw_Inquisitor", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Inquisitor", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_ElBastardo"); --- ���-��������
	SetCraftAmount("JKZTZD_ItMw_ElBastardo", 1);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_ElBastardo", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_ElBastardo", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_ElBastardo", 20);
	SetCraftScience("JKZTZD_ItMw_ElBastardo", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_ElBastardo", 75);		
	SetCraftEXP("JKZTZD_ItMw_ElBastardo", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_ElBastardo", "���������")	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Kriegshammer2"); --- ������� ������ �����
	SetCraftAmount("JKZTZD_ItMw_Kriegshammer2", 1);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Kriegshammer2", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Kriegshammer2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Kriegshammer2", 20);
	SetCraftScience("JKZTZD_ItMw_Kriegshammer2", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Kriegshammer2", 75);
	SetCraftEXP("JKZTZD_ItMw_Kriegshammer2", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Kriegshammer2", "���������")		
	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Meisterdegen"); --- ����� �������
	SetCraftAmount("JKZTZD_ItMw_Meisterdegen", 1);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Meisterdegen", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Meisterdegen", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Meisterdegen", 20);
	SetCraftScience("JKZTZD_ItMw_Meisterdegen", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Meisterdegen", 75);	
	SetCraftEXP("JKZTZD_ItMw_Meisterdegen", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Meisterdegen", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Orkschlaecht"); --- ������ �����
	SetCraftAmount("JKZTZD_ItMw_Orkschlaecht", 1);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Orkschlaecht", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Orkschlaecht", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Orkschlaecht", 20);
	SetCraftScience("JKZTZD_ItMw_Orkschlaecht", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Orkschlaecht", 75);	
	SetCraftEXP("JKZTZD_ItMw_Orkschlaecht", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Orkschlaecht", "���������")		
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_1H_Blessed_01"); --- ���������� ������ ������
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_01", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_01", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_01", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Blessed_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Blessed_01", "���������")		
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_1H_Special_02"); --- ���������� ������ ���
	SetCraftAmount("JKZTZD_ItMw_1H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Special_02", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_02", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_02", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_02", "���������")			
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_1H_Special_03"); --- ������ ������ ������
	SetCraftAmount("JKZTZD_ItMw_1H_Special_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_1H_Special_03", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_1H_Special_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Special_03", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Special_03", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_1H_Special_03", 75);
	SetCraftEXP("JKZTZD_ItMw_1H_Special_03", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Special_03", "���������")	
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Addon_Betty"); --- �����
	SetCraftAmount("JKZTZD_ItMw_Addon_Betty", 1);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmiswordblade", 4);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Addon_Betty", "ooltyb_itmi_t_leather", 2);
	 AddTool("JKZTZD_ItMw_Addon_Betty", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_Betty", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_Betty", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_Betty", 75);
	SetCraftEXP("JKZTZD_ItMw_Addon_Betty", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_Betty", "���������")

-- ��������� 3 ������� ��������� ������ �� 50 �����

AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Krummschwert"); --- ��������� ���������� �����
	SetCraftAmount("JKZTZD_ItMw_Krummschwert", 1);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Krummschwert", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Krummschwert", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Krummschwert", 20);
	SetCraftScience("JKZTZD_ItMw_Krummschwert", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Krummschwert", 75);
	SetCraftEXP("JKZTZD_ItMw_Krummschwert", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Krummschwert", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_2H_Special_01"); --- ��������� ����������� ������
	SetCraftAmount("JKZTZD_ItMw_2H_Special_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Special_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Special_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_01", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_01", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Special_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Special_01", "���������")
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Sturmbringer"); --- ��������� ������ ����
	SetCraftAmount("JKZTZD_ItMw_Sturmbringer", 1);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Sturmbringer", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Sturmbringer", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Sturmbringer", 20);
	SetCraftScience("JKZTZD_ItMw_Sturmbringer", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Sturmbringer", 75);
	SetCraftEXP("JKZTZD_ItMw_Sturmbringer", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Sturmbringer", "���������")

AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_2H_Blessed_01"); --- ��������� ������ ������ ������
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Blessed_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_01", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_01", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_01", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Blessed_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Blessed_01", "���������")

AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_2H_Blessed_02"); --- ��������� ��� ������
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_02", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_02", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Blessed_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Blessed_02", "���������")		
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_2H_Special_02"); --- ������� ������ ���������
	SetCraftAmount("JKZTZD_ItMw_2H_Special_02", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_2H_Special_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_2H_Special_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_02", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_02", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_02", 75);
	SetCraftEXP("JKZTZD_ItMw_2H_Special_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Special_02", "���������")		
	
AddItemCategory ("��������� (3 �������)", "JKZTZD_ItMw_Addon_PIR2hAx"); --- ��������� ��������� �����
	SetCraftAmount("JKZTZD_ItMw_Addon_PIR2hAx", 1);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmiswordblade", 5);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmi_nail", 3);
	 AddIngre("JKZTZD_ItMw_Addon_PIR2hAx", "ooltyb_itmi_whool_holst", 2);
	 AddTool("JKZTZD_ItMw_Addon_PIR2hAx", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 20);
	SetCraftScience("JKZTZD_ItMw_Addon_PIR2hAx", "���������", 3);
	SetenergyPenalty("JKZTZD_ItMw_Addon_PIR2hAx", 75);
	SetCraftEXP("JKZTZD_ItMw_Addon_PIR2hAx", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Addon_PIR2hAx", "���������")		
	
AddItemCategory ("��������� (3 �������)", "itmw_2h_molotzac_02"); --- ��������� ����� ������ ������
	SetCraftAmount("itmw_2h_molotzac_02", 1);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmiswordblade", 5);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmi_nail", 3);
	 AddIngre("itmw_2h_molotzac_02", "ooltyb_itmi_whool_holst", 2);
	 AddTool("itmw_2h_molotzac_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itmw_2h_molotzac_02", 20);
	SetCraftScience("itmw_2h_molotzac_02", "���������", 3);
	SetenergyPenalty("itmw_2h_molotzac_02", 75);
	SetCraftEXP("itmw_2h_molotzac_02", 75)
	SetCraftEXP_SKILL("itmw_2h_molotzac_02", "���������")		
	
AddItemCategory ("��������� (3 �������)", "itmw_2h_molotzac_01"); --- ��������� ������ ������ ������
	SetCraftAmount("itmw_2h_molotzac_01", 1);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmiswordblade", 5);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmi_nail", 3);
	 AddIngre("itmw_2h_molotzac_01", "ooltyb_itmi_whool_holst", 2);
	 AddTool("itmw_2h_molotzac_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itmw_2h_molotzac_01", 20);
	SetCraftScience("itmw_2h_molotzac_01", "���������", 3);
	SetenergyPenalty("itmw_2h_molotzac_01", 75);
	SetCraftEXP("itmw_2h_molotzac_01", 75)
	SetCraftEXP_SKILL("itmw_2h_molotzac_01", "���������")	
	
-- ��������� 4 ������� ���������� ������ �� 60 �����

AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_1H_Blessed_02"); --- ���������� ������ ������
	SetCraftAmount("JKZTZD_ItMw_1H_Blessed_02", 1);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_ItMw_1H_Blessed_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_1H_Blessed_02", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1H_Blessed_02", 20);
	SetCraftScience("JKZTZD_ItMw_1H_Blessed_02", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_1H_Blessed_02", 100);		
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_mace"); --- ������ ������
	SetCraftAmount("JKZTZD_mace", 1);
	 AddIngre("JKZTZD_mace", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_mace", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_mace", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_mace", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_mace", 20);
	SetCraftScience("JKZTZD_mace", "���������", 4);
	SetenergyPenalty("JKZTZD_mace", 100);	
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_mastersword"); --- ��� �������
	SetCraftAmount("JKZTZD_mastersword", 1);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmiswordblade", 15);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_mastersword", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("JKZTZD_mastersword", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_mastersword", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_mastersword", 20);
	SetCraftScience("JKZTZD_mastersword", "���������", 4);
	SetenergyPenalty("JKZTZD_mastersword", 100);	
	
AddItemCategory ("��������� (4 �������)", "jkztzd_itmw_1h_special_04"); --- ������ ��������
	SetCraftAmount("jkztzd_itmw_1h_special_04", 1);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmiswordblade", 15);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "ooltyb_itmi_alchemy_syrianoil_01", 7);
	 AddIngre("jkztzd_itmw_1h_special_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_1h_special_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jkztzd_itmw_1h_special_04", 20);
	SetCraftScience("jkztzd_itmw_1h_special_04", "���������", 4);
	SetenergyPenalty("jkztzd_itmw_1h_special_04", 100);	

-- ��������� 4 ������� ��������� ������ �� 70 �����

AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_Zweihaender3"); --- ���� ��� (���������)
	SetCraftAmount("JKZTZD_ItMw_Zweihaender3", 1);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Zweihaender3", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Zweihaender3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Zweihaender3", 20);
	SetCraftScience("JKZTZD_ItMw_Zweihaender3", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_Zweihaender3", 100);
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_Drachenschne"); --- ��������� ������ ��������
	SetCraftAmount("JKZTZD_ItMw_Drachenschne", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne", 100);	
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_2H_Blessed_03"); --- ��������� ������ �����
	SetCraftAmount("JKZTZD_ItMw_2H_Blessed_03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Blessed_03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Blessed_03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Blessed_03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Blessed_03", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Blessed_03", 100);	
	
		
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_2H_Special03"); --- ��������� ������ ������ ������
	SetCraftAmount("JKZTZD_ItMw_2H_Special03", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special03", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special03", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special03", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special03", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special03", 100);	
	
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_2H_Special_04"); --- ��������� ������ ��������
	SetCraftAmount("JKZTZD_ItMw_2H_Special_04", 1);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_2H_Special_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_2H_Special_04", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Special_04", 20);
	SetCraftScience("JKZTZD_ItMw_2H_Special_04", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_2H_Special_04", 100);	
	
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_Drachenschne1"); --- ��������� ��� ��������
	SetCraftAmount("JKZTZD_ItMw_Drachenschne1", 1);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Drachenschne1", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Drachenschne1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Drachenschne1", 20);
	SetCraftScience("JKZTZD_ItMw_Drachenschne1", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_Drachenschne1", 100);	
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_Barbarenstr"); --- ��������� ����� ��������
	SetCraftAmount("JKZTZD_ItMw_Barbarenstr", 1);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Barbarenstr", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Barbarenstr", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Barbarenstr", 20);
	SetCraftScience("JKZTZD_ItMw_Barbarenstr", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_Barbarenstr", 100);		
	
AddItemCategory ("��������� (4 �������)", "JKZTZD_ItMw_Berserkeraxt"); --- ��������� ����� ����������
	SetCraftAmount("JKZTZD_ItMw_Berserkeraxt", 1);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmiswordblade", 16);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_t_leather", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "ooltyb_itmi_nail", 7);
	 AddIngre("JKZTZD_ItMw_Berserkeraxt", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItMw_Berserkeraxt", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_Berserkeraxt", 20);
	SetCraftScience("JKZTZD_ItMw_Berserkeraxt", "���������", 4);
	SetenergyPenalty("JKZTZD_ItMw_Berserkeraxt", 100);	


-- ������� 1 �������� ������

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_TABLE_LOW"); --- ������ ����
	SetCraftAmount("RC_HOUSE_TABLE_LOW", 1);
	 AddIngre("RC_HOUSE_TABLE_LOW", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_TABLE_LOW", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_TABLE_LOW", 5);
	SetCraftScience("RC_HOUSE_TABLE_LOW", "�������", 1);
	SetenergyPenalty("RC_HOUSE_TABLE_LOW", 25);
	SetCraftEXP("RC_HOUSE_TABLE_LOW", 25)
	SetCraftEXP_SKILL("RC_HOUSE_TABLE_LOW", "�������")	
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_TABLE_POOR"); --- ������� ����
	SetCraftAmount("RC_HOUSE_TABLE_POOR", 1);
	 AddIngre("RC_HOUSE_TABLE_POOR", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_TABLE_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_TABLE_POOR", 5);
	SetCraftScience("RC_HOUSE_TABLE_POOR", "�������", 1);
	SetenergyPenalty("RC_HOUSE_TABLE_POOR", 25);
	SetCraftEXP("RC_HOUSE_TABLE_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_TABLE_POOR", "�������")	
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CUPBOARD_POOR"); --- ������� ����
	SetCraftAmount("RC_HOUSE_CUPBOARD_POOR", 1);
	 AddIngre("RC_HOUSE_CUPBOARD_POOR", "OOLTYB_ITMI_WOOD", 25);
	 AddTool("RC_HOUSE_CUPBOARD_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_CUPBOARD_POOR", 5);
	SetCraftScience("RC_HOUSE_CUPBOARD_POOR", "�������", 1);
	SetenergyPenalty("RC_HOUSE_CUPBOARD_POOR", 25);
	SetCraftEXP("RC_HOUSE_CUPBOARD_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_CUPBOARD_POOR", "�������")

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CUPBOARDLOW_POOR"); --- ������� �����
	SetCraftAmount("RC_HOUSE_CUPBOARDLOW_POOR", 1);
	 AddIngre("RC_HOUSE_CUPBOARDLOW_POOR", "OOLTYB_ITMI_WOOD", 25);
	 AddTool("RC_HOUSE_CUPBOARDLOW_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_CUPBOARDLOW_POOR", 5);
	SetCraftScience("RC_HOUSE_CUPBOARDLOW_POOR", "�������", 1);
	SetenergyPenalty("RC_HOUSE_CUPBOARDLOW_POOR", 25);
	SetCraftEXP("RC_HOUSE_CUPBOARDLOW_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_CUPBOARDLOW_POOR", "�������")

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_LOWCHAIR_POOR"); --- ������� �������
	SetCraftAmount("RC_HOUSE_LOWCHAIR_POOR", 1);
	 AddIngre("RC_HOUSE_LOWCHAIR_POOR", "OOLTYB_ITMI_WOOD", 15);
	 AddTool("RC_HOUSE_LOWCHAIR_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_LOWCHAIR_POOR", 5);
	SetCraftScience("RC_HOUSE_LOWCHAIR_POOR", "�������", 1);
	SetenergyPenalty("RC_HOUSE_LOWCHAIR_POOR", 25);
	SetCraftEXP("RC_HOUSE_LOWCHAIR_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_LOWCHAIR_POOR", "�������")
	
--AddItemCategory ("������� (�������� ������)", "RC_HOUSE_SHELFBIG"); --- ������� �����
	--SetCraftAmount("RC_HOUSE_SHELFBIG", 1);
	-- AddIngre("RC_HOUSE_SHELFBIG", "OOLTYB_ITMI_OBRABOTDER", 1);
	-- AddTool("RC_HOUSE_SHELFBIG", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_SHELFBIG", 5);
	--SetCraftScience("RC_HOUSE_SHELFBIG", "�������", 1);
	--SetenergyPenalty("RC_HOUSE_SHELFBIG", 25);
	--SetCraftEXP("RC_HOUSE_SHELFBIG", 25)
--	SetCraftEXP_SKILL("RC_HOUSE_SHELFBIG", "�������")
	
-- AddItemCategory ("������� (�������� ������)", "RC_HOUSE_SHELFWALL_1"); --- ��������� �����
	-- SetCraftAmount("RC_HOUSE_SHELFWALL_1", 1);
	-- AddIngre("RC_HOUSE_SHELFWALL_1", "OOLTYB_ITMI_WOOD", 15);
	-- AddTool("RC_HOUSE_SHELFWALL_1", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_SHELFWALL_1", 5);
	--SetCraftScience("RC_HOUSE_SHELFWALL_1", "�������", 1);
	--SetenergyPenalty("RC_HOUSE_SHELFWALL_1", 15);
	--SetCraftEXP("RC_HOUSE_SHELFWALL_1", 15)
	--SetCraftEXP_SKILL("RC_HOUSE_SHELFWALL_1", "�������")

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_LOWCHAIR_WOOD"); --- �����
	SetCraftAmount("RC_HOUSE_LOWCHAIR_WOOD", 1);
	 AddIngre("RC_HOUSE_LOWCHAIR_WOOD", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("RC_HOUSE_LOWCHAIR_WOOD", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_LOWCHAIR_WOOD", 5);
	SetCraftScience("RC_HOUSE_LOWCHAIR_WOOD", "�������", 1);
	SetenergyPenalty("RC_HOUSE_LOWCHAIR_WOOD", 25);
	SetCraftEXP("RC_HOUSE_LOWCHAIR_WOOD", 25)
	SetCraftEXP_SKILL("RC_HOUSE_LOWCHAIR_WOOD", "�������")
	
--AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CREATE_1"); --- ������� ����
	--SetCraftAmount("RC_HOUSE_CREATE_1", 1);
	-- AddIngre("RC_HOUSE_CREATE_1", "OOLTYB_ITMI_WOOD", 15);
	-- AddTool("RC_HOUSE_CREATE_1", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_CREATE_1", 5);
	--SetCraftScience("RC_HOUSE_CREATE_1", "�������", 1);
	--SetenergyPenalty("RC_HOUSE_CREATE_1", 25);
	--SetCraftEXP("RC_HOUSE_CREATE_1", 25)
	--SetCraftEXP_SKILL("RC_HOUSE_CREATE_1", "�������")	
	
--AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CREATE_3"); --- ����� ����
	--SetCraftAmount("RC_HOUSE_CREATE_3", 1);
	-- AddIngre("RC_HOUSE_CREATE_3", "OOLTYB_ITMI_WOOD", 10);
	-- AddTool("RC_HOUSE_CREATE_3", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("RC_HOUSE_CREATE_3", 5);
--	SetCraftScience("RC_HOUSE_CREATE_3", "�������", 1);
--	SetenergyPenalty("RC_HOUSE_CREATE_3", 25);
	--SetCraftEXP("RC_HOUSE_CREATE_3", 25)
	--SetCraftEXP_SKILL("RC_HOUSE_CREATE_3", "�������")	
	

AddItemCategory ("������� (�������� ������)", "ooltyb_itmi_chest1"); --- ������
	SetCraftAmount("ooltyb_itmi_chest1", 1);
	 AddIngre("ooltyb_itmi_chest1", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("ooltyb_itmi_chest1", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest1", 5);
	SetCraftScience("ooltyb_itmi_chest1", "�������", 1);
	SetenergyPenalty("ooltyb_itmi_chest1", 25);
	SetCraftEXP("ooltyb_itmi_chest1", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest1", "�������")	
	
AddItemCategory ("������� (�������� ������)", "ooltyb_itmi_chest2"); --- ������� ������
	SetCraftAmount("ooltyb_itmi_chest2", 1);
	 AddIngre("ooltyb_itmi_chest2", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddIngre("ooltyb_itmi_chest2", "yvnzmz_itmi_zamok", 1);
	 AddTool("ooltyb_itmi_chest2", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest2", 5);
	SetCraftScience("ooltyb_itmi_chest2", "�������", 2);
	SetenergyPenalty("ooltyb_itmi_chest2", 25);
	SetCraftEXP("ooltyb_itmi_chest2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest2", "�������")
	
AddItemCategory ("������� (�������� ������)", "ooltyb_itmi_chest3"); --- ������� ������
	SetCraftAmount("ooltyb_itmi_chest3", 1);
	 AddIngre("ooltyb_itmi_chest3", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddIngre("ooltyb_itmi_chest3", "yvnzmz_itmi_zamok", 1);
	 AddTool("ooltyb_itmi_chest3", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_chest3", 5);
	SetCraftScience("ooltyb_itmi_chest3", "�������", 3);
	SetenergyPenalty("ooltyb_itmi_chest3", 25);
	SetCraftEXP("ooltyb_itmi_chest3", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_chest3", "�������")	

-- ������� ����������

--AddItemCategory ("������� (1 �������)", "ZDPWLA_ITMI_BUCKET"); ---- �����
	--SetCraftAmount("ZDPWLA_ITMI_BUCKET", 1);
	-- AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("ZDPWLA_ITMI_BUCKET", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("ZDPWLA_ITMI_BUCKET", "JKZTZD_ItMw_1h_Vlk_AxE");
	--SetCraftPenalty("ZDPWLA_ITMI_BUCKET", 2);
	--SetCraftScience("ZDPWLA_ITMI_BUCKET", "�������", 1);
	--SetenergyPenalty("ZDPWLA_ITMI_BUCKET", 10);
	--SetCraftEXP("ZDPWLA_ITMI_BUCKET", 10)
	--SetCraftEXP_SKILL("ZDPWLA_ITMI_BUCKET", "�������")

AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_OBRABOTDER"); --- ������������ ���������
	SetCraftAmount("OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ItMi_Coal", 5);
	 AddAlterIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ITAT_CRAWLERPLATE", 10);
	 AddAlterIngre("OOLTYB_ITMI_OBRABOTDER", "OOLTYB_ItMi_Coal", 5);
	 AddTool("OOLTYB_ITMI_OBRABOTDER", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_OBRABOTDER", 5);
	SetCraftScience("OOLTYB_ITMI_OBRABOTDER", "�������", 1);
	SetenergyPenalty("OOLTYB_ITMI_OBRABOTDER", 25);
	SetCraftEXP("OOLTYB_ITMI_OBRABOTDER", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_OBRABOTDER", "�������")

AddItemCategory ("������� (1 �������)", "OOLTYB_ItMi_FlasK"); --- ��������
	SetCraftAmount("OOLTYB_ItMi_FlasK", 40);
	 AddIngre("OOLTYB_ItMi_FlasK", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("OOLTYB_ItMi_FlasK", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_FlasK", 5);
	SetCraftScience("OOLTYB_ItMi_FlasK", "�������", 1);
	SetenergyPenalty("OOLTYB_ItMi_FlasK", 25);
	SetCraftEXP("OOLTYB_ItMi_FlasK", 25)
	SetCraftEXP_SKILL("OOLTYB_ItMi_FlasK", "�������")
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Arrow"); --- ������
	SetCraftAmount("JKZTZD_ItRw_Arrow", 40);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ITMI_WOOD", 5);
	 AddIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Iron", 5);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "jkztzd_itmw_1h_bau_mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Arrow", "OOLTYB_ItMi_Iron", 5);
	 AddTool("JKZTZD_ItRw_Arrow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Arrow", 5);
	SetCraftScience("JKZTZD_ItRw_Arrow", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Arrow", 10);
	SetCraftEXP("JKZTZD_ItRw_Arrow", 10)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Arrow", "�������")	
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Bolt"); --- ����
	SetCraftAmount("JKZTZD_ItRw_Bolt", 40);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ITMI_WOOD", 5);
	 AddIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Iron", 5);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "jkztzd_itmw_1h_bau_mace", 1);
	 AddAlterIngre("JKZTZD_ItRw_Bolt", "OOLTYB_ItMi_Iron", 5);
	 AddTool("JKZTZD_ItRw_Bolt", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bolt", 5);
	SetCraftScience("JKZTZD_ItRw_Bolt", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bolt", 10);
	SetCraftEXP("JKZTZD_ItRw_Bolt", 10)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bolt", "�������")	

AddItemCategory ("������� (1 �������)", "ooltyb_itmi_paper"); --- ������
	SetCraftAmount("ooltyb_itmi_paper", 25);
	 AddIngre("ooltyb_itmi_paper", "OOLTYB_ITMI_WOOD", 15);
	SetCraftPenalty("ooltyb_itmi_paper", 5);
	SetCraftScience("ooltyb_itmi_paper", "�������", 1);
	SetenergyPenalty("ooltyb_itmi_paper", 10);
	SetCraftEXP("ooltyb_itmi_paper", 10)
	SetCraftEXP_SKILL("ooltyb_itmi_paper", "�������")	

	
-- ������� 1 ������� ���������� ������ �� 20 �����
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_1h_Vlk_Mace"); --- ������
	SetCraftAmount("JKZTZD_ItMw_1h_Vlk_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Vlk_Mace", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1h_Vlk_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Vlk_Mace", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Vlk_Mace", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Vlk_Mace", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Vlk_Mace", "�������")		

AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_1H_Mace_L_03"); --- ������
	SetCraftAmount("JKZTZD_ItMw_1H_Mace_L_03", 1);
	 AddIngre("JKZTZD_ItMw_1H_Mace_L_03", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1H_Mace_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1H_Mace_L_03", 5);
	SetCraftScience("JKZTZD_ItMw_1H_Mace_L_03", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1H_Mace_L_03", 25);
	SetCraftEXP("JKZTZD_ItMw_1H_Mace_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1H_Mace_L_03", "�������")	

AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_Nagelknueppel"); --- ������ � ������
	SetCraftAmount("JKZTZD_ItMw_Nagelknueppel", 1);
	 AddIngre("JKZTZD_ItMw_Nagelknueppel", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_Nagelknueppel", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelknueppel", 5);
	SetCraftScience("JKZTZD_ItMw_Nagelknueppel", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelknueppel", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelknueppel", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelknueppel", "�������")	

	AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_Nagelkeule"); --- ������ � ������
	SetCraftAmount("JKZTZD_ItMw_Nagelkeule", 1);
	 AddIngre("JKZTZD_ItMw_Nagelkeule", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_Nagelkeule", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Nagelkeule", 10);
	SetCraftScience("JKZTZD_ItMw_Nagelkeule", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_Nagelkeule", 25);
	SetCraftEXP("JKZTZD_ItMw_Nagelkeule", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Nagelkeule", "�������")
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_1h_Nov_Mace"); --- ������ �����
	SetCraftAmount("JKZTZD_ItMw_1h_Nov_Mace", 1);
	 AddIngre("JKZTZD_ItMw_1h_Nov_Mace", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItMw_1h_Nov_Mace", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_1h_Nov_Mace", 5);
	SetCraftScience("JKZTZD_ItMw_1h_Nov_Mace", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Nov_Mace", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Nov_Mace", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Nov_Mace", "�������")
	
-- ������� 1 ������� ��������� ������ �� 30 ����� � ���������� �� 20 �����

AddItemCategory ("������� (1 �������)", "JKZTZD_ItMW_Addon2h"); --- ��������� ������� ����
	SetCraftAmount("JKZTZD_ItMW_Addon2h", 1);
	 AddIngre("JKZTZD_ItMW_Addon2h", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddTool("JKZTZD_ItMW_Addon2h", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_Addon2h", 10);
	SetCraftScience("JKZTZD_ItMW_Addon2h", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMW_Addon2h", 25);
	SetCraftEXP("JKZTZD_ItMW_Addon2h", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Addon2h", "�������")

AddItemCategory ("������� (1 �������)", "jkztzd_itmw_addon_stab06"); --- ����� ����������
	SetCraftAmount("jkztzd_itmw_addon_stab06", 1);
     AddIngre("jkztzd_itmw_addon_stab06", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddIngre("jkztzd_itmw_addon_stab06", "ooltyb_itmi_s_ignot", 1);
	 AddIngre("jkztzd_itmw_addon_stab06", "ooltyb_itmi_mage1", 1);
	 AddTool("jkztzd_itmw_addon_stab06", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab06", 10);
	SetCraftScience("jkztzd_itmw_addon_stab06", "�������", 1);
	SetenergyPenalty("jkztzd_itmw_addon_stab06", 25);
	SetCraftEXP("jkztzd_itmw_addon_stab06", 25)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab06", "�������")	
		
AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Bow_L_01"); --- �������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_01", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Bow_L_01", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_01", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_01", "�������")	
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Bow_L_03"); --- ��������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_L_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_03", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_03", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_03", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_03", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_03", "�������")

AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Bow_L_02"); --- ������ ���
	SetCraftAmount("JKZTZD_ItRw_Bow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Bow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_02", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_02", 25);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_02", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_02", "�������")

AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Crossbow_L_01"); --- ��������� �������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_01", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_L_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_01", 5);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_01", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_01", 25);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_L_01", "�������")


AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Mil_Crossbow"); --- �������
	SetCraftAmount("JKZTZD_ItRw_Mil_Crossbow", 1);
	 AddIngre("JKZTZD_ItRw_Mil_Crossbow", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Mil_Crossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Mil_Crossbow", 10);
	SetCraftScience("JKZTZD_ItRw_Mil_Crossbow", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Mil_Crossbow", 25);
	SetCraftEXP("JKZTZD_ItRw_Mil_Crossbow", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Mil_Crossbow", "�������")	
	
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItRw_Crossbow_L_02"); --- ������ �������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_L_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_L_02", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_L_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_L_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_L_02", "�������", 1);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_L_02", 25);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_L_02", 25)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_L_02", "�������")	

AddItemCategory ("������� (1 �������)", "yfauun_itsh_shield_01"); --- ���������� ���
	SetCraftAmount("yfauun_itsh_shield_01", 1);
	 AddIngre("yfauun_itsh_shield_01", "ooltyb_itmi_obrabotder", 2);
	 AddTool("yfauun_itsh_shield_01", "jkztzd_itmw_1h_vlk_axe");
	SetCraftPenalty("yfauun_itsh_shield_01", 10);
	SetCraftScience("yfauun_itsh_shield_01", "�������", 1);
	SetenergyPenalty("yfauun_itsh_shield_01", 25);
	SetCraftEXP("yfauun_itsh_shield_01", 25)
	SetCraftEXP_SKILL("yfauun_itsh_shield_01", "�������")
	
AddItemCategory ("������� (1 �������)", "ooltyb_itmi_lute"); --- �����
	SetCraftAmount("ooltyb_itmi_lute", 1);
	 AddIngre("ooltyb_itmi_lute", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddIngre("ooltyb_itmi_lute", "ZDPWLA_ItMi_Glue", 1);
	 AddTool("ooltyb_itmi_lute", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_lute", 10);
	SetCraftScience("ooltyb_itmi_lute", "�������", 1);
	SetenergyPenalty("ooltyb_itmi_lute", 10);
	SetCraftEXP("ooltyb_itmi_lute", 10)
	SetCraftEXP_SKILL("ooltyb_itmi_lute", "�������")
	
--AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_FISHING"); --- ������
	--SetCraftAmount("OOLTYB_ITMI_FISHING", 1);
	-- AddIngre("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Bau_Mace", 1);
	-- AddIngre("OOLTYB_ITMI_FISHING", "OOLTYB_ITMI_SHEEP", 1);
	-- AddTool("OOLTYB_ITMI_FISHING", "JKZTZD_ItMw_1h_Vlk_AxE");
--	SetCraftPenalty("OOLTYB_ITMI_FISHING", 5);
--	SetCraftScience("OOLTYB_ITMI_FISHING", "�������", 1);
--	SetenergyPenalty("OOLTYB_ITMI_FISHING", 10);
--	SetCraftEXP("OOLTYB_ITMI_FISHING", 10)
--	SetCraftEXP_SKILL("OOLTYB_ITMI_FISHING", "�������")	

AddItemCategory ("������� (1 �������)", "OOLTYB_ItMi_Scoop"); --- �����
	SetCraftAmount("OOLTYB_ItMi_Scoop", 1);
	 AddIngre("OOLTYB_ItMi_Scoop", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("OOLTYB_ItMi_Scoop", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_Scoop", 5);
	SetCraftScience("OOLTYB_ItMi_Scoop", "�������", 1);
	SetenergyPenalty("OOLTYB_ItMi_Scoop", 10);
	SetCraftEXP("OOLTYB_ItMi_Scoop", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Scoop", "�������")		
	
AddItemCategory ("������� (1 �������)", "OOLTYB_ItMi_Broom"); --- �����
	SetCraftAmount("OOLTYB_ItMi_Broom", 1);
	 AddIngre("OOLTYB_ItMi_Broom", "OOLTYB_ITMI_WOOD", 10);
	 AddTool("OOLTYB_ItMi_Broom", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ItMi_Broom", 5);
	SetCraftScience("OOLTYB_ItMi_Broom", "�������", 1);
	SetenergyPenalty("OOLTYB_ItMi_Broom", 10);
	SetCraftEXP("OOLTYB_ItMi_Broom", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Broom", "�������")	

-- ������� 2 ����������

AddItemCategory ("������� (2 �������)", "OOLTYB_ITMI_HANDLE"); --- �������
	SetCraftAmount("OOLTYB_ITMI_HANDLE", 1);
	 AddIngre("OOLTYB_ITMI_HANDLE", "OOLTYB_ITMI_OBRABOTDER", 2);
	 AddTool("OOLTYB_ITMI_HANDLE", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("OOLTYB_ITMI_HANDLE", 10);
	SetCraftScience("OOLTYB_ITMI_HANDLE", "�������", 2);
	SetenergyPenalty("OOLTYB_ITMI_HANDLE", 50);
	SetCraftEXP("OOLTYB_ITMI_HANDLE", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_HANDLE", "�������")

AddItemCategory ("������� (2 �������)", "ooltyb_itmi_alchemy_syrianoil_01"); --- ������
	SetCraftAmount("ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddIngre("ooltyb_itmi_alchemy_syrianoil_01", "OOLTYB_ITMI_OBRABOTDER", 1);
	 AddTool("ooltyb_itmi_alchemy_syrianoil_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("ooltyb_itmi_alchemy_syrianoil_01", 10);
	SetCraftScience("ooltyb_itmi_alchemy_syrianoil_01", "�������", 2);
	SetenergyPenalty("ooltyb_itmi_alchemy_syrianoil_01", 50);
	SetCraftEXP("ooltyb_itmi_alchemy_syrianoil_01", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_alchemy_syrianoil_01", "�������")

-- ������� 2 ������� ���������� ������ �� 30 �����

AddItemCategory ("������� (2 �������)", "JKZTZD_ItMW_AddonKeu"); --- ������� �����
	SetCraftAmount("JKZTZD_ItMW_AddonKeu", 1);
	 AddIngre("JKZTZD_ItMW_AddonKeu", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItMW_AddonKeu", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItMW_AddonKeu", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_AddonKeu", 10);
	SetCraftScience("JKZTZD_ItMW_AddonKeu", "�������", 2);
	SetenergyPenalty("JKZTZD_ItMW_AddonKeu", 50);
	SetCraftEXP("JKZTZD_ItMW_AddonKeu", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMW_AddonKeu", "�������")

-- ������� 2 ������� ��������� ������ �� 40 ����� � ���������� �� 30 �����

AddItemCategory ("������� (2 �������)", "JKZTZD_ItMw_Richtstab"); --- ����� �����
	SetCraftAmount("JKZTZD_ItMw_Richtstab", 1);
     AddIngre("JKZTZD_ItMw_Richtstab", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("JKZTZD_ItMw_Richtstab", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItMw_Richtstab", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMw_Richtstab", 10);
	SetCraftScience("JKZTZD_ItMw_Richtstab", "�������", 2);
	SetenergyPenalty("JKZTZD_ItMw_Richtstab", 50);
	SetCraftEXP("JKZTZD_ItMw_Richtstab", 50)
	SetCraftEXP_SKILL("JKZTZD_ItMw_Richtstab", "�������")		

AddItemCategory ("������� (2 �������)", "jkztzd_itmw_rangerstaff"); --- ����������� ������ �����
	SetCraftAmount("jkztzd_itmw_rangerstaff", 1);
     AddIngre("jkztzd_itmw_rangerstaff", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("jkztzd_itmw_rangerstaff", "ooltyb_itmi_nail", 1);
	 AddTool("jkztzd_itmw_rangerstaff", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_rangerstaff", 10);
	SetCraftScience("jkztzd_itmw_rangerstaff", "�������", 2);
	SetenergyPenalty("jkztzd_itmw_rangerstaff", 50);
	SetCraftEXP("jkztzd_itmw_rangerstaff", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_rangerstaff", "�������")	
	
AddItemCategory ("������� (2 �������)", "jkztzd_itmw_addon_stab01"); --- ����� ���� ����
	SetCraftAmount("jkztzd_itmw_addon_stab01", 1);
     AddIngre("jkztzd_itmw_addon_stab01", "OOLTYB_ITMI_OBRABOTDER", 3);
	 AddIngre("jkztzd_itmw_addon_stab01", "ooltyb_itmi_whool_holst", 2);
	 AddIngre("jkztzd_itmw_addon_stab01", "ooltyb_itmi_mage2", 1);
	 AddTool("jkztzd_itmw_addon_stab01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab01", 10);
	SetCraftScience("jkztzd_itmw_addon_stab01", "�������", 2);
	SetenergyPenalty("jkztzd_itmw_addon_stab01", 50);
	SetCraftEXP("jkztzd_itmw_addon_stab01", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab01", "�������")	
	
AddItemCategory ("������� (2 �������)", "jkztzd_itmw_addon_stab02"); --- ����� ���� ����
	SetCraftAmount("jkztzd_itmw_addon_stab02", 1);
     AddIngre("jkztzd_itmw_addon_stab02", "OOLTYB_ITMI_OBRABOTDER", 5);
	 AddIngre("jkztzd_itmw_addon_stab02", "ooltyb_itmi_whool_holst", 2);
	 AddIngre("jkztzd_itmw_addon_stab02", "ooltyb_itmi_mage2", 1);
	 AddTool("jkztzd_itmw_addon_stab02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab02", 10);
	SetCraftScience("jkztzd_itmw_addon_stab02", "�������", 2);
	SetenergyPenalty("jkztzd_itmw_addon_stab02", 50);
	SetCraftEXP("jkztzd_itmw_addon_stab02", 50)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab02", "�������")	


AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Sld_Bow"); --- ���������� ���
	SetCraftAmount("JKZTZD_ItRw_Sld_Bow", 1);
	 AddIngre("JKZTZD_ItRw_Sld_Bow", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Sld_Bow", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Sld_Bow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Sld_Bow", 10);
	SetCraftScience("JKZTZD_ItRw_Sld_Bow", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Sld_Bow", 50);
	SetCraftEXP("JKZTZD_ItRw_Sld_Bow", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Sld_Bow", "�������")
	
AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Bow_L_04"); --- ������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_L_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_L_04", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_L_04", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_L_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_L_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_L_04", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_L_04", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_L_04", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_L_04", "�������")
	
	
AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Bow_M_02"); --- �������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_02", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_02", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_02", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_02", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_02", "�������")
	
	
AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Bow_M_03"); --- ������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_M_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_03", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_03", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_03", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_03", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_03", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_03", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_03", "�������")
	
	
AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Bow_M_04"); --- ������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_M_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_M_04", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Bow_M_04", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Bow_M_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_M_04", 10);
	SetCraftScience("JKZTZD_ItRw_Bow_M_04", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Bow_M_04", 50);
	SetCraftEXP("JKZTZD_ItRw_Bow_M_04", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_M_04", "�������")


AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Crossbow_M_01"); --- ������� ���������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_01", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_01", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_M_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_01", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_01", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_01", 50);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_M_01", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_M_01", "�������")	
	
	
AddItemCategory ("������� (2 �������)", "JKZTZD_ItRw_Crossbow_M_02"); --- ������� �������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_M_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_M_02", "ooltyb_itmi_nail", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_M_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_M_02", 10);
	SetCraftScience("JKZTZD_ItRw_Crossbow_M_02", "�������", 2);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_M_02", 50);
	SetCraftEXP("JKZTZD_ItRw_Crossbow_M_02", 50)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_M_02", "�������")	
	
	
AddItemCategory ("������� (2 �������)", "YFAUUN_ITSH_SHIELD_02"); --- ������� ���
	SetCraftAmount("YFAUUN_ITSH_SHIELD_02", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_02", "OOLTYB_ITMI_OBRABOTDER", 4);
	 AddIngre("YFAUUN_ITSH_SHIELD_02", "ooltyb_itmi_nail", 1);
	 AddTool("YFAUUN_ITSH_SHIELD_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_02", 10);
	SetCraftScience("YFAUUN_ITSH_SHIELD_02", "�������", 2);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_02", 50);
	SetCraftEXP("YFAUUN_ITSH_SHIELD_02", 50)
	SetCraftEXP_SKILL("YFAUUN_ITSH_SHIELD_02", "�������")		
	

-- ������� 3 ������� ��������� ������ �� 50 ����� � ���������� �� 40 �����

AddItemCategory ("������� (3 �������)", "jkztzd_itmw_addon_stab08"); --- ����� � ����������
	SetCraftAmount("jkztzd_itmw_addon_stab08", 1);
	 AddIngre("jkztzd_itmw_addon_stab08", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("jkztzd_itmw_addon_stab08", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("jkztzd_itmw_addon_stab08", "ooltyb_itmi_mage3", 1);
	 AddTool("jkztzd_itmw_addon_stab08", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab08", 20);
	SetCraftScience("jkztzd_itmw_addon_stab08", "�������", 3);
	SetenergyPenalty("jkztzd_itmw_addon_stab08", 75);
	SetCraftEXP("jkztzd_itmw_addon_stab08", 75)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab08", "�������")	
	
AddItemCategory ("������� (3 �������)", "JKZTZD_ItMW_Addon_Stab09"); --- ������������ �����
	SetCraftAmount("JKZTZD_ItMW_Addon_Stab09", 1);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("JKZTZD_ItMW_Addon_Stab09", "ooltyb_itmi_mage3", 1);
	 AddTool("JKZTZD_ItMW_Addon_Stab09", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItMW_Addon_Stab09", 20);
	SetCraftScience("JKZTZD_ItMW_Addon_Stab09", "�������", 3);
	SetenergyPenalty("JKZTZD_ItMW_Addon_Stab09", 75);
	SetCraftEXP("JKZTZD_ItMW_Addon_Stab09", 75)
	SetCraftEXP_SKILL("JKZTZD_ItMW_Addon_Stab09", "�������")	
	
AddItemCategory ("������� (3 �������)", "jkztzd_itmw_addon_stab07"); --- ���������� �����
	SetCraftAmount("jkztzd_itmw_addon_stab07", 1);
	 AddIngre("jkztzd_itmw_addon_stab07", "OOLTYB_ITMI_HANDLE", 6);
	 AddIngre("jkztzd_itmw_addon_stab07", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("jkztzd_itmw_addon_stab07", "ooltyb_itmi_mage3", 1);
	 AddTool("jkztzd_itmw_addon_stab07", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab07", 20);
	SetCraftScience("jkztzd_itmw_addon_stab07", "�������", 3);
	SetenergyPenalty("jkztzd_itmw_addon_stab07", 75);
	SetCraftEXP("jkztzd_itmw_addon_stab07", 75)
	SetCraftEXP_SKILL("jkztzd_itmw_addon_stab07", "�������")

AddItemCategory ("������� (3 �������)", "jkztzd_itrw_bow_m_01"); --- ����������� ���
	SetCraftAmount("jkztzd_itrw_bow_m_01", 1);
	 AddIngre("jkztzd_itrw_bow_m_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("jkztzd_itrw_bow_m_01", "ooltyb_itmi_nail", 2);
	 AddIngre("jkztzd_itrw_bow_m_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("jkztzd_itrw_bow_m_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itrw_bow_m_01", 20);
	SetCraftScience("jkztzd_itrw_bow_m_01", "�������", 3);
	SetenergyPenalty("jkztzd_itrw_bow_m_01", 75);
	SetCraftEXP("jkztzd_itrw_bow_m_01", 75)
	SetCraftEXP_SKILL("jkztzd_itrw_bow_m_01", "�������")


AddItemCategory ("������� (3 �������)", "JKZTZD_ItRw_Bow_H_01"); --- �������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_01", "�������", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_01", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_01", "�������")

AddItemCategory ("������� (3 �������)", "JKZTZD_ItRw_Bow_H_02"); --- ������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_02", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_02", "�������", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_02", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_02", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_02", "�������")


AddItemCategory ("������� (3 �������)", "JKZTZD_ItRw_Bow_H_03"); --- ������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_H_03", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Bow_H_03", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Bow_H_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_03", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_03", "�������", 3);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_03", 75);
	SetCraftEXP("JKZTZD_ItRw_Bow_H_03", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Bow_H_03", "�������")
	
AddItemCategory ("������� (3 �������)", "JKZTZD_ItRw_Crossbow_H_01"); --- ������� �������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_01", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "ooltyb_itmi_nail", 2);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_01", "ZDPWLA_ItMi_Glue", 2);
	 AddTool("JKZTZD_ItRw_Crossbow_H_01", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_01", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_01", "�������", 3);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_01", 75);	
	SetCraftEXP("JKZTZD_ItRw_Crossbow_H_01", 75)
	SetCraftEXP_SKILL("JKZTZD_ItRw_Crossbow_H_01", "�������")
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ITSH_SHIELD_03"); --- �������� ���
	SetCraftAmount("YFAUUN_ITSH_SHIELD_03", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "OOLTYB_ITMI_HANDLE", 4);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "ooltyb_itmi_nail", 2);
	 AddIngre("YFAUUN_ITSH_SHIELD_03", "ooltyb_itmi_whool_holst", 2);
	 AddTool("YFAUUN_ITSH_SHIELD_03", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_03", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_03", "�������", 3);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_03", 75);	
	SetCraftEXP("YFAUUN_ITSH_SHIELD_03", 75)
	SetCraftEXP_SKILL("YFAUUN_ITSH_SHIELD_03", "�������")
	
-- ������� 4 ������� ��������� ������ �� 70 ����� � ���������� �� 60 �����
	
AddItemCategory ("������� (4 �������)", "jkztzd_itmw_addon_stab05"); --- ������
	SetCraftAmount("jkztzd_itmw_addon_stab05", 1);
     AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_m_wire", 10);
	 AddIngre("jkztzd_itmw_addon_stab05", "OOLTYB_ITMI_HANDLE", 20);
	 AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_whool_holst", 10);
	 AddIngre("jkztzd_itmw_addon_stab05", "ooltyb_itmi_mage4", 1);
	 AddIngre("jkztzd_itmw_addon_stab05", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_addon_stab05", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_addon_stab05", 20);
	SetCraftScience("jkztzd_itmw_addon_stab05", "�������", 4);
	SetenergyPenalty("jkztzd_itmw_addon_stab05", 100);	

AddItemCategory ("������� (4 �������)", "jkztzd_itmw_2h_mudreccw"); --- ������
	SetCraftAmount("jkztzd_itmw_2h_mudreccw", 1);
     AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_m_wire", 10);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "OOLTYB_ITMI_HANDLE", 20);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_whool_holst", 10);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "ooltyb_itmi_mage4", 1);
	 AddIngre("jkztzd_itmw_2h_mudreccw", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jkztzd_itmw_2h_mudreccw", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("jkztzd_itmw_2h_mudreccw", 20);
	SetCraftScience("jkztzd_itmw_2h_mudreccw", "�������", 4);
	SetenergyPenalty("jkztzd_itmw_2h_mudreccw", 100);	
	
AddItemCategory ("������� (4 �������)", "JKZTZD_ItRw_Crossbow_H_02"); --- ������� �������� �� ��������
	SetCraftAmount("JKZTZD_ItRw_Crossbow_H_02", 1);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_RIVET", 6);
	 AddIngre("JKZTZD_ItRw_Crossbow_H_02", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Crossbow_H_02", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Crossbow_H_02", 20);
	SetCraftScience("JKZTZD_ItRw_Crossbow_H_02", "�������", 4);
	SetenergyPenalty("JKZTZD_ItRw_Crossbow_H_02", 100);	
	
	
AddItemCategory ("������� (4 �������)", "JKZTZD_ItRw_Addon_MagicCrossbow"); --- ���������� �������
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicCrossbow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_RIVET", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicCrossbow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicCrossbow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicCrossbow", "�������", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicCrossbow", 100);	
	
	
AddItemCategory ("������� (4 �������)", "JKZTZD_ItRw_Bow_H_04"); --- �������� ���
	SetCraftAmount("JKZTZD_ItRw_Bow_H_04", 1);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Bow_H_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Bow_H_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Bow_H_04", 20);
	SetCraftScience("JKZTZD_ItRw_Bow_H_04", "�������", 4);
	SetenergyPenalty("JKZTZD_ItRw_Bow_H_04", 100);	
	
	
AddItemCategory ("������� (4 �������)", "JKZTZD_ItRw_Addon_MagicBow"); --- ���������� ���
	SetCraftAmount("JKZTZD_ItRw_Addon_MagicBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Addon_MagicBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_MagicBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_MagicBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_MagicBow", "�������", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_MagicBow", 100);	
	
	
AddItemCategory ("������� (4 �������)", "JKZTZD_ItRw_Addon_FireBow"); --- �������� ���
	SetCraftAmount("JKZTZD_ItRw_Addon_FireBow", 1);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_HANDLE", 15);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ooltyb_itmi_nail", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ZDPWLA_ItMi_Glue", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("JKZTZD_ItRw_Addon_FireBow", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("JKZTZD_ItRw_Addon_FireBow", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("JKZTZD_ItRw_Addon_FireBow", 20);
	SetCraftScience("JKZTZD_ItRw_Addon_FireBow", "�������", 4);
	SetenergyPenalty("JKZTZD_ItRw_Addon_FireBow", 100);	
	

AddItemCategory ("������� (4 �������)", "YFAUUN_ITSH_SHIELD_04"); --- �������� ���
	SetCraftAmount("YFAUUN_ITSH_SHIELD_04", 1);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_handle", 15);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_nail", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_whool_holst", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "ooltyb_itmi_t_leather", 7);
	 AddIngre("YFAUUN_ITSH_SHIELD_04", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("YFAUUN_ITSH_SHIELD_04", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("YFAUUN_ITSH_SHIELD_04", 20);
	SetCraftScience("YFAUUN_ITSH_SHIELD_04", "�������", 4);
	SetenergyPenalty("YFAUUN_ITSH_SHIELD_04", 100);	
	
-- �������� 1 �������� ������
AddItemCategory ("�������� (�������� ������)", "rc_house_armchair_wood"); --- ���������� ������ � ��������
	SetCraftAmount("rc_house_armchair_wood", 1);
	 AddIngre("rc_house_armchair_wood", "OOLTYB_ItAt_WolfFur", 2);
	 AddIngre("rc_house_armchair_wood", "ooltyb_itmi_wood", 10);
	 AddAlterIngre("rc_house_armchair_wood", "OOLTYB_itat_LurkerSkin", 2);
	 AddAlterIngre("rc_house_armchair_wood", "ooltyb_itmi_wood", 10);
	SetCraftPenalty("rc_house_armchair_wood", 5);
	SetCraftScience("rc_house_armchair_wood", "��������", 1);
	SetenergyPenalty("rc_house_armchair_wood", 25);
	SetCraftEXP("rc_house_armchair_wood", 25)
	SetCraftEXP_SKILL("rc_house_armchair_wood ", "��������")
	
AddItemCategory ("�������� (�������� ������)", "rc_house_armchair_rich"); --- ������� ������
	SetCraftAmount("rc_house_armchair_rich ", 1);
	 AddIngre("rc_house_armchair_rich ", "OOLTYB_ITMI_LEATHER", 2);
	 AddIngre("rc_house_armchair_rich ", "ooltyb_itmi_wood", 5);
	SetCraftPenalty("rc_house_armchair_rich ", 5);
	SetCraftScience("rc_house_armchair_rich ", "��������", 1);
	SetenergyPenalty("rc_house_armchair_rich ", 25);
	SetCraftEXP("rc_house_armchair_rich ", 25)
	SetCraftEXP_SKILL("rc_house_armchair_rich ", "��������")
	
-- �������� 1 ������� ����������

AddItemCategory ("�������� (1 �������)", "OOLTYB_ITMI_LEATHER"); --- ����
	SetCraftAmount("OOLTYB_ITMI_LEATHER", 1);
	 AddIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_ItAt_WolfFur", 2);
	 AddAlterIngre("OOLTYB_ITMI_LEATHER", "OOLTYB_itat_LurkerSkin", 2);
	SetCraftPenalty("OOLTYB_ITMI_LEATHER", 5);
	SetCraftScience("OOLTYB_ITMI_LEATHER", "��������", 1);
	SetenergyPenalty("OOLTYB_ITMI_LEATHER", 25);
	SetCraftEXP("OOLTYB_ITMI_LEATHER", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_LEATHER", "��������")

--[[	AddItemCategory ("�������� (����������)", "OOLTYB_ITMI_QLEATHER"); --- ������������ ����
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 2);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "��������", 1);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);]]
	
	
-- �������� 1 ������� ������� �� 10 ������

AddItemCategory ("�������� (1 �������)", "yfauun_itar_islam1"); --- ������� ��������
	SetCraftAmount("yfauun_itar_islam1", 1);
	 AddIngre("yfauun_itar_islam1", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("yfauun_itar_islam1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam1", 10);
	SetCraftScience("yfauun_itar_islam1", "��������", 1);
	SetenergyPenalty("yfauun_itar_islam1", 25);
	SetCraftEXP("yfauun_itar_islam1", 25)
	SetCraftEXP_SKILL("yfauun_itar_islam1", "��������")

AddItemCategory ("�������� (1 �������)", "YFAUUN_ItAr_FRONTIER10"); --- ����������� �������
	SetCraftAmount("YFAUUN_ItAr_FRONTIER10", 1);
	 AddIngre("YFAUUN_ItAr_FRONTIER10", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ItAr_FRONTIER10", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_FRONTIER10", 10);
	SetCraftScience("YFAUUN_ItAr_FRONTIER10", "��������", 1);
	SetenergyPenalty("YFAUUN_ItAr_FRONTIER10", 25);
	SetCraftEXP("YFAUUN_ItAr_FRONTIER10", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_FRONTIER10", "��������")
	
AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_WOODCUTTER"); --- ������ ��������
	SetCraftAmount("YFAUUN_ITAR_WOODCUTTER", 1);
	 AddIngre("YFAUUN_ITAR_WOODCUTTER", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_WOODCUTTER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WOODCUTTER", 10);
	SetCraftScience("YFAUUN_ITAR_WOODCUTTER", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_WOODCUTTER", 25);
	SetCraftEXP("YFAUUN_ITAR_WOODCUTTER", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WOODCUTTER", "��������")
	
AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_Leather_L"); --- ������� �������
	SetCraftAmount("YFAUUN_ITAR_Leather_L", 1);
	 AddIngre("YFAUUN_ITAR_Leather_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_Leather_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Leather_L", 10);
	SetCraftScience("YFAUUN_ITAR_Leather_L", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Leather_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Leather_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Leather_L", "��������")
	
AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_BABE_LEATHER_L"); --- ������� ������� ���
	SetCraftAmount("YFAUUN_ITAR_BABE_LEATHER_L", 1);
	 AddIngre("YFAUUN_ITAR_BABE_LEATHER_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_BABE_LEATHER_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 10);
	SetCraftScience("YFAUUN_ITAR_BABE_LEATHER_L", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BABE_LEATHER_L", 25);
	SetCraftEXP("YFAUUN_ITAR_BABE_LEATHER_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BABE_LEATHER_L", "��������")
	
AddItemCategory ("�������� (1 �������)", "YFAUUN_ItAr_HNT_L"); --- ������ ��������
	SetCraftAmount("YFAUUN_ItAr_HNT_L", 1);
	 AddIngre("YFAUUN_ItAr_HNT_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ItAr_HNT_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_HNT_L", 10);
	SetCraftScience("YFAUUN_ItAr_HNT_L", "��������", 1);
	SetenergyPenalty("YFAUUN_ItAr_HNT_L", 25);
	SetCraftEXP("YFAUUN_ItAr_HNT_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_HNT_L", "��������")

AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_PIR_M_HORINIS"); --- ������ ������
	SetCraftAmount("YFAUUN_ITAR_PIR_M_HORINIS", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_HORINIS", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_HORINIS", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_HORINIS", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_HORINIS", 25);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_HORINIS", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_HORINIS", "��������")

AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_OLDCAMP_L"); --- ������ ����
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_L", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMP_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMP_L", "��������")
	
	
AddItemCategory ("�������� (1 �������)", "YFAUUN_ITAR_NEWCAMP_L"); --- ������ ����
	SetCraftAmount("YFAUUN_ITAR_NEWCAMP_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMP_L", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMP_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMP_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMP_L", "��������", 1);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMP_L", 25);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMP_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMP_L", "��������")
	
AddItemCategory ("�������� (1 �������)", "yfauun_itar_babe_bandit"); --- ������� �������
	SetCraftAmount("yfauun_itar_babe_bandit", 1);
	 AddIngre("yfauun_itar_babe_bandit", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("yfauun_itar_babe_bandit", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_babe_bandit", 10);
	SetCraftScience("yfauun_itar_babe_bandit", "��������", 1);
	SetenergyPenalty("yfauun_itar_babe_bandit", 25);
	SetCraftEXP("yfauun_itar_babe_bandit", 25)
	SetCraftEXP_SKILL("yfauun_itar_babe_bandit", "��������")
	
AddItemCategory ("�������� (1 �������)", "itar_arx_r_l"); --- ������� ����� �������
	SetCraftAmount("itar_arx_r_l", 1);
	 AddIngre("itar_arx_r_l", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("itar_arx_r_l", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_r_l", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_arx_r_l", 10);
	SetCraftScience("itar_arx_r_l", "��������", 1);
	SetenergyPenalty("itar_arx_r_l", 25);
	SetCraftEXP("itar_arx_r_l", 25)
	SetCraftEXP_SKILL("itar_arx_r_l", "��������")
	
AddItemCategory ("�������� (1 �������)", "ITAR_BES_DOSP1"); --- ������� ����� �����������
	SetCraftAmount("ITAR_BES_DOSP1", 1);
	 AddIngre("ITAR_BES_DOSP1", "OOLTYB_ITMI_LEATHER", 2);
	 AddTool("ITAR_BES_DOSP1", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_BES_DOSP1", 10);
	SetCraftScience("ITAR_BES_DOSP1", "��������", 1);
	SetenergyPenalty("ITAR_BES_DOSP1", 25);
	SetCraftEXP("ITAR_BES_DOSP1", 25)
	SetCraftEXP_SKILL("ITAR_BES_DOSP1", "��������")
	
AddItemCategory ("�������� (1 �������)", "itar_syn_ldosp"); --- ������� ���������
	SetCraftAmount("itar_syn_ldosp", 1);
	 AddIngre("itar_syn_ldosp", "OOLTYB_ITMI_LEATHER", 4);
	 AddTool("itar_syn_ldosp", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_ldosp", 10);
	SetCraftScience("itar_syn_ldosp", "��������", 1);
	SetenergyPenalty("itar_syn_ldosp", 25);
	SetCraftEXP("itar_syn_ldosp", 25)
	SetCraftEXP_SKILL("itar_syn_ldosp", "��������")

-- �������� 2 ������� ����������

AddItemCategory ("�������� (2 �������)", "OOLTYB_ITMI_QLEATHER"); --- ������������ ����
	SetCraftAmount("OOLTYB_ITMI_QLEATHER", 1);
	 AddIngre("OOLTYB_ITMI_QLEATHER", "ooltyb_itat_shadowfur", 2);
	 AddAlterIngre("OOLTYB_ITMI_QLEATHER", "OOLTYB_ItAt_TrollFur", 1);
	SetCraftPenalty("OOLTYB_ITMI_QLEATHER", 10);
	SetCraftScience("OOLTYB_ITMI_QLEATHER", "��������", 2);
	SetenergyPenalty("OOLTYB_ITMI_QLEATHER", 50);
	SetCraftEXP("OOLTYB_ITMI_QLEATHER", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_QLEATHER", "��������")
	
AddItemCategory ("�������� (2 �������)", "ooltyb_itmi_t_leather"); --- ������ ����
	SetCraftAmount("ooltyb_itmi_t_leather", 1);
	 AddIngre("ooltyb_itmi_t_leather", "OOLTYB_ITMI_LEATHER", 1);
	SetCraftPenalty("ooltyb_itmi_t_leather", 10);
	SetCraftScience("ooltyb_itmi_t_leather", "��������", 2);
	SetenergyPenalty("ooltyb_itmi_t_leather", 50);
	SetCraftEXP("ooltyb_itmi_t_leather", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_t_leather", "��������")
	
	
-- �������� 2 ������� ������� �� 20 ������

AddItemCategory ("�������� (2 �������)", "yfauun_itar_islam2"); --- ������ ������� ��������
	SetCraftAmount("yfauun_itar_islam2", 1);
	 AddIngre("yfauun_itar_islam2", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("yfauun_itar_islam2", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("yfauun_itar_islam2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam2", 10);
	SetCraftScience("yfauun_itar_islam2", "��������", 2);
	SetenergyPenalty("yfauun_itar_islam2", 50);
	SetCraftEXP("yfauun_itar_islam2", 50)
	SetCraftEXP_SKILL("yfauun_itar_islam2", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_NEUTRAL11"); --- ������ ������� �������
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL11", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL11", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL11", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL11", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL11", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL11", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL11", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL11", "��������")
	
AddItemCategory ("�������� (2 �������)", "YFAUUN_ItAr_COL"); --- ������ ������� ���������
	SetCraftAmount("YFAUUN_ItAr_COL", 1);
	 AddIngre("YFAUUN_ItAr_COL", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ItAr_COL", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ItAr_COL", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_COL", 10);
	SetCraftScience("YFAUUN_ItAr_COL", "��������", 2);
	SetenergyPenalty("YFAUUN_ItAr_COL", 50);
	SetCraftEXP("YFAUUN_ItAr_COL", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_COL", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_HUNTER3"); --- �������� ������ ��������
	SetCraftAmount("YFAUUN_ITAR_HUNTER3", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_HUNTER3", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_HUNTER3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER3", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER3", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER3", 50);
	SetCraftEXP("YFAUUN_ITAR_HUNTER3", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_HUNTER3", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_PIR_L_Addon"); --- ������ ������� ������
	SetCraftAmount("YFAUUN_ITAR_PIR_L_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_PIR_L_Addon", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_PIR_L_Addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_L_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_L_Addon", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_PIR_L_Addon", 50);
	SetCraftEXP("YFAUUN_ITAR_PIR_L_Addon", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_L_Addon", "��������")
		
AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_WALKER"); --- ������� ����
	SetCraftAmount("YFAUUN_ITAR_WALKER", 1);
	 AddIngre("YFAUUN_ITAR_WALKER", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_WALKER", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_WALKER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_WALKER", 10);
	SetCraftScience("YFAUUN_ITAR_WALKER", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_WALKER", 50);
	SetCraftEXP("YFAUUN_ITAR_WALKER", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_WALKER", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_TRAVELER"); --- ������� ������� ����
	SetCraftAmount("YFAUUN_ITAR_TRAVELER", 1);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_TRAVELER", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_TRAVELER", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_TRAVELER", 10);
	SetCraftScience("YFAUUN_ITAR_TRAVELER", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_TRAVELER", 50);
	SetCraftEXP("YFAUUN_ITAR_TRAVELER", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_TRAVELER", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_NEUTRAL"); --- ������ ��������
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL", "��������")
	
AddItemCategory ("�������� (2 �������)", "YFAUUN_ItAr_LARM_M"); --- ������ ������� �������
	SetCraftAmount("YFAUUN_ItAr_LARM_M", 1);
	 AddIngre("YFAUUN_ItAr_LARM_M", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ItAr_LARM_M", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ItAr_LARM_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_LARM_M", 10);	
	SetCraftScience("YFAUUN_ItAr_LARM_M", "��������", 2);
	SetenergyPenalty("YFAUUN_ItAr_LARM_M", 50);
	SetCraftEXP("YFAUUN_ItAr_LARM_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_LARM_M", "��������")

AddItemCategory ("�������� (2 �������)", "YFAUUN_ITAR_REDSHAR"); --- ������ ������� ��������
	SetCraftAmount("YFAUUN_ITAR_REDSHAR", 1);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ITAR_REDSHAR", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ITAR_REDSHAR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_REDSHAR", 10);
	SetCraftScience("YFAUUN_ITAR_REDSHAR", "��������", 2);
	SetenergyPenalty("YFAUUN_ITAR_REDSHAR", 50);
	SetCraftEXP("YFAUUN_ITAR_REDSHAR", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_REDSHAR", "��������")
	
AddItemCategory ("�������� (2 �������)", "YFAUUN_ORG_NEWCAMP_M"); --- ������ ������� ����
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_M", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("YFAUUN_ORG_NEWCAMP_M", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("YFAUUN_ORG_NEWCAMP_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_M", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_M", "��������", 2);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_M", 50);
	SetCraftEXP("YFAUUN_ORG_NEWCAMP_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ORG_NEWCAMP_M", "��������")
	
AddItemCategory ("�������� (2 �������)", "itar_arx_h1"); --- ������ ������� �������� �������
	SetCraftAmount("itar_arx_h1", 1);
	 AddIngre("itar_arx_h1", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_arx_h1", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_arx_h1", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_h1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_arx_h1", 10);
	SetCraftScience("itar_arx_h1", "��������", 2);
	SetenergyPenalty("itar_arx_h1", 50);
	SetCraftEXP("itar_arx_h1", 50)
	SetCraftEXP_SKILL("itar_arx_h1", "��������")
	
AddItemCategory ("�������� (2 �������)", "ITAR_BES_DOSP7"); --- ��������� �������� �����������
	SetCraftAmount("ITAR_BES_DOSP7", 1);
	 AddIngre("ITAR_BES_DOSP7", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("ITAR_BES_DOSP7", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("ITAR_BES_DOSP7", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP7", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_BES_DOSP7", 10);
	SetCraftScience("ITAR_BES_DOSP7", "��������", 2);
	SetenergyPenalty("ITAR_BES_DOSP7", 50);
	SetCraftEXP("ITAR_BES_DOSP7", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP7", "��������")
	
AddItemCategory ("�������� (2 �������)", "itar_mil_a_l"); --- ����������� ������� ���������
	SetCraftAmount("itar_mil_a_l", 1);
	 AddIngre("itar_mil_a_l", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_mil_a_l", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_mil_a_l", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l", 10);
	SetCraftScience("itar_mil_a_l", "��������", 2);
	SetenergyPenalty("itar_mil_a_l", 50);
	SetCraftEXP("itar_mil_a_l", 50)
	SetCraftEXP_SKILL("itar_mil_a_l", "��������")
	
AddItemCategory ("�������� (2 �������)", "itar_syn_marmor"); --- ������ ������� ���������
	SetCraftAmount("itar_syn_marmor", 1);
	 AddIngre("itar_syn_marmor", "OOLTYB_ITMI_LEATHER", 4);
	 AddIngre("itar_syn_marmor", "ooltyb_itmi_alchemy_syrianoil_01", 1);
	 AddTool("itar_syn_marmor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_marmor", 10);
	SetCraftScience("itar_syn_marmor", "��������", 2);
	SetenergyPenalty("itar_syn_marmor", 50);
	SetCraftEXP("itar_syn_marmor", 50)
	SetCraftEXP_SKILL("itar_syn_marmor", "��������")

-- �������� 3 ������ ������� �� 30 ������

AddItemCategory ("�������� (3 �������)", "YFAUUN_VALLEY_M"); --- ����� �������� �����
	SetCraftAmount("YFAUUN_VALLEY_M", 1);
	 AddIngre("YFAUUN_VALLEY_M", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_VALLEY_M", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_VALLEY_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_VALLEY_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_VALLEY_M", 10);
	SetCraftScience("YFAUUN_VALLEY_M", "��������", 3);
	SetenergyPenalty("YFAUUN_VALLEY_M", 75);
	SetCraftEXP("YFAUUN_VALLEY_M", 75)
	SetCraftEXP_SKILL("YFAUUN_VALLEY_M", "��������")

AddItemCategory ("�������� (3 �������)", "yfauun_itar_islam3"); --- ������� ������� ��������
	SetCraftAmount("yfauun_itar_islam3", 1);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_qleather", 5);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_itar_islam3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_islam3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_islam3", 10);
	SetCraftScience("yfauun_itar_islam3", "��������", 3);
	SetenergyPenalty("yfauun_itar_islam3", 75);
	SetCraftEXP("yfauun_itar_islam3", 75)
	SetCraftEXP_SKILL("yfauun_itar_islam3", "��������")

AddItemCategory ("�������� (3 �������)", "YFAUUN_ItAr_BDT_H"); --- ������� ������� �� ���� � ������
	SetCraftAmount("YFAUUN_ItAr_BDT_H", 1);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_BDT_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_BDT_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ItAr_BDT_H", 10);
	SetCraftScience("YFAUUN_ItAr_BDT_H", "��������", 3);
	SetenergyPenalty("YFAUUN_ItAr_BDT_H", 75);
	SetCraftEXP("YFAUUN_ItAr_BDT_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_BDT_H", "��������")
	
	
AddItemCategory ("�������� (3 �������)", "YFAUUN_ITAR_HUNTER4"); --- ������ �������� �� ������������ ����
	SetCraftAmount("YFAUUN_ITAR_HUNTER4", 1);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_HUNTER4", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_HUNTER4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_HUNTER4", 10);
	SetCraftScience("YFAUUN_ITAR_HUNTER4", "��������", 3);
	SetenergyPenalty("YFAUUN_ITAR_HUNTER4", 75);
	SetCraftEXP("YFAUUN_ITAR_HUNTER4", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_HUNTER4", "��������")
	
AddItemCategory ("�������� (3 �������)", "YFAUUN_ITAR_NEUTRALM"); --- ������� ������� ������
	SetCraftAmount("YFAUUN_ITAR_NEUTRALM", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_NEUTRALM", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_NEUTRALM", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRALM", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRALM", "��������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRALM", 75);
	SetCraftEXP("YFAUUN_ITAR_NEUTRALM", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRALM", "��������")
	
AddItemCategory ("�������� (3 �������)", "YFAUUN_ITAR_PIR_M_Addon"); --- ������� ������� ������
	SetCraftAmount("YFAUUN_ITAR_PIR_M_Addon", 1);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_ITAR_PIR_M_Addon", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_PIR_M_Addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_PIR_M_Addon", 10);
	SetCraftScience("YFAUUN_ITAR_PIR_M_Addon", "��������", 3);
	SetenergyPenalty("YFAUUN_ITAR_PIR_M_Addon", 75);
	SetCraftEXP("YFAUUN_ITAR_PIR_M_Addon", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_PIR_M_Addon", "��������")
	
AddItemCategory ("�������� (3 �������)", "yfauun_itar_sld_l_g2"); --- ������� ������� ��������
	SetCraftAmount("yfauun_itar_sld_l_g2", 1);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_qleather", 5);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_itar_sld_l_g2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_sld_l_g2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_sld_l_g2", 10);
	SetCraftScience("yfauun_itar_sld_l_g2", "��������", 3);
	SetenergyPenalty("yfauun_itar_sld_l_g2", 75);
	SetCraftEXP("yfauun_itar_sld_l_g2", 75)
	SetCraftEXP_SKILL("yfauun_itar_sld_l_g2", "��������")	
	
AddItemCategory ("�������� (3 �������)", "YFAUUN_ORG_NEWCAMP_H"); --- ������� ������� ���� 
	SetCraftAmount("YFAUUN_ORG_NEWCAMP_H", 1);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ORG_NEWCAMP_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ORG_NEWCAMP_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ORG_NEWCAMP_H", 10);
	SetCraftScience("YFAUUN_ORG_NEWCAMP_H", "��������", 3);
	SetenergyPenalty("YFAUUN_ORG_NEWCAMP_H", 75);
	SetCraftEXP("YFAUUN_ORG_NEWCAMP_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ORG_NEWCAMP_H", "��������")
	
AddItemCategory ("�������� (3 �������)", "YFAUUN_ITAR_OLDCAMP_M"); --- ������� ������� ��������
	SetCraftAmount("YFAUUN_ITAR_OLDCAMP_M", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "ooltyb_itmi_qleather", 5);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("YFAUUN_ITAR_OLDCAMP_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMP_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMP_M", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMP_M", "��������", 3);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMP_M", 75);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMP_M", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMP_M", "��������")

AddItemCategory ("�������� (3 �������)", "jar_itar_popochka3"); --- ������� ������� ������������
	SetCraftAmount("jar_itar_popochka3", 1);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_qleather", 5);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_m_wire", 3);
	 AddIngre("jar_itar_popochka3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("jar_itar_popochka3", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("jar_itar_popochka3", "OOLTYB_ITMI_JAR1");
	SetCraftPenalty("jar_itar_popochka3", 10);
	SetCraftScience("jar_itar_popochka3", "��������", 3);
	SetenergyPenalty("jar_itar_popochka3", 75);
	SetCraftEXP("jar_itar_popochka3", 75)
	SetCraftEXP_SKILL("jar_itar_popochka3", "��������")

AddItemCategory ("�������� (3 �������)", "ITAR_ARX_H2"); --- ������� ������� �������� �������
	SetCraftAmount("ITAR_ARX_H2", 1);
	 AddIngre("ITAR_ARX_H2", "ooltyb_itmi_qleather", 5);
	 AddIngre("ITAR_ARX_H2", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("ITAR_ARX_H2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("ITAR_ARX_H2", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("ITAR_ARX_H2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_ARX_H2", 10);
	SetCraftScience("ITAR_ARX_H2", "��������", 3);
	SetenergyPenalty("ITAR_ARX_H2", 75);
	SetCraftEXP("ITAR_ARX_H2", 75)
	SetCraftEXP_SKILL("ITAR_ARX_H2", "��������")
	
AddItemCategory ("�������� (3 �������)", "itar_syn_djgl"); --- ������� ������� ���������
	SetCraftAmount("itar_syn_djgl", 1);
	 AddIngre("itar_syn_djgl", "ooltyb_itmi_qleather", 5);
	 AddIngre("itar_syn_djgl", "OOLTYB_ITMI_RIVET", 3);
	 AddIngre("itar_syn_djgl", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_syn_djgl", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_djgl", 10);
	SetCraftScience("itar_syn_djgl", "��������", 3);
	SetenergyPenalty("itar_syn_djgl", 75);
	SetCraftEXP("itar_syn_djgl", 75)
	SetCraftEXP_SKILL("itar_syn_djgl", "��������")

-- �������� 4 ������ ������� �� 40 ������

AddItemCategory ("�������� (4 �������)", "yfauun_itar_pir_h_addon"); --- ������� ������� ������
	SetCraftAmount("yfauun_itar_pir_h_addon", 1);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_pir_h_addon", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_pir_h_addon", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_pir_h_addon", 10);
	SetCraftScience("yfauun_itar_pir_h_addon", "��������", 4);
	SetenergyPenalty("yfauun_itar_pir_h_addon", 100);

AddItemCategory ("�������� (4 �������)", "yfauun_itar_kllr_h"); --- ������� ������� ������
	SetCraftAmount("yfauun_itar_kllr_h", 1);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_kllr_h", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_kllr_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kllr_h", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_kllr_h", 10);
	SetCraftScience("yfauun_itar_kllr_h", "��������", 4);
	SetenergyPenalty("yfauun_itar_kllr_h", 100);

AddItemCategory ("�������� (4 �������)", "yfauun_itar_orchunterh"); --- ����� ���������
	SetCraftAmount("yfauun_itar_orchunterh", 1);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_orchunterh", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_orchunterh", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_orchunterh", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_orchunterh", 10);
	SetCraftScience("yfauun_itar_orchunterh", "��������", 4);
	SetenergyPenalty("yfauun_itar_orchunterh", 100);
	
AddItemCategory ("�������� (4 �������)", "yfauun_itar_neutral12"); --- ���������� ������� �����
	SetCraftAmount("yfauun_itar_neutral12", 1);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_qleather", 16);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_alchemy_syrianoil_01", 8);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_m_wire", 8);
	 AddIngre("yfauun_itar_neutral12", "ooltyb_itmi_whool_holst", 8);
	 AddIngre("yfauun_itar_neutral12", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_neutral12", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_neutral12", 10);
	SetCraftScience("yfauun_itar_neutral12", "��������", 4);
	SetenergyPenalty("yfauun_itar_neutral12", 100);

-- ������� 1 �������� ������

AddItemCategory ("������� (�������� ������)", "rc_house_otherstand"); ----- ������ ��� �����
	SetCraftAmount("rc_house_otherstand", 1);
	 AddIngre("rc_house_otherstand", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("rc_house_otherstand", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("rc_house_otherstand", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_otherstand", 5);
	SetCraftScience("rc_house_otherstand", "�������", 1);
	SetenergyPenalty("rc_house_otherstand", 25);
	SetCraftEXP("rc_house_otherstand", 25)
	SetCraftEXP_SKILL("rc_house_otherstand", "�������")
	
AddItemCategory ("������� (�������� ������)", "rc_house_armchair_rofl"); ----- ������ � ������
	SetCraftAmount("rc_house_armchair_rofl", 1);
	 AddIngre("rc_house_armchair_rofl", "OOLTYB_ItMi_Iron", 10);
	 AddIngre("rc_house_armchair_rofl", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_armchair_rofl", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_armchair_rofl", 5);
	SetCraftScience("rc_house_armchair_rofl", "�������", 1);
	SetenergyPenalty("rc_house_armchair_rofl", 25);
	SetCraftEXP("rc_house_armchair_rofl", 25)
	SetCraftEXP_SKILL("rc_house_armchair_rofl", "�������")
	
AddItemCategory ("������� (�������� ������)", "rc_house_stand_armor_9"); ----- ��������� ����� � ��������
	SetCraftAmount("rc_house_stand_armor_9", 1);
	 AddIngre("rc_house_stand_armor_9", "ooltyb_itat_wolffur", 2);
	 AddIngre("rc_house_stand_armor_9", "ooltyb_itmi_wood", 10);
	 AddTool("rc_house_stand_armor_9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("rc_house_stand_armor_9", 5);
	SetCraftScience("rc_house_stand_armor_9", "�������", 1);
	SetenergyPenalty("rc_house_stand_armor_9", 25);
	SetCraftEXP("rc_house_stand_armor_9", 25)
	SetCraftEXP_SKILL("rc_house_stand_armor_9", "�������")

-- ������� 1 ������ ���������� � �����������

AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_S_IGNOT"); ----- ������
	SetCraftAmount("OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_Iron", 15);
	 AddIngre("OOLTYB_ITMI_S_IGNOT", "OOLTYB_ItMi_CoaL", 5);
	 AddTool("OOLTYB_ITMI_S_IGNOT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_S_IGNOT", 5);
	SetCraftScience("OOLTYB_ITMI_S_IGNOT", "�������", 1);
	SetenergyPenalty("OOLTYB_ITMI_S_IGNOT", 25);
	SetCraftEXP("OOLTYB_ITMI_S_IGNOT", 25)
	SetCraftEXP_SKILL("OOLTYB_ITMI_S_IGNOT", "�������")
	

AddItemCategory ("������� (1 �������)", "yvnzmz_itmi_zamok"); --- �����
	SetCraftAmount("yvnzmz_itmi_zamok", 1);
	 AddIngre("yvnzmz_itmi_zamok", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("yvnzmz_itmi_zamok", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yvnzmz_itmi_zamok", 5);
	SetCraftScience("yvnzmz_itmi_zamok", "�������", 1);
	SetenergyPenalty("yvnzmz_itmi_zamok", 25);
	SetCraftEXP("yvnzmz_itmi_zamok", 25)
	SetCraftEXP_SKILL("yvnzmz_itmi_zamok", "�������")


AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_2H_Axe_L_01"); ---- �����
	SetCraftAmount("JKZTZD_ItMw_2H_Axe_L_01", 1);
	 AddIngre("JKZTZD_ItMw_2H_Axe_L_01", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_2H_Axe_L_01", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_2H_Axe_L_01", 2);
	SetCraftScience("JKZTZD_ItMw_2H_Axe_L_01", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_2H_Axe_L_01", 25);
	SetCraftEXP("JKZTZD_ItMw_2H_Axe_L_01", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_2H_Axe_L_01", "�������")
	
AddItemCategory ("������� (1 �������)", "JKZTZD_ItMw_1h_Bau_Axe"); ---- ����
	SetCraftAmount("JKZTZD_ItMw_1h_Bau_Axe", 1);
	 AddIngre("JKZTZD_ItMw_1h_Bau_Axe", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("JKZTZD_ItMw_1h_Bau_Axe", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("JKZTZD_ItMw_1h_Bau_Axe", 2);
	SetCraftScience("JKZTZD_ItMw_1h_Bau_Axe", "�������", 1);
	SetenergyPenalty("JKZTZD_ItMw_1h_Bau_Axe", 25);
	SetCraftEXP("JKZTZD_ItMw_1h_Bau_Axe", 25)
	SetCraftEXP_SKILL("JKZTZD_ItMw_1h_Bau_Axe", "�������")

	
AddItemCategory ("������� (1 �������)", "OOLTYB_ItMi_PaN"); --- ����������
	SetCraftAmount("OOLTYB_ItMi_PaN", 1);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ItMi_Iron", 5);
	 AddIngre("OOLTYB_ItMi_Pan", "OOLTYB_ITMI_WOOD", 5)
	 AddTool("OOLTYB_ItMi_Pan", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMi_Pan", 2);
	SetCraftScience("OOLTYB_ItMi_Pan", "�������", 1);
	SetenergyPenalty("OOLTYB_ItMi_Pan", 10);
	SetCraftEXP("OOLTYB_ItMi_Pan", 10)
	SetCraftEXP_SKILL("OOLTYB_ItMi_Pan", "�������")

	
--AddItemCategory ("������� (1 �������)", "OOLTYB_ITMI_SCISSORS"); ---- �������
	--SetCraftAmount("OOLTYB_ITMI_SCISSORS", 1);
	-- AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ItMi_Iron", 5);
	-- AddIngre("OOLTYB_ITMI_SCISSORS", "OOLTYB_ITMI_WOOD", 5)
	-- AddTool("OOLTYB_ITMI_SCISSORS", "JKZTZD_ItMw_1H_Mace_L_04");
	--SetCraftPenalty("OOLTYB_ITMI_SCISSORS", 2);
	--SetCraftScience("OOLTYB_ITMI_SCISSORS", "�������", 1);
	--SetenergyPenalty("OOLTYB_ITMI_SCISSORS", 10);
	--SetCraftEXP("OOLTYB_ITMI_SCISSORS", 10)
	--SetCraftEXP_SKILL("OOLTYB_ITMI_SCISSORS", "�������")	
	
	
AddItemCategory ("������� (1 �������)", "YVNZMZ_ITMI_NEEDLE"); --- ����
	SetCraftAmount("YVNZMZ_ITMI_NEEDLE", 1);
	 AddIngre("YVNZMZ_ITMI_NEEDLE", "OOLTYB_ItMi_Iron", 5);
	 AddTool("YVNZMZ_ITMI_NEEDLE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YVNZMZ_ITMI_NEEDLE", 2);
	SetCraftScience("YVNZMZ_ITMI_NEEDLE", "�������", 1);
	SetenergyPenalty("YVNZMZ_ITMI_NEEDLE", 10);	
	SetCraftEXP("YVNZMZ_ITMI_NEEDLE", 10)
	SetCraftEXP_SKILL("YVNZMZ_ITMI_NEEDLE", "�������")	

-- ������� 1 ������ ����� �� 10 ������

AddItemCategory ("������� (1 �������)", "YFAUUN_ItAr_RANGER_H"); --- �������� � ������� �������
	SetCraftAmount("YFAUUN_ItAr_RANGER_H", 1);
	 AddIngre("YFAUUN_ItAr_RANGER_H", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_RANGER_H", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_RANGER_H", 10);
	SetCraftScience("YFAUUN_ItAr_RANGER_H", "�������", 1);
	SetenergyPenalty("YFAUUN_ItAr_RANGER_H", 25);
	SetCraftEXP("YFAUUN_ItAr_RANGER_H", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_RANGER_H", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ItAr_GHRB"); --- ���������� �������
	SetCraftAmount("YFAUUN_ItAr_GHRB", 1);
	 AddIngre("YFAUUN_ItAr_GHRB", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ItAr_GHRB", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_GHRB", 10);
	SetCraftScience("YFAUUN_ItAr_GHRB", "�������", 1);
	SetenergyPenalty("YFAUUN_ItAr_GHRB", 25);
	SetCraftEXP("YFAUUN_ItAr_GHRB", 25)
	SetCraftEXP_SKILL("YFAUUN_ItAr_GHRB", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_SLD_ARMOR_L3"); --- ��������� ��������
	SetCraftAmount("YFAUUN_SLD_ARMOR_L3", 1);
	 AddIngre("YFAUUN_SLD_ARMOR_L3", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_SLD_ARMOR_L3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_SLD_ARMOR_L3", 10);
	SetCraftScience("YFAUUN_SLD_ARMOR_L3", "�������", 1);
	SetenergyPenalty("yfauun_sld_armor_l3", 25);
	SetCraftEXP("YFAUUN_SLD_ARMOR_L3", 25)
	SetCraftEXP_SKILL("YFAUUN_SLD_ARMOR_L3", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_OLDCAMPG_L"); --- ������� ���������-����������
	SetCraftAmount("YFAUUN_ITAR_OLDCAMPG_L", 1);
	 AddIngre("YFAUUN_ITAR_OLDCAMPG_L", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("YFAUUN_ITAR_OLDCAMPG_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_OLDCAMPG_L", 10);
	SetCraftScience("YFAUUN_ITAR_OLDCAMPG_L", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_OLDCAMPG_L", 25);
	SetCraftEXP("YFAUUN_ITAR_OLDCAMPG_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_OLDCAMPG_L", "�������")

AddItemCategory ("������� (1 �������)", "jar_ithl_yznik"); --- ������� ������
	SetCraftAmount("jar_ithl_yznik", 1);
	 AddIngre("jar_ithl_yznik", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("jar_ithl_yznik", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jar_ithl_yznik", 10);
	SetCraftScience("jar_ithl_yznik", "�������", 1);
	SetenergyPenalty("jar_ithl_yznik", 25);
	SetCraftEXP("jar_ithl_yznik", 25)
	SetCraftEXP_SKILL("jar_ithl_yznik", "�������")

-- ������� 2 ������ ����������

AddItemCategory ("������� (2 �������)", "OOLTYB_ItMiSwordraw"); ----- ������������ �����
	SetCraftAmount("OOLTYB_ItMiSwordraw", 1);
	 AddIngre("OOLTYB_ItMiSwordraw", "OOLTYB_ITMI_S_IGNOT", 2);
	 AddTool("OOLTYB_ItMiSwordraw", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ItMiSwordraw", 10);
	SetCraftScience("OOLTYB_ItMiSwordraw", "�������", 2);
	SetenergyPenalty("OOLTYB_ItMiSwordraw", 50);
	SetCraftEXP("OOLTYB_ItMiSwordraw", 50)
	SetCraftEXP_SKILL("OOLTYB_ItMiSwordraw", "�������")
	
AddItemCategory ("������� (2 �������)", "OOLTYB_ITMI_RIVET"); ----- ��������
	SetCraftAmount("OOLTYB_ITMI_RIVET", 1);
	 AddIngre("OOLTYB_ITMI_RIVET", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("OOLTYB_ITMI_RIVET", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_RIVET", 10);
	SetCraftScience("OOLTYB_ITMI_RIVET", "�������", 2);
	SetenergyPenalty("OOLTYB_ITMI_RIVET", 50);
	SetCraftEXP("OOLTYB_ITMI_RIVET", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_RIVET", "�������")

AddItemCategory ("������� (2 �������)", "ooltyb_itmi_nail"); ----- ������
	SetCraftAmount("ooltyb_itmi_nail", 1);
	 AddIngre("ooltyb_itmi_nail", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("ooltyb_itmi_nail", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itmi_nail", 10);
	SetCraftScience("ooltyb_itmi_nail", "�������", 2);
	SetenergyPenalty("ooltyb_itmi_nail", 50);
	SetCraftEXP("ooltyb_itmi_nail", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_nail", "�������")

-- ������� 2 ������ ������� �� 20 ������

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_CHAINMAIL"); --- ������ ��������
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ITAR_CHAINMAIL", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL", 50);
	SetCraftEXP("YFAUUN_ITAR_CHAINMAIL", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_CHAINMAIL", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ItAr_ALBINO"); --- ������� ���������
	SetCraftAmount("YFAUUN_ItAr_ALBINO", 1);
	 AddIngre("YFAUUN_ItAr_ALBINO", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ItAr_ALBINO", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_ALBINO", 10);
	SetCraftScience("YFAUUN_ItAr_ALBINO", "�������", 2);
	SetenergyPenalty("YFAUUN_ItAr_ALBINO", 50);
	SetCraftEXP("YFAUUN_ItAr_ALBINO", 50)
	SetCraftEXP_SKILL("YFAUUN_ItAr_ALBINO", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_itar_oldcampg_m"); --- ������ ������� ���������
	SetCraftAmount("yfauun_itar_oldcampg_m", 1);
	 AddIngre("yfauun_itar_oldcampg_m", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("yfauun_itar_oldcampg_m", "ooltyb_itmi_m_wire", 1);
	 AddTool("yfauun_itar_oldcampg_m", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_oldcampg_m", 10);
	SetCraftScience("yfauun_itar_oldcampg_m", "�������", 2);
	SetenergyPenalty("yfauun_itar_oldcampg_m", 50);
	SetCraftEXP("yfauun_itar_oldcampg_m", 50)
	SetCraftEXP_SKILL("yfauun_itar_oldcampg_m", "�������")	
	
AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_NEWCAMPM_L"); --- ������ ������� ��������
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_L", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_L", "ooltyb_itmi_m_wire", 1);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_L", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_L", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_L", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_L", 50);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMPM_L", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMPM_L", "�������")	
	
AddItemCategory ("������� (2 �������)", "itar_arx_b"); --- ������ ������� �������� �������
	SetCraftAmount("itar_arx_b", 1);
	 AddIngre("itar_arx_b", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("itar_arx_b", "ooltyb_itmi_m_wire", 1);
	 AddTool("itar_arx_b", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("itar_arx_b", "OOLTYB_ITMI_RECIPEAR");
	SetCraftPenalty("itar_arx_b", 10);
	SetCraftScience("itar_arx_b", "�������", 2);
	SetenergyPenalty("itar_arx_b", 50);
	SetCraftEXP("itar_arx_b", 50)
	SetCraftEXP_SKILL("itar_arx_b", "�������")
	
AddItemCategory ("������� (2 �������)", "ITAR_BES_DOSP2"); --- ������ ������� ����� �����������
	SetCraftAmount("ITAR_BES_DOSP2", 1);
	 AddIngre("ITAR_BES_DOSP2", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("ITAR_BES_DOSP2", "ooltyb_itmi_m_wire", 1);
	 AddTool("ITAR_BES_DOSP2", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("ITAR_BES_DOSP2", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP2", 10);
	SetCraftScience("ITAR_BES_DOSP2", "�������", 2);
	SetenergyPenalty("ITAR_BES_DOSP2", 50);
	SetCraftEXP("ITAR_BES_DOSP2", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP2", "�������")
	
AddItemCategory ("������� (2 �������)", "yfauun_itar_circlewl"); --- ������ ������� ����� ����
	SetCraftAmount("yfauun_itar_circlewl", 1);
	 AddIngre("yfauun_itar_circlewl", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("yfauun_itar_circlewl", "ooltyb_itmi_m_wire", 1);
	 AddTool("yfauun_itar_circlewl", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("yfauun_itar_circlewl", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_circlewl", 10);
	SetCraftScience("yfauun_itar_circlewl", "�������", 2);
	SetenergyPenalty("yfauun_itar_circlewl", 50);
	SetCraftEXP("yfauun_itar_circlewl", 50)
	SetCraftEXP_SKILL("yfauun_itar_circlewl", "�������")
	
AddItemCategory ("������� (2 �������)", "itar_pal_zact2"); --- ������ ������� ������ ������
	SetCraftAmount("itar_pal_zact2", 1);
	 AddIngre("itar_pal_zact2", "OOLTYB_ITMI_S_IGNOT", 4);
	 AddIngre("itar_pal_zact2", "ooltyb_itmi_m_wire", 1);
	 AddTool("itar_pal_zact2", "JKZTZD_ItMw_1H_Mace_L_04");
	 AddTool("itar_pal_zact2", "ooltyb_itmi_recipe2");
	SetCraftPenalty("itar_pal_zact2", 10);
	SetCraftScience("itar_pal_zact2", "�������", 2);
	SetenergyPenalty("itar_pal_zact2", 50);
	SetCraftEXP("itar_pal_zact2", 50)
	SetCraftEXP_SKILL("itar_pal_zact2", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_ithl_m_helmet1"); -- �������� ����
   SetCraftAmount("yfauun_ithl_m_helmet1", 1);
    AddIngre("yfauun_ithl_m_helmet1", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet1", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet1", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet1", 10);
   SetCraftScience("yfauun_ithl_m_helmet1", "�������", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet1", 25);
   SetCraftEXP("yfauun_ithl_m_helmet1", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet1", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_ithl_m_helmet2"); -- ���� ��������
   SetCraftAmount("yfauun_ithl_m_helmet2", 1);
    AddIngre("yfauun_ithl_m_helmet2", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet2", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet2", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet2", 10);
   SetCraftScience("yfauun_ithl_m_helmet2", "�������", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet2", 25);
   SetCraftEXP("yfauun_ithl_m_helmet2", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet2", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_ithl_m_helmet3"); -- ���� �������
   SetCraftAmount("yfauun_ithl_m_helmet3", 1);
    AddIngre("yfauun_ithl_m_helmet3", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet3", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet3", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet3", 10);
   SetCraftScience("yfauun_ithl_m_helmet3", "�������", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet3", 25);
   SetCraftEXP("yfauun_ithl_m_helmet3", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet3", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_ithl_m_helmet4"); -- ������� ����
   SetCraftAmount("yfauun_ithl_m_helmet4", 1);
    AddIngre("yfauun_ithl_m_helmet4", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet4", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet4", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet4", 10);
   SetCraftScience("yfauun_ithl_m_helmet4", "�������", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet4", 25);
   SetCraftEXP("yfauun_ithl_m_helmet4", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet4", "�������")

AddItemCategory ("������� (2 �������)", "yfauun_ithl_m_helmet5"); -- ������ ����
   SetCraftAmount("yfauun_ithl_m_helmet5", 1);
    AddIngre("yfauun_ithl_m_helmet5", "OOLTYB_ITMI_S_IGNOT", 2); 
    AddIngre("yfauun_ithl_m_helmet5", "ooltyb_itmi_m_wire", 1);
    AddTool("yfauun_ithl_m_helmet5", "JKZTZD_ItMw_1H_Mace_L_04");
   SetCraftPenalty("yfauun_ithl_m_helmet5", 10);
   SetCraftScience("yfauun_ithl_m_helmet5", "�������", 2);
   SetenergyPenalty("yfauun_ithl_m_helmet5", 25);
   SetCraftEXP("yfauun_ithl_m_helmet5", 25)
   SetCraftEXP_SKILL("yfauun_ithl_m_helmet5", "�������")

-- ������� 3 ������ ����������

AddItemCategory ("������� (3 �������)", "ooltyb_itke_lockpick"); --- �������
	SetCraftAmount("ooltyb_itke_lockpick", 1);
	 AddIngre("ooltyb_itke_lockpick", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddTool("ooltyb_itke_lockpick", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ooltyb_itke_lockpick", 5);
	SetCraftScience("ooltyb_itke_lockpick", "�������", 3);
	SetenergyPenalty("ooltyb_itke_lockpick", 50);
	SetCraftEXP("ooltyb_itke_lockpick", 50)
	SetCraftEXP_SKILL("ooltyb_itke_lockpick", "�������")

AddItemCategory ("������� (3 �������)", "OOLTYB_ITMI_BIJOUTERIE"); ----- ���������
	SetCraftAmount("OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_GoldNugget_Addon", 2);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ITMI_S_IGNOT", 1);
	 AddAlterIngre("OOLTYB_ITMI_BIJOUTERIE", "OOLTYB_ItMi_SilverNugget", 2);
	 AddTool("OOLTYB_ITMI_BIJOUTERIE", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("OOLTYB_ITMI_BIJOUTERIE", 10);
	SetCraftScience("OOLTYB_ITMI_BIJOUTERIE", "�������", 3);
	SetenergyPenalty("OOLTYB_ITMI_BIJOUTERIE", 50);
	SetCraftEXP("OOLTYB_ITMI_BIJOUTERIE", 50)
	SetCraftEXP_SKILL("OOLTYB_ITMI_BIJOUTERIE", "�������")
	
-- ������� 3 ������ ������� �� 30 ������
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ItAr_FKNGHT"); --- ����� �������� ������
	SetCraftAmount("YFAUUN_ItAr_FKNGHT", 1);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_FKNGHT", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_FKNGHT", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_FKNGHT", 10);
	SetCraftScience("YFAUUN_ItAr_FKNGHT", "�������", 3);
	SetenergyPenalty("YFAUUN_ItAr_FKNGHT", 75);
	SetCraftEXP("YFAUUN_ItAr_FKNGHT", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_FKNGHT", "�������")
	
AddItemCategory ("������� (3 �������)", "yfauun_grd_armor_hb"); --- ������� ��������
	SetCraftAmount("yfauun_grd_armor_hb", 1);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("yfauun_grd_armor_hb", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_grd_armor_hb", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_grd_armor_hb", 10);
	SetCraftScience("yfauun_grd_armor_hb", "�������", 3);
	SetenergyPenalty("yfauun_grd_armor_hb", 75);
	SetCraftEXP("yfauun_grd_armor_hb", 75)
	SetCraftEXP_SKILL("yfauun_grd_armor_hb", "�������")
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ItAr_HRB_H"); --- ������� ��������
	SetCraftAmount("YFAUUN_ItAr_HRB_H", 1);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ItAr_HRB_H", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ItAr_HRB_H", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ItAr_HRB_H", 10);
	SetCraftScience("YFAUUN_ItAr_HRB_H", "�������", 3);
	SetenergyPenalty("YFAUUN_ItAr_HRB_H", 75);
	SetCraftEXP("YFAUUN_ItAr_HRB_H", 75)
	SetCraftEXP_SKILL("YFAUUN_ItAr_HRB_H", "�������")
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_CHAINMAIL2"); --- �������� � �����������
	SetCraftAmount("YFAUUN_ITAR_CHAINMAIL2", 1);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_CHAINMAIL2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_CHAINMAIL2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_CHAINMAIL2", 10);
	SetCraftScience("YFAUUN_ITAR_CHAINMAIL2", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_CHAINMAIL2", 75);
	SetCraftEXP("YFAUUN_ITAR_CHAINMAIL2", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_CHAINMAIL2", "�������")
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWCAMPM_M"); --- ������� ������� ��������
	SetCraftAmount("YFAUUN_ITAR_NEWCAMPM_M", 1);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmiswordraw", 4);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmi_m_wire", 3);
	 AddIngre("YFAUUN_ITAR_NEWCAMPM_M", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("YFAUUN_ITAR_NEWCAMPM_M", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("YFAUUN_ITAR_NEWCAMPM_M", 10);
	SetCraftScience("YFAUUN_ITAR_NEWCAMPM_M", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWCAMPM_M", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWCAMPM_M", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWCAMPM_M", "�������")
	
AddItemCategory ("������� (3 �������)", "yfauun_grd_armor_h"); --- ������� ������� ���������
	SetCraftAmount("yfauun_grd_armor_h", 1);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmi_m_wire", 3);
	 AddIngre("yfauun_grd_armor_h", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_grd_armor_h", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_grd_armor_h", 10);
	SetCraftScience("yfauun_grd_armor_h", "�������", 3);
	SetenergyPenalty("yfauun_grd_armor_h", 75);
	SetCraftEXP("yfauun_grd_armor_h", 75)
	SetCraftEXP_SKILL("yfauun_grd_armor_h", "�������")
	
AddItemCategory ("������� (3 �������)", "itar_arx_w1"); --- ������� ������� �������� �������
	SetCraftAmount("itar_arx_w1", 1);
	 AddIngre("itar_arx_w1", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_arx_w1", "ooltyb_itmi_m_wire", 3);
	 AddIngre("itar_arx_w1", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_arx_w1", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_w1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_arx_w1", 10);
	SetCraftScience("itar_arx_w1", "�������", 3);
	SetenergyPenalty("itar_arx_w1", 75);
	SetCraftEXP("itar_arx_w1", 75)
	SetCraftEXP_SKILL("itar_arx_w1", "�������")
	
AddItemCategory ("������� (3 �������)", "ITAR_BES_DOSP3"); --- ������� ������� ����� �����������
	SetCraftAmount("ITAR_BES_DOSP3", 1);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmiswordraw", 4);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("ITAR_BES_DOSP3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("ITAR_BES_DOSP3", "OOLTYB_ITMI_RECIPEBES");
	 AddTool("ITAR_BES_DOSP3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("ITAR_BES_DOSP3", 10);
	SetCraftScience("ITAR_BES_DOSP3", "�������", 3);
	SetenergyPenalty("ITAR_BES_DOSP3", 75);
	SetCraftEXP("ITAR_BES_DOSP3", 75)
	SetCraftEXP_SKILL("ITAR_BES_DOSP3", "�������")
	
AddItemCategory ("������� (3 �������)", "itar_mil_a_l2"); --- ����������� ������� ���������-�����������
	SetCraftAmount("itar_mil_a_l2", 1);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_mil_a_l2", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_mil_a_l2", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l2", 10);
	SetCraftScience("itar_mil_a_l2", "�������", 3);
	SetenergyPenalty("itar_mil_a_l2", 75);
	SetCraftEXP("itar_mil_a_l2", 75)
	SetCraftEXP_SKILL("itar_mil_a_l2", "�������")
	
AddItemCategory ("������� (3 �������)", "itar_mil_a_l7"); --- ����������� ������� ���������-�������
	SetCraftAmount("itar_mil_a_l7", 1);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_mil_a_l7", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_mil_a_l7", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l7", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l7", 10);
	SetCraftScience("itar_mil_a_l7", "�������", 3);
	SetenergyPenalty("itar_mil_a_l7", 75);
	SetCraftEXP("Yitar_mil_a_l7", 75)
	SetCraftEXP_SKILL("itar_mil_a_l7", "�������")
	
AddItemCategory ("������� (3 �������)", "yfauun_itar_circlewh"); --- ������� ������� ����� ����
	SetCraftAmount("yfauun_itar_circlewh", 1);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmiswordraw", 4);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("yfauun_itar_circlewh", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("yfauun_itar_circlewh", "ooltyb_itmi_recipe1");
	 AddTool("yfauun_itar_circlewh", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_circlewh", 10);
	SetCraftScience("yfauun_itar_circlewh", "�������", 3);
	SetenergyPenalty("yfauun_itar_circlewh", 75);
	SetCraftEXP("Yyfauun_itar_circlewh", 75)
	SetCraftEXP_SKILL("yfauun_itar_circlewh", "�������")
	
AddItemCategory ("������� (3 �������)", "itar_pal_zact3"); --- ������� ������� ������ ������
	SetCraftAmount("itar_pal_zact3", 1);
	 AddIngre("itar_pal_zact3", "ooltyb_itmiswordraw", 4);
	 AddIngre("itar_pal_zact3", "ooltyb_itmi_whool_holst", 3);
	 AddIngre("itar_pal_zact3", "ooltyb_itmi_alchemy_syrianoil_01", 2);
	 AddTool("itar_pal_zact3", "ooltyb_itmi_recipe2");
	 AddTool("itar_pal_zact3", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_pal_zact3", 10);
	SetCraftScience("itar_pal_zact3", "�������", 3);
	SetenergyPenalty("itar_pal_zact3", 75);
	SetCraftEXP("Yitar_pal_zact3", 75)
	SetCraftEXP_SKILL("itar_pal_zact3", "�������")
	
-- ������� 4 ������ ������� �� 40 ������

AddItemCategory ("������� (4 �������)", "yfauun_itar_neutral16"); --- ����������� ������ �������
	SetCraftAmount("yfauun_itar_neutral16", 1);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_neutral16", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_neutral16", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_neutral16", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_neutral16", 10);
	SetCraftScience("yfauun_itar_neutral16", "�������", 4);
	SetenergyPenalty("yfauun_itar_neutral16", 100);

AddItemCategory ("������� (4 �������)", "yfauun_itar_champion"); --- ����� ��������
	SetCraftAmount("yfauun_itar_champion", 1);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_champion", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_champion", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_champion", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_champion", 10);
	SetCraftScience("yfauun_itar_champion", "�������", 4);
	SetenergyPenalty("yfauun_itar_champion", 100);
	
AddItemCategory ("������� (4 �������)", "yfauun_itar_frontier9"); --- �������� ��������� �������
	SetCraftAmount("yfauun_itar_frontier9", 1);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_frontier9", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_frontier9", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_frontier9", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_frontier9", 10);
	SetCraftScience("yfauun_itar_frontier9", "�������", 4);
	SetenergyPenalty("yfauun_itar_frontier9", 100);
	
AddItemCategory ("������� (4 �������)", "yfauun_itar_dospcoman"); --- ����� ���������
	SetCraftAmount("yfauun_itar_dospcoman", 1);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_dospcoman", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_dospcoman", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_dospcoman", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_dospcoman", 10);
	SetCraftScience("yfauun_itar_dospcoman", "�������", 4);
	SetenergyPenalty("yfauun_itar_dospcoman", 100);	

AddItemCategory ("������� (4 �������)", "itar_arx_w2"); --- ������� ������� �������� �������
	SetCraftAmount("itar_arx_w2", 1);
	 AddIngre("itar_arx_w2", "ooltyb_itmiswordraw", 15);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_m_wire", 6);
	 AddIngre("itar_arx_w2", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("itar_arx_w2", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("itar_arx_w2", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_arx_w2", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_arx_w2", 10);
	SetCraftScience("itar_arx_w2", "�������", 4);
	SetenergyPenalty("itar_arx_w2", 100);
	
AddItemCategory ("������� (4 �������)", "yfauun_itar_pal_m"); --- ������� ������-��������
	SetCraftAmount("yfauun_itar_pal_m", 1);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmiswordraw", 15);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_m_wire", 6);
	 AddIngre("yfauun_itar_pal_m", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("yfauun_itar_pal_m", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_pal_m", "ooltyb_itmi_recipe2");
	 AddTool("yfauun_itar_pal_m", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("yfauun_itar_pal_m", 10);
	SetCraftScience("yfauun_itar_pal_m", "�������", 4);
	SetenergyPenalty("yfauun_itar_pal_m", 100);
	
AddItemCategory ("������� (4 �������)", "jar_itar_popochka4_1"); --- ������� ������� ������������
	SetCraftAmount("jar_itar_popochka4_1", 1);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmiswordraw", 15);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_m_wire", 6);
	 AddIngre("jar_itar_popochka4_1", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("jar_itar_popochka4_1", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("jar_itar_popochka4_1", "OOLTYB_ITMI_JAR1");
	 AddTool("jar_itar_popochka4_1", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("jar_itar_popochka4_1", 10);
	SetCraftScience("jar_itar_popochka4_1", "�������", 4);
	SetenergyPenalty("jar_itar_popochka4_1", 100);
	
AddItemCategory ("������� (4 �������)", "itar_mil_a_l8n"); --- ���������� ������� ���������
	SetCraftAmount("itar_mil_a_l8n", 1);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmiswordraw", 15);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_whool_holst", 6);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_m_wire", 6);
	 AddIngre("itar_mil_a_l8n", "ooltyb_itmi_alchemy_syrianoil_01", 6);
	 AddIngre("itar_mil_a_l8n", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("itar_mil_a_l8n", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l8n", "JKZTZD_ItMw_1H_Mace_L_04");
	SetCraftPenalty("itar_mil_a_l8n", 10);
	SetCraftScience("itar_mil_a_l8n", "�������", 4);
	SetenergyPenalty("itar_mil_a_l8n", 100);

-- ������� 1 �������� ������

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_BED_BAD"); --- ������ �������
	SetCraftAmount("RC_HOUSE_BED_BAD", 1);
	 AddIngre("RC_HOUSE_BED_BAD", "OOLTYB_ITMI_WOOD", 20);
	 AddTool("RC_HOUSE_BED_BAD", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_BED_BAD", 5);
	SetCraftScience("RC_HOUSE_BED_BAD", "�������", 1);
	SetenergyPenalty("RC_HOUSE_BED_BAD", 25);
	SetCraftEXP("RC_HOUSE_BED_BAD", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BED_BAD", "�������")
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_BED_POOR"); --- ������ �������
	SetCraftAmount("RC_HOUSE_BED_POOR", 1);
	 AddIngre("RC_HOUSE_BED_POOR", "OOLTYB_ITMI_WOOD", 10);
	 AddIngre("RC_HOUSE_BED_POOR", "OOLTYB_ITMI_SHEEP", 5);
	 AddTool("RC_HOUSE_BED_POOR", "JKZTZD_ItMw_1h_Vlk_AxE");
	SetCraftPenalty("RC_HOUSE_BED_POOR", 5);
	SetCraftScience("RC_HOUSE_BED_POOR", "�������", 1);
	SetenergyPenalty("RC_HOUSE_BED_POOR", 25);
	SetCraftEXP("RC_HOUSE_BED_POOR", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BED_POOR", "�������")

AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CARPET_8"); --- ������� ����� 1
    SetCraftAmount("RC_HOUSE_CARPET_8", 1);
     AddIngre("RC_HOUSE_CARPET_8", "OOLTYB_ITMI_SHEEP", 30);
    SetCraftPenalty("RC_HOUSE_CARPET_8", 10);
    SetCraftScience("RC_HOUSE_CARPET_8", "�������", 1);
    SetenergyPenalty("RC_HOUSE_CARPET_8", 25);
    SetCraftEXP("RC_HOUSE_CARPET_8", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CARPET_8", "�������")
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CARPET_9"); --- ������� ����� 2
    SetCraftAmount("RC_HOUSE_CARPET_9", 1);
     AddIngre("RC_HOUSE_CARPET_9", "OOLTYB_ITMI_SHEEP", 30);
    SetCraftPenalty("RC_HOUSE_CARPET_9", 10);
    SetCraftScience("RC_HOUSE_CARPET_9", "�������", 1);
    SetenergyPenalty("RC_HOUSE_CARPET_9", 25);
    SetCraftEXP("RC_HOUSE_CARPET_9", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CARPET_9", "�������")
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_CANVAS_WHITE"); --- ����� ������ (�� �����)
    SetCraftAmount("RC_HOUSE_CANVAS_WHITE", 1);
     AddIngre("RC_HOUSE_CANVAS_WHITE", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_HOUSE_CANVAS_WHITE", 10);
    SetCraftScience("RC_HOUSE_CANVAS_WHITE", "�������", 1);
    SetenergyPenalty("RC_HOUSE_CANVAS_WHITE", 25);
    SetCraftEXP("RC_HOUSE_CANVAS_WHITE", 25)
    SetCraftEXP_SKILL("RC_HOUSE_CANVAS_WHITE", "�������")
	
AddItemCategory ("������� (�������� ������)", "RC_HOUSE_WARE_33"); --- ������������ ���
    SetCraftAmount("RC_HOUSE_WARE_33", 1);
     AddIngre("RC_HOUSE_WARE_33", "ooltyb_itmi_fiber", 1);
	 AddIngre("RC_HOUSE_WARE_33", "ooltyb_itmi_wood", 10);
    SetCraftPenalty("RC_HOUSE_WARE_33", 10);
    SetCraftScience("RC_HOUSE_WARE_33", "�������", 1);
    SetenergyPenalty("RC_HOUSE_WARE_33", 25);
    SetCraftEXP("RC_HOUSE_WARE_33", 25)
    SetCraftEXP_SKILL("RC_HOUSE_WARE_33", "�������")

-- ������� 1 ������� ������������

AddItemCategory ("������� (1 �������)", "RC_BLUE_MASK"); --- ����� �����
    SetCraftAmount("RC_BLUE_MASK", 1);
     AddIngre("RC_BLUE_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_BLUE_MASK", 10);
    SetCraftScience("RC_BLUE_MASK", "�������", 1);
    SetenergyPenalty("RC_BLUE_MASK", 25);
    SetCraftEXP("RC_BLUE_MASK", 25)
    SetCraftEXP_SKILL("RC_BLUE_MASK", "�������")

AddItemCategory ("������� (1 �������)", "RC_DBLUE_MASK"); --- �����-����� �����
    SetCraftAmount("RC_DBLUE_MASK", 1);
     AddIngre("RC_DBLUE_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_DBLUE_MASK", 10);
    SetCraftScience("RC_DBLUE_MASK", "�������", 1);
    SetenergyPenalty("RC_DBLUE_MASK", 25);
    SetCraftEXP("RC_DBLUE_MASK", 25)
    SetCraftEXP_SKILL("RC_DBLUE_MASK", "�������")

AddItemCategory ("������� (1 �������)", "RC_GRAY_MASK"); --- ����� �����
    SetCraftAmount("RC_GRAY_MASK", 1);
     AddIngre("RC_GRAY_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_GRAY_MASK", 10);
    SetCraftScience("RC_GRAY_MASK", "�������", 1);
    SetenergyPenalty("RC_GRAY_MASK", 25);
    SetCraftEXP("RC_GRAY_MASK", 25)
    SetCraftEXP_SKILL("RC_GRAY_MASK", "�������")

AddItemCategory ("������� (1 �������)", "RC_DGREEN_MASK"); --- ������� �����
    SetCraftAmount("RC_DGREEN_MASK", 1);
     AddIngre("RC_DGREEN_MASK", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("RC_DGREEN_MASK", 10);
    SetCraftScience("RC_DGREEN_MASK", "�������", 1);
    SetenergyPenalty("RC_DGREEN_MASK", 25);
    SetCraftEXP("RC_DGREEN_MASK", 25)
    SetCraftEXP_SKILL("RC_DGREEN_MASK", "�������")
	
AddItemCategory ("������� (1 �������)", "yfauun_ithl_l_band"); --- ������� 
    SetCraftAmount("yfauun_ithl_l_band", 1);
     AddIngre("yfauun_ithl_l_band", "ooltyb_itmi_fiber", 1);
    SetCraftPenalty("yfauun_ithl_l_band", 10);
    SetCraftScience("yfauun_ithl_l_band", "�������", 1);
    SetenergyPenalty("yfauun_ithl_l_band", 25);
    SetCraftEXP("yfauun_ithl_l_band", 25)
    SetCraftEXP_SKILL("yfauun_ithl_l_band", "�������")
	
AddItemCategory ("������� (1 �������)", "ooltyb_itmi_palatka"); --- �������
	SetCraftAmount("ooltyb_itmi_palatka", 1);
	 AddIngre("ooltyb_itmi_palatka", "ooltyb_itmi_fiber", 2);
	 AddTool("ooltyb_itmi_palatka", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_palatka", 5);
	SetCraftScience("ooltyb_itmi_palatka", "�������", 1);
	SetenergyPenalty("ooltyb_itmi_palatka", 25);
	SetCraftEXP("ooltyb_itmi_palatka", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_palatka", "�������")
	
AddItemCategory ("������� (1 �������)", "yfauun_itar_torba"); --- �����
	SetCraftAmount("yfauun_itar_torba", 1);
	 AddIngre("yfauun_itar_torba", "ooltyb_itmi_sheep", 10);
	 AddTool("yfauun_itar_torba", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_torba", 5);
	SetCraftScience("yfauun_itar_torba", "�������", 1);
	SetenergyPenalty("yfauun_itar_torba", 15);
	SetCraftEXP("yfauun_itar_torba", 15)
	SetCraftEXP_SKILL("yfauun_itar_torba", "�������")

-- ������� 1 ������� ����������

AddItemCategory ("������� (1 �������)", "ooltyb_itmi_fiber"); --- ����
	SetCraftAmount("ooltyb_itmi_fiber", 1);
	 AddIngre("ooltyb_itmi_fiber", "OOLTYB_ITMI_SHEEP", 10);
	 AddAlterIngre("ooltyb_itmi_fiber", "zdpwla_itpl_swampherb", 10);
	 AddTool("ooltyb_itmi_fiber", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_fiber", 5);
	SetCraftScience("ooltyb_itmi_fiber", "�������", 1);
	SetenergyPenalty("ooltyb_itmi_fiber", 25);
	SetCraftEXP("ooltyb_itmi_fiber", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_fiber", "�������")
	
	
-- -- ������� 1 ������� ������� �� 10 ������

AddItemCategory ("������� (1 �������)", "yfauun_itar_underarmor"); --- ������������
	SetCraftAmount("yfauun_itar_underarmor", 1);
	 AddIngre("yfauun_itar_underarmor", "ooltyb_itmi_fiber", 3);
	 AddTool("yfauun_itar_underarmor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_underarmor", 10);
	SetCraftScience("yfauun_itar_underarmor", "�������", 1);
	SetenergyPenalty("yfauun_itar_underarmor", 25);
	SetCraftEXP("yfauun_itar_underarmor", 25)
	SetCraftEXP_SKILL("yfauun_itar_underarmor", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Smith"); --- ������ �������
	SetCraftAmount("YFAUUN_ITAR_Smith", 1);
	 AddIngre("YFAUUN_ITAR_Smith", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Smith", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Smith", 10);
	SetCraftScience("YFAUUN_ITAR_Smith", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Smith", 25);
	SetCraftEXP("YFAUUN_ITAR_Smith", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Smith", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Barkeeper"); --- ������ �����������
	SetCraftAmount("YFAUUN_ITAR_Barkeeper", 1);
	 AddIngre("YFAUUN_ITAR_Barkeeper", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Barkeeper", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Barkeeper", 10);
	SetCraftScience("YFAUUN_ITAR_Barkeeper", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Barkeeper", 25);
	SetCraftEXP("YFAUUN_ITAR_Barkeeper", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Barkeeper", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Bau_L"); --- ������� ���������� ������
	SetCraftAmount("YFAUUN_ITAR_Bau_L", 1);
	 AddIngre("YFAUUN_ITAR_Bau_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Bau_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Bau_L", 10);
	SetCraftScience("YFAUUN_ITAR_Bau_L", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Bau_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Bau_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Bau_L", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BAU_M"); --- ��������� ������������ ������
	SetCraftAmount("YFAUUN_ITAR_BAU_M", 1);
	 AddIngre("YFAUUN_ITAR_BAU_M", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_M", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_M", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_M", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_M", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BAU_A"); --- ������� ������ �������
	SetCraftAmount("YFAUUN_ITAR_BAU_A", 1);
	 AddIngre("YFAUUN_ITAR_BAU_A", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_A", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_A", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_A", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_A", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_A", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BAU_C"); --- ��������� ������ �������
	SetCraftAmount("YFAUUN_ITAR_BAU_C", 1);
	 AddIngre("YFAUUN_ITAR_BAU_C", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_C", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_C", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_C", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_C", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_C", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BAU_B"); --- ���������� ������ �������
	SetCraftAmount("YFAUUN_ITAR_BAU_B", 1);
	 AddIngre("YFAUUN_ITAR_BAU_B", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BAU_B", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BAU_B", 10);
	SetCraftScience("YFAUUN_ITAR_BAU_B", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BAU_B", 25);
	SetCraftEXP("YFAUUN_ITAR_BAU_B", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BAU_B", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Prisoner"); --- ����� ��������
	SetCraftAmount("YFAUUN_ITAR_Prisoner", 1);
	 AddIngre("YFAUUN_ITAR_Prisoner", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Prisoner", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Prisoner", 10);
	SetCraftScience("YFAUUN_ITAR_Prisoner", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Prisoner", 25);
	SetCraftEXP("YFAUUN_ITAR_Prisoner", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Prisoner", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_STANI"); --- ����� ������
	SetCraftAmount("YFAUUN_ITAR_STANI", 1);
	 AddIngre("YFAUUN_ITAR_STANI", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_STANI", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_STANI", 10);
	SetCraftScience("YFAUUN_ITAR_STANI", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_STANI", 25);
	SetCraftEXP("YFAUUN_ITAR_STANI", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_STANI", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_SAILOR"); --- ������� ������ ��������
	SetCraftAmount("YFAUUN_ITAR_SAILOR", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_SAILOR1"); --- ������� ������ ��������
	SetCraftAmount("YFAUUN_ITAR_SAILOR1", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR1", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR1", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR1", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR1", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR1", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR1", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_SAILOR2"); --- ���������� ������ ��������
	SetCraftAmount("YFAUUN_ITAR_SAILOR2", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR2", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR2", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR2", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR2", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR2", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR2", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_SAILOR3"); --- ������ ������ ��������
	SetCraftAmount("YFAUUN_ITAR_SAILOR3", 1);
	 AddIngre("YFAUUN_ITAR_SAILOR3", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_SAILOR3", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_SAILOR3", 10);
	SetCraftScience("YFAUUN_ITAR_SAILOR3", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_SAILOR3", 25);
	SetCraftEXP("YFAUUN_ITAR_SAILOR3", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_SAILOR3", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Vlk_L"); --- ���������� ������
	SetCraftAmount("YFAUUN_ITAR_Vlk_L", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Vlk_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_L", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_L", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_L", 25);
	SetCraftEXP("YFAUUN_ITAR_Vlk_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_L", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_Vlk_H"); --- ������� ������
	SetCraftAmount("YFAUUN_ITAR_Vlk_H", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_H", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_Vlk_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_H", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_H", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_H", 25);
	SetCraftEXP("YFAUUN_ITAR_Vlk_H", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_H", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VLK_Y"); --- ������ ������
	SetCraftAmount("YFAUUN_ITAR_VLK_Y", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Y", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VLK_Q"); --- ������ ������
	SetCraftAmount("YFAUUN_ITAR_VLK_Q", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Q", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Q", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Q", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Q", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Q", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Q", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Q", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VLK_W"); --- ����� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_W", 1);
	 AddIngre("YFAUUN_ITAR_VLK_W", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_W", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_W", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_W", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_W", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_W", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_W", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VLK_Y1"); --- ������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_Y1", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Y1", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_Y1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Y1", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_Y1", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Y1", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_Y1", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Y1", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VLK_P"); --- ���������� ����
	SetCraftAmount("YFAUUN_ITAR_VLK_P", 1);
	 AddIngre("YFAUUN_ITAR_VLK_P", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VLK_P", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_P", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_P", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VLK_P", 25);
	SetCraftEXP("YFAUUN_ITAR_VLK_P", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_P", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BauBabe_L"); --- ������� ������
	SetCraftAmount("YFAUUN_ITAR_BauBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BauBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_L", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_L", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_L", 25);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_L", "�������")

AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_BauBabe_M"); --- ������� ������
	SetCraftAmount("YFAUUN_ITAR_BauBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_M", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_BauBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_M", 10);
	SetCraftScience("YFAUUN_ITAR_BauBabe_M", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_M", 25);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_M", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_M", "�������")
	
AddItemCategory ("������� (1 �������)", "YFAUUN_ITAR_VlkBabe_L"); --- ������� ������
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_L", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_L", "ooltyb_itmi_fiber", 3);
	 AddTool("YFAUUN_ITAR_VlkBabe_L", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_L", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_L", "�������", 1);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_L", 25);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_L", 25)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_L", "�������")
	
AddItemCategory ("������� (1 �������)", "jar_itar_popochka1"); --- ������ ������������
	SetCraftAmount("jar_itar_popochka1", 1);
	 AddIngre("jar_itar_popochka1", "ooltyb_itmi_fiber", 3);
	 AddTool("jar_itar_popochka1", "OOLTYB_ITMI_JAR1");
	 AddTool("jar_itar_popochka1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("jar_itar_popochka1", 10);
	SetCraftScience("jar_itar_popochka1", "�������", 1);
	SetenergyPenalty("jar_itar_popochka1", 25);
	SetCraftEXP("jar_itar_popochka1", 25)
	SetCraftEXP_SKILL("jar_itar_popochka1", "�������")

AddItemCategory ("������� (1 �������)", "itar_km_rm_hat_02"); --- ������������ ������ �������
	SetCraftAmount("itar_km_rm_hat_02", 1);
	 AddIngre("itar_km_rm_hat_02", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_km_rm_hat_02", "OOLTYB_ITMI_RECIPEAR");
	 AddTool("itar_km_rm_hat_02", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_km_rm_hat_02", 20);
	SetCraftScience("itar_km_rm_hat_02", "�������", 1);
	SetenergyPenalty("itar_km_rm_hat_02", 25);
	SetCraftEXP("itar_km_rm_hat_02", 25)
	SetCraftEXP_SKILL("itar_km_rm_hat_02", "�������")
	
AddItemCategory ("������� (1 �������)", "itar_syn_rab"); --- ������� ������ ���������
	SetCraftAmount("itar_syn_rab", 1);
	 AddIngre("itar_syn_rab", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_syn_rab", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_rab", 20);
	SetCraftScience("itar_syn_rab", "�������", 1);
	SetenergyPenalty("itar_syn_rab", 25);
	SetCraftEXP("itar_syn_rab", 25)
	SetCraftEXP_SKILL("itar_syn_rab", "�������")
	
AddItemCategory ("������� (1 �������)", "ITAR_SYN_DB1"); --- ������ ��������� 1
	SetCraftAmount("ITAR_SYN_DB1", 1);
	 AddIngre("ITAR_SYN_DB1", "ooltyb_itmi_fiber", 3);
	 AddTool("ITAR_SYN_DB1", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_SYN_DB1", 20);
	SetCraftScience("ITAR_SYN_DB1", "�������", 1);
	SetenergyPenalty("ITAR_SYN_DB1", 25);
	SetCraftEXP("ITAR_SYN_DB1", 25)
	SetCraftEXP_SKILL("ITAR_SYN_DB1", "�������")
	
AddItemCategory ("������� (1 �������)", "ITAR_SYN_DB2"); --- ������ ��������� 2
	SetCraftAmount("ITAR_SYN_DB2", 1);
	 AddIngre("ITAR_SYN_DB2", "ooltyb_itmi_fiber", 3);
	 AddTool("ITAR_SYN_DB2", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ITAR_SYN_DB2", 20);
	SetCraftScience("ITAR_SYN_DB2", "�������", 1);
	SetenergyPenalty("ITAR_SYN_DB2", 25);
	SetCraftEXP("ITAR_SYN_DB2", 25)
	SetCraftEXP_SKILL("ITAR_SYN_DB2", "�������")
	
AddItemCategory ("������� (1 �������)", "itar_mil_a_l4"); --- ���������� ������� ���������
	SetCraftAmount("itar_mil_a_l4", 1);
	 AddIngre("itar_mil_a_l4", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_mil_a_l4", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l4", 20);
	SetCraftScience("itar_mil_a_l4", "�������", 1);
	SetenergyPenalty("itar_mil_a_l4", 25);
	SetCraftEXP("itar_mil_a_l4", 25)
	SetCraftEXP_SKILL("itar_mil_a_l4", "�������")
	
AddItemCategory ("������� (1 �������)", "itar_mil_a_l6"); --- ���������� ������� ���������-������
	SetCraftAmount("itar_mil_a_l6", 1);
	 AddIngre("itar_mil_a_l6", "ooltyb_itmi_fiber", 3);
	 AddTool("itar_mil_a_l6", "OOLTYB_ITMI_RECIPEG");
	 AddTool("itar_mil_a_l6", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_mil_a_l6", 20);
	SetCraftScience("itar_mil_a_l6", "�������", 1);
	SetenergyPenalty("itar_mil_a_l6", 25);
	SetCraftEXP("itar_mil_a_l6", 25)
	SetCraftEXP_SKILL("itar_mil_a_l6", "�������")

-- ������� 2 ������� ����������

AddItemCategory ("������� (2 �������)", "ooltyb_itmi_whool_holst"); --- �����
	SetCraftAmount("ooltyb_itmi_whool_holst", 1);
	 AddIngre("ooltyb_itmi_whool_holst", "ooltyb_itmi_fiber", 2);
	 AddTool("ooltyb_itmi_whool_holst", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_whool_holst", 5);
	SetCraftScience("ooltyb_itmi_whool_holst", "�������", 2);
	SetenergyPenalty("ooltyb_itmi_whool_holst", 50);
	SetCraftEXP("ooltyb_itmi_whool_holst", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_whool_holst", "�������")
	
AddItemCategory ("������� (2 �������)", "ooltyb_itmi_linen_holst"); --- ������� �����
	SetCraftAmount("ooltyb_itmi_linen_holst", 1);
	 AddIngre("ooltyb_itmi_linen_holst", "ooltyb_itmi_fiber", 1);
	 AddTool("ooltyb_itmi_linen_holst", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("ooltyb_itmi_linen_holst", 5);
	SetCraftScience("ooltyb_itmi_linen_holst", "�������", 2);
	SetenergyPenalty("ooltyb_itmi_linen_holst", 50);
	SetCraftEXP("ooltyb_itmi_linen_holst", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_linen_holst", "�������")

-- ������� 2 ������� ������� �� 20 ������

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_NEUTRAL22"); --- ����������
	SetCraftAmount("YFAUUN_ITAR_NEUTRAL22", 1);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_NEUTRAL22", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_NEUTRAL22", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEUTRAL22", 10);
	SetCraftScience("YFAUUN_ITAR_NEUTRAL22", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_NEUTRAL22", 50);
	SetCraftEXP("YFAUUN_ITAR_NEUTRAL22", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEUTRAL22", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VAV"); --- ������� ��������
	SetCraftAmount("YFAUUN_ITAR_VAV", 1);
	 AddIngre("YFAUUN_ITAR_VAV", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VAV", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VAV", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VAV", 10);
	SetCraftScience("YFAUUN_ITAR_VAV", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VAV", 50);
	SetCraftEXP("YFAUUN_ITAR_VAV", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VAV", "�������")
	
AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_DARKROBE"); --- ���� �� ������� �����
	SetCraftAmount("YFAUUN_ITAR_DARKROBE", 1);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_DARKROBE", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_DARKROBE", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_DARKROBE", 10);
	SetCraftScience("YFAUUN_ITAR_DARKROBE", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_DARKROBE", 50);
	SetCraftEXP("YFAUUN_ITAR_DARKROBE", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_DARKROBE", "�������")
	
AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_Vlk_Khr01"); --- �������� �������� ������
	SetCraftAmount("YFAUUN_ITAR_Vlk_Khr01", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_Vlk_Khr01", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_Vlk_Khr01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_Khr01", 10);
	SetCraftScience("YFAUUN_ITAR_Vlk_Khr01", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_Khr01", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_Khr01", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_Khr01", "�������")
	
AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VLK_D"); --- ����� �������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_D", 1);
	 AddIngre("YFAUUN_ITAR_VLK_D", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_D", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_D", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_D", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_D", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_D", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_D", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_D", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_Vlk_M"); --- ������� �������� ������
	SetCraftAmount("YFAUUN_ITAR_Vlk_M", 1);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_Vlk_M", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_Vlk_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Vlk_M", 20);
	SetCraftScience("YFAUUN_ITAR_Vlk_M", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_Vlk_M", 50);
	SetCraftEXP("YFAUUN_ITAR_Vlk_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Vlk_M", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VLK_J"); --- �������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_J", 1);
	 AddIngre("YFAUUN_ITAR_VLK_J", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_J", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_J", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_J", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_J", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_J", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_J", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_J", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VLK_Z"); --- ������� �������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_Z", 1);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_Z", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_Z", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_Z", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_Z", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_Z", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_Z", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_Z", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VLK_A"); --- ����� �������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_A", 1);
	 AddIngre("YFAUUN_ITAR_VLK_A", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_A", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_A", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_A", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_A", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_A", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_A", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_A", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VLK_C"); --- �����-������� �������� ������
	SetCraftAmount("YFAUUN_ITAR_VLK_C", 1);
	 AddIngre("YFAUUN_ITAR_VLK_C", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VLK_C", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VLK_C", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_C", 20);
	SetCraftScience("YFAUUN_ITAR_VLK_C", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VLK_C", 50);
	SetCraftEXP("YFAUUN_ITAR_VLK_C", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_C", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VlkBabe_M"); --- ������� ����� ������
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_M", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VlkBabe_M", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VlkBabe_M", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_M", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_M", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_M", 50);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_M", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_M", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_VlkBabe_H"); --- ������� ������ ������
	SetCraftAmount("YFAUUN_ITAR_VlkBabe_H", 1);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_VlkBabe_H", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_VlkBabe_H", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VlkBabe_H", 20);
	SetCraftScience("YFAUUN_ITAR_VlkBabe_H", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_VlkBabe_H", 50);
	SetCraftEXP("YFAUUN_ITAR_VlkBabe_H", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VlkBabe_H", "�������")

AddItemCategory ("������� (2 �������)", "YFAUUN_ITAR_BauBabe_N"); --- ������� ��������� ������
	SetCraftAmount("YFAUUN_ITAR_BauBabe_N", 1);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "ooltyb_itmi_fiber", 4);
	 AddIngre("YFAUUN_ITAR_BauBabe_N", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("YFAUUN_ITAR_BauBabe_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BauBabe_N", 20);
	SetCraftScience("YFAUUN_ITAR_BauBabe_N", "�������", 2);
	SetenergyPenalty("YFAUUN_ITAR_BauBabe_N", 50);
	SetCraftEXP("YFAUUN_ITAR_BauBabe_N", 50)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BauBabe_N", "�������")
	
AddItemCategory ("������� (2 �������)", "itar_f_armor15"); --- �����-������� ������ (�)
	SetCraftAmount("itar_f_armor15", 1);
	 AddIngre("itar_f_armor15", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor15", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor15", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor15", 20);
	SetCraftScience("itar_f_armor15", "�������", 2);
	SetenergyPenalty("itar_f_armor15", 50);
	SetCraftEXP("itar_f_armor15", 50)
	SetCraftEXP_SKILL("itar_f_armor15", "�������")
	
AddItemCategory ("������� (2 �������)", "itar_f_armor16"); --- �����-���������� ������ (�)
	SetCraftAmount("itar_f_armor16", 1);
	 AddIngre("itar_f_armor16", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor16", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor16", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor16", 20);
	SetCraftScience("itar_f_armor16", "�������", 2);
	SetenergyPenalty("itar_f_armor16", 50);
	SetCraftEXP("itar_f_armor16", 50)
	SetCraftEXP_SKILL("itar_f_armor16", "�������")
	
AddItemCategory ("������� (2 �������)", "itar_f_armor17"); --- ������ ������� ������
	SetCraftAmount("itar_f_armor17", 1);
	 AddIngre("itar_f_armor17", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_f_armor17", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_f_armor17", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_f_armor17", 20);
	SetCraftScience("itar_f_armor17", "�������", 2);
	SetenergyPenalty("itar_f_armor17", 50);
	SetCraftEXP("itar_f_armor17", 50)
	SetCraftEXP_SKILL("itar_f_armor17", "�������")
	
AddItemCategory ("������� (2 �������)", "itar_syn_plash"); --- ���� ���������
	SetCraftAmount("itar_syn_plash", 1);
	 AddIngre("itar_syn_plash", "ooltyb_itmi_fiber", 4);
	 AddIngre("itar_syn_plash", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("itar_syn_plash", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("itar_syn_plash", 20);
	SetCraftScience("itar_syn_plash", "�������", 2);
	SetenergyPenalty("itar_syn_plash", 50);
	SetCraftEXP("itar_syn_plash", 50)
	SetCraftEXP_SKILL("itar_syn_plash", "�������")
	
AddItemCategory ("������� (2 �������)", "jar_itar_popochka2"); --- ������ ������� ������������
	SetCraftAmount("jar_itar_popochka2", 1);
	 AddIngre("jar_itar_popochka2", "ooltyb_itmi_fiber", 4);
	 AddIngre("jar_itar_popochka2", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("jar_itar_popochka2", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("jar_itar_popochka2", "OOLTYB_ITMI_JAR1");
	SetCraftPenalty("jar_itar_popochka2", 20);
	SetCraftScience("jar_itar_popochka2", "�������", 2);
	SetenergyPenalty("jar_itar_popochka2", 50);
	SetCraftEXP("jar_itar_popochka2", 50)
	SetCraftEXP_SKILL("jar_itar_popochka2", "�������")


-- -- ������� 3 ������� ������� �� 30 ������

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_VLK_F"); --- ���������� ����� ����
	SetCraftAmount("YFAUUN_ITAR_VLK_F", 1);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_VLK_F", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_VLK_F", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_F", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_F", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_VLK_F", 75);
	SetCraftEXP("YFAUUN_ITAR_VLK_F", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_F", "�������")
	
AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_VLK_N"); --- ���������� ������ ����
	SetCraftAmount("YFAUUN_ITAR_VLK_N", 1);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_VLK_N", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_VLK_N", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_VLK_N", 10);
	SetCraftScience("YFAUUN_ITAR_VLK_N", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_VLK_N", 75);
	SetCraftEXP("YFAUUN_ITAR_VLK_N", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_VLK_N", "�������")
	
AddItemCategory ("������� (3 �������)", "yfauun_itar_vlk_e"); --- ���������� ������� ����
	SetCraftAmount("yfauun_itar_vlk_e", 1);
	 AddIngre("yfauun_itar_vlk_e", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("yfauun_itar_vlk_e", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("yfauun_itar_vlk_e", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("yfauun_itar_vlk_e", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("yfauun_itar_vlk_e", 10);
	SetCraftScience("yfauun_itar_vlk_e", "�������", 3);
	SetenergyPenalty("yfauun_itar_vlk_e", 75);
	SetCraftEXP("yfauun_itar_vlk_e", 75)
	SetCraftEXP_SKILL("yfauun_itar_vlk_e", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_Judge"); ---  ������ �����
	SetCraftAmount("YFAUUN_ITAR_Judge", 1);
	 AddIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_Judge", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_Judge", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_Judge", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Judge", 10);
	SetCraftScience("YFAUUN_ITAR_Judge", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_Judge", 75);
	SetCraftEXP("YFAUUN_ITAR_Judge", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Judge", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWPLAT_05"); --- ���������� ������� ������
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_05", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_05", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_05", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_05", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_05", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_05", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_05", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_05", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWPLAT_04"); --- ���������� ������ ������
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_04", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_04", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_04", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_04", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_04", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_04", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_04", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_04", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWPLAT_03"); --- ���������� ������� ������
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_03", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_03", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_03", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_03", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_03", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_03", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_03", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_03", "�������")


AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWPLAT_02"); --- ���������� �������� ������
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_02", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_02", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_02", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_02", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_02", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_02", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_02", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_02", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_NEWPLAT_01"); --- ���������� ������� ������
	SetCraftAmount("YFAUUN_ITAR_NEWPLAT_01", 1);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ZDPWLA_ItMi_Dye", 2);
	 AddIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_rubin", 1);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_linen_holst", 4);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ZDPWLA_ItMi_Dye", 2);
	 AddAlterIngre("YFAUUN_ITAR_NEWPLAT_01", "ooltyb_itmi_aquamarine", 1);
	 AddTool("YFAUUN_ITAR_NEWPLAT_01", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_NEWPLAT_01", 10);
	SetCraftScience("YFAUUN_ITAR_NEWPLAT_01", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_NEWPLAT_01", 75);
	SetCraftEXP("YFAUUN_ITAR_NEWPLAT_01", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_NEWPLAT_01", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_BURG4"); --- ������� ������ ����������
	SetCraftAmount("YFAUUN_ITAR_BURG4", 1);
	 AddIngre("YFAUUN_ITAR_BURG4", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_BURG4", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_BURG4", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_BURG4", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_BURG4", 10);
	SetCraftScience("YFAUUN_ITAR_BURG4", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_BURG4", 75);
	SetCraftEXP("YFAUUN_ITAR_BURG4", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_BURG4", "�������")

AddItemCategory ("������� (3 �������)", "YFAUUN_ITAR_Governor"); --- ������� ������� ������ ����������
	SetCraftAmount("YFAUUN_ITAR_Governor", 1);
	 AddIngre("YFAUUN_ITAR_Governor", "ooltyb_itmi_linen_holst", 4);
	 AddIngre("YFAUUN_ITAR_Governor", "ZDPWLA_ItMi_Dye", 3);
	 AddIngre("YFAUUN_ITAR_Governor", "ooltyb_itmi_addon_whitepearl", 1);
	 AddTool("YFAUUN_ITAR_Governor", "YVNZMZ_ITMI_NEEDLE");
	SetCraftPenalty("YFAUUN_ITAR_Governor", 10);
	SetCraftScience("YFAUUN_ITAR_Governor", "�������", 3);
	SetenergyPenalty("YFAUUN_ITAR_Governor", 75);
	SetCraftEXP("YFAUUN_ITAR_Governor", 75)
	SetCraftEXP_SKILL("YFAUUN_ITAR_Governor", "�������")

-- ���� �����

AddItemCategory ("���� �����", "yfauun_itar_kdw_s"); --- ���� ���������� ����� ����
	SetCraftAmount("yfauun_itar_kdw_s", 1);
	 AddIngre("yfauun_itar_kdw_s", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_kdw_s", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("yfauun_itar_kdw_s", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_s", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_s", 5);
	SetCraftScience("yfauun_itar_kdw_s", "�������", 1);
	SetenergyPenalty("yfauun_itar_kdw_s", 25);
	SetCraftEXP("yfauun_itar_kdw_s", 25)
	SetCraftEXP_SKILL("yfauun_itar_kdw_s", "�������")
	
AddItemCategory ("���� �����", "yfauun_itar_nov_l"); --- ���� ���������� ����� ����
	SetCraftAmount("yfauun_itar_nov_l", 1);
	 AddIngre("yfauun_itar_nov_l", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_nov_l", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("yfauun_itar_nov_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_nov_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_nov_l", 5);
	SetCraftScience("yfauun_itar_nov_l", "�������", 1);
	SetenergyPenalty("yfauun_itar_nov_l", 25);
	SetCraftEXP("yfauun_itar_nov_l", 25)
	SetCraftEXP_SKILL("yfauun_itar_nov_l", "�������")
	
AddItemCategory ("���� �����", "ITAR_BES_DOSP4"); --- ���� ���������� �����������
	SetCraftAmount("ITAR_BES_DOSP4", 1);
	 AddIngre("ITAR_BES_DOSP4", "ooltyb_itmi_fiber", 3);
	 AddIngre("ITAR_BES_DOSP4", "ZDPWLA_ItMi_Dye", 1);
	 AddTool("ITAR_BES_DOSP4", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP4", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP4", 5);
	SetCraftScience("ITAR_BES_DOSP4", "�������", 1);
	SetenergyPenalty("ITAR_BES_DOSP4", 25);
	SetCraftEXP("ITAR_BES_DOSP4", 25)
	SetCraftEXP_SKILL("ITAR_BES_DOSP4", "�������")

AddItemCategory ("���� �����", "YFAUUN_KDF_ARMOR_L"); --- ������ ������� ����� ����
	SetCraftAmount("YFAUUN_KDF_ARMOR_L", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "ooltyb_itmi_fiber", 3);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "zdpwla_itmi_dye", 1);
	 AddIngre("YFAUUN_KDF_ARMOR_L", "zdpwla_itmi_beltlm", 1);
	 AddTool("YFAUUN_KDF_ARMOR_L", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("YFAUUN_KDF_ARMOR_L", "ooltyb_itmi_recipe2");
	SetCraftPenalty("YFAUUN_KDF_ARMOR_L", 5);
	SetCraftScience("YFAUUN_KDF_ARMOR_L", "�������", 2);
	SetenergyPenalty("YFAUUN_KDF_ARMOR_L", 50);
	SetCraftEXP("YFAUUN_KDF_ARMOR_L", 50)
	SetCraftEXP_SKILL("YFAUUN_KDF_ARMOR_L", "�������")

AddItemCategory ("���� �����", "yfauun_itar_kdw_l"); --- ������ ������� ���� ����
	SetCraftAmount("yfauun_itar_kdw_l", 1);
	 AddIngre("yfauun_itar_kdw_l", "ooltyb_itmi_fiber", 3);
	 AddIngre("yfauun_itar_kdw_l", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdw_l", "zdpwla_itmi_beltlm", 1);
	 AddTool("yfauun_itar_kdw_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_l", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l", 5);
	SetCraftScience("yfauun_itar_kdw_l", "�������", 2);
	SetenergyPenalty("yfauun_itar_kdw_l", 50);
	SetCraftEXP("yfauun_itar_kdw_l", 50)
	SetCraftEXP_SKILL("yfauun_itar_kdw_l", "�������")
	
AddItemCategory ("���� �����", "ITAR_BES_DOSP5"); --- ������ ������� �����������
	SetCraftAmount("ITAR_BES_DOSP5", 1);
	 AddIngre("ITAR_BES_DOSP5", "ooltyb_itmi_fiber", 3);
	 AddIngre("ITAR_BES_DOSP5", "zdpwla_itmi_dye", 1);
	 AddIngre("ITAR_BES_DOSP5", "zdpwla_itmi_beltlm", 1);
	 AddTool("ITAR_BES_DOSP5", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP5", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP5", 5);
	SetCraftScience("ITAR_BES_DOSP5", "�������", 2);
	SetenergyPenalty("ITAR_BES_DOSP5", 50);
	SetCraftEXP("ITAR_BES_DOSP5", 50)
	SetCraftEXP_SKILL("ITAR_BES_DOSP5", "�������")
	
AddItemCategory ("���� �����", "yfauun_itar_kdw_l_addon"); --- ������ ���� ����
	SetCraftAmount("yfauun_itar_kdw_l_addon", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("yfauun_itar_kdw_l_addon", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdw_l_addon", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("yfauun_itar_kdw_l_addon", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_l_addon", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_l_addon", 5);
	SetCraftScience("yfauun_itar_kdw_l_addon", "�������", 3);
	SetenergyPenalty("yfauun_itar_kdw_l_addon", 75);
	
	
AddItemCategory ("���� �����", "yfauun_itar_kdf_l"); --- ������ ���� ����
	SetCraftAmount("yfauun_itar_kdf_l", 1);
	 AddIngre("yfauun_itar_kdf_l", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("yfauun_itar_kdf_l", "zdpwla_itmi_dye", 1);
	 AddIngre("yfauun_itar_kdf_l", "zdpwla_itmi_belthm", 1);
	 AddIngre("yfauun_itar_kdf_l", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("yfauun_itar_kdf_l", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdf_l", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_kdf_l", 5);
	SetCraftScience("yfauun_itar_kdf_l", "�������", 3);
	SetenergyPenalty("yfauun_itar_kdf_l", 75);
	
AddItemCategory ("���� �����", "ITAR_BES_DOSP6"); --- ������ ������� �����������
	SetCraftAmount("ITAR_BES_DOSP6", 1);
	 AddIngre("ITAR_BES_DOSP6", "ooltyb_itmi_linen_holst", 5);
	 AddIngre("ITAR_BES_DOSP6", "zdpwla_itmi_dye", 1);
	 AddIngre("ITAR_BES_DOSP6", "zdpwla_itmi_belthm", 1);
	 AddIngre("ITAR_BES_DOSP6", "OOLTYB_ITMI_BIJOUTERIE", 1);
	 AddTool("ITAR_BES_DOSP6", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("ITAR_BES_DOSP6", "OOLTYB_ITMI_RECIPEBES");
	SetCraftPenalty("ITAR_BES_DOSP6", 5);
	SetCraftScience("ITAR_BES_DOSP6", "�������", 3);
	SetenergyPenalty("ITAR_BES_DOSP6", 75);
	
AddItemCategory ("���� �����", "yfauun_itar_kdw_h"); --- ������ �������� ����
	SetCraftAmount("yfauun_itar_kdw_h", 1);
	 AddIngre("yfauun_itar_kdw_h", "ooltyb_itmi_linen_holst", 10);
	 AddIngre("yfauun_itar_kdw_h", "zdpwla_itmi_dye", 3);
	 AddIngre("yfauun_itar_kdw_h", "zdpwla_itmi_beltum", 1);
	 AddIngre("yfauun_itar_kdw_h", "OOLTYB_ITMI_BIJOUTERIE", 2);
	 AddIngre("yfauun_itar_kdw_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kdw_h", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdw_h", "ooltyb_itmi_recipe1");
	SetCraftPenalty("yfauun_itar_kdw_h", 5);
	SetCraftScience("yfauun_itar_kdw_h", "�������", 4);
	SetenergyPenalty("yfauun_itar_kdw_h", 100);
	
AddItemCategory ("���� �����", "yfauun_itar_kdf_h"); --- ������ �������� ����
	SetCraftAmount("yfauun_itar_kdf_h", 1);
	 AddIngre("yfauun_itar_kdf_h", "ooltyb_itmi_linen_holst", 10);
	 AddIngre("yfauun_itar_kdf_h", "zdpwla_itmi_dye", 3);
	 AddIngre("yfauun_itar_kdf_h", "zdpwla_itmi_beltum", 1);
	 AddIngre("yfauun_itar_kdf_h", "OOLTYB_ITMI_BIJOUTERIE", 2);
	 AddIngre("yfauun_itar_kdf_h", "OOLTYB_ITMI_UNIQUERECIPE", 1);
	 AddTool("yfauun_itar_kdf_h", "YVNZMZ_ITMI_NEEDLE");
	 AddTool("yfauun_itar_kdf_h", "ooltyb_itmi_recipe2");
	SetCraftPenalty("yfauun_itar_kdf_h", 5);
	SetCraftScience("yfauun_itar_kdf_h", "�������", 4);
	SetenergyPenalty("yfauun_itar_kdf_h", 100);
	
	
-- ������ 1 ����

AddItemCategory ("(�) 1-� ����", "IHPIWN_ItSc_Firebolt"); ----- ������ �������� ������
	SetCraftAmount("IHPIWN_ItSc_Firebolt", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_paper", 2);
	AddTool("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_kft1");
    AddTool("IHPIWN_ItSc_Firebolt", "ooltyb_itmi_kscf");
	SetCraftPenalty("IHPIWN_ItSc_Firebolt", 5);
	SetCraftScience("IHPIWN_ItSc_Firebolt", "�����", 1);
	SetenergyPenalty("IHPIWN_ItSc_Firebolt", 25);
	
AddItemCategory ("(�) 1-� ����", "ihpiwn_itsc_icebolt"); ----- ������ ������� ������
	SetCraftAmount("ihpiwn_itsc_icebolt", 1);
	 AddIngre("ihpiwn_itsc_icebolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_icebolt", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_icebolt", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_icebolt", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icebolt", 5);
	SetCraftScience("ihpiwn_itsc_icebolt", "�����", 1);
	SetenergyPenalty("ihpiwn_itsc_icebolt", 25);

AddItemCategory ("(�) 1-� ����", "IHPIWN_ItSc_Zap"); ----- ������ ����� ������
	SetCraftAmount("IHPIWN_ItSc_Zap", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Zap", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Zap", "ooltyb_itmi_kft1");
	AddTool("IHPIWN_ItSc_Zap", "ooltyb_itmi_kscs");
	SetCraftPenalty("IHPIWN_ItSc_Zap", 5);
	SetCraftScience("IHPIWN_ItSc_Zap", "�����", 1);
	SetenergyPenalty("IHPIWN_ItSc_Zap", 25);
	
AddItemCategory ("(�) 1-� ����", "ihpiwn_itsc_palholybolt"); ----- ������ ������ ������
	SetCraftAmount("ihpiwn_itsc_palholybolt", 1);
	 AddIngre("ihpiwn_itsc_palholybolt", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_palholybolt", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_palholybolt", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_palholybolt", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palholybolt", 5);
	SetCraftScience("ihpiwn_itsc_palholybolt", "�����", 1);
	SetenergyPenalty("ihpiwn_itsc_palholybolt", 25);
	
AddItemCategory ("(�) 1-� ����", "ihpiwn_itsc_pallight"); ----- ������ ������ ����
	SetCraftAmount("ihpiwn_itsc_pallight", 1);
	 AddIngre("ihpiwn_itsc_pallight", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_pallight", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_pallight", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_pallight", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_pallight", 5);
	SetCraftScience("ihpiwn_itsc_pallight", "�����", 1);
	SetenergyPenalty("ihpiwn_itsc_pallight", 25);
	
AddItemCategory ("(�) 1-� ����", "ihpiwn_itsc_pallightheal"); ----- C����� ����� ���������
	SetCraftAmount("ihpiwn_itsc_pallightheal", 1);
	 AddIngre("ihpiwn_itsc_pallightheal", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_pallightheal", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_pallightheal", "ooltyb_itmi_kft1");
	AddTool("ihpiwn_itsc_pallightheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_pallightheal", 5);
	SetCraftScience("ihpiwn_itsc_pallightheal", "�����", 1);
	SetenergyPenalty("ihpiwn_itsc_pallightheal", 25);

AddItemCategory ("(�) 1-� ����", "IHPIWN_ItSc_Light"); ----- ������ ����
	SetCraftAmount("IHPIWN_ItSc_Light", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_Light", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_Light", "ooltyb_itmi_kft1");
	SetCraftPenalty("IHPIWN_ItSc_Light", 5);
	SetCraftScience("IHPIWN_ItSc_Light", "�����", 1);
	SetenergyPenalty("IHPIWN_ItSc_Light", 25);
	
AddItemCategory ("(�) 1-� ����", "IHPIWN_ItSc_LightHeal"); ----- ������ ������ �������
	SetCraftAmount("IHPIWN_ItSc_LightHeal", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_magicore", 1);
	 AddIngre("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_paper", 2);
    AddTool("IHPIWN_ItSc_LightHeal", "ooltyb_itmi_kft1");
	SetCraftPenalty("IHPIWN_ItSc_LightHeal", 5);
	SetCraftScience("IHPIWN_ItSc_LightHeal", "�����", 1);
	SetenergyPenalty("IHPIWN_ItSc_LightHeal", 25);
	
AddItemCategory ("(�) 1-� ����", "ihpiwn_itsc_lightfocheal"); ----- ������ ������ ������� ������
	SetCraftAmount("ihpiwn_itsc_lightfocheal", 1);
	 AddIngre("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_magicore", 1);
	 AddIngre("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_paper", 2);
    AddTool("ihpiwn_itsc_lightfocheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("ihpiwn_itsc_lightfocheal", 5);
	SetCraftScience("ihpiwn_itsc_lightfocheal", "�����", 1);
	SetenergyPenalty("ihpiwn_itsc_lightfocheal", 25);
	
------- ������ 2 ����

AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_instantfireball"); ----- ������ �������� ���
	SetCraftAmount("ihpiwn_itsc_instantfireball", 1);
	 AddIngre("ihpiwn_itsc_instantfireball", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_instantfireball", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_instantfireball", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_instantfireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_instantfireball", 5);
	SetCraftScience("ihpiwn_itsc_instantfireball", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_instantfireball", 25);
	
AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_waterfist"); ----- ������ ����� ����
	SetCraftAmount("ihpiwn_itsc_waterfist", 1);
	 AddIngre("ihpiwn_itsc_waterfist", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_waterfist", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_waterfist", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_waterfist", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_waterfist", 5);
	SetCraftScience("ihpiwn_itsc_waterfist", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_waterfist", 25);
	
AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_lightningflash"); ----- ������ ������
	SetCraftAmount("ihpiwn_itsc_lightningflash", 1);
	 AddIngre("ihpiwn_itsc_lightningflash", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_lightningflash", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_lightningflash", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_lightningflash", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_lightningflash", 5);
	SetCraftScience("ihpiwn_itsc_lightningflash", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_lightningflash", 25);
	
AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_palmediumheal"); ----- ������ ������� ���������
	SetCraftAmount("ihpiwn_itsc_palmediumheal", 1);
	 AddIngre("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_palmediumheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palmediumheal", 5);
	SetCraftScience("ihpiwn_itsc_palmediumheal", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_palmediumheal", 25);
	
AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_palrepelevil"); ----- ������ �������� ���
	SetCraftAmount("ihpiwn_itsc_palrepelevil", 1);
	 AddIngre("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_kft2");
	AddTool("ihpiwn_itsc_palrepelevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palrepelevil", 5);
	SetCraftScience("ihpiwn_itsc_palrepelevil", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_palrepelevil", 25);
	
AddItemCategory ("(�) 2-� ����", "ihpiwn_itsc_sleep"); ----- ������ ���
	SetCraftAmount("ihpiwn_itsc_sleep", 1);
	 AddIngre("ihpiwn_itsc_sleep", "ooltyb_itmi_magicore", 2);
	 AddIngre("ihpiwn_itsc_sleep", "ooltyb_itmi_paper", 4);
    AddTool("ihpiwn_itsc_sleep", "ooltyb_itmi_kft2");
	SetCraftPenalty("ihpiwn_itsc_sleep", 5);
	SetCraftScience("ihpiwn_itsc_sleep", "�����", 2);
	SetenergyPenalty("ihpiwn_itsc_sleep", 25);
	
	------- ������ 3 ����
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_chargefireball"); ----- ������ ������� �������� ���
	SetCraftAmount("ihpiwn_itsc_chargefireball", 1);
	 AddIngre("ihpiwn_itsc_chargefireball", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_chargefireball", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_chargefireball", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_chargefireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_chargefireball", 5);
	SetCraftScience("ihpiwn_itsc_chargefireball", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_chargefireball", 50);

AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_icecube"); ----- ������ ������� ����
	SetCraftAmount("ihpiwn_itsc_icecube", 1);
	 AddIngre("ihpiwn_itsc_icecube", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_icecube", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_icecube", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_icecube", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icecube", 5);
	SetCraftScience("ihpiwn_itsc_icecube", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_icecube", 50);
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_breathofdeath"); ----- ������ ������� ������
	SetCraftAmount("ihpiwn_itsc_breathofdeath", 1);
	 AddIngre("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_breathofdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_breathofdeath", 5);
	SetCraftScience("ihpiwn_itsc_breathofdeath", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_breathofdeath", 50);
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_fear"); ----- ������ �����
	SetCraftAmount("ihpiwn_itsc_fear", 1);
	 AddIngre("ihpiwn_itsc_fear", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_fear", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_fear", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_fear", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_fear", 5);
	SetCraftScience("ihpiwn_itsc_fear", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_fear", 50);

AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_palfullheal"); ----- ������ ������ ���������
	SetCraftAmount("ihpiwn_itsc_palfullheal", 1);
	 AddIngre("ihpiwn_itsc_palfullheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_palfullheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_palfullheal", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_palfullheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_palfullheal", 5);
	SetCraftScience("ihpiwn_itsc_palfullheal", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_palfullheal", 50);
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_paldestroyevil"); ----- ������ ����������� ���
	SetCraftAmount("ihpiwn_itsc_paldestroyevil", 1);
	 AddIngre("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_kft3");
	AddTool("ihpiwn_itsc_paldestroyevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("ihpiwn_itsc_paldestroyevil", 5);
	SetCraftScience("ihpiwn_itsc_paldestroyevil", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_paldestroyevil", 50);

AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_harmundead"); ----- ������ ����������� ������
	SetCraftAmount("ihpiwn_itsc_harmundead", 1);
	 AddIngre("ihpiwn_itsc_harmundead", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_harmundead", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_harmundead", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_harmundead", 5);
	SetCraftScience("ihpiwn_itsc_harmundead", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_harmundead", 50);
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_mediumheal"); ----- ������ ������� �������
	SetCraftAmount("ihpiwn_itsc_mediumheal", 1);
	 AddIngre("ihpiwn_itsc_mediumheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_mediumheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_mediumheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_mediumheal", 5);
	SetCraftScience("ihpiwn_itsc_mediumheal", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_mediumheal", 50);
	
AddItemCategory ("(�) 3-� ����", "ihpiwn_itsc_mediumfocheal"); ----- ������ ������� ������� ������
	SetCraftAmount("ihpiwn_itsc_mediumfocheal", 1);
	 AddIngre("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_magicore", 3);
	 AddIngre("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_paper", 8);
    AddTool("ihpiwn_itsc_mediumfocheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("ihpiwn_itsc_mediumfocheal", 5);
	SetCraftScience("ihpiwn_itsc_mediumfocheal", "�����", 3);
	SetenergyPenalty("ihpiwn_itsc_mediumfocheal", 50);
	
	------- ������ 4 ����
	
AddItemCategory ("(�) 4-� ����", "ihpiwn_itsc_InstantFireStorm"); ----- ������ ����� �������� ����
	SetCraftAmount("ihpiwn_itsc_InstantFireStorm", 1);
	 AddIngre("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_kft4");
    AddTool("ihpiwn_itsc_InstantFireStorm", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_InstantFireStorm", 5);
	SetCraftScience("ihpiwn_itsc_InstantFireStorm", "�����", 4);
	SetenergyPenalty("ihpiwn_itsc_InstantFireStorm", 75);
	
AddItemCategory ("(�) 4-� ����", "ihpiwn_itsc_icelance"); ----- ������ ������� �����
	SetCraftAmount("ihpiwn_itsc_icelance", 1);
	 AddIngre("ihpiwn_itsc_icelance", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_icelance", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_icelance", "ooltyb_itmi_kft4");
    AddTool("ihpiwn_itsc_icelance", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icelance", 5);
	SetCraftScience("ihpiwn_itsc_icelance", "�����", 4);
	SetenergyPenalty("ihpiwn_itsc_icelance", 75);
	
AddItemCategory ("(�) 4-� ����", "ihpiwn_itsc_thunderball"); ----- ������ ������� ������
	SetCraftAmount("ihpiwn_itsc_thunderball", 1);
	 AddIngre("ihpiwn_itsc_thunderball", "ooltyb_itmi_magicore", 5);
	 AddIngre("ihpiwn_itsc_thunderball", "ooltyb_itmi_paper", 12);
	AddTool("ihpiwn_itsc_thunderball", "ooltyb_itmi_kft4");
	AddTool("ihpiwn_itsc_thunderball", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_thunderball", 5);
	SetCraftScience("ihpiwn_itsc_thunderball", "�����", 4);
	SetenergyPenalty("ihpiwn_itsc_thunderball", 75);
	
	------- ������ 5 ����

AddItemCategory ("(�) 5-� ����", "ihpiwn_itsc_pyrokinesis"); ----- ������ ������� �������� ����
	SetCraftAmount("ihpiwn_itsc_pyrokinesis", 1);
	 AddIngre("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_pyrokinesis", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_pyrokinesis", 5);
	SetCraftScience("ihpiwn_itsc_pyrokinesis", "�����", 5);
	SetenergyPenalty("ihpiwn_itsc_pyrokinesis", 100);	

AddItemCategory ("(�) 5-� ����", "ihpiwn_itsc_geyser"); ----- ������ ������
	SetCraftAmount("ihpiwn_itsc_geyser", 1);
	 AddIngre("ihpiwn_itsc_geyser", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_geyser", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_geyser", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_geyser", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_geyser", 5);
	SetCraftScience("ihpiwn_itsc_geyser", "�����", 5);
	SetenergyPenalty("ihpiwn_itsc_geyser", 100);
	
AddItemCategory ("(�) 5-� ����", "ihpiwn_itsc_beliarsrage"); ----- ������ ���� �������
	SetCraftAmount("ihpiwn_itsc_beliarsrage", 1);
	 AddIngre("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_kft5");
    AddTool("ihpiwn_itsc_beliarsrage", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_beliarsrage", 5);
	SetCraftScience("ihpiwn_itsc_beliarsrage", "�����", 5);
	SetenergyPenalty("ihpiwn_itsc_beliarsrage", 100);
	
AddItemCategory ("(�) 5-� ����", "ihpiwn_itsc_fullheal"); ----- ������ ������ �������
	SetCraftAmount("ihpiwn_itsc_fullheal", 1);
	 AddIngre("ihpiwn_itsc_fullheal", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_fullheal", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_fullheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("ihpiwn_itsc_fullheal", 5);
	SetCraftScience("ihpiwn_itsc_fullheal", "�����", 5);
	SetenergyPenalty("ihpiwn_itsc_fullheal", 100);

AddItemCategory ("(�) 5-� ����", "ihpiwn_itsc_fullfocheal"); ----- ������ ������ ������� ������
	SetCraftAmount("ihpiwn_itsc_fullfocheal", 1);
	 AddIngre("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_magicore", 10);
	 AddIngre("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_paper", 25);
	AddTool("ihpiwn_itsc_fullfocheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("ihpiwn_itsc_fullfocheal", 5);
	SetCraftScience("ihpiwn_itsc_fullfocheal", "�����", 5);
	SetenergyPenalty("ihpiwn_itsc_fullfocheal", 100);

	------- ������ 6 ����
	
AddItemCategory ("(�) 6-� ����", "ihpiwn_itsc_firerain"); ----- ������ �������� �����
	SetCraftAmount("ihpiwn_itsc_firerain", 1);
	 AddIngre("ihpiwn_itsc_firerain", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_firerain", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_firerain", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_firerain", "ooltyb_itmi_kscf");
	SetCraftPenalty("ihpiwn_itsc_firerain", 5);
	SetCraftScience("ihpiwn_itsc_firerain", "�����", 6);
	SetenergyPenalty("ihpiwn_itsc_firerain", 100);
	
AddItemCategory ("(�) 6-� ����", "ihpiwn_itsc_icewave"); ----- ������ ������� �����
	SetCraftAmount("ihpiwn_itsc_icewave", 1);
	 AddIngre("ihpiwn_itsc_icewave", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_icewave", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_icewave", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_icewave", "ooltyb_itmi_kscw");
	SetCraftPenalty("ihpiwn_itsc_icewave", 5);
	SetCraftScience("ihpiwn_itsc_icewave", "�����", 6);
	SetenergyPenalty("ihpiwn_itsc_icewave", 100);
	
AddItemCategory ("(�) 6-� ����", "ihpiwn_itsc_massdeath"); ----- ������ ����� ������
	SetCraftAmount("ihpiwn_itsc_massdeath", 1);
	 AddIngre("ihpiwn_itsc_massdeath", "ooltyb_itmi_magicore", 15);
	 AddIngre("ihpiwn_itsc_massdeath", "ooltyb_itmi_paper", 50);
	AddTool("ihpiwn_itsc_massdeath", "ooltyb_itmi_kft6");
	AddTool("ihpiwn_itsc_massdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("ihpiwn_itsc_massdeath", 5);
	SetCraftScience("ihpiwn_itsc_massdeath", "�����", 6);
	SetenergyPenalty("ihpiwn_itsc_massdeath", 100);

----- ���� 1 ����
	
AddItemCategory ("(�) 1-� ����", "book_garrypotter1"); ----- ������ ���� �����
	SetCraftAmount("book_garrypotter1", 1);
	 AddIngre("book_garrypotter1", "zdpwla_itmi_dye", 1);
	 AddIngre("book_garrypotter1", "ooltyb_itmi_paper", 10);
	 AddIngre("book_garrypotter1", "ooltyb_itmi_magicore", 5);
	AddTool("book_garrypotter1", "ooltyb_itmi_kft1");
	SetCraftPenalty("book_garrypotter1", 5);
	SetCraftScience("book_garrypotter1", "�����", 1);
	SetenergyPenalty("book_garrypotter1", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_firebolt"); ----- ���� �������� ������
	SetCraftAmount("saqtsh_itru_firebolt", 1);
	 AddIngre("saqtsh_itru_firebolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_firebolt", "ooltyb_itmi_rubin", 1);
	 AddIngre("saqtsh_itru_firebolt", "ihpiwn_itsc_firebolt", 1);
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_firebolt", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_firebolt", 5);
	SetCraftScience("saqtsh_itru_firebolt", "�����", 1);
	SetenergyPenalty("saqtsh_itru_firebolt", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_icebolt"); ----- ���� ������� ������
	SetCraftAmount("saqtsh_itru_icebolt", 1);
	 AddIngre("saqtsh_itru_icebolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_icebolt", "ooltyb_itmi_aquamarine", 1);
	 AddIngre("saqtsh_itru_icebolt", "ihpiwn_itsc_icebolt", 1);
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_icebolt", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icebolt", 5);
	SetCraftScience("saqtsh_itru_icebolt", "�����", 1);
	SetenergyPenalty("saqtsh_itru_icebolt", 25);

AddItemCategory ("(�) 1-� ����", "saqtsh_itru_zap"); ----- ���� ����� ������
	SetCraftAmount("saqtsh_itru_zap", 1);
	 AddIngre("saqtsh_itru_zap", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_zap", "ooltyb_itmi_sulfur", 1);
	 AddIngre("saqtsh_itru_zap", "ihpiwn_itsc_zap", 1);
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_zap", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_zap", 5);
	SetCraftScience("saqtsh_itru_zap", "�����", 1);
	SetenergyPenalty("saqtsh_itru_zap", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_palholybolt"); ----- ���� ������ ������
	SetCraftAmount("saqtsh_itru_palholybolt", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_palholybolt", "ihpiwn_itsc_palholybolt", 1);
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_palholybolt", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palholybolt", 5);
	SetCraftScience("saqtsh_itru_palholybolt", "�����", 1);
	SetenergyPenalty("saqtsh_itru_palholybolt", 25);

AddItemCategory ("(�) 1-� ����", "saqtsh_itru_pallight"); ----- ���� ������ ����
	SetCraftAmount("saqtsh_itru_pallight", 1);
	 AddIngre("saqtsh_itru_pallight", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_pallight", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_pallight", "ihpiwn_itsc_pallight", 1);
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_pallight", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_pallight", 5);
	SetCraftScience("saqtsh_itru_pallight", "�����", 1);
	SetenergyPenalty("saqtsh_itru_pallight", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_pallightheal"); ----- ���� ����� ���������
	SetCraftAmount("saqtsh_itru_pallightheal", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("saqtsh_itru_pallightheal", "ihpiwn_itsc_pallightheal", 1);
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_kft1");
	AddTool("saqtsh_itru_pallightheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_pallightheal", 5);
	SetCraftScience("saqtsh_itru_pallightheal", "�����", 1);
	SetenergyPenalty("saqtsh_itru_pallightheal", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_light"); ----- ���� ����
	SetCraftAmount("saqtsh_itru_light", 1);
	 AddIngre("saqtsh_itru_light", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_light", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_light", "ihpiwn_itsc_light", 1);
    AddTool("saqtsh_itru_light", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_light", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_light", 5);
	SetCraftScience("saqtsh_itru_light", "�����", 1);
	SetenergyPenalty("saqtsh_itru_light", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_lightheal"); ----- ���� ������ �������
	SetCraftAmount("saqtsh_itru_lightheal", 1);
	 AddIngre("saqtsh_itru_lightheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_lightheal", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_lightheal", "ihpiwn_itsc_lightheal", 1);
    AddTool("saqtsh_itru_lightheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_lightheal", 5);
	SetCraftScience("saqtsh_itru_lightheal", "�����", 1);
	SetenergyPenalty("saqtsh_itru_lightheal", 25);
	
AddItemCategory ("(�) 1-� ����", "saqtsh_itru_lightfocheal"); ----- ���� ������ ������� ������
	SetCraftAmount("saqtsh_itru_lightfocheal", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ooltyb_itmi_runeblank", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ooltyb_itmi_quartz", 1);
	 AddIngre("saqtsh_itru_lightfocheal", "ihpiwn_itsc_lightfocheal", 1);
    AddTool("saqtsh_itru_lightfocheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightfocheal", "ooltyb_itmi_kft1");
	SetCraftPenalty("saqtsh_itru_lightfocheal", 5);
	SetCraftScience("saqtsh_itru_lightfocheal", "�����", 1);
	SetenergyPenalty("saqtsh_itru_lightfocheal", 25);
	
----- ���� 2 ����

AddItemCategory ("(�) 2-� ����", "book_garrypotter2"); ----- ������ ���� �����
	SetCraftAmount("book_garrypotter2", 1);
	 AddIngre("book_garrypotter2", "zdpwla_itmi_dye", 2);
	 AddIngre("book_garrypotter2", "ooltyb_itmi_paper", 20);
	 AddIngre("book_garrypotter2", "ooltyb_itmi_magicore", 10);
	AddTool("book_garrypotter2", "ooltyb_itmi_kft2");
	SetCraftPenalty("book_garrypotter2", 5);
	SetCraftScience("book_garrypotter2", "�����", 2);
	SetenergyPenalty("book_garrypotter2", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_instantfireball"); ----- ���� �������� ���
	SetCraftAmount("saqtsh_itru_instantfireball", 1);
	 AddIngre("saqtsh_itru_instantfireball", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_instantfireball", "ooltyb_itmi_rubin", 2);
	 AddIngre("saqtsh_itru_instantfireball", "ihpiwn_itsc_instantfireball", 1);
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_instantfireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_instantfireball", 5);
	SetCraftScience("saqtsh_itru_instantfireball", "�����", 2);
	SetenergyPenalty("saqtsh_itru_instantfireball", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_waterfist"); ----- ���� ����� ����
	SetCraftAmount("saqtsh_itru_waterfist", 1);
	 AddIngre("saqtsh_itru_waterfist", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_waterfist", "ooltyb_itmi_aquamarine", 2);
	 AddIngre("saqtsh_itru_waterfist", "ihpiwn_itsc_waterfist", 1);
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_waterfist", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_waterfist", 5);
	SetCraftScience("saqtsh_itru_waterfist", "�����", 2);
	SetenergyPenalty("saqtsh_itru_waterfist", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_lightningflash"); ----- ���� ������
	SetCraftAmount("saqtsh_itru_lightningflash", 1);
	 AddIngre("saqtsh_itru_lightningflash", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_lightningflash", "ooltyb_itmi_sulfur", 2);
	 AddIngre("saqtsh_itru_lightningflash", "ihpiwn_itsc_lightningflash", 1);
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_kft2");
	AddTool("saqtsh_itru_lightningflash", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_lightningflash", 5);
	SetCraftScience("saqtsh_itru_lightningflash", "�����", 2);
	SetenergyPenalty("saqtsh_itru_lightningflash", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_palmediumheal"); ----- ���� ������� ���������
	SetCraftAmount("saqtsh_itru_palmediumheal", 1);
	 AddIngre("saqtsh_itru_palmediumheal", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_palmediumheal", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("saqtsh_itru_palmediumheal", "ihpiwn_itsc_palmediumheal", 1);
    AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_kft2");
    AddTool("saqtsh_itru_palmediumheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palmediumheal", 5);
	SetCraftScience("saqtsh_itru_palmediumheal", "�����", 2);
	SetenergyPenalty("saqtsh_itru_palmediumheal", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_palrepelevil"); ----- ���� �������� ���
	SetCraftAmount("saqtsh_itru_palrepelevil", 1);
	 AddIngre("saqtsh_itru_palrepelevil", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_palrepelevil", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("saqtsh_itru_palrepelevil", "ihpiwn_itsc_palrepelevil", 1);
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_kft2");
    AddTool("saqtsh_itru_palrepelevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palrepelevil", 5);
	SetCraftScience("saqtsh_itru_palrepelevil", "�����", 2);
	SetenergyPenalty("saqtsh_itru_palrepelevil", 25);
	
AddItemCategory ("(�) 2-� ����", "saqtsh_itru_sleep"); ----- ���� ���
	SetCraftAmount("saqtsh_itru_sleep", 1);
	 AddIngre("saqtsh_itru_sleep", "ooltyb_itmi_mage2", 1);
	 AddIngre("saqtsh_itru_sleep", "ooltyb_itmi_quartz", 2);
	 AddIngre("saqtsh_itru_sleep", "ihpiwn_itsc_sleep", 1);
    AddTool("saqtsh_itru_sleep", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_sleep", "ooltyb_itmi_kft2");
	SetCraftPenalty("saqtsh_itru_sleep", 5);
	SetCraftScience("saqtsh_itru_sleep", "�����", 2);
	SetenergyPenalty("saqtsh_itru_sleep", 25);
	
----- ���� 3 ����


AddItemCategory ("(�) 3-� ����", "book_garrypotter3"); ----- ������ ���� �����
	SetCraftAmount("book_garrypotter3", 1);
	 AddIngre("book_garrypotter3", "zdpwla_itmi_dye", 3);
	 AddIngre("book_garrypotter3", "ooltyb_itmi_paper", 30);
	 AddIngre("book_garrypotter3", "ooltyb_itmi_magicore", 15);
	AddTool("book_garrypotter3", "ooltyb_itmi_kft3");
	SetCraftPenalty("book_garrypotter3", 5);
	SetCraftScience("book_garrypotter3", "�����", 3);
	SetenergyPenalty("book_garrypotter3", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_chargefireball"); ----- ���� ������� �������� ���
	SetCraftAmount("saqtsh_itru_chargefireball", 1);
	 AddIngre("saqtsh_itru_chargefireball", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_chargefireball", "ooltyb_itmi_rubin", 3);
	 AddIngre("saqtsh_itru_chargefireball", "ihpiwn_itsc_chargefireball", 1);
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_pliers");	
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_chargefireball", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_chargefireball", 15);
	SetCraftScience("saqtsh_itru_chargefireball", "�����", 3);
	SetenergyPenalty("saqtsh_itru_chargefireball", 50);

AddItemCategory ("(�) 3-� ����", "saqtsh_itru_icecube"); ----- ���� ������� ����
	SetCraftAmount("saqtsh_itru_icecube", 1);
	 AddIngre("saqtsh_itru_icecube", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_icecube", "OOLTYB_ItMi_AquamarinE", 3);
	 AddIngre("saqtsh_itru_icecube", "ihpiwn_itsc_icecube", 1);
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_icecube", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icecube", 15);
	SetCraftScience("saqtsh_itru_icecube", "�����", 3);
	SetenergyPenalty("saqtsh_itru_icecube", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_breathofdeath"); ----- ���� ������� ������
	SetCraftAmount("saqtsh_itru_breathofdeath", 1);
	 AddIngre("saqtsh_itru_breathofdeath", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_breathofdeath", "ooltyb_itmi_sulfur", 3);
	 AddIngre("saqtsh_itru_breathofdeath", "ihpiwn_itsc_breathofdeath", 1);
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_kft3");
    AddTool("saqtsh_itru_breathofdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_breathofdeath", 5);
	SetCraftScience("saqtsh_itru_breathofdeath", "�����", 3);
	SetenergyPenalty("saqtsh_itru_breathofdeath", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_fear"); ----- ���� �����
	SetCraftAmount("saqtsh_itru_fear", 1);
	 AddIngre("saqtsh_itru_fear", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_fear", "ooltyb_itmi_sulfur", 3);
	 AddIngre("saqtsh_itru_fear", "ihpiwn_itsc_fear", 1);
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_fear", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_fear", 5);
	SetCraftScience("saqtsh_itru_fear", "�����", 3);
	SetenergyPenalty("saqtsh_itru_fear", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_palfullheal"); ----- ���� ������ ���������
	SetCraftAmount("saqtsh_itru_palfullheal", 1);
	 AddIngre("saqtsh_itru_palfullheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_palfullheal", "ooltyb_itmi_rockcrystal", 3);
	 AddIngre("saqtsh_itru_palfullheal", "ihpiwn_itsc_palfullheal", 1);
	AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_palfullheal", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_palfullheal", 5);
	SetCraftScience("saqtsh_itru_palfullheal", "�����", 3);
	SetenergyPenalty("saqtsh_itru_palfullheal", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_paldestroyevil"); ----- ���� ����������� ���
	SetCraftAmount("saqtsh_itru_paldestroyevil", 1);
	 AddIngre("saqtsh_itru_paldestroyevil", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_paldestroyevil", "ooltyb_itmi_rockcrystal", 3);
	 AddIngre("saqtsh_itru_paldestroyevil", "ihpiwn_itsc_paldestroyevil", 1);
	AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_kft3");
	AddTool("saqtsh_itru_paldestroyevil", "ooltyb_itmi_kscl");
	SetCraftPenalty("saqtsh_itru_paldestroyevil", 5);
	SetCraftScience("saqtsh_itru_paldestroyevil", "�����", 3);
	SetenergyPenalty("saqtsh_itru_paldestroyevil", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_harmundead"); ----- ���� ����������� ������
	SetCraftAmount("saqtsh_itru_harmundead", 1);
	 AddIngre("saqtsh_itru_harmundead", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_harmundead", "OOLTYB_ItMi_Quartz", 3);
	 AddIngre("saqtsh_itru_harmundead", "ihpiwn_itsc_harmundead", 1);
	AddTool("saqtsh_itru_harmundead", "ooltyb_itmi_pliers");	
	AddTool("saqtsh_itru_harmundead", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_harmundead", 15);
	SetCraftScience("saqtsh_itru_harmundead", "�����", 3);
	SetenergyPenalty("saqtsh_itru_harmundead", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_mediumheal"); ----- ���� ������� �������
	SetCraftAmount("saqtsh_itru_mediumheal", 1);
	 AddIngre("saqtsh_itru_mediumheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_mediumheal", "ooltyb_itmi_quartz", 3);
	 AddIngre("saqtsh_itru_mediumheal", "ihpiwn_itsc_mediumheal", 1);
	AddTool("saqtsh_itru_mediumheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_mediumheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_mediumheal", 15);
	SetCraftScience("saqtsh_itru_mediumheal", "�����", 3);
	SetenergyPenalty("saqtsh_itru_mediumheal", 50);
	
AddItemCategory ("(�) 3-� ����", "saqtsh_itru_mediumfocheal"); ----- ���� ������� ������� ������
	SetCraftAmount("saqtsh_itru_mediumfocheal", 1);
	 AddIngre("saqtsh_itru_mediumfocheal", "ooltyb_itmi_mage3", 1);
	 AddIngre("saqtsh_itru_mediumfocheal", "ooltyb_itmi_quartz", 3);
	 AddIngre("saqtsh_itru_mediumfocheal", "ihpiwn_itsc_mediumfocheal", 1);
    AddTool("saqtsh_itru_mediumfocheal", "ooltyb_itmi_pliers");
    AddTool("saqtsh_itru_mediumfocheal", "ooltyb_itmi_kft3");
	SetCraftPenalty("saqtsh_itru_mediumfocheal", 5);
	SetCraftScience("saqtsh_itru_mediumfocheal", "�����", 3);
	SetenergyPenalty("saqtsh_itru_mediumfocheal", 50);
	
----- ���� 4 ����
	
AddItemCategory ("(�) 4-� ����", "book_garrypotter4"); ----- ��������� ���� �����
	SetCraftAmount("book_garrypotter4", 1);
	 AddIngre("book_garrypotter4", "zdpwla_itmi_dye", 4);
	 AddIngre("book_garrypotter4", "ooltyb_itmi_paper", 40);
	 AddIngre("book_garrypotter4", "ooltyb_itmi_magicore", 20);
	AddTool("book_garrypotter4", "ooltyb_itmi_kft4");
	SetCraftPenalty("book_garrypotter4", 5);
	SetCraftScience("book_garrypotter4", "�����", 4);
	SetenergyPenalty("book_garrypotter4", 75);
	
AddItemCategory ("(�) 4-� ����", "saqtsh_itru_InstantFireStorm"); ----- ���� ����� �������� ����
	SetCraftAmount("saqtsh_itru_InstantFireStorm", 1);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_rubin", 4);
	 AddIngre("saqtsh_itru_InstantFireStorm", "ihpiwn_itsc_InstantFireStorm", 1);
	AddTool("saqtsh_itru_InstantFireStorm","ooltyb_itmi_pliers");	
    AddTool("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_InstantFireStorm", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_InstantFireStorm", 15);
	SetCraftScience("saqtsh_itru_InstantFireStorm", "�����", 4);
	SetenergyPenalty("saqtsh_itru_InstantFireStorm", 75);
	
AddItemCategory ("(�) 4-� ����", "saqtsh_itru_icelance"); ----- ���� ������� �����
	SetCraftAmount("saqtsh_itru_icelance", 1);
	 AddIngre("saqtsh_itru_icelance", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_icelance", "OOLTYB_ItMi_AquamarinE", 4);
	 AddIngre("saqtsh_itru_icelance", "ihpiwn_itsc_icelance", 1);
    AddTool("saqtsh_itru_icelance", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_icelance", "ooltyb_itmi_kscw");
	AddTool("saqtsh_itru_icelance","ooltyb_itmi_pliers");	
	SetCraftPenalty("saqtsh_itru_icelance", 15);
	SetCraftScience("saqtsh_itru_icelance", "�����", 4);
	SetenergyPenalty("saqtsh_itru_icelance", 75);
	
AddItemCategory ("(�) 4-� ����", "saqtsh_itru_thunderball"); ----- ���� ������� ������
	SetCraftAmount("saqtsh_itru_thunderball", 1);
	 AddIngre("saqtsh_itru_thunderball", "ooltyb_itmi_mage4", 1);
	 AddIngre("saqtsh_itru_thunderball", "ooltyb_itmi_sulfur", 4);
	 AddIngre("saqtsh_itru_thunderball", "ihpiwn_itsc_thunderball", 1);
    AddTool("saqtsh_itru_thunderball", "ooltyb_itmi_kft4");
	AddTool("saqtsh_itru_thunderball", "ooltyb_itmi_kscs");
	AddTool("saqtsh_itru_thunderball","ooltyb_itmi_pliers");
	SetCraftPenalty("saqtsh_itru_thunderball", 15);
	SetCraftScience("saqtsh_itru_thunderball", "�����", 4);
	SetenergyPenalty("saqtsh_itru_thunderball", 75);

----- ���� 5 ����

AddItemCategory ("(�) 5-� ����", "book_garrypotter5"); ----- ����� ���� �����
	SetCraftAmount("book_garrypotter5", 1);
	 AddIngre("book_garrypotter5", "zdpwla_itmi_dye", 5);
	 AddIngre("book_garrypotter5", "ooltyb_itmi_paper", 50);
	 AddIngre("book_garrypotter5", "ooltyb_itmi_magicore", 25);
	AddTool("book_garrypotter5", "ooltyb_itmi_kft5");
	SetCraftPenalty("book_garrypotter5", 5);
	SetCraftScience("book_garrypotter5", "�����", 5);
	SetenergyPenalty("book_garrypotter5", 100);

AddItemCategory ("(�) 5-� ����", "saqtsh_itru_pyrokinesis"); ----- ���� ������� �������� ����
	SetCraftAmount("saqtsh_itru_pyrokinesis", 1);
	 AddIngre("saqtsh_itru_pyrokinesis", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_pyrokinesis", "ooltyb_itmi_rubin", 5);
	 AddIngre("saqtsh_itru_pyrokinesis", "ihpiwn_itsc_pyrokinesis", 1);
	AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_pyrokinesis", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_pyrokinesis", 5);
	SetCraftScience("saqtsh_itru_pyrokinesis", "�����", 5);
	SetenergyPenalty("saqtsh_itru_pyrokinesis", 100);

AddItemCategory ("(�) 5-� ����", "saqtsh_itru_geyser"); ----- ���� ������
	SetCraftAmount("saqtsh_itru_geyser", 1);
	 AddIngre("saqtsh_itru_geyser", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_geyser", "ooltyb_itmi_aquamarine", 5);
	 AddIngre("saqtsh_itru_geyser", "saqtsh_itru_geyser", 1);
	AddTool("saqtsh_itru_geyser", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_geyser", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_geyser", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_geyser", 5);
	SetCraftScience("saqtsh_itru_geyser", "�����", 5);
	SetenergyPenalty("saqtsh_itru_geyser", 100);
	
AddItemCategory ("(�) 5-� ����", "saqtsh_itru_beliarsrage"); ----- ���� ���� �������
	SetCraftAmount("saqtsh_itru_beliarsrage", 1);
	 AddIngre("saqtsh_itru_beliarsrage", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_beliarsrage", "ooltyb_itmi_sulfur", 5);
	 AddIngre("saqtsh_itru_beliarsrage", "ihpiwn_itsc_beliarsrage", 1);
	AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_kft5");
    AddTool("saqtsh_itru_beliarsrage", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_beliarsrage", 5);
	SetCraftScience("saqtsh_itru_beliarsrage", "�����", 5);
	SetenergyPenalty("saqtsh_itru_beliarsrage", 100);
	
AddItemCategory ("(�) 5-� ����", "saqtsh_itru_fullheal"); ----- ���� ������ �������
	SetCraftAmount("saqtsh_itru_fullheal", 1);
	 AddIngre("saqtsh_itru_fullheal", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_fullheal", "ooltyb_itmi_quartz", 5);
	 AddIngre("saqtsh_itru_fullheal", "ihpiwn_itsc_fullheal", 1);
	AddTool("saqtsh_itru_fullheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fullheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("saqtsh_itru_fullheal", 5);
	SetCraftScience("saqtsh_itru_fullheal", "�����", 5);
	SetenergyPenalty("saqtsh_itru_fullheal", 100);

AddItemCategory ("(�) 5-� ����", "saqtsh_itru_fullfocheal"); ----- ���� ������ ������� ������
	SetCraftAmount("saqtsh_itru_fullfocheal", 1);
	 AddIngre("saqtsh_itru_fullfocheal", "ooltyb_itmi_mage5", 1);
	 AddIngre("saqtsh_itru_fullfocheal", "ooltyb_itmi_quartz", 5);
	 AddIngre("saqtsh_itru_fullfocheal", "ihpiwn_itsc_fullfocheal", 1);
	AddTool("saqtsh_itru_fullfocheal", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_fullfocheal", "ooltyb_itmi_kft5");
	SetCraftPenalty("saqtsh_itru_fullfocheal", 5);
	SetCraftScience("saqtsh_itru_fullfocheal", "�����", 5);
	SetenergyPenalty("saqtsh_itru_fullfocheal", 100);
	
----- ���� 6 ����

AddItemCategory ("(�) 6-� ����", "saqtsh_itru_firerain"); ----- ���� �������� �����
	SetCraftAmount("saqtsh_itru_firerain", 1);
	 AddIngre("saqtsh_itru_firerain", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_firerain", "ooltyb_itmi_rubin", 6);
	 AddIngre("saqtsh_itru_firerain", "ihpiwn_itsc_firerain", 1);
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_firerain", "ooltyb_itmi_kscf");
	SetCraftPenalty("saqtsh_itru_firerain", 5);
	SetCraftScience("saqtsh_itru_firerain", "�����", 6);
	SetenergyPenalty("saqtsh_itru_firerain", 100);
	
AddItemCategory ("(�) 6-� ����", "saqtsh_itru_icewave"); ----- ���� ������� �����
	SetCraftAmount("saqtsh_itru_icewave", 1);
	 AddIngre("saqtsh_itru_icewave", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_icewave", "ooltyb_itmi_aquamarine", 6);
	 AddIngre("saqtsh_itru_icewave", "ihpiwn_itsc_icewave", 1);
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_icewave", "ooltyb_itmi_kscw");
	SetCraftPenalty("saqtsh_itru_icewave", 5);
	SetCraftScience("saqtsh_itru_icewave", "�����", 6);
	SetenergyPenalty("saqtsh_itru_icewave", 100);
	
AddItemCategory ("(�) 6-� ����", "saqtsh_itru_massdeath"); ----- ���� ����� ������
	SetCraftAmount("saqtsh_itru_massdeath", 1);
	 AddIngre("saqtsh_itru_massdeath", "ooltyb_itmi_mage6", 1);
	 AddIngre("saqtsh_itru_massdeath", "ooltyb_itmi_rubin", 6);
	 AddIngre("saqtsh_itru_massdeath", "ihpiwn_itsc_massdeath", 1);
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_pliers");
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_kft6");
	AddTool("saqtsh_itru_massdeath", "ooltyb_itmi_kscs");
	SetCraftPenalty("saqtsh_itru_massdeath", 5);
	SetCraftScience("saqtsh_itru_massdeath", "�����", 6);
	SetenergyPenalty("saqtsh_itru_massdeath", 100);	

---- ������������ 1 �������� ������

AddItemCategory ("������������ (�������� ������)", "RC_HOUSE_BOOKS_1"); ----- ������ ���� (1)
	SetCraftAmount("RC_HOUSE_BOOKS_1", 1);
	 AddIngre("RC_HOUSE_BOOKS_1", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_1", "ooltyb_itmi_paper", 10);
	SetCraftPenalty("RC_HOUSE_BOOKS_1", 25);
	SetCraftScience("RC_HOUSE_BOOKS_1", "������������", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_1", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_1", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_1", "������������")
	
AddItemCategory ("������������ (�������� ������)", "RC_HOUSE_BOOKS_7"); ----- ������ ������
	SetCraftAmount("RC_HOUSE_BOOKS_7", 1);
	 AddIngre("RC_HOUSE_BOOKS_7", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_7", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_7", 25);
	SetCraftScience("RC_HOUSE_BOOKS_7", "������������", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_7", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_7", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_7", "������������")
	
AddItemCategory ("������������ (�������� ������)", "RC_HOUSE_BOOKS_3"); ----- ��������� ����� ��������
	SetCraftAmount("RC_HOUSE_BOOKS_3", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "zdpwla_itmi_dye", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftScience("RC_HOUSE_BOOKS_3", "������������", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_3", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_3", "������������")

AddItemCategory ("������������ (�������� ������)", "RC_HOUSE_BOOKS_3"); ----- ���������� ��������� � �������
	SetCraftAmount("RC_HOUSE_BOOKS_3", 1);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_magicore", 2);
	 AddIngre("RC_HOUSE_BOOKS_3", "ooltyb_itmi_paper", 1);
	SetCraftPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftScience("RC_HOUSE_BOOKS_3", "������������", 1);
	SetenergyPenalty("RC_HOUSE_BOOKS_3", 25);
	SetCraftEXP("RC_HOUSE_BOOKS_3", 25)
	SetCraftEXP_SKILL("RC_HOUSE_BOOKS_3", "������������")

AddItemCategory ("������������ (�������� ������)", "rc_house_bookshelf_6"); ----- ���������� ��������� � �������
	SetCraftAmount("rc_house_bookshelf_6", 1);
	 AddIngre("rc_house_bookshelf_6", "ooltyb_itmi_wood", 10);
	 AddIngre("rc_house_bookshelf_6", "ooltyb_itmi_paper", 5);
	SetCraftPenalty("rc_house_bookshelf_6", 25);
	SetCraftScience("rc_house_bookshelf_6", "������������", 1);
	SetenergyPenalty("rc_house_bookshelf_6", 25);
	SetCraftEXP("rc_house_bookshelf_6", 25)
	SetCraftEXP_SKILL("rc_house_bookshelf_6", "������������")

----- ������������ 1 ������� �����

AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_kft1"); ----- ����� ������ ��� 1
	SetCraftAmount("ooltyb_itmi_kft1", 1);
	 AddIngre("ooltyb_itmi_kft1", "zdpwla_itmi_dye", 1);
	 AddIngre("ooltyb_itmi_kft1", "ooltyb_itmi_paper", 10);
	 AddIngre("ooltyb_itmi_kft1", "ooltyb_itmi_magicore", 5);
    AddTool("ooltyb_itmi_kft1", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft1", "ooltyb_itmi_kft1");
	SetCraftPenalty("ooltyb_itmi_kft1", 25);
	SetCraftScience("ooltyb_itmi_kft1", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_kft1", 25);
	SetCraftEXP("ooltyb_itmi_kft1", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kft1", "������������")

AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_kft2"); ----- ����� ������ ��� 2
	SetCraftAmount("ooltyb_itmi_kft2", 1);
	 AddIngre("ooltyb_itmi_kft2", "zdpwla_itmi_dye", 2);
	 AddIngre("ooltyb_itmi_kft2", "ooltyb_itmi_paper", 20);
	 AddIngre("ooltyb_itmi_kft2", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_kft2", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft2", "ooltyb_itmi_kft2");
	SetCraftPenalty("ooltyb_itmi_kft2", 25);
	SetCraftScience("ooltyb_itmi_kft2", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_kft2", 25);
	SetCraftEXP("ooltyb_itmi_kft2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kft2", "������������")
	
AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_kscl"); ----- ����� ���������� ����� �����
	SetCraftAmount("ooltyb_itmi_kscl", 1);
	 AddIngre("ooltyb_itmi_kscl", "zdpwla_itmi_dye", 2);
	 AddIngre("ooltyb_itmi_kscl", "ooltyb_itmi_paper", 20);
	 AddIngre("ooltyb_itmi_kscl", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_kscl", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscl", "ooltyb_itmi_kscl");
	SetCraftPenalty("ooltyb_itmi_kscl", 25);
	SetCraftScience("ooltyb_itmi_kscl", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_kscl", 25);
	SetCraftEXP("ooltyb_itmi_kscl", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_kscl", "������������")
	
----- ������������ 1 ������� ����������

AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_magicore"); ----- ���������� ������
	SetCraftAmount("ooltyb_itmi_magicore", 5);
	 AddIngre("ooltyb_itmi_magicore", "ooltyb_itmi_addon_whitepearl", 1);
	 AddAlterIngre("ooltyb_itmi_magicore", "ooltyb_itmi_quartz", 1);
    AddTool("ooltyb_itmi_magicore", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_magicore", 25);
	SetCraftScience("ooltyb_itmi_magicore", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_magicore", 25);
	SetCraftEXP("ooltyb_itmi_magicore", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_magicore", "������������")
	
AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_m_ignot"); ----- ���������� ������
	SetCraftAmount("ooltyb_itmi_m_ignot", 1);
	 AddIngre("ooltyb_itmi_m_ignot", "OOLTYB_ITMI_Iron", 5);
	 AddIngre("ooltyb_itmi_m_ignot", "ooltyb_itmi_magicore", 10);
    AddTool("ooltyb_itmi_m_ignot", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_m_ignot", 25);
	SetCraftScience("ooltyb_itmi_m_ignot", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_m_ignot", 25);
	SetCraftEXP("ooltyb_itmi_m_ignot", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_m_ignot", "������������")

AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_runeblank"); ----- ��������� ���� 1 �����
	SetCraftAmount("ooltyb_itmi_runeblank", 1);
	 AddIngre("ooltyb_itmi_runeblank", "ooltyb_itmi_magicore", 25);
    AddTool("ooltyb_itmi_runeblank", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_runeblank", 25);
	SetCraftScience("ooltyb_itmi_runeblank", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_runeblank", 25);
	SetCraftEXP("ooltyb_itmi_runeblank", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_runeblank", "������������")
	
AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_mage2"); ----- ��������� ���� 2 �����
	SetCraftAmount("ooltyb_itmi_mage2", 1);
	 AddIngre("ooltyb_itmi_mage2", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("ooltyb_itmi_mage2", "ooltyb_itmi_runeblank", 1);
    AddTool("ooltyb_itmi_mage2", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage2", 25);
	SetCraftScience("ooltyb_itmi_mage2", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_mage2", 25);
	SetCraftEXP("ooltyb_itmi_mage2", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_mage2", "������������")
	
AddItemCategory ("������������ (1 �������)", "zdpwla_itmi_beltlm"); ----- ������ ���� �������
	SetCraftAmount("zdpwla_itmi_beltlm", 1);
	 AddIngre("zdpwla_itmi_beltlm", "ooltyb_itmi_runeblank", 1);
	 AddIngre("zdpwla_itmi_beltlm", "OOLTYB_ITMI_LEATHER", 1);
	AddTool("zdpwla_itmi_beltlm","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltlm", 5);
	SetCraftScience("zdpwla_itmi_beltlm", "������������", 1);
	SetenergyPenalty("zdpwla_itmi_beltlm", 25);
	SetCraftEXP("zdpwla_itmi_beltlm", 25)
	SetCraftEXP_SKILL("zdpwla_itmi_beltlm", "������������")
	
AddItemCategory ("������������ (1 �������)", "ooltyb_itmi_enchantset"); ----- ����� ��� �����������
	SetCraftAmount("ooltyb_itmi_enchantset", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_sulfur", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_addon_whitepearl", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_rockcrystal", 1);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_paper", 5);
	 AddIngre("ooltyb_itmi_enchantset", "ooltyb_itmi_magicore", 25);
	 AddIngre("ooltyb_itmi_enchantset", "zdpwla_itmi_dye", 1);
	AddTool("ooltyb_itmi_enchantset", "ooltyb_itmi_pliers");	
	SetCraftPenalty("ooltyb_itmi_enchantset", 25);
	SetCraftScience("ooltyb_itmi_enchantset", "������������", 1);
	SetenergyPenalty("ooltyb_itmi_enchantset", 25);
	SetCraftEXP("ooltyb_itmi_enchantset", 25)
	SetCraftEXP_SKILL("ooltyb_itmi_enchantset", "������������")
	
----- ������������ 1 ������� ���������

AddItemCategory ("������������ (1 �������)", "rmymew_itam_prot_mage_01"); ----- �������� �����
	SetCraftAmount("rmymew_itam_prot_mage_01", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_quartz", 2);
	 AddIngre("rmymew_itam_prot_mage_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itam_prot_mage_01","ooltyb_itmi_enchantset");	
	SetCraftPenalty("rmymew_itam_prot_mage_01", 25);
	SetCraftScience("rmymew_itam_prot_mage_01", "������������", 1);
	SetenergyPenalty("rmymew_itam_prot_mage_01", 25);
	SetCraftEXP("rmymew_itam_prot_mage_01", 25)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_01", "������������")
	
AddItemCategory ("������������ (1 �������)", "rmymew_itri_dex_01"); ----- ����� ������ ��������
	SetCraftAmount("rmymew_itri_dex_01", 1);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_rockcrystal", 2);
	 AddIngre("rmymew_itri_dex_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_dex_01","ooltyb_itmi_enchantset");	
	SetCraftPenalty("rmymew_itri_dex_01", 25);
	SetCraftScience("rmymew_itri_dex_01", "������������", 1);
	SetenergyPenalty("rmymew_itri_dex_01", 25);
	SetCraftEXP("rmymew_itri_dex_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_dex_01", "������������")
	
AddItemCategory ("������������ (1 �������)", "rmymew_itri_hp_01"); ----- ����� ������ �����
	SetCraftAmount("rmymew_itri_hp_01", 1);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_rubin", 2);
	 AddIngre("rmymew_itri_hp_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_hp_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_01", 25);
	SetCraftScience("rmymew_itri_hp_01", "������������", 1);
	SetenergyPenalty("rmymew_itri_hp_01", 25);
	SetCraftEXP("rmymew_itri_hp_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_hp_01", "������������")
	
AddItemCategory ("������������ (1 �������)", "rmymew_itri_str_01"); ----- ����� ������ ����
	SetCraftAmount("rmymew_itri_str_01", 1);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_sulfur", 2);
	 AddIngre("rmymew_itri_str_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_str_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_01", 25);
	SetCraftScience("rmymew_itri_str_01", "������������", 1);
	SetenergyPenalty("rmymew_itri_str_01", 25);
	SetCraftEXP("rmymew_itri_str_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_str_01", "������������")
	
AddItemCategory ("������������ (1 �������)", "rmymew_itri_mana_01"); ----- ������ �������
	SetCraftAmount("rmymew_itri_mana_01", 1);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_m_ignot", 1);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_aquamarine", 2);
	 AddIngre("rmymew_itri_mana_01", "ooltyb_itmi_bijouterie", 1);
	AddTool("rmymew_itri_mana_01", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_01", 25);
	SetCraftScience("rmymew_itri_mana_01", "������������", 1);
	SetenergyPenalty("rmymew_itri_mana_01", 25);
	SetCraftEXP("rmymew_itri_mana_01", 25)
	SetCraftEXP_SKILL("rmymew_itri_mana_01", "������������")

----- ������������ 2 ������� �����

AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_kft3"); ----- ����� ������ ��� 3
	SetCraftAmount("ooltyb_itmi_kft3", 1);
	 AddIngre("ooltyb_itmi_kft3", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kft3", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kft3", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kft3", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft3", "ooltyb_itmi_kft3");
	SetCraftPenalty("ooltyb_itmi_kft3", 15);
	SetCraftScience("ooltyb_itmi_kft3", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kft3", 50);
	SetCraftEXP("ooltyb_itmi_kft3", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kft3", "������������")
	
AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_kscs"); ----- ����� ���������� ����� ����
	SetCraftAmount("ooltyb_itmi_kscs", 1);
	 AddIngre("ooltyb_itmi_kscs", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscs", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscs", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscs", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscs", "ooltyb_itmi_kscs");
	SetCraftPenalty("ooltyb_itmi_kscs", 15);
	SetCraftScience("ooltyb_itmi_kscs", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kscs", 50);
	SetCraftEXP("ooltyb_itmi_kscs", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscs", "������������")
	
AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_kscf"); ----- ����� ���������� ����� ����
	SetCraftAmount("ooltyb_itmi_kscf", 1);
	 AddIngre("ooltyb_itmi_kscf", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscf", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscf", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscf", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscf", "ooltyb_itmi_kscf");
	SetCraftPenalty("ooltyb_itmi_kscf", 15);
	SetCraftScience("ooltyb_itmi_kscf", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kscf", 50);
	SetCraftEXP("ooltyb_itmi_kscf", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscf", "������������")
	
AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_kscw"); ----- ����� ���������� ����� ����
	SetCraftAmount("ooltyb_itmi_kscw", 1);
	 AddIngre("ooltyb_itmi_kscw", "zdpwla_itmi_dye", 3);
	 AddIngre("ooltyb_itmi_kscw", "ooltyb_itmi_paper", 30);
	 AddIngre("ooltyb_itmi_kscw", "ooltyb_itmi_magicore", 15);
    AddTool("ooltyb_itmi_kscw", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kscw", "ooltyb_itmi_kscw");
	SetCraftPenalty("ooltyb_itmi_kscw", 15);
	SetCraftScience("ooltyb_itmi_kscw", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kscw", 50);
	SetCraftEXP("ooltyb_itmi_kscw", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kscw", "������������")

AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_kft4"); ----- ����� ������ ��� 4
	SetCraftAmount("ooltyb_itmi_kft4", 1);
	 AddIngre("ooltyb_itmi_kft4", "zdpwla_itmi_dye", 4);
	 AddIngre("ooltyb_itmi_kft4", "ooltyb_itmi_paper", 40);
	 AddIngre("ooltyb_itmi_kft4", "ooltyb_itmi_magicore", 20);
    AddTool("ooltyb_itmi_kft4", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft4", "ooltyb_itmi_kft4");
	SetCraftPenalty("ooltyb_itmi_kft4", 15);
	SetCraftScience("ooltyb_itmi_kft4", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kft4", 50);
	SetCraftEXP("ooltyb_itmi_kft4", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_kft4", "������������")

----- ������������ 2 ������� ����������

AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_mage3"); ----- ��������� ���� 3 ����
	SetCraftAmount("ooltyb_itmi_mage3", 1);
	 AddIngre("ooltyb_itmi_mage3", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("ooltyb_itmi_mage3", "ooltyb_itmi_mage2", 1);
    AddTool("ooltyb_itmi_mage3", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage3", 15);
	SetCraftScience("ooltyb_itmi_mage3", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_mage3", 50);
	SetCraftEXP("ooltyb_itmi_mage3", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_mage3", "������������")
	
AddItemCategory ("������������ (2 �������)", "ooltyb_itmi_mage4"); ----- ��������� ���� 4 ����
	SetCraftAmount("ooltyb_itmi_mage4", 1);
	 AddIngre("ooltyb_itmi_mage4", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("ooltyb_itmi_mage4", "ooltyb_itmi_mage3", 1);
    AddTool("ooltyb_itmi_mage4", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage4", 15);
	SetCraftScience("ooltyb_itmi_mage4", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_mage4", 50);
	SetCraftEXP("ooltyb_itmi_mage4", 50)
	SetCraftEXP_SKILL("ooltyb_itmi_mage4", "������������")

AddItemCategory ("������������ (2 �������)", "zdpwla_itmi_belthm"); ----- ������ ���� ����
	SetCraftAmount("zdpwla_itmi_belthm", 1);
	 AddIngre("zdpwla_itmi_belthm", "ooltyb_itmi_mage3", 1);
	 AddIngre("zdpwla_itmi_belthm", "OOLTYB_ITMI_LEATHER", 2);
	AddTool("zdpwla_itmi_belthm","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_belthm", 5);
	SetCraftScience("zdpwla_itmi_belthm", "������������", 2);
	SetenergyPenalty("zdpwla_itmi_belthm", 50);
	SetCraftEXP("zdpwla_itmi_belthm", 50)
	SetCraftEXP_SKILL("zdpwla_itmi_belthm", "������������")
	
----- ������������ 2 ������� ���������

AddItemCategory ("������������ (2 �������)", "rmymew_itam_prot_mage_02"); ----- �������� ������
	SetCraftAmount("rmymew_itam_prot_mage_02", 1);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_quartz", 4);
	 AddIngre("rmymew_itam_prot_mage_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itam_prot_mage_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itam_prot_mage_02", 15);
	SetCraftScience("rmymew_itam_prot_mage_02", "������������", 2);
	SetenergyPenalty("rmymew_itam_prot_mage_02", 50);
	SetCraftEXP("rmymew_itam_prot_mage_02", 50)
	SetCraftEXP_SKILL("rmymew_itam_prot_mage_02", "������������")
	
AddItemCategory ("������������ (2 �������)", "rmymew_itri_dex_02"); ----- ������� ������ ��������
	SetCraftAmount("rmymew_itri_dex_02", 1);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_rockcrystal", 4);
	 AddIngre("rmymew_itri_dex_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_dex_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_dex_02", 15);
	SetCraftScience("rmymew_itri_dex_02", "������������", 2);
	SetenergyPenalty("rmymew_itri_dex_02", 50);
	SetCraftEXP("rmymew_itri_dex_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_dex_02", "������������")
	
AddItemCategory ("������������ (2 �������)", "rmymew_itri_hp_02"); ----- ������� ������ �����
	SetCraftAmount("rmymew_itri_hp_02", 1);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_rubin", 4);
	 AddIngre("rmymew_itri_hp_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_hp_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_02", 15);
	SetCraftScience("rmymew_itri_hp_02", "������������", 2);
	SetenergyPenalty("rmymew_itri_hp_02", 50);
	SetCraftEXP("rmymew_itri_hp_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_hp_02", "������������")
	
AddItemCategory ("������������ (2 �������)", "rmymew_itri_str_02"); ----- ������� ������ ����
	SetCraftAmount("rmymew_itri_str_02", 1);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_sulfur", 4);
	 AddIngre("rmymew_itri_str_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_str_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_02", 15);
	SetCraftScience("rmymew_itri_str_02", "������������", 2);
	SetenergyPenalty("rmymew_itri_str_02", 50);
	SetCraftEXP("rmymew_itri_str_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_str_02", "������������")
	
AddItemCategory ("������������ (2 �������)", "rmymew_itri_mana_02"); ----- ������ ����
	SetCraftAmount("rmymew_itri_mana_02", 1);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_m_ignot", 2);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_aquamarine", 4);
	 AddIngre("rmymew_itri_mana_02", "ooltyb_itmi_bijouterie", 2);
	AddTool("rmymew_itri_mana_02", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_02", 15);
	SetCraftScience("rmymew_itri_mana_02", "������������", 2);
	SetenergyPenalty("rmymew_itri_mana_02", 50);
	SetCraftEXP("rmymew_itri_mana_02", 50)
	SetCraftEXP_SKILL("rmymew_itri_mana_02", "������������")

----- ������������ 3 ������� �����

AddItemCategory ("������������ (3 �������)", "ooltyb_itmi_kft5"); ----- ����� ������ ��� 5
	SetCraftAmount("ooltyb_itmi_kft5", 1);
	 AddIngre("ooltyb_itmi_kft5", "zdpwla_itmi_dye", 5);
	 AddIngre("ooltyb_itmi_kft5", "ooltyb_itmi_paper", 50);
	 AddIngre("ooltyb_itmi_kft5", "ooltyb_itmi_magicore", 25);
    AddTool("ooltyb_itmi_kft5", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft5", "ooltyb_itmi_kft5");
	SetCraftPenalty("ooltyb_itmi_kft5", 15);
	SetCraftScience("ooltyb_itmi_kft5", "������������", 2);
	SetenergyPenalty("ooltyb_itmi_kft5", 75);

AddItemCategory ("������������ (3 �������)", "ooltyb_itmi_kft6"); ----- ����� ������ ��� 6
	SetCraftAmount("ooltyb_itmi_kft6", 1);
	 AddIngre("ooltyb_itmi_kft6", "zdpwla_itmi_dye", 6);
	 AddIngre("ooltyb_itmi_kft6", "ooltyb_itmi_paper", 60);
	 AddIngre("ooltyb_itmi_kft6", "ooltyb_itmi_magicore", 30);
    AddTool("ooltyb_itmi_kft6", "ooltyb_itmi_enchantset");
	AddTool("ooltyb_itmi_kft6", "ooltyb_itmi_kft6");
	SetCraftPenalty("ooltyb_itmi_kft6", 15);
	SetCraftScience("ooltyb_itmi_kft6", "������������", 3);
	SetenergyPenalty("ooltyb_itmi_kft6", 75);

----- ������������ 3 ������� ����������
	
AddItemCategory ("������������ (3 �������)", "ooltyb_itmi_mage5"); ----- ��������� ���� 5 ����
	SetCraftAmount("ooltyb_itmi_mage5", 1);
	 AddIngre("ooltyb_itmi_mage5", "ooltyb_itmi_m_ignot", 4);
	 AddIngre("ooltyb_itmi_mage5", "ooltyb_itmi_mage4", 1);
    AddTool("ooltyb_itmi_mage5", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage5", 15);
	SetCraftScience("ooltyb_itmi_mage5", "������������", 3);
	SetenergyPenalty("ooltyb_itmi_mage5", 75);
	
AddItemCategory ("������������ (3 �������)", "ooltyb_itmi_mage6"); ----- ��������� ���� 6 ����
	SetCraftAmount("ooltyb_itmi_mage6", 1);
	 AddIngre("ooltyb_itmi_mage6", "ooltyb_itmi_m_ignot", 5);
	 AddIngre("ooltyb_itmi_mage6", "ooltyb_itmi_mage5", 1);
    AddTool("ooltyb_itmi_mage6", "ooltyb_itmi_pliers");
	SetCraftPenalty("ooltyb_itmi_mage6", 15);
	SetCraftScience("ooltyb_itmi_mage6", "������������", 3);
	SetenergyPenalty("ooltyb_itmi_mage6", 75);
	
AddItemCategory ("������������ (3 �������)", "zdpwla_itmi_beltum"); ----- ������ ���� �������
	SetCraftAmount("zdpwla_itmi_beltum", 1);
	 AddIngre("zdpwla_itmi_beltum", "ooltyb_itmi_mage5", 1);
	 AddIngre("zdpwla_itmi_beltum", "ooltyb_itmi_t_leather", 1);
	AddTool("zdpwla_itmi_beltum","ooltyb_itmi_pliers");	
	SetCraftPenalty("zdpwla_itmi_beltum", 5);
	SetCraftScience("zdpwla_itmi_beltum", "������������", 3);
	SetenergyPenalty("zdpwla_itmi_beltum", 75);
	
----- ������������ 3 ������� ���������
	
AddItemCategory ("������������ (3 �������)", "rmymew_itam_prot_mage_03"); ----- �������� ������
	SetCraftAmount("rmymew_itam_prot_mage_03", 1);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_quartz", 8);
	 AddIngre("rmymew_itam_prot_mage_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itam_prot_mage_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itam_prot_mage_03", 15);
	SetCraftScience("rmymew_itam_prot_mage_03", "������������", 3);
	SetenergyPenalty("rmymew_itam_prot_mage_03", 75);
	
AddItemCategory ("������������ (3 �������)", "rmymew_itri_dex_03"); ----- ������� ������ ��������
	SetCraftAmount("rmymew_itri_dex_03", 1);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_rockcrystal", 8);
	 AddIngre("rmymew_itri_dex_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_dex_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_dex_03", 15);
	SetCraftScience("rmymew_itri_dex_03", "������������", 3);
	SetenergyPenalty("rmymew_itri_dex_03", 75);
	
AddItemCategory ("������������ (3 �������)", "rmymew_itri_hp_03"); ----- ������� ������ �����
	SetCraftAmount("rmymew_itri_hp_03", 1);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_rubin", 8);
	 AddIngre("rmymew_itri_hp_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_hp_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_hp_03", 15);
	SetCraftScience("rmymew_itri_hp_03", "������������", 3);
	SetenergyPenalty("rmymew_itri_hp_03", 75);
	
AddItemCategory ("������������ (3 �������)", "rmymew_itri_str_03"); ----- ������� ������ ����
	SetCraftAmount("rmymew_itri_str_03", 1);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_sulfur", 8);
	 AddIngre("rmymew_itri_str_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_str_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_str_03", 15);
	SetCraftScience("rmymew_itri_str_03", "������������", 3);
	SetenergyPenalty("rmymew_itri_str_03", 75);
	
AddItemCategory ("������������ (3 �������)", "rmymew_itri_mana_03"); ----- ������ �������
	SetCraftAmount("rmymew_itri_mana_03", 1);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_m_ignot", 3);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_aquamarine", 8);
	 AddIngre("rmymew_itri_mana_03", "ooltyb_itmi_bijouterie", 3);
	AddTool("rmymew_itri_mana_03", "ooltyb_itmi_enchantset");
	SetCraftPenalty("rmymew_itri_mana_03", 15);
	SetCraftScience("rmymew_itri_mana_03", "������������", 3);
	SetenergyPenalty("rmymew_itri_mana_03", 75);
	
-- �������������������������������������������������������������������������������������������������������������������������������

	
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
		local k = "��� ���������"
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
	
	
	GUI_Craft[pid].cat_title = CreatePlayerDraw(pid, 500, 50, "���������", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].it_title = CreatePlayerDraw(pid, 2900, 50, "�������", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	GUI_Craft[pid].add_title = CreatePlayerDraw(pid, 5775, 50, "����������", "Font_Old_20_White_Hi.TGA", 255, 165, 0);
	
	GUI_Craft[pid].exit_draw = CreatePlayerDraw(pid, 2900, 7200, "����� (ESC)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
	GUI_Craft[pid].produce_draw = CreatePlayerDraw(pid, 5775, 7200, "���������� (Enter)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
			
			
	GUI_Craft[pid].cat_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
	GUI_Craft[pid].it_cur = CreatePlayerDraw(pid, 525, 500, '>', "Font_Old_10_White_Hi.TGA", 255, 13, 13);
			
	GUI_Craft[pid].cat = {};
	local i = 0;
	
	GameTextForPlayer(pid, 1500, 7500, "��������. ���������...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 1000);
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
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�������������� ���.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� �������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d �����", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� ������������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ��.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s ��.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
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
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;
						
						if tLen(CraftItem[vi].tools) > 0 then
							for kii, vii in pairs(CraftItem[vi].tools) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						for kii, vii in pairs(CraftItem[vi].ing) do				
							table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
							k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�������������� ���.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].altering) > 0 then
							for kii, vii in pairs(CraftItem[vi].altering) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
						end
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� �������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
												
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d �����", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;	
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� ������������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;							
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ��.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
						k = k + 1;
						
						table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
						k = k + 1;	
						
						if tLen(CraftItem[vi].science) > 0 then
							for kii, vii in pairs(CraftItem[vi].science) do
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s ��.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
							end
						else
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
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
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�������������� ���.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� �������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d �����", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� ������������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ��.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;

								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s ��.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
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
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;
								
								if tLen(CraftItem[vi].tools) > 0 then
									for kii, vii in pairs(CraftItem[vi].tools) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, " - "..GetItemName(kii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								for kii, vii in pairs(CraftItem[vi].ing) do				
									table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[vi].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
									k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�������������� ���.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].altering) > 0 then
									for kii, vii in pairs(CraftItem[vi].altering) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, GetItemName(CraftItem[vi].altering), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
								end
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� �������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d �����", CraftItem[vi].penalty), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;	
								
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� ������������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;							
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ��.", CraftItem[vi].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
								k = k + 1;
								
								table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
								k = k + 1;	
								
								if tLen(CraftItem[vi].science) > 0 then
									for kii, vii in pairs(CraftItem[vi].science) do
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s ��.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
										k = k + 1;
									end
								else
										table.insert(GUI_Craft[pid].cat[i].items[j].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
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
	
	GameTextForPlayer(pid, 1500, 7500, "�������� ������ ���������...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
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
	GameTextForPlayer(pid, 1500, 7500, "�������� ������ ��������� ��������...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
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
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
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
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�����������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing) do				
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].ing[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "�������������� ���.: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
												
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("\t - %s x%d", GetItemName(kii), CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].altering[kii].amount), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
		k = k + 1;
	end
								
												
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "����� ������������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;							
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("- %d ��.", CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].energy), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
	k = k + 1;
								
	table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "������: ", "Font_Old_10_White_Hi.TGA", 200, 2, 2));
	k = k + 1;	
								
	if tCount(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) > 0 then
		for kii, vii in pairs(CraftItem[GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].instance].science) do
			table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, string.format("%s ��.%d", kii, vii), "Font_Old_10_White_Hi.TGA", 255, 255, 255));
			k = k + 1;
		end
	else
		table.insert(GUI_Craft[pid].cat[GUI_Craft[pid].current_cat].items[GUI_Craft[pid].current_item].addition, CreatePlayerDraw(pid, 5650, 500 + 300*k, "\t - �����������", "Font_Old_10_White_Hi.TGA", 255, 255, 255));
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
	GameTextForPlayer(pid, 1500, 7500, "������� ������ ����� ��������...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
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
		GameTextForPlayer(pid, 1500, 7500, "�������� �������...", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 500);
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
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." ��������� �������: "..GetItemName(instance));
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
		GameTextForPlayer(pid, 1500, 7500, "������������ ������������","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
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
	
	GameTextForPlayer(pid, 1500, 7500, "������������� ������� ������","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);

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
	file:write(GetScienceLevel(id, "�����").." "..Player[id].scraft_povar[2].."\n");
	file:write(GetScienceLevel(id, "�������").." "..Player[id].scraft_plotnik[2].."\n");
	file:write(GetScienceLevel(id, "�������").." "..Player[id].scraft_bronnik[2].."\n");

	file:write(GetScienceLevel(id, "���������").." "..Player[id].scraft_oryjeynik[2].."\n");
	file:write(GetScienceLevel(id, "�������").." "..Player[id].scraft_portnoy[2].."\n");
	file:write(GetScienceLevel(id, "�������").." "..Player[id].scraft_alhimic[2].."\n");

	file:write(GetScienceLevel(id, "��������").." "..Player[id].scraft_kozhevnik[2].."\n");
	file:write(GetScienceLevel(id, "������������").." "..Player[id].scraft_zacharovatel[2].."\n");
	file:write(GetScienceLevel(id, "�����").." "..Player[id].scraft_magic[2].."\n");

	file:write(GetScienceLevel(id, "������").." "..Player[id].scraft_lekar[2].."\n");

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
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_kozhevnik[2].."/"..nexp..". ������� ��������� ���������: "..GetScienceLevel(id, "��������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
		if Player[id].scraft_alhimic[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_alhimic[2].."/"..nexp..". ������� ��������� ��������: "..GetScienceLevel(id, "�������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
		if Player[id].scraft_portnoy[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_portnoy[2].."/"..nexp..". ������� ��������� ��������: "..GetScienceLevel(id, "�������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
		if Player[id].scraft_oryjeynik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_oryjeynik[2].."/"..nexp..". ������� ��������� ����������: "..GetScienceLevel(id, "���������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_POVAR_LEVELS) do
		if Player[id].scraft_povar[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_povar[2].."/"..nexp..". ������� ��������� ������: "..GetScienceLevel(id, "�����"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
		if Player[id].scraft_plotnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_plotnik[2].."/"..nexp..". ������� ��������� ��������: "..GetScienceLevel(id, "�������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
		if Player[id].scraft_bronnik[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_bronnik[2].."/"..nexp..". ������� ��������� ��������: "..GetScienceLevel(id, "�������"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_MAGIC_LEVELS) do
		if Player[id].scraft_magic[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_magic[2].."/"..nexp..". ������� ��������� �����: "..GetScienceLevel(id, "�����"));
		end
	end

	local nexp = 0;
	for i, v in ipairs(CRAFT_ZACHAROVATEL_LEVELS) do
		if Player[id].scraft_zacharovatel[1] == i then
			nexp = v;
			SendPlayerMessage(id, 255, 255, 255, "������� ����: "..Player[id].scraft_zacharovatel[2].."/"..nexp..". ������� ��������� ������������: "..GetScienceLevel(id, "������������"));
		end
	end

end
addCommandHandler({"/�����"}, _getCraftExpCMD);

function _craftGiveEXP(id, skill, exp)

	--#######################################################################################################
	if skill == "�����" then

			if GetScienceLevel(id, "�����") > 0 then
				local oldValue = Player[id].scraft_povar[2]; Player[id].scraft_povar[2] = Player[id].scraft_povar[2] + exp; local newValue = Player[id].scraft_povar[2];
				_craftSaveEXP(id);

				local nexp = 0;
				for i, v in ipairs(CRAFT_POVAR_LEVELS) do
					if Player[id].scraft_povar[1] == i then
						nexp = v;
						SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
					end
				end

				if Player[id].scraft_povar[2] >= nexp then
					Player[id].scraft_povar[1] = Player[id].scraft_povar[1] + 1; Player[id].scraft_povar[2] = 0;
					AddScience(id, "�����", Player[id].scraft_povar[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� ������ �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				end
			end
		--#######################################################################################################
	elseif skill == "�������" then

		if GetScienceLevel(id, "�������") > 0 then
			local oldValue = Player[id].scraft_plotnik[2]; Player[id].scraft_plotnik[2] = Player[id].scraft_plotnik[2] + exp; local newValue = Player[id].scraft_plotnik[2];
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PLOTNIK_LEVELS) do
				if Player[id].scraft_plotnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_plotnik[2] >= nexp then
				Player[id].scraft_plotnik[1] = Player[id].scraft_plotnik[1] + 1; Player[id].scraft_plotnik[2] = 0;
				AddScience(id, "�������", Player[id].scraft_plotnik[1]);
				SendPlayerMessage(id, 255, 255, 255, "������� �������� �������!");
				_craftSaveEXP(id);
				SaveDLPlayerInfo(id);
			end
		end
		--#######################################################################################################
	elseif skill == "�������" then

		if GetScienceLevel(id, "�������") > 0 then
				local oldValue = Player[id].scraft_portnoy[2]; Player[id].scraft_portnoy[2] = Player[id].scraft_portnoy[2] + exp; local newValue = Player[id].scraft_portnoy[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_PORTNOY_LEVELS) do
				if Player[id].scraft_portnoy[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_portnoy[2] >= nexp then

					Player[id].scraft_portnoy[1] = Player[id].scraft_portnoy[1] + 1; Player[id].scraft_portnoy[2] = 0;
					AddScience(id, "�������", Player[id].scraft_portnoy[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� �������� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "���������" then
		if GetScienceLevel(id, "���������") > 0 then
			local oldValue = Player[id].scraft_oryjeynik[2]; Player[id].scraft_oryjeynik[2] = Player[id].scraft_oryjeynik[2] + exp; local newValue = Player[id].scraft_oryjeynik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ORYJEYNIK_LEVELS) do
				if Player[id].scraft_oryjeynik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_oryjeynik[2] >= nexp then

					Player[id].scraft_oryjeynik[1] = Player[id].scraft_oryjeynik[1] + 1; Player[id].scraft_oryjeynik[2] = 0;
					AddScience(id, "���������", Player[id].scraft_oryjeynik[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� ���������� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "�������" then
		if GetScienceLevel(id, "�������") > 0 then
			local oldValue = Player[id].scraft_bronnik[2]; Player[id].scraft_bronnik[2] = Player[id].scraft_bronnik[2] + exp; local newValue = Player[id].scraft_bronnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_BRONNIK_LEVELS) do
				if Player[id].scraft_bronnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_bronnik[2] >= nexp then

					Player[id].scraft_bronnik[1] = Player[id].scraft_bronnik[1] + 1; Player[id].scraft_bronnik[2] = 0;
					AddScience(id, "�������", Player[id].scraft_bronnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� �������� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "��������" then
		if GetScienceLevel(id, "��������") > 0 then

			local oldValue = Player[id].scraft_kozhevnik[2]; Player[id].scraft_kozhevnik[2] = Player[id].scraft_kozhevnik[2] + exp; local newValue = Player[id].scraft_kozhevnik[2]
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_KOZHEVNIK_LEVELS) do
				if Player[id].scraft_kozhevnik[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_kozhevnik[2] >= nexp then

					Player[id].scraft_kozhevnik[1] = Player[id].scraft_kozhevnik[1] + 1; Player[id].scraft_kozhevnik[2] = 0;
					AddScience(id, "��������", Player[id].scraft_kozhevnik[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� ��������� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);

			end
		end
		--#######################################################################################################
	elseif skill == "�������" then
		if GetScienceLevel(id, "�������") > 0 then

			local oldValue = Player[id].scraft_alhimic[2]; Player[id].scraft_alhimic[2] = Player[id].scraft_alhimic[2] + exp; local newValue = Player[id].scraft_alhimic[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ALHIMIC_LEVELS) do
				if Player[id].scraft_alhimic[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_alhimic[2] >= nexp then
				
					Player[id].scraft_alhimic[1] = Player[id].scraft_alhimic[1] + 1; Player[id].scraft_alhimic[2] = 0;
					AddScience(id, "�������", Player[id].scraft_alhimic[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� �������� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				
			end
		end
		--#######################################################################################################
	elseif skill == "�����" then
		if GetScienceLevel(id, "�����") > 0 then

			local oldValue = Player[id].scraft_magic[2]; Player[id].scraft_magic[2] = Player[id].scraft_magic[2] + exp; local newValue = Player[id].scraft_magic[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_MAGIC_LEVELS) do
				if Player[id].scraft_magic[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_magic[2] >= nexp then
				
					Player[id].scraft_magic[1] = Player[id].scraft_magic[1] + 1; Player[id].scraft_magic[2] = 0;
					AddScience(id, "�����", Player[id].scraft_magic[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� ����� �������!");
					_craftSaveEXP(id);
					SaveDLPlayerInfo(id);
				
			end
		end
		--#######################################################################################################
	--#######################################################################################################
	elseif skill == "������������" then
		if GetScienceLevel(id, "������������") > 0 then

			local oldValue = Player[id].scraft_zacharovatel[2]; Player[id].scraft_zacharovatel[2] = Player[id].scraft_zacharovatel[2] + exp; local newValue = Player[id].scraft_zacharovatel[2]; 
			_craftSaveEXP(id);

			local nexp = 0;
			for i, v in ipairs(CRAFT_ZACHAROVATEL_LEVELS) do
				if Player[id].scraft_zacharovatel[1] == i then
					nexp = v;
					SendPlayerMessage(id, 255, 255, 255, "������� ����: "..newValue.."/"..nexp.." (�������� �����: "..newValue-oldValue..")");
				end
			end

			if Player[id].scraft_zacharovatel[2] >= nexp then
			
					Player[id].scraft_zacharovatel[1] = Player[id].scraft_zacharovatel[1] + 1; Player[id].scraft_zacharovatel[2] = 0;
					AddScience(id, "������������", Player[id].scraft_zacharovatel[1]);
					SendPlayerMessage(id, 255, 255, 255, "������� ������������ �������!");
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
			SendPlayerMessage(pid, 255, 255, 255, GetPlayerName(pid).." ��������� �������: "..GetItemName(instance));
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
	
	GameTextForPlayer(pid,  1500, 7500, "��� ����������� ������������","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
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
	
	GameTextForPlayer(pid,  1500, 7500, "������������ ��������","Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
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
		GameTextForPlayer(pid,  1500, 7500, "�������������� ������������ �� ���������� ��� ����� ������", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
		return false;
	end
	
	if matches == max_matches then
		return true;
	end
	
	GameTextForPlayer(pid,  1500, 7500, "������������ �������������� ��������", "Font_Old_10_White_Hi.TGA", 255, 154, 0, 2000);
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