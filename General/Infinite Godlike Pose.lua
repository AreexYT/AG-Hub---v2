local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character
if not character or not character.Parent then
character = player.CharacterAdded:Wait()
end
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:WaitForChild("Animator")
local godAnimation = Instance.new("Animation")
godAnimation.AnimationId = "rbxassetid://3337994105"
local godAnimationTrack = animator:LoadAnimation(godAnimation)
spawn(function()
   while wait() do
       character.Animate.Disabled = true
       godAnimationTrack:Play()
       godAnimationTrack.TimePosition = 2.5
       wait(2.21)
   end
end)
