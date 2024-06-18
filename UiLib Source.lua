local UILibrary = {}

-- Define styles
UILibrary.Styles = {
    Dark = {
        BackgroundColor = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(35, 35, 35),
        ButtonTextColor = Color3.fromRGB(255, 255, 255),
        TabColor = Color3.fromRGB(48, 48, 48),
        AccentColor = Color3.fromRGB(255, 85, 85)
    },
    Bloody = {
        BackgroundColor = Color3.fromRGB(64, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(96, 0, 0),
        ButtonTextColor = Color3.fromRGB(255, 255, 255),
        TabColor = Color3.fromRGB(48, 0, 0),
        AccentColor = Color3.fromRGB(200, 0, 0)
    },
    Light = {
        BackgroundColor = Color3.fromRGB(245, 245, 245),
        TextColor = Color3.fromRGB(0, 0, 0),
        ButtonColor = Color3.fromRGB(220, 220, 220),
        ButtonTextColor = Color3.fromRGB(0, 0, 0),
        TabColor = Color3.fromRGB(230, 230, 230),
        AccentColor = Color3.fromRGB(100, 100, 100)
    },
    Grey = {
        BackgroundColor = Color3.fromRGB(128, 128, 128),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(169, 169, 169),
        ButtonTextColor = Color3.fromRGB(255, 255, 255),
        TabColor = Color3.fromRGB(148, 148, 148),
        AccentColor = Color3.fromRGB(200, 200, 200)
    }
}

-- Apply style
local function applyStyle(uiElement, style, styleType)
    if styleType == "button" then
        uiElement.BackgroundColor3 = style.ButtonColor
        uiElement.TextColor3 = style.ButtonTextColor
    elseif styleType == "tab" then
        uiElement.BackgroundColor3 = style.TabColor
        uiElement.TextColor3 = style.TextColor
    elseif styleType == "checkbox" then
        uiElement.BackgroundColor3 = style.AccentColor
    else
        uiElement.BackgroundColor3 = style.BackgroundColor
        uiElement.TextColor3 = style.TextColor
    end
    uiElement.Visible = true
end

-- Enable dragging
local function enableDragging(frame)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Create menu
function UILibrary:CreateMenu(styleName, title)
    local style = self.Styles[styleName] or self.Styles.Dark
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 400, 0, 500)
    menu.Position = UDim2.new(0.5, -200, 0.5, -250)
    menu.AnchorPoint = Vector2.new(0.5, 0.5)
    menu.BackgroundTransparency = 0
    applyStyle(menu, style)

    local titleLabel = Instance.new("TextLabel", menu)
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.TextScaled = true
    titleLabel.BackgroundTransparency = 1
    applyStyle(titleLabel, style)

    enableDragging(menu)
    
    local tabs = Instance.new("Frame", menu)
    tabs.Size = UDim2.new(1, 0, 0, 40)
    tabs.Position = UDim2.new(0, 0, 0, 50)
    tabs.BackgroundTransparency = 1

    local tabContent = Instance.new("Frame", menu)
    tabContent.Size = UDim2.new(1, 0, 1, -90)
    tabContent.Position = UDim2.new(0, 0, 0, 90)
    tabContent.BackgroundTransparency = 1

    return {
        Menu = menu,
        Tabs = tabs,
        TabContent = tabContent,
        Style = style
    }
end

-- Create tab
function UILibrary:CreateTab(menuData, title)
    local style = menuData.Style
    local tabButton = Instance.new("TextButton", menuData.Tabs)
    tabButton.Text = title
    tabButton.Size = UDim2.new(0, 100, 1, 0)
    tabButton.Position = UDim2.new(0, #menuData.Tabs:GetChildren() * 100, 0, 0)
    tabButton.TextScaled = true
    applyStyle(tabButton, style, "tab")

    local tabContent = Instance.new("Frame", menuData.TabContent)
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false

    tabButton.MouseButton1Click:Connect(function()
        for _, sibling in ipairs(menuData.TabContent:GetChildren()) do
            sibling.Visible = false
        end
        tabContent.Visible = true
    end)

    return tabContent
end

-- Create button
function UILibrary:CreateButton(parent, title, onClick)
    local button = Instance.new("TextButton", parent)
    button.Text = title
    button.Size = UDim2.new(1, 0, 0, 50)
    button.TextScaled = true
    button.MouseButton1Click:Connect(onClick)
    applyStyle(button, UILibrary.Styles.Grey, "button")

    return button
end

-- Create label
function UILibrary:CreateLabel(parent, text)
    local label = Instance.new("TextLabel", parent)
    label.Text = text
    label.Size = UDim2.new(1, 0, 0, 50)
    label.TextScaled = true
    applyStyle(label, UILibrary.Styles.Grey)

    return label
end

-- Create textbox
function UILibrary:CreateTextBox(parent, placeholderText)
    local textBox = Instance.new("TextBox", parent)
    textBox.PlaceholderText = placeholderText
    textBox.Size = UDim2.new(1, 0, 0, 50)
    textBox.TextScaled = true
    applyStyle(textBox, UILibrary.Styles.Grey)

    return textBox
end

-- Create dropdown
function UILibrary:CreateDropDown(parent, options, onSelect)
    local dropDown = Instance.new("Frame", parent)
    dropDown.Size = UDim2.new(1, 0, 0, 50)

    local selectedText = Instance.new("TextLabel", dropDown)
    selectedText.Text = "Select an option"
    selectedText.Size = UDim2.new(1, 0, 1, 0)
    selectedText.TextScaled = true
    applyStyle(selectedText, UILibrary.Styles.Grey)

    local dropDownButton = Instance.new("TextButton", dropDown)
    dropDownButton.Text = "▼"
    dropDownButton.Size = UDim2.new(0, 30, 1, 0)
    dropDownButton.Position = UDim2.new(1, -30, 0, 0)
    applyStyle(dropDownButton, UILibrary.Styles.Grey, "button")

    local optionFrame = Instance.new("Frame", dropDown)
    optionFrame.Size = UDim2.new(1, 0, 0, #options * 50)
    optionFrame.Position = UDim2.new(0, 0, 1, 0)
    optionFrame.Visible = false
    applyStyle(optionFrame, UILibrary.Styles.Grey, "button")

    dropDownButton.MouseButton1Click:Connect(function()
        optionFrame.Visible = not optionFrame.Visible    end)

    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton", optionFrame)
        optionButton.Text = option
        optionButton.Size = UDim2.new(1, 0, 0, 50)
        optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
        optionButton.TextScaled = true
        applyStyle(optionButton, UILibrary.Styles.Grey, "button")

        optionButton.MouseButton1Click:Connect(function()
            selectedText.Text = option
            optionFrame.Visible = false
            onSelect(option)
        end)
    end

    return dropDown
end

-- Create checkbox
function UILibrary:CreateCheckBox(parent, label, onChange)
    local checkBox = Instance.new("TextButton", parent)
    checkBox.AutoButtonColor = false
    checkBox.Size = UDim2.new(1, 0, 0, 30)
    applyStyle(checkBox, UILibrary.Styles.Grey, "checkbox")

    local checkMark = Instance.new("Frame", checkBox)
    checkMark.Size = UDim2.new(0, 20, 0, 20)
    checkMark.Position = UDim2.new(0, 5, 0.5, -10)
    checkMark.BackgroundTransparency = 0
    applyStyle(checkMark, UILibrary.Styles.Grey, "button")

    local checked = false

    checkBox.MouseButton1Click:Connect(function()
        checked = not checked
        if checked then
            checkMark.Visible = true
        else
            checkMark.Visible = false
        end
        onChange(checked)
    end)

    local checkLabel = Instance.new("TextLabel", checkBox)
    checkLabel.Text = label
    checkLabel.Size = UDim2.new(1, -30, 1, 0)
    checkLabel.Position = UDim2.new(0, 30, 0, 0)
    checkLabel.TextXAlignment = Enum.TextXAlignment.Left
    applyStyle(checkLabel, UILibrary.Styles.Grey)

    return checkBox
end

return UILibrary
