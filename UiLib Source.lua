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
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 200)
    menu.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    menu.BorderSizePixel = 0
    menu.Visible = true
    
    self:AnimateIn(menu)
    
    local textBox = Instance.new("TextBox", menu)
    textBox.PlaceholderText = "Enter your link or password"
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
            print("Hello")
        else
            print("Incorrect password")
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
    
    menu.Parent = game.Players.LocalPlayer.PlayerGui
    
    -- Добавляем меню в ScreenGui, создавая его, если он еще не создан
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = playerGui:FindFirstChild("ScreenGui") or Instance.new("ScreenGui", playerGui)
    screenGui.Name = "ScreenGui"
    menu.Parent = screenGui
    
    return menu
end

return UILibrary
