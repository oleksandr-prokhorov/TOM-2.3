
--  # World Container system by royclapton #
--  #             version: 1.0             #

--[[

	состояния статуса: 0 - слот свободен, 1 - слот занят/заспавнен, 2 - слот занят, сейчас лутается, 3 - слот занят, но залутан.
	в функции _createWorldContainer есть 6 обязательных аргументов: sname ... world. остальные можно проигнорировать (не писать их).
	rx, ry, rz - угол поворота объекта.
	drop_list - список, откуда будет браться дроп с предмета. если не указать дроп_лист, то скрипт назначит стандартный дроп_лист (default).
	эти дроп листы прописывать в функции _worldContainerDropLists()
	если контейнер не заспавнился или есть другие трудности: ПРОВЕРЯТЬ ЛОГИ!!!!!! (Logs/Server/WorldContainer..... .txt);
	обращаю внимание: названия дроп-листов должны быть единым словом! т.е, если нужен пробел в названии контейнера, то использовать подчеркивания:
																																		VASYA_PETYA (VASYA PETYA не подойдет).
																																		FOOD_LIST (FOOD LIST не подойдет).
	так же обращаю внимание, что если контейнер создается не через игру, то уникальное название нужно ставить аналогично названиям дроп-листов.
	для того чтобы добавить в контейнер спавн какого-нибудь уебана, нужно создать новую позицию в дроп-листе. например:
																											  в список предметов: ZOMBIE
																											  в количество: 1 (заспавнится один зомбик)
																											  в шанс: 100 (с вероятностью 100%).
																											  список ПОКА ЧТО ограничен тока падальщиком (SCAVENGER)




]]																												

DROP_LIST_GETN = 150;
WKEY = "";

WCONT = {};
for i = 1, DROP_LIST_GETN do
	WCONT[i] = {};
	WCONT[i].id = i;
	WCONT[i].sname = "slot"..i;
	WCONT[i].status = 0;
	WCONT[i].pos = {0, 0, 0};
	WCONT[i].rotate = {};
	WCONT[i].drop = nil;
	WCONT[i].visual = nil;
	WCONT[i].mob = nil;
	WCONT[i].world = nil;
	WCONT[i].perm = 0;
end

WDROPS = {};
for i = 1, DROP_LIST_GETN do
	WDROPS[i] = {};
	WDROPS[i].drop_list_name = nil;
	WDROPS[i].drop = {};
	WDROPS[i].amount = {};
	WDROPS[i].chance = {};
end

function _worldContainerDropLists()

	-- alice

	WDROPS[1].drop_list_name = "бандиты1" 
	WDROPS[1].drop = {"yfauun_itar_bdt_l", "jkztzd_itmw_streitaxt1", "jkztzd_itrw_mil_crossbow", "yfauun_ithl_l_band", "zeqfrn_itpo_health_01", "ooltyb_itmi_goldring", "ooltyb_itmi_silverchalice", "ooltyb_itmi_jewelerychest", "ooltyb_itmi_goldnecklace", "ooltyb_itmi_silverplate", "yfauun_itar_torba2"} 
	WDROPS[1].amount = {1, 1, 1, 2, 4, 1, 1, 1, 1, 1, 1}
	WDROPS[1].chance = {5, 5, 5, 25, 50, 5, 5, 5, 5, 5, 5}
	print("World Container DL Created: "..WDROPS[1].drop_list_name);
	-- броня т1, т1 двуруч, т1 арб, бандана, эссенции хп, зол. кольцо, серебр чаша, шкатулка с драгоценностями, зол. ожерелье, серебр тарелка, сумка

	WDROPS[2].drop_list_name = "пиратклад1"
	WDROPS[2].drop = {"yfauun_itar_stani", "jkztzd_itmw_piratensaebel", "jkztzd_itmw_schiffsaxt", "book_southisland", "zeqfrn_itpo_health_01", "ooltyb_itmi_jewelerychest", "ooltyb_itmi_sextant", "ooltyb_itmi_goldcup", "ooltyb_itmi_oldcoin", "ooltyb_itmi_jointrecipe_1", "ooltyb_itmi_addon_whitepearl", "ooltyb_itmi_darkpearl"}
	WDROPS[2].amount = {1, 1, 1, 1, 4, 1, 1, 1, 20, 1, 3, 2}
	WDROPS[2].chance = {5, 5, 5, 5, 50, 5, 5, 5, 5, 5, 5, 5}
	print("World Container DL Created: "..WDROPS[2].drop_list_name);
	-- т1 броня, т2 одноруч, т1 одноруч, язык юо, эссенция хп, шкатулка с драг, секстант, зол кубок, старые монеты, рецепт болотник т1, жемчужины, черный жемчуг

	WDROPS[3].drop_list_name = "сокровищемонстра1"
	WDROPS[3].drop = {"ooltyb_itmi_skull", "ooltyb_itat_skeletonbone", "ooltyb_itat_goblinbone", "ooltyb_itat_shadowhorn", "zeqfrn_itpo_health_01", "jkztzd_itrw_bow_l_03"}
	WDROPS[3].amount = {1, 3, 2, 1, 4, 1}
	WDROPS[3].chance = {25, 25, 25, 25, 50, 25}
	print("World Container DL Created: "..WDROPS[3].drop_list_name);
	--череп, кость, кось гоблина, рог мракориса, эссенция хп, т1 лук

	WDROPS[4].drop_list_name = "сокровищемонстра2"
	WDROPS[4].drop = {"ooltyb_itmi_skull", "ooltyb_itat_skeletonbone", "ooltyb_itmi_innosstatue", "yfauun_itar_torba", "zeqfrn_itpo_health_01", "jkztzd_itrw_arrow"}
	WDROPS[4].amount = {1, 3, 1, 1, 4, 40}
	WDROPS[4].chance = {25, 25, 25, 25, 50, 25}
	print("World Container DL Created: "..WDROPS[4].drop_list_name);
	--череп, кость, статуя инноса, сумка, эссенция хп, стрелы

	WDROPS[5].drop_list_name = "сокровищемонстра3"
	WDROPS[5].drop = {"ooltyb_itmi_skull", "ooltyb_itat_skeletonbone", "ooltyb_itmi_oldcoin", "zdpwla_itfo_sausage", "zeqfrn_itpo_health_01", "yfauun_itar_hunter3"}
	WDROPS[5].amount = {1, 3, 25, 3, 4, 1}
	WDROPS[5].chance = {25, 25, 25, 25, 50, 15}
	print("World Container DL Created: "..WDROPS[5].drop_list_name);
	--череп, кость, стар монета, колбаса, эссенция хп, т2 бронь

	WDROPS[6].drop_list_name = "пиратклад2"
	WDROPS[6].drop = {"yfauun_itar_stani", "jkztzd_itmw_schiffsaxt", "zeqfrn_itpo_health_01", "ooltyb_itmi_jewelerychest", "zeqfrn_itpo_speed", "ooltyb_itmi_goldcup", "ooltyb_itmi_oldcoin", "ooltyb_itmi_addon_whitepearl", "ooltyb_itmi_darkpearl"}
	WDROPS[6].amount = {1, 1, 4, 1, 1, 1, 25, 4, 1}
	WDROPS[6].chance = {5, 5, 50, 15, 5, 15, 15, 15, 10}
	print("World Container DL Created: "..WDROPS[6].drop_list_name);
	-- т1 броня, т1 одноруч, эссенция хп, шкатулка с драг, зелье ускор, зол кубок, старые монеты, жемчужины, черный жемчуг

	WDROPS[7].drop_list_name = "бандиты2" 
	WDROPS[7].drop = {"ooltyb_itmi_oldcoin", "ooltyb_itmi_doppeltabak", "rc_dgreen_mask", "zeqfrn_itpo_health_01", "ooltyb_itmi_silverring", "zdpwla_itpl_swampherb", "ooltyb_itmi_jewelerychest", "ooltyb_itmi_silvernecklace", "ooltyb_itke_lockpick", "yfauun_ithl_m_helmet5", "zdpwla_itfo_ricebooze", "yfauun_itsh_shield_02", "jkztzd_itmw_spicker"} 
	WDROPS[7].amount = {20, 4, 2, 4, 1, 15, 1, 1, 5, 1, 3, 1, 1}
	WDROPS[7].chance = {15, 15, 25, 50, 15, 15, 15, 15, 15, 15, 25, 5, 5}
	print("World Container DL Created: "..WDROPS[7].drop_list_name);
	-- стар монета, Двойное яблоко, бандана, эссенции хп, сер. кольцо, болотник, шкатулка с драгоценностями, сер. ожерелье, отмычка, легкий шлем, еда на 50, щит т2, т2 одноруч


	-- riverander
	WDROPS[8].drop_list_name = "кожевник"
	WDROPS[8].drop = {"ooltyb_itmi_leather", "ooltyb_itmi_qleather", "ooltyb_itmi_t_leather", "ooltyb_itat_wolffur", "ooltyb_itat_shadowfur"}
	WDROPS[8].amount = {2, 2, 1, 2, 2}
	WDROPS[8].chance = {10, 10, 10, 10, 10}
	print("World Container DL Created: "..WDROPS[8].drop_list_name);
	-- "кожа", "качественная кожа", "тонкая кожа", "шкура", "качественная шкура"
	 
	WDROPS[9].drop_list_name = "оружейник"
	WDROPS[9].drop = {"ooltyb_itmiswordrawhot", "ooltyb_itmiswordblade", "ooltyb_itmi_m_wire", "ooltyb_itmi_iron", "ooltyb_itmi_coal"}
	WDROPS[9].amount = {2, 2, 1, 40, 10}
	WDROPS[9].chance = {10, 10, 10, 10, 10}
	print("World Container DL Created: "..WDROPS[9].drop_list_name);
	-- "закаленная сталь", "клинок", "проволока", "кусок железной руды", "уголь"
	 
	WDROPS[10].drop_list_name = "бронник"
	WDROPS[10].drop = {"ooltyb_itmi_s_ignot", "ooltyb_itmiswordraw", "ooltyb_itmi_rivet", "ooltyb_itmi_iron", "ooltyb_itmi_coal"}
	WDROPS[10].amount = {2, 2, 1, 40, 10}
	WDROPS[10].chance = {10, 10, 10, 10, 10}
	print("World Container DL Created: "..WDROPS[10].drop_list_name);
	-- "слиток", "обработанная сталь", "заклепка", "кусок железной руды", "уголь"
	 
	WDROPS[11].drop_list_name = "плотник"
	WDROPS[11].drop = {"ooltyb_itmi_obrabotder", "ooltyb_itmi_alchemy_syrianoil_01", "ooltyb_itmi_handle", "ooltyb_itmi_wood", "ooltyb_itmi_coal"}
	WDROPS[11].amount = {2, 2, 1, 30, 10}
	WDROPS[11].chance = {10, 10, 10, 10, 10}
	print("World Container DL Created: "..WDROPS[11].drop_list_name);
	-- "обработанная древесина", "деготь", "рукоять", "древесина", "уголь"
	 
	WDROPS[12].drop_list_name = "портной"
	WDROPS[12].drop = {"нить", "сукно", "льняная ткань", "шерсть"}
	WDROPS[12].amount = {2, 2, 1, 30}
	WDROPS[12].chance = {15, 10, 10, 15}
	print("World Container DL Created: "..WDROPS[12].drop_list_name);
	-- "нить", "сукно", "льняная ткань", "шерсть"
	 
	WDROPS[13].drop_list_name = "книжполка1"
	WDROPS[13].drop = {"ooltyb_itmi_paper", "ihpiwn_itsc_light", "ihpiwn_itsc_lightheal", "ihpiwn_itsc_lightfocheal"}
	WDROPS[13].amount = {25, 2, 2, 2}
	WDROPS[13].chance = {35, 5, 5, 5}
	print("World Container DL Created: "..WDROPS[13].drop_list_name);
	-- "бумага", "Свиток свет", "Свиток легкое лечение", "Свиток легкое лечение таргет"
	 
	WDROPS[14].drop_list_name = "книжполка2"
	WDROPS[14].drop = {"book_varant", "book_nordmar", "book_gatia", "book_timoris", "book_southisland"}
	WDROPS[14].amount = {1, 1, 1, 1, 1}
	WDROPS[14].chance = {5, 5, 5, 5, 5}
	print("World Container DL Created: "..WDROPS[14].drop_list_name);
	-- "Предания Варанта", "Старый Нормадский фолиант", "Том ХХI Образования Гатии", "Закат эпохи Тимориса", "Пыльный фолиант Южных Островов"
	 
	WDROPS[15].drop_list_name = "книжполка3"
	WDROPS[15].drop = {"book_smithweapon", "book_smitharmor", "book_kitchener", "book_alchemist", "book_woodworker", "book_leatherman", "book_tailor", "book_hunter", "book_scrollmedit"}
	WDROPS[15].amount = {1, 1, 1, 1, 1, 1, 1, 1, 1}
	WDROPS[15].chance = {5, 5, 5, 5, 5, 5, 5, 5, 5}
	print("World Container DL Created: "..WDROPS[15].drop_list_name);
	-- "Мастерское оружие Миртаны", "Десять ошибок бронника","Искуссная кулинария Винченцо", "Обратная сторона алхимии", "Руководство плотницкому делу", "Умелый кожедел","Гобелен судьбы портного", "Охота и трофеи", "Мана небесная"
	 
	WDROPS[16].drop_list_name = "говно"
	WDROPS[16].drop = {"zdpwla_itpl_weed", "ooltyb_itmi_dirty_water", "ooltyb_itmi_bottle_empty", "ooltyb_itmi_packet"}
	WDROPS[16].amount = {1, 1, 1, 1}
	WDROPS[16].chance = {25, 25, 25, 25}
	print("World Container DL Created: "..WDROPS[16].drop_list_name);
	-- сорняк, грязная вода, пустая бутылка, пакет (чисто каловый лут для любителей полутать)

	WDROPS[17].drop_list_name = "бандит1"
	WDROPS[17].drop = {"ooltyb_itmi_s_ignot", "ooltyb_itmi_goldnugget_addon", "zdpwla_itfo_wine", "ooltyb_itmi_joint_1", "ooltyb_itmi_bijouterie", "jkztzd_itrw_arrow", "ooltyb_itmi_obrabotder", "zeqfrn_itpo_health_01", "ooltyb_itmi_linen_holst", "ooltyb_itmi_leather", "jkztzd_itrw_bolt", "zdpwla_itmi_alchbasis"}
	WDROPS[17].amount = {1, 5, 3, 5, 2, 50, 3, 10, 2, 4, 50, 1}
	WDROPS[17].chance = {100, 100, 5, 5, 10, 10, 15, 10, 10, 10, 15, 10}
	print("World Container DL Created: "..WDROPS[17].drop_list_name);
	-- 

	WDROPS[18].drop_list_name = "бандит2"
	WDROPS[18].drop = {"ooltyb_itmi_flask", "ooltyb_itmi_leather", "ooltyb_itmi_silvernugget", "ooltyb_itmi_goldnugget_addon", "ooltyb_itmi_nail", "jkztzd_itrw_arrow", "jkztzd_itrw_bolt", "zdpwla_itfo_marinmushroom", "ooltyb_itmiswordblade"}
	WDROPS[18].amount = {10, 1, 10, 5, 1, 25, 25, 15, 1}
	WDROPS[18].chance = {100, 100, 100, 100, 25, 15, 20, 20, 20}
	print("World Container DL Created: "..WDROPS[18].drop_list_name);
	-- 

	WDROPS[19].drop_list_name = "бандит3"
	WDROPS[19].drop = {"ooltyb_itmi_stroy", "ooltyb_itat_wolffur", "ooltyb_itmi_silvernugget", "ooltyb_itmi_goldnugget_addon", "jkztzd_itmw_hacker_01", "yfauun_itar_hunter3", "zeqfrn_itpo_health_02", "ooltyb_itmi_iron", "ooltyb_itmi_iron", "zdpwla_itfo_managa", "ooltyb_itmi_dleather", "zdpwla_itmi_glue", "yfauun_itsh_shield_02", "jkztzd_itrw_crossbow_m_02"}
	WDROPS[19].amount = {1, 1, 10, 10, 1, 1, 10, 100, 100, 10, 2, 1, 1, 1}
	WDROPS[19].chance = {100, 100, 100, 100, 5, 5, 10, 15, 15, 10, 5, 15, 10, 10}
	print("World Container DL Created: "..WDROPS[19].drop_list_name);
	-- 

	WDROPS[20].drop_list_name = "монстр1"
	WDROPS[20].drop = {"ooltyb_itat_wolffur", "zdpwla_itpl_strength_herb_01", "zdpwla_itfo_plants_mountainmoss_01", "zdpwla_itfo_plants_towerwood_01", "zdpwla_itfo_plants_nightshadow_01", "zdpwla_itfo_egg"}
	WDROPS[20].amount = {3, 5, 5, 30, 5, 10}
	WDROPS[20].chance = {100, 20, 20, 20, 20, 20}
	print("World Container DL Created: "..WDROPS[20].drop_list_name);

	WDROPS[21].drop_list_name = "монстр2"
	WDROPS[21].drop = {"ooltyb_itat_fat", "ooltyb_itmi_sheep", "yfauun_itar_islam1", "zdpwla_itpl_swampherb", "zdpwla_itfo_plants_seraphis_01", "zdpwla_itpl_temp_herb"}
	WDROPS[21].amount = {2, 10, 1, 25, 15, 50}
	WDROPS[21].chance = {100, 100, 25, 25, 25, 25}
	print("World Container DL Created: "..WDROPS[21].drop_list_name);

	WDROPS[22].drop_list_name = "монстр3"
	WDROPS[22].drop = {"ooltyb_itat_shadowfur", "zdpwla_itfomuttonraw", "zdpwla_itpl_forestberry", "jkztzd_itrw_sld_bow", "yfauun_itar_walker", "zdpwla_itpl_health_herb_03", "jkztzd_itrw_arrow", "jkztzd_itrw_bolt"}
	WDROPS[22].amount = {1, 30, 5, 1, 1, 5, 25, 25}
	WDROPS[22].chance = {100, 100, 100, 20, 20, 20, 20, 20}
	print("World Container DL Created: "..WDROPS[22].drop_list_name);



end

function _worldContainerInit()

	print("=======================================")
	print("        WORLD CONTAINERS....       ")
	_worldContainerDropLists()

	local count = 0;
	local file = io.open("Database/WorldContainer/Containers.txt", "r");
	if file then
		for line in file:lines() do
			count = count + 1;
		end
		file:close();
	end

	if count > 0 then
		local file = io.open("Database/WorldContainer/Containers.txt", "r");
		if file then
			for line in file:lines() do
				local l, sname, visual, drop, x, y, z, rx, ry, rz, world = sscanf(line, "sssdddddds")
				if l == 1 then

					local droplistcorr = false;
					for i = 1, DROP_LIST_GETN do
						if WDROPS[i].drop_list_name == drop then
							droplistcorr = true;
							break
						end
					end

					if droplistcorr == true then
						for i = 1, DROP_LIST_GETN do
							if WCONT[i].status == 0 then
								WCONT[i].sname = "slot_"..i;
								WCONT[i].status = 1;
								WCONT[i].pos = {x, y, z};

								if visual == "random" then
									WCONT[i].visual = "random";
								else
									WCONT[i].visual = visual;
								end

								WCONT[i].world = world;
								WCONT[i].drop = drop;

								if visual == "random" then
									WCONT[i].mob = Mob.Create(_worldContainerGetRandomVisual(), "MOBNAME_GO_CONTAINER", 1, "CHESTBIG", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
								else
									WCONT[i].mob = Mob.Create(WCONT[i].visual, "MOBNAME_GO_CONTAINER", 1, "CHESTBIG", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
								end

								WCONT[i].rotate = {rx, ry, rz};
								Mob.SetRotation(WCONT[i].mob, WCONT[i].rotate[1], WCONT[i].rotate[2], WCONT[i].rotate[3])
								LogString("Logs/Server/WorldContainerSpawn","Создан контейнер в слот-"..i.." "..WCONT[i].sname.." [".._getRTime().."] (запуск сервера).");
								print("Container (slot-"..i..") load.");
								break
							end
						end
					else
						print("ERROR: Cannot find drop-list name -"..drop.."-.")
						LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера со строки Containers.txt: [[ "..line.."]] / ".._getRTime().." - не найден дроп-лист (запуск сервера).");
					end
				end
			end
			file:close();
		else
			print("ERROR: CANNOT READ Containers.txt!");
		end

	elseif count > 39 then
		local file = io.open("Database/WorldContainer/Containers.txt", "r");
		if file then
			local times = 0;
			for line in file:lines() do
				if times < 40 then
					times = times + 1;
					local l, sname, visual, drop, x, y, z, rx, ry, rz, world = sscanf(line, "sssdddddds")
					if l == 1 then

						local droplistcorr = false;
						for i = 1, DROP_LIST_GETN do
							if WDROPS[i].drop_list_name == drop then
								droplistcorr = true;
								break
							end
						end

						if droplistcorr == true then
							for i = 1, DROP_LIST_GETN do
								if WCONT[i].status == 0 then
									WCONT[i].sname = "slot_"..i;
									WCONT[i].status = 1;
									WCONT[i].pos = {x, y, z};
									if visual == "random" then
										WCONT[i].visual = _worldContainerGetRandomVisual();
									else
										WCONT[i].visual = _worldContainerSetVisual(i, visual);
									end
									WCONT[i].world = world;
									WCONT[i].drop = drop;
									WCONT[i].mob = Mob.Create(WCONT[i].visual, "MOBNAME_GO_CONTAINER", 1, "", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
									WCONT[i].rotate = {rx, ry, rz};
									Mob.SetRotation(WCONT[i].mob, WCONT[i].rotate[1], WCONT[i].rotate[2], WCONT[i].rotate[3])
									LogString("Logs/Server/WorldContainerSpawn","Создан контейнер в слот-"..i.." "..WCONT[i].sname.." [".._getRTime().."] (запуск сервера).");
									print("Container (slot-"..i..") load.");
									break
								end
							end
						else
							print("ERROR: Cannot find drop-list name -"..drop.."-.")
							LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера со строки Containers.txt: [[ "..line.."]] / ".._getRTime().." - не найден дроп-лист (запуск сервера).");
						end
					end
				end
			end
			file:close();
		else
			print("ERROR: CANNOT READ Containers.txt!");
		end
	end

	print("=======================================")


end

function _worldContainerSetVisual(cid, visual)

	if visual == "ящик" then
		WCONT[cid].visual = "NW_HARBOUR_CRATE_01.3DS";

	else
		WCONT[cid].visual = _worldContainerGetRandomVisual();
	end

end

function _createWorldContainer(sname, x, y, z, visual, world, rx, ry, rz, drop_list) 
	
	-- вроде эта хуйня не воркает, написал ее в самом начале, а после сотню правок ввел уже в код
	if sname and type(sname) == "string" then
		if x and y and z then
			if visual then
				if world then

					for i = 1, DROP_LIST_GETN do
						if WCONT[i].status == 0 then
							WCONT[i].sname = sname;
							WCONT[i].status = 1;
							WCONT[i].pos = {x, y, z};
							WCONT[i].visual = visual;
							WCONT[i].world = world;
							WCONT[i].mob = Mob.Create(WCONT[i].visual, "MOBNAME_GO_CONTAINER", 1, "", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);

							if rx and ry and rz then
								WCONT[i].rotate = {rx, ry, rz};
								Mob.SetRotation(WCONT[i].mob, WCONT[i].rotate[1], WCONT[i].rotate[2], WCONT[i].rotate[3])
							end

							if drop_list then
								WCONT[i].drop = drop_list;
							else
								WCONT[i].drop = "default";
							end

							LogString("Logs/Server/WorldContainerSpawn","Создан контейнер #"..i.." "..sname.." [".._getRTime().."].");
							break
						end
					end
				else
					LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера [".._getRTime().."] - не правильно/указан игровой мир.");
				end
			else
				LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера [".._getRTime().."] - не правильно/указан визуал объекта.");
			end
		else
			LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера [".._getRTime().."] - не правильно/указаны координаты.");
		end
	else
		LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера [".._getRTime().."] - не правильно/указано условное название.");
	end

end


function _createWorldContainerInGame(id, sets)

	if Player[id].astatus > -1 then
		local cmd, drop_list, visual = sscanf(sets, "ss"); -- save - *d
		if cmd == 1 then
			--if save == 1 or save == 0 then
				local droplistcorr = false;
				for i = 1, 150 do
					if WDROPS[i].drop_list_name == drop_list then
						droplistcorr = true;
						break
					end
				end

				local error_status = nil;
				if droplistcorr == true then
					local x, y, z = GetPlayerPos(id);
					for i = DROP_LIST_GETN, 1, -1 do
						if WCONT[i].status == 0 then
							WCONT[i].sname = "ADMIN_CONTAINER";
							WCONT[i].status = 1;
							WCONT[i].drop = drop_list;
							WCONT[i].pos = {x, y - 70, z};
							WCONT[i].rotate = {0, 0, 0};
							WCONT[i].world = GetPlayerWorld(id);
							--WCONT[i].perm = save;

							visual = string.lower(visual);

							if visual == "ящик" then
								WCONT[i].visual = "NW_HARBOUR_CRATE_01.3DS";
							------------------------------------------------------
						
							elseif visual == "бочкатряпка" then
								WCONT[i].visual = "KM_VOB_BARRELTABLE_02.3DS";
						
							elseif visual == "кучапакетов" then
								WCONT[i].visual = "KM_VOB_PACKAGE_04.3DS";
						
							elseif visual == "ящикруда" then
								WCONT[i].visual = "OM_OREBOX_01.3DS";
								
							elseif visual == "бочка" then
								WCONT[i].visual = "NW_HARBOUR_BARREL_01.3DS";
						
							elseif visual == "ящикрыба" then
								WCONT[i].visual = "CORPSEPLUNDER_FISHCHEST.ASC";
						
							elseif visual == "ящиксломан" then
								WCONT[i].visual = "NW_HARBOUR_CRATEBROKEN_01.3DS";
						
							elseif visual == "кучамешковдругие" then
								WCONT[i].visual = "OC_SAECKE_01.3DS";
						
							elseif visual == "кошель" then
								WCONT[i].visual = "ITMI_POCKET.3DS";
						
							elseif visual == "ящикдрова" then
								WCONT[i].visual = "OC_FIREWOOD_V2.3DS";
						
							elseif visual == "мешокмука" then
								WCONT[i].visual = "KM_VOB_SACKS_04.3DS";
						
							elseif visual == "шкатулка" then
								WCONT[i].visual = "ITMI_GOLDCHEST.3DS";
						
							elseif visual == "ящиквиноград" then
								WCONT[i].visual = "KM_VOB_GRAPECRATE_01.3DS";
								
							elseif visual == "стогсена" then
								WCONT[i].visual = "NW_MISC_STRAW_02.3DS";
						
							elseif visual == "пеньнахуй" then
								WCONT[i].visual = "NW_NATURE_BAUMSTUMPF_02_154P.3DS";
						
							elseif visual == "пеньпоменьше" then
								WCONT[i].visual = "NW_NATURE_BAUMSTUMPF_115P.3DS";
						
							elseif visual == "пеньпобольше" then
								WCONT[i].visual = "NW_NATURE_BAUMSTUMPF_02_115P.3DS";
						
							elseif visual == "бочкасломана" then
								WCONT[i].visual = "OC_BARREL_V1_DESTROYED.3DS";
						
							elseif visual == "бочкамечи" then
								WCONT[i].visual = "NW_CITY_WEAPON_BARREL_01.3DS";
						
							elseif visual == "мешокмечи" then
								WCONT[i].visual = "NW_CITY_WEAPON_BAG_01.3DS";
						
							elseif visual == "скелет" then
								WCONT[i].visual = "ORC_SKELETON_V2.3DS";
						
							elseif visual == "могила" then
								WCONT[i].visual = "NW_MISC_FIELDGRAVE_01.3DS";
								
							elseif visual == "саркофаг" then
								WCONT[i].visual = "NW_EVT_CEMENTARYCOFFIN_01.3DS";
						
							elseif visual == "рандом" then
								WCONT[i].visual = "random";
						
							else
								WCONT[i].visual = "random";
							end

							if WCONT[i].visual == "random" then
								WCONT[i].mob = Mob.Create(_worldContainerGetRandomVisual(), "MOBNAME_GO_CONTAINER", 1, "CHESTBIG", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
							else
								WCONT[i].mob = Mob.Create(WCONT[i].visual, "MOBNAME_GO_CONTAINER", 1, "CHESTBIG", "", WCONT[i].world, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
							end

							Mob.SetRotation(WCONT[i].mob, WCONT[i].rotate[1], WCONT[i].rotate[2], WCONT[i].rotate[3])
							error_status = "Контейнер создан на слоте: "..i.." # ";
							--if WCONT[i].perm == 1 then
								--_worldContainerSave(i);
							--end
							LogString("Logs/Server/WorldContainerSpawn","Создан контейнер в слот-"..i.." "..WCONT[i].sname.." [".._getRTime().."], админ "..Player[id].nickname);
							--LogString("Logs/Server/WorldContainerSpawn","Статус сохранения: "..save);
							LogString("Logs/Server/WorldContainerSpawn","-------------------------------------------------------------");
							break
						else
							error_status = "Ошибка создания контейнера: не найдено свободных слотов."
						end
					end
				else
					error_status = "Ошибка создания контейнера: не найден дроп_лист."
					LogString("Logs/Server/WorldContainerErrors","Ошибка создания контейнера [".._getRTime().."] - не правильно/указано название дроп-листа (сервер) админом "..Player[id].nickname);
				end
				SendPlayerMessage(id, 255, 255, 255, error_status);
			--else
			--	SendPlayerMessage(id, 255, 255, 255, "Сохранение должно быть указано в виде чисел 0 или 1 (где 0 - не сохранять).")
			--end
		else
			SendPlayerMessage(id, 255, 255, 255, "/контейнер (дроп-лист) (visual)")
		end
	end

end
addCommandHandler({"/контейнер"}, _createWorldContainerInGame);

function _worldContainerSave(wcid)

	local file = io.open("Database/WorldContainer/Containers.txt", "a+");
	file:write(WCONT[wcid].sname.." ");
	if WCONT[wcid].visual == "рандом" or WCONT[wcid].visual == "random" then
		file:write("random ");
	else
		file:write(WCONT[wcid].visual.." ");
	end
	file:write(WCONT[wcid].drop.." "..WCONT[wcid].pos[1].." "..WCONT[wcid].pos[2].." "..WCONT[wcid].pos[3].." "..
			   WCONT[wcid].rotate[1].." "..WCONT[wcid].rotate[2].." "..WCONT[wcid].rotate[3].." "..WCONT[wcid].world.."\n");
	file:close();

end


function _worldContainerGetRandomVisual()

	local random = math.random(1, 33);

	if random == 1 then
		return "NW_HARBOUR_BARREL_01.3DS";

	elseif random == 2 then
		return "DT_FIREPLACE_V1.3DS";

	elseif random == 3 then
		return "OC_FIREWOOD_V2.3DS";

	elseif random == 4 then
		return "NW_HARBOUR_CRATE_01.3DS";

	elseif random == 5 then
		return "OC_SAECKE_01.3DS";

	elseif random == 6 then
		return "NW_HARBOUR_ROPE_01.3DS";

	elseif random == 7 then
		return "NW_MISC_STRAW_01.3DS";

	elseif random == 8 then
		return "OC_FIREWOOD_V1.3DS";

	elseif random == 9 then
		return "NW_MISC_STRAW_02.3DS";

	elseif random == 10 then
		return "NW_HARBOUR_CRATEBROKEN_01.3DS";

	elseif random == 11 then
		return "NW_HARBOUR_CRATE_01.3DS";

	elseif random == 12 then
		return "KM_VOB_BARRELTABLE_02.3DS";

	elseif random == 13 then
		return "KM_VOB_PACKAGE_04.3DS";

	elseif random == 14 then
		return "OM_OREBOX_01.3DS";

	elseif random == 15 then
		return "NW_HARBOUR_BARREL_01.3DS";

	elseif random == 16 then
		return "CORPSEPLUNDER_FISHCHEST.ASC";

	elseif random == 17 then
		return "NW_HARBOUR_CRATEBROKEN_01.3DS";

	elseif random == 18 then
		return "OC_SAECKE_01.3DS";

	elseif random == 19 then
		return "ITMI_POCKET.3DS";

	elseif random == 20 then
		return "OC_FIREWOOD_V2.3DS";

	elseif random == 21 then
		return "KM_VOB_SACKS_04.3DS";

	elseif random == 22 then
		return "ITMI_GOLDCHEST.3DS";

	elseif random == 23 then
		return "KM_VOB_GRAPECRATE_01.3DS";

	elseif random == 24 then
		return "NW_MISC_STRAW_02.3DS";

	elseif random == 25 then
		return "NW_NATURE_BAUMSTUMPF_02_154P.3DS";

	elseif random == 26 then
		return "NW_NATURE_BAUMSTUMPF_115P.3DS";

	elseif random == 27 then
		return "NW_NATURE_BAUMSTUMPF_02_115P.3DS";

	elseif random == 28 then
		return "OC_BARREL_V1_DESTROYED.3DS";

	elseif random == 29 then
		return "NW_CITY_WEAPON_BARREL_01.3DS";

	elseif random == 30 then
		return "NW_CITY_WEAPON_BAG_01.3DS";

	elseif random == 31 then
		return "ORC_SKELETON_V2.3DS";

	elseif random == 32 then
		return "NW_MISC_FIELDGRAVE_01.3DS";

	elseif random == 33 then
		return "NW_EVT_CEMENTARYCOFFIN_01.3DS";
	end

end

function _worldContainerConnect(id)
	Player[id].wctimer = nil;
	Player[id].wcid = nil;
	Player[id].wzone = {false, false};
	Player[id].wcurrent = nil;
	Player[id].wdraw = CreatePlayerDraw(id, 0, 0, "");
end

function _worldContainerKey(id, down, up)

	if Player[id].loggedIn == true then
		if down == KEY_G then
			local x, y, z = GetPlayerPos(id);
			for i = 1, DROP_LIST_GETN do
				local checkPos = GetDistance3D(x, y, z, WCONT[i].pos[1], WCONT[i].pos[2], WCONT[i].pos[3]);
				if checkPos < 200 and GetPlayerWorld(id) == WCONT[i].world then
					if WCONT[i].status == 1 then
						if Player[id].energy >= 25 then
							Player[id].energy = Player[id].energy - 25;
							_saveEnergy(id)
							PlayAnimation(id, "T_CHESTBIG_STAND_2_S0");
							FreezePlayer(id, 1);
							ShowTexture(id, Player[id].prog_background_f);
							ShowTexture(id, Player[id].prog_f);
							SetDefaultCamera(id);
							_newSetCameraBeforePlayer(id, 1);
							SetTimerEx("freezeCameraTimer", 400, 0, id);
							Player[id].wctimer = SetTimerEx("_worldContainerF", 100, 1, id);
							WCONT[i].status = 2;
							Player[id].wcid = i;
							_worldContainerUpdateState(id);
						else
							SendPlayerMessage(id, 255, 255, 255, "У вас недостаточно энергии");
						end
						break
					end
				end
			end
		end

	end
end

function _worldContainerGetDropList(drop_list)

	for i = 1, DROP_LIST_GETN do
		if WDROPS[i].drop_list_name == drop_list then
			return i;
		end
	end
	return nil;

end

function _worldContainerF(id)

	if Player[id].current_size_f > Player[id].zero_size_f then
		Player[id].current_size_f = Player[id].current_size_f - 20;
		UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].current_size_f, 7469, 'PROGRESS_BLUE_BAR');
	else
		KillTimer(Player[id].wctimer);

		if Player[id].loggedIn == true then

			UpdateTexture(Player[id].prog_f, 3007, 7283, Player[id].start_size_f, 7469, 'PROGRESS_BLUE_BAR');
			Player[id].current_size_f = Player[id].start_size_f;
			Player[id].wctimer = nil;
			HideTexture(id, Player[id].prog_f)
			HideTexture(id, Player[id].prog_background_f);
			FreezeCamera(id, 0);
			SetDefaultCamera(id);
			UnFreeze(id);
			PlayAnimation(id, "S_CHESTBIG_S0");
			PlayAnimation(id, "T_CHESTBIG_S0_2_STAND");
			

			local wcid = Player[id].wcid; 
			local droplistid = _worldContainerGetDropList(WCONT[wcid].drop);
			local tcount = table.getn(WDROPS[droplistid].drop);
			local drops = "Вы ничего не нашли!";

			if tcount > 0 then
				for i = 1, tcount do
					local rnd = math.random(1, 100);

					if rnd <= WDROPS[droplistid].chance[i] then
						if WDROPS[droplistid].drop[i] == "SCAVENGER" then
							local x, y, z = GetPlayerPos(id);
							for i = 1, WDROPS[droplistid].amount[i] do
								_SpawnNPCpos(Scavenger(), x + math.random(-100, 100), y + math.random(200, 300), z + math.random(-100, 100), GetPlayerWorld(id));
							end
							SendPlayerMessage(id, 252, 129, 129, "Пока вы исследовали сокровищницу на вас напал монстр.")
							--LogString("Logs/Server/WorldContainerOpen","На "..Player[id].nickname.." напал монстр (падальщик) при открытии контейнера в слоте-"..wcid.." ("..WCONT[wcid].sname..") / ".._getRTime());						
						else
							for p = 0, GetMaxPlayers() do
								if Player[p].loggedIn == true and GetPlayerWorld(p) == GetPlayerWorld(id) and GetPlayerVirtualWorld(p) == GetPlayerVirtualWorld(id) then
									if GetDistancePlayers(p, id) < 1300 then
										SendPlayerMessage(p, 154, 255, 120, GetPlayerName(id).." нашел в сокровищнице "..GetItemName(WDROPS[droplistid].drop[i]).." в количестве: "..WDROPS[droplistid].amount[i]);
									end
								end
							end
							GiveItem(id, string.upper(WDROPS[droplistid].drop[i]), WDROPS[droplistid].amount[i]);
							SaveItems(id);
							drops = "";
							--LogString("Logs/Server/WorldContainerOpen",Player[id].nickname.." нашел "..WDROPS[droplistid].drop[i].." при открытии контейнера / ".._getRTime());	
						end
					end
				end
			end

			if drops ~= "" then
				LogString("Logs/Server/WorldContainerOpen",Player[id].nickname.." ничего не нашел при открытии контейнера в слоте-"..wcid.." ("..WCONT[wcid].sname..") / ".._getRTime());	
				LogString("Logs/Server/WorldContainerOpen", "-------------------------------------------------------------------");
				for p = 0, GetMaxPlayers() do
					if Player[p].loggedIn == true and GetPlayerWorld(p) == GetPlayerWorld(id) and GetPlayerVirtualWorld(p) == GetPlayerVirtualWorld(id) then
						if GetDistancePlayers(p, id) < 1300 then
							SendPlayerMessage(p, 154, 255, 120, GetPlayerName(id).." ничего не нашел в сокровищнице. ");
						end
					end
				end
			else
				LogString("Logs/Server/WorldContainerOpen", "-------------------------------------------------------------------");	
			end

			WCONT[wcid].status = 3;
			--Mob.Destroy(WCONT[wcid].mob);
			Player[id].wcid = nil;
		else
			WCONT[wcid].status = 1;
			for p = 0, GetMaxPlayers() do
				_worldContainerUpdateState(p);
			end
		end
	end
end

local wzonetex = CreateTexture(5658.5, 7198.5, 8135, 7627, 'menu_ingame')
function _worldContainerCheckZone()

	for i = 0, GetMaxPlayers() do
		if Player[i].loggedIn == true then
			local x, y, z = GetPlayerPos(i);

			local needPos = nil;
			for k = 1, DROP_LIST_GETN do
				local checkPos = GetDistance3D(x, y, z, WCONT[k].pos[1], WCONT[k].pos[2], WCONT[k].pos[3]);
				if checkPos <= 300 then
					needPos = k;
				end
			end

			if needPos ~= nil then
				local checkPos = GetDistance3D(x, y, z, WCONT[needPos].pos[1], WCONT[needPos].pos[2], WCONT[needPos].pos[3]);
				if checkPos <= 300 then
					Player[i].wzone[1] = true; 
					if Player[i].wzone[1] == true then
						if Player[i].wzone[2] == false then
							Player[i].wcurrent = needPos;
							ShowPlayerDraw(i, Player[i].wdraw);
							_worldContainerUpdateState(i);
							ShowTexture(i, wzonetex);
							Player[i].wzone[2] = true;
						end
					end
				end
			else
				Player[i].wzone[1] = false; 
				if Player[i].wzone[1] == false then
					if Player[i].wzone[2] == true then
						HidePlayerDraw(i, Player[i].wdraw);
						HideTexture(i, wzonetex);
						Player[i].wzone[2] = false;
						Player[i].wcurrent = nil;
					end
				end
			end
		end
	end

end
SetTimer(_worldContainerCheckZone, 1000, 1);

function _worldContainerUpdateState(id)

	if Player[id].wcurrent ~= nil then
		local wcid = Player[id].wcurrent;
		if WCONT[wcid].status == 1 then
			UpdatePlayerDraw(id, Player[id].wdraw, 5771, 7348, "Сокровищница (доступно) / G", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif WCONT[wcid].status == 2 then
			UpdatePlayerDraw(id, Player[id].wdraw, 5771, 7348, "Сокровищница (занята)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif WCONT[wcid].status == 3 then
			UpdatePlayerDraw(id, Player[id].wdraw, 5771, 7348, "Сокровищница (разграблена)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);

		elseif WCONT[wcid].status == 4 then
			UpdatePlayerDraw(id, Player[id].wdraw, 5771, 7348, "Сокровищница (недоступно)", "Font_Old_10_White_Hi.TGA", 255, 255, 255);
		end
	end

end

function _worldContainerRespawn()

	--------------------------------------------------------------------
	-- перезагрузка уже созданных контейнеров (залутанных) в пределе 40 штук.
	local containers = {};
	for i = 1, DROP_LIST_GETN do
		if WCONT[i].mob ~= nil then
			if WCONT[i].status == 3 then
				table.insert(containers, i);
			end
		end
	end

	if table.getn(containers) > 0 then
		for i, v in pairs(containers) do
			if WCONT[v].mob ~= nil then
				WCONT[v].status = 1;
			end
		end
	end
	--------------------------------------------------------------------


end
--SetTimer(_worldContainerRespawn, 3600000, 1); -- респавн раз в час.