local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local repo = "https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()

-- Constants:
local LocalPlayer = Players.LocalPlayer
local BoundKeys = LocalPlayer.PlayerScripts.PlayerModule.CameraModule.MouseLockController.BoundKeys

local FarmMethods = { "Coins only (Silent)", "Coins and EXP (Visible)", "Coins, EXP, and Kills (Blatant)" }

local GunHighlight = Instance.new("Highlight")
local GunHandleAdornment = Instance.new("SphereHandleAdornment")

-- Variables:
local murderer, sheriff, hero
local roles = {}
local visuals = {}

-- Functions:
local function findAngleDelta(a, b)
	return math.deg(math.acos(a:Dot(b)))
end

local function isCharacterValid(character: Model)
	if character and character:IsA("Model") then
		local humanoid = character:FindFirstChildWhichIsA("Humanoid")
		if humanoid and humanoid.Health > 0 then
			local root = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
			if root then
				return true
			end
		end
	end
	return false
end

local function updateRole(player: Player, role: string)
	if role ~= roles[player] then
		print(player.Name .. " is now " .. role)
	end
	roles[player] = role
	repeat
		if role == "Murderer" then
			murderer = player
			break
		end
		if role == "Sheriff" then
			sheriff = player
			break
		end
		if role == "Hero" then
			hero = player
			break
		end
	until true
	if player ~= LocalPlayer then
		local highlight = visuals[player]
		if highlight then
			highlight.FillColor = Options[role .. "_Color"].Value
		end
	end
end

local function onPlayerAdded(player: Player) -- Fires on Player joined
	-- Creates Highlight:
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Options.Unknown_Color.Value
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.RobloxLocked = true
	if syn then
		syn.protect_gui(highlight)
	end
	visuals[player] = highlight
	highlight.Parent = CoreGui

	-- Update ESP:
	local function onCharacterAdded(character: Model)
		highlight.Adornee = character
	end

	player.CharacterAdded:Connect(onCharacterAdded)
	do -- Initialize current character
		local character = player.Character
		if character then
			onCharacterAdded(character)
		end
	end
end

local function onPlayerRemoving(player: Player) -- Fires on Player left
	-- Destroys Highlight:
	local highlight = visuals[player]
	highlight:Destroy()

	-- Cleanup:
	visuals[player] = nil
	roles[player] = nil
end

local function handleAutoFarm()

end

-- Interface:
do
	Library:SetWatermark("Linoria Community (OminousVibes)")
	Library:Notify("Loading UI...")

	local Window = Library:CreateWindow("Murder Mystery 2")

	do -- Legit
		local Tab = Window:AddTab("Legit")

		do -- Roles
			local Container = Tab:AddLeftTabbox("Roles")

			local Murd = Container:AddTab("Murderer")
			Murd:AddToggle("Reach", { Text = "Hitbox Extender", Default = false })
			Murd:AddSlider(
				"Reach",
				{ Text = "Hitbox Radius", Min = 5, Max = 20, Default = 10, Rounding = 0, Suffix = "studs" }
			)
			Murd:AddSlider(
				"ReachAngle",
				{ Text = "Hitbox Angle", Min = 10, Max = 180, Default = 60, Rounding = 0, Suffix = "degrees" }
			)
            Murd:AddToggle("StabAll", { Text = "Kill All (Swing your knife)", Default = false })

			local Sher = Container:AddTab("Sheriff")
			Sher
				:AddToggle("SilentAim", { Text = "Silent Aim", Default = false })
				:AddKeyPicker("SilentAim", { Text = "Silent Aim", Default = "G", Mode = "Toggle" })
			Sher:AddSlider(
				"Prediction",
				{ Text = "Prediction", Min = 0, Max = 100, Default = 10, Rounding = 0, Suffix = "%" }
			)

			local Innocent = Container:AddTab("Innocent")
			Innocent
				:AddToggle("Callouts", { Text = "Callout Murderer", Default = false })
				:AddKeyPicker("Callouts", { Text = "Callouts", NoUI = true })
			Innocent:AddInput(
				"CalloutMessage",
				{ Text = "Callout Message", Default = "Murderer is ${murderer}, Sheriff is ${sheriff}" }
			)
			Innocent:AddToggle("AutoGun", { Text = "Auto-Pickup Gun", Default = false })
		end

		do -- Others
			local Container = Tab:AddRightGroupbox("Others")
			Container
				:AddToggle("SpeedHack", { Text = "Speed Hack", Default = false })
				:AddKeyPicker("SpeedHack", { Text = "Speed", Default = "LeftShift", Mode = "Hold" })
			Container:AddSlider("Speed", { Text = "Speed", Min = 1, Max = 10, Default = 2, Rounding = 1, Suffix = "" })
			Container
				:AddToggle("LockBind", { Text = "Bind Shift-Lock", Default = false })
				:AddKeyPicker("LockBind", { Text = "Key", Default = "LeftControl", NoUI = true })
		end

        do -- Progression
            local Container = Tab:AddLeftTabbox("Progression")

			local AutoFarm = Container:AddTab("Auto Farm (WIP)")
			AutoFarm:AddToggle("AutoFarm", { Text = "Enabled", Default = false })
            AutoFarm:AddDropdown("FarmMethod", { Text = "Farm Algorithm", Default = FarmMethods[1], Values = FarmMethods })
            AutoFarm:AddToggle("FarmNotifications", { Text = "Status Notifications", Default = false })
        end
	end

	do -- Visuals
		local Tab = Window:AddTab("Visuals")
		do -- Visuals
			local Container = Tab:AddLeftTabbox("Visuals")

			local Player = Container:AddTab("Player")
			Player:AddToggle("PlayerChams", { Text = "ESP", Default = true })

			local World = Container:AddTab("World")
			World:AddToggle("GunChams", { Text = "Gun Chams", Default = false })

			local Settings = Container:AddTab("Settings")
			Settings:AddLabel("Murderer Color"):AddColorPicker("Murderer_Color", { Default = Color3.new(1, 0, 0) })
			Settings:AddLabel("Sheriff Color"):AddColorPicker("Sheriff_Color", { Default = Color3.new(0, 0, 1) })
			Settings:AddLabel("Hero Color"):AddColorPicker("Hero_Color", { Default = Color3.new(1, 1, 0) })
			Settings:AddLabel("Innocent Color"):AddColorPicker("Innocent_Color", { Default = Color3.new(1, 1, 1) })
			Settings:AddLabel("Unknown Color"):AddColorPicker("Unknown_Color", { Default = Color3.new(0.5, 0.5, 0.5) })
		end

		do -- World Render
			local Container = Tab:AddRightGroupbox("World Render")
			Container:AddLabel("Work in progress")
		end
	end

	do -- Settings
		local Tab = Window:AddTab("Settings")

		ThemeManager:SetLibrary(Library)
		SaveManager:SetLibrary(Library)

		ThemeManager:SetFolder("OminousVibes")
		SaveManager:SetFolder("OminousVibes/MurderMystery2")

		SaveManager:IgnoreThemeSettings()
		SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

		SaveManager:BuildConfigSection(Tab)
		ThemeManager:ApplyToTab(Tab)

		local Menu = Tab:AddLeftGroupbox("Menu")
		Menu:AddButton("Unload", function()
			Library:Unload()
		end)
		Menu:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "End", NoUI = true, Text = "Menu keybind" })

		Menu:AddToggle("Keybinds", { Text = "Show Keybinds Menu", Default = true }):OnChanged(function()
			Library.KeybindFrame.Visible = Toggles.Keybinds.Value
		end)
		Menu:AddToggle("Watermark", { Text = "Show Watermark", Default = true }):OnChanged(function()
			Library:SetWatermarkVisibility(Toggles.Watermark.Value)
		end)
	end

    Toggles.AutoFarm:OnChanged(function()
        while Toggles.AutoFarm.Value do
            local character = LocalPlayer.Character
            if isCharacterValid(character) then
                local CoinContainer = Workspace:FindFirstChild("CoinContainer", true)
                if CoinContainer and roles[LocalPlayer] ~= "Unknown" then
                    -- AutoFarm:
                    local coin = CoinContainer:FindFirstChild("Coin_Server")
                    if coin then
                        local root = character.HumanoidRootPart
                        repeat
                            root.CFrame = CFrame.new(coin.Position - Vector3.new(0, 2.5, 0)) * CFrame.Angles(0, 0, math.rad(180))
                            RunService.Stepped:Wait()
                            if Toggles.AutoFarm.Value then break end
                        until not coin:IsDescendantOf(Workspace) or coin.Name ~= "Coin_Server"
                        task.wait(0.5)
                    end
                else
                    task.wait(0.5)
                end
            end
            task.wait()
        end
    end)

	Options.Callouts:OnClick(function() -- Callout
		if Toggles.Callouts.Value then
			local callout = Options.CalloutMessage.Value
			local message = callout
				:gsub("${murderer}", murderer and murderer.Name or "NaN")
				:gsub("${sheriff}", sheriff and sheriff.Name or "NaN")
			ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "normalchat")
		end
	end)

	Library:Notify("UI Loaded")
end

-- Listeners:
Players.PlayerAdded:Connect(onPlayerAdded)
Players.PlayerRemoving:Connect(onPlayerRemoving)

local lastCFrame = false
RunService.RenderStepped:Connect(function(deltaTime)
	local character = LocalPlayer.Character
	if isCharacterValid(character) then
		if Toggles.Reach.Value then
			local Knife = character:FindFirstChild("Knife")
			if Knife and Knife:IsA("Tool") then
				local HumanoidRootPart = character.HumanoidRootPart
				for i, v in ipairs(Players:GetPlayers()) do
					if v ~= LocalPlayer and isCharacterValid(v.Character) then
						local EnemyRoot = v.Character.HumanoidRootPart
						local EnemyPosition = EnemyRoot.Position
						local Distance = (EnemyPosition - HumanoidRootPart.Position).Magnitude
						local Angle = findAngleDelta(
							HumanoidRootPart.CFrame.LookVector.Unit,
							(EnemyPosition - HumanoidRootPart.Position).Unit
						)
						if Toggles.StabAll.Value or (Distance <= Options.Reach.Value and Angle <= Options.ReachAngle.Value) then
							firetouchinterest(EnemyRoot, Knife.Handle, 1)
							firetouchinterest(EnemyRoot, Knife.Handle, 0)
						end
					end
				end
			end
		end

        if Toggles.AutoGun.Value and roles[LocalPlayer] == "Innocent" then
            local gundrop = Workspace:FindFirstChild("GunDrop")
            if gundrop and not lastCFrame then
                lastCFrame = character.HumanoidRootPart.CFrame
                task.spawn(pcall, function()
                    repeat
                        character.HumanoidRootPart.CFrame = gundrop.CFrame
                        RunService.Stepped:Wait()
                    until not gundrop:IsDescendantOf(Workspace) or not Toggles.AutoGun.Value
                    character.HumanoidRootPart.CFrame = lastCFrame
                    lastCFrame = false
                end)
            end
        end

		if Toggles.SpeedHack.Value then
			local SpeedState = Options.SpeedHack:GetState()
			if SpeedState then
				character.Humanoid.WalkSpeed = 16 + Options.Speed.Value
			else
				character.Humanoid.WalkSpeed = 16
			end
		end
	end

	if Toggles.LockBind.Value then
		BoundKeys.Value = Options.LockBind.Value or "LeftControl"
	else
		BoundKeys.Value = "LeftShift, RightShift"
	end

    -- Gun Chams:
    local gundrop = Workspace:FindFirstChild("GunDrop")
    GunHighlight.Adornee = gundrop
    GunHandleAdornment.Adornee = gundrop
    if gundrop then GunHandleAdornment.Size = gundrop.Size + Vector3.new(0.05, 0.05, 0.05) end

    -- Visuals:
    for i,v in pairs(visuals) do
        v.Enabled = Toggles.PlayerChams.Value
    end
    GunHighlight.Enabled = Toggles.GunChams.Value
    GunHandleAdornment.Visible = Toggles.GunChams.Value
end)

ReplicatedStorage.Fade.OnClientEvent:Connect(function(data)
	for i, v in ipairs(Players:GetPlayers()) do
		local info = data[v.Name]
		if info then
			local role = typeof(info) == "table" and info.Role or "Unknown"
			pcall(updateRole, v, role)
		end
	end
end)
ReplicatedStorage.UpdatePlayerData.OnClientEvent:Connect(function(data)
	for i, v in ipairs(Players:GetPlayers()) do
		local info = data[v.Name]
		if info then
			local role = typeof(info) == "table" and info.Role or "Unknown"
			pcall(updateRole, v, role)
		end
	end
end)
ReplicatedStorage.RoleSelect.OnClientEvent:Connect(function(role, ...)
	updateRole(LocalPlayer, role or "Unknown")
end)
ReplicatedStorage.Remotes.Gameplay.RoundEndFade.OnClientEvent:Connect(function()
	for i, v in pairs(roles) do
		updateRole(i, "Unknown")
	end
	murderer, sheriff, hero = nil, nil, nil
end)

-- MetaMethods:
local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
	local method = getnamecallmethod()
	local args = { ... }
	if not checkcaller() then
		if typeof(self) == "Instance" then
			if self.Name == "ShootGun" and method == "InvokeServer" then
				if Toggles.SilentAim.Value and Options.SilentAim:GetState() then
					if murderer then
						local root = murderer.Character.PrimaryPart
						local velocity = root.AssemblyLinearVelocity
						local aimPosition = root.Position
							+ (
								velocity
								* Vector3.new(Options.Prediction.Value / 200, 0, Options.Prediction.Value / 200)
							)
						args[2] = aimPosition
					end
				end
			end
		end
	end
	return __namecall(self, unpack(args))
end)

-- Actions:
GunHighlight.FillColor = Options.Hero_Color.Value
GunHighlight.Adornee = Workspace:FindFirstChild("GunDrop")
GunHighlight.OutlineTransparency = 1
GunHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
GunHighlight.RobloxLocked = true

GunHandleAdornment.Color3 = Options.Hero_Color.Value
GunHandleAdornment.Transparency = 0.2
GunHandleAdornment.Adornee = Workspace:FindFirstChild("GunDrop")
GunHandleAdornment.AlwaysOnTop = true
GunHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Never
GunHandleAdornment.RobloxLocked = true

if syn then
	syn.protect_gui(GunHighlight)
end
if syn then
	syn.protect_gui(GunHandleAdornment)
end
GunHighlight.Parent = CoreGui
GunHandleAdornment.Parent = CoreGui

for i, v in ipairs(Players:GetPlayers()) do
	if v ~= LocalPlayer then
		onPlayerAdded(v)
	end
end

local data = ReplicatedStorage.GetPlayerData:InvokeServer()
for i, v in ipairs(Players:GetPlayers()) do
	local info = data[v.Name]
	if info then
		local role = typeof(info) == "table" and info.Role or "Unknown"
		pcall(updateRole, v, role)
	end
end

return Library:Notify("[Murder Mystery 2] Loaded")

-- -- Humanoid ESP + Silent Aim




-- -- [ Services ] --
-- local Services = setmetatable({}, {__index = function(Self, Index)
-- local NewService = game.GetService(game, Index)
-- if NewService then
-- Self[Index] = NewService
-- end
-- return NewService
-- end})

-- -- [ Modules ] --
-- --[[
-- local OrnamentalMouse = loadstring(game:HttpGet("https://raw.githubusercontent.com/iHavoc101/Genesis-Studios/main/Modules/OrnamentalMouse.lua", true))().new()
-- OrnamentalMouse.Sensitivity = 0.9
-- OrnamentalMouse.AutoUpdate = false
-- ]]

-- -- [ LocalPlayer ] --
-- local LocalPlayer = Services.Players.LocalPlayer
-- local Camera = workspace.CurrentCamera

-- -- [ Weapon Names ] --
-- local WeaponNames = {
--    Knife = {
-- Index = "Murderer";
-- Color = Color3.fromRGB(255, 0, 0)
-- };
-- Gun = {
-- Index = "Sheriff";
-- Color = Color3.fromRGB(0, 0, 255)
-- };
-- }

-- local AttackAnimations = {
--    "rbxassetid://2467567750";
--    "rbxassetid://1957618848";
--    "rbxassetid://2470501967";
--    "rbxassetid://2467577524";
-- }

-- -- // Variables \\ --
-- -- [ Roles ] --
-- local Roles = {
--    Murderer = nil;
--    Sheriff = nil;
--    Closest = nil;
-- }

-- local ESPInstances = {}
-- local ESPToggle = true

-- local SilentAIMEnabled = true

-- -- [ Character ] --
-- local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
-- local Humanoid = Character:WaitForChild("Humanoid")
-- LocalPlayer.CharacterAdded:Connect(function(Character)
-- Character = Character
-- Humanoid = Character:WaitForChild("Humanoid")
-- end)

-- -- [ Raycast Parameters ] --
-- local RaycastParameters = RaycastParams.new()
-- RaycastParameters.IgnoreWater = true
-- RaycastParameters.FilterType = Enum.RaycastFilterType.Blacklist
-- RaycastParameters.FilterDescendantsInstances = {LocalPlayer.Character}

-- -- // Functions \\ --
-- -- [ Main ] --
-- local Functions = {}

-- -- ESP --
-- function Functions.ESP(Part, Color)
--    if Part:FindFirstChildOfClass('BoxHandleAdornment') then
--        return Part:FindFirstChildOfClass('BoxHandleAdornment')
--    end

--    local Box = Instance.new("BoxHandleAdornment")
--    Box.Size = Part.Size + Vector3.new(0.1, 0.1, 0.1)
--    Box.Name = "Mesh"
--    Box.Visible = ESPToggle
--    Box.Adornee = Part
--    Box.Color3 = Color
--    Box.AlwaysOnTop = true
--    Box.ZIndex = 5
--    Box.Transparency = 0.5
--    Box.Parent = Part

--    table.insert(ESPInstances, Box)

--    return Box
-- end

-- -- Notify Roles --
-- function Functions.NotifyRoles()
--    if Roles.Murderer then
--        -- Murderer --
--        local Image, Ready = Services.Players:GetUserThumbnailAsync(Roles.Murderer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
--        Services.StarterGui:SetCore("SendNotification", {
--            Title = 'Murderer';
--            Text = Roles.Murderer.Name;
--            Icon = Image;
--            Duration = 5;
--        })
--    end

--    if Roles.Sheriff then
--        -- Sheriff --
--        local Image, Ready = Services.Players:GetUserThumbnailAsync(Roles.Sheriff.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
--        Services.StarterGui:SetCore("SendNotification", {
--            Title = 'Sheriff';
--            Text = Roles.Sheriff.Name;
--            Icon = Image;
--            Duration = 5;
--        })
--    end
-- end

-- -- GetClosestPlayer --
-- function Functions.GetClosestPlayer(MaxDistance)
--    local ClosestPlayer = nil
--    local FarthestDistance = MaxDistance or math.huge

--    for i, v in ipairs(Services.Players.GetPlayers(Services.Players)) do
--        if v ~= LocalPlayer then
--            pcall(function()
--                local DistanceFromPlayer = (LocalPlayer.Character.PrimaryPart.Position - v.Character.PrimaryPart.Position).Magnitude
--                if DistanceFromPlayer < FarthestDistance then
--                    FarthestDistance = DistanceFromPlayer
--                    ClosestPlayer = v
--                end
--            end)
--        end
--    end

--    return ClosestPlayer
-- end

-- -- [ Event ] --
-- local EventFunctions = {}

-- function EventFunctions.Initialize(Player)
--    local function CharacterAdded(Character)
--        Player:WaitForChild("Backpack").ChildAdded:Connect(function(Child)
--            local Role = WeaponNames[Child.Name]
--            if Role then
-- Roles[Role.Index] = Player

--                local Cham = Functions.ESP(Player.Character.HumanoidRootPart, Role.Color)

--                local Animator = Player.Character:FindFirstChildWhichIsA("Humanoid"):WaitForChild("Animator")
--                Animator.AnimationPlayed:Connect(function(AnimationTrack)
--                    if (AnimationTrack and AnimationTrack.Animation) == nil then
--                        return
--                    end

--                    if table.find(AttackAnimations, AnimationTrack.Animation.AnimationId) then
--                        Cham.Color3 = Color3.fromRGB(255, 0, 255)

--                        while true do
--                            Services.RunService.Heartbeat:Wait(0.01)
--                            local PlayingAnimations = Animator:GetPlayingAnimationTracks()
--                            local StillAttacking = false
--                            for i,v in ipairs(PlayingAnimations) do
--                                if table.find(AttackAnimations, v.Animation.AnimationId) then
--                                    StillAttacking = true
--                                end
--                            end
--                            if StillAttacking == false then
--                                break
--                            end
--                        end

--                        Cham.Color3 = Role.Color
--                    end
--                end)
--            end
--        end)
--    end

--    CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
--    Player.CharacterAdded:Connect(CharacterAdded)
-- end

-- function EventFunctions.GunAdded(Child)
--    if Child.Name == "GunDrop" then
--        Functions.ESP(Child, Color3.fromRGB(0, 255, 0))
--    end
-- end

-- function EventFunctions.ContextActionService_C(actionName, InputState, inputObject)
-- if InputState == Enum.UserInputState.End then
-- return
--    end
   
--    Functions.NotifyRoles()
-- end

-- function EventFunctions.ContextActionService_V(actionName, InputState, inputObject)
-- if InputState == Enum.UserInputState.End then
-- return
--    end

--    if Humanoid.WalkSpeed == 16.5 or Humanoid.WalkSpeed == 16 then
-- Humanoid.WalkSpeed = 28
-- else
-- Humanoid.WalkSpeed = 16.5
--    end

--    Services.StarterGui:SetCore("SendNotification", {
-- Title = 'Speed Change';
-- Text = tostring(Humanoid.WalkSpeed);
-- Duration = 3;
-- })
-- end

-- function EventFunctions.ContextActionService_B(actionName, InputState, inputObject)
-- if InputState == Enum.UserInputState.End then
-- return
--    end

--    ESPToggle = not ESPToggle
--    for i,v in ipairs(ESPInstances) do
--        v.Visible = ESPToggle
--        if v.Parent == nil then
--            table.remove(ESPInstances, i)
--        end
--    end
-- end

-- function EventFunctions.ContextActionService_G(actionName, InputState, inputObject)
--    if InputState == Enum.UserInputState.End then
-- return
--    end
--    SilentAIMEnabled = not SilentAIMEnabled
--    Services.StarterGui:SetCore("SendNotification", {
-- Title = 'Silent Aim';
-- Text = "Enabled: " .. tostring(SilentAIMEnabled);
-- Duration = 3;
-- })
-- end

-- -- // Metatable \\ --
-- local RawMetatable = getrawmetatable(game)
-- local OldNameCall = RawMetatable.__namecall
-- setreadonly(RawMetatable, false)

-- RawMetatable.__namecall = newcclosure(function(Object, ...)
--    local NamecallMethod = getnamecallmethod()
--    local Arguments = {...}

--    if SilentAIMEnabled == true then
--        RaycastParameters.FilterDescendantsInstances = {LocalPlayer.Character}
--        if NamecallMethod == "FireServer" and tostring(Object) == "Throw" then
--            local Success, Error = pcall(function()
--                local Closest = Functions.GetClosestPlayer()
--                local PrimaryPart = Closest.Character.PrimaryPart
--                local Velocity = PrimaryPart.AssemblyLinearVelocity * Vector3.new(1, 0, 1)
--                local Magnitude = (PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude
--                local Prediction = Velocity * 0.5 * Magnitude / 100
--                local Result = workspace.Raycast(workspace, LocalPlayer.Character.PrimaryPart.Position, (PrimaryPart.Position - (LocalPlayer.Character.PrimaryPart.Position + Prediction)).Unit * 200, RaycastParameters)
--                Arguments[2] = Result.Position
--            end)
--            if not Success then
--                warn(Error)
--            end
--        elseif NamecallMethod == "InvokeServer" and tostring(Object) == "ShootGun" and Roles.Murderer then
--            local Success, Error = pcall(function()
--                local PrimaryPart = Roles.Murderer.Character.PrimaryPart
--                local Prediction = PrimaryPart.AssemblyLinearVelocity / 40
--                if math.abs(PrimaryPart.AssemblyLinearVelocity.Y) < 10 then
--                    Arguments[2] = PrimaryPart.Position + Prediction
--                else
--                    return "Nullify Remote"
--                end
--            end)
--            if not Success then
--                warn(Error)
--            elseif Success == "Nullify Remote" then
--                warn("Null")
--                return
--            end
--        end
--    end

--    return OldNameCall(Object, unpack(Arguments))
-- end)

-- setreadonly(RawMetatable, true)

-- -- // Event Listeners \\ --
-- for i,v in ipairs(Services.Players:GetPlayers()) do
-- EventFunctions.Initialize(v)
-- end
-- Services.Players.PlayerAdded:Connect(EventFunctions.Initialize)

-- workspace.ChildAdded:Connect(EventFunctions.GunAdded)

-- -- [ Binds ] --
-- --Services.ContextActionService:BindAction('SprintBind', EventFunctions.ContextActionService_V, false, Enum.KeyCode.V)
-- --Services.ContextActionService:BindAction('NotifyBind', EventFunctions.ContextActionService_C, false, Enum.KeyCode.C)
-- --Services.ContextActionService:BindAction('ESPBind', EventFunctions.ContextActionService_B, false, Enum.KeyCode.B)
-- --Services.ContextActionService:BindAction('AIMBind', EventFunctions.ContextActionService_G, false, Enum.KeyCode.G)

-- -- // Actions \\ --
