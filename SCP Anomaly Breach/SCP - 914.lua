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

createESP("Machine914","SCP-914",255,0,255)