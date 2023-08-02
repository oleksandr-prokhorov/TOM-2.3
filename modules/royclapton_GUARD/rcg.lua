
royclapton_GUARD = nil;

function _royclaptonGuard() -- gamemodeinit

	royclapton_GUARD = CreateNPC("×åëîâåê ğîñòîâùèêà")
	SpawnPlayer(royclapton_GUARD);
	SetPlayerWorld(royclapton_GUARD, "FULLWORLD2.ZEN");
	SetPlayerPos(royclapton_GUARD, 430.13873291016, -84.143890380859, -1950.6860351562);
	SetPlayerAngle(royclapton_GUARD, 266);
	SetPlayerMaxHealth(royclapton_GUARD, 99999999999999);
	SetPlayerHealth(royclapton_GUARD, 99999999999999);
	SetPlayerAdditionalVisual(royclapton_GUARD, "Hum_Body_Naked0", 19, "HUM_HEAD_BEARD3", 388);
	PlayAnimation(royclapton_GUARD, "S_HGUARD");
	SetPlayerVirtualWorld(royclapton_GUARD, 0);
	EquipArmor(royclapton_GUARD, "itar_fknifes_2");
	EquipMeleeWeapon(royclapton_GUARD, "jkztzd_itmw_2h_sld_axe")

end

createGUIMenu("royclaptonGUARD_MENU", {
	{ "1. Êòî òû?" },
	{ "2. ×åì çàíèìàåòñÿ ğîñòîâùèê?" },
	{ "3. Ìîãó ëè ÿ âçÿòü ó íåãî â äîëã?" },
	{ "4. ×òî áóäåò åñëè íå âåğíóòü äîëã?" },
	{ "5. (ÓÉÒÈ)" },
    }, 150, 150, 150, 255, 255, 255, 5430, 3500, "Font_Old_10_White_Hi.TGA", CreateTexture(5350, 3397, 7709, 4572, 'menu_ingame'), 5);



function _showrcGuardMenu(id)
	showGUIMenu(id, "royclaptonGUARD_MENU");
	Freeze(id);
end

--[[

if focusid == royclapton_GUARD then
	UpdatePlayerDraw(id, Player[id].medraw, 1300, 7800, "Íàæìèòå L.CTRL ÷òîáû ïîãîâîğèòü ñ ÷åëîâåêîì ğîñòîâùèêà.", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
end

]]

function _rcgKey(id, down, up) -- onplayerkey

	--[[if Player[id].loggedIn == true then	

		if down == KEY_LCONTROL then
			if GetFocus(id) == royclapton_GUARD then
				SetTimerEx(_showrcGuardMenu, 300, 0, id);
			end
		end
		

		if down == KEY_RETURN then
			
			if Player[id].loggedIn == true then

				local h, m = GetTime();

				if getPlayerOptionID(id, "royclaptonGUARD_MENU") == 1 then

					PlayGesticulation(royclapton_GUARD);
					if h > 6 and h < 21 then
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: ß îõğàíÿş äîì ñâîåãî øåôà - ğîñòîâùèêà Ëåçàëèòà.")
					else
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: Âğåìÿ óæå ïîçäíåå, ñòóïàé-êà òû äîìîé.");
					end

				elseif getPlayerOptionID(id, "royclaptonGUARD_MENU") == 2 then

					PlayGesticulation(royclapton_GUARD);
					if h > 6 and h < 21 then

						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà òÿæåëî âçäîõíóë è ñêàçàë: Îí äàåò ëşäÿì äåíåã â äîëã.")
					else
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: Íå ìîãó íè÷åì ïîìî÷ü, ïğèõîäè äíåì.");
					end

				elseif getPlayerOptionID(id, "royclaptonGUARD_MENU") == 3 then

					PlayGesticulation(royclapton_GUARD);
					if h > 6 and h < 21 then
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: Îí äàåò â äîëã ïğàêòè÷åñêè âñåì æåëàşùèì, ïîıòîìó äåğçàé.")
					else
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: Ïîãîâîğèì ïîçæå.");
					end

				elseif getPlayerOptionID(id, "royclaptonGUARD_MENU") == 4 then

					PlayGesticulation(royclapton_GUARD);
					if h > 6 and h < 21 then
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ñêàçàë: Íó-ó, äàæå íå çíàş. Ëó÷øå íå äîâîäèòü äî ıòîãî.")
					else
						SendPlayerMessage(id, 255, 241, 153, "×åëîâåê ğîñòîâùèêà ïğîòÿæåííî çåâíóë è íè÷åãî íå îòâåòèë.");
					end

				elseif getPlayerOptionID(id, "royclaptonGUARD_MENU") == 5 then
					UnFreeze(id);
					hideGUIMenu(id, "royclaptonGUARD_MENU");
				end

			end
		end
		
		if down == KEY_UP then
			switchGUIMenuUp(id, "royclaptonGUARD_MENU");
		end

		if down == KEY_DOWN then
			switchGUIMenuDown(id, "royclaptonGUARD_MENU");
		end

	end]]
end
