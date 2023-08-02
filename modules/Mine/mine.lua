
function _mGetOnline()
	local on = 0;
	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
			on = on + 1;
		end
	end
	ONLINE = on;
end

function MINE_OnPlayerKey(playerid, keyDown, keyUp)

	if Player[playerid].loggedIn == true then
		if keyDown == KEY_P then
			Mine_ID5(playerid)
		end
	end

end

function freezeCameraTimer(id)
	FreezeCamera(id, 1);
end

function MINE_OnPlayerHasItem(playerid, itemInstance, amount, equipped, checkid)

	_mGetOnline();
	if ONLINE > 0 then

		if checkid == 1 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 5;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 2 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 3;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать болотник. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 3 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 7;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать пшеницу. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);

						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 100, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		
		if checkid == 4 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 9;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать грибы. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		
		if checkid == 5 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 5;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 6 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 8;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 7 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 10;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end

		if checkid == 8 then
			if itemInstance ~= "NULL" then
				if Player[playerid].energy >= 5 then
					if Player[playerid].mine == 0 then
						Player[playerid].mine = 11;
						Player[playerid].energy = Player[playerid].energy - 5;
						GameTextForPlayer(playerid, 50, 6000, "Вы начали собирать траву. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						PlayAnimation(playerid,"T_PLUNDER");
						FreezePlayer(playerid, 1);
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);

						SavePlayer(playerid);
						_saveEnergy(playerid);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
				end
			else
				GameTextForPlayer(playerid, 50, 6000, "Нет предмета","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
		UpdateEnergyBar(playerid);
	else
		SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
	end

end


--[[

checkid 4 = грибы
checkid 7 = мана
checkid 8 = лечебные
checkid 3 = пшеница
checkid 2 = болотник
checkid 1 = ягоды


]]

function Mine_ID5(playerid)

	local x, y, z = GetPlayerPos(playerid);
	
	-- пшеница (ид 3)
	local pos5 = GetDistance3D(x, y, z, 12411.056640625, 1036.8210449219, -8169.6962890625);
	local pos6 = GetDistance3D(x, y, z, 10802.431640625, 1071.0112304688, -8929.119140625);
	local pos7 = GetDistance3D(x, y, z, 9398.708984375, 954.74328613281, -10441.27734375);
	
	-- леc. травы
	local pos8 = GetDistance3D(x, y, z, 1397.3416748047, 712.31536865234, 6901.501953125);
	local pos9 = GetDistance3D(x, y, z, 1585.0631103516, -1.5572227239609, -8410.029296875);
	local pos91 = GetDistance3D(x, y, z, 11916.537109375, -309.49884033203, -19372.046875);

	-- леч. травы (ид 4)
	local pos10 = GetDistance3D(x, y, z, 1233.1004638672, 398.20608520508, 4649.1791992188);
	local pos11 = GetDistance3D(x, y, z, 14088.397460938, 1123.8833007813, 735.35968017578);
	
	-- трава маны
	local pos12 = GetDistance3D(x, y, z, 15738.364257812, 996.54736328125, -4569.798828125);
	local pos13 = GetDistance3D(x, y, z, 16483.349609375, 2670.4924316406, -9148.9091796875);
	
	-- болотник (ид 2)
	local pos14 = GetDistance3D(x, y, z, 4087.1943359375, -520.47357177734, -5777.4521484375);
	local pos15 = GetDistance3D(x, y, z, 2277.9079589844, 216.6360168457, -20264.458984375);
	
	-- грибы
	local pos16 = GetDistance3D(x, y, z, -2030.7687988281, 676.71887207031, -10850.7109375); 
	local pos17 = GetDistance3D(x, y, z, 20605.58203125, 915.34100341797, 5555.2001953125);
	
	-- лесные ягоды
	local pos18 = GetDistance3D(x, y, z, 3572.6586914062, 22.166223526001, -12633.997070312);

	_mGetOnline();
	if ONLINE > 0 then
	
		--------------------------------------------------------- пшеница
		if pos5 < 650 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 3);

		elseif pos6 < 650 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 3);

		elseif pos7 < 650 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 3);
		--------------------------------------------------------- леcные травы
		elseif pos8 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 6);
			
		elseif pos9 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 6);
		
		elseif pos91 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 6);
			
		--------------------------------------------------------- лечебные травы
			
		elseif pos10 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 8);
			
		elseif pos11 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 8);

		--------------------------------------------------------- мана
		elseif pos12 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 7);

		elseif pos13 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 7);
		--------------------------------------------------------- болотник
		elseif pos14 < 700 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 2);
		
		elseif pos15 < 700 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 2);
		--------------------------------------------------------- грибы
		elseif pos16 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 4);
		
		elseif pos17 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 4);
		--------------------------------------------------------- ягодки
		elseif pos18 < 600 then
			HasItem(playerid, "JKZTZD_ITMW_1H_BAU_AXE", 1);
		---------------------------------------------------------
		end

		UpdateEnergyBar(playerid);
	end

end

function freezePlayerTimer(id);
	Freeze(id);
end

function MINE_OnPlayerUseItem(playerid, itemInstance, amount, hand)

	_mGetOnline();
	if ONLINE > 0 then

		if itemInstance == "OOLTYB_ITMI_SAW" then -- pila 
			_mGetOnline();
			if ONLINE > 0 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали распиливать полено. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 1;
						Player[playerid].energy = Player[playerid].energy - 5;
						
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						SetDefaultCamera(playerid);
						_newSetCameraBeforePlayer(playerid, 1)
						SetTimerEx("freezeCameraTimer", 400, 0, playerid);
						SetTimerEx("freezePlayerTimer", 800, 0, playerid);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);
						
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end
		end

		if itemInstance == "JKZTZD_ITMW_2H_AXE_L_01" then -- kirka
			_mGetOnline();
			if ONLINE > 0 then
				if Player[playerid].mine == 0 then
					if Player[playerid].energy >= 5 then
						GameTextForPlayer(playerid, 50, 6000, "Вы начали добывать руду. Ожидайте несколько секунд.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
						Player[playerid].mine = 2;
						Player[playerid].energy = Player[playerid].energy - 5;
					
						ShowTexture(playerid, Player[playerid].prog_background_f);
						ShowTexture(playerid, Player[playerid].prog_f);
						Player[playerid].prog_timer = SetTimerEx("_wd", 130, 1, playerid);
						SavePlayer(playerid);
						_saveEnergy(playerid);

						FreezePlayer(playerid, 1);
					else
						GameTextForPlayer(playerid, 50, 6000, "Недостаточно энергии","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					end
				else
					GameTextForPlayer(playerid, 50, 6000, "Вы еще не закончили прошлую работу","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
					SaveItems(playerid);
				end
			else
				SendPlayerMessage(playerid, 255, 255, 255, "Нельзя добывать при онлайне ниже 5.")
			end
		end
		
		UpdateEnergyBar(playerid);
	end

end

function _wd(playerid)


	if Player[playerid].current_size_f > Player[playerid].zero_size_f then
		Player[playerid].current_size_f = Player[playerid].current_size_f - 20;
		UpdateTexture(Player[playerid].prog_f, 3007, 7283, Player[playerid].current_size_f, 7469, 'PROGRESS_BLUE_BAR');
	else
		KillTimer(Player[playerid].prog_timer);
		UpdateTexture(Player[playerid].prog_f, 3007, 7283, Player[playerid].start_size_f, 7469, 'PROGRESS_BLUE_BAR');
		Player[playerid].current_size_f = Player[playerid].start_size_f;
		Player[playerid].prog_timer = nil;
		HideTexture(playerid, Player[playerid].prog_f)
		HideTexture(playerid, Player[playerid].prog_background_f);
		FreezeCamera(playerid, 0);
		SetDefaultCamera(playerid);
		UnFreeze(playerid);

		if Player[playerid].mine == 1 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);

			local rnd = math.random (1, 100);
			if rnd <= 45 then
		    GameTextForPlayer(playerid, 50, 6000, "Вы распилили бревно на три части","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ITMI_WOOD", 3);
			elseif rnd > 45 and rnd <= 65 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы распилили бревно на четыре части","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ITMI_WOOD", 4);
		   	elseif rnd > 65 and rnd <= 75 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли тяжелый сук","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "JKZTZD_ItMw_1h_Bau_Mace", 1);
		   	elseif rnd > 75 and rnd <= 85 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли желудь","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 1);
		   	elseif rnd > 85 and rnd <= 95 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли соту","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ITMI_HONEYCOMB", 1);
		   	elseif rnd > 95 and rnd <= 100 then
	        GameTextForPlayer(playerid, 50, 6000, "Вы нашли смолу","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Pitch", 1);
		   	end
		   	SaveItems(playerid);

		elseif Player[playerid].mine == 2 then

			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
			local rnd = math.random (1, 100);
			if rnd <= 30 then
				GameTextForPlayer(playerid, 50, 6000, "Вы откололи немного железа","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Iron", 3);
				SaveItems(playerid);
				
			elseif rnd > 30 and rnd <= 50 then
				GameTextForPlayer(playerid, 50, 6000, "Вы откололи немного железа","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Iron", 5);
				SaveItems(playerid);
				
			elseif rnd > 50 and rnd <= 56 then
				GameTextForPlayer(playerid, 50, 6000, "Вы откололи рудную крошку","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ITMI_MAGICORE", 1);
				SaveItems(playerid);
				
			elseif rnd > 56 and rnd <= 58 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли кварц!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Quartz", 1);
				SaveItems(playerid);

			elseif rnd > 58 and rnd <= 60 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли аквамарин!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Aquamarine", 1)
				SaveItems(playerid);

			elseif rnd > 60 and rnd <= 62 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли рубин!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ITMI_RUBIN", 1);
				SaveItems(playerid);

			elseif rnd > 62 and rnd <= 68 then
				GameTextForPlayer(playerid, 50, 6000, "Вы откололи серу","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Sulfur", 1);
				SaveItems(playerid);

			elseif rnd > 68 and rnd <= 78 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли один золотой самородок!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_GoldNugget_Addon", 1);
				SaveItems(playerid);

			elseif rnd > 78 and rnd <= 83 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли два золотых самородка!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_GoldNugget_Addon", 2);
				SaveItems(playerid);
				
			elseif rnd > 83 and rnd <= 98 then
				GameTextForPlayer(playerid, 50, 6000, "Вы нашли серебряный самородок!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_SilverNugget", 1);
				SaveItems(playerid);
				
			elseif rnd > 98 and rnd <= 100 then
				GameTextForPlayer(playerid, 50, 6000, "Вы откололи горный хрусталь","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		   		GiveItem(playerid, "OOLTYB_ItMi_Rockcrystal", 1);
				SaveItems(playerid);
			end
		   	SaveItems(playerid);
			

		elseif Player[playerid].mine == 5 then
			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лесной ягоды.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Forestberry", 1);
		    elseif rnd > 40 and rnd <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали два стебля лесной ягоды.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Forestberry", 2);
		    elseif rnd > 60 and rnd <= 70 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли гроздь дикого винограда","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_WINEBERRYS2", 5);
		    elseif rnd > 70 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель Солнечника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_01", 1);
		    elseif rnd > 80 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель Лунника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_NIGHTSHADOW_02", 1);
			 elseif rnd > 90 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли ягоду гоблина!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Dex_Herb_01", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли вишню тролля!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_Plants_Trollberrys_01", 1);
		    end
			SaveItems(playerid);

		elseif Player[playerid].mine == 3 then

		   Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd1 = math.random(1, 100);
			if rnd1 <= 30 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель болотника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITPL_SWAMPHERB", 1);
		    elseif rnd1 > 30 and rnd1 <= 50 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля болотника.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITPL_SWAMPHERB", 2);
		    elseif rnd1 > 50 and rnd1 <= 65 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли Речной мирт.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_REMI", 1);
		    elseif rnd1 > 65 and rnd1 <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли Иловый мирт.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_REMI1", 1);
		    elseif rnd1 > 80 and rnd1 <= 88 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли моллюска","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_REMI2", 1);
			elseif rnd1 > 88 and rnd1 <= 98 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы намыли золотой самородок","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_GOLDNUGGET_ADDON", 1);
			elseif rnd1 > 98 and rnd1 <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли жемчужину","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_ADDON_WHITEPEARL", 1);
		    end
			SaveItems(playerid)
			
		elseif Player[playerid].mine == 8 then

		   Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 1);
		    elseif rnd > 40 and rnd <= 60 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 2);
		    elseif rnd > 60 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли серафис.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 1);
		    elseif rnd > 80 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли желудь.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_TOWERWOOD_01", 1);
		    elseif rnd > 90 and rnd <= 98 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли драконий корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Strength_Herb_01", 1);
			elseif rnd > 98 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли коронное растение","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Perm_Herb", 1);
		    end
			SaveItems(playerid)
		
		elseif Player[playerid].mine == 9 then

		   	Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 30 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли черный гриб.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mushroom_01", 1);
		    elseif rnd > 30 and rnd <= 50 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли два черных гриба.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mushroom_01", 2);
		    elseif rnd > 50 and rnd <= 70 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли мясной гриб.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mushroom_02", 1);
		    elseif rnd > 70 and rnd <= 80 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли горный мох.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_MOUNTAINMOSS_01", 1);
		    elseif rnd > 80 and rnd <= 85 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли каменный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_STONEROOT_01", 1);
			elseif rnd > 85 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли астральный гриб!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mushroom_04", 1);
			elseif rnd > 90 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы нашли золотой самородок!","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_GOLDNUGGET_ADDON", 1);
		    end
			SaveItems(playerid)

		elseif Player[playerid].mine == 10 then

			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 1);
		    elseif rnd > 40 and rnd <= 55 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 2);
		    elseif rnd > 55 and rnd <= 65 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля серафиса","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 2);
		    elseif rnd > 65 and rnd <= 85 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель огненной крапивы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mana_Herb_01", 1);
		    elseif rnd > 85 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель огненной травы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mana_Herb_02", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали огненный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Mana_Herb_03", 1);
		    end
			SaveItems(playerid);

		elseif Player[playerid].mine == 11 then
			Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			
		    local rnd = math.random(1, 100);
			if rnd <= 40 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли один стебель полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 1);
		    elseif rnd > 40 and rnd <= 55 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля полевого растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Temp_Herb", 2);
		    elseif rnd > 55 and rnd <= 65 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы отсекли два стебля серафиса","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITFO_PLANTS_SERAPHIS_01", 2);
		    elseif rnd > 65 and rnd <= 85 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лечебного растения.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Health_Herb_01", 1);
		    elseif rnd > 85 and rnd <= 95 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали стебель лечебной травы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Health_Herb_02", 1);
			 elseif rnd > 95 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы срезали лечебный корень","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ItPl_Health_Herb_03", 1);
		    end
			SaveItems(playerid);



		elseif Player[playerid].mine == 7 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			local rnd = math.random(1, 100);
			if rnd <= 50 then
			GameTextForPlayer(playerid, 50, 6000, "Вы набрали две охапки пшеницы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
			GiveItem(playerid, "OOLTYB_ITMI_WHEAT", 2);
			elseif rnd > 50 and rnd <= 75 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы набрали три охапки пшеницы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_WHEAT", 3);
		    elseif rnd > 75 and rnd <= 90 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы набрали четыре охапки пшеницы.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "OOLTYB_ITMI_WHEAT", 4);
		    elseif rnd > 90 and rnd <= 100 then
		    	GameTextForPlayer(playerid, 50, 6000, "Вы наткнулись на сорняк","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);
		    	GiveItem(playerid, "ZDPWLA_ITPL_WEED", 1);	
		    end
		    SaveItems(playerid);

		    

		elseif Player[playerid].mine == 4 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			GiveItem(playerid, "JKZTZD_ITMW_1H_BAU_MACE", 1);
			SaveItems(playerid);
		    GameTextForPlayer(playerid, 50, 6000, "Вы нашли палку.","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);

		elseif Player[playerid].mine == 6 then

		    Player[playerid].mine = 0;
			FreezePlayer(playerid, 0);
			GiveItem(playerid, "ZDPWLA_ITFO_HONEY", 1);
			SaveItems(playerid);
		    GameTextForPlayer(playerid, 50, 6000, "Вы набрали мед","Font_Old_10_White_Hi.TGA", 218,165,32, 3000);

		end
	end
end