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

function UILibrary:CreateLoginMenu()
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("ScreenGui") or Instance.new("ScreenGui", playerGui)
    screenGui.Name = "ScreenGui"
    
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 200)
    menu.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    menu.BorderSizePixel = 0
    menu.Visible = true
    
    self:AnimateIn(menu)
    
    -- Добавим возможность перетаскивания меню
    local dragging = false
    local dragStart = nil
    
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
    
    local textBox = Instance.new("TextBox", menu)
    textBox.PlaceholderText = "Enter your password"
    textBox.Size = UDim2.new(0.8, 0, 0, 50)
    textBox.Position = UDim2.new(0.1, 0, 0.2, 0)
    textBox.TextScaled = true
    textBox.Font = Enum.Font.SourceSans
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.BorderSizePixel = 0
    textBox.ClearTextOnFocus = false
    
    local enterButton = Instance.new("TextButton", menu)
    enterButton.Text = "Enter"
    enterButton.Size = UDim2.new(0.35, 0, 0, 50)
    enterButton.Position = UDim2.new(0.1, 0, 0.4, 0)
    enterButton.TextScaled = true
    enterButton.Font = Enum.Font.SourceSans
    enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    enterButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    enterButton.BorderSizePixel = 0
    enterButton.MouseButton1Click:Connect(function()
        local userInput = textBox.Text
        if userInput == "password123" then
            print("Good :D")
            local SLabel = Instance.new("TextLabel", menu)
            SLabel.Text = "SussessFully"
            SLabel.Size = UDim2.new(1, 0, 0, 20)
            SLabel.Position = UDim2.new(0, 0, 0.8, 0)
            SLabel.TextScaled = true
            SLabel.Font = Enum.Font.SourceSans
            SLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            SLabel.BackgroundTransparency = 1
            SLabel.BorderSizePixel = 0
            wait(3)
            errorLabel:Destroy()
        else
            print("Incorrect password")
            -- Отображение сообщения об ошибке
            local errorLabel = Instance.new("TextLabel", menu)
            errorLabel.Text = "Incorrect Password"
            errorLabel.Size = UDim2.new(1, 0, 0, 20)
            errorLabel.Position = UDim2.new(0, 0, 0.8, 0)
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
    getKeyButton.Size = UDim2.new(0.35, 0, 0, 50)
    getKeyButton.Position = UDim2.new(0.55, 0, 0.4, 0)
    getKeyButton.TextScaled = true
    getKeyButton.Font = Enum.Font.SourceSans
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    getKeyButton.BorderSizePixel = 0
    getKeyButton.MouseButton1Click:Connect(function()
        local link = "https://example.com"
        setclipboard(link)
        print("Link copied to clipboard:", link)
    end)
    
    menu.Parent = screenGui
    
    return menu
end

return UILibrary
