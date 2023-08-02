


function CMD_ME(playerid, params)	
	
	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	
		local txt = "";
		if Player[playerid].masked == false then
			txt = GetPlayerName(playerid).." "..msg;
		else
			txt = "Неизвестный ("..playerid.."): "..msg;
		end

		local world = GetPlayerWorld(playerid);
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid,i) <= 1500 then
				if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
					SendPlayerMessage(i, 218,165,32, txt);
				end   
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/я (действие от 1 лица)");
	end
end
addCommandHandler({"/я"}, CMD_ME)


function CMD_OOC(playerid, params)
	
	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
    if result == 1 then
    	if OOC_STATUS == true then
		
			local txt = "";
			if Player[playerid].masked == false then
				txt = "(( "..GetPlayerName(playerid)..": "..msg.." ))";
			else
				txt = "(( Неизвестный ("..playerid.."): "..msg.." ))";
			end
			
			local world = GetPlayerWorld(playerid);

			for i = 0, GetMaxPlayers() - 1 do
				if GetDistancePlayers(playerid, i) <= 1500 then
					if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
						SendPlayerMessage(i, 255, 255, 0, txt);       
					end
				end
			end
			LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
		else
			SendPlayerMessage(playerid, 255, 255, 255, "ООС-чат отключен администрацией.")
		end
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/о (внеролевая информация)");
	end
	
end
addCommandHandler({"/о"}, CMD_OOC)



function CMD_DO(playerid, params)


	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	
		local txt = "";
		if Player[playerid].masked == false then
			txt = msg.." # "..GetPlayerName(playerid);
		else
			txt = msg.." # Неизвестный ("..playerid..")";
		end

		local world = GetPlayerWorld(playerid);
	
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 2000 then
				if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
					SendPlayerMessage(i, 51,153,255, txt);         
				end
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/до (информация от 3 лица)");
	end

end
addCommandHandler({"/до"}, CMD_DO)

function CMD_M(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	    if result == 1 then
	    local txt = "(Мысли) "..GetPlayerName(playerid)..") "..msg;

	    local world = GetPlayerWorld(playerid);

		for i = 0, GetMaxPlayers() do
			if GetDistancePlayers(playerid, i) <= 1400 and Player[i].astatus > 0 then
				if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
					SendPlayerMessage(i, 210, 217, 169, txt);    
				end  
			end
		end
		SendPlayerMessage(playerid, 210, 217, 169, txt);
		
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/м (мысли персонажа)");
	end
		
end
addCommandHandler({"/м"}, CMD_M)


function CMD_SH(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	if result == 1 then
	    
		local txt = "";
		if Player[playerid].masked == false then
			txt = "(Шепот) "..GetPlayerName(playerid)..": "..msg;
		else
			txt = "(Шепот) Неизвестный ("..playerid.."): "..msg;
		end

		local world = GetPlayerWorld(playerid);
		
		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 250 then
				if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
					SendPlayerMessage(i, 134, 150, 206, txt);       
				end  
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 209, 222,"/ш (шепот)");
	end

end
addCommandHandler({"/ш"}, CMD_SH)

function CMD_K(playerid, params)

	local result, text = sscanf(params, "s");
	local time = os.date('*t');
    local ryear = time.year;
	local rmonth = time.month;
	local rday = time.day;
	local rhour = string.format("%02d", time.hour);
	local rminute = string.format("%02d", time.min);

	local result, msg = sscanf(params,"s");
	    if result == 1 then
	    
		local txt = "";
		if Player[playerid].masked == false then
			txt = GetPlayerName(playerid).." крикнул: "..msg;
		else
			txt = "Неизвестный ("..playerid..") крикнул: "..msg;
		end
		
		local world = GetPlayerWorld(playerid);

		for i = 0, GetMaxPlayers() - 1 do
			if GetDistancePlayers(playerid, i) <= 4000 then
				if GetPlayerWorld(i) == world and GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) then
					SendPlayerMessage(i, 255, 36, 0, txt);   
				end      
			end
		end
		LogString("Logs/Chats/All", "("..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear.."): "..txt);
	else
		SendPlayerMessage(playerid, 255, 36, 0,"/к (крик)");
	end
	
end
addCommandHandler({"/к"}, CMD_K)

function _shId(id, sets)

	local cmd, pid, text = sscanf(sets, "ds");
	if cmd == 1 then
		if Player[pid].loggedIn == true then
			local x1, y1, z1 = GetPlayerPos(id); local x2, y2, z2 = GetPlayerPos(pid);
			if GetDistance3D(x1, y1, z1, x2, y2, z2) < 300 then
				SendPlayerMessage(pid, 134, 150, 206, GetPlayerName(id).." прошептал вам: "..text);
				SendPlayerMessage(id, 134, 150, 206, "Вы прошептали "..GetPlayerName(pid)..": "..text);
				for i = 0, GetMaxPlayers() do
					local x, y, z = GetPlayerPos(i);
					if GetDistance3D(x, y, z, x1, y1, z1) < 700 then
						SendPlayerMessage(i, 134, 150, 206, GetPlayerName(id).." что-то прошептал игроку "..GetPlayerName(pid))
					end
				end
				LogString("Logs/Chats/All", "( "..GetPlayerName(id).." личный шепот): "..text.." / ".._getRTime());
			else
				SendPlayerMessage(id, 255, 255, 255, "Игрок далеко от вас.")
			end
		else
			SendPlayerMessage(id, 255, 255, 255, "Игрок не авторизирован.")
		end
	else
		SendPlayerMessage(id, 255, 255, 255, "/ш_ид (ид) (текст)")
	end

end
addCommandHandler({"/ш_ид"}, _shId);