-- Audio Bypass

if game.CoreGui:FindFirstChild("RadioGui") then game.CoreGui:FindFirstChild("RadioGui"):Destroy() end
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "RadioGui"
local frame = Instance.new("Frame", gui)
frame.Style = "DropShadow"
frame.Position = UDim2.new(0, 0, 0.75, 0)
frame.Size = UDim2.new(0.1, 0, 0.1, 0)
local text1 = Instance.new("TextLabel", frame)
text1.Size = UDim2.new(1, 0, 0.15, 0)
text1.BackgroundTransparency = 1
text1.Text = "Radio"
text1.Font = "SourceSansBold"
text1.FontSize = "Size18"
text1.TextColor3 = Color3.fromRGB(255, 255, 255)
text1.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
text1.TextStrokeTransparency = 0.7
local tb1 = Instance.new("TextBox", frame)
tb1.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
tb1.BorderSizePixel = 0
tb1.Font = "SourceSansItalic"
tb1.TextWrapped = true
tb1.FontSize = "Size14"
tb1.Size = UDim2.new(1, 0, 0.25, 0)
tb1.Position = UDim2.new(0, 0, 0.25, 0)
tb1.TextColor3 = Color3.fromRGB(255, 255, 255)
tb1.Text = "966572194"
local tbtn = Instance.new("TextButton", frame)
tbtn.Style = "RobloxRoundButton"
tbtn.Size = UDim2.new(1, 0, 0.35, 0)
tbtn.Font = "SourceSansBold"
tbtn.FontSize = "Size18"
tbtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tbtn.TextStrokeTransparency = 0.7
tbtn.Text = "Play"
tbtn.Position = UDim2.new(0, 0, 0.6, 0)
tbtn.MouseButton1Click:connect(function()
print(game.ReplicatedStorage:FindFirstChild("PlaySong"):FireServer("rbxassetid://"..tb1.Text))
end)
