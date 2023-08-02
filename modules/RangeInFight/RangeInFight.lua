
function _checkFightMode(pid, kid) -- pid - ������, kid - ������ (��������� ����)

    if Player[kid]._weaponMode == 5 or Player[kid]._weaponMode == 6 then -- ���� ������� ����� ��� ���/�������       
		local x1, y1, z1 = GetPlayerPos(pid); -- �������� ���������� ������.
        local x2, y2, z2 = GetPlayerPos(kid); -- �������� ���������� �����������
        if GetDistance3D(x1, y1, z1, x2, y2, z2) < 600 then -- ���� ��������� ����� �������� ������ ��� 600
            SetPlayerWeaponMode(kid, 0); -- ������������� ����� ��� 0 (��� ������ ������)
            PlayAnimation(kid, "T_FALLDOWN_QUICK"); -- �������� �������
            GameTextForPlayer(kid, 3500, 4096, "������ ������������ ��������� ������", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
        end
    end

end