-- Custom Blue UI ScreenGui
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local SideBar = Instance.new("Frame")
local ContentArea = Instance.new("Frame")

-- Tabs & Frames
local PlayerBtn = Instance.new("TextButton")
local GameBtn = Instance.new("TextButton")
local SettingsBtn = Instance.new("TextButton")

local PlayerTab = Instance.new("ScrollingFrame")
local GameTab = Instance.new("ScrollingFrame")
local SettingsTab = Instance.new("ScrollingFrame")

-- Gui Parent
ScreenGui.Name = "StealEggHubUI"
ScreenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame (Blue Theme)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 42)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 550, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 58, 138)
TitleBar.Size = UDim2.new(1, 0, 0, 40)

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 10)

TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(1, -30, 1, 0)
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Text = "STEAL AN EGG HUB 🥚 [BLUE EDITION]"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Sidebar
SideBar.Parent = MainFrame
SideBar.BackgroundColor3 = Color3.fromRGB(23, 37, 84)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.Size = UDim2.new(0, 130, 1, -40)

-- Tab Buttons Creator Function
local function createTabButton(name, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = SideBar
    btn.BackgroundColor3 = Color3.fromRGB(30, 64, 175)
    btn.Position = UDim2.new(0, 10, 0, pos)
    btn.Size = UDim2.new(0, 110, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 6)
    return btn
end

PlayerBtn = createTabButton("PLAYER", 15)
GameBtn = createTabButton("GAME", 60)
SettingsBtn = createTabButton("SETTINGS", 105)

-- Content Area
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 140, 0, 50)
ContentArea.Size = UDim2.new(1, -150, 1, -60)

local function createTabFrame()
    local frame = Instance.new("ScrollingFrame")
    frame.Parent = ContentArea
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.CanvasSize = UDim2.new(0, 0, 2, 0)
    frame.ScrollBarThickness = 4
    frame.Visible = false
    return frame
end

PlayerTab = createTabFrame()
GameTab = createTabFrame()
SettingsTab = createTabFrame()

PlayerTab.Visible = true

-- Tab Switch Logic
PlayerBtn.MouseButton1Click:Connect(function()
    PlayerTab.Visible = true
    GameTab.Visible = false
    SettingsTab.Visible = false
end)

GameBtn.MouseButton1Click:Connect(function()
    PlayerTab.Visible = false
    GameTab.Visible = true
    SettingsTab.Visible = false
end)

SettingsBtn.MouseButton1Click:Connect(function()
    PlayerTab.Visible = false
    GameTab.Visible = false
    SettingsTab.Visible = true
end)

----------------------------------------------------
-- 1. PLAYER TAB CONTENT
----------------------------------------------------
-- Speed Box
local SpeedLabel = Instance.new("TextLabel", PlayerTab)
SpeedLabel.Text = "WalkSpeed (1 to 10,000,000):"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 5)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left

local SpeedInput = Instance.new("TextBox", PlayerTab)
SpeedInput.Parent = PlayerTab
SpeedInput.Position = UDim2.new(0, 0, 0, 30)
SpeedInput.Size = UDim2.new(1, -10, 0, 30)
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 58, 138)
SpeedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedInput.Text = "16"

SpeedInput.FocusLost:Connect(function()
    local val = tonumber(SpeedInput.Text)
    if val and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = math.clamp(val, 1, 10000000)
    end
end)

-- Toggle Button Function
local function createToggle(parent, name, pos, callback)
    local toggleBtn = Instance.new("TextButton", parent)
    toggleBtn.Position = UDim2.new(0, 0, 0, pos)
    toggleBtn.Size = UDim2.new(1, -10, 0, 35)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(23, 37, 84)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Text = name .. " : OFF"
    
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.Text = name .. (state and " : ON" or " : OFF")
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(37, 99, 235) or Color3.fromRGB(23, 37, 84)
        callback(state)
    end)
end

createToggle(PlayerTab, "Auto Treadmill (AFK Mode)", 70, function(val) print("Auto Treadmill:", val) end)
createToggle(PlayerTab, "Auto Upgrade Treadmill", 115, function(val) print("Auto Upgrade Treadmill:", val) end)
createToggle(PlayerTab, "Auto Upgrade Base", 160, function(val) print("Auto Upgrade Base:", val) end)
createToggle(PlayerTab, "Auto Steal Egg", 205, function(val) print("Auto Steal Egg:", val) end)

----------------------------------------------------
-- 2. GAME TAB CONTENT
----------------------------------------------------
local InfoText = Instance.new("TextLabel", GameTab)
InfoText.Size = UDim2.new(1, -10, 0, 150)
InfoText.Position = UDim2.new(0, 0, 0, 10)
InfoText.BackgroundColor3 = Color3.fromRGB(23, 37, 84)
InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.Text = " 🌙 Night Reset Stats:\n\n 🥚 Golden Egg -> $100,000 [Dragon 🐉]\n 🥚 Volcano Egg -> $50,000 [Phoenix 🦅]\n 🥚 Ice Egg -> $20,000 [Ice Bear 🐻]\n 🥚 Forest Egg -> $5,000 [Wolf 🐺]"

----------------------------------------------------
-- 3. SETTINGS TAB CONTENT
----------------------------------------------------
local CloseBtn = Instance.new("TextButton", SettingsTab)
CloseBtn.Size = UDim2.new(1, -10, 0, 35)
CloseBtn.Position = UDim2.new(0, 0, 0, 10)
CloseBtn.BackgroundColor3 = Color3.fromRGB(185, 28, 28)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Text = "Unload / Close UI"

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
