-- ZASZ HUB MOBILE

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer

-- SETTINGS
local hitboxSize = 10
local transparency = 0.5
local flySpeed = 60
local flying = false
local esp = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ZASZ_MOBILE"

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 260, 0, 300)
main.Position = UDim2.new(0.1,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "📱 ZASZ HUB"
title.TextColor3 = Color3.fromRGB(255,255,0)
title.BackgroundTransparency = 1
title.TextScaled = true

-- CLOSE / OPEN
local close = Instance.new("TextButton", main)
close.Text = "X"
close.Size = UDim2.new(0,30,0,30)
close.Position = UDim2.new(1,-35,0,5)

local open = Instance.new("TextButton", gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0,80,0,80)
open.Text = "Z"
open.Visible = false
open.BackgroundColor3 = Color3.fromRGB(255,255,0)
open.Active = true
open.Draggable = true

close.MouseButton1Click:Connect(function()
	main.Visible = false
	open.Visible = true
end)

open.MouseButton1Click:Connect(function()
	main.Visible = true
	open.Visible = false
end)

-- UI HELPERS
local function button(y,text,callback)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0,220,0,35)
	b.Position = UDim2.new(0,20,0,y)
	b.Text = text
	b.MouseButton1Click:Connect(callback)
	return b
end

local function box(y,text)
	local b = Instance.new("TextBox", main)
	b.Size = UDim2.new(0,220,0,30)
	b.Position = UDim2.new(0,20,0,y)
	b.PlaceholderText = text
	return b
end

-- HITBOX LOOP
RunService.RenderStepped:Connect(function()
	for _,p in pairs(Players:GetPlayers()) do
		if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = p.Character.HumanoidRootPart
			hrp.Size = Vector3.new(hitboxSize,hitboxSize,hitboxSize)
			hrp.Transparency = transparency
			hrp.Material = Enum.Material.Neon
			hrp.BrickColor = BrickColor.new("New Yeller")
			hrp.CanCollide = false
		end
	end
end)

-- ESP
local function addESP(p)
	if p ~= LP then
		p.CharacterAdded:Connect(function(c)
			local h = Instance.new("Highlight", c)
			h.FillColor = Color3.new(1,1,0)
			h.FillTransparency = 0.4
		end)
	end
end

button(60,"Toggle ESP",function()
	esp = not esp
	if esp then
		for _,p in pairs(Players:GetPlayers()) do
			addESP(p)
		end
	end
end)

-- FLY BUTTON
local flyBtn = button(100,"Toggle Fly",function()
	flying = not flying
end)

-- FLY SYSTEM
local bv
RunService.RenderStepped:Connect(function()
	if flying then
		local char = LP.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local hrp = char.HumanoidRootPart
			
			if not bv then
				bv = Instance.new("BodyVelocity", hrp)
				bv.MaxForce = Vector3.new(1e9,1e9,1e9)
			end
			
			bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
		end
	else
		if bv then bv:Destroy() bv=nil end
	end
end)

-- INPUTS
box(150,"Hitbox Size (0-300)").FocusLost:Connect(function(self)
	local v = tonumber(self.Text)
	if v then hitboxSize = math.clamp(v,0,300) end
end)

box(190,"Transparency (0-1)").FocusLost:Connect(function(self)
	local v = tonumber(self.Text)
	if v then transparency = math.clamp(v,0,1) end
end)

box(230,"Fly Speed").FocusLost:Connect(function(self)
	local v = tonumber(self.Text)
	if v then flySpeed = v end
end)
