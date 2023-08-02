
--  #   AnimMSG system by royclapton  #
--  #           version: 1.0          #

local beckon = {"������", "������", "�������", "�����", "�����"};
local indicated = {"������", "������", "������� � "};
local look = {"�����������", "������������", "��������", "������������", "����������", "��������� �� ��������", "�����������"};
local joint = {"�����������", "�����������", "���������", "����� ����", "������ ���", "�����", "����������", "�������", "���������", "����"}

function _findAnim(id, text)
	
	if Player[id].mine == 0 then
	
		local lower_text = string.lower(text);

		for i = 1, table.getn(beckon) do
			if string.find(lower_text, beckon[i]) then
				PlayAnimation(id, "T_YES")
				break
			end
		end

		for i = 1, table.getn(joint) do
			if string.find(lower_text, joint[i]) then
				PlayAnimation(id, "T_JOINT_S0_2_STAND")
				break
			end
		end

		for i = 1, table.getn(indicated) do
			if string.find(lower_text, indicated[i]) then
				PlayAnimation(id, "T_GETLOST2")
				break
			end
		end
		

		for i = 1, table.getn(look) do
			if string.find(lower_text, look[i]) then
				PlayAnimation(id, "T_SEARCH");
				break
			end
		end
		
	end

end