local EditorPlayaDraw = {};
local zdraw = {};
zdraw[0] = {};
--local tex = nil;
speedswitch = 3;
OnDraw = 1;
draw = nil;
x1 = 4000;
y1 = 3500;
x2 = 500;
y2 = 500;

--[[

UpdateTexture(..., 1835, 1490, 4885, 6120, DLG_CONVERSATION.tga)
UpdateTexture(..., 72, 7128, 1079, 218, bar_back.tga) UpdateTexture(..., 111, 7161, 993, 156, bar_iddqd.tex)
]]--

for id = 0, MAX_PLAYERS - 1 do
	EditorPlayaDraw[id] = {}
	EditorPlayaDraw[id].zdrawOn = false;
	EditorPlayaDraw[id].Timer = 0;
end

function GetDrawsEd()
	local cout = 0;
	for i,v in ipairs(zdraw) do 
		cout = i;
	end
	return cout;
end

function zdraw:Create(pid, zedre)
	local cout = GetDrawsEd();
	if zedre then
		cout = cout + 1
		zdraw[cout] = {};
		zdraw[cout].arg = CreateDraw(6035, 1690, zedre, "Font_Old_10_White_Hi.TGA", 255,255,255); -- FONT_MENU_HI.TGA Font_Old_10_White_Hi.TGA
		zdraw[cout].name = zedre;
		zdraw[cout].x = 420;
		zdraw[cout].y = 1710;
		ShowDraw(pid, zdraw[cout].arg);
		SendPlayerMessage(pid,0,130,180,"(zDraw): Draw id: "..cout.." has been created.");
	end
end

function zdraw:Switch(playerid, x1, y1)
	SetDrawPos(zdraw[OnDraw].arg, zdraw[OnDraw].x, zdraw[OnDraw].y)
end

function zdraw:Save(playerid)
	for i = 1, GetDrawsEd() do
		LogString("(zDraw) resultDrawEditor", "CreateDraw("..zdraw[OnDraw].name..", "..zdraw[OnDraw].x..", "..zdraw[OnDraw].y..")" )
		LogString("(zDraw) resultDrawEditor", "UpdateDrawPixel(, "..zdraw[OnDraw].name..", "..nax(playerid, zdraw[OnDraw].x)..", "..nay(playerid, zdraw[OnDraw].y)..")" )
	end
end

function CMD_CDRAW(playerid, params)
	local result, texb = sscanf( params, "s" )
	if result == 1 then
		zdraw:Create(playerid, texb)
	end
end
addCommandHandler({"/драв", "/draw"}, CMD_CDRAW);

function CMD_INITTEX(playerid, params)
	if EditorPlayaDraw[playerid].zdrawOn == false then
		EditorPlayaDraw[playerid].zdrawOn = true
		SendPlayerMessage(playerid,0,130,180,"(zDraw): zDraw has been ON!");
		FreezePlayer(playerid, 1)
	else
		EditorPlayaDraw[playerid].zdrawOn = false
		SendPlayerMessage(playerid,0,130,180,"(zDraw): zDraw has been OFF!");
		FreezePlayer(playerid, 0)
	end
end
addCommandHandler({"/вдрав", "/zdraw"}, CMD_INITTEX);

function DrawSave(playerid)
	zdraw:Save(playerid)
end
addCommandHandler({"/сдрав", "/sdraw"}, DrawSave);

function lim1(playerid)
zdraw:Switch(playerid, zdraw[OnDraw].x, zdraw[OnDraw].y - speedswitch)
		zdraw[OnDraw].y = zdraw[OnDraw].y - speedswitch
end

function lim2(playerid)
		zdraw:Switch(playerid, zdraw[OnDraw].x, zdraw[OnDraw].y + speedswitch)
		zdraw[OnDraw].y = zdraw[OnDraw].y + speedswitch
end

function lim3(playerid)
		zdraw:Switch(playerid, zdraw[OnDraw].x - speedswitch, zdraw[OnDraw].y)
		zdraw[OnDraw].x = zdraw[OnDraw].x - speedswitch
end

function lim4(playerid)
		zdraw:Switch(playerid, zdraw[OnDraw].x + speedswitch, zdraw[OnDraw].y)
		zdraw[OnDraw].x = zdraw[OnDraw].x + speedswitch
end

function zDrawUpdate()
	for id = 0, MAX_PLAYERS - 1 do
		if IsPlayerConnected(id) == 1 then
			if EditorPlayaDraw[id].Timer == 1 then
				lim1(id)
			elseif EditorPlayaDraw[id].Timer == 2 then
				lim2(id)
			elseif EditorPlayaDraw[id].Timer == 3 then
				lim3(id)
			elseif EditorPlayaDraw[id].Timer == 4 then
				lim4(id)
			end
		end
	end
end
SetTimer("zDrawUpdate", 1, 100);

function zDrawKey(playerid, keydown, keyup)

	if keydown == KEY_M then
		can = true;
		SendPlayerMessage(playerid, 255, 255, 255, "(zdraw) okay go")
	end

	if EditorPlayaDraw[playerid].zdrawOn == true and can == true then
		if keydown == KEY_UP then
			EditorPlayaDraw[playerid].Timer = 1 --KillTimer (timerid)
		elseif keydown == KEY_DOWN then
			EditorPlayaDraw[playerid].Timer = 2
		elseif keydown == KEY_LEFT then
			EditorPlayaDraw[playerid].Timer = 3
		elseif keydown == KEY_RIGHT then
			EditorPlayaDraw[playerid].Timer = 4
		elseif keydown == KEY_MINUS then
			speedswitch = speedswitch + 1 ;
		elseif keydown == KEY_EQUALS then
			speedswitch = speedswitch - 1;
		elseif keydown == KEY_I then
			OnDraw = OnDraw - 1;
			if OnDraw < 1 then
				OnDraw = 1
			end
		elseif keydown == KEY_O then
			OnDraw = OnDraw + 1;
			if OnDraw > GetDrawsEd() then
				OnDraw = GetDrawsEd();
			end
		elseif keyup == KEY_UP then
			EditorPlayaDraw[playerid].Timer = 0
		elseif keyup == KEY_DOWN then
			EditorPlayaDraw[playerid].Timer = 0
		elseif keyup == KEY_LEFT then
			EditorPlayaDraw[playerid].Timer = 0
		elseif keyup == KEY_RIGHT then
			EditorPlayaDraw[playerid].Timer = 0
		end
	end
end

print("zdraw has been loaded.");