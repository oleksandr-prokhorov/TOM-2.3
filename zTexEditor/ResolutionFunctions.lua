--[[

	Script: anx, any and pixel resolution script

]]--

MyPPI = 96.910963052692 --// My PPI resolution 1366x768
local VIEW_MAX = 8192;
MyPsize = {x = 1366, y = 768}; --// My resolution

function GetPPI(playerid)
	local a, b = GetPlayerResolution(playerid); 
	local pix = 37.79527559055; 
	local inc = 0.39; 
	local dia = math.sqrt(a*a + b*b); 
	local dia_to_sm = (dia/pix); 
	local sm_to_inc = (tonumber(dia_to_sm) * inc); 
	local ppi = dia/sm_to_inc;
	return tonumber(ppi)
end

local function rnd(x)
	if x > 0 then
		return x + 0.5
	else
		return x - 0.5
	end
end

function PlayerDrawAnx(pid, argument, x, y)
	local psizex, psizey = GetPlayerResolution(pid)
	local oneX = rnd((x * VIEW_MAX) / psizex);
	local twoY = rnd((y * VIEW_MAX) / psizey); 
	SetPlayerDrawPos(pid, argument, oneX, twoY);
end

function nax(pid, x)
	local psizex, psizey = GetPlayerResolution(pid)
    return rnd((x * psizex) / VIEW_MAX);
end

function nay(pid, y)
	local psizex, psizey = GetPlayerResolution(pid)
    return rnd((y * psizey) / VIEW_MAX);
end

function anx(pid, x)
	local psizex, psizey = GetPlayerResolution(pid)
	return rnd((x * VIEW_MAX) / psizex); 
end

function any(pid, y)
	local psizex, psizey = GetPlayerResolution(pid)
	return rnd((y * VIEW_MAX) / psizey); 
end

function my_nax(pid, x)
	local psizex, psizey = GetPlayerResolution(pid)
    return rnd((x * MyPsize.x) / VIEW_MAX);
end

function my_nay(pid, y)
    return rnd((y * MyPsize.y) / VIEW_MAX);
end

function my_anx(pid, x)
	local psizex, psizey = GetPlayerResolution(pid)
	return rnd((x * VIEW_MAX) / MyPsize.x); 
end

function my_any(pid, y)
	local psizex, psizey = GetPlayerResolution(pid)
	return rnd((y * VIEW_MAX) / MyPsize.y); 
end

function UpdatePixelTexture(pid, argument, pix1, piy1, pix2, piy2, texture)
	UpdateTexture(argument, anx(pid, pix1), any(pid, piy1), anx(pid, pix2), any(pid, piy2), texture)
end

function PlayerUpdatePixelDrawCenter(pid, argument, posX, posY)
	local resX, resY = GetPlayerResolution(pid); --// resX-resY - player resolution
	local x1 = (resX/2) + posX; --// sizeX-sizeY - texture size
	local y1 = (resY/2) + posY; --// backX-backY - set position texture for center
	SetDrawPos(argument, anx(pid, x1), any(pid, y1))
end

--// Resize texture for center
function UpdatePixelTextureCenter(pid, argument, sizeX, sizeY, backX, backY, texture)
	local resX, resY = GetPlayerResolution(pid); --// resX-resY - player resolution
	local x1 = (resX/2) - (sizeX/2) + backX; --// sizeX-sizeY - texture size
	local y1 = (resY/2) - (sizeY/2) + backY; --// backX-backY - set position texture for center
	UpdateTexture(argument, anx(pid, x1), any(pid, y1), anx(pid, x1 + sizeX), any(pid, y1 + sizeY), texture)
end

function UpdateTextureSize(argument, x1, y1, x2, y2, texture)
	UpdateTexture(argument, x1, y1, (x1 + x2), (y1 + y2), texture)
end