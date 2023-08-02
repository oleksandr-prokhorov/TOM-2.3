function InitMainNPC()

    local world = "FULLWORLD2.ZEN";
    

    for i = 1, 2 do
        print("=================");
    end
    print(" ")
    print("WOOOOOOOOOOLF")
    print(" ")
    for i = 0, 34 do
        local point = "WOLF_"..i;
        SpawnNPC(Wolf(), point, world);
    end

    print(" ")
    print("SCAVENGER")
    print(" ")
    for i = 0, 49 do
        local point = "SCAVENGER_"..i;
        SpawnNPC(Scavenger(), point, world);
    end

    print(" ")
    print("MOLERAT")
    print(" ")
    for i = 0, 26 do
        local point = "MOLERAT_"..i;
        SpawnNPC(Molerat(), point, world);
    end
	
    print(" ")
    print("GOBBO")
    print(" ")
    for i = 0, 16 do
        local point = "GOBBO_"..i;
        SpawnNPC(Gobbo_Green(), point, world);
    end

    print(" ")
    print("BLOODFLY")
    print(" ")
    for i = 0, 15 do
        local point = "BLOODFLY_"..i;
		if i ~= 6 and i ~= 7 and i ~= 8 then
			SpawnNPC(Bloodfly(), point, world);
		end
    end
	
	print(" ")
    print("SHADOWBEAST")
    print(" ")
    for i = 1, 1 do
        local point = "SHADOWBEAST_"..i;
        SpawnNPC(Shadowbeast(), point, world);
    end

    for i = 1, 2 do
        print("=================");
    end

end