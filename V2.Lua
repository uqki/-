-- ============================================
-- FPS Mobile Cheat - Aimbot+Rapid Merge Edition
-- Removed: RapidFire Toggle (merged into Aimbot)
-- Added: Config Save/Load, FOV 30-180
-- Added: Noclip, Infinity Jump, Speed Hack, V-Fly
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local ShootRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("ShootReplicate")
local CrosshairRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CrosshairSync")

-- Notification
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

-- Settings
local genv = getgenv()
genv.FPSCheat = genv.FPSCheat or {
    ESP = false,
    Aimbot = false,
    ThirdPerson = false,
    HeadshotOnly = false,
    FOV = 70,
    AimbotRange = 200,
    RapidRange = 200,
    AimSpeed = 0.15,
    FireRate = 0.05,
    ESPColor = Color3.fromRGB(255, 0, 0),
    TeamCheck = true,
    -- Movement additions
    Noclip = false,
    InfinityJump = false,
    SpeedHack = false,
    SpeedValue = 50,
    VFly = false,
    FlySpeed = 50,
}
local Settings = genv.FPSCheat

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPSMobileCheatV6"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame (height expanded for Move tab)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 360)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "FPS Cheat"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 15
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -68, 0, 3)
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 18
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TitleBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -36, 0, 3)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 26)
TabBar.Position = UDim2.new(0, 10, 0, 38)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local TabButtons = {}
local TabFrames = {}
local activeTab = "Main"

local function SwitchTab(tabName)
    activeTab = tabName
    for name, btn in pairs(TabButtons) do
        if name == tabName then
            btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    for name, frame in pairs(TabFrames) do
        frame.Visible = (name == tabName)
    end
end

local function CreateTabButton(name, x, width)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width, 1, 0)
    btn.Position = UDim2.new(0, x, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
    TabButtons[name] = btn
end

-- 4 tabs: Main, Fire, Move, Settings
local tabWidth = (260 - 20 - 12) / 4
CreateTabButton("Main", 0, tabWidth)
CreateTabButton("Fire", tabWidth + 4, tabWidth)
CreateTabButton("Move", tabWidth * 2 + 8, tabWidth)
CreateTabButton("Settings", tabWidth * 3 + 12, tabWidth)

-- Tab Content
local ContentY = 68
local ContentH = 290

local TabMain = Instance.new("Frame")
TabMain.Size = UDim2.new(1, -20, 0, ContentH)
TabMain.Position = UDim2.new(0, 10, 0, ContentY)
TabMain.BackgroundTransparency = 1
TabMain.Visible = true
TabMain.Parent = MainFrame
TabFrames["Main"] = TabMain

local TabFire = Instance.new("Frame")
TabFire.Size = UDim2.new(1, -20, 0, ContentH)
TabFire.Position = UDim2.new(0, 10, 0, ContentY)
TabFire.BackgroundTransparency = 1
TabFire.Visible = false
TabFire.Parent = MainFrame
TabFrames["Fire"] = TabFire

local TabMove = Instance.new("Frame")
TabMove.Size = UDim2.new(1, -20, 0, ContentH)
TabMove.Position = UDim2.new(0, 10, 0, ContentY)
TabMove.BackgroundTransparency = 1
TabMove.Visible = false
TabMove.Parent = MainFrame
TabFrames["Move"] = TabMove

local TabSettings = Instance.new("Frame")
TabSettings.Size = UDim2.new(1, -20, 0, ContentH)
TabSettings.Position = UDim2.new(0, 10, 0, ContentY)
TabSettings.BackgroundTransparency = 1
TabSettings.Visible = false
TabSettings.Parent = MainFrame
TabFrames["Settings"] = TabSettings

SwitchTab("Main")

-- Toggle tracking for Save/Load
local ToggleButtons = {}

local function CreateToggle(name, key, y, parent)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 34)
    f.Position = UDim2.new(0, 0, 0, y)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.6, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = Color3.fromRGB(210, 210, 210)
    l.TextSize = 13
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0, 48, 0, 26)
    b.Position = UDim2.new(1, -48, 0.5, -13)
    b.BackgroundColor3 = Settings[key] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70)
    b.Text = Settings[key] and "ON" or "OFF"
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = f
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

    b.MouseButton1Click:Connect(function()
        Settings[key] = not Settings[key]
        b.BackgroundColor3 = Settings[key] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70)
        b.Text = Settings[key] and "ON" or "OFF"
        Notify("FPS Cheat", name .. " " .. (Settings[key] and "Enabled" or "Disabled"), 2)
    end)

    ToggleButtons[key] = b
end

CreateToggle("ESP / Wallhack", "ESP", 0, TabMain)
CreateToggle("Aimbot + Rapid", "Aimbot", 38, TabMain)
CreateToggle("Third Person", "ThirdPerson", 76, TabMain)
CreateToggle("Headshot Only", "HeadshotOnly", 114, TabMain)

-- Slider tracking for Save/Load
local activeSlider = nil
local SliderRefs = {}

local function CreateSlider(name, key, y, min, max, suffix, isFloat, color, parent)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, 50)
    f.Position = UDim2.new(0, 0, 0, y)
    f.BackgroundTransparency = 1
    f.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = name .. ": " .. (isFloat and string.format("%.3f", Settings[key]) or Settings[key]) .. (suffix or "")
    lbl.TextColor3 = Color3.fromRGB(210, 210, 210)
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = f

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 8)
    track.Position = UDim2.new(0, 0, 0, 28)
    track.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    track.BorderSizePixel = 0
    track.Parent = f
    Instance.new("UICorner", track).CornerRadius = UDim.new(0, 4)

    local fill = Instance.new("Frame")
    local percent = (Settings[key] - min) / (max - min)
    fill.Size = UDim2.new(percent, 0, 1, 0)
    fill.BackgroundColor3 = color or Color3.fromRGB(0, 150, 255)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 4)

    local knob = Instance.new("TextButton")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new(percent, -9, 0, -5)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.Text = ""
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function UpdateFromInput(input)
        local absX = track.AbsolutePosition.X
        local absW = track.AbsoluteSize.X
        local pos = math.clamp((input.Position.X - absX) / absW, 0, 1)
        local val = isFloat and (min + pos * (max - min)) or math.floor(min + pos * (max - min))
        Settings[key] = isFloat and math.floor(val * 1000) / 1000 or val
        lbl.Text = name .. ": " .. (isFloat and string.format("%.3f", Settings[key]) or Settings[key]) .. (suffix or "")
        fill.Size = UDim2.new(pos, 0, 1, 0)
        knob.Position = UDim2.new(pos, -9, 0, -5)
        if key == "FOV" then Camera.FieldOfView = Settings.FOV end
    end

    knob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            activeSlider = {track = track, fill = fill, knob = knob, lbl = lbl, min = min, max = max, key = key, suffix = suffix, isFloat = isFloat, name = name}
        end
    end)
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
            activeSlider = {track = track, fill = fill, knob = knob, lbl = lbl, min = min, max = max, key = key, suffix = suffix, isFloat = isFloat, name = name}
            UpdateFromInput(i)
        end
    end)

    SliderRefs[key] = {fill = fill, knob = knob, lbl = lbl, min = min, max = max, isFloat = isFloat, suffix = suffix, name = name}
end

-- Fire Tab
CreateSlider("Fire Rate", "FireRate", 0, 0.001, 0.1, "s", true, Color3.fromRGB(255, 200, 0), TabFire)
CreateSlider("Rapid Range", "RapidRange", 55, 50, 500, "", false, Color3.fromRGB(0, 200, 100), TabFire)

-- Move Tab
CreateToggle("Noclip", "Noclip", 0, TabMove)
CreateToggle("Infinity Jump", "InfinityJump", 38, TabMove)
CreateToggle("Speed Hack", "SpeedHack", 76, TabMove)
CreateSlider("Speed Value", "SpeedValue", 110, 16, 200, "", false, Color3.fromRGB(255, 150, 0), TabMove)
CreateToggle("V-Fly", "VFly", 164, TabMove)
CreateSlider("Fly Speed", "FlySpeed", 198, 10, 200, "", false, Color3.fromRGB(0, 200, 255), TabMove)

-- Settings Tab
CreateSlider("FOV", "FOV", 0, 30, 180, "", false, Color3.fromRGB(0, 150, 255), TabSettings)
CreateSlider("Aim Range", "AimbotRange", 50, 50, 500, "", false, Color3.fromRGB(255, 60, 60), TabSettings)
CreateSlider("Aim Speed", "AimSpeed", 100, 0.01, 0.5, "", true, Color3.fromRGB(150, 0, 255), TabSettings)

-- Save / Load Buttons
local SaveBtn = Instance.new("TextButton")
SaveBtn.Size = UDim2.new(0.48, 0, 0, 28)
SaveBtn.Position = UDim2.new(0, 0, 0, 158)
SaveBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 0)
SaveBtn.Text = "Save"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.TextSize = 12
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.Parent = TabSettings
Instance.new("UICorner", SaveBtn).CornerRadius = UDim.new(0, 6)

local LoadBtn = Instance.new("TextButton")
LoadBtn.Size = UDim2.new(0.48, 0, 0, 28)
LoadBtn.Position = UDim2.new(0.52, 0, 0, 158)
LoadBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
LoadBtn.Text = "Load"
LoadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadBtn.TextSize = 12
LoadBtn.Font = Enum.Font.GothamBold
LoadBtn.Parent = TabSettings
Instance.new("UICorner", LoadBtn).CornerRadius = UDim.new(0, 6)

-- Config System
local ConfigFile = "FPSCheat_Mobile.json"

local function RefreshUI()
    -- Toggles
    for key, btn in pairs(ToggleButtons) do
        btn.BackgroundColor3 = Settings[key] and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(70, 70, 70)
        btn.Text = Settings[key] and "ON" or "OFF"
    end
    -- Sliders
    for key, ref in pairs(SliderRefs) do
        local percent = (Settings[key] - ref.min) / (ref.max - ref.min)
        ref.fill.Size = UDim2.new(percent, 0, 1, 0)
        ref.knob.Position = UDim2.new(percent, -9, 0, -5)
        ref.lbl.Text = ref.name .. ": " .. (ref.isFloat and string.format("%.3f", Settings[key]) or Settings[key]) .. (ref.suffix or "")
    end
    Camera.FieldOfView = Settings.FOV
end

local function SaveConfig()
    local ok = pcall(function()
        local data = {
            ESP = Settings.ESP,
            Aimbot = Settings.Aimbot,
            ThirdPerson = Settings.ThirdPerson,
            HeadshotOnly = Settings.HeadshotOnly,
            FOV = Settings.FOV,
            AimbotRange = Settings.AimbotRange,
            RapidRange = Settings.RapidRange,
            AimSpeed = Settings.AimSpeed,
            FireRate = Settings.FireRate,
            TeamCheck = Settings.TeamCheck,
            ESPColorR = Settings.ESPColor.R,
            ESPColorG = Settings.ESPColor.G,
            ESPColorB = Settings.ESPColor.B,
            -- Movement
            Noclip = Settings.Noclip,
            InfinityJump = Settings.InfinityJump,
            SpeedHack = Settings.SpeedHack,
            SpeedValue = Settings.SpeedValue,
            VFly = Settings.VFly,
            FlySpeed = Settings.FlySpeed,
        }
        writefile(ConfigFile, HttpService:JSONEncode(data))
    end)
    Notify("Config", ok and "Saved!" or "Save Failed", 2)
end

local function LoadConfig()
    local ok = pcall(function()
        if isfile(ConfigFile) then
            local data = HttpService:JSONDecode(readfile(ConfigFile))
            Settings.ESP = data.ESP
            Settings.Aimbot = data.Aimbot
            Settings.ThirdPerson = data.ThirdPerson
            Settings.HeadshotOnly = data.HeadshotOnly
            Settings.FOV = data.FOV
            Settings.AimbotRange = data.AimbotRange
            Settings.RapidRange = data.RapidRange
            Settings.AimSpeed = data.AimSpeed
            Settings.FireRate = data.FireRate
            Settings.TeamCheck = data.TeamCheck
            Settings.ESPColor = Color3.new(data.ESPColorR, data.ESPColorG, data.ESPColorB)
            -- Movement
            Settings.Noclip = data.Noclip or false
            Settings.InfinityJump = data.InfinityJump or false
            Settings.SpeedHack = data.SpeedHack or false
            Settings.SpeedValue = data.SpeedValue or 50
            Settings.VFly = data.VFly or false
            Settings.FlySpeed = data.FlySpeed or 50
            RefreshUI()
        else
            Notify("Config", "No file found", 2)
        end
    end)
    if ok and isfile(ConfigFile) then
        Notify("Config", "Loaded!", 2)
    elseif not ok then
        Notify("Config", "Load Failed", 2)
    end
end

SaveBtn.MouseButton1Click:Connect(SaveConfig)
LoadBtn.MouseButton1Click:Connect(LoadConfig)

-- Extra toggle callbacks for movement
ToggleButtons["Noclip"].MouseButton1Click:Connect(function() UpdateNoclip() end)
ToggleButtons["InfinityJump"].MouseButton1Click:Connect(function() UpdateInfJump() end)
ToggleButtons["SpeedHack"].MouseButton1Click:Connect(function() UpdateSpeed() end)
ToggleButtons["VFly"].MouseButton1Click:Connect(function() UpdateVFly() end)

-- Slider Input Logic
UserInputService.InputChanged:Connect(function(i)
    if activeSlider and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local s = activeSlider
        local absX = s.track.AbsolutePosition.X
        local absW = s.track.AbsoluteSize.X
        local pos = math.clamp((i.Position.X - absX) / absW, 0, 1)
        local val = s.isFloat and (s.min + pos * (s.max - s.min)) or math.floor(s.min + pos * (s.max - s.min))
        Settings[s.key] = s.isFloat and math.floor(val * 1000) / 1000 or val
        s.lbl.Text = s.name .. ": " .. (s.isFloat and string.format("%.3f", Settings[s.key]) or Settings[s.key]) .. (s.suffix or "")
        s.fill.Size = UDim2.new(pos, 0, 1, 0)
        s.knob.Position = UDim2.new(pos, -9, 0, -5)
        if s.key == "FOV" then Camera.FieldOfView = Settings.FOV end
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        activeSlider = nil
    end
end)

-- Drag
local dragging = false
local dragStart, startPos

TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = i.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.Touch or i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Minimize
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    TabBar.Visible = not minimized
    for _, f in pairs(TabFrames) do f.Visible = not minimized and f.Name == "Tab" .. activeTab end
    MainFrame.Size = minimized and UDim2.new(0, 260, 0, 36) or UDim2.new(0, 260, 0, 360)
    MinBtn.Text = minimized and "+" or "-"
    if not minimized then SwitchTab(activeTab) end
end)

-- Cleanup
CloseBtn.MouseButton1Click:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local h = p.Character:FindFirstChild("FPSESP_H")
            if h then h:Destroy() end
            local b = p.Character:FindFirstChild("FPSESP_B")
            if b then b:Destroy() end
        end
    end
    -- Disconnect movement connections
    if noclipConnection then noclipConnection:Disconnect() end
    if infJumpConnection then infJumpConnection:Disconnect() end
    if speedConnection then speedConnection:Disconnect() end
    if flyConnection then flyConnection:Disconnect() end
    if flyGyro then flyGyro:Destroy() end
    if flyVel then flyVel:Destroy() end
    ScreenGui:Destroy()
    Notify("FPS Cheat", "Script Closed", 3)
end)

-- ============================================
-- ESP SYSTEM
-- ============================================
local ESPObjects = {}

local function ClearPlayerESP(player)
    if player and player.Character then
        local h = player.Character:FindFirstChild("FPSESP_H")
        if h then h:Destroy() end
        local b = player.Character:FindFirstChild("FPSESP_B")
        if b then b:Destroy() end
    end
    ESPObjects[player] = nil
end

local function CreateESP(player)
    if player == LocalPlayer then return end
    if not player.Character then return end
    if Settings.TeamCheck and player.Team == LocalPlayer.Team then
        ClearPlayerESP(player)
        return
    end

    local char = player.Character
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        ClearPlayerESP(player)
        return
    end

    if char:FindFirstChild("FPSESP_H") and char:FindFirstChild("FPSESP_B") then
        local bg = char:FindFirstChild("FPSESP_B")
        if bg then
            local distLabel = bg:FindFirstChild("DistLabel")
            local nameLabel = bg:FindFirstChild("NameLabel")
            if distLabel and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude)
                distLabel.Text = dist .. "m"
            end
            if nameLabel then nameLabel.TextColor3 = Settings.ESPColor end
            local hl = char:FindFirstChild("FPSESP_H")
            if hl then hl.FillColor = Settings.ESPColor end
        end
        return
    end

    ClearPlayerESP(player)

    local hl = Instance.new("Highlight")
    hl.Name = "FPSESP_H"
    hl.FillColor = Settings.ESPColor
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.65
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = char
    hl.Parent = char

    local bg = Instance.new("BillboardGui")
    bg.Name = "FPSESP_B"
    bg.Size = UDim2.new(0, 120, 0, 50)
    bg.StudsOffset = Vector3.new(0, 3.5, 0)
    bg.AlwaysOnTop = true
    bg.Parent = char

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Settings.ESPColor
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = bg

    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "0m"
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextSize = 11
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = bg

    ESPObjects[player] = {Highlight = hl, Billboard = bg, Character = char}
end

local function ClearAllESP()
    for _, p in pairs(Players:GetPlayers()) do
        ClearPlayerESP(p)
    end
    ESPObjects = {}
end

-- ============================================
-- AIMBOT SYSTEM (Merged with Rapid Fire)
-- ============================================
local function GetTargetBone(character)
    local priority = {"Head", "UpperTorso", "Torso", "HumanoidRootPart"}
    for _, boneName in ipairs(priority) do
        local bone = character:FindFirstChild(boneName)
        if bone then return bone end
    end
    return character:FindFirstChild("HumanoidRootPart")
end

local function IsVisible(targetPart, targetCharacter)
    if not targetPart then return false end
    local origin = Camera.CFrame.Position
    local direction = targetPart.Position - origin
    local distance = direction.Magnitude
    direction = direction.Unit
    local ray = Ray.new(origin, direction * distance)
    local hit = Workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, Camera})
    if not hit then return true end
    if hit:IsDescendantOf(targetCharacter) then return true end
    if hit.Transparency > 0.7 then return true end
    return false
end

local currentTarget = nil

local function GetAimbotTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local bestTarget = nil
    local bestScore = math.huge

    if currentTarget and currentTarget.Parent then
        local char = currentTarget.Parent
        local player = Players:GetPlayerFromCharacter(char)
        if player and player ~= LocalPlayer then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hum and hum.Health > 0 and hrp then
                local dist = (hrp.Position - myPos).Magnitude
                if dist <= Settings.AimbotRange * 1.3 then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
                    if onScreen then
                        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                        if screenDist <= 120 then
                            if IsVisible(currentTarget, char) then
                                return currentTarget
                            end
                        end
                    end
                end
            end
        end
    end
    currentTarget = nil

    for _, p in pairs(Players:GetPlayers()) do
        if p == LocalPlayer then continue end
        if not p.Character then continue end
        local char = p.Character
        local bone = GetTargetBone(char)
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not bone or not hum or hum.Health <= 0 or not hrp then continue end
        if Settings.TeamCheck and p.Team == LocalPlayer.Team then continue end
        local dist = (hrp.Position - myPos).Magnitude
        if dist > Settings.AimbotRange then continue end
        local screenPos, onScreen = Camera:WorldToViewportPoint(bone.Position)
        if not onScreen then continue end
        local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
        if screenDist > 100 then continue end
        if not IsVisible(bone, char) then continue end
        local score = screenDist + (dist * 0.05)
        if score < bestScore then
            bestScore = score
            bestTarget = bone
        end
    end

    currentTarget = bestTarget
    return bestTarget
end

-- ============================================
-- RAPID FIRE (Merged into Aimbot)
-- Fires automatically when Aimbot locks a target
-- ============================================
local bulletId = 0

spawn(function()
    while ScreenGui and ScreenGui.Parent do
        if Settings.Aimbot then
            if currentTarget and currentTarget.Parent then
                local char = currentTarget.Parent
                local player = Players:GetPlayerFromCharacter(char)
                if player and player ~= LocalPlayer then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health > 0 then
                        bulletId = bulletId + 1
                        local origin = Camera.CFrame.Position
                        local hitPos = currentTarget.Position
                        local hitNormal = (origin - hitPos).Unit

                        ShootRemote:FireServer({
                            hitPos = hitPos,
                            ownerUserId = LocalPlayer.UserId,
                            origin = origin,
                            id = bulletId,
                            effects = {Frost = 0, Ricochet = 0, Barrage = 0},
                            hitInstance = currentTarget,
                            to = hitPos,
                            mode = "single",
                            hitNormal = hitNormal,
                            kind = "bullet",
                            isCharacterHit = true,
                            isADS = false,
                        })

                        CrosshairRemote:FireServer("Patch", {TwoHanded = false})
                    end
                end
            end
            task.wait(Settings.FireRate)
        else
            task.wait(0.1)
        end
    end
end)

-- ============================================
-- THIRD PERSON
-- ============================================
local tpConnection = nil
local function UpdateThirdPerson()
    if Settings.ThirdPerson then
        if not tpConnection then
            tpConnection = RunService.RenderStepped:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = LocalPlayer.Character.HumanoidRootPart
                    local camPos = hrp.Position - hrp.CFrame.LookVector * 7 + Vector3.new(0, 2.5, 0)
                    Camera.CFrame = CFrame.new(camPos, hrp.Position + Vector3.new(0, 1.5, 0))
                end
            end)
        end
    else
        if tpConnection then
            tpConnection:Disconnect()
            tpConnection = nil
        end
    end
end

-- ============================================
-- MOVEMENT SYSTEMS
-- ============================================

-- Noclip
local noclipConnection = nil
function UpdateNoclip()
    if Settings.Noclip then
        if not noclipConnection then
            noclipConnection = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
            Notify("Movement", "Noclip Enabled", 2)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
            Notify("Movement", "Noclip Disabled", 2)
        end
    end
end

-- Infinity Jump
local infJumpConnection = nil
function UpdateInfJump()
    if Settings.InfinityJump then
        if not infJumpConnection then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
            Notify("Movement", "Infinity Jump Enabled", 2)
        end
    else
        if infJumpConnection then
            infJumpConnection:Disconnect()
            infJumpConnection = nil
            Notify("Movement", "Infinity Jump Disabled", 2)
        end
    end
end

-- Speed Hack
local speedConnection = nil
function UpdateSpeed()
    if Settings.SpeedHack then
        if not speedConnection then
            speedConnection = RunService.Heartbeat:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Settings.SpeedValue
                end
            end)
            Notify("Movement", "Speed Hack Enabled (" .. Settings.SpeedValue .. ")", 2)
        end
    else
        if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
            end
            Notify("Movement", "Speed Hack Disabled", 2)
        end
    end
end

-- V-Fly
local flyConnection = nil
local flyGyro = nil
local flyVel = nil
function UpdateVFly()
    if Settings.VFly then
        if not flyConnection then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                flyGyro = Instance.new("BodyGyro")
                flyGyro.P = 9e4
                flyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                flyGyro.CFrame = hrp.CFrame
                flyGyro.Parent = hrp

                flyVel = Instance.new("BodyVelocity")
                flyVel.Velocity = Vector3.zero
                flyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                flyVel.Parent = hrp

                flyConnection = RunService.RenderStepped:Connect(function()
                    if not flyGyro or not flyVel or not flyGyro.Parent or not flyVel.Parent then
                        UpdateVFly()
                        return
                    end
                    local camCF = Camera.CFrame
                    flyGyro.CFrame = camCF

                    local moveDir = Vector3.zero
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                        moveDir = LocalPlayer.Character:FindFirstChildOfClass("Humanoid").MoveDirection
                    end

                    local velocity = (camCF.LookVector * moveDir.Z + camCF.RightVector * moveDir.X) * Settings.FlySpeed

                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                        velocity = velocity + Vector3.new(0, Settings.FlySpeed * 0.5, 0)
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                        velocity = velocity - Vector3.new(0, Settings.FlySpeed * 0.5, 0)
                    end

                    flyVel.Velocity = velocity
                end)
                Notify("Movement", "V-Fly Enabled", 2)
            else
                Notify("Movement", "V-Fly Failed: No Character", 2)
                Settings.VFly = false
                ToggleButtons["VFly"].BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                ToggleButtons["VFly"].Text = "OFF"
            end
        end
    else
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if flyGyro then
            flyGyro:Destroy()
            flyGyro = nil
        end
        if flyVel then
            flyVel:Destroy()
            flyVel = nil
        end
        Notify("Movement", "V-Fly Disabled", 2)
    end
end

-- Re-apply VFly on respawn
LocalPlayer.CharacterAdded:Connect(function()
    if Settings.VFly then
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if flyGyro then
            flyGyro:Destroy()
            flyGyro = nil
        end
        if flyVel then
            flyVel:Destroy()
            flyVel = nil
        end
        task.wait(0.3)
        UpdateVFly()
    end
end)

-- ============================================
-- MAIN LOOP
-- ============================================
RunService.RenderStepped:Connect(function()
    if Settings.ESP then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                CreateESP(p)
            end
        end
    else
        ClearAllESP()
    end

    if Settings.Aimbot then
        local target = GetAimbotTarget()
        if target then
            local targetCFrame = CFrame.new(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, Settings.AimSpeed)
        end
    else
        currentTarget = nil
    end

    UpdateThirdPerson()
end)

Players.PlayerRemoving:Connect(function(p)
    ClearPlayerESP(p)
end)

Camera.FieldOfView = Settings.FOV
Notify("FPS Cheat", "Aimbot+Rapid + Movement Ready!", 3)
