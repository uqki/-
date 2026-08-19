-- Mobile Cheat GUI [Crash-Free Final]
-- Features: Teleport, Noclip, Infinity Jump, Speed Hack, Light Anti-Cheat

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Notification
local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

-- ============================================
-- LIGHT ANTI-CHEAT BYPASS (Crash-Free)
-- ============================================
local function LightBypass()
    local count = 0

    -- Step 1: Kick Block
    local ok1, err1 = pcall(function()
        local oldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(self, ...)
            if checkcaller() then return oldKick(self, ...) end
            Notify("Bypass", "Kick blocked", 3)
            return nil
        end))
        count = count + 1
    end)
    if not ok1 then Notify("Bypass", "Kick hook skipped", 2) end

    -- Step 2: LoadCharacter Block
    local ok2, err2 = pcall(function()
        local oldLoad = hookfunction(LocalPlayer.LoadCharacter, newcclosure(function(self, ...)
            if checkcaller() then return oldLoad(self, ...) end
            Notify("Bypass", "Respawn blocked", 3)
            return nil
        end))
        count = count + 1
    end)
    if not ok2 then Notify("Bypass", "Respawn hook skipped", 2) end

    -- Step 3: Metatable Shield (Light)
    local ok3, err3 = pcall(function()
        local mt = getrawmetatable and getrawmetatable(game)
        if mt and setreadonly then
            setreadonly(mt, false)
            local oldIndex = mt.__index
            mt.__index = newcclosure(function(t, k)
                if checkcaller() then return oldIndex(t, k) end
                if k == "Kick" or k == "kick" then
                    return function() return nil end
                end
                return oldIndex(t, k)
            end)
            setreadonly(mt, true)
            count = count + 1
        end
    end)
    if not ok3 then Notify("Bypass", "Meta hook skipped", 2) end

    Notify("Anti-Cheat", "Active! (" .. count .. " protections)", 4)
    return true
end

-- ============================================
-- GUI SETUP
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheatHubFinal"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 340)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(70, 70, 85)
Stroke.Thickness = 1.2

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -60, 0, 40)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Mobile Cheat Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 17
Title.Font = Enum.Font.GothamBold
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close
local Close = Instance.new("TextButton", MainFrame)
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -36, 0, 4)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 70, 70)
Close.TextSize = 15
Close.Font = Enum.Font.GothamBold
Close.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 8)
Close.Activated:Connect(function()
    ScreenGui:Destroy()
    Notify("Script", "Closed", 2)
end)

-- Minimize
local Min = Instance.new("TextButton", MainFrame)
Min.Size = UDim2.new(0, 32, 0, 32)
Min.Position = UDim2.new(1, -72, 0, 4)
Min.Text = "-"
Min.TextColor3 = Color3.fromRGB(255, 255, 255)
Min.TextSize = 18
Min.Font = Enum.Font.GothamBold
Min.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Instance.new("UICorner", Min).CornerRadius = UDim.new(0, 8)

local minimized = false
Min.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 260, 0, 40)}):Play()
        Min.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.25), {Size = UDim2.new(0, 260, 0, 340)}):Play()
        Min.Text = "-"
    end
end)

-- Drag
local dragging, dragStart, startPos = false, nil, nil
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Scrolling Frame
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, 0, 1, -42)
Scroll.Position = UDim2.new(0, 0, 0, 42)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 100)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 400)

-- Button Factory
local function MakeButton(text, y, color)
    local btn = Instance.new("TextButton", Scroll)
    btn.Size = UDim2.new(0.9, 0, 0, 44)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 15
    btn.Font = Enum.Font.GothamSemibold
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 62)
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    btn.Active = true
    return btn
end

-- ============================================
-- FEATURES
-- ============================================
local savedCF = nil
local noclip = false
local infJump = false
local speed = false
local bypass = false

-- Bypass Button
local BypassBtn = MakeButton("Anti-Cheat: OFF", 8, Color3.fromRGB(180, 50, 50))
BypassBtn.Activated:Connect(function()
    bypass = not bypass
    if bypass then
        Notify("Bypass", "Starting...", 2)
        LightBypass()
        BypassBtn.Text = "Anti-Cheat: ON"
        BypassBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 70)
    else
        BypassBtn.Text = "Anti-Cheat: OFF"
        BypassBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        Notify("Bypass", "Disabled (restart to clear)", 3)
    end
end)

-- Save Position
local SaveBtn = MakeButton("Save Position", 60)
SaveBtn.Activated:Connect(function()
    if HRP then
        savedCF = HRP.CFrame
        Notify("Teleport", "Position saved", 3)
    else
        Notify("Error", "HRP not found", 3)
    end
end)

-- Teleport (Smooth)
local TpBtn = MakeButton("Teleport", 112)
TpBtn.Activated:Connect(function()
    if savedCF and HRP then
        for i = 1, 5 do
            HRP.CFrame = HRP.CFrame:Lerp(savedCF, 0.3)
            task.wait(0.05)
        end
        Notify("Teleport", "Arrived", 3)
    else
        Notify("Teleport", "No save data", 3)
    end
end)

-- Noclip
local NoclipBtn = MakeButton("Noclip: OFF", 164)
NoclipBtn.Activated:Connect(function()
    noclip = not noclip
    NoclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
    NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(50, 50, 62)
    Notify("Noclip", noclip and "Enabled" or "Disabled", 3)
end)

RunService.Stepped:Connect(function()
    if noclip and Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Infinity Jump
local JumpBtn = MakeButton("Inf Jump: OFF", 216)
JumpBtn.Activated:Connect(function()
    infJump = not infJump
    JumpBtn.Text = infJump and "Inf Jump: ON" or "Inf Jump: OFF"
    JumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(50, 50, 62)
    Notify("Inf Jump", infJump and "Enabled" or "Disabled", 3)
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and HRP then
        HRP.Velocity = Vector3.new(HRP.Velocity.X, 50, HRP.Velocity.Z)
    end
end)

-- Speed
local SpeedBtn = MakeButton("Speed: OFF", 268)
SpeedBtn.Activated:Connect(function()
    speed = not speed
    if Humanoid then
        Humanoid.WalkSpeed = speed and 80 or 16
    end
    SpeedBtn.Text = speed and "Speed: ON" or "Speed: OFF"
    SpeedBtn.BackgroundColor3 = speed and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(50, 50, 62)
    Notify("Speed", speed and "Enabled (80)" or "Disabled", 3)
end)

-- Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
    if speed then Humanoid.WalkSpeed = 80 end
end)

Notify("Cheat Hub", "Loaded! Tap Anti-Cheat first", 5)
