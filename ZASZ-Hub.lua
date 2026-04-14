-- ZASZ HUB v13 MOBILE + SOPHIE RAIN BEACH EDITION
-- Draggable • Collapsible Circle • Mobile Optimized

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZASZ_HUB_MOBILE"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000
ScreenGui.Parent = gui

-- COLLAPSIBLE CIRCLE BUTTON (Mobile Optimized)
local CircleBtn = Instance.new("ImageButton")
CircleBtn.Name = "ToggleBtn"
CircleBtn.Parent = ScreenGui
CircleBtn.BackgroundColor3 = Color3.fromRGB(255,50,150)
CircleBtn.Position = UDim2.new(0,20,0,100)  -- Mobile safe position
CircleBtn.Size = UDim2.new(0,80,0,80)
CircleBtn.Image = "rbxassetid://3926305904"  -- Circle icon
CircleBtn.ImageTransparency = 0.2
CircleBtn.ImageColor3 = Color3.fromRGB(255,255,255)

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1,40)
CircleCorner.Parent = CircleBtn

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Color = Color3.fromRGB(255,100,200)
CircleStroke.Thickness = 3
CircleStroke.Parent = CircleBtn

-- MAIN FRAME (Mobile Small Size)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(8,8,18)
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -250)
MainFrame.Size = UDim2.new(0,360,0,500)  -- Mobile friendly size
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

-- Frame Corner
local FrameCorner = Instance.new("UICorner")
FrameCorner.CornerRadius = UDim.new(0,20)
FrameCorner.Parent = MainFrame

-- Frame Stroke
local FrameStroke = Instance.new("UIStroke")
FrameStroke.Color = Color3.fromRGB(255,100,200)
FrameStroke.Thickness = 2
FrameStroke.Parent = MainFrame

-- SOPHIE RAIN BEACH BACKGROUND
local SophieBG = Instance.new("ImageLabel")
SophieBG.Name = "SophieRainBeach"
SophieBG.Parent = MainFrame
SophieBG.BackgroundTransparency = 1
SophieBG.Position = UDim2.new(0,0,0,0)
SophieBG.Size = UDim2.new(1,0,1,0)
SophieBG.Image = "rbxassetid://18416517881"  -- Sophie Rain beach sexy
SophieBG.ImageColor3 = Color3.fromRGB(255,240,255)
SophieBG.ImageTransparency = 0.72
SophieBG.ScaleType = Enum.ScaleType.Crop
SophieBG.ZIndex = 0

-- Dark Overlay
local Overlay = Instance.new("Frame")
Overlay.Parent = MainFrame
Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 0.38
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.ZIndex = 1

-- TITLE BAR (Draggable Area)
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(25,15,40)
TitleBar.Size = UDim2.new(1,0,0,55)
TitleBar.ZIndex = 10

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0,20)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundTransparency = 1
TitleLabel.Size = UDim2.new(1,-100,1,0)
TitleLabel.Position = UDim2.new(0,20,0,0)
TitleLabel.Text = "ZASZ HUB v13 | SOPHIE RAIN 🌊"
TitleLabel.TextColor3 = Color3.fromRGB(255,150,255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 11

-- CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TitleBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,80,80)
CloseBtn.Position = UDim2.new(1,-55,0,8)
CloseBtn.Size = UDim2.new(0,45,0,38)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.TextScaled = true
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.ZIndex = 11

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,12)
CloseCorner.Parent = CloseBtn

-- SCROLL CONTENT
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Parent = MainFrame
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.Position = UDim2.new(0,15,0,65)
ScrollFrame.Size = UDim2.new(1,-30,1,-80)
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255,150,255)
ScrollFrame.CanvasSize = UDim2.new(0,0,0,900)
ScrollFrame.ScrollBarImageTransparency = 0.3
ScrollFrame.ZIndex = 3

-- TOGGLE FUNCTION (Mobile Optimized)
local function CreateToggle(yPos, text, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Parent = ScrollFrame
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Size = UDim2.new(1,0,0,55)
    ToggleFrame.Position = UDim2.new(0,0,0,yPos)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = ToggleFrame
    Label.BackgroundTransparency = 1
    Label.Size = UDim2.new(1,-90,1,0)
    Label.Position = UDim2.new(0,15,0,0)
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255,255,255)
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 4
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = ToggleFrame
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(255,100,150)
    ToggleBtn.Size = UDim2.new(0,75,0,40)
    ToggleBtn.Position = UDim2.new(1,-85,0.15,0)
    ToggleBtn.Text = "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.ZIndex = 4
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0,15)
    BtnCorner.Parent = ToggleBtn
    
    local BtnStroke = Instance.new("UIStroke")
    BtnStroke.Color = Color3.fromRGB(255,200,255)
    BtnStroke.Thickness = 1.5
    BtnStroke.Parent = ToggleBtn
    
    local enabled = false
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        ToggleBtn.BackgroundColor3 = enabled and Color3.fromRGB(100,255,150) or Color3.fromRGB(255,100,150)
        ToggleBtn.Text = enabled and "ON" or "OFF"
        callback(enabled)
    end)
end

-- UNIVERSAL FEATURES
CreateToggle(10, "🚀 Super Speed", function(state)
    if state and player.Character then
        player.Character.Humanoid.WalkSpeed = 120
    end
end)

CreateToggle(75, "🦘 High Jump", function(state)
    if player.Character then
        player.Character.Humanoid.JumpPower = state and 180 or 50
    end
end)

CreateToggle(140, "👻 Noclip Walk", function(state)
    spawn(function()
        while state do
            if player.Character then
                for _, part in pairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
            wait(0.1)
        end
    end)
end)

CreateToggle(205, "✈️ Fly (Hold SPACE)", function(state)
    local flySpeed = 50
    spawn(function()
        while state do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    root.Velocity = Vector3.new(0,flySpeed,0)
                end
            end
            wait()
        end
    end)
end)

CreateToggle(270, "🌈 Rainbow Sophie", function(state)
    if state then
        spawn(function()
            while state do
                SophieBG.ImageColor3 = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                FrameStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                CircleStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                wait(0.1)
            end
            SophieBG.ImageColor3 = Color3.fromRGB(255,240,255)
            FrameStroke.Color = Color3.fromRGB(255,100,200)
            CircleStroke.Color = Color3.fromRGB(255,100,200)
        end)
    end
end)

CreateToggle(335, "💖 Heart Beat Effect", function(state)
    if state then
        spawn(function()
            while state do
                local pulse = 0.68 + math.sin(tick() * 4) * 0.08
                SophieBG.ImageTransparency = pulse
                Overlay.BackgroundTransparency = pulse + 0.1
                wait(0.05)
            end
        end)
    end
end)

-- TOGGLE ANIMATION (CIRCLE BUTTON)
local function toggleUI()
    MainFrame.Visible = not MainFrame.Visible
    CircleBtn.ImageTransparency = MainFrame.Visible and 0.1 or 0.3
    TweenService:Create(CircleBtn, TweenInfo.new(0.3), {
        Size = MainFrame.Visible and UDim2.new(0,70,0,70) or UDim2.new(0,80,0,80),
        Rotation = MainFrame.Visible and 360 or 0
    }):Play()
end

CircleBtn.MouseButton1Click:Connect(toggleUI)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- MOBILE DRAG FIX
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.X.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- CIRCLE DRAG (Mobile)
local circleDragging, circleStart, circlePos
CircleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        circleDragging = true
        circleStart = input.Position
        circlePos = CircleBtn.Position
    end
end)

CircleBtn.InputChanged:Connect(function(input)
    if circleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - circleStart
        CircleBtn.Position = UDim2.new(0, circlePos.X.Offset + delta.X, 0, circlePos.Y.Offset + delta.Y)
    end
end)

CircleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        circleDragging = false
    end
end)

print("🌊 ZASZ HUB v13 MOBILE SOPHIE RAIN BEACH EDITION LOADED! 💖")
