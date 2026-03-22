-- ZASZ HUB FULL POLISHED DEV

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- SETTINGS
local Settings = {
	Hitbox=false,
	Size=10,
	ESP=false,
	Speed=16,
	Fly=false,
	Target=false
}

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ZASZ_POLISHED"

-- FLOAT BUTTON
local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0.05,0,0.4,0)
open.Text = "Z"
open.BackgroundColor3 = Color3.fromRGB(255,0,0)
open.TextScaled = true
open.Active = true
open.Draggable = true
Instance.new("UICorner", open).CornerRadius = UDim.new(1,0)

-- MAIN
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0,340,0,280)
main.Position = UDim2.new(0.1,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

-- TITLE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,30)
title.Text = "👑 ZASZ HUB POLISHED"
title.TextColor3 = Color3.fromRGB(255,0,0)
title.BackgroundTransparency = 1

-- TABS
local tabs = {"Combat","Player","Visuals","Aim"}
local frames = {}

for i,name in ipairs(tabs) do
	local btn = Instance.new("TextButton", main)
	btn.Size = UDim2.new(0.24,0,0,25)
	btn.Position = UDim2.new((i-1)*0.25,0,0,35)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
	Instance.new("UICorner", btn)
	
	local frame = Instance.new("Frame", main)
	frame.Size = UDim2.new(1,0,0,200)
	frame.Position = UDim2.new(0,0,0,65)
	frame.BackgroundTransparency = 1
	frame.Visible = (i==1)
	frames[name]=frame
	
	btn.MouseButton1Click:Connect(function()
		for _,f in pairs(frames) do f.Visible=false end
		frame.Visible=true
	end)
end

-- TOGGLE
local function toggle(parent,text,y,key)
	local t = Instance.new("TextButton", parent)
	t.Size = UDim2.new(0.8,0,0,30)
	t.Position = UDim2.new(0.1,0,0,y)
	t.Text = text.." : OFF"
	t.BackgroundColor3 = Color3.fromRGB(170,0,0)
	Instance.new("UICorner", t)

	t.MouseButton1Click:Connect(function()
		Settings[key]=not Settings[key]
		t.Text = text.." : "..(Settings[key] and "ON" or "OFF")
		t.BackgroundColor3 = Settings[key] and Color3.fromRGB(0,170,0) or Color3.fromRGB(170,0,0)
	end)
end

-- 🔥 FIXED SLIDER
local function slider(parent,text,min,max,y,key)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(1,0,0,20)
	label.Position = UDim2.new(0,0,0,y)
	label.Text = text..": "..Settings[key]
	label.TextColor3 = Color3.new(1,1,1)
	label.BackgroundTransparency = 1
	
	local bar = Instance.new("Frame", parent)
	bar.Size = UDim2.new(0.8,0,0,10)
	bar.Position = UDim2.new(0.1,0,0,y+25)
	bar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", bar)
	
	local fill = Instance.new("Frame", bar)
	fill.Size = UDim2.new(Settings[key]/max,0,1,0)
	fill.BackgroundColor3 = Color3.fromRGB(255,0,0)
	Instance.new("UICorner", fill)
	
	local knob = Instance.new("Frame", bar)
	knob.Size = UDim2.new(0,16,0,16)
	knob.Position = UDim2.new(Settings[key]/max,-8,0.5,-8)
	knob.BackgroundColor3 = Color3.fromRGB(255,0,0)
	Instance.new("UICorner", knob)

	local dragging = false

	local function update(input)
		local rel = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
		rel = math.clamp(rel,0,1)
		local val = math.floor(min + (max-min)*rel)
		
		fill.Size = UDim2.new(rel,0,1,0)
		knob.Position = UDim2.new(rel,-8,0.5,-8)
		label.Text = text..": "..val
		
		Settings[key] = val
	end

	knob.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
			update(input)
		end
	end)

	bar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
			update(input)
		end
	end)
end

-- COMBAT
toggle(frames["Combat"],"Hitbox",10,"Hitbox")
slider(frames["Combat"],"Size",0,100,50,"Size")

-- PLAYER
slider(frames["Player"],"Speed",16,100,10,"Speed")
toggle(frames["Player"],"Fly",60,"Fly")

-- VISUALS
toggle(frames["Visuals"],"ESP",10,"ESP")

-- AIM
toggle(frames["Aim"],"Target Lock",10,"Target")

-- OPEN
open.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- TARGET
local function getClosest()
	local closest,dist=nil,math.huge
	for _,p in pairs(Players:GetPlayers()) do
		if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local mag = (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
			if mag < dist then
				dist=mag
				closest=p
			end
		end
	end
	return closest
end

-- LOOP
RunService.RenderStepped:Connect(function()
	for _,p in pairs(Players:GetPlayers()) do
		if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			
			if Settings.Hitbox then
				hrp.Size = Vector3.new(Settings.Size,Settings.Size,Settings.Size)
				hrp.Transparency = 0.4
				hrp.Material = Enum.Material.Neon
				hrp.Color = Color3.fromRGB(255,0,0)
			end
			
			if Settings.ESP then
				if not p.Character:FindFirstChild("ESP") then
					local h = Instance.new("Highlight",p.Character)
					h.Name="ESP"
					h.FillColor=Color3.fromRGB(255,0,0)
					h.FillTransparency=0.5
				end
			end
		end
	end
	
	if LP.Character and LP.Character:FindFirstChild("Humanoid") then
		LP.Character.Humanoid.WalkSpeed = Settings.Speed
	end
	
	if Settings.Fly and LP.Character then
		LP.Character.HumanoidRootPart.Velocity = Vector3.new(0,50,0)
	end
	
	if Settings.Target and LP.Character then
		local t = getClosest()
		if t and t.Character then
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, t.Character.HumanoidRootPart.Position)
		end
	end
end)
