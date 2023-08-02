Player = {};
TEX_STAMINA = {};
ChatLines = {}; --DrawChat ChatLines
NameLines = {};
--DrawChat = {};
local sound_id = CreateSound("CURRENT.WAV")
local bot_id = -1
----КООРДИНАТЫ----
Player.OnTimer = false;
TEX_NUMBER_X = 7650;
TEX_NUMBER_Y = 7810;
TEX_NUMBER_BACK_X = 7620;
TEX_NUMBER_BACK_Y = 7835;
--===================================================================================--
--TEX_STAMINAln = CreateTexture(4229, 7900, 5307, 8060, "BAR_STAMINA.TEX");
--===================================================================================--

function PlayerParams()
for i = 0, GetMaxPlayers() do
	Player[i] = {};
	Player[i].Stamina = 100;
	Player[i].Bag = 0;
	Player[i].Overlay = nil;
	Player[i].timer_stamina = 0;--DrawChat ChatLines
	Player[i].OnAnim = 0;
end
end

function OnFilterscriptInit( )
	Enable_OnPlayerKey( 1 )
	--Enable_OnPlayerUpdate( 1 )
	PlayerParams();
	print("--================================--")-----------------------------===
	print("*  Go-Go System by Nochnoi_DocTor  *")--                             |
	print("*     ------------------------     *")--       Yoshagg pidor         |
	print("*          BAR_X = "..TEX_NUMBER_X.."            *")--               |
	print("*          BAR_Y = "..TEX_NUMBER_Y.."            *")--               |
	print("*                                  *")--                             |
	print("*          BACK_X = "..TEX_NUMBER_BACK_X.."           *")--          |
	print("*          BACK_Y = "..TEX_NUMBER_BACK_Y.."           *")--          |
	print("*     ------------------------     *")--                             |
	print("*              LOADED              *")--           IDDQD             |
	print("--================================--")-----------------------------===
	TEX_STAMINAln = CreateTexture(117, TEX_NUMBER_X, 1108, TEX_NUMBER_Y, "BAR_MISC.TGA"); --BAR_STAMINA BAR_MISC BAR_WATER
	TEX_BACK = CreateTexture(70, TEX_NUMBER_BACK_X, 1146, TEX_NUMBER_BACK_Y, "Bar_Back.tga");
end

function InitStats(playerid)
	Player[playerid].Stamina = 100;
	Player[playerid].timer_stamina = 0;
	Player[playerid].StaminaOn = 0;
	Player[playerid].Bag = 0;
	Player[playerid].OnAnim = 0;
	Player[playerid].Overlay = nil;
	Player[playerid].Point = 1108;
	Player[playerid].onchat = -170;
	Player[playerid].__n = 3030; --DrawChat ChatLines
	--[[DrawChat[playerid].Draw[1] = CreatePlayerDraw(playerid, 50, 30, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[2] = CreatePlayerDraw(playerid, 50, 230, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[3] = CreatePlayerDraw(playerid, 50, 430, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[4] = CreatePlayerDraw(playerid, 50, 630, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[5] = CreatePlayerDraw(playerid, 50, 830, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[6] = CreatePlayerDraw(playerid, 50, 1030, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[7] = CreatePlayerDraw(playerid, 50, 1230, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[8] = CreatePlayerDraw(playerid, 50, 1430, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[9] = CreatePlayerDraw(playerid, 50, 1630, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[10] = CreatePlayerDraw(playerid, 50, 1830, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[11] = CreatePlayerDraw(playerid, 50, 2030, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[12] = CreatePlayerDraw(playerid, 50, 2230, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[13] = CreatePlayerDraw(playerid, 50, 2430, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[14] = CreatePlayerDraw(playerid, 50, 2630, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
	DrawChat[playerid].Draw[15] = CreatePlayerDraw(playerid, 50, 2830, " ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)]]
end

function OnPlayerConnect(playerid)
ChatLines[playerid] = {}; --создание таблицы игрока
NameLines[playerid] = {};
Mchat = CreatePlayerDraw(playerid, 80, 3030, "-> ", "Font_Old_10_White_Hi.TGA", 255, 0, 255)
Mchat2 = CreatePlayerDraw(playerid, 300, 3030, "Hello, im doc!", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
InitStats(playerid)
gui_stamina = CreatePlayerDraw(playerid, 1240, 7550, Player[playerid].Point.."/100", "Font_Old_10_White_Hi.TGA",250, 210, 1,255); --102, 255, 0
if Player.OnTimer == false then
 --[[Player[playerid].timer_stamina = ]]
 for i = 0, GetMaxPlayers() do
 SetTimerEx("alm",120,1, i);
 end
 Player.OnTimer = true
 print("Timer ALM has been active!")
end
ShowTexture(playerid,TEX_BACK);
ShowTexture(playerid,TEX_STAMINAln);
ShowPlayerDraw(playerid,gui_stamina)
local res1,res2 = GetPlayerResolution(playerid)
--print("*****Player "..GetPlayerName(playerid).." imeet resolution: "..res1.."x"..res2.." *****")
LogString("LOG_P_RES", GetPlayerName(playerid).." imeet resolution: "..res1.."x"..res2)
--SetPlayerStreamable(playerid, 0, 0)
UpdatehTexture(playerid)
--SetTimerEx("alm",800,1, playerid);
end

function OnPlayerSpawn( playerid, classid )
--UpdateDraw(gui_stamina,150, 7500, "Выносливость: "..Player[playerid].Stamina.."%", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
--ShowDraw(playerid,gui_stamina);
end

--[[function OnPlayerHit(playerid, killerid)
--Player[playerid].Stamina = Player[playerid].Stamina - 20
	--if IsNPC(playerid) == 0 then
	local orug = GetPlayerWeaponMode(killerid)
		if Player[killerid].Stamina <= 100 then
		if orug == WEAPON_2H then
			Player[killerid].Stamina = Player[killerid].Stamina - 35
		elseif orug == WEAPON_1H then
			Player[killerid].Stamina = Player[killerid].Stamina - 20
		end
			UpdatehTexture(killerid)
			if Player[killerid].Stamina <= 0 then
				SetPlayerWeaponMode(killerid,WEAPON_NONE)
				GameTextForPlayer(killerid,1060, 6000, "Вы переутомились!", "Font_Old_10_White_Hi.TGA", 250, 210, 1, 2000)
			end
		end
		if killerid == 1 then
		Player[playerid].Stamina = Player[playerid].Stamina - 25
		end
	end]]


--[[function OnPlayerFocus(playerid, focusid)
local anim = GetPlayerAnimationID(playerid); --T_FALLDN_2_FALL
    if focusid >= 0 then
		if anim == 380 or anim == 381 or anim == 379 then
			Player[focusid].Stamina = Player[focusid].Stamina - 10
		end
	end
end]]

function KeyTimer(playerid)
SetPlayerEnable_OnPlayerKey(playerid,1)
end

function antycheat(playerid)
local anim = GetPlayerAnimationID(playerid); --T_FALLDN_2_FALL
if anim == 158 or anim == 691 then
PlayAnimation(playerid,"T_FALLDN_2_FALL");
SetPlayerEnable_OnPlayerKey(playerid,0)
SetTimerEx("KeyTimer",4000,0,playerid);
Player[playerid].Bag = Player[playerid].Bag + 1;
GameTextForPlayer(playerid,1260, 6000, "Кто-то багает спринт("..Player[playerid].Bag..")", "Font_Old_10_White_Hi.TGA", 102, 255, 0, 3000)
    if Player[playerid].Bag >= 3 then
	    SendPlayerMessage(playerid,102,255,0,"(СЕРВЕР): Багоюз спринтом.");
		Kick(playerid);
	end
end
end

function OnPlayerUpdate(playerid)
local anim = GetPlayerAnimationID(playerid);--T_FALLDN_2_FALL
local anim2 = GetPlayerAnimationName(playerid);
print(anim.." "..anim2)
end

function OnPlayerKey(playerid, keydown, keyup, keyname)
local over = GetPlayerWalk(playerid)
local anim = GetPlayerAnimationID(playerid); --T_FALLDN_2_FALL
if keydown == KEY_Z then
--[[if IsTimerActive(Player[playerid].timer_stamina) == 1 then
KillTimer(Player[playerid].timer_stamina);
end]]
Player[playerid].Overlay = over;
--antycheat(playerid)
if anim ~= 158 and anim ~= 212 and anim ~= 1092 and anim ~= 691 then
if Player[playerid].Point < 1109 and Player[playerid].Point > 116 then
	if Player[playerid].Point > 117 then
	if over ~= "HumanS_Sprint.mds" then
		if Player[playerid].Point > 1108 then
		   Player[playerid].Point = 1108
		end
		RemovePlayerOverlay(playerid,Player[playerid].Overlay);
		Player[playerid].StaminaOn = 1;
		SetPlayerWalk(playerid,"HumanS_Sprint.mds");
	else
	    if Player[playerid].Point >= 1109 then
		Player[playerid].Stamina = 1108
		end
	    UpdatehTexture(playerid)
	end
	end
end
end
elseif keyup == KEY_Z then
Player[playerid].StaminaOn = 0;
if over ~= Player[playerid].Overlay then
	RemovePlayerOverlay(playerid,"HumanS_Sprint.mds");
	SetPlayerWalk(playerid,Player[playerid].Overlay);
end
elseif keydown == KEY_S then
	if anim ~= 380 and anim ~= 381 and anim ~= 379 then
	Player[playerid].OtskokOn = 1
	end
	if Player[playerid].Point <= 300 then
			--local focus_name = GetPlayerName(focusid)
		PlayAnimation(playerid,"T_FALLB_2_FALLENB");
	end
elseif keyup == KEY_S then
	Player[playerid].OtskokOn = 0
elseif keydown == KEY_W or keydown == KEY_A or keydown == KEY_D or keydown == KEY_Q or keydown == KEY_E or keydown == KEY_LEFT or keydown == KEY_RIGHT or keydown == KEY_UP then
	if anim == 78 or anim == 68 or anim == 375 or anim == 317 or anim == 373 or anim == 319 then
		Player[playerid].OnAnim = 0	
	--[[elseif anim == 144 then
		PlayAnimation(playerid,"T_FALLENB_2_STAND"); --T_FALLENB_2_STAND T_FALLB_2_FALLENB]]
	end
--[[elseif keydown == KEY_T then
		if Player[playerid].OnToggle ~= 1 then
		ShowPlayerDraw(playerid,Mchat)
		ShowPlayerDraw(playerid,Mchat2)
        FreezePlayer(playerid, 1);
        PlayGesticulation(playerid);
		Player[playerid].OnToggle = 1;
		end

elseif keydown == KEY_ESCAPE then
		if Player[playerid].OnToggle == 1 then
		HidePlayerDraw(playerid,Mchat)
		HidePlayerDraw(playerid,Mchat2)
        FreezePlayer(playerid, 0);
		Player[playerid].OnToggle = 0;
		end

elseif keydown == KEY_RETURN then --ShowChat(playerid, 0)
        if Player[playerid].OnToggle == 1 then
		local text = "Hello, im doc!";
		HidePlayerDraw(playerid,Mchat)
		HidePlayerDraw(playerid,Mchat2)
		OnPlayerText(playerid, text);
        FreezePlayer(playerid, 0);
		Player[playerid].OnToggle = 0;
		end]]
	--[[
639 T_DIALOGGESTURE_08
646 T_DIALOGGESTURE_15
632 T_DIALOGGESTURE_01
641 T_DIALOGGESTURE_10
636 T_DIALOGGESTURE_05
650 T_DIALOGGESTURE_19
650 T_DIALOGGESTURE_19
634 T_DIALOGGESTURE_03
636 T_DIALOGGESTURE_05
637 T_DIALOGGESTURE_06
637 T_DIALOGGESTURE_06
633 T_DIALOGGESTURE_02
639 T_DIALOGGESTURE_08
633 T_DIALOGGESTURE_02
643 T_DIALOGGESTURE_12
647 T_DIALOGGESTURE_16
634 T_DIALOGGESTURE_03
		end]]
elseif keydown == KEY_F12 then
		ShowChat(playerid, 1)
	end
end

function alm(playerid)
	local anim = GetPlayerAnimationID(playerid);
	local orug = GetPlayerWeaponMode(playerid);
	local hel = GetPlayerHealth(playerid)
	--PlayAnimation(playerid,"S_2HATTACK");
	if Player[playerid].StaminaOn == 1 then
		SprintOn(playerid)
	elseif Player[playerid].StaminaOn == 0 then
		SprintOff(playerid)
	end
	if anim == 380 or anim == 381 or anim == 379 or anim == 323 or anim == 324 or anim == 325 then --shit
		if Player[playerid].Point <= 300 then
		PlayAnimation(playerid,"T_FALLB_2_FALLENB");
		else
		Player[playerid].Point = Player[playerid].Point - 50
		end
	end
	if anim == 826 or anim == 378 or anim == 322 then
		Player[playerid].Point = Player[playerid].Point - 50
		if Player[playerid].Point <= 300 then
			--local focus_name = GetPlayerName(focusid)
		--SetPlayerWeaponMode(playerid,WEAPON_NONE)
		PlayAnimation(playerid,"T_FALLB_2_FALLENB"); --T_FALLENB_2_STAND
		end
	end
	if anim == 283 then
		SetPlayerHealth(playerid, hel - 40)
	end
	OnAmin(playerid)
	if Player[playerid].Point <= 0 then
		if orug == WEAPON_2H or WEAPON_1H then
		SetPlayerWeaponMode(playerid,WEAPON_NONE)
		GameTextForPlayer(playerid,1060, 6000, "Вы переутомились!", "Font_Old_10_White_Hi.TGA", 250, 210, 1, 2000)
		end
	Player[playerid].Point = 0
	end
	--OnPlayerHourse(playerid)
end

function OnAmin(playerid)
local anim = GetPlayerAnimationID(playerid);
--===2H_WEAPON===--
if anim == 78 then
		if Player[playerid].OnAnim == 0 then
	    Player[playerid].Point = Player[playerid].Point - 100
		Player[playerid].OnAnim = 1
		end
	elseif anim == 375 or anim == 373 then --319 373
		if Player[playerid].OnAnim == 0 then
		Player[playerid].Point = Player[playerid].Point - 85
		Player[playerid].OnAnim = 1
		end
	--===1H_WEAPON===--
	elseif anim == 68 then
		if Player[playerid].OnAnim == 0 then
		Player[playerid].Point = Player[playerid].Point - 75
		Player[playerid].OnAnim = 1
		end
	elseif anim == 317 or anim == 319 then
		if Player[playerid].OnAnim == 0 then
		Player[playerid].Point = Player[playerid].Point - 50
		Player[playerid].OnAnim = 1
		end
	--===CLOSE_OnAnim===--
	elseif anim == 69 or anim == 79 then
		if Player[playerid].OnAnim == 1 then
		Player[playerid].OnAnim = 0
		end
	end
	return
end

local callback = function ()
    print("here")
end

function caller(callback)
    callback()
end

-- run caller function
caller(callback)

function OnPlayerHourse(playerid)
	local focusid = GetFocus(playerid)
	if Player[playerid].OnHurseLn == 1 then
		local x, y, z = GetPlayerPos(bot_id)
		local px, py, pz = GetPlayerPos(playerid)
		local angle = GetPlayerAngle(bot_id)
		local pangle = GetPlayerAngle(playerid)
		--PlayAnimation(playerid,"T_STAND_2_SIT");
		FreezePlayer(playerid, 1)
		SetPlayerPos(playerid, x, y+60, z)
		SetPlayerAngle(playerid, angle)
		Player[playerid].OnPivo = 1
		--print(x,y,z)
	end
end

--[[function OnPlayerFocus(playerid, focusid)
if IsNPC(focusid) == 0 then
    if focusid >= 0 then
		local focus_name = GetPlayerName(focusid)
		print(focus_name)
	end
	elseif focusid == -1 then
	local focus_name = GetPlayerName(focusid)
		if focus_name == "My Wolf" then
		Player[playerid].OnHurse = 0
		end
	end
end]]

function SprintOn(playerid)
	if Player[playerid].StaminaOn == 1 then
		--Player[playerid].Stamina = Player[playerid].Stamina - 3;
		Player[playerid].Point = Player[playerid].Point - 15
		UpdatePlayerDraw(playerid,gui_stamina, 1240, 7550, Player[playerid].Point.."/100", "Font_Old_10_White_Hi.TGA", 250, 210, 1,255);
		--UpdateDraw(gui_stamina,150, 7500, "Выносливость: "..Player[playerid].Stamina.."%", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
		UpdatehTexture(playerid)
		if Player[playerid].Point <= 0 then
			RemovePlayerOverlay(playerid,"HumanS_Sprint.mds");
			SetPlayerWalk(playerid,Player[playerid].Overlay);
			Player[playerid].StaminaOn = 0;
		end
	end
end

function SprintOff(playerid)
	if Player[playerid].StaminaOn == 0 then
		if Player[playerid].Point <= 992 then
			Player[playerid].Point = Player[playerid].Point + 15;
			UpdatePlayerDraw(playerid,gui_stamina, 1240, 7550, Player[playerid].Point.."/100", "Font_Old_10_White_Hi.TGA", 250, 210, 1,255);
		end
		if Player[playerid].Point >= 994 then
			Player[playerid].Point = 994
			UpdatePlayerDraw(playerid,gui_stamina, 1240, 7550, Player[playerid].Point.."/100", "Font_Old_10_White_Hi.TGA", 250, 210, 1,255);
				if Player[playerid].Point <= 0 then
					Player[playerid].Point = 0
				end
--GameTextForPlayer(playerid,1260, 6000, "Кто-то багает спринт...", "Font_Old_10_White_Hi.TGA", 102, 255, 0, 3000)
		end
--UpdateDraw(gui_stamina,150, 7500, "Выносливость: "..Player[playerid].Stamina.."%", "Font_Old_10_White_Hi.TGA", 255, 255, 255)
UpdatehTexture(playerid)
	end
end

function OnPlayerDisconnect(playerid,reason)
	InitStats(playerid)
end

local chacha = 0;

function OnPlayerCommandText(playerid, cmdtext)
local _n = #ChatLines[playerid]
local Playa = playerid
local anim = GetPlayerAnimationID(playerid);
    if cmdtext == "/музон" then
        if sound_id >= 0 then
			PlayPlayerSound(playerid, sound_id)
            GameTextForPlayer(playerid,1860, 4000, "Музон врублен. Lets rock!!!", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 3000)
        else
            SendPlayerMessage(playerid, 255, 0, 0, "Can't create sound.")
        end
	elseif cmdtext == "/стоп_музон" then
        StopPlayerSound(playerid, sound_id)
		GameTextForPlayer(playerid,1860, 4000, "Музон все, того...", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 3000)
	elseif cmdtext == "/ебошь" then
		PlayAnimation(playerid,"S_SUCKENERGY_VICTIM");
	elseif cmdtext == "/дел" then
		for i = 0, #NameLines[playerid] - 1 do
		HidePlayerDraw(playerid, NameLines[playerid][i+1])
		DestroyPlayerDraw(playerid, NameLines[playerid][i+1])
		end
		for i = 0, #ChatLines[playerid] - 1 do
		HidePlayerDraw(playerid, ChatLines[playerid][i+1])
		DestroyPlayerDraw(playerid, ChatLines[playerid][i+1])
		end
		Player[playerid].onchat = -170
	elseif cmdtext == "/злой" then
		PlayAnimation(playerid,"S_ANGRY"); --ShowPlayerDraw(playerid, ChatLines[(_n+1)])
	end
end

function UpdatehTexture(playerid)
UpdateTexture(TEX_STAMINAln, 115, 7650, Player[playerid].Point, 160, "BAR_MISC.TGA")
end

--[[local state = 5750
local statel = 2257
local mare = 1028
local mare2 = 1028
local mareln = 1229
local cProc
local an


function FoodEdenic(playerid, d)
--1
local aProc = d/100
local bProc = 1 - aProc
cProc = mare2 * bProc
print(cProc)

end

function alm(playerid)
local stateone = 2257
--local statel = 5750
local stateln = 2257
DestroyTexture(playerid, TEX_STAMINA)
local ln = 5
mare = mare - ln
stateln = stateln - mare
local main = stateln - mareln
stateone = statel - main
if stateone <= 1229 then
mare = 1028
end
print(stateone)
TEX_STAMINA = CreateTexture(1229, 7900, stateone, 8060, "BAR_MISC.TGA");
--ShowTexture(playerid, FocusNPC_Texture)
--DestroyTexture(playerid, FocusNPC_Texture)
TEX_STAMINA = CreateTexture(1229, 7900, stateone, 8060, "BAR_MISC.TGA");
--ShowTexture(playerid, FocusNPC_Texture)
--DestroyTexture(playerid, FocusNPC_Texture)



function alm(playerid)
local stateone = 2257
--local statel = 5750
local stateln = 2257
DestroyTexture(playerid, TEX_STAMINA)
local ln = 5

local stateln = 2257
local stateln = 2223
DestroyTexture(playerid, TEX_STAMINA)
local ln = 5
end]]

--[[function OnPlayerCommandText(playerid, cmdtext)
local cmd, params = GetCommand(cmdtext); 
    if cmdtext == "/iddqd" then
		GiveItem(playerid,"ItPo_Health_Addon_04", 50)
		SetPlayerMaxHealth(playerid,475)
		SetPlayerStrength (playerid, 65)
		SetPlayerSkillWeapon(playerid, SKILL_2H, 59)
	elseif cmdtext == "/idclev" then
        --CompleteHeal(playerid)
        os.remove("lp_logs.txt") --os.remove (filename)
		os.remove("lp_logs.txt")
	    os.remove("lp_logs.txt")
		os.remove("lp_logs.txt")
	    
    end
end]]