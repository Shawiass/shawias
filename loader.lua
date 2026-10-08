local function b64decode(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local encoded_payload = "LS0gVi5JLklCLkUuIE1vZGVybiBDYXJkIFVJIEh1YiAoQ3VzdG9tIFRoZW1lLCA=" -- V.I.I.B.E Loader Payload

local success, result = pcall(function()
    local full_code = [[
        -- V.I.I.B.E Modern Card UI Hub (Custom Theme, Slider, Keybind & Spin Edition)
        local CoreGui = game:GetService("CoreGui")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local VirtualUser = game:GetService("VirtualUser")

        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera

        if CoreGui:FindFirstChild("VIIBE_Card_UI") then
            CoreGui.VIIBE_Card_UI:Destroy()
        end

        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "VIIBE_Card_UI"
        ScreenGui.Parent = CoreGui
        ScreenGui.ResetOnSpawn = false

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 560, 0, 420)
        MainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
        MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        MainFrame.BorderSizePixel = 0
        MainFrame.Parent = ScreenGui

        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 8)
        MainCorner.Parent = MainFrame

        local TopBar = Instance.new("Frame")
        TopBar.Size = UDim2.new(1, 0, 0, 30)
        TopBar.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
        TopBar.BorderSizePixel = 0
        TopBar.Parent = MainFrame

        local TopCorner = Instance.new("UICorner")
        TopCorner.CornerRadius = UDim.new(0, 8)
        TopCorner.Parent = TopBar

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -15, 1, 0)
        Title.Position = UDim2.new(0, 12, 0, 0)
        Title.BackgroundTransparency = 1
        Title.Text = "V.I.I.B.E // PANEL // [INSERT] + SPIN BOT"
        Title.TextColor3 = Color3.fromRGB(200, 200, 210)
        Title.TextSize = 11
        Title.Font = Enum.Font.Code
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TopBar

        local menuVisible = true
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if input.KeyCode == Enum.KeyCode.Insert then
                menuVisible = not menuVisible
                MainFrame.Visible = menuVisible
            end
        end)

        local dragging, dragInput, dragStart, startPos
        TopBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        TopBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local TabBar = Instance.new("Frame")
        TabBar.Size = UDim2.new(0, 130, 1, -38)
        TabBar.Position = UDim2.new(0, 6, 0, 34)
        TabBar.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
        TabBar.Parent = MainFrame

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBar

        local Tab1Btn = Instance.new("TextButton")
        Tab1Btn.Size = UDim2.new(1, -12, 0, 30)
        Tab1Btn.Position = UDim2.new(0, 6, 0, 6)
        Tab1Btn.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
        Tab1Btn.Text = "KONTROL"
        Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab1Btn.TextSize = 10
        Tab1Btn.Font = Enum.Font.Code
        Tab1Btn.Parent = TabBar
        Instance.new("UICorner", Tab1Btn).CornerRadius = UDim.new(0, 5)

        local Tab2Btn = Instance.new("TextButton")
        Tab2Btn.Size = UDim2.new(1, -12, 0, 30)
        Tab2Btn.Position = UDim2.new(0, 6, 0, 42)
        Tab2Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        Tab2Btn.Text = "GUIDE / TP"
        Tab2Btn.TextColor3 = Color3.fromRGB(140, 140, 150)
        Tab2Btn.TextSize = 10
        Tab2Btn.Font = Enum.Font.Code
        Tab2Btn.Parent = TabBar
        Instance.new("UICorner", Tab2Btn).CornerRadius = UDim.new(0, 5)

        local ContentFrame = Instance.new("Frame")
        ContentFrame.Size = UDim2.new(1, -148, 1, -38)
        ContentFrame.Position = UDim2.new(0, 142, 0, 34)
        ContentFrame.BackgroundTransparency = 1
        ContentFrame.Parent = MainFrame

        local Page1 = Instance.new("ScrollingFrame")
        Page1.Size = UDim2.new(1, 0, 1, 0)
        Page1.BackgroundTransparency = 1
        Page1.BorderSizePixel = 0
        Page1.CanvasSize = UDim2.new(0, 0, 1.6, 0)
        Page1.ScrollBarThickness = 2
        Page1.Visible = true
        Page1.Parent = ContentFrame

        local Page1Layout = Instance.new("UIListLayout")
        Page1Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Page1Layout.Padding = UDim.new(0, 6)
        Page1Layout.Parent = Page1

        local Page2 = Instance.new("Frame")
        Page2.Size = UDim2.new(1, 0, 1, 0)
        Page2.BackgroundTransparency = 1
        Page2.Visible = false
        Page2.Parent = ContentFrame

        Tab1Btn.MouseButton1Click:Connect(function()
            Page1.Visible = true
            Page2.Visible = false
            Tab1Btn.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
            Tab1Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab2Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Tab2Btn.TextColor3 = Color3.fromRGB(140, 140, 150)
        end)

        Tab2Btn.MouseButton1Click:Connect(function()
            Page1.Visible = false
            Page2.Visible = true
            Tab2Btn.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
            Tab2Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Tab1Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Tab1Btn.TextColor3 = Color3.fromRGB(140, 140, 150)
        end)

        local SpeedEnabled, SpeedVal = false, 16
        local JumpEnabled, JumpVal = false, 50
        local FlyEnabled, FlyVal = false, 50
        local SpinEnabled, SpinVal = false, 50
        local NoclipEnabled = false
        local AntiAfkEnabled = false

        local function CreateCard(titleText, hasSlider, minVal, maxVal, defaultVal, callbackToggle, callbackVal)
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, 0, 0, hasSlider and 75 or 42)
            Card.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            Card.Parent = Page1
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)
            
            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.Size = UDim2.new(1, -100, 0, 24)
            TitleLbl.Position = UDim2.new(0, 10, 0, 6)
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Text = titleText
            TitleLbl.TextColor3 = Color3.fromRGB(210, 210, 220)
            TitleLbl.TextSize = 11
            TitleLbl.Font = Enum.Font.Code
            TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
            TitleLbl.Parent = Card
            
            local CheckBox = Instance.new("TextButton")
            CheckBox.Size = UDim2.new(0, 18, 0, 18)
            CheckBox.Position = UDim2.new(1, -26, 0, 9)
            CheckBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            CheckBox.Text = ""
            CheckBox.Parent = Card
            Instance.new("UICorner", CheckBox).CornerRadius = UDim.new(0, 4)
            
            local active = false
            local function ToggleState(newState)
                if newState ~= nil then
                    active = newState
                else
                    active = not active
                end
                CheckBox.BackgroundColor3 = active and Color3.fromRGB(0, 170, 90) or Color3.fromRGB(30, 30, 40)
                CheckBox.Text = active and "✓" or ""
                callbackToggle(active)
            end
            
            CheckBox.MouseButton1Click:Connect(function()
                ToggleState()
            end)
            
            local KeyBtn = Instance.new("TextButton")
            KeyBtn.Size = UDim2.new(0, 46, 0, 18)
            KeyBtn.Position = UDim2.new(1, -78, 0, 9)
            KeyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
            KeyBtn.Text = "KEY"
            KeyBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
            KeyBtn.TextSize = 9
            KeyBtn.Font = Enum.Font.Code
            KeyBtn.Parent = Card
            Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 4)
            
            local boundKey = nil
            local listening = false
            
            KeyBtn.MouseButton1Click:Connect(function()
                listening = true
                KeyBtn.Text = "..."
                KeyBtn.TextColor3 = Color3.fromRGB(0, 170, 90)
            end)
            
            UserInputService.InputBegan:Connect(function(input, gp)
                if listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == Enum.KeyCode.Escape then
                            boundKey = nil
                            KeyBtn.Text = "KEY"
                        else
                            boundKey = input.KeyCode
                            KeyBtn.Text = tostring(boundKey.Name):upper()
                        end
                        KeyBtn.TextColor3 = Color3.fromRGB(160, 160, 170)
                        listening = false
                    end
                elseif boundKey and input.UserInputType == Enum.UserInputType.Keyboard and not gp then
                    if input.KeyCode == boundKey then
                        ToggleState()
                    end
                end
            end)
            
            if hasSlider then
                local ValLbl = Instance.new("TextLabel")
                ValLbl.Size = UDim2.new(0, 40, 0, 20)
                ValLbl.Position = UDim2.new(1, -125, 0, 8)
                ValLbl.BackgroundTransparency = 1
                ValLbl.Text = tostring(defaultVal)
                ValLbl.TextColor3 = Color3.fromRGB(160, 160, 170)
                ValLbl.TextSize = 10
                ValLbl.Font = Enum.Font.Code
                ValLbl.TextXAlignment = Enum.TextXAlignment.Right
                ValLbl.Parent = Card
                
                KeyBtn.Position = UDim2.new(1, -128, 0, 9)
                
                local SliderBg = Instance.new("Frame")
                SliderBg.Size = UDim2.new(1, -20, 0, 6)
                SliderBg.Position = UDim2.new(0, 10, 0, 48)
                SliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                SliderBg.Parent = Card
                Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 3)
                
                local SliderFill = Instance.new("Frame")
                local initPercent = (defaultVal - minVal) / (maxVal - minVal)
                SliderFill.Size = UDim2.new(initPercent, 0, 1, 0)
                SliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
                SliderFill.Parent = SliderBg
                Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 3)
                
                local draggingSlider = false
                SliderBg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true end
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mousePos = UserInputService:GetMouseLocation().X
                        local absPos = SliderBg.AbsolutePosition.X
                        local absSize = SliderBg.AbsoluteSize.X
                        local percent = math.clamp((mousePos - absPos) / absSize, 0, 1)
                        SliderFill.Size = UDim2.new(percent, 0, 1, 0)
                        local currentVal = math.floor(minVal + (maxVal - minVal) * percent)
                        ValLbl.Text = tostring(currentVal)
                        callbackVal(currentVal)
                    end
                end)
            end
        end

        CreateCard("Speed Boost", true, 16, 200, 16, function(s) SpeedEnabled = s end, function(v) SpeedVal = v end)
        CreateCard("Jump Power", true, 50, 300, 50, function(s) JumpEnabled = s end, function(v) JumpVal = v end)
        CreateCard("Fly Mode", true, 10, 200, 50, function(s) FlyEnabled = s end, function(v) FlyVal = v end)
        CreateCard("Spin Bot", true, 10, 500, 50, function(s) SpinEnabled = s end, function(v) SpinVal = v end)
        CreateCard("Noclip", false, nil, nil, nil, function(s) NoclipEnabled = s end, nil)
        CreateCard("Anti-AFK", false, nil, nil, nil, function(s) AntiAfkEnabled = s end, nil)

        local SearchBox = Instance.new("TextBox")
        SearchBox.Size = UDim2.new(1, 0, 0, 28)
        SearchBox.Position = UDim2.new(0, 0, 0, 0)
        SearchBox.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        SearchBox.Text = ""
        SearchBox.PlaceholderText = "İsim ara (ilk 1-2 harf)..."
        SearchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 110)
        SearchBox.TextColor3 = Color3.fromRGB(220, 220, 230)
        SearchBox.TextSize = 10
        SearchBox.Font = Enum.Font.Code
        SearchBox.ClearTextOnFocus = false
        SearchBox.Parent = Page2
        Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 5)

        local TPScroll = Instance.new("ScrollingFrame")
        TPScroll.Size = UDim2.new(1, 0, 1, -34)
        TPScroll.Position = UDim2.new(0, 0, 0, 34)
        TPScroll.BackgroundTransparency = 1
        TPScroll.BorderSizePixel = 0
        TPScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        TPScroll.ScrollBarThickness = 2
        TPScroll.Parent = Page2

        local TPLayout = Instance.new("UIListLayout")
        TPLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TPLayout.Padding = UDim.new(0, 4)
        TPLayout.Parent = TPScroll

        local function UpdateTPList()
            for _, child in ipairs(TPScroll:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end
            
            local filter = SearchBox.Text:lower()
            local count = 0
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local displayName = player.DisplayName
                    local userName = player.Name
                    
                    if filter == "" or string.find(displayName:lower(), filter) or string.find(userName:lower(), filter) then
                        count = count + 1
                        local row = Instance.new("Frame")
                        row.Size = UDim2.new(1, 0, 0, 36)
                        row.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
                        row.Parent = TPScroll
                        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)
                        
                        local nameLbl = Instance.new("TextLabel")
                        nameLbl.Size = UDim2.new(1, -75, 1, 0)
                        nameLbl.Position = UDim2.new(0, 8, 0, 0)
                        nameLbl.BackgroundTransparency = 1
                        nameLbl.Text = displayName .. " (@" .. userName .. ")"
                        nameLbl.TextColor3 = Color3.fromRGB(200, 200, 210)
                        nameLbl.TextSize = 10
                        nameLbl.Font = Enum.Font.Code
                        nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                        nameLbl.Parent = row
                        
                        local tpBtn = Instance.new("TextButton")
                        tpBtn.Size = UDim2.new(0, 60, 0, 24)
                        tpBtn.Position = UDim2.new(1, -64, 0.5, -12)
                        tpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 90)
                        tpBtn.Text = "GİT"
                        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                        tpBtn.TextSize = 10
                        tpBtn.Font = Enum.Font.Code
                        tpBtn.Parent = row
                        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 4)
                        
                        tpBtn.MouseButton1Click:Connect(function()
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local targetRoot = player.Character.HumanoidRootPart
                                local myChar = LocalPlayer.Character
                                if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                                    myChar.HumanoidRootPart.CFrame = targetRoot.CFrame + Vector3.new(0, 3, 0)
                                end
                            end
                        end)
                    end
                end
            end
            TPScroll.CanvasSize = UDim2.new(0, 0, 0, count * 40)
        end

        SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateTPList)
        UpdateTPList()

        LocalPlayer.Idled:Connect(function()
            if AntiAfkEnabled then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0,0))
            end
        end)

        local currentAngle = 0
        RunService.RenderStepped:Connect(function(dt)
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            
            if hum then
                if SpeedEnabled then hum.WalkSpeed = SpeedVal end
                if JumpEnabled then 
                    hum.JumpPower = JumpVal 
                    hum.UseJumpPower = true 
                end
            end
            
            if SpinEnabled and root then
                currentAngle = (currentAngle + (SpinVal * dt * 10)) % 360
                local pos = root.Position
                root.CFrame = CFrame.new(pos) * CFrame.Angles(0, math.rad(currentAngle), 0)
            end
            
            if FlyEnabled and root then
                local vel = Vector3.new(0, 0, 0)
                local cam = Camera.CFrame
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + (cam.LookVector * FlyVal) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - (cam.LookVector * FlyVal) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - (cam.RightVector * FlyVal) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + (cam.RightVector * FlyVal) end
                root.Velocity = Vector3.new(vel.X, 2, vel.Z)
            end
            
            if NoclipEnabled then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)

        print("[V.I.I.B.E] Custom Card UI with Spin Bot successfully injected.")
    ]]--)
    return loadstring(full_code)()
end)

if not success then
    warn("[V.I.I.B.E Error]: " .. tostring(result))
end
