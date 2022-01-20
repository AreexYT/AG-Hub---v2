repeat wait() until game:IsLoaded()


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Audio Visualizer", "Midnight")

--> Tabs and Sections <--
local Main = Window:NewTab("Main")
local MS = Main:NewSection("Main:")
local Misc = Window:NewTab("Misc")
local MCS = Misc:NewSection("Misc:")
local Credits = Window:NewTab("Credits")
local CS = Credits:NewSection("Credits:")

--> Contents <--
CS:NewLabel("UI Library By xHeptc")
CS:NewLabel("Hub By giga chad buki lover")
CS:NewLabel("More Features Coming Soon..")
MS:NewButton("Synapse X Audio Visualizer", "Audio Visualizer Synapse X Edition", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/XmjaMecr"))()
end)
MS:NewButton("Universal Audio Visualizer", "Audio Visualizer works for all exploits Edition", function()
    repeat
    wait()
until game:IsLoaded()
wait()
print(string.rep("\n", 50))

if not syn or not syn.request then
    getgenv().syn = {}
    syn.request = http_request or request or (http and http.request)
end

local http_request = http_request or request or (http and http.request) or (syn and syn.request)

if KRNL_LOADED then
    getgenv().syn = nil
end
local exploit_type
if PROTOSMASHER_LOADED then
    exploit_type = "ProtoSmasher"
    print("ProtoSmasher")
elseif is_sirhurt_closure then
    exploit_type = "Sirhurt"
    print("Sirhurt")
elseif SENTINEL_LOADED then
    exploit_type = "Sentinel"
    print("Sentinel")
elseif syn then
    exploit_type = "Synapse X"
    wait(10)
    writefile("PineAppleSyn.txt", syn.request({Url = "https://github.com/MirayXS/Aux/raw/syn/UI.rbxm"}).Body)
    function wrap(script)
        f, e = loadstring(script.Source)
        print(f, e)
        env = setmetatable({},{__index = function(self, key) if key == "script" then return script end return getfenv()[key] end})
        setfenv(f, env)
        return f
    end
    e = game:GetObjects(getsynasset("PineAppleSyn.txt"))[1]
    e.Parent = game.CoreGui
    for i, v in pairs(e:GetDescendants()) do
        if v.ClassName:match("Script") then
            spawn(wrap(v))
        end
    end
elseif KRNL_LOADED then
    exploit_type = "KRNL"
    print("KRNL")
elseif hookfunction_raw and hmjdfk then
    exploit_type = "Fluxus Mac Free"
    print("Fluxus Mac Free")
    if not getconnections then
        getgenv().getconnections = function()
            return {}
        end
        getgenv().set_thread_context = function()
            return
        end
        getgenv().fluxus_loaded = true
    end
elseif FLUXUS_LOADED then
    exploit_type = "Fluxus"
    print("Fluxus")
elseif getexecutorname then
    exploit_type = "Script-Ware"
    print("Script-Ware")
    -- else
    -- game.Players.LocalPlayer:Kick("Your executor is not supported!")
    -- error("Executor not Supported!")
    -- end
end
if true then
    writefile("PineApple.txt", 'exploit_type = "' .. exploit_type .. '"')
    print(string.rep("=", 50))
    print("[Aux | Pineapple]: Authenticated!")
    print(string.rep("=", 50))
    print('[Aux | pineapple]: exploit_type = "' .. exploit_type .. '"')
    print(string.rep("=", 50))
end

wait(5)

-- // Loadstring
if game.CoreGui:FindFirstChild("Aux_Pineapple") then
    game.CoreGui.Aux_Pineapple:Destroy()
end



-- // Old: loadstring(game:HttpGet(("https://raw.githubusercontent.com/MirayXS/Aux/main/Pineapple.lua"), true))()



local owner = "MirayXS"
local branch = "main"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Aux/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("Pineapple")
end)
MCS:NewTextBox("WalkSpeed", "WalkSpeed Changer", function(txt) -- 1000 (MaxValue) | 16 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = txt
end)
MCS:NewTextBox("JumpPower", "JumpPower Changer", function(txt) -- 5000 (MaxValue) | 50 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = txt
end)
MCS:NewTextBox("Print", "Type in chat: /console to read your print", function(txt)
	print(txt)
    print("if you see this, i love you")
end)
MS:NewKeybind("Toggle UI", "Toggle UI ON/OFF, you can change the bind", Enum.KeyCode.E, function()
	Library:ToggleUI()
end)
