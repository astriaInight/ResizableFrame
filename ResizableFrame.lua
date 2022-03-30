-- Written by @AstrialNight 3/30/22

-- Config
local Len = 0.05
local MinX, MinY = 80, 80
local MaxX, MaxY = 1800, 1000
local Frame = script.Parent.Parent
local Resizer = script.Parent

local UserInput = game:GetService("UserInputService")
local Tween = game:GetService("TweenService")

local MouseDown = false

local function Resize(x, y)
	local fx, fy = Frame.AbsolutePosition.X, Frame.AbsolutePosition.Y
	local sx, sy = Frame.AbsoluteSize.X, Frame.AbsoluteSize.Y
	
	local nx = math.min(math.max(x - fx, MinX), MaxX)
	local ny = math.min(math.max(y - fy, MinY), MaxY)
	
	Tween:Create(
		Frame,
		TweenInfo.new(Len, Enum.EasingStyle.Sine),
		{ Size = UDim2.new(0,  nx, 0, ny) }
	):Play()
end

UserInput.InputChanged:Connect(function(input, processed)
	if not MouseDown then return end
	
	if input.UserInputType ~= Enum.UserInputType.MouseMovement then return end
	
	Resize(input.Position.X, input.Position.Y)
end)

Resizer.InputBegan:Connect(function(input, processed)
	if processed then return end
	
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	
	MouseDown = true
end)

UserInput.InputEnded:Connect(function(input, processed)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

	MouseDown = false
end)