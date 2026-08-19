-- Mobile Cheat GUI [Fixed v3]
-- Features: Teleport, Noclip, Infinity Jump, Speed Hack, Anti-Cheat Bypass

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
-- ANTI-CHEAT BYPASS (Use First!)
-- ============================================
local function ActivateBypass()
    local count = 0

    -- 1. Block Kick
    pcall(function()
        local oldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(self, ...)
            if checkcaller() then return oldKick(self, ...) end
            Notify("Bypass", "Kick blocked", 3)
            return nil
        end))
        count = count + 1
    end)

    -- 2. Block Force Respawn
    pcall(function()
        local oldLoad = hookfunction(LocalPlayer.LoadCharacter, newcclosure(function(self, ...)
            if checkcaller() then return oldLoad(self, ...) end
            Notify("Bypass", "Forced respawn blocked", 3)
            return nil
        end))
        count = count + 1
    end)

    -- 3. getgc Deep Scan
    pcall(function()
        if getgc and islclosure then
            for _, func in pairs(getgc(true)) do
                if type(func) == "function" and islclosure(func) then
                    local info = debug.getinfo(func)
                    if info and info.source then
                        local src = info.source:lower()
                        if src:find("anticheat") or src:find("detect") or src:find("ban")
                           or src:find("kick") or src:find("exploit") or src:find("cheat")
                           or src:find("fly") or src:find("speed") or src:find("teleport")
                           or src:find("noclip") or src:find("hack") or src:find("check") then
                            hookfunction(func, newcclosure(function(...)
                                return nil
                            end))
                            count = count + 1
                        end
                    end
                    -- Constant scan
                    for i = 1, 15 do
                        pcall(function()
                            local const = debug.getconstant(func, i)
                            if type(const) == "string" then
                                local c = const:lower()
                                if c:find("ban") or c:find("kick") or c:find("cheat")
                                   or c:find("exploit") or c:find("hack") or c:find("fly") then
                                    debug.setconstant(func, i, "safe")
                                end
                            end
                        end)
                    end
                end
            end
        end
    end)

    -- 4. Registry Wipe
    pcall(function()
        if getreg then
            for _, v in pairs(getreg()) do
                if type(v) == "thread" then
                    pcall(function()
                        debug.setconstant(v, 1, "nil")
                    end)
                elseif type(v) == "function" then
                    pcall(function()
                        hookfunction(v, newcclosure(function() return nil end))
                    end)
                end
            end
        end
    end)

    -- 5. Metatable Shield
    pcall(function()
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
        end
    end)

    Notify("Anti-Cheat", "Bypass active! (" .. count .. " neutralized)", 4)
    return true
end

-- ============================================
-- GUI SETUP
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CheatHubV3"
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
Title.Text = "Mobile Cheat Hub v3"
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

-- Bypass Button (MUST USE FIRST)
local BypassBtn = MakeButton("Anti-Cheat: OFF", 8, Color3.fromRGB(180, 50, 50))
BypassBtn.Activated:Connect(function()
    bypass = not bypass
    if bypass then
        ActivateBypass()
        BypassBtn.Text = "Anti-Cheat: ON"
        BypassBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 70)
    else
        BypassBtn.Text = "Anti-Cheat: OFF"
        BypassBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
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

-- Teleport (Smooth Lerp to avoid instant detection)
local TpBtn = MakeButton("Teleport", 112)
TpBtn.Activated:Connect(function()
    if savedCF and HRP then
        local steps = 5
        local startCF = HRP.CFrame
        for i = 1, steps do
            HRP.CFrame = startCF:Lerp(savedCF, i/steps)
            task.wait(0.03)
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

-- Infinity Jump (Velocity based, not ChangeState)
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

-- Speed (Simple WalkSpeed, no CFrame overwrite)
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
    if noclip then Notify("System", "Noclip restored", 2) end
    if infJump then Notify("System", "Inf Jump restored", 2) end
end)

Notify("Cheat Hub v3", "Loaded! Enable Anti-Cheat first!", 5)
