-- Auto ESP Creator

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/exploiting/main/EngoUILib"))()
if not game.CoreGui:FindFirstChild("esp") then
    local a = Instance.new("Folder", game.CoreGui)
a.Name = "esp"
end

function createESP(itemName, espText, c1,c2,c3)
      local folder = Instance.new("Folder", game.CoreGui.esp)
              folder.Name = itemName 
              for i,v in pairs(game.Workspace:GetDescendants()) do  
                  if v.Name == itemName and v.Position then warn("here")
                      tb = {}   
                      table.insert(tb, v)
                         for i = 1, #tb do  
                    local esp = Instance.new("BillboardGui", game.CoreGui.esp[itemName])
                    esp.Adornee = v
                    esp.AlwaysOnTop=true
                    esp.ResetOnSpawn=false
                    esp.Size = UDim2.new(1,1,1,1)
                    esp.Name = v.Name

                    local tag = Instance.new("TextLabel", esp)
                    tag.Size = UDim2.new(5,5,5,5)
                    tag.Text = espText
                    tag.TextColor3 = Color3.fromRGB(c1, c2, c3)
                    tag.BackgroundTransparency = 1
                    end   
                  end
              end

wait(2)
while wait() do
                    game.CoreGui.esp:FindFirstChild(itemName)
                    for i,v in pairs(game.CoreGui.esp[itemName]:GetChildren()) do
                        if v then
                            local oo = {};
                            table.insert(oo, v.Name)
                            pcall(function()
                                local texts = math.ceil((v.Adornee.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                                local text = tostring(texts)
                                v.TextLabel.Text = espText.."\n[ "..text.." ]"
                                end)
                        end
                    end
end end
        
function espChildren(partName, parentName, espText, c1, c2, c3)
     local folder = Instance.new("Folder", game.CoreGui.esp)
              folder.Name = parentName
              for i,v in pairs(game.Workspace:GetDescendants()) do  
                  if v.Name == partName and v.Position and v:FindFirstAncestor(parentName) or v.Parent == parentName then warn("here")
                      tb = {}   
                      table.insert(tb, v)
                         for i = 1, #tb do  
                    local esp = Instance.new("BillboardGui", game.CoreGui.esp[parentName])
                    esp.Adornee = v
                    esp.AlwaysOnTop=true
                    esp.ResetOnSpawn=false
                    esp.Size = UDim2.new(1,1,1,1)
                    esp.Name = v.Name

                    local tag = Instance.new("TextLabel", esp)
                    tag.Size = UDim2.new(5,5,5,5)
                    tag.Text = espText
                    tag.TextColor3 = Color3.fromRGB(c1, c2, c3)
                    tag.BackgroundTransparency = 1
                    end   
                  end
              end

wait(2)
while wait() do
                    game.CoreGui.esp:FindFirstChild(parentName)
                    for i,v in pairs(game.CoreGui.esp[parentName]:GetChildren()) do
                        if v then
                             oo = {};
                            table.insert(oo, v.Name)
                            pcall(function()
                                local texts = math.ceil((v.Adornee.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                                local text = tostring(texts)
                                v.TextLabel.Text = espText.."\n[ "..text.." ]"
                                end)
                        end
                    end
end
    end


--espChildren("Part", "Gold Rock", "Diamond", 0,100,0)
--createESP("HumanoidRootPart", "Living", 0,0,200)

local ui = lib:CreateUI("Create ESP: Added Copy Script!!", Enum.KeyCode.RightShift)
local cooltab = ui:CreateTab("IsModel")
local etab = ui:CreateTab("IsObject")
local a1,a2,a3,c1,c2,c3
cooltab:CreateTextbox("Part", function(callback)
a1 = callback
end)

cooltab:CreateTextbox("Parent", function(callback)
a2 = callback
end)

cooltab:CreateTextbox("Name", function(callback)
a3 =callback
end)

cooltab:CreateTextbox("c1", function(callback)
c1 = callback
end)
cooltab:CreateTextbox("c2", function(callback)
c2 = callback
end)
cooltab:CreateTextbox("c3", function(callback)
c3 = callback
end)
cooltab:CreateToggle("Create", "ESP", function(callback)
if callback then
    espChildren(a1,a2,a3,c1,c2,c3) end
end)

pcall(function()
    if syn.is_cached(game) then
cooltab:CreateToggle("Copy Script", "ESP", function(callback)
    if callback then
        syn.write_clipboard([[
        if not game.CoreGui:FindFirstChild("esp") then
    local a = Instance.new("Folder", game.CoreGui)
a.Name = "esp"
end
        function espChildren(partName, parentName, espText, c1, c2, c3)
     local folder = Instance.new("Folder", game.CoreGui.esp)
              folder.Name = parentName
              for i,v in pairs(game.Workspace:GetDescendants()) do  
                  if v.Name == partName and v.Position and v:FindFirstAncestor(parentName) or v.Parent == parentName then warn("here")
                      tb = {}   
                      table.insert(tb, v)
                         for i = 1, #tb do  
                    local esp = Instance.new("BillboardGui", game.CoreGui.esp[parentName])
                    esp.Adornee = v
                    esp.AlwaysOnTop=true
                    esp.ResetOnSpawn=false
                    esp.Size = UDim2.new(1,1,1,1)
                    esp.Name = v.Name

                    local tag = Instance.new("TextLabel", esp)
                    tag.Size = UDim2.new(5,5,5,5)
                    tag.Text = espText
                    tag.TextColor3 = Color3.fromRGB(c1, c2, c3)
                    tag.BackgroundTransparency = 1
                    end   
                  end
              end

wait(2)
while wait() do
                    game.CoreGui.esp:FindFirstChild(parentName)
                    for i,v in pairs(game.CoreGui.esp[parentName]:GetChildren()) do
                        if v then
                             oo = {};
                            table.insert(oo, v.Name)
                            pcall(function()
                                local texts = math.ceil((v.Adornee.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                                local text = tostring(texts)
                                v.TextLabel.Text = espText.."\n[ "..text.." ]"
                                end)
                        end
                    end
end
        end

espChildren(]]..'"'..tostring(a1)..'"'..','..'"'..tostring(a2)..'"'..','..'"'..tostring(a3)..'"'..','..tostring(c1)..','..tostring(c2)..','..tostring(c3)..')')
    end 
end)
end
end)
local e1,e2,cc1,cc2,cc3

etab:CreateTextbox("Part", function(callback)
e1 = callback
end)

etab:CreateTextbox("Name", function(callback)
e2 =callback
end)

etab:CreateTextbox("c1", function(callback)
cc1 = callback
end)
etab:CreateTextbox("c2", function(callback)
cc2 = callback
end)
etab:CreateTextbox("c3", function(callback)
cc3 = callback
end)
etab:CreateToggle("Create", "ESP", function(callback)
if callback then
    createESP(e1,e2,cc1,cc2,cc3) end
end)
pcall(function()
    if syn.is_cached(game) then
etab:CreateToggle("Copy Script", "ESP", function(callback)
    syn.write_clipboard([[if not game.CoreGui:FindFirstChild("esp") then
    local a = Instance.new("Folder", game.CoreGui)
a.Name = "esp"
end
    function createESP(itemName, espText, c1,c2,c3)
      local folder = Instance.new("Folder", game.CoreGui.esp)
              folder.Name = itemName 
              for i,v in pairs(game.Workspace:GetDescendants()) do  
                  if v.Name == itemName and v.Position then warn("here")
                      tb = {}   
                      table.insert(tb, v)
                         for i = 1, #tb do  
                    local esp = Instance.new("BillboardGui", game.CoreGui.esp[itemName])
                    esp.Adornee = v
                    esp.AlwaysOnTop=true
                    esp.ResetOnSpawn=false
                    esp.Size = UDim2.new(1,1,1,1)
                    esp.Name = v.Name

                    local tag = Instance.new("TextLabel", esp)
                    tag.Size = UDim2.new(5,5,5,5)
                    tag.Text = espText
                    tag.TextColor3 = Color3.fromRGB(c1, c2, c3)
                    tag.BackgroundTransparency = 1
                    end   
                  end
              end

wait(2)
while wait() do
                    game.CoreGui.esp:FindFirstChild(itemName)
                    for i,v in pairs(game.CoreGui.esp[itemName]:GetChildren()) do
                        if v then
                            local oo = {};
                            table.insert(oo, v.Name)
                            pcall(function()
                                local texts = math.ceil((v.Adornee.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude)
                                local text = tostring(texts)
                                v.TextLabel.Text = espText.."\n[ "..text.." ]"
                                end)
                        end
                    end
end end

createESP(]]..'"'..tostring(e1)..'"'..','..'"'..tostring(e2)..'"'..','..tostring(cc1)..','..tostring(cc2)..','..tostring(cc3)..')'
        
        )
end)
end
end)
