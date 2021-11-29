frames = nil

local RunService = game:GetService("RunService")
RunService.RenderStepped:Connect(function(step)
frames = math.floor(1/step).." fps"
end)

function CreateInstance(cls, props) local inst = Instance.new(cls) for i,v in pairs(props) do inst[i] = v end return inst end
local UserInputService = game:GetService("UserInputService")
fpscounter = CreateInstance("ScreenGui", {ZIndexBehavior=Enum.ZIndexBehavior.Global, ResetOnSpawn=false, Name="fpscounter", Parent=game.CoreGui})
syn.protect_gui(fpscounter)
textHolder = CreateInstance("Frame", {BackgroundColor3=Color3.fromRGB(100, 100, 100), BorderColor3=Color3.fromRGB(100, 100, 100), Position=UDim2.new(0.00853788853, 0, 0.0364473727, 0), Size=UDim2.new(0, 129, 0, 33), Name = "textHolder", Parent=fpscounter})
border = CreateInstance("Frame", {BackgroundColor3=Color3.fromRGB(30, 30, 30), BorderColor3=Color3.fromRGB(30, 30, 30), BorderSizePixel=0, Position=UDim2.new(0.00999999978, 0, 0.0520000011, 0), Size=UDim2.new(0, 128, 0, 30), Name="border", Parent=textHolder})
gradient = CreateInstance("Frame", {Name="gradient", Parent=textHolder, BackgroundColor3=Color3.fromRGB(255, 255, 255), BorderSizePixel=0, Position = UDim2.new(0.00999999978, 0, 0.0289999992, 0), Size = UDim2.new(0, 127, 0, 3) })
UIGradient = CreateInstance("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 175, 218)), ColorSequenceKeypoint.new(0.51, Color3.fromRGB(198, 73, 205)), ColorSequenceKeypoint.new(1, Color3.fromRGB(204, 219, 61))}, Name="UIGradient", Parent=gradient})
fps = CreateInstance("TextLabel", {BackgroundColor3=Color3.fromRGB(255, 255, 255), BackgroundTransparency=1, Position=UDim2.new(0.0100000072, 0, 0.18051517, 0), Size=UDim2.new(0, 127, 0, 20), Font=Enum.Font.Code, Text="", TextColor3=Color3.fromRGB(255, 255, 255), TextSize=16, Name="fps", Parent=textHolder})

local loop = "chimkin"
repeat
	wait(.25)
fps.Text = (frames)
until loop == "rice"
