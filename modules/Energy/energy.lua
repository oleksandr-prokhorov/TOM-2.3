
--  #  Energy system by royclapton  #
--  #           version: 1.0        #

preENERGY_BLOCK = {};



function _debuffConnect(id)

	Player[id]._debuffTimer = nil;
	Player[id]._debuffDefense = false;

end

function _debuffTimer()
	
	for i = 0, GetMaxPlayers() do
		if Player[i]._debuffDefense == false and Player[i].loggedIn == true and IsPlayerConnected(i) == 1 then
		
			if Player[i].energy > 0 then
				
				Player[i].energy = Player[i].energy - 5;

				if Player[i].energy < 0 then
					Player[i].energy = 0;
				end
				
                        if Player[i].hud_draw[3] ~= nil then
				      SetPlayerDrawText(i, Player[i].hud_draw[3], Player[i].energy);
                        end
				
				_debuffReset(i);
				
				_saveEnergy(i);
				SavePlayer(i);
				_updateHud(i);
				
			end
		end
	end

end
SetTimer(_debuffTimer, 390000, 1); -- 390000

function _debuffReset(id)

	if Player[id].loggedIn == true and IsPlayerConnected(id) == 1 then
	
		if Player[id].energy >= 50 and Player[id].energy <= 75 then
		
				
			if GetPlayerHealth(id) > 100 then
				SetPlayerHealth(id, GetPlayerHealth(id) - 5);
			end
			
			_updateHealth(id);
			SaveStats(id);

		elseif Player[id].energy >= 25 and Player[id].energy < 50 then
			
			if GetPlayerHealth(id) > 100 then
				SetPlayerHealth(id, GetPlayerHealth(id) - 10);
			end
			
			_updateHealth(id);
			SaveStats(id);

		elseif Player[id].energy < 25 then
			
			if GetPlayerHealth(id) > 100 then
				SetPlayerHealth(id, GetPlayerHealth(id) - 15);
			end
			
			_updateHealth(id);
			SaveStats(id);
			
		end
		
		_updateHud(id);
		
	end

end


function _debuffTimerDown(id)
	if Player[id].loggedIn == true then
		Player[id]._debuffDefense = false;
	end
end

function EnergyBar(id)

	if Player[id].eBar == false then
		Player[id].eBar = true;
		ShowTexture(id, Player[id].energybar[1])
		UpdateEnergyBar(id);
	else
		Player[id].eBar = false;
		HideTexture(id, Player[id].energybar[1])
	end

end

function UpdateEnergyBar(id)

	local a = 100 - Player[id].energy;
	local b = a * 11.2;

	--Player[id].energybar_x = 1100 - b;
	--UpdateTexture(Player[id].energybar[1], 74, 7592, Player[id].energybar_x, 7809, 'BAR1');
	_updateHud(id);

end

function _initEnergy()

	--[[local file = io.open("Blocks/preENERGY.txt", "r");
		for line in file:lines() do
			local result, nickname = sscanf(line, "s");
			if result == 1 then
				table.insert(preENERGY_BLOCK, nickname);
			end
		end
	file:close();]]

end

function _addToPreEnergy(id)

	--[[local status = false;
	for i, v in pairs(preENERGY_BLOCK) do
		if Player[id].nickname == v then
			status = true;
		end
	end

	if status == false then
		table.insert(preENERGY_BLOCK, GetMacAddress(id));
		local file = io.open("Blocks/preENERGY.txt", "w+");
		for i = 1, table.getn(preENERGY_BLOCK) do
			file:write(preENERGY_BLOCK[i].."\n");
		end
		file:close();
	end]]

end

function _checkPreEnergy(id)

	--[[local file = io.open("Blocks/preENERGY.txt", "r");
	if file then
		for line in file:lines() do
			local result, nm = sscanf(line, "s");
			if result == 1 then
				if Player[id].nickname == nm then
					file:close();
					return true;
				end
			end
		end
		file:close();
	end
	return false;]]

end

function _saveEnergy(id)

	local file = io.open("Database/Players/Energy/"..Player[id].nickname, "w");
	file:write(Player[id].energy.." "..Player[id].energyblock);
	file:close();

end

function _saveEnergyNewAccount(id)

	--local file = io.open("Database/Players/Energy/"..GetMacAddress(id),"r");
	--if file then
	--	file:close();
	--	return true;
	--end
	--return false;

end

function _readEnergy(id)

	local file = io.open("Database/Players/Energy/"..Player[id].nickname, "r");
	if file then

		tempvar = file:read("*l");
		local result, profID, profID2 = sscanf(tempvar,"dd");
		if result == 1 then
			Player[id].energy = profID;
			Player[id].energyblock = profID2;

			--[[local status = false;
			if _checkBlock(id, "energy", Player[id].nickname) == true then
				status = true;
			end
			
			if status == false then
				if _checkPreEnergy(id) == false then
					Player[id].energyblock = 0;
					_saveEnergy(id);
				end
			end]]
		end
	else
		_saveEnergy(id)
	end

end

function UseEnergyItems(id, itemInstance, amount, hand)

	if Player[id].loggedIn == true then

		local checked = false;

		--if _checkBlock(id, "energy", GetMacAddress(id)) == true then
  			--checked = true;
  		--end

  		if checked == false then

  			local time = os.date('*t');
		    local ryear = time.year;
			local rmonth = time.month;
			local rday = time.day;
			local rhour = string.format("%02d", time.hour);
			local rminute = string.format("%02d", time.min);
			local date = rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear;
			local oldEnergy = Player[id].energy;

			local item = string.upper(itemInstance);
  			local itfo = string.find(itemInstance, "ITFO");
  			local joint = string.find(itemInstance, "JOINT");
  			if itfo then
				SetPlayerVirtualWorld(id, math.random(5, 500));
				SetTimerEx("BackToZero", 1500, 0, id);
			end

			if joint then
				SetPlayerVirtualWorld(id, math.random(5, 500));
				SetTimerEx("BackToZero", 1500, 0, id);
			end
			
			local oldLimit = Player[id].energyblock; local oldEnergy = Player[id].energy; local newEnergy = 0; local item_en = 0; local newLimit = 0;
			
			if itemInstance == "ZDPWLA_ITFO_GRAPEJUICE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MUSHROOMOFFAL" then

                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
					
			---------------------------------------------------------------------------------------------------------
			
			elseif itemInstance == "ZDPWLA_ITFO_FISHFRIED" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 10)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFOMUTTON" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 15)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_HONEY" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MORS" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                        SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
				
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_SHELLFLESH" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 10)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SAMOGON" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_POORSOUP" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_TEA" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ACORNBOOZE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SMOKEDFISH" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 10)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MARINMUSHROOM" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_MEATSOUP" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 15)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BEER" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_RUM" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SOUP" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_CHEESE" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 15)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ACORNBREAD" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_RICEBOOZE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 10)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MBLINCHIK" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MUSHROOMCUTLET" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_GROG" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 20)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BOOZE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 20)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BREAD" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SAUSAGE" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 30)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MEDOVUHA" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 20)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FISHBATTER" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FISHSOUP" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 20)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYSALAD" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BOMBER" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 30)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_WINE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 30)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_HONEYMEAT" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BACON" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BEAFPIE" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_CASSEROLE" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);	
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BARBECUE" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYLIQUEUR" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 30)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_BERRYPIE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 60)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_FRIEDEGG" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 45)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SHAURMA" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 60)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MAGICSOUP" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 80)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MANAGA" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 40)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_HONEYBISCUIT" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 80)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_MONK_WINE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 75;
                    
                    if GetPlayerMaxMana(id) > 0 then
                          SetPlayerMana(id, GetPlayerMana(id) + 40)
                    end

                    SaveStats(id)

                    _updateMana(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_SEASALAD" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_ADDON_FIRESTEW" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 60)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_CAKE" then
                    Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 25;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 80)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_OYSTERSOUP" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 100;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 40)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_WINESTEW" then
					Player[id]._debuffDefense = true;
                    _debuffReset(id);
                    Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
                
                    Player[id].energy = Player[id].energy + 50;
                    SetPlayerHealth(id, GetPlayerHealth(id) + 60)
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
                    if GetPlayerHealth(id) > GetPlayerMaxHealth(id) then
                    	SetPlayerHealth(id, GetPlayerMaxHealth(id));
                    end
					
                    SaveStats(id)

                    _updateHealth(id)
                    _saveEnergy(id);
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "ZDPWLA_ITFO_OPUS" then
					Player[id]._debuffDefense = true;
					_debuffReset(id);
					Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
				
					Player[id].energy = Player[id].energy + 100;
					--Player[id].energyblock = Player[id].energyblock + 25;
					item_en = 25;
 
					_saveEnergy(id);
 
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "OOLTYB_ITMI_JOINT" then
					Player[id]._debuffDefense = true;
					_debuffReset(id);
					Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
				
					Player[id].energy = Player[id].energy + 15;
					--Player[id].energyblock = Player[id].energyblock + 25;
					item_en = 15;
 
					_saveEnergy(id);
 

			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "OOLTYB_ITMI_JOINT_1" then
					Player[id]._debuffDefense = true;
					_debuffReset(id);
					Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
				
					Player[id].energy = Player[id].energy + 30;
					--Player[id].energyblock = Player[id].energyblock + 25;
					item_en = 25;
 
					_saveEnergy(id);
 
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "OOLTYB_ITMI_JOINT_2" then
					Player[id]._debuffDefense = true;
					_debuffReset(id);
					Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
				
					Player[id].energy = Player[id].energy + 45;
					--Player[id].energyblock = Player[id].energyblock + 50;
					item_en = 45;
 
					_saveEnergy(id);
 
			
			---------------------------------------------------------------------------------------------------------
			elseif itemInstance == "OOLTYB_ITMI_JOINT_3" then
					Player[id]._debuffDefense = true;
					_debuffReset(id);
					Player[id]._debuffTimer = SetTimerEx(_debuffTimerDown, 1200000, 0, id);
				
					Player[id].energy = Player[id].energy + 60;
					--Player[id].energyblock = Player[id].energyblock + 100;
					item_en = 60;
 
					_saveEnergy(id);
 
					
			end

			newEnergy = Player[id].energy;
			newLimit = Player[id].energyblock;


			--local correct_limit = 100 - oldLimit; -- число, которое мы можем восстановить
			--local energy_get = newEnergy - oldEnergy; -- сколько восстановлено стамины сейчас.
			--if energy_get > correct_limit then
				--Player[id].energy = oldEnergy + correct_limit; -- устанавливает уровень стамины (старый+лимит).
			--end


			--[[local correct_limit = 100 - oldLimit;
			if newEnergy > oldEnergy then
				if correct_limit ~= 100 then
					if oldEnergy == 0 then
						Player[id].energy = correct_limit;
					end
				end
			end]]




			if Player[id].energy > 100 then
				Player[id].energy = 100;
			end
			
			if itfo then
				LogString("Logs/PlayersAll/Food", Player[id].nickname.." съел "..GetItemName(itemInstance).." (старая стамина: "..oldEnergy.." / новая стамина: "..Player[id].energy.." / ост. лимит: "..150-Player[id].energyblock.." / Дата: "..date..")");
			end

			if joint then
				LogString("Logs/PlayersAll/Food", Player[id].nickname.." съел "..GetItemName(itemInstance).." (старая стамина: "..oldEnergy.." / новая стамина: "..Player[id].energy.." / ост. лимит: "..150-Player[id].energyblock.." / Дата: "..date..")");
			end
			
			local zalupa_item = string.find(itemInstance, "ITFO");
			if zalupa_item then
				if Player[id].energyblock >= 149 then
					--Player[id].energyblock = 150;
					--_addToBlock(id, "energy")
					--SendPlayerMessage(id, 250, 67, 67, "Внимание, достигнут лимит восстановления стамины.")
				end
			end
			
			_updateHud(id);
			_saveEnergy(id);
		else
			local item = string.upper(itemInstance);
  			local itfo = string.find(itemInstance, "ITFO");
  			if itfo then
				--GameTextForPlayer(id, 50, 6000, "Достигнут дневной лимит восстановления энергии.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
			
			if item == "OOLTYB_ITMI_JOINT_1" or item == "OOLTYB_ITMI_JOINT" then
				--GameTextForPlayer(id, 50, 6000, "Достигнут дневной лимит восстановления энергии.","Font_Old_10_White_Hi.TGA", 255,0,0, 3000);
			end
		end
	end
end

function BackToZero(id)
	SetPlayerVirtualWorld(id, 0);
end
