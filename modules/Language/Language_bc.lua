
--  # Language system by royclapton #
--  #         version: 1.0          #


-- ������� � ��������� ��� ��������������
LANGUAGE_ORCS = {"���","����","�������","�������","����","������","������","��","���","��","���","���","������",
				"������","��","������","���","���","����","�����","���","���","����","���","����-�����", "������-���", "�������",
				"�����","���-������","��-���","�����-���", "�����-�����","������-���","�����","�����","������","�����", "�������",
				"�����", "�����", "���", "����������"};

LANGUAGE_WARANT = {"'ana","'ant","hi","alansan","hassishin","muharib","tariq","ta'akul","yanam","al'atfal","rajul","raba","'asnan",
					"yashrab","dzan","hayit","salaa","alzalam","khafifa","'aerif","sikiyn fi alzuhr","taeraf muqadaman","tashghil bitahawur","fuqdan alruwya",
					"faeal","alqidiys","waeiz","sahir","said","dire","kham","sahar","hadm","yuhraq","nansaa","kun muhibana","dukhan","tibgh","tasrukh","hamsa",
					"ghidha'","sum","an","al","as","fah","lah","nah","la","na","sa","ja","ra","ma"};
					
LANGUAGE_NORDMAR = {"styrke","brann","hammer","malm","sverd","dod","smerte","kjaerlighet","venn","Jeg","du","vi","de","hun","landsby","Rane",
					"sove","bjorn","haeren","hvile","sansene","se","snuse","trampe","handel","vet","dragen","oks","ond","legge"," stridsoksen","lurerpa","hvorfor",
					"forgjeves","skog","is","drikke vann","ol","full","kone","datter","blodfeide","kniv i ryggen","forbannet",
					"glemt","nyheter","ga vekk","lese boker","ga til krig","komme ned","fra fjellet","kjempe til slutten","seirende","kriger","rustning","busk",
					"trylledrikk","suppe","lage grot","gi penger"};

LANGUAGE_WARAN = {"���","���","��","��","���","���","����","����","����","���"};

LANGUAGE_YARKENDAR = {"Ata pai","rongo pai","korero nui","whakapouri","koroua","whawhai","whakanui i nga tikanga","ki te poipoi ringa",
					 "I","koe","ratou","matou","tahu ahi","kei mua","tuhia te heke mai","kaitiaki","toa","hoari","kaiahuwhenua","tohu","reta",
					 "tikanga","moana","nga merekara","tupu ana","pouri","reo","aroha","kirikiri","nikau","ahi"}

LANGUAGE_DEMON = {"ozh","izh","izhai","sa","vu","doq","roq","doz","ahm�","vo�","ashm","vom","hollom","tho","ucha","acha","tak","sek","thok","fek","ses",
				 "nox","hahsh","eyik","gluth","ensh","zomfa","domosh","arkosh","voth","hedoq","nith","safras","lieyev","fol","sav","kish","sof",
				 "Hollom icha fek ozh","Izh sol fek","Sof izh","Izh acha Ozh!","Ozh miskath","Izh vo�acha Ozh","Ensh izh Arkosh, fol","Thal'kituun",
				 "A-rul shach kigon","Anach kyree","Katra zil shukil"}

LANGUAGE_TEMORIS = {"���","��","���","������","�������� ��","���� ��������","������� ����� ����","�������� � ����","�� �� ���� ����� ����",
					"����� ���������","��� � ����","��� �� �����","����� �� ������","�� ���� �� ����� ����� ������","��","��","���","��","��",
					"�������","����","�������","�����","���","��������","����","����","������","��������","�����","���"}			
					
LANGUAGE_GATIA = {"He","jusqu'a","bien","mal","vivre magnifiquement","ville","Detendez-vous","voir","etre amoureux","sorcier","epee","guerrier",
				 "vas en paix","je","toi","nous","elles ou ils","elle","etre ici","baignade","minerai","voleur","criminel","nouvelles",
				 "resoudre des problemes","pour le roi","fumee","boire de la biere","considerer","grenier a foin","travailler sur le terrain",
				 "Loup","detester","sentir","piquer","salete","foret","masquer","armure","Feu","bruler","vetements","chapeau","Commerce",
				 "fixer environ","crier a l'injustice","a'l","an","la","mia","croissant"}

LANGUAGE_AFRO = {"Habari","baadaye","shujaa","upanga","biashara","kuogelea","kupigana","kujua mahali pako","amri","kuhani","mganga","usiku","mwathirika",
				"mtumwa","kazi","kuwa na mapumziko","kumtumikia bwana","kupigania yako","I","wewe","sisi","wao","yeye","kike","Mwanaume","mkokoteni",
			    "meli","kusimama bandarini","biashara ya binadamu","kujua","ugomvi wa damu","walioanguka","moja kwa moja","choma","moto","barafu",
			    "mnyama","mbwa Mwitu","simba","mjusi","kuruka","utumwa","kupanda","ndoto","laana","kupiga kelele","kuvumilia","lofa","ombaomba",
			    "tajiri","mkate","bia","damu","mzimu","samaki","kichwa","kuadhibu","kasia","mrembo","ya kutisha","mzaha","piga","supu","mto","fundisha",
			    "hadithi ya hadithi","kanuni","mwizi","muuaji","msafiri"}


LANGUAGE_MYRTANA = {}; -- reverse

function _languageConnect(id) -- � OnPlayerConnect � ��������� _nameConnect(playerid)

	Player[id]._language_myrtana = 0;
	Player[id]._language_warant = 0;
	Player[id]._language_orcs = 0;
	Player[id]._language_nord = 0;
	Player[id]._language_afro = 0;
	Player[id]._language_gatia = 0;
	Player[id]._language_temoris = 0;
	Player[id]._language_demon = 0;
	Player[id]._language_yarkendar = 0;
	Player[id]._language_waran = 0;

	Player[id]._language_current = "";
	Player[id]._language_text = "";
end

function _languageText(id, text) -- � OnPlayerText (tom.lua) ����� ���� if else end

	if Player[id].loggedIn == true and Player[id].board_write == false and WriteHandscript(id, text) == 0 then
		local cur_lang = Player[id]._language_current;

		if cur_lang == "WARAN" then
			for i = 0, GetMaxPlayers() do
				
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_waran ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� ������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (���� ������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (���� ������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_waran ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� ������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (���� ������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (���� ������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_waran ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� ������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (���� ������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (���� ������)");
					end

				end
			end

		elseif cur_lang == "YARKENDAR" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_yarkendar ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (������)");
						end

					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_yarkendar ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (������)");
						end

					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_yarkendar ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (������)");
						end

					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (������)");
					end

				end
			end

		elseif cur_lang == "DEMON" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_demon ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� �������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (���� �������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (���� �������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_demon ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� �������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (���� �������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (���� �������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_demon ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���� �������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (���� �������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (���� �������)");
					end

				end
			end

		elseif cur_lang == "TEMORIS" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_temoris ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������� ��������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (������� ��������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (������� ��������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_temoris ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������� ��������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (������� ��������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (������� ��������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_temoris ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (������� ��������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (������� ��������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (������� ��������)");
					end

				end
			end

		elseif cur_lang == "GATIA" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_gatia ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (���������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (���������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_gatia ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (���������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (���������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_gatia ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (���������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (���������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (���������)");
					end

				end
			end

		elseif cur_lang == "AFRO" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_afro ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (�����)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (�����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (�����)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_afro ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (�����)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (�����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (�����)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_afro ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.." (�����)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (�����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (�����)");
					end

				end
			end

		elseif cur_lang == "MYRTANA" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_myrtana ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text);
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text);
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_myrtana ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text);
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text);
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_myrtana ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text);
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text);
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				end
			end

		elseif cur_lang == "ORCS" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_orcs ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (���� �����)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (���� �����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (���� �����)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_orcs ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (���� �����)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (���� �����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (���� �����)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_orcs ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (���� �����)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (���� �����)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (���� �����)");
					end

				end
			end

		elseif cur_lang == "WARANT" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_warant ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (����������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_warant ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (����������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_warant ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (����������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (����������)");
					end

				end
			end
			
		elseif cur_lang == "NORDMAR" then
			for i = 0, GetMaxPlayers() do
				if GetDistancePlayers(id, i) < 1000 then
					if Player[i]._language_nord ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 255, 255, 255, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (�����������)");
						else
							SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": "..text.." (�����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 255, 255, 255, GetPlayerName(id)..": ".._languageCode(id).." (�����������)");
					end

				elseif GetDistancePlayers(id, i) > 999 and GetDistancePlayers(id, i) < 1300 then
					if Player[i]._language_nord ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 170, 170, 170, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (�����������)");
						else
							SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": "..text.." (�����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 170, 170, 170, GetPlayerName(id)..": ".._languageCode(id).." (�����������)");
					end

				elseif GetDistancePlayers(id, i) > 1299 and GetDistancePlayers(id, i) < 1500 then
					if Player[i]._language_nord ~= 0 then
						if Player[id].zvanie ~= nil then
							SendPlayerMessage(i, 110, 110, 110, Player[id].zvanie.." "..GetPlayerName(id)..": "..text.. " (�����������)");
						else
							SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": "..text.." (�����������)");
						end
					else
						Player[id]._language_text = text;
						SendPlayerMessage(i, 110, 110, 110, GetPlayerName(id)..": ".._languageCode(id).." (�����������)");
					end

				end
			end
		end

		local time = os.date('*t');
	    local ryear = time.year;
		local rmonth = time.month;
		local rday = time.day;
		local rhour = string.format("%02d", time.hour);
		local rminute = string.format("%02d", time.min);
		local txt = GetPlayerName(id).." ������: "..text.." ("..Player[id]._language_current..")";
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear..") "..txt);

	end		

end


function _languageCode(id) -- ������� �������������� �����.

	local newText = "";
	local message = Player[id]._language_text;

	if Player[id]._language_current == "ORCS" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 5 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_ORCS[math.random(#LANGUAGE_ORCS)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 5 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_ORCS[math.random(#LANGUAGE_ORCS)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 5 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_ORCS[math.random(#LANGUAGE_ORCS)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "WARANT" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_WARANT[math.random(#LANGUAGE_WARANT)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_WARANT[math.random(#LANGUAGE_WARANT)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_WARANT[math.random(#LANGUAGE_WARANT)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	
	elseif Player[id]._language_current == "NORDMAR" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_NORDMAR[math.random(#LANGUAGE_NORDMAR)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_NORDMAR[math.random(#LANGUAGE_NORDMAR)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_NORDMAR[math.random(#LANGUAGE_NORDMAR)]
					newText = newText..word;
				end
			end
			return newText;
		end
		
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "MYRTANA" then
		return string.reverse(message);

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "WARAN" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_WARAN[math.random(#LANGUAGE_WARAN)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_WARAN[math.random(#LANGUAGE_WARAN)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_WARAN[math.random(#LANGUAGE_WARAN)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "YARKENDAR" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_YARKENDAR[math.random(#LANGUAGE_YARKENDAR)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_YARKENDAR[math.random(#LANGUAGE_YARKENDAR)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_YARKENDAR[math.random(#LANGUAGE_YARKENDAR)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "DEMON" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_DEMON[math.random(#LANGUAGE_DEMON)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_DEMON[math.random(#LANGUAGE_DEMON)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_DEMON[math.random(#LANGUAGE_DEMON)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "GATIA" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_GATIA[math.random(#LANGUAGE_GATIA)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_GATIA[math.random(#LANGUAGE_GATIA)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_GATIA[math.random(#LANGUAGE_GATIA)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "TEMORIS" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_TEMORIS[math.random(#LANGUAGE_TEMORIS)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_TEMORIS[math.random(#LANGUAGE_TEMORIS)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_TEMORIS[math.random(#LANGUAGE_TEMORIS)]
					newText = newText..word;
				end
			end
			return newText;
		end

	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------
	--------------------------------------------------------------------------------------------------------------------

	elseif Player[id]._language_current == "AFRO" then
		if string.len(message) > 5 and string.len(message) < 20 then
			local message_len = string.len(message) / 3;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_AFRO[math.random(#LANGUAGE_AFRO)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) > 19 then
			local message_len = string.len(message) / 4;
			for i = 1, message_len do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= message_len then
					local word = LANGUAGE_AFRO[math.random(#LANGUAGE_AFRO)]
					newText = newText..word;
				end
			end
			return newText;

		elseif string.len(message) <= 5 then
			for i = 1, string.len(message) do
				local rnd = math.random(1, 10);
				if rnd < 6 then
					newText = newText.." ";
				end

				if string.len(newText) ~= string.len(message) then
					local word = LANGUAGE_AFRO[math.random(#LANGUAGE_AFRO)]
					newText = newText..word;
				end
			end
			return newText;
		end

	end
end

function _saveLang(id) -- � Registration.lua (func: AllSave) + ������� �����, ����� ��������� ����: Database/Players/Language

	local file = io.open("Database/Players/Language/"..Player[id].nickname..".txt", "w+")
	file:write(Player[id]._language_current.."\n");
	file:write(Player[id]._language_myrtana.."\n");
	file:write(Player[id]._language_warant.."\n");
	file:write(Player[id]._language_orcs.."\n");
	file:write(Player[id]._language_nord.."\n");
	file:write(Player[id]._language_afro.."\n");
	file:write(Player[id]._language_gatia.."\n");
	file:write(Player[id]._language_temoris.."\n");
	file:write(Player[id]._language_demon.."\n");
	file:write(Player[id]._language_yarkendar.."\n");
	file:write(Player[id]._language_waran.."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0".."\n");
	file:write("0");
	file:close();

end

function _readLang(id) -- � Login.lua (func: logged)

	local file = io.open("Database/Players/Language/"..Player[id].nickname..".txt", "r")
	if file then
		line = file:read("*l");
		local result, lng = sscanf(line, "s");
		if result == 1 then
			Player[id]._language_current = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_myrtana = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_warant = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_orcs = lng;
		end
		
		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_nord = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_afro = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_gatia = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_temoris = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_demon = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_yarkendar = lng;
		end

		line = file:read("*l");
		local result, lng = sscanf(line, "d");
		if result == 1 then
			Player[id]._language_waran = lng;
		end

		file:close();
	end

end

function _aGiveLang(id, sets) -- ������� ������ �����

	if Player[id].astatus > 2 then
		local result, pid, lang, par = sscanf(sets, "dsd");
		if result == 1 then
			if Player[pid].loggedIn == true and IsPlayerConnected(pid) == 1 then
				if lang == "���" or lang == "orc" then
					if par > 0 then
						Player[pid]._language_orcs = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� �����.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ����� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_orcs = par;
						Player[pid]._language_current = "MYRTANA";
						Player[pid]._language_myrtana = 1;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� �����.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ����� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "���" or lang == "war" then
					if par > 0 then
						Player[pid]._language_warant = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_warant = par;
						Player[pid]._language_current = "MYRTANA";
						Player[pid]._language_myrtana = 1;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "���" or lang == "myr" then
					if par > 0 then
						Player[pid]._language_myrtana = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_myrtana = par;
						Player[pid]._language_current = "WARANT";
						Player[pid]._language_warant = 1;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ������� � ������ "..GetPlayerName(pid)..".")
					end
					
				elseif lang == "����" or lang == "nord" then
					if par > 0 then
						Player[pid]._language_nord = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� ��������")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� �������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_nord = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "���� ������" or lang == "waran" then
					if par > 0 then
						Player[pid]._language_waran = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� ���� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ���� �������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_waran = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� ���� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ���� �������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "��" or lang == "afro" then
					if par > 0 then
						Player[pid]._language_afro = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� ����� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ����� �������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_afro = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� ����� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ����� �������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "�����" or lang == "gatia" then
					if par > 0 then
						Player[pid]._language_gatia = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� �����.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ����� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_gatia = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� �����.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ����� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "�������" or lang == "temoris" then
					if par > 0 then
						Player[pid]._language_temoris = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� �������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_temoris = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� ��������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "�����" or lang == "demon" then
					if par > 0 then
						Player[pid]._language_demon = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ������� ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_demon = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� �������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ������� � ������ "..GetPlayerName(pid)..".")
					end

				elseif lang == "������" or lang == "yarken" then
					if par > 0 then
						Player[pid]._language_yarkendar = par;
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� ������ ���� ������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������ ���� ������ ������ "..GetPlayerName(pid)..".")
					else
						Player[pid]._language_yarkendar = par;
						Player[pid]._language_current = "MYRTANA";
						_saveLang(pid);
						SendPlayerMessage(pid, 255, 255, 255, "������ �� �� ������ ���� ������.")
						SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� ������ � ������ "..GetPlayerName(pid)..".")
					end
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "����� �� ������������� ��� �� ������.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "/�_���� (��) (����) (��������)");
			SendPlayerMessage(id, 255, 255, 255, "��������� �����: ���, ���, ���, ����, �����, �����, �������, �����, ��, ���� ������");
		end
	end
end
addCommandHandler({"/�_����", "/a_lang"}, _aGiveLang);


function _moveLanguage(id, sets) -- ������� ����� �����.

	local result, lang = sscanf(sets, "s");
	if result == 1 then
		if Player[id].loggedIn == true then

			if lang == "���" or lang == "orc" then
				if Player[id]._language_orcs ~= 0 then
					Player[id]._language_current = "ORCS";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ���� �����.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "�����" or lang == "yarken" then
				if Player[id]._language_yarkendar ~= 0 then
					Player[id]._language_current = "YARKENDAR";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ���������� ���� ������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "�������" or lang == "temoris" then
				if Player[id]._language_temoris ~= 0 then
					Player[id]._language_current = "TEMORIS";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ������� ��������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "�����" or lang == "gatia" then
				if Player[id]._language_gatia ~= 0 then
					Player[id]._language_current = "GATIA";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ���������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "��" or lang == "afro" then
				if Player[id]._language_afro ~= 0 then
					Player[id]._language_current = "AFRO";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ������� ����� ��������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "�����" or lang == "demon" then
				if Player[id]._language_demon ~= 0 then
					Player[id]._language_current = "DEMON";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ���������� ���� �������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "����" or lang == "waran" then
				if Player[id]._language_waran ~= 0 then
					Player[id]._language_current = "WARAN";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ���������� ���� ���� ��������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "���" or lang == "war" then
				if Player[id]._language_warant ~= 0 then
					Player[id]._language_current = "WARANT";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ����������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end


			elseif lang == "���" or lang == "myr" then
				if Player[id]._language_myrtana ~= 0 then
					Player[id]._language_current = "MYRTANA";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� ����������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end

			elseif lang == "����" or lang == "����" then
				if Player[id]._language_nord ~= 0 then
					Player[id]._language_current = "NORDMAR";
					_saveLang(id);
					SendPlayerMessage(id, 255, 255, 255, "�� ������� ���� �� �����������.")
				else
					SendPlayerMessage(id, 255, 255, 255, "�� �� ������ ���� ����.")
				end
			else
				SendPlayerMessage(id, 255, 255, 255, "��������� �����: ���, ���, ���, ����, �����, �������, �����, ��, ����, ������");
			end
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/���� (����)");
		SendPlayerMessage(id, 255, 255, 255, "��������� �����: ���, ���, ���, ����, �����, �������, �����, ��, ����, ������");
	end

end
addCommandHandler({"/����", "/lang"}, _moveLanguage);