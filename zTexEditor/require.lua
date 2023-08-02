
require "zTexEditor/ResolutionFunctions"
require "zTexEditor/ztex"
require "zTexEditor/zdraw"

function zTexKey(playerid, keyDown, keyUp)
	TextureEdKey(playerid, keyDown, keyUp);
	zDrawKey(playerid, keyDown, keyUp);
end

print("-== zTex Editor v0.2 has benn loaded ==-")