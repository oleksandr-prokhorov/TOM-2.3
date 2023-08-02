
function _checkFightMode(pid, kid) -- pid - жертва, kid - убийца (наносящий урон)

    if Player[kid]._weaponMode == 5 or Player[kid]._weaponMode == 6 then -- если текущий режим боя лук/арбалет       
		local x1, y1, z1 = GetPlayerPos(pid); -- получаем координаты жертвы.
        local x2, y2, z2 = GetPlayerPos(kid); -- получаем координаты нападающего
        if GetDistance3D(x1, y1, z1, x2, y2, z2) < 600 then -- если дистанция между игроками меньше чем 600
            SetPlayerWeaponMode(kid, 0); -- устанавливаем режим боя 0 (вне боевой стойки)
            PlayAnimation(kid, "T_FALLDOWN_QUICK"); -- анимация падения
            GameTextForPlayer(kid, 3500, 4096, "Нельзя использовать дальнобой вблизи", "Font_Old_20_White_Hi.TGA", 255, 255, 255, 500);
        end
    end

end