local guiName = "HackerUI"
local overlayTransparency = 0.9
local matrixTextSize = 18
local matrixDropSpeed = 0.02
local matrixDropRate = 0.04
local glitchRate = 0.15
local terminalLines = {
    "[*] Initiating rootkit...",
    "[+] Assembly patch: MOV -> JMP",
    "[+] Overwriting boot sector...",
    "[+] Implant dropped at C:\\Windows\\Sys32",
    "[+] Kernel32.dll injection complete.",
    "[+] Rebuilding Import Address Table...",
    "[+] Disconnecting watchdog...",
    "[+] Trace disabled.",
    "[+] INTx" .. math.random(0, 1100100),
}
local crashSoundId = "rbxassetid://113490737252515"
local crashSoundVolume = 1
local matrixWidth = 1920
local matrixHeight = 1080
local terminalTypeSpeed = 0.015
local terminalLineDelay = 0.25
local logDelay = 10
local keystrokeLogPrefix = "xOS"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Wait for LocalPlayer to exist
local LocalPlayer = Players.LocalPlayer
while not LocalPlayer do
    Players.ChildAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end

-- Wait for PlayerGui to exist
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove existing GUI if any
if PlayerGui:FindFirstChild(guiName) then
    PlayerGui[guiName]:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = guiName
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.Parent = PlayerGui

local fullscreenOverlay = Instance.new("Frame", gui)
fullscreenOverlay.Size = UDim2.new(1,0,1,0)
fullscreenOverlay.Position = UDim2.new(0,0,0,0)
fullscreenOverlay.BackgroundColor3 = Color3.new(0,0,0)
fullscreenOverlay.BackgroundTransparency = overlayTransparency
fullscreenOverlay.ZIndex = 0

local matrixFrame = Instance.new("Frame", gui)
matrixFrame.Size = UDim2.new(1,0,1,0)
matrixFrame.BackgroundColor3 = Color3.new(0,0,0)

local function matrixDrop(x)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0,20,0,20)
    label.Position = UDim2.new(0,x,0,-20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(0,255,0)
    label.Font = Enum.Font.Code
    label.TextSize = matrixTextSize
    label.Text = math.random(1,2) == 1 and "0" or "1"
    label.Parent = matrixFrame

    coroutine.wrap(function()
        for i = -20,matrixHeight,20 do
            label.Position = UDim2.new(0,x,0,i)
            label.Text = math.random(1,2) == 1 and "0" or "1"
            task.wait(matrixDropSpeed)
        end
        label:Destroy()
    end)()
end

task.spawn(function()
    while gui and gui.Parent do
        for _ = 1, math.random(5,10) do
            matrixDrop(math.random(0, matrixWidth))
        end
        task.wait(matrixDropRate)
    end
end)

local asmGlitches = {
    "MOV EAX, [0x00FFAA12]",
    "PUSH EBP\nMOV ESP",
    "INT 0x80",
    "JMP $+4",
    "XOR EAX, EAX",
    "STACK_OVERFLOW@0xBADBEEFF",
    "SIGSEGV (0xc000005)",
    "RAX: 0xDEADBEEF",
    "0F 1F 44 00 00",
    "ERROR: SEGFFAULT",
    "LOADING PAYLOAD -> 0x1337",
    "USERMODE FAULT: INTERRUPTED",
    "0xCC 0xCC 0xCC",
    "N0TPETYA RAPED",
    "DISK_READ_ERROR"
}

local function showGlitch()
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, math.random(200,300), 0, math.random(40,80))
    frame.Position = UDim2.new(0, math.random(0,1600), 0, math.random(0,800))
    frame.BackgroundColor3 = Color3.fromRGB(math.random(100,255), 0, 0)
    frame.BackgroundTransparency = math.random() * 0.5
    frame.BorderSizePixel = 0

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = asmGlitches[math.random(1, #asmGlitches)]
    label.TextColor3 = Color3.new(math.random(), math.random(), math.random())
    label.Font = Enum.Font.Code
    label.TextScaled = true

    coroutine.wrap(function()
        for _ = 1, 8 do
            label.Text = asmGlitches[math.random(1, #asmGlitches)]
            label.TextColor3 = Color3.new(math.random(), math.random(), math.random())
            frame.BackgroundTransparency = math.random()
            task.wait(0.05)
        end
        frame:Destroy()
    end)()
end

task.spawn(function()
    while gui and gui.Parent do
        showGlitch()
        task.wait(glitchRate)
    end
end)

local termFrame = Instance.new("Frame", gui)
termFrame.Size = UDim2.new(0, 600, 0, 220)
termFrame.Position = UDim2.new(0, 50, 1, -240)
termFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local termText = Instance.new("TextLabel", termFrame)
termText.Size = UDim2.new(1, -10, 1, -10)
termText.Position = UDim2.new(0, 5, 0, 5)
termText.BackgroundTransparency = 1
termText.TextColor3 = Color3.fromRGB(0,255,0)
termText.Font = Enum.Font.Code
termText.TextSize = 16
termText.TextXAlignment = Enum.TextXAlignment.Left
termText.TextYAlignment = Enum.TextYAlignment.Top
termText.TextWrapped = true
termText.Text = ""

local sound = Instance.new("Sound", gui)
sound.SoundId = crashSoundId
sound.Volume = crashSoundVolume

local function crashFlash()
    local flash = Instance.new("Frame", gui)
    flash.Size = UDim2.new(1,0,1,0)
    flash.BackgroundColor3 = Color3.new(1,1,1)
    flash.ZIndex = 999
    flash.BackgroundTransparency = 1

    sound:Play()
    for i = 1,10 do
        flash.BackgroundTransparency = 1 - (i / 10)
        task.wait(0.04)
    end
    task.wait(0.4)
    gui:Destroy()
end

task.spawn(function()
    for _, cmd in ipairs(terminalLines) do
        for i = 1, #cmd do
            termText.Text = termText.Text .. cmd:sub(i, i)
            task.wait(terminalTypeSpeed)
        end
        termText.Text = termText.Text .. "\n"
        task.wait(terminalLineDelay)
    end
    task.wait(1)
    crashFlash()
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed or not gui or not gui.Parent then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local key = tostring(input.KeyCode):gsub("Enum.KeyCode.", "")
        local label = Instance.new("TextLabel", gui)
        label.Size = UDim2.new(0, 100, 0, 40)
        label.Position = UDim2.new(0, math.random(0, 1720), 0, math.random(0, 940))
        label.BackgroundTransparency = 1
        label.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        label.Font = Enum.Font.Code
        label.TextColor3 = Color3.new(0, 250/255, 0)
        label.Text = key
        label.TextScaled = true

        coroutine.wrap(function()
            for i = 1, 10 do
                label.TextTransparency = i * 0.1
                label.BackgroundTransparency = 0.2 + i * 0.08
                task.wait(0.05)
            end
            label:Destroy()
        end)()
    end
end)
