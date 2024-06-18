local UILibrary = {}

local TweenService = game:GetService("TweenService")

function UILibrary:AnimateIn(frame)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Size = UDim2.new(0, 400, 0, 250)
    frame.BackgroundTransparency = 1
    
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(frame, tweenInfo, {
        Size = UDim2.new(0, 400, 0, 250),
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
    
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 400, 0, 250)
    menu.Position = UDim2.new(0.5, 0, 0.5, 0)
    menu.AnchorPoint = Vector2.new(0.5, 0.5)
    menu.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    menu.BorderColor3 = Color3.fromRGB(27, 42, 53)
    menu.BorderSizePixel = 2
    menu.ClipsDescendants = true
    
    self:AnimateIn(menu)
    
    -- Создание заголовка
    local titleFrame = Instance.new("Frame", menu)
    titleFrame.Size = UDim2.new(1, 0, 0, 40)
    titleFrame.Position = UDim2.new(0, 0, 0, 0)
    titleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleFrame.BorderSizePixel = 0
    
    local titleLabel = Instance.new("TextLabel", titleFrame)
    titleLabel.Text = "Login Menu"
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    
    -- Добавим возможность перетаскивания меню
    local dragging = false
    local dragStart = nil
    
    local closeBtn = Instance.new("TextButton", titleFrame)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeBtn.BorderSizePixel = 0
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextScaled = true
    closeBtn.MouseButton1Click:Connect(function()
        self:AnimateOut(menu)
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
    
    -- Создание поля для ввода пароля
    local textBox = Instance.new("TextBox", menu)
    textBox.PlaceholderText = "Enter your password"
    textBox.Size = UDim2.new(0.8, 0, 0, 30)
    textBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    textBox.TextScaled = true
    textBox.Font = Enum.Font.SourceSans
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    textBox.BorderSizePixel = 0
    textBox.ClearTextOnFocus = false
    
    -- Создание кнопки "Enter"
    local enterButton = Instance.new("TextButton", menu)
    enterButton.Text = "Enter"
    enterButton.Size = UDim2.new(0.35, 0, 0, 30)
    enterButton.Position = UDim2.new(0.1, 0, 0.5, 0)
    enterButton.TextScaled = true
    enterButton.Font = Enum.Font.SourceSansBold
    enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    enterButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    enterButton.BorderSizePixel = 0
    enterButton.MouseButton1Click:Connect(function()
        local userInput = textBox.Text
        if userInput == password then
            -- Выполнение пользовательского скрипта при успешном вводе пароля
            if scriptToExecute then
                loadstring(scriptToExecute)()
            end
            
            -- Отображение сообщения об успешном входе
            local successLabel = Instance.new("TextLabel", menu)
            successLabel.Text = "Access granted!"
            successLabel.Size = UDim2.new(1, 0, 0, 20)
            successLabel.Position = UDim2.new(0, 0, 0.75, 0)
            successLabel.TextScaled = true
            successLabel.Font = Enum.Font.SourceSansBold
            successLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            successLabel.BackgroundTransparency = 1
            successLabel.BorderSizePixel = 0
            wait(3)
            successLabel:Destroy()
            
            -- Обновление текущего пароля и ссылки
            password = newPassword
            link = newLink
            
            -- Анимация закрытия меню после успешного ввода пароля
            self:AnimateOut(menu)
        else
            -- Отображение сообщения о неправильном пароле
            local errorLabel = Instance.new("TextLabel", menu)
            errorLabel.Text = "Incorrect Password"
            errorLabel.Size = UDim2.new(1, 0, 0, 20)
            errorLabel.Position = UDim2.new(0, 0, 0.75, 0)
            errorLabel.TextScaled = true
            errorLabel.Font = Enum.Font.SourceSansBold
            errorLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            errorLabel.BackgroundTransparency = 1
            errorLabel.BorderSizePixel = 0
            wait(3)
            errorLabel:Destroy()
        end
    end)
    
    -- Создание кнопки "Get Key"
    local getKeyButton = Instance.new("TextButton", menu)
    getKeyButton.Text = "Get Key"
    getKeyButton.Size = UDim2.new(0.35, 0, 0, 30)
    getKeyButton.Position = UDim2.new(0.55, 0, 0.5, 0)
    getKeyButton.TextScaled = true
    getKeyButton.Font = Enum.Font.SourceSansBold
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
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
        copyLabel.Font = Enum.Font.SourceSansBold
        copyLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
        copyLabel.BackgroundTransparency = 1
        copyLabel.BorderSizePixel = 0
        wait(3)
        copyLabel:Destroy()
    end)
    
    -- Функция для изменения пароля и скрипта
    function UILibrary:Setup(password, newLink, newScriptToExecute)
        password = password or "defaultpassword123"
        link = newLink or "https://defaultlink.com"
        scriptToExecute = newScriptToExecute or nil
    end
    
    -- Возвращаем созданное меню
    return {
        frame = menu,
        textBox = textBox,
        enterButton = enterButton,
        getKeyButton = getKeyButton
    }
end

return UILibrary
