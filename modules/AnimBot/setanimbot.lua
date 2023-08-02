function _setAnimToBot(id, params)
    
    if Player[id].astatus > 1 then
        local result, b_id, anim_case = sscanf(params, "ds");
        if result == 1 then
            if IsPlayerConnected(b_id) == 1 then
                if IsNPC(b_id) == 1 then

                    if anim_case == "�����" then
                        PlayAnimation(b_id, "S_GUARDSLEEP")

                    elseif anim_case == "�����" then
                        PlayAnimation(b_id, "T_STAND_2_PEE")
					
					elseif anim_case == "�����" then
                        PlayAnimation(b_id, "T_STAND_2_GUARDSLEEP")
                    
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_GREETRIGHT")
						
					elseif anim_case == "������2" then
                        PlayAnimation(b_id, "T_HGUARD_GREET")
						
					elseif anim_case == "�����3" then
                        PlayAnimation(b_id, "T_HGUARD_LOOKAROUND")
						
					elseif anim_case == "�����" then
                        PlayAnimation(b_id, "T_YES")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "T_GETLOST2")
						
					elseif anim_case == "������������" then
                        PlayAnimation(b_id, "T_1HSINSPECT")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "R_SCRATCHEGG")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "R_SCRATCHHEAD")
						
					elseif anim_case == "������������" then
                        PlayAnimation(b_id, "R_LEGSHAKE")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_BORINGKICK")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_DONTKNOW")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "T_FORGETIT")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_BSANVIL_S1")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_BSSHARP_S1")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_CAULDRON_S1")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "T_PAUKE_S1_2_S0")
						
					elseif anim_case == "�����" then
                        PlayAnimation(b_id, "T_STAND_2_WOUNDED")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_1HSFINISH")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_JOINT_S0_2_STAND")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "T_STAND_2_PRAY")
						
					elseif anim_case == "��������2" then
                        PlayAnimation(b_id, "S_INNOS_S1")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "S_REPAIR_S1")
						
					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "T_1HSFREE")
						
					elseif anim_case == "��" then
                        PlayAnimation(b_id, "T_YES")
						
					elseif anim_case == "���" then
                        PlayAnimation(b_id, "T_NO")
						
					elseif anim_case == "�����" then
                        PlayAnimation(b_id, "T_PLUNDER")
						
					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "T_SEARCH")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_FOOD_S0_2_STAND")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_TREASURE_S2")
						
					elseif anim_case == "���" then
                        PlayAnimation(b_id, "S_LEAN")
						
					elseif anim_case == "���2" then
                        PlayAnimation(b_id, "S_WALL_S1")
						
					elseif anim_case == "����" then
                        PlayAnimation(b_id, "T_POTION_S0_2_STAND")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "T_CHESTSMALL_STAND_2_S0")
						
					elseif anim_case == "����" then
                        PlayAnimation(b_id, "S_IDOL_S1")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_DEAD")
						
					elseif anim_case == "������2" then
                        PlayAnimation(b_id, "T_DEADB")
						
					elseif anim_case == "�����1" then
                        PlayAnimation(b_id, "T_STAND_2_LGUARD")
						
					elseif anim_case == "�����2" then
                        PlayAnimation(b_id, "T_STAND_2_HGUARD")
						
					elseif anim_case == "�����1" then
                        PlayAnimation(b_id, "T_DANCE_01")
						
					elseif anim_case == "�����2" then
                        PlayAnimation(b_id, "T_DANCE_02")
						
					elseif anim_case == "�����3" then
                        PlayAnimation(b_id, "T_DANCE_03")

					elseif anim_case == "�����4" then
                        PlayAnimation(b_id, "T_DANCE_04")
						
					elseif anim_case == "�����5" then
                        PlayAnimation(b_id, "T_DANCE_05")
						
					elseif anim_case == "�����6" then
                        PlayAnimation(b_id, "T_DANCE_06")
						
					elseif anim_case == "�����7" then
                        PlayAnimation(b_id, "T_DANCE_07")
						
					elseif anim_case == "�����8" then
                        PlayAnimation(b_id, "T_DANCE_08")
						
					elseif anim_case == "�����9" then
                        PlayAnimation(b_id, "T_DANCE_09")
						
					elseif anim_case == "���1" then
                        PlayAnimation(b_id, "S_BARRELCONTAINER_S1")
						
					elseif anim_case == "���2" then
                        PlayAnimation(b_id, "R_BARRELCONTAINER_DRINK")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "S_BREATH")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "S_CRY")
						
					elseif anim_case == "���������" then
                        PlayAnimation(b_id, "T_FACEPALM")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_FALLDOWN_QUICK")

					elseif anim_case == "������2" then
                        PlayAnimation(b_id, "T_FALLDOWN_LONG")
						
					elseif anim_case == "�����������" then
                        PlayAnimation(b_id, "T_EXPLOSION_SCARED_HERO")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "T_FINGERSCOUNT_START_GUIDO")
						
					elseif anim_case == "���������" then
                        PlayAnimation(b_id, "S_FIREPLACE")
						
					elseif anim_case == "��" then
                        PlayAnimation(b_id, "S_FIREPLACEOAR_S1")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "T_JON_STANDUP")
						PlayAnimation(b_id, "T_JON_KNEEL")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_KICKOBJECT_S1")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "T_LAUGH")
						
					elseif anim_case == "����" then
                        PlayAnimation(b_id, "S_LOOKOUT")						
						
					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "T_STAND_2_MPRISON")
						
					elseif anim_case == "�" then
                        PlayAnimation(b_id, "S_OCEAN_S1")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "S_SITTIRED_S1")

					elseif anim_case == "�����" then
						Freeze(b_id);
                        PlayAnimation(b_id, "S_SLAVSQUATDIALOGUE")
						
					elseif anim_case == "�����_������" then
                        PlayAnimation(b_id, "T_REMOVE_SLAVSQUATDIALOGUE")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "S_BLOODFLASK_S1")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "S_BOWMAKING_S1")
						
					elseif anim_case == "������������" then
                        PlayAnimation(b_id, "S_CHECKSWD_S1")
						
					elseif anim_case == "������������2" then
                        PlayAnimation(b_id, "S_CHECKSWDV2_S1")
						
					elseif anim_case == "������" then
                        PlayAnimation(b_id, "S_CLEANWALL_S1")
						
					elseif anim_case == "���������" then
                        PlayAnimation(b_id, "T_EXECUTION_S0_2_S1")
						
					elseif anim_case == "��������" then
                        PlayAnimation(b_id, "S_DEPRESSIONSIT")
						
					elseif anim_case == "���������" then
                        PlayAnimation(b_id, "T_Q405_MARVIN_ONKNEE_LOOP_02")
						
					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "T_MARVIN_FLEX_LOOP")
						
					elseif anim_case == "�������" then
                        PlayAnimation(b_id, "T_PISSOFF")

					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "T_STAND_2_SCAREDDIALOGUE")
						PlayAnimation(b_id, "S_SCAREDDIALOGUE")
						PlayAnimation(b_id, "T_REMOVE_SCAREDDIALOGUE")
						
					elseif anim_case == "����������" then
                        PlayAnimation(b_id, "S_SECRETSTOVE_S1")
						
                    end

                else
                    SendPlayerMessage(id, 255, 255, 255, "��� �� ���.")
                end
            else
                SendPlayerMessage(id, 255, 255, 255, "��� �� ������ � �����.")
            end
        else
            SendPlayerMessage(id, 255, 255, 255, "/�_���� (�� ����) (��������)")
        end
    end
end
addCommandHandler({"/�_����"}, _setAnimToBot);
