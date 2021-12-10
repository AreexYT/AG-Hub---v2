-- Infinite Stamina

local setreadonly = setreadonly or make_writeable
local stamina = game.workspace[game.Players.LocalPlayer.Name].Stamina
local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)
mt.__index = newcclosure(function(tbl, idx)
if idx == "Value" and tbl == stamina then
return 100
end
return old(tbl, idx)
end)
