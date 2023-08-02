
--  #  Zone system by royclapton  #
--  #         version: 0.5        #


local itqqqqq = CreateTexture(5660, 7694, 8130, 8114, 'menu_ingame')

function CheckZones()

	for i = 0, GetMaxSlots() do
        if IsPlayerConnected(i) == 1 then
            local x, y, z = GetPlayerPos(i);

            -- баня
			local pos1 = GetDistance3D(x, y, z, 4880.294921875, 354.95486450195, -3280.2866210938);
			
			-- арены
			local pos2 = GetDistance3D(x, y, z, 6277.1728515625, 848.20452880859, 9390.30078125); -- казарма
			local pos3 = GetDistance3D(x, y, z, -3058.9470214844, -42.363803863525, -4386.4296875); -- порт склад
			local pos4_1 = GetDistance3D(x, y, z, 13768.81640625, 404.38897705078, -3574.6303710938); -- маги огня
			local pos4_2 = GetDistance3D(x, y, z, 14414.493164063, -1376.8328857422, -613.60382080078); -- маги воды
			local pos4_3 = GetDistance3D(x, y, z, 75629.71875, 3612.2917480469, -11347.44140625); -- старт поз
			local pos4_4 = GetDistance3D(x, y, z, -31461.580078125, -1176.1448974609, 24262.2890625); -- яркендар

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

			-- корабль
			local pos_ship = GetDistance3D(x, y, z, -2982.6467285156, -715.85217285156, 1370.7963867188);
			---------------------------------------------------------
            if pos1 < 800 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "баня");
							Player[i].zone[2] = true;
						end
					end
				end]]
			----------------------------- ----------------------------- 
			elseif pos2 < 500 or pos3 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "арена");
							Player[i].zone[2] = true;
						end
					end
				end
				
			elseif pos4_1 < 300 or pos4_2 < 500 or pos4_3 < 1000 or pos4_4 < 500 then
				if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "арена");
							Player[i].zone[2] = true;
						end
					end
				end
			----------------------------- ----------------------------- 
			elseif pos5 < 650 or pos6 < 650 or pos7 < 650 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "пшеница");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos8 < 600 or pos9 < 600 or pos91 < 600 then 
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "лесныетравы");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos10 < 600 or pos11 < 600 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "лечебныетравы");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos12 < 600 or pos13 < 600 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "манатрава");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos14 < 700 or pos15 < 700 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "болотник");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos16 < 700 or pos17 < 700 then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "грибы");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos18 < 1500  then
				--[[if Player[i].loggedIn == true then
					Player[i].zone[1] = true; 
					
					if Player[i].zone[1] == true then
						if Player[i].zone[2] == false then
							ShowPlayerDraw(i, zoneinfo);
							ShowTexture(i, itqqqqq);
							ShowZones(i, "ягоды");
							Player[i].zone[2] = true;
						end
					end
				end]]

			elseif pos_ship < 1000  then
				if SHIP_STATE == "city" then
					if Player[i].loggedIn == true then
						Player[i].zone[1] = true; 
						
						if Player[i].zone[1] == true then
							if Player[i].zone[2] == false then
								ShowPlayerDraw(i, zoneinfo);
								ShowTexture(i, itqqqqq);
								ShowZones(i, "корабль");
								Player[i].zone[2] = true;
							end
						end
					end
				end

			-- ############################################################
			-- ЭТО НЕ ТРОГАТЬ.
            else
				if Player[i].loggedIn == true then
					Player[i].zone[1] = false; 
					if Player[i].zone[1] == false then
						if Player[i].zone[2] == true then
							HidePlayerDraw(i, zoneinfo);
							HideTexture(i, itqqqqq);
							Player[i].zone[2] = false;
						end
					end
				end
            end
			---------------------------------------------------------
			
        end
    end

end
SetTimer("CheckZones", 1000, 1);


function ShowZones(id, dId)

    if dId == "баня" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Баня города Хоринис", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
	elseif dId == "грибы" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи грибов (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "болотник" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи болотника (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "ягоды" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи лес. ягод (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "лечебныетравы" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи леч. трав (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "пшеница" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи пшеницы (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "лесныетравы" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи лес. трав (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "манатрава" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка добычи МП-трав (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "арена" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Точка тренировки (Р)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    elseif dId == "корабль" then
        UpdatePlayerDraw(id, zoneinfo, 5914, 7798, "Торговое судно (/корабль)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
    end

end