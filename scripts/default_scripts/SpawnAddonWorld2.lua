
function InitAWNpc()

    local world = "ADDONWORLD2.ZEN";
    
    for i = 0, 10 do
        local point = "ORCROAMER_"..i;
        SpawnNPC(OrcRoamer(), point, world);
    end
	
	for i = 0, 3 do
        local point = "ORCSHAMAN_"..i;
        SpawnNPC(OrcShaman(), point, world);
    end

	for i = 0, 12 do
        local point = "ORCWARRIOR_"..i;
        SpawnNPC(OrcWarrior(), point, world);
    end
	
	for i = 0, 2 do
        local point = "ORCELITE_"..i;
        SpawnNPC(OrcElite(), point, world);
    end
	
	for i = 0, 9 do
        local point = "SAVAGE_"..i;
        SpawnNPC(Savage(), point, world);
    end
	
	for i = 0, 36 do
        local point = "MINECRAWLER_"..i;
        SpawnNPC(MineCrawler(), point, world);
    end
	
	for i = 0, 20 do
        local point = "MINECRAWLERWARRIOR_"..i;
        SpawnNPC(MineCrawlerWarrior(), point, world);
    end
	
	for i = 0, 21 do
        local point = "WOLF_"..i;
        SpawnNPC(Wolf(), point, world);
    end
	
	for i = 0, 38 do
        local point = "SCAVENGER_"..i;
        SpawnNPC(Scavenger(), point, world);
    end
	
	for i = 0, 21 do
        local point = "MOLERAT_"..i;
        SpawnNPC(Molerat(), point, world);
    end
	
	for i = 0, 25 do
        local point = "BLOODFLY_"..i;
        SpawnNPC(Bloodfly(), point, world);
    end
	
	for i = 0, 15 do
        local point = "BOGOMOL_"..i;
        SpawnNPC(Bogomol(), point, world);
    end
	
	for i = 0, 8 do
        local point = "SWAMPDRONE_"..i;
        SpawnNPC(SwampDrone(), point, world);
    end

end