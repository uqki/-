-- FPSチート (ESP + Wallhack + Aimbot) モバイル対応
-- 注意: 使用は自己責任です

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local function Notify(title, text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

-- GUI作成 (モバイル操作用)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FPS_Cheat_GUI"
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 350)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 35)
titleLabel.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
titleLabel.Text = "FPS CHEAT v1.0"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextScaled = true
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = mainFrame

local function createToggle(labelText, yPos, initialValue, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = mainFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Text = labelText
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 30)
    toggle.Position = UDim2.new(0.75, 0, 0.5, -15)
    toggle.BackgroundColor3 = initialValue and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 50, 50)
    toggle.Text = initialValue and "ON" or "OFF"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.TextScaled = true
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 1
    toggle.BorderColor3 = Color3.new(0.5, 0.5, 0.5)
    toggle.Parent = frame

    local state = initialValue
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.BackgroundColor3 = state and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 50, 50)
        toggle.Text = state and "ON" or "OFF"
        callback(state)
    end)

    return { setState = function(v) state = v; toggle.BackgroundColor3 = v and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 50, 50); toggle.Text = v and "ON" or "OFF" end }
end

local espEnabled = true
local wallEnabled = true
local aimEnabled = true
local aimFov = 120
local aimSmooth = 0.3

createToggle("ESP", 45, espEnabled, function(v) espEnabled = v end)
createToggle("Wallhack", 90, wallEnabled, function(v) wallEnabled = v end)
createToggle("Aimbot", 135, aimEnabled, function(v) aimEnabled = v end)

-- FOVスライダー
local fovSlider = Instance.new("Frame")
fovSlider.Size = UDim2.new(1, -20, 0, 35)
fovSlider.Position = UDim2.new(0, 10, 0, 185)
fovSlider.BackgroundTransparency = 1
fovSlider.Parent = mainFrame

local fovLabel = Instance.new("TextLabel")
fovLabel.Size = UDim2.new(0.5, 0, 1, 0)
fovLabel.Text = "Aimbot FOV: " .. aimFov
fovLabel.TextColor3 = Color3.new(1, 1, 1)
fovLabel.TextScaled = true
fovLabel.TextXAlignment = Enum.TextXAlignment.Left
fovLabel.BackgroundTransparency = 1
fovLabel.Font = Enum.Font.Gotham
fovLabel.Parent = fovSlider

local fovButton = Instance.new("TextButton")
fovButton.Size = UDim2.new(0, 80, 0, 30)
fovButton.Position = UDim2.new(0.6, 0, 0.5, -15)
fovButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
fovButton.Text = tostring(aimFov)
fovButton.TextColor3 = Color3.new(1, 1, 1)
fovButton.TextScaled = true
fovButton.Font = Enum.Font.GothamBold
fovButton.BorderSizePixel = 1
fovButton.Parent = fovSlider

fovButton.MouseButton1Click:Connect(function()
    aimFov = aimFov + 10
    if aimFov > 300 then aimFov = 60 end
    fovButton.Text = tostring(aimFov)
    fovLabel.Text = "Aimbot FOV: " .. aimFov
end)

-- ステータス表示
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 30)
statusLabel.Position = UDim2.new(0, 10, 0, 235)
statusLabel.Text = "Status: Active"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
statusLabel.TextScaled = true
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 80, 0, 35)
closeBtn.Position = UDim2.new(0.5, -40, 0, 280)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "×"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    Notify("Cheat", "Disabled", 2)
end)

Notify("FPS Cheat", "Loaded successfully!", 3)

-- ===== ESP + WALLHACK =====
local espObjects = {}
local wallObjects = {}

local function createESPLine(player)
    if espObjects[player] then return end
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(2, 4.5, 2)
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Color3 = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.5
    box.Adornee = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    box.Parent = player.Character and player.Character:FindFirstChild("HumanoidRootPart") or player

    local nameTag = Instance.new("BillboardGui")
    nameTag.Size = UDim2.new(0, 200, 0, 30)
    nameTag.AlwaysOnTop = true
    nameTag.Parent = player.Character and player.Character:FindFirstChild("Head") or player

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name .. " (" .. math.floor((player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health or 0)) .. "HP)"
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.Parent = nameTag

    local distanceGui = Instance.new("BillboardGui")
    distanceGui.Size = UDim2.new(0, 100, 0, 20)
    distanceGui.Position = UDim2.new(0, 0, 0, 25)
    distanceGui.AlwaysOnTop = true
    distanceGui.Parent = player.Character and player.Character:FindFirstChild("Head") or player

    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 1, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.TextScaled = true
    distLabel.Font = Enum.Font.Gotham
    distLabel.Parent = distanceGui

    espObjects[player] = { box = box, nameTag = nameTag, distanceGui = distanceGui, distLabel = distLabel }
end

local function removeESP(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            if obj and obj.Parent then obj:Destroy() end
        end
        espObjects[player] = nil
    end
end

local function updateWallhack(player)
    if wallObjects[player] then return end
    if not player.Character then return end
    for _, part in pairs(player.Character:GetChildren()) do
        if part:IsA("BasePart") then
            local orig = part.LocalTransparencyModifier
            part.LocalTransparencyModifier = 0.3
            wallObjects[player] = wallObjects[player] or {}
            table.insert(wallObjects[player], { part = part, orig = orig })
        end
    end
end

local function removeWallhack(player)
    if wallObjects[player] then
        for _, data in pairs(wallObjects[player]) do
            if data.part and data.part.Parent then
                data.part.LocalTransparencyModifier = data.orig or 0
            end
        end
        wallObjects[player] = nil
    end
end

-- プレイヤー追跡
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if espEnabled then createESPLine(player) end
        if wallEnabled then updateWallhack(player) end
    end)
    player.CharacterRemoving:Connect(function()
        removeESP(player)
        removeWallhack(player)
    end)
end)

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        if player.Character then
            task.wait(0.3)
            if espEnabled then createESPLine(player) end
            if wallEnabled then updateWallhack(player) end
        end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if espEnabled then createESPLine(player) end
            if wallEnabled then updateWallhack(player) end
        end)
        player.CharacterRemoving:Connect(function()
            removeESP(player)
            removeWallhack(player)
        end)
    end
end

-- 距離更新ループ
RunService.Heartbeat:Connect(function()
    local camPos = Camera.CFrame.Position
    for player, data in pairs(espObjects) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - camPos).Magnitude
            if data.distLabel then
                data.distLabel.Text = math.floor(dist) .. "m"
            end
        end
    end
end)

-- ===== AIMBOT =====
local function getClosestPlayer()
    local closest = nil
    local closestDist = aimFov
    local camPos = Camera.CFrame.Position
    local camLook = Camera.CFrame.LookVector

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local pos = head.Position
                local dir = (pos - camPos).Unit
                local angle = math.deg(math.acos(camLook:Dot(dir)))
                local dist = (pos - camPos).Magnitude
                if angle < closestDist and dist < 500 then
                    closestDist = angle
                    closest = player
                end
            end
        end
    end
    return closest
end

-- モバイルタッチでエイム
UserInputService.TouchStarted:Connect(function(input)
    if not aimEnabled then return end
    local target = getClosestPlayer()
    if target and target.Character and target.Character:FindFirstChild("Head") then
        local headPos = target.Character.Head.Position
        local camPos = Camera.CFrame.Position
        local dir = (headPos - camPos).Unit
        local targetCFrame = CFrame.lookAt(camPos, camPos + dir)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, aimSmooth)
    end
end)

-- トグル更新用
local espToggle, wallToggle, aimToggle
-- 再トグル処理は元のcreateToggleでコールバックが動くので追加処理
Notify("FPS Cheat", "All systems ready. Use GUI to configure.", 4)

-- 終了時クリーンアップ
game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    for player in pairs(espObjects) do removeESP(player) end
    for player in pairs(wallObjects) do removeWallhack(player) end
    espObjects = {}
    wallObjects = {}
end)
