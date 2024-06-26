local UILibrary = {}

local TweenService = game:GetService("TweenService")

function UILibrary:AnimateIn(frame)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.BackgroundTransparency = 1
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(frame, tweenInfo, {
        Size = UDim2.new(0, 300, 0, 200),
        BackgroundTransparency = 0.5
    })
    
    tween:Play()
end

function UILibrary:AnimateOut(frame)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local tween = TweenService:Create(frame, tweenInfo, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    tween:Play()
    tween.Completed:Connect(function()
        frame.Visible = false
    end)
end

function UILibrary:CreateLoginMenu(password, link, scriptToExecute)
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("ScreenGui") or Instance.new("ScreenGui", playerGui)
    screenGui.Name = "ScreenGui"
    screenGui.ResetOnSpawn = false
    
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 200)
    menu.Position = UDim2.new(0.5, 0, 0.5, 0)
    menu.AnchorPoint = Vector2.new(0.5, 0.5)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    menu.BorderSizePixel = 0
    menu.ClipsDescendants = true
    menu.Visible = true
    
    UILibrary:AnimateIn(menu)
    
    local dragging = false
    local dragStart = nil
    
    local closeBtn = Instance.new("TextButton", menu)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Position = UDim2.new(1, -25, 0, 5)
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.BorderSizePixel = 0
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextSize = 18
    closeBtn.MouseButton1Click:Connect(function()
        UILibrary:AnimateOut(menu)
    end)
    
    menu.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position - menu.Position
            input:Capture()
        end
    end)
    
    menu.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            input:Release()
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            menu.Position = UDim2.new(0, input.Position.X - dragStart.X, 0, input.Position.Y - dragStart.Y)
        end
    end)
    
    local titleLabel = Instance.new("TextLabel", menu)
    titleLabel.Text = "Key Menu"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    titleLabel.BorderSizePixel = 0
    
    local textBox = Instance.new("TextBox", menu)
    textBox.PlaceholderText = "Enter Key"
    textBox.Size = UDim2.new(0.8, 0, 0, 30)
    textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    textBox.TextScaled = true
    textBox.Font = Enum.Font.SourceSans
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textBox.BorderSizePixel = 0
    textBox.ClearTextOnFocus = false
    textBox.TextWrapped = true
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    
    local enterButton = Instance.new("TextButton", menu)
    enterButton.Text = "Enter"
    enterButton.Size = UDim2.new(0.35, 0, 0, 30)
    enterButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    enterButton.TextScaled = true
    enterButton.Font = Enum.Font.SourceSansBold
    enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    enterButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    enterButton.BorderSizePixel = 0
    enterButton.MouseButton1Click:Connect(function()
        local userInput = textBox.Text
        if userInput == password then
            if scriptToExecute then
                loadstring(scriptToExecute)()
            end
            
            local successLabel = Instance.new("TextLabel", menu)
            successLabel.Text = "Success! Access granted."
            successLabel.Size = UDim2.new(1, 0, 0, 20)
            successLabel.Position = UDim2.new(0, 0, 0.75, 0)
            successLabel.TextScaled = true
            successLabel.Font = Enum.Font.SourceSans
            successLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            successLabel.BackgroundTransparency = 1
            successLabel.BorderSizePixel = 0
            wait(3)
            successLabel:Destroy()
            
            UILibrary:AnimateOut(menu)
        else
            local errorLabel = Instance.new("TextLabel", menu)
            errorLabel.Text = "Invalid Key"
            errorLabel.Size = UDim2.new(1, 0, 0, 20)
            errorLabel.Position = UDim2.new(0, 0, 0.75, 0)
            errorLabel.TextScaled = true
            errorLabel.Font = Enum.Font.SourceSans
            errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            errorLabel.BackgroundTransparency = 1
            errorLabel.BorderSizePixel = 0
            wait(3)
            errorLabel:Destroy()
        end
    end)
    
    local getKeyButton = Instance.new("TextButton", menu)
    getKeyButton.Text = "Get Key"
    getKeyButton.Size = UDim2.new(0.35, 0, 0, 30)
    getKeyButton.Position = UDim2.new(0.55, 0, 0.5, 0)
    getKeyButton.TextScaled = true
    getKeyButton.Font = Enum.Font.SourceSansBold
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    getKeyButton.BorderSizePixel = 0
    getKeyButton.MouseButton1Click:Connect(function()
        setclipboard(link)
        print("Link copied to clipboard:", link)
        
        -- Отображение сообщения о копировании
        local copyLabel = Instance.new("TextLabel", menu)
        copyLabel.Text = "Link copied!"
        copyLabel.Size = UDim2.new(1, 0, 0, 20)
        copyLabel.Position = UDim2.new(0, 0, 0.65, 0)
        copyLabel.TextScaled = true
        copyLabel.Font = Enum.Font.SourceSans
        copyLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        copyLabel.BackgroundTransparency = 1
        copyLabel.BorderSizePixel = 0
        wait(3)
        copyLabel:Destroy()
    end)
    
    menu.Parent = screenGui
    
    return {
        frame = menu,
        enterButton = enterButton,
        getKeyButton = getKeyButton,
        textBox = textBox,
        closeBtn = closeBtn
    }
end

return UILibrary

