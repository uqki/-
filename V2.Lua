-- ═══════════════════════════════════════════════════════════
--  Steal a Brainrot - Mobile Cheat Script
--  Features: AutoFarm, AutoSteal, Speed, InfJump, ESP, Noclip, AntiAFK, AutoBuy, AutoRebirth
-- ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ═══════════════════════════════════════════════════════════
--  NOTIFICATION SYSTEM
-- ═══════════════════════════════════════════════════════════
local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = tostring(title),
            Text = tostring(text),
            Duration = duration or 3
        })
    end)
end

-- ═══════════════════════════════════════════════════════════
--  GUI CREATION (Mobile Optimized)
-- ═══════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotCheat_" .. tostring(math.random(1000,9999))
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 60, 180)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 30, 60)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -90, 1, 0)
TitleText.Position = UDim2.new(0, 14, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Steal a Brainrot"
TitleText.TextColor3 = Color3.fromRGB(220, 200, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -90, 0, 14)
SubTitle.Position = UDim2.new(0, 14, 0, 26)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Mobile Cheat"
SubTitle.TextColor3 = Color3.fromRGB(150, 140, 200)
SubTitle.TextSize = 10
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -38, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 32, 0, 32)
MinBtn.Position = UDim2.new(1, -74, 0, 6)
MinBtn.BackgroundColor3 = Color3.fromRGB(180, 140, 50)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinBtn

-- Scrolling Content
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "Content"
ScrollFrame.Size = UDim2.new(1, -16, 1, -60)
ScrollFrame.Position = UDim2.new(0, 8, 0, 52)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 3
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 80, 180)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 6)
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Parent = ScrollFrame

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 4)
UIPadding.PaddingBottom = UDim.new(0, 4)
UIPadding.Parent = ScrollFrame

-- ═══════════════════════════════════════════════════════════
--  TOGGLE STATES
-- ═══════════════════════════════════════════════════════════
local States = {
    AutoFarm = false,
    AutoSteal = false,
    SpeedBoost = false,
    InfiniteJump = false,
    ESP = false,
    AntiAFK = false,
    Noclip = false,
    AutoBuy = false,
    AutoRebirth = false,
    AutoCollect = false,
}

-- ═══════════════════════════════════════════════════════════
--  TOGGLE BUTTON CREATOR
-- ═══════════════════════════════════════════════════════════
local ToggleButtons = {}

local function CreateToggle(name, key, order)
    local Btn = Instance.new("TextButton")
    Btn.Name = key .. "Btn"
    Btn.Size = UDim2.new(1, -4, 0, 42)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 38, 60)
    Btn.Text = "  " .. name
    Btn.TextColor3 = Color3.fromRGB(180, 180, 200)
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.LayoutOrder = order
    Btn.AutoButtonColor = true
    Btn.Parent = ScrollFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Btn
    
    local Status = Instance.new("TextLabel")
    Status.Name = "Status"
    Status.Size = UDim2.new(0, 50, 0, 22)
    Status.Position = UDim2.new(1, -58, 0.5, -11)
    Status.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    Status.Text = "OFF"
    Status.TextColor3 = Color3.fromRGB(200, 80, 80)
    Status.TextSize = 12
    Status.Font = Enum.Font.GothamBold
    Status.Parent = Btn
    
    local StatusCorner = Instance.new("UICorner")
    StatusCorner.CornerRadius = UDim.new(0, 6)
    StatusCorner.Parent = Status
    
    Btn.MouseButton1Click:Connect(function()
        States[key] = not States[key]
        if States[key] then
            Btn.BackgroundColor3 = Color3.fromRGB(45, 70, 50)
            Status.BackgroundColor3 = Color3.fromRGB(50, 130, 70)
            Status.Text = "ON"
            Status.TextColor3 = Color3.fromRGB(200, 255, 200)
            Notify(name, name .. " Enabled!", 2)
        else
            Btn.BackgroundColor3 = Color3.fromRGB(40, 38, 60)
            Status.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            Status.Text = "OFF"
            Status.TextColor3 = Color3.fromRGB(200, 80, 80)
            Notify(name, name .. " Disabled!", 2)
        end
    end)
    
    ToggleButtons[key] = {Button = Btn, Status = Status}
    return Btn
end

-- Create Toggles
CreateToggle("Auto Farm", "AutoFarm", 1)
CreateToggle("Auto Steal", "AutoSteal", 2)
CreateToggle("Auto Buy", "AutoBuy", 3)
CreateToggle("Auto Collect", "AutoCollect", 4)
CreateToggle("Auto Rebirth", "AutoRebirth", 5)
CreateToggle("Speed Boost", "SpeedBoost", 6)
CreateToggle("Infinite Jump", "InfiniteJump", 7)
CreateToggle("ESP", "ESP", 8)
CreateToggle("Noclip", "Noclip", 9)
CreateToggle("Anti AFK", "AntiAFK", 10)

-- Separator
local Sep = Instance.new("Frame")
Sep.Size = UDim2.new(1, -8, 0, 1)
Sep.BackgroundColor3 = Color3.fromRGB(60, 55, 90)
Sep.BorderSizePixel = 0
Sep.LayoutOrder = 11
Sep.Parent = ScrollFrame

-- Action Buttons
local function CreateActionButton(name, order, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -4, 0, 40)
    Btn.BackgroundColor3 = Color3.fromRGB(55, 50, 100)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(230, 220, 255)
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamBold
    Btn.LayoutOrder = order
    Btn.Parent = ScrollFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    return Btn
end

-- ═══════════════════════════════════════════════════════════
--  UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════
local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHRP()
    local char = GetCharacter()
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function GetHumanoid()
    local char = GetCharacter()
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local function FindRemote(namePattern)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) then
            if obj.Name:lower():find(namePattern:lower()) then
                return obj
            end
        end
    end
    return nil
end

local function FireRemote(namePattern, ...)
    local remote = FindRemote(namePattern)
    if remote then
        if remote:IsA("RemoteEvent") then
            pcall(function() remote:FireServer(...) end)
        elseif remote:IsA("RemoteFunction") then
            pcall(function() remote:InvokeServer(...) end)
        end
    end
end

-- ═══════════════════════════════════════════════════════════
--  ACTION: TELEPORT TO BASE
-- ═══════════════════════════════════════════════════════════
CreateActionButton("Teleport to Base", 12, function()
    local hrp = GetHRP()
    if not hrp then return end
    
    local base = nil
    local searchNames = {
        LocalPlayer.Name .. "Base",
        LocalPlayer.Name .. "_Base",
        LocalPlayer.Name .. "Plot",
        LocalPlayer.Name .. "_Plot",
        LocalPlayer.Name .. "Island",
    }
    
    for _, name in ipairs(searchNames) do
        base = Workspace:FindFirstChild(name)
        if base then break end
    end
    
    if not base then
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local n = obj.Name:lower()
                if n:find("base") and n:find(LocalPlayer.Name:lower()) then
                    base = obj
                    break
                end
                if n:find("plot") and n:find(LocalPlayer.Name:lower()) then
                    base = obj
                    break
                end
            end
        end
    end
    
    if base and base:IsA("BasePart") then
        hrp.CFrame = base.CFrame + Vector3.new(0, 8, 0)
        Notify("Teleport", "Teleported to your base!", 2)
    else
        Notify("Teleport", "Base not found!", 2)
    end
end)

-- ═══════════════════════════════════════════════════════════
--  ACTION: TELEPORT TO CONVEYOR
-- ═══════════════════════════════════════════════════════════
CreateActionButton("Teleport to Conveyor", 13, function()
    local hrp = GetHRP()
    if not hrp then return end
    
    local conveyor = nil
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            local n = obj.Name:lower()
            if n:find("conveyor") or n:find("belt") or n:find("carpet") or n:find("red") then
                conveyor = obj
                break
            end
        end
    end
    
    if conveyor then
        hrp.CFrame = conveyor.CFrame + Vector3.new(0, 5, 0)
        Notify("Teleport", "Teleported to conveyor!", 2)
    else
        Notify("Teleport", "Conveyor not found!", 2)
    end
end)

-- ═══════════════════════════════════════════════════════════
--  ACTION: COPY EXECUTOR NAME
-- ═══════════════════════════════════════════════════════════
CreateActionButton("Copy Executor Info", 14, function()
    local info = "Unknown"
    pcall(function()
        info = identifyexecutor() or "Unknown"
    end)
    pcall(function()
        setclipboard("Executor: " .. info)
    end)
    Notify("Clipboard", "Executor info copied!", 2)
end)

-- ═══════════════════════════════════════════════════════════
--  GUI CONTROLS
-- ═══════════════════════════════════════════════════════════
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        ScrollFrame.Visible = false
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 46), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
        MinBtn.Text = "+"
    else
        MainFrame:TweenSize(UDim2.new(0, 300, 0, 420), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25, true)
        task.wait(0.25)
        ScrollFrame.Visible = true
        MinBtn.Text = "-"
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    for k, _ in pairs(States) do
        States[k] = false
    end
    ScreenGui:Destroy()
    Notify("Script", "Cheat GUI Closed!", 3)
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: SPEED BOOST
-- ═══════════════════════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    local hum = GetHumanoid()
    if hum then
        if States.SpeedBoost then
            hum.WalkSpeed = 100
        else
            if hum.WalkSpeed > 50 then
                hum.WalkSpeed = 16
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: INFINITE JUMP
-- ═══════════════════════════════════════════════════════════
UserInputService.JumpRequest:Connect(function()
    if States.InfiniteJump then
        local hum = GetHumanoid()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: NOCLIP
-- ═══════════════════════════════════════════════════════════
RunService.Stepped:Connect(function()
    if States.Noclip then
        local char = GetCharacter()
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: ANTI-AFK
-- ═══════════════════════════════════════════════════════════
local AntiAFKConnection = nil

LocalPlayer.Idled:Connect(function()
    if States.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: AUTO FARM
-- ═══════════════════════════════════════════════════════════
task.spawn(function()
    while true do
        task.wait(0.3)
        if States.AutoFarm then
            -- Method 1: Click detectors on base
            local baseNames = {
                LocalPlayer.Name .. "Base",
                LocalPlayer.Name .. "_Base",
                LocalPlayer.Name .. "Plot",
            }
            
            for _, bname in ipairs(baseNames) do
                local base = Workspace:FindFirstChild(bname)
                if base then
                    for _, obj in pairs(base:GetDescendants()) do
                        if obj:IsA("ClickDetector") then
                            pcall(function() fireclickdetector(obj) end)
                        end
                        if obj:IsA("ProximityPrompt") then
                            pcall(function() fireproximityprompt(obj) end)
                        end
                    end
                end
            end
            
            -- Method 2: Remote Events for collecting
            local collectPatterns = {"collect", "money", "cash", "earn", "claim", "income", "profit"}
            for _, pattern in ipairs(collectPatterns) do
                FireRemote(pattern)
            end
            
            -- Method 3: Touch interest
            local hrp = GetHRP()
            if hrp then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj:IsA("TouchInterest") then
                        local parent = obj.Parent
                        if parent and parent:IsA("BasePart") then
                            if (parent.Position - hrp.Position).Magnitude < 30 then
                                pcall(function()
                                    firetouchinterest(hrp, parent, 0)
                                    task.wait()
                                    firetouchinterest(hrp, parent, 1)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: AUTO STEAL
-- ═══════════════════════════════════════════════════════════
task.spawn(function()
    while true do
        task.wait(0.8)
        if States.AutoSteal then
            local hrp = GetHRP()
            if not hrp then continue end
            
            for _, player in pairs(Players:GetPlayers()) do
                if player == LocalPlayer then continue end
                
                local baseNames = {
                    player.Name .. "Base",
                    player.Name .. "_Base",
                    player.Name .. "Plot",
                }
                
                for _, bname in ipairs(baseNames) do
                    local base = Workspace:FindFirstChild(bname)
                    if base then
                        for _, obj in pairs(base:GetDescendants()) do
                            if obj:IsA("BasePart") then
                                local n = obj.Name:lower()
                                if n:find("brainrot") or n:find("plush") or n:find("pet") or n:find("character") then
                                    if (obj.Position - hrp.Position).Magnitude < 40 then
                                        -- Try proximity prompt
                                        if obj:FindFirstChild("ProximityPrompt") then
                                            pcall(function() fireproximityprompt(obj.ProximityPrompt) end)
                                        end
                                        -- Try click detector
                                        if obj:FindFirstChild("ClickDetector") then
                                            pcall(function() fireclickdetector(obj.ClickDetector) end)
                                        end
                                        -- Try remotes
                                        local stealPatterns = {"steal", "grab", "take", "pickup", "collect"}
                                        for _, pattern in ipairs(stealPatterns) do
                                            FireRemote(pattern, obj)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: AUTO BUY
-- ═══════════════════════════════════════════════════════════
task.spawn(function()
    while true do
        task.wait(0.5)
        if States.AutoBuy then
            local hrp = GetHRP()
            if not hrp then continue end
            
            -- Look for buyable items on conveyor
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = obj.Name:lower()
                    if n:find("brainrot") or n:find("plush") or n:find("conveyor") or n:find("buy") then
                        if (obj.Position - hrp.Position).Magnitude < 50 then
                            if obj:FindFirstChild("ClickDetector") then
                                pcall(function() fireclickdetector(obj.ClickDetector) end)
                            end
                            if obj:FindFirstChild("ProximityPrompt") then
                                pcall(function() fireproximityprompt(obj.ProximityPrompt) end)
                            end
                        end
                    end
                end
            end
            
            -- Try buy remotes
            local buyPatterns = {"buy", "purchase", "get", "spawn"}
            for _, pattern in ipairs(buyPatterns) do
                FireRemote(pattern)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: AUTO COLLECT
-- ═══════════════════════════════════════════════════════════
task.spawn(function()
    while true do
        task.wait(0.4)
        if States.AutoCollect then
            local hrp = GetHRP()
            if not hrp then continue end
            
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = obj.Name:lower()
                    if n:find("drop") or n:find("money") or n:find("cash") or n:find("coin") or n:find("orb") then
                        if (obj.Position - hrp.Position).Magnitude < 60 then
                            pcall(function()
                                if obj:FindFirstChild("ClickDetector") then
                                    fireclickdetector(obj.ClickDetector)
                                end
                                if obj:FindFirstChild("ProximityPrompt") then
                                    fireproximityprompt(obj.ProximityPrompt)
                                end
                                hrp.CFrame = obj.CFrame + Vector3.new(0, 2, 0)
                            end)
                        end
                    end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: AUTO REBIRTH
-- ═══════════════════════════════════════════════════════════
task.spawn(function()
    while true do
        task.wait(5)
        if States.AutoRebirth then
            local rebirthPatterns = {"rebirth", "prestige", "reset", "reborn", "ascend"}
            for _, pattern in ipairs(rebirthPatterns) do
                FireRemote(pattern)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  FEATURE: ESP
-- ═══════════════════════════════════════════════════════════
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "ESP"
ESPFolder.Parent = ScreenGui

local function CreateESP(target, color, label)
    if not target or not target:IsA("BasePart") then return nil end
    
    local bb = Instance.new("BillboardGui")
    bb.Name = "ESP_" .. target.Name
    bb.Size = UDim2.new(0, 120, 0, 36)
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.Adornee = target
    bb.Parent = ESPFolder
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = color
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextStrokeTransparency = 0.5
    lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
    lbl.Parent = bb
    
    return bb
end

task.spawn(function()
    while true do
        task.wait(1.5)
        
        -- Clear old ESP
        for _, obj in pairs(ESPFolder:GetChildren()) do
            obj:Destroy()
        end
        
        if States.ESP then
            -- ESP Players
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        CreateESP(hrp, Color3.fromRGB(255, 80, 80), player.Name)
                    end
                end
            end
            
            -- ESP Brainrots on conveyor
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = obj.Name:lower()
                    if n:find("brainrot") or n:find("plush") or n:find("lucky") or n:find("block") then
                        CreateESP(obj, Color3.fromRGB(80, 255, 80), obj.Name)
                    end
                end
            end
            
            -- ESP Bases
            for _, player in pairs(Players:GetPlayers()) do
                local baseNames = {
                    player.Name .. "Base",
                    player.Name .. "_Base",
                    player.Name .. "Plot",
                }
                for _, bname in ipairs(baseNames) do
                    local base = Workspace:FindFirstChild(bname)
                    if base and base:IsA("BasePart") then
                        CreateESP(base, Color3.fromRGB(80, 150, 255), player.Name .. "'s Base")
                        break
                    end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  CHARACTER RESPAWN HANDLER
-- ═══════════════════════════════════════════════════════════
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = newChar:WaitForChild("Humanoid")
    HumanoidRootPart = newChar:WaitForChild("HumanoidRootPart")
    Notify("Character", "Respawn detected! Features reloaded.", 2)
end)

-- ═══════════════════════════════════════════════════════════
--  INITIAL NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════
task.wait(1)
Notify("Brainrot Cheat", "Script Loaded Successfully!", 4)

pcall(function()
    local execName = identifyexecutor() or "Unknown"
    Notify("Executor", "Running on: " .. execName, 3)
end)

Notify("Controls", "Tap toggles to enable features!", 3)
