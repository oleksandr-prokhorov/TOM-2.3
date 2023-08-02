

local ztex = {};
EditorPlaya = {};
ztex[0] = {};

local speedswitch = 5;
local OnTex = 1;
local tex = nil;
local x1 = 4000;
local y1 = 3500;
local x2 = 500;
local y2 = 500;

for id = 0, MAX_PLAYERS - 1 do
	EditorPlaya[id] = {};
	EditorPlaya[id].ztexOn = false;
	EditorPlaya[id].Timer = 0;
end

function GetTextures()
	local cout = 0;
	for i,v in ipairs(ztex) do 
		cout = i;
	end
	return cout;
end

function ztex:Create(pid, zetex)
	local cout = GetTextures();
	if zetex then
		cout = cout + 1
		OnTex = cout
		ztex[cout] = {}
		ztex[cout].arg = CreateTexture(4000, 3500, 4500, 4000, zetex)
		ztex[cout].tex = zetex;
		ztex[cout].x1 = 4000;
		ztex[cout].y1 = 3500;
		ztex[cout].x2 = 500;
		ztex[cout].y2 = 500;
		ShowTexture(pid, ztex[cout].arg);
		SendPlayerMessage(pid,219,20,73,"(zTex): Tex id: "..cout.." has been created.");
	end
end

function ztex:Switch(playerid, x1, y1, x2, y2)
	UpdateTextureSize(ztex[OnTex].arg, x1, y1, x2, y2, ztex[OnTex].tex)
end

function ztex:Save(playerid)
	for i = 1, GetTextures() do
		LogString("(zTex) resultTexEditor", "CreateTexture(arg "..i..", "..ztex[i].x1..", "..ztex[i].y1..", "..ztex[i].x1+ztex[i].x2..", "..ztex[i].y1+ztex[i].y2..", '"..ztex[i].tex.."')" )
	end
end


function CMD_CTEX(playerid, params)
	local result, texb = sscanf( params, "s" )
	if result == 1 then
		ztex:Create(playerid, texb)
	end
end
addCommandHandler({"/ztex","/зтекс"}, CMD_CTEX);

function CMD_INITTEX(playerid, params)
	if EditorPlaya[playerid].ztexOn == false then
		EditorPlaya[playerid].ztexOn = true
		SendPlayerMessage(playerid,219,20,73,"(zTex): zTex has been ON!");
		FreezePlayer(playerid, 1)
	else
		EditorPlaya[playerid].ztexOn = false
		SendPlayerMessage(playerid,219,10,73,"(zTex): zTex has been OFF!");
		FreezePlayer(playerid, 0)
	end
end
addCommandHandler({"/zinit","/зинит"}, CMD_INITTEX);

function TexSave(playerid)
	ztex:Save(playerid)
end
addCommandHandler({"/texsave"}, TexSave);

function im1(playerid)
ztex:Switch(playerid, ztex[OnTex].x1, ztex[OnTex].y1 - speedswitch, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].y1 = ztex[OnTex].y1 - speedswitch
end

function im2(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1, ztex[OnTex].y1 + speedswitch, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].y1 = ztex[OnTex].y1 + speedswitch
end

function im3(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1 - speedswitch, ztex[OnTex].y1, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].x1 = ztex[OnTex].x1 - speedswitch
end

function im4(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1 + speedswitch, ztex[OnTex].y1, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].x1 = ztex[OnTex].x1 + speedswitch
end

function sim1(playerid)
ztex:Switch(playerid, ztex[OnTex].x1, ztex[OnTex].y1 - speedswitch, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].y2 = ztex[OnTex].y2 - speedswitch
end

function sim2(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1, ztex[OnTex].y1 + speedswitch, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].y2 = ztex[OnTex].y2 + speedswitch
end

function sim3(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1 - speedswitch, ztex[OnTex].y1, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].x2 = ztex[OnTex].x2 - speedswitch
end

function sim4(playerid)
		ztex:Switch(playerid, ztex[OnTex].x1 + speedswitch, ztex[OnTex].y1, ztex[OnTex].x2, ztex[OnTex].y2)
		ztex[OnTex].x2 = ztex[OnTex].x2 + speedswitch
end

function zTexUpdate()
	for id = 0, MAX_PLAYERS - 1 do
		if IsPlayerConnected(id) == 1 then
			if EditorPlaya[id].Timer == 1 then
				im1(id)
			elseif EditorPlaya[id].Timer == 2 then
				im2(id)
			elseif EditorPlaya[id].Timer == 3 then
				im3(id)
			elseif EditorPlaya[id].Timer == 4 then
				im4(id)
			elseif EditorPlaya[id].Timer == 5 then
				sim1(id)
			elseif EditorPlaya[id].Timer == 6 then
				sim2(id)
			elseif EditorPlaya[id].Timer == 7 then
				sim3(id)
			elseif EditorPlaya[id].Timer == 8 then
				sim4(id)
			end
		end
	end
end
SetTimer("zTexUpdate", 1, 100);

function TextureEdKey(playerid, keydown, keyup)
	if EditorPlaya[playerid].ztexOn == true then
		if keydown == KEY_UP then
			EditorPlaya[playerid].Timer = 1 --KillTimer (timerid)
		elseif keydown == KEY_DOWN then
			EditorPlaya[playerid].Timer = 2
		elseif keydown == KEY_LEFT then
			EditorPlaya[playerid].Timer = 3
		elseif keydown == KEY_RIGHT then
			EditorPlaya[playerid].Timer = 4
		elseif keydown == KEY_MINUS then
			speedswitch = speedswitch + 0.5 ;
		elseif keydown == KEY_EQUALS then
			speedswitch = speedswitch - 0.5;
		elseif keydown == KEY_I then
			OnTex = OnTex - 1;
			if OnTex < 1 then
				OnTex = 1
			end
		elseif keydown == KEY_O then
			OnTex = OnTex + 1;
			if OnTex > GetTextures() then
				OnTex = GetTextures();
			end
		elseif keyup == KEY_UP then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_DOWN then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_LEFT then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_RIGHT then
			EditorPlaya[playerid].Timer = 0
		
		elseif keydown == KEY_NUMPAD8 then
			EditorPlaya[playerid].Timer = 5 --KillTimer (timerid)
		elseif keydown == KEY_NUMPAD2 then
			EditorPlaya[playerid].Timer = 6
		elseif keydown == KEY_NUMPAD4 then
			EditorPlaya[playerid].Timer = 7
		elseif keydown == KEY_NUMPAD6 then
			EditorPlaya[playerid].Timer = 8
			
		elseif keyup == KEY_NUMPAD8 then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_NUMPAD2 then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_NUMPAD4 then
			EditorPlaya[playerid].Timer = 0
		elseif keyup == KEY_NUMPAD6 then
			EditorPlaya[playerid].Timer = 0
		end
	end
end

print("ztex has been loaded.");