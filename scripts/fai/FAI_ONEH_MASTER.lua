function FAI_ONEH_MASTER(player)
    if FAI_CheckPlayerHealth(player) == true then
        return
    end

    if GetPlayerWeaponMode(player.ID) ~= player.WeaponMode then
        SetPlayerWeaponMode(player.ID, player.WeaponMode)
    end

    -- Remove all invisible enemies.
    if #player["ENEMY"] == 0 then
        FAI_AllEnemysRemoved(player)
        player.NEXTMOVES = {}

        -- Avoid endless loop of some animations like running. Such animation only stop by another animation.
        PlayAnimation(player.ID, aniHelper("S", player.WeaponMode, "RUN"))
        --SetPlayerPos(player.ID, player.spawnx, player.spawny, player.spawnz);

        if player.daily_routine ~= nil then
            Reset_TA(player.ID);
            --SetPlayerPos(player.ID, player.spawnx, player.spawny, player.spawnz);

        elseif player.LASTWP ~= nil then
           -- AI_GOTO_NOW(player.ID, player.LASTWP);
           -- AI_STOP_NOW(player.ID, 10);

        end
    end

	if player.ENEMY[1] ~= nil then
		-- checke Spieler in der Nï¿½he
		for _, val in pairs(player["TARGETS"]) do
			local aitarget = GetPlayerOrNPC(val)
			if aitarget and aitarget.GP_IsDead == 0 and aitarget.GP_IsUnconscious == 0 and GetGuildAttitude(player, aitarget) == AI_ATTITUDE_HOSTILE and aitarget.Invisible == false then
				local dist = GetDistancePlayers(player.ID, val)
				if dist < player.Aivars["MaxWarnDistance"] then
					SetEnemy(player.ID, val)
				end
			end
		end
	end

	-- Kriege nï¿½chsten Feind
    local shortestRangePlayer = nil
    local r = nil
    for key,val in ipairs(player["ENEMY"]) do -- val = playerid des Gegners
        local dist = GetDistancePlayers(player.ID, val)
        if r == nil or dist < r then
            r = dist
            shortestRangePlayer = val
        end

        if _M_OLDHP[player.ID].timer == nil then
            if dist >= 900 then -- HERE
                table.remove(player["ENEMY"], key);
                if next(player.ENEMY) == nil then
                    FAI_AllEnemysRemoved(player);
                    --PlayAnimation(player.ID, "T_PERCEPTION");
                    player.ENEMY = {};
                    player.NEXTMOVES = {}
                    --if(player.daily_routine ~= nil)then
                        Reset_TA(player.ID);
                    --elseif(player.LASTWP ~= nil)then
                        --AI_GOTO_NOW(player.ID, player.LASTWP);
                        --AI_STOP_NOW(player.ID, 10);
                    --end
                    SetPlayerPos(player.ID, player.spawnx, player.spawny, player.spawnz);
                    for i = 1, 3 do
                        PlayAnimation(player.ID, "S_RUN");
                    end
                    return;
                end
            end
        end
    end
    
    if FAI_UPDATE_NEXTMOVES(player) then
        return
    end

    if player.Aivars["Flee"] == true then
        if player.Aivars["FleeRoute"]==nil then
            player.Aivars["FleeStartWP"] = AI_WayNets[player.GP_World]:GetNearestWP(player.ID)
            player.Aivars["FleeEndWP"] = AI_WayNets[player.GP_World]:GetRandomWaypoint()
            player.Aivars["FleeWPIndex"] = 1
            player.Aivars["FleeRoute"] = AI_WayNets[player.GP_World]:GetWayRoute(player.Aivars["FleeStartWP"], player.Aivars["FleeEndWP"])
            player.LastPosUpdate = 0
            setPlayerWalkType(player.ID, 1)
        end
        if player.Aivars["FleeRoute"]==nil then
            turnPlayer(player.ID, GetAngleToPlayer(player.ID,player.ENEMY[1]) + 180)
            table.insert(player.NEXTMOVES, {type=1, anim="S_FISTRUNL"})
            table.insert(player.NEXTMOVES, {type=2, waittime=150}) -- Testen wozu der Wert gut is, original 500
        else
            local _x = player.Aivars["FleeRoute"][player.Aivars["FleeWPIndex"]].x
            local _y = player.Aivars["FleeRoute"][player.Aivars["FleeWPIndex"]].y
            local _z = player.Aivars["FleeRoute"][player.Aivars["FleeWPIndex"]].z

            if gotoPosition(player.ID, _x, _y, _z) then
                player.Aivars["FleeWPIndex"] = player.Aivars["FleeWPIndex"] + 1
                if player.Aivars["FleeRoute"][player.Aivars["FleeWPIndex"]] == nil then
                    player.Aivars["FleeRoute"] = nil
                end
            end
        end
        return
    end

    if player.ENEMY[1] == nil then
        return
    end

	-- Tausche player.ENEMY[1] mit demjenigen, der am nï¿½chsten steht aka Targetchange
	if shortestRangePlayer ~= player.ENEMY[1] then
		for key, val in ipairs(player["ENEMY"]) do
			if val == shortestRangePlayer then
				player.ENEMY[key] = player.ENEMY[1]
				player.ENEMY[1] = shortestRangePlayer
				break
			end
		end
    end

    local AttackRange = 300
    if player.Aivars["ATTACKRANGE"] ~= nil then
        AttackRange = player.Aivars["ATTACKRANGE"]
    end

    -- Distanz zwischen Monster und Spieler > Attack Range....
    player.attackInterruptable = true
    if GetDistancePlayers(player.ID, player.ENEMY[1]) > AttackRange then
        if player.Aivars["RUNMODE"] ~= nil and player.Aivars["RUNMODE"] == 0 then
            table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "WALKL")})
        else
            table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "RUNL")})
        end
    else
        -- Distanz zwischen Monster und Spieler < Attack Range....
        local dangle = GetPlayerAngle(player.ID) - GetAngleToPlayer(player.ID, player.ENEMY[1]); -- Angle vom Monster - Angle vom Monster zum Spieler
        local timeToWait = 2000 -- Milliseconds to wait for the next attack
        local enemyWeaponMode = GetPlayerWeaponMode(player.ENEMY[1])
        if enemyWeaponMode == WEAPON_BOW or enemyWeaponMode == WEAPON_CBOW or enemyWeaponMode == WEAPON_MAGIC then
            timeToWait = timeToWait * 0.75 -- Attack more often against ranged enemies
        end
        if dangle > -20 and dangle < 20 and math.abs(GetTickCount() - player.attackWait) > timeToWait then
            -- Instant attack!
            if string.find(GetPlayerAnimationName(player.ENEMY[1]), "PARADE") then
                GameTextForPlayer(player.ENEMY[1], 500, 6000, "Âû óêëîíèëèñü!", "Font_Old_10_White_Hi.TGA", 255, 128, 128, 1000);     
            else
                player.attackInterruptable = false
                turnPlayer(player.ID, GetAngleToPlayer(player.ID, player.ENEMY[1]))
                PlayAnimation(player.ID, aniHelper("T", player.WeaponMode, "ATTACKL"))
    			if IsNPC(player.ID) == 1 and IsNPC(player.ENEMY[1]) == 1 then
    				local hp = GetPlayerHealth(player.ENEMY[1]) - GetPlayerStrength(player.ID)
    				if hp < 0 then
    					hp = 0
    				end
    				SetPlayerHealth(player.ENEMY[1], hp)
    				OnPlayerHit(player.ENEMY[1], player.ID)
    			else
    				HitPlayer(player.ID, player.ENEMY[1])
    			end
                player.attackWait = GetTickCount()
            
                table.insert(player.NEXTMOVES, {type=2, waittime=200})
                table.insert(player.NEXTMOVES, {type=3, anim=aniHelper("T", player.WeaponMode, "ATTACKR"), victim=player.ENEMY[1]})
                table.insert(player.NEXTMOVES, {type=2, waittime=200})
                table.insert(player.NEXTMOVES, {type=3, anim=aniHelper("S", player.WeaponMode, "ATTACK"), victim=player.ENEMY[1]})
                table.insert(player.NEXTMOVES, {type=2, waittime=300})
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "RUN")})
            end
        elseif GetDistancePlayers(player.ID, player.ENEMY[1]) < AttackRange - 150 then
            -- When AI is to near to player, quick evade.
            table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "PARADEJUMPB")})
            table.insert(player.NEXTMOVES, {type=2, waittime=200})
        else
            local random = math.random()
            if random < 0.2 then
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "PARADEJUMPB")})
                table.insert(player.NEXTMOVES, {type=2, waittime=500})
            elseif random <= 0.3 then
                local pangle = GetAngleToPlayer(player.ID, player.ENEMY[1])
                if pangle > 180 then
                    -- Spieler steht links vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFER")})
                    table.insert(player.NEXTMOVES, {type=2, waittime=300})
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFER")})
                else
                    -- Spieler steht rechts vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFEL")})
                    table.insert(player.NEXTMOVES, {type=2, waittime=300})
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFEL")})
                end
                table.insert(player.NEXTMOVES, {type=2, waittime=400})
            elseif random <= 0.4 then
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "PARADEJUMPB")})
                table.insert(player.NEXTMOVES, {type=2, waittime=500})
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "PARADEJUMPB")})
                table.insert(player.NEXTMOVES, {type=2, waittime=300})
            elseif random <= 0.5 and dangle > -20 and dangle < 20 then
                -- Run behind enemy, turn and eventually attack
                if GetAngleToPlayer(player.ID, player.ENEMY[1]) > 180 then
                    -- Spieler steht links vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFER")})
                else
                    -- Spieler steht rechts vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFEL")})
                end
                table.insert(player.NEXTMOVES, {type=2, waittime=200})
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "RUNL")})
                table.insert(player.NEXTMOVES, {type=2, waittime=500})

                player.attackWait = player.attackWait - timeToWait * 0.5 -- Higher chance to attack
                player.attackInterruptable = false
            elseif random < 0.7 and dangle > -20 and dangle < 20 then
                -- Run to side and eventually attack
                if GetAngleToPlayer(player.ID, player.ENEMY[1]) > 180 then
                    -- Spieler steht links vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFER")})
                else
                    -- Spieler steht rechts vom Monster
                    table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("T", player.WeaponMode, "RUNSTRAFEL")})
                end
                table.insert(player.NEXTMOVES, {type=2, waittime=200})
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "RUNL")})
                table.insert(player.NEXTMOVES, {type=2, waittime=100})

                player.attackWait = player.attackWait - timeToWait * 0.3 -- Higher chance to attack
                player.attackInterruptable = false
            else
                -- Do nothing
                table.insert(player.NEXTMOVES, {type=1, anim=aniHelper("S", player.WeaponMode, "RUN")})
                table.insert(player.NEXTMOVES, {type=2, waittime=500})
            end
		end
    end
    turnPlayer(player.ID, GetAngleToPlayer(player.ID, player.ENEMY[1]))
end

