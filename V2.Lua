--// FPS Cheat | ObsidianUI | Mobile Supported
--// Generated for Roblox Executor

local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

--// Load ObsidianUI
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "FPS Cheat",
    Footer = "ver 1.0 | Mobile & PC",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    MobileButtonsSide = "Left",
})

local Tabs = {
    Combat = Window:AddTab("Combat", "crosshair"),
    Visuals = Window:AddTab("Visuals", "eye"),
    Movement = Window:AddTab("Movement", "move"),
    ["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}

--// =====================
--//  COMBAT TAB
--// =====================
local CombatLeft = Tabs.Combat:AddLeftGroupbox("Aimbot", "target")

CombatLeft:AddToggle("AimbotEnabled", {
    Text = "Aimbot",
    Default = false,
    Tooltip = "Automatically aim at nearest enemy",
}):AddKeyPicker("AimbotKey", {
    Default = "MB2",
    Mode = "Hold",
    Text = "Aimbot Key",
    SyncToggleState = false,
})

CombatLeft:AddSlider("AimbotSmoothness", {
    Text = "Smoothness",
    Default = 0.1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Tooltip = "Lower = faster snap",
})

CombatLeft:AddSlider("AimbotFOV", {
    Text = "FOV",
    Default = 200,
    Min = 50,
    Max = 800,
    Rounding = 0,
    Tooltip = "Aimbot field of view",
})

CombatLeft:AddToggle("AimbotTeamCheck", {
    Text = "Team Check",
    Default = true,
    Tooltip = "Ignore teammates",
})

local CombatRight = Tabs.Combat:AddRightGroupbox("Weapon", "sword")

CombatRight:AddToggle("AutoShoot", {
    Text = "Auto Shoot",
    Default = false,
    Tooltip = "Automatically click when aiming",
})

CombatRight:AddToggle("NoRecoil", {
    Text = "No Recoil",
    Default = false,
    Tooltip = "Removes camera recoil",
})

--// =====================
--//  VISUALS TAB
--// =====================
local VisualsLeft = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")

VisualsLeft:AddToggle("ESPEnabled", {
    Text = "ESP",
    Default = false,
    Tooltip = "Show players through walls",
})

VisualsLeft:AddToggle("ESPBox", {
    Text = "Box ESP",
    Default = true,
})

VisualsLeft:AddToggle("ESPName", {
    Text = "Name ESP",
    Default = true,
})

VisualsLeft:AddToggle("ESPDistance", {
    Text = "Distance ESP",
    Default = true,
})

VisualsLeft:AddToggle("ESPTeamCheck", {
    Text = "Team Check",
    Default = true,
})

VisualsLeft:AddToggle("ESPTracer", {
    Text = "Tracer ESP",
    Default = false,
})

local VisualsRight = Tabs.Visuals:AddRightGroupbox("Wallhack", "scan-eye")

VisualsRight:AddToggle("WallhackEnabled", {
    Text = "Wallhack",
    Default = false,
    Tooltip = "See players through walls",
})

VisualsRight:AddSlider("WallhackTransparency", {
    Text = "Transparency",
    Default = 0.5,
    Min = 0,
    Max = 1,
    Rounding = 2,
})

VisualsRight:AddToggle("WallhackTeamCheck", {
    Text = "Team Check",
    Default = true,
})

VisualsRight:AddToggle("ChamsEnabled", {
    Text = "Chams",
    Default = false,
    Tooltip = "Highlight players with color",
})

VisualsRight:AddColorPicker("ChamsColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Chams Color",
})

--// =====================
--//  MOVEMENT TAB
--// =====================
local MovementLeft = Tabs.Movement:AddLeftGroupbox("Speed", "zap")

MovementLeft:AddToggle("SpeedHackEnabled", {
    Text = "Speed Hack",
    Default = false,
    Tooltip = "Increase walk speed",
}):AddKeyPicker("SpeedHackKey", {
    Default = "LeftShift",
    Mode = "Hold",
    Text = "Speed Key",
})

MovementLeft:AddSlider("SpeedHackValue", {
    Text = "Speed Multiplier",
    Default = 2,
    Min = 1,
    Max = 10,
    Rounding = 1,
})

local MovementRight = Tabs.Movement:AddRightGroupbox("Misc", "feather")

MovementRight:AddToggle("NoclipEnabled", {
    Text = "Noclip",
    Default = false,
    Tooltip = "Walk through walls",
}):AddKeyPicker("NoclipKey", {
    Default = "N",
    Mode = "Toggle",
    Text = "Noclip Key",
})

MovementRight:AddToggle("InfiniteJumpEnabled", {
    Text = "Infinite Jump",
    Default = false,
    Tooltip = "Jump infinitely",
})

MovementRight:AddToggle("VFlyEnabled", {
    Text = "V-Fly",
    Default = false,
    Tooltip = "Vertical fly mode",
}):AddKeyPicker("VFlyKey", {
    Default = "F",
    Mode = "Toggle",
    Text = "V-Fly Key",
})

MovementRight:AddSlider("VFlySpeed", {
    Text = "Fly Speed",
    Default = 50,
    Min = 10,
    Max = 200,
    Rounding = 0,
})

--// =====================
--//  UI SETTINGS TAB
--// =====================
local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(value)
        Library.KeybindFrame.Visible = value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = Library.ShowCustomCursor,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {
    Default = "RightShift",
    NoUI = true,
    Text = "Menu keybind"
})

MenuGroup:AddButton({
    Text = "Unload",
    Func = function()
        Library:Unload()
    end,
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
ThemeManager:SetFolder("FPSCheat")
SaveManager:SetFolder("FPSCheat/settings")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
ThemeManager:ApplyToTab(Tabs["UI Settings"])

--// =====================
--//  CORE LOGIC
--// =====================

--// ESP System
local ESPObjects = {}
local function GetCharacter(player)
    return player.Character
end

local function GetHumanoid(character)
    return character:FindFirstChildOfClass("Humanoid")
end

local function GetRootPart(character)
    return character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
end

local function IsTeammate(player)
    if not LocalPlayer.Team then return false end
    return player.Team == LocalPlayer.Team
end

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local esp = {
        Box = Drawing.new("Square"),
        Name = Drawing.new("Text"),
        Distance = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        Highlight = nil,
    }
    
    esp.Box.Visible = false
    esp.Box.Thickness = 1
    esp.Box.Filled = false
    esp.Box.Color = Color3.fromRGB(255, 0, 0)
    
    esp.Name.Visible = false
    esp.Name.Size = 14
    esp.Name.Center = true
    esp.Name.Outline = true
    esp.Name.Color = Color3.fromRGB(255, 255, 255)
    
    esp.Distance.Visible = false
    esp.Distance.Size = 12
    esp.Distance.Center = true
    esp.Distance.Outline = true
    esp.Distance.Color = Color3.fromRGB(200, 200, 200)
    
    esp.Tracer.Visible = false
    esp.Tracer.Thickness = 1
    esp.Tracer.Color = Color3.fromRGB(255, 0, 0)
    
    ESPObjects[player] = esp
    return esp
end

local function RemoveESP(player)
    local esp = ESPObjects[player]
    if not esp then return end
    
    if esp.Box then esp.Box:Remove() end
    if esp.Name then esp.Name:Remove() end
    if esp.Distance then esp.Distance:Remove() end
    if esp.Tracer then esp.Tracer:Remove() end
    if esp.Highlight then esp.Highlight:Destroy() end
    
    ESPObjects[player] = nil
end

local function UpdateESP()
    for player, esp in pairs(ESPObjects) do
        local character = GetCharacter(player)
        if not character then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local root = GetRootPart(character)
        local humanoid = GetHumanoid(character)
        
        if not root or not humanoid or humanoid.Health <= 0 then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        if Toggles.ESPTeamCheck.Value and IsTeammate(player) then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
            if esp.Highlight then esp.Highlight.Enabled = false end
            continue
        end
        
        local size = Vector2.new(1000 / pos.Z, 1500 / pos.Z)
        local topLeft = Vector2.new(pos.X - size.X / 2, pos.Y - size.Y / 2)
        
        if Toggles.ESPEnabled.Value then
            if Toggles.ESPBox.Value then
                esp.Box.Visible = true
                esp.Box.Size = size
                esp.Box.Position = topLeft
                esp.Box.Color = IsTeammate(player) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            else
                esp.Box.Visible = false
            end
            
            if Toggles.ESPName.Value then
                esp.Name.Visible = true
                esp.Name.Position = Vector2.new(pos.X, topLeft.Y - 16)
                esp.Name.Text = player.Name
                esp.Name.Color = IsTeammate(player) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
            else
                esp.Name.Visible = false
            end
            
            if Toggles.ESPDistance.Value then
                esp.Distance.Visible = true
                esp.Distance.Position = Vector2.new(pos.X, topLeft.Y + size.Y + 2)
                local dist = math.floor((LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude or 0))
                esp.Distance.Text = tostring(dist) .. " studs"
            else
                esp.Distance.Visible = false
            end
            
            if Toggles.ESPTracer.Value then
                esp.Tracer.Visible = true
                esp.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                esp.Tracer.To = Vector2.new(pos.X, pos.Y)
                esp.Tracer.Color = IsTeammate(player) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            else
                esp.Tracer.Visible = false
            end
        else
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
        end
        
        --// Wallhack / Chams
        if Toggles.WallhackEnabled.Value or Toggles.ChamsEnabled.Value then
            if not esp.Highlight then
                local hl = Instance.new("Highlight")
                hl.Parent = character
                hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                esp.Highlight = hl
            end
            
            if Toggles.WallhackTeamCheck.Value and IsTeammate(player) then
                esp.Highlight.Enabled = false
            else
                esp.Highlight.Enabled = true
                if Toggles.ChamsEnabled.Value then
                    esp.Highlight.FillColor = Options.ChamsColor.Value
                    esp.Highlight.OutlineColor = Options.ChamsColor.Value
                    esp.Highlight.FillTransparency = 0.5
                    esp.Highlight.OutlineTransparency = 0
                else
                    esp.Highlight.FillColor = Color3.fromRGB(255, 255, 255)
                    esp.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    esp.Highlight.FillTransparency = Toggles.WallhackEnabled.Value and Options.WallhackTransparency.Value or 1
                    esp.Highlight.OutlineTransparency = Toggles.WallhackEnabled.Value and 0 or 1
                end
            end
        else
            if esp.Highlight then
                esp.Highlight.Enabled = false
            end
        end
    end
end

--// Initialize ESP for existing players
for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

--// Aimbot System
local function GetClosestPlayer()
    local closest = nil
    local closestDist = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local fov = Options.AimbotFOV.Value
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        
        local character = GetCharacter(player)
        if not character then continue end
        
        local root = GetRootPart(character)
        local humanoid = GetHumanoid(character)
        if not root or not humanoid or humanoid.Health <= 0 then continue end
        
        if Toggles.AimbotTeamCheck.Value and IsTeammate(player) then continue end
        
        local pos, onScreen = Camera:WorldToViewportPoint(root.Position)
        if not onScreen then continue end
        
        local dist = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
        if dist < fov and dist < closestDist then
            closestDist = dist
            closest = player
        end
    end
    
    return closest
end

local function AimAt(target)
    if not target then return end
    local character = GetCharacter(target)
    if not character then return end
    
    local root = GetRootPart(character)
    if not root then return end
    
    local targetPos = root.Position + Vector3.new(0, 1.5, 0)
    local smoothness = Options.AimbotSmoothness.Value
    
    if smoothness <= 0 then
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPos)
    else
        local targetCF = CFrame.new(Camera.CFrame.Position, targetPos)
        Camera.CFrame = Camera.CFrame:Lerp(targetCF, 1 - smoothness)
    end
end

--// Noclip System
local NoclipConnection = nil
local function SetNoclip(enabled)
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    
    if enabled then
        NoclipConnection = RunService.Stepped:Connect(function()
            if not LocalPlayer.Character then return end
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    else
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

--// Speed Hack System
local DefaultWalkSpeed = 16
local SpeedConnection = nil
local function SetSpeedHack(enabled)
    if SpeedConnection then
        SpeedConnection:Disconnect()
        SpeedConnection = nil
    end
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = GetHumanoid(char)
        if humanoid then
            if enabled then
                humanoid.WalkSpeed = DefaultWalkSpeed * Options.SpeedHackValue.Value
                SpeedConnection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                    humanoid.WalkSpeed = DefaultWalkSpeed * Options.SpeedHackValue.Value
                end)
            else
                humanoid.WalkSpeed = DefaultWalkSpeed
            end
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.1)
    if Toggles.SpeedHackEnabled.Value then
        SetSpeedHack(true)
    end
    if Toggles.NoclipEnabled.Value then
        SetNoclip(true)
    end
end)

--// Infinite Jump
local InfiniteJumpConnection = nil
local function SetInfiniteJump(enabled)
    if InfiniteJumpConnection then
        InfiniteJumpConnection:Disconnect()
        InfiniteJumpConnection = nil
    end
    
    if enabled then
        InfiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character then
                local humanoid = GetHumanoid(LocalPlayer.Character)
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

--// V-Fly System
local FlyConnection = nil
local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local function SetVFly(enabled)
    if FlyConnection then
        FlyConnection:Disconnect()
        FlyConnection = nil
    end
    
    if FlyBodyVelocity then
        FlyBodyVelocity:Destroy()
        FlyBodyVelocity = nil
    end
    
    if FlyBodyGyro then
        FlyBodyGyro:Destroy()
        FlyBodyGyro = nil
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local root = GetRootPart(char)
    if not root then return end
    
    if enabled then
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        FlyBodyVelocity.Velocity = Vector3.zero
        FlyBodyVelocity.Parent = root
        
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        FlyBodyGyro.P = 10000
        FlyBodyGyro.Parent = root
        
        FlyConnection = RunService.RenderStepped:Connect(function()
            if not FlyBodyVelocity or not FlyBodyVelocity.Parent then return end
            if not FlyBodyGyro or not FlyBodyGyro.Parent then return end
            
            local speed = Options.VFlySpeed.Value
            local velocity = Vector3.zero
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                velocity = velocity + Vector3.new(0, speed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift) then
                velocity = velocity + Vector3.new(0, -speed, 0)
            end
            
            FlyBodyVelocity.Velocity = velocity
            FlyBodyGyro.CFrame = Camera.CFrame
        end)
    end
end

--// Auto Shoot
local AutoShootConnection = nil
local function SetAutoShoot(enabled)
    if AutoShootConnection then
        AutoShootConnection:Disconnect()
        AutoShootConnection = nil
    end
    
    if enabled then
        AutoShootConnection = RunService.RenderStepped:Connect(function()
            if Toggles.AimbotEnabled.Value and Options.AimbotKey:GetState() then
                mouse1click()
            end
        end)
    end
end

--// No Recoil
local OriginalCameraCFrame = nil
local NoRecoilConnection = nil
local function SetNoRecoil(enabled)
    if NoRecoilConnection then
        NoRecoilConnection:Disconnect()
        NoRecoilConnection = nil
    end
    
    if enabled then
        NoRecoilConnection = RunService.RenderStepped:Connect(function()
            if OriginalCameraCFrame then
                Camera.CFrame = OriginalCameraCFrame
            end
            OriginalCameraCFrame = Camera.CFrame
        end)
    end
end

--// =====================
--//  CONNECTIONS
--// =====================

RunService.RenderStepped:Connect(function()
    -- ESP Update
    if Toggles.ESPEnabled.Value or Toggles.WallhackEnabled.Value or Toggles.ChamsEnabled.Value then
        UpdateESP()
    else
        for _, esp in pairs(ESPObjects) do
            esp.Box.Visible = false
            esp.Name.Visible = false
            esp.Distance.Visible = false
            esp.Tracer.Visible = false
            if esp.Highlight then esp.Highlight.Enabled = false end
        end
    end
    
    -- Aimbot
    if Toggles.AimbotEnabled.Value and Options.AimbotKey:GetState() then
        local target = GetClosestPlayer()
        if target then
            AimAt(target)
        end
    end
end)

--// Toggle Callbacks
Toggles.ESPEnabled:OnChanged(function()
    Notify("ESP", Toggles.ESPEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.WallhackEnabled:OnChanged(function()
    Notify("Wallhack", Toggles.WallhackEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.ChamsEnabled:OnChanged(function()
    Notify("Chams", Toggles.ChamsEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.AimbotEnabled:OnChanged(function()
    Notify("Aimbot", Toggles.AimbotEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.SpeedHackEnabled:OnChanged(function()
    SetSpeedHack(Toggles.SpeedHackEnabled.Value)
    Notify("Speed Hack", Toggles.SpeedHackEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.NoclipEnabled:OnChanged(function()
    SetNoclip(Toggles.NoclipEnabled.Value)
    Notify("Noclip", Toggles.NoclipEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.InfiniteJumpEnabled:OnChanged(function()
    SetInfiniteJump(Toggles.InfiniteJumpEnabled.Value)
    Notify("Infinite Jump", Toggles.InfiniteJumpEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.VFlyEnabled:OnChanged(function()
    SetVFly(Toggles.VFlyEnabled.Value)
    Notify("V-Fly", Toggles.VFlyEnabled.Value and "Enabled" or "Disabled", 2)
end)

Toggles.AutoShoot:OnChanged(function()
    SetAutoShoot(Toggles.AutoShoot.Value)
    Notify("Auto Shoot", Toggles.AutoShoot.Value and "Enabled" or "Disabled", 2)
end)

Toggles.NoRecoil:OnChanged(function()
    SetNoRecoil(Toggles.NoRecoil.Value)
    Notify("No Recoil", Toggles.NoRecoil.Value and "Enabled" or "Disabled", 2)
end)

Options.SpeedHackValue:OnChanged(function()
    if Toggles.SpeedHackEnabled.Value then
        SetSpeedHack(true)
    end
end)

--// Cleanup on unload
Library:OnUnload(function()
    for _, esp in pairs(ESPObjects) do
        if esp.Box then esp.Box:Remove() end
        if esp.Name then esp.Name:Remove() end
        if esp.Distance then esp.Distance:Remove() end
        if esp.Tracer then esp.Tracer:Remove() end
        if esp.Highlight then esp.Highlight:Destroy() end
    end
    
    if NoclipConnection then NoclipConnection:Disconnect() end
    if SpeedConnection then SpeedConnection:Disconnect() end
    if InfiniteJumpConnection then InfiniteJumpConnection:Disconnect() end
    if FlyConnection then FlyConnection:Disconnect() end
    if AutoShootConnection then AutoShootConnection:Disconnect() end
    if NoRecoilConnection then NoRecoilConnection:Disconnect() end
    
    Notify("Unloaded", "FPS Cheat has been unloaded", 3)
end)

Notify("FPS Cheat", "Script loaded successfully!", 3)
