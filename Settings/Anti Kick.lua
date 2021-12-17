-- Anti Kick.lua

if game:IsLoaded() ~= true then
    game.Loaded:Wait()
end
function Notify(NT, NTT)
    game.StarterGui:SetCore('SendNotification', {
        Title = NT, 
        Text = NTT
    })
end
local Players = game:GetService('Players')
local s,e = pcall(function()
    local GC = getconnections or get_signal_cons
	if GC then
		for i,v in pairs(GC(Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
		Notify('Anti-Idle Enabled', 'Successfully Enabled Anti-Idle. Close ROBLOX to disable.')
	else
		Notify('Your Exploit is Incompatible', 'Your Executor does not have GetConnections, you cannot use this script.')
		script:Destroy()
	end
end)
if not s then warn(e); script:Destroy() end
