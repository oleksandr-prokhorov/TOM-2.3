--[[
***************************************************
* GMP Movements Gates/Doors script by Risen       *
* Date: 03-07-2013                                *
*                                                 *
* Added unical keys for gates/doors by royclapton *
** Free open for admins                           *
* Date: 31-03-2022/01-04-2022                     *
***************************************************
]]--

local movementTimer;
MovementList     = {};
MovementType     = {TYPE_GATE = 0, TYPE_DOOR = 1};
MovementStatus   = {STATUS_OPENED = 0, STATUS_CLOSED = 1, STATUS_MOVING_TO_OPEN = 2, STATUS_MOVING_TO_CLOSE = 3};
MovementDistance = {DISTANCE_PLAYER_GATE = 1000, DISTANCE_PLAYER_DOOR = 300, DISTANCE_MOVE_GATE = 5};

--[[
prototype of movement:
	type,
	status,
	vobName,
	worldName,
	
	opened_posX,
	opened_posY,
	opened_posZ,
	opened_rotX,
	opened_rotY,
	opened_rotZ,
	
	closed_posX,
	closed_posY,
	closed_posZ,
	closed_rotX,
	closed_rotY,
	closed_rotZ,
	vobID
]]--

function OnFilterscriptInit()

	print("--------------------------------------------------");
	print("Movement Gates/Doors script 0.2 by Risen");
	print("* Add unical keys for gates/doors by royclapton")
	print("** Free open for admins")
	print("--------------------------------------------------");
	movementTimer = SetTimer("MovementProcess",50,1);

	
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_SMALL_01.3DS","FULLWORLD2.ZEN");
	SetMovementCoordinationAsOpened(movement, 3837.5949707031, 300.20941162109, 5235.2211914062, 0, -29, 0);
	SetMovementCoordinationAsClosed(movement, 3837.5949707031, 848.20941162109, 5235.2211914062, 0, -29, 0);
	SetMovementKey(movement, "OOLTYB_ITMI_KEY45");

	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_SMALL_01.3DS","FULLWORLD2.ZEN");
	SetMovementCoordinationAsOpened(movement, 4248.4047851562, 300.20941162109, 5464.2026367188, 0, 151, 0);
	SetMovementCoordinationAsClosed(movement, 4248.4047851562, 848.20941162109, 5464.2026367188, 0, 151, 0);
	SetMovementKey(movement, "OOLTYB_ITMI_KEY45");

	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_CLOSED,"EVT_GATE_SMALL_01.3DS","FULLWORLD2.ZEN");
	SetMovementCoordinationAsOpened(movement, 4294.626953125, 300.20941162109, 5848.1684570312, 0, 60, 0);
	SetMovementCoordinationAsClosed(movement, 4294.626953125, 848.20941162109, 5848.1684570312, 0, 60, 0);
	SetMovementKey(movement, "OOLTYB_ITMI_KEY45");

	-------------- ВОРОТА1
	--[[movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","FULLWORLD2.ZEN");
	SetMovementCoordinationAsOpened(movement, 8069.3520507812, -680.43444824219, -6252.0859375, 0, 188, 0);
	SetMovementCoordinationAsClosed(movement, 8069.3520507812, -150.43447875977, -6252.0859375, 0, 188, 0);
	SetMovementKey(movement, "OOLTYB_ITMI_KEY45");

	-------------- ВОРОТА2
	movement = CreateMovement(MovementType.TYPE_GATE,MovementStatus.STATUS_OPENED,"OC_LOB_GATE_BIG.3DS","FULLWORLD2.ZEN");
	SetMovementCoordinationAsOpened(movement, 10454.12109375, -800.27978515625, 5809.912109375, 0, 56, 0);
	SetMovementCoordinationAsClosed(movement, 10454.12109375, -150.72021484375, 5809.912109375, 0, 56, 0);
	SetMovementKey(movement, "OOLTYB_ITMI_KEY45");]]


	
end

function OnFilterscriptExit()
	print("--------------------------------------");
	print("Closing Movement Gates/Doors script...");
	print("--------------------------------------"); 
	
	KillTimer(movementTimer);
end

function SetMovementKey(movement, key)
	if key ~= nil then
		movement.key = string.upper(key);
	else
		movement.key = nil;
	end
end


function CreateMovement(movementType, movementStatus, vobName, worldName)

	if movementType < 2 then
	
		if movementStatus < 2 then -- STATUS_MOVING_TO_OPEN or STATUS_MOVING_TO_CLOSE can not be set as default
			movement = {};
			movement.type      = movementType;
			movement.status    = movementStatus;
			movement.vobName   = vobName;
			movement.worldName = worldName;
			movement.opened_posX = 0;
			movement.opened_posY = 0;
			movement.opened_posZ = 0;
			movement.opened_rotX = 0;
			movement.opened_rotY = 0;
			movement.opened_rotZ = 0;
			movement.closed_posX = 0;
			movement.closed_posY = 0;
			movement.closed_posZ = 0;
			movement.closed_rotX = 0;
			movement.closed_rotY = 0;
			movement.closed_rotZ = 0;
			movement.key = nil;
			
			if movement.status == MovementStatus.STATUS_OPENED then --Opened
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.opened_posX,movement.opened_posY,movement.opened_posZ);
				movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
				
			elseif movement.status == MovementStatus.STATUS_CLOSED then --Closed
				movement.vobID = Vob.Create(movement.vobName,movement.worldName,movement.closed_posX,movement.closed_posY,movement.closed_posZ);
				movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			end
	
			table.insert(MovementList,movement);
			return movement;
		else
			LogString("movement_log.txt","Error CreateMovement(): Incorrent movement status. It can be MovementStatus.STATUS_OPENED or MovementStatus.STATUS_CLOSED.");
		end
		
	else
		LogString("movement_log.txt","Error CreateMovement(): Incorrent movement type. It can be MovementType.TYPE_GATE or MovementType.TYPE_DOOR.");
	end
	
	return nil;
end


function DestroyMovement(movement)
	
	for i = 1, #MovementList do
		if MovementList[i] == movement then
			MovementList[i].vobID:Destroy();
			table.remove(MovementList,i);
			return true;
		end
	end
	return false;
end

function SetMovementCoordinationAsOpened(movement, posX, posY, posZ, rotX, rotY, rotZ)

	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.opened_posX = posX;
		movement.opened_posY = posY;
		movement.opened_posZ = posZ;
		movement.opened_rotX = rotX;
		movement.opened_rotY = rotY;
		movement.opened_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_OPENED then
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function SetMovementCoordinationAsClosed(movement, posX, posY, posZ, rotX, rotY, rotZ)
	
	if movement.status ~= MovementStatus.STATUS_MOVING_TO_OPEN and movement.status ~= MovementStatus.STATUS_MOVING_TO_CLOSE then
		movement.closed_posX = posX;
		movement.closed_posY = posY;
		movement.closed_posZ = posZ;
		movement.closed_rotX = rotX;
		movement.closed_rotY = rotY;
		movement.closed_rotZ = rotZ;
		
		if movement.status == MovementStatus.STATUS_CLOSED then
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
		end
		
		return true;
	end
	
	return false;
end

function OpenMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_CLOSED or movement.status == MovementStatus.STATUS_MOVING_TO_CLOSE then
			movement.status = MovementStatus.STATUS_MOVING_TO_OPEN;
			return true;
		end
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_CLOSED then -- if closed
			movement.vobID:SetPosition(movement.opened_posX,movement.opened_posY,movement.opened_posZ);
			movement.vobID:SetRotation(movement.opened_rotX,movement.opened_rotY,movement.opened_rotZ);
			
			movement.status = MovementStatus.STATUS_OPENED; -- lets open
			return true;
		end
	end
	
	return false;
end

function CloseMovement(movement)

	--Gate
	if movement.type == MovementType.TYPE_GATE then
		if movement.status == MovementStatus.STATUS_OPENED or movement.status == MovementStatus.STATUS_MOVING_TO_OPEN then
			movement.status = MovementStatus.STATUS_MOVING_TO_CLOSE;
			return true;
		end
		
	
	--Door
	elseif movement.type == MovementType.TYPE_DOOR then
		if movement.status == MovementStatus.STATUS_OPENED then -- if opened
			movement.vobID:SetPosition(movement.closed_posX,movement.closed_posY,movement.closed_posZ);
			movement.vobID:SetRotation(movement.closed_rotX,movement.closed_rotY,movement.closed_rotZ);
			
			movement.status = MovementStatus.STATUS_CLOSED; --lets close
			return true;
		end
	end
	
	return false;
end

function GetNearestGate(playerid)
	
	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		local key = nil;
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
			
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_GATE then
						if MovementList[i].worldName == playerWorld then
							local distanceToGate = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);
							if distanceToGate <= currDistance then
								currDistance = distanceToGate;
								currMovement = MovementList[i];
								key = MovementList[i].key;
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
					return currMovement, currDistance, key;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_GATE and currDistance < MovementDistance.DISTANCE_PLAYER_GATE then
				return MovementList[1], currDistance, MovementList[1].key;
			end
		end
	end
	return nil;
end

function GetNearestDoor(playerid)

	if IsPlayerConnected(playerid) == 1 then
		local playerX,playerY,playerZ = GetPlayerPos(playerid);
		local playerWorld = GetPlayerWorld(playerid);
		local key = nil;
		if #MovementList > 0 then
			local currDistance = GetDistance3D(playerX,playerY,playerZ,MovementList[1].closed_posX,MovementList[1].closed_posY,MovementList[1].closed_posZ);
			if #MovementList > 1 then
				local currMovement = nil;
				
				for i = 1, #MovementList do
					if MovementList[i].type == MovementType.TYPE_DOOR then
						if MovementList[i].worldName == playerWorld then
							local distanceToDoor = GetDistance3D(playerX,playerY,playerZ,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ);	
							if distanceToDoor <= currDistance then
								currDistance = distanceToDoor;
								currMovement = MovementList[i];
								key = MovementList[i].key;
							end
						end
					end
				end
				
				if currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
					return currMovement, currDistance, key;
				end
			end
			
			if MovementList[1].type == MovementType.TYPE_DOOR and currDistance < MovementDistance.DISTANCE_PLAYER_DOOR then
				return MovementList[1], currDistance, MovementList[1].key;
			end
		end
	end
	return nil;
end

function GetNearestMovement(playerid)
	
	local gate, distanceGate, keyG = GetNearestGate(playerid);
	local door, distanceDoor, keyD = GetNearestDoor(playerid);
	
	if gate ~= nil and door ~= nil then

		if distanceGate < distanceDoor then
			return gate, distanceGate, keyG;
		else
			return door, distanceDoor, keyD;
		end

	elseif gate == nil and door ~= nil then
		return door, distanceDoor, keyD;

	elseif gate ~= nil and door == nil then
		return gate, distanceGate, keyG;
	end
	
	return nil;
end

function MovementProcess() --Timer

	for i = 1, #MovementList do
		if MovementList[i].type == MovementType.TYPE_GATE then
		
			local x,y,z = MovementList[i].vobID:GetPosition();
		
			if MovementList[i].status == MovementStatus.STATUS_MOVING_TO_OPEN then --gate is moving to open
			
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].opened_posX,MovementList[i].opened_posY,MovementList[i].opened_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y > MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				else --if opened gate is higher than closed gate (default)
					if y < MovementList[i].opened_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z);
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_OPENED;
					end
				end
			
			elseif MovementList[i].status == MovementStatus.STATUS_MOVING_TO_CLOSE then --gate is moving to close
				
				local distanceMove = GetDistance3D(x,y,z,MovementList[i].closed_posX,MovementList[i].closed_posY,MovementList[i].closed_posZ); --calculate distance for fixing position
				
				if MovementList[i].opened_posY < MovementList[i].closed_posY then --if opened gate is lower than closed gate (default)
					if y < MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y + MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y + distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				else --if opened gate is higher than closed gate (default)
					if y > MovementList[i].closed_posY then
						if distanceMove > MovementDistance.DISTANCE_MOVE_GATE then
							MovementList[i].vobID:SetPosition(x,y - MovementDistance.DISTANCE_MOVE_GATE,z); -- destination is far
						else
							MovementList[i].vobID:SetPosition(x,y - distanceMove,z); --fixing position with small distance to destination
						end
					else
						MovementList[i].status = MovementStatus.STATUS_CLOSED;
					end
				end
			end
		end
	end
end

function CheckDatabaseGateDoor(id, key)

	local file = io.open("Database/Players/Items/"..GetPlayerName(id)..".db", "r");
	if file then
		for line in file:lines() do
			local result, item, amount = sscanf(line, "sd");
			if result == 1 then
				if string.upper(item) == key then
					if amount > 0 then
						return true;
					end
				end
			end
		end
	file:close();
	end
	return false;

end

function CheckDatabaseAdmin(id)

	local file = io.open("Database/Players/Profiles/"..GetPlayerName(id)..".txt", "r");
	if file then
		line = file:read("*l");
		line = file:read("*l");
		local result, admin = sscanf(line,"d");
		if result == 1 then
			if admin > 0 then
				file:close();
				return true;
			end
		end
	file:close();
	end
	return false;
end

function OnPlayerCommandText(playerid, cmdtext)

	if cmdtext == "/откр" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			if CheckDatabaseGateDoor(playerid, string.upper(movement.key)) == true then
				OpenMovement(movement);
				SendPlayerMessage(playerid, 255, 255, 255, "Открыто.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "У вас нет ключа.")
			end
		end
	
	elseif cmdtext == "/закр" then
	
		local movement = GetNearestMovement(playerid);
		if movement ~= nil then
			if CheckDatabaseGateDoor(playerid, string.upper(movement.key)) == true then
				CloseMovement(movement);
				SendPlayerMessage(playerid, 255, 255, 255, "Закрыто.")
			else
				SendPlayerMessage(playerid, 255, 255, 255, "У вас нет ключа.")
			end
		end
	end
end