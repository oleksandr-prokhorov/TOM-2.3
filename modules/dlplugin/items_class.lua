local NamedWA = {};

function AddItemsClass(instance, class)
	NamedWA[string.upper(instance)] = class;
end

local ClassItems = {};

function AddClassItems(class, instance)
	ClassItems[string.upper(class)] = string.upper(instance);
end

function GetInstanceWA(instance)
	if NamedWA[string.upper(instance)] ~= nil then
		return NamedWA[string.upper(instance)];
	else
		return instance;
	end
end


function GetClassItems(class)
	if ClassItems[string.upper(class)] ~= nil then
		return ClassItems[string.upper(class)];
	else
		return "NULL";
	end
end


function InitItemWAList()
	LoadItemWAList();
end

function PrintFullClassList()
	for k, v in pairs(Items) do
		print(k.." "..v);
	end
end


function LoadItemWAList()
	local iFile = io.open("dlbase/it_c.me", "r+");
	local filestream = iFile:read();
	for line in io.lines("dlbase/it_c.me","r+") do
		local result, instance, class = sscanf(filestream,"sd");
		if result == 1 then
			AddClassItems(string.upper(instance), class);
			AddItemsClass(string.upper(class), string.upper(instance));
		end
		filestream = iFile:read("*l");
	end
	iFile:close();
end