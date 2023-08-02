
--  #   Xz system by royclapton  #
--  #       version: 1.1         #

local sound = CreateSound("LEVELUP.WAV");
function _useBooks(id, item, a, h)
	
	if Player[id].loggedIn == true then

		item = string.lower(item);

		-- языки
		if item == "book_varant" then
			if Player[id]._language_warant == 0 then
				Player[id]._language_warant = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_nordmar" then
			if Player[id]._language_nord == 0 then
				Player[id]._language_nord = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_gatia" then
			if Player[id]._language_gatia == 0 then
				Player[id]._language_gatia = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_timoris" then
			if Player[id]._language_temoris == 0 then
				Player[id]._language_temoris = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_southisland" then
			if Player[id]._language_afro == 0 then
				Player[id]._language_afro = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end


		elseif item == "book_lizard" then
			if Player[id]._language_waran == 0 then
				Player[id]._language_waran = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_orcfol" then
			if Player[id]._language_orcs == 0 then
				Player[id]._language_orcs = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_jarken" then
			if Player[id]._language_yarkendar == 0 then
				Player[id]._language_yarkendar = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		elseif item == "book_demonic" then
			if Player[id]._language_demon == 0 then
				Player[id]._language_demon = 1;
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				_saveLang(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете этот язык.")
			end

		-- навыки
		elseif item == "book_smithweapon" then
			if GetScienceLevel(id, "Оружейник") == 0 then
				AddScience(id, "Оружейник", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end


		elseif item == "book_smitharmor" then
			if GetScienceLevel(id, "Бронник") == 0 then
				AddScience(id, "Бронник", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end

		elseif item == "book_kitchener" then
			if GetScienceLevel(id, "Повар") == 0 then
				AddScience(id, "Повар", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end

		elseif item == "book_alchemist" then
			if GetScienceLevel(id, "Алхимия") == 0 then
				AddScience(id, "Алхимия", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end

		elseif item == "book_woodworker" then
			if GetScienceLevel(id, "Плотник") == 0 then
				AddScience(id, "Плотник", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_leatherman" then
			if GetScienceLevel(id, "Кожевник") == 0 then
				AddScience(id, "Кожевник", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_tailor" then
			if GetScienceLevel(id, "Портной") == 0 then
				AddScience(id, "Портной", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_hunter" then
			if Player[id].huntlevel == 0 then
				Player[id].huntlevel = 1;
				Player[id].huntexp = 0;
				SaveSkill(id);
				SaveHunt(id);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_scrollmedit" then
			if Player[id].readscrolls == 0 then
				Player[id].readscrolls = 1;
				SaveSkill(id);
				SaveHunt(id);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_chanting" then
			if GetScienceLevel(id, "Зачарователь") == 0 then
				AddScience(id, "Зачарователь", 1);
				item = string.upper(item);
				Player[id].book = item;
				SetTimerEx(_deleteBook, 750, 0, id);
				CloseInventory(id);
				SaveDLPlayerInfo(id);
				SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..". ")
				PlayPlayerSound(id, sound);
			else
				SendPlayerMessage(id, 255, 255, 255, "Вы уже владеете этим навыком.")
			end
			
		elseif item == "book_nazi1" then
			_useSkillWeaponBook(id, item, SKILL_1H, 10, 50, 60, 60, 1)

		elseif item == "book_nazi2" then
			_useSkillWeaponBook(id, item, SKILL_2H, 10, 50, 60, 60, 1)

		elseif item == "book_nazi3" then
			_useSkillWeaponBook(id, item, SKILL_BOW, 10, 50, 60, 60, 1)

		elseif item == "book_nazi4" then
			_useSkillWeaponBook(id, item, SKILL_CBOW, 10, 50, 60, 60, 1)

		elseif item == "book_garrypotter1" then
			_useMagicLevelBook(id, item, 1, 50, 0)
		
		elseif item == "book_garrypotter2" then
			_useMagicLevelBook(id, item, 2, 100, 0)

		elseif item == "book_garrypotter3" then
			_useMagicLevelBook(id, item, 3, 200, 0)

		elseif item == "book_garrypotter4" then
			_useMagicLevelBook(id, item, 4, 300, 1)

		elseif item == "book_garrypotter5" then
			_useMagicLevelBook(id, item, 5, 400, 1)

		elseif item == "book_garrypotter6" then
			_useMagicLevelBook(id, item, 6, 500, 1)

		end
	end

end

function _useSkillWeaponBook(id, item, skillId, addSkillValue, requiredSkillValue, requiredStr, requiredDex, restrictedForMages)
	local currentSkillValue = GetPlayerSkillWeapon(id, skillId)

	if (restrictedForMages > 0 and GetPlayerMagicLevel(id) >= 4) then
		SendPlayerMessage(id, 255, 255, 255, "Маги не могут развивать боевые навыки дальше.")
		return
	end

	if (GetPlayerStrength(id) < requiredStr and GetPlayerDexterity(id) < requiredDex) then
		SendPlayerMessage(id, 255, 255, 255, "Вам недостает силы или ловкости для совершенствования боевых навыков.")
		return
	end

	if currentSkillValue < requiredSkillValue then
		SendPlayerMessage(id, 255, 255, 255, "Ваших боевых навыков недостаточно для изучения этих приемов.")
		return
	end

	if currentSkillValue > requiredSkillValue then
		SendPlayerMessage(id, 255, 255, 255, "Вы уже знаете эти приемы.")
		return
	end

	SetPlayerSkillWeapon(id, skillId, currentSkillValue + addSkillValue)
	item = string.upper(item)
	Player[id].book = item
	SetTimerEx(_deleteBook, 750, 0, id)
	CloseInventory(id)
	SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..".")
	PlayPlayerSound(id, sound)
end

function _useMagicLevelBook(id, item, magicLevel, requiredMana, restrictedForWarriors)
	local currentMagicLevel = GetPlayerMagicLevel(id)
	local requiredMagicLevel = magicLevel - 1

	if currentMagicLevel < requiredMagicLevel then
		SendPlayerMessage(id, 255, 255, 255, "Необходимо достичь "..requiredMagicLevel.." круга перед изучением.")
		return
	end

	if currentMagicLevel >= magicLevel then
		SendPlayerMessage(id, 255, 255, 255, "Вы уже достигли этого круга.")
		return
	end

	if (restrictedForWarriors > 0 and (GetPlayerSkillWeapon(id, SKILL_1H) >= 60 or GetPlayerSkillWeapon(id, SKILL_2H) >= 60 or GetPlayerSkillWeapon(id, SKILL_BOW) >= 60 or GetPlayerSkillWeapon(id, SKILL_CBOW) >= 60)) then
		SendPlayerMessage(id, 255, 255, 255, "Воины не могут развивать магические навыки дальше.")
		return
	end

	if GetPlayerMaxMana(id) < requiredMana then
		SendPlayerMessage(id, 255, 255, 255, "Необходимо "..requiredMana.." маны для изучения круга.")
		return
	end

	SetPlayerMagicLevel(id, magicLevel)
	item = string.upper(item)
	Player[id].book = item
	SetTimerEx(_deleteBook, 750, 0, id)
	CloseInventory(id)
	SendPlayerMessage(id, 255, 255, 255, "Вы прочли книгу "..GetItemName(item)..".")
	PlayPlayerSound(id, sound)
end

function _deleteBook(id)
	RemoveItem(id, Player[id].book, 1);
	SaveItems(id);
	Player[id].book = nil;
end