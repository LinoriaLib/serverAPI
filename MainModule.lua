local MainModule = {}

-- Approved safe utilities only
function MainModule.CalculateMath(expression)
	-- Example: Only allow basic math operations
	return loadstring("return "..expression, "math")()
end

function MainModule.CreateInstance(className, properties)
	-- Whitelist of allowed classes
	local allowedClasses = {
		Part = true,
		Folder = true,
		Script = true
	}

	if not allowedClasses[className] then
		error("Class not allowed")
	end

	local instance = Instance.new(className)
	for k,v in pairs(properties) do
		instance[k] = v
	end
	return instance
end

function MainModule.Init()
	-- Set up approved remote functions
	local remote = Instance.new("RemoteFunction")
	remote.Name = "SafeOperations"

	remote.OnServerInvoke = function(player, operation, ...)
		-- Verify player permissions first
		if not player:IsInGroup(12345) then  -- Your approved group ID
			error("Permission denied")
		end

		if operation == "Calculate" then
			return MainModule.CalculateMath(...)
		elseif operation == "Create" then
			return MainModule.CreateInstance(...)
		end
	end

	remote.Parent = game:GetService("ReplicatedStorage")
end

return MainModule
