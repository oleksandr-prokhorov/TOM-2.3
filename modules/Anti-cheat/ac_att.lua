
--  # AC stats (attributes) (files) by royclapton #
--  #                version: 0.1                 #
--  #                    lite                     #

-- � ����� � � ���

function _ac_att_connect(id)
	Player[id]._ac_stats = false;
end

function _onAC(id)
	Player[id]._ac_stats = true;
end

function _offAC(id)
	Player[id]._ac_stats = false;
end

function _ac_ChangeStrength(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
	
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." ������� ���� �� "..newValue..", ���� � ��: "..Player[id].str.." ("..oldValue..") / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "���������� ������������ � ��������� ���� ���������! �������� �� ��: "..Player[id].str.." / � ����: "..newValue);
					SendPlayerMessage(id, 255, 255, 255, "�� �������� �� ��������� ��������.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." ������� �� ������������� ����� (��������� ������������� - ����).");
					end
					Ban(id);
				end
			end
		end

	end]]


end

function _ac_ChangeDexterity(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
		
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." ������� �������� �� "..newValue..", ���� � ��: "..Player[id].dex.." ("..oldValue..") / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "���������� ������������ � ��������� �������� ���������! �������� �� ��: "..Player[id].dex.." / � ����: "..newValue);
					SendPlayerMessage(id, 255, 255, 255, "�� �������� �� ��������� ��������.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." ������� �� ������������� ����� (��������� ������������� - ��������).");
					end
					Ban(id);
				end
			end
		end

	end]]

end

function _ac_ChangeAcrobatic(id, newValue, oldValue)

	--[[if newValue ~= oldValue then
	
		if IsNPC(id) == 0 then
			if Player[id].loggedIn == true then
				local time = os.date('*t');
			    local ryear = time.year;
				local rmonth = time.month;
				local rday = time.day;
				local rhour = string.format("%02d", time.hour);
				local rminute = string.format("%02d", time.min);

				if Player[id]._ac_stats == true then
					LogString("Logs/AC/ac_att", Player[id].nickname.." ������� ����� ����������. / "..rhour..":"..rminute.." "..rday.."."..rmonth.."."..ryear);
					SendPlayerMessage(id, 255, 255, 255, "��������� ����� ���������� (�� ������� ��������).");
					SendPlayerMessage(id, 255, 255, 255, "�� �������� �� ��������� ��������.")
					for i = 0, GetMaxPlayers() do
						SendPlayerMessage(i, 247, 77, 77, Player[id].nickname.." ������� �� ������������� ����� (��������� ����������).");
					end
					Ban(id);
				end
			end
		end
	
	end]]

end