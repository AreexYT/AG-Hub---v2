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

espChildren("Torso","SCP106","SCP-106",100,100,100)
