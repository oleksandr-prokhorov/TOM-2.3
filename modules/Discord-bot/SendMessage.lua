
function _discordRegularSM()
	
	local go = false;
	local file = io.open("Database/Discord/sendMessage", "r");
	if file then
		local txt = "";
		str = file:read("*l");
		if str then
			local l, text = sscanf(str, "s")
			if l == 1 then
				txt = text;
			end
			file:close();
			os.remove("Database/Discord/sendMessage");
			go = true;
		end
		
		if go == true then
			SendMessageToAll(0, 0, 0, " ");
			SendMessageToAll(187, 105, 255, "(Gothic Online) Объявление: "..txt);
			SendMessageToAll(0, 0, 0, " ");
			go = false;
		end
		
	end

end
SetTimer(_discordRegularSM, 3000, 1);