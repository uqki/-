-- Mobile Cheat GUI Script [Enhanced Version]
-- Features: Teleport, Noclip, Infinity Jump, Speed Hack, Anti-Cheat Bypass

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Notification System
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

-- GUI Creation
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileCheatGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 320)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 70)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 14)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Name = "Title"
TitleText.Size = UDim2.new(1, -10, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Text = "Mobile Cheat Hub"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.Font = Enum.Font.GothamBold
TitleText.BackgroundTransparency = 1
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    Notify("Script", "GUI Closed", 3)
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 34, 0, 34)
MinBtn.Position = UDim2.new(1, -78, 0, 5)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
MinBtn.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 8)
MinCorner.Parent = MinBtn

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 44)}):Play()
        MinBtn.Text = "+"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 280, 0, 320)}):Play()
        MinBtn.Text = "-"
    end
end)

-- Drag System (Mobile & PC)
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateDrag(input)
    end
end)

-- ScrollingFrame for Buttons
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, -44)
ScrollFrame.Position = UDim2.new(0, 0, 0, 44)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 90)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 420)
ScrollFrame.Parent = MainFrame

-- Button Creator
local function CreateButton(name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0.9, 0, 0, 46)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.GothamSemibold
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    btn.BorderSizePixel = 0
    btn.Parent = ScrollFrame
    btn.AutoButtonColor = true
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- State Variables
local savedPosition = nil
local noclipEnabled = false
local infJumpEnabled = false
local speedEnabled = false
local antiCheatEnabled = false
local normalSpeed = 16
local boostedSpeed = 120
local normalJump = 50
local boostedJump = 120

-- Teleport: Save Position
local SavePosBtn = CreateButton("Save Position", 10, function()
    if HRP then
        savedPosition = HRP.CFrame
        Notify("Teleport", "Position saved!", 3)
    else
        Notify("Teleport", "Character not ready", 3)
    end
end)

-- Teleport: Load Position (Tween for smooth movement)
local TpBtn = CreateButton("Teleport to Saved", 66, function()
    if savedPosition and HRP then
        local tween = TweenService:Create(HRP, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = savedPosition})
        tween:Play()
        Notify("Teleport", "Teleported smoothly!", 3)
    else
        Notify("Teleport", "No position saved!", 3)
    end
end)

-- Noclip (Enhanced: CFrame lock + Velocity zero)
local NoclipBtn = CreateButton("Noclip: OFF", 122, function()
    noclipEnabled = not noclipEnabled
    NoclipBtn.Text = noclipEnabled and "Noclip: ON" or "Noclip: OFF"
    NoclipBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(45, 45, 55)
    Notify("Noclip", noclipEnabled and "Enabled" or "Disabled", 3)
end)

RunService.RenderStepped:Connect(function()
    if noclipEnabled and Character and HRP then
        local currentCF = HRP.CFrame
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        HRP.CFrame = currentCF
        HRP.Velocity = Vector3.new(0, 0, 0)
        HRP.RotVelocity = Vector3.new(0, 0, 0)
    end
end)

-- Infinity Jump (Enhanced: JumpRequest + JumpPower force)
local InfJumpBtn = CreateButton("Inf Jump: OFF", 178, function()
    infJumpEnabled = not infJumpEnabled
    InfJumpBtn.Text = infJumpEnabled and "Inf Jump: ON" or "Inf Jump: OFF"
    InfJumpBtn.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(45, 45, 55)
    Notify("Inf Jump", infJumpEnabled and "Enabled" or "Disabled", 3)
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Speed Hack (Enhanced: WalkSpeed + CFrame movement)
local SpeedBtn = CreateButton("Speed: OFF", 234, function()
    speedEnabled = not speedEnabled
    SpeedBtn.Text = speedEnabled and "Speed: ON" or "Speed: OFF"
    SpeedBtn.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 130, 70) or Color3.fromRGB(45, 45, 55)
    Notify("Speed", speedEnabled and "Enabled (" .. boostedSpeed .. ")" or "Disabled", 3)
end)

-- Anti-Cheat Bypass (Enhanced: Multi-layer defense)
local function AntiCheatBypass()
    local bypassCount = 0
    
    pcall(function()
        if hookfunction and newcclosure then
            local oldKick = hookfunction(LocalPlayer.Kick, newcclosure(function(self, ...)
                if checkcaller() then
                    return oldKick(self, ...)
                end
                Notify("AntiCheat", "Kick blocked!", 3)
                return nil
            end))
            bypassCount = bypassCount + 1
        end
    end)
    
    pcall(function()
        if getgc and islclosure then
            for _, func in pairs(getgc(true)) do
                if type(func) == "function" and islclosure(func) then
                    local info = debug.getinfo(func)
                    if info and info.source then
                        local src = info.source:lower()
                        if src:find("anticheat") or src:find("detect") or src:find("ban") or src:find("kick") or src:find("exploit") then
                            hookfunction(func, newcclosure(function(...)
                                return nil
                            end))
                            bypassCount = bypassCount + 1
                        end
                    end
                end
            end
        end
    end)
    
    pcall(function()
        if getreg then
            for _, v in pairs(getreg()) do
                if type(v) == "thread" then
                    pcall(function()
                        debug.setconstant(v, 1, "nil")
                    end)
                end
            end
        end
    end)
    
    pcall(function()
        if hookfunction then
            local mt = getrawmetatable and getrawmetatable(game) or nil
            if mt and setreadonly then
                setreadonly(mt, false)
                local oldIndex = mt.__index
                mt.__index = newcclosure(function(t, k)
                    if checkcaller() then
                        return oldIndex(t, k)
                    end
                    if k == "Kick" or k == "kick" then
                        return function() return nil end
                    end
                    return oldIndex(t, k)
                end)
                setreadonly(mt, true)
            end
        end
    end)
    
    Notify("AntiCheat", "Bypass active (" .. bypassCount .. " hooks)", 4)
end

-- Anti-Cheat Button
local AntiCheatBtn = CreateButton("Anti-Cheat: OFF", 290, function()
    antiCheatEnabled = not antiCheatEnabled
    if antiCheatEnabled then
        AntiCheatBypass()
        AntiCheatBtn.Text = "Anti-Cheat: ON"
        AntiCheatBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    else
        AntiCheatBtn.Text = "Anti-Cheat: OFF"
        AntiCheatBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    end
end)

-- Enhanced RenderStepped Loop (Anti-reset + Speed CFrame + JumpPower)
RunService.RenderStepped:Connect(function()
    if not Character or not Humanoid or not HRP then return end
    
    -- Speed: Force WalkSpeed + CFrame boost
    if speedEnabled then
        Humanoid.WalkSpeed = boostedSpeed
        local moveDir = Humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            HRP.CFrame = HRP.CFrame + moveDir.Unit * (boostedSpeed * 0.016)
            HRP.Velocity = Vector3.new(0, HRP.Velocity.Y, 0)
        end
    else
        if Humanoid.WalkSpeed ~= normalSpeed then
            Humanoid.WalkSpeed = normalSpeed
        end
    end
    
    -- Inf Jump: Force JumpPower
    if infJumpEnabled then
        Humanoid.JumpPower = boostedJump
    else
        if Humanoid.JumpPower ~= normalJump then
            Humanoid.JumpPower = normalJump
        end
    end
end)

-- Character Respawn Handler
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
    
    if speedEnabled and Humanoid then
        Humanoid.WalkSpeed = boostedSpeed
    end
    
    if infJumpEnabled and Humanoid then
        Humanoid.JumpPower = boostedJump
    end
    
    if noclipEnabled then
        Notify("System", "Respawned. Features restored.", 3)
    end
end)

-- Initial Notification
Notify("Mobile Cheat Hub", "Enhanced script loaded!", 5)
