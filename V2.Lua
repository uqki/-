-- Roblox FPS Cheats - Obsidian UI (fixed)
-- ESP, Wallhack, Aimbot, Noclip, Speedhack
-- Library: https://github.com/deividcomsono/Obsidian (Library.lua)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local espEnabled = true
local wallhackEnabled = true
local aimbotEnabled = true
local noclipEnabled = true
local speedhackEnabled = true
local speedValue = 50

local espBox = {}
local wallhackLines = {}

local function createESP(plr)
    if plr == player then return end
    local box = Drawing.new("Square")
    box.Thickness = 2
    box.Color = Color3.fromRGB(255, 0, 0)
    box.Filled = false
    box.Transparency = 1
    box.Visible = false

    local name = Drawing.new("Text")
    name.Size = 16
    name.Color = Color3.fromRGB(255, 255, 255)
    name.Outline = true
    name.OutlineColor = Color3.fromRGB(0, 0, 0)
    name.Visible = false

    local distance = Drawing.new("Text")
    distance.Size = 14
    distance.Color = Color3.fromRGB(255, 255, 255)
    distance.Outline = true
    distance.OutlineColor = Color3.fromRGB(0, 0, 0)
    distance.Visible = false

    local lines = {}
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Thickness = 2
        line.Color = Color3.fromRGB(255, 0, 0)
        line.Transparency = 1
        line.Visible = false
        table.insert(lines, line)
    end

    espBox[plr] = {box = box, name = name, distance = distance, lines = lines}
end

local function updateESP()
    for plr, data in pairs(espBox) do
        if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
            data.box.Visible = false
            data.name.Visible = false
            data.distance.Visible = false
            for _, line in ipairs(data.lines) do line.Visible = false end
            continue
        end

        local root = plr.Character.HumanoidRootPart
        local head = plr.Character:FindFirstChild("Head")
        local screenPos, onScreen = camera:WorldToViewportPoint(root.Position)
        if not onScreen then
            data.box.Visible = false
            data.name.Visible = false
            data.distance.Visible = false
            for _, line in ipairs(data.lines) do line.Visible = false end
            continue
        end

        local headPos = camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local feetPos = camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))

        local height = headPos.Y - feetPos.Y
        local width = height / 2

        data.box.Size = Vector2.new(width, height)
        data.box.Position = Vector2.new(headPos.X - width/2, headPos.Y - height/2)
        data.box.Visible = espEnabled

        data.name.Text = plr.Name
        data.name.Position = Vector2.new(headPos.X, headPos.Y - height - 20)
        data.name.Visible = espEnabled

        data.distance.Text = math.floor((root.Position - camera.CFrame.Position).Magnitude) .. " studs"
        data.distance.Position = Vector2.new(headPos.X, headPos.Y + height + 5)
        data.distance.Visible = espEnabled

        if wallhackEnabled then
            for i, line in ipairs(data.lines) do
                line.Color = Color3.fromRGB(255, 0, 0)
                line.Visible = true
            end
            data.lines[1].From = headPos
            data.lines[1].To = Vector2.new(headPos.X, headPos.Y + height)
            data.lines[2].From = Vector2.new(headPos.X + width, headPos.Y + height)
            data.lines[2].To = headPos
            data.lines[3].From = headPos
            data.lines[3].To = Vector2.new(headPos.X, headPos.Y - height)
            data.lines[4].From = Vector2.new(headPos.X - width, headPos.Y - height)
            data.lines[4].To = headPos
        end
    end
end

local function aimbotLoop()
    if not aimbotEnabled then return end
    local closest, closestDist = nil, math.huge
    for plr, data in pairs(espBox) do
        if plr \~= player and plr.Character and plr.Character:FindFirstChild("Head") then
            local headPos = plr.Character.Head.Position
            local screen, _ = camera:WorldToViewportPoint(headPos)
            if screen.Z > 0 then
                local dist = (headPos - camera.CFrame.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = headPos
                end
            end
        end
    end
    if closest then
        local targetCFrame = CFrame.new(camera.CFrame.Position, closest)
        camera.CFrame = camera.CFrame:Lerp(targetCFrame, 0.2)
    end
end

local function noclipLoop()
    if not noclipEnabled or not humanoid then return end
    humanoid:ChangeState(11)
end

local function speedhackLoop()
    if not speedhackEnabled or not rootPart then return end
    rootPart.Velocity = rootPart.CFrame.LookVector * speedValue
end

-- Obsidian Library Load
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

local Window = Library:CreateWindow({
    Title = "FPS Cheats - Obsidian",
    Footer = "Rat's Edge",
    ToggleKeybind = Enum.KeyCode.RightShift,
    Center = true,
    AutoShow = true
})

local MainTab = Window:AddTab("Main", "rocket")

-- ESP Tab
local ESPTab = MainTab:AddTab("ESP", "eye")
ESPTab:AddToggle("ESP", {Text = "ESP", Default = true, Callback = function(v) espEnabled = v end})
ESPTab:AddToggle("Wallhack", {Text = "Wallhack", Default = true, Callback = function(v) wallhackEnabled = v end})

-- Aim Tab
local AimTab = MainTab:AddTab("Aimbot", "crosshair")
AimTab:AddToggle("Aimbot", {Text = "Aimbot", Default = true, Callback = function(v) aimbotEnabled = v end})

-- Misc Tab
local MiscTab = MainTab:AddTab("Misc", "settings")
MiscTab:AddToggle("Noclip", {Text = "Noclip", Default = true, Callback = function(v) noclipEnabled = v end})
MiscTab:AddSlider("Speed", {Text = "Speed Value", Default = 50, Min = 16, Max = 100, Callback = function(v) speedValue = v end})
MiscTab:AddToggle("Speedhack", {Text = "Speedhack", Default = true, Callback = function(v) speedhackEnabled = v end})

-- Character
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = newChar:WaitForChild("Humanoid")
    rootPart = newChar:WaitForChild("HumanoidRootPart")
end)

-- ESP Setup
for _, plr in ipairs(Players:GetPlayers()) do createESP(plr) end
Players.PlayerAdded:Connect(createESP)

-- Loops
RunService.RenderStepped:Connect(updateESP)
RunService.Heartbeat:Connect(aimbotLoop)
RunService.Heartbeat:Connect(noclipLoop)
RunService.Heartbeat:Connect(speedhackLoop)

print("Roblox FPS Cheats Obsidian loaded clean. Workshop warm. Edge sharp.")
