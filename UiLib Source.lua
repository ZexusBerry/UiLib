-- UI Library for Roblox
-- Author: ZexusBerry
-- GitHub: https://github.com/ZexusBerry

-- Module
local UILibrary = {}

-- Styles
UILibrary.Styles = {
    Dark = {
        BackgroundColor = Color3.fromRGB(32, 32, 32),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(45, 45, 45),
        ButtonTextColor = Color3.fromRGB(255, 255, 255)
    },
    Bloody = {
        BackgroundColor = Color3.fromRGB(64, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(96, 0, 0),
        ButtonTextColor = Color3.fromRGB(255, 255, 255)
    },
    Light = {
        BackgroundColor = Color3.fromRGB(255, 255, 255),
        TextColor = Color3.fromRGB(0, 0, 0),
        ButtonColor = Color3.fromRGB(230, 230, 230),
        ButtonTextColor = Color3.fromRGB(0, 0, 0)
    },
    Grey = {
        BackgroundColor = Color3.fromRGB(128, 128, 128),
        TextColor = Color3.fromRGB(255, 255, 255),
        ButtonColor = Color3.fromRGB(169, 169, 169),
        ButtonTextColor = Color3.fromRGB(255, 255, 255)
    }
}

-- Helper Function to Apply Styles
local function applyStyle(uiElement, style)
    uiElement.BackgroundColor3 = style.BackgroundColor
    if uiElement:IsA("TextButton") or uiElement:IsA("TextLabel") then
        uiElement.TextColor3 = style.TextColor
    end
end

-- Create Menu
function UILibrary:CreateMenu(styleName, title)
    local style = self.Styles[styleName]
    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(0, 300, 0, 400)
    menu.Position = UDim2.new(0.5, -150, 0.5, -200)
    menu.AnchorPoint = Vector2.new(0.5, 0.5)
    applyStyle(menu, style)
    
    local titleLabel = Instance.new("TextLabel", menu)
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.TextScaled = true
    applyStyle(titleLabel, style)
    
    return menu
end

-- Create Tab
function UILibrary:CreateTab(menu, title)
    local tab = Instance.new("Frame", menu)
    tab.Size = UDim2.new(1, 0, 0, 50)
    tab.Position = UDim2.new(0, 0, 0, 50)
    
    local tabButton = Instance.new("TextButton", tab)
    tabButton.Text = title
    tabButton.Size = UDim2.new(1, 0, 1, 0)
    tabButton.TextScaled = true
    applyStyle(tabButton, UILibrary.Styles.Grey)
    
    return tab
end

-- Create Button
function UILibrary:CreateButton(parent, title, onClick)
    local button = Instance.new("TextButton", parent)
    button.Text = title
    button.Size = UDim2.new(1, 0, 0, 50)
    button.TextScaled = true
    button.MouseButton1Click:Connect(onClick)
    applyStyle(button, UILibrary.Styles.Grey)
    
    return button
end

-- Create Label
function UILibrary:CreateLabel(parent, text)
    local label = Instance.new("TextLabel", parent)
    label.Text = text
    label.Size = UDim2.new(1, 0, 0, 50)
    label.TextScaled = true
    applyStyle(label, UILibrary.Styles.Grey)
    
    return label
end

-- Create TextBox
function UILibrary:CreateTextBox(parent, placeholderText)
    local textBox = Instance.new("TextBox", parent)
    textBox.PlaceholderText = placeholderText
    textBox.Size = UDim2.new(1, 0, 0, 50)
    textBox.TextScaled = true
    applyStyle(textBox, UILibrary.Styles.Grey)
    
    return textBox
end

-- Create DropDown
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
    applyStyle(dropDownButton, UILibrary.Styles.Grey)
    
    local optionFrame = Instance.new("Frame", dropDown)
    optionFrame.Size = UDim2.new(1, 0, 0, #options * 50)
    optionFrame.Position = UDim2.new(0, 0, 1, 0)
    optionFrame.Visible = false
    applyStyle(optionFrame, UILibrary.Styles.Grey)
    
    dropDownButton.MouseButton1Click:Connect(function()
        optionFrame.Visible = not optionFrame.Visible
    end)
    
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton", optionFrame)
        optionButton.Text = option
        optionButton.Size = UDim2.new(1, 0, 0, 50)
        optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
        optionButton.TextScaled = true
        applyStyle(optionButton, UILibrary.Styles.Grey)
        
        optionButton.MouseButton1Click:Connect(function()
            selectedText.Text = option
            optionFrame.Visible = false
            onSelect(option)
        end)
    end
    
    return dropDown
end

return UILibrary
