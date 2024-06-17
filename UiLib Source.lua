local function createInstance(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    return instance
end

-- Базовый класс для элементов UI
local UIElement = {}
UIElement.__index = UIElement

function UIElement.new()
    local self = setmetatable({}, UIElement)
    return self
end

-- Класс стиля
local Style = {}
Style.__index = Style

function Style.new(name, properties)
    local self = setmetatable({}, Style)
    self.Name = name
    self.Properties = properties or {}
    return self
end

-- Определение стилей
local Styles = {
    Dark = Style.new("Dark", {
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        -- Другие свойства стиля Dark
    }),
    Bloody = Style.new("Bloody", {
        BackgroundColor3 = Color3.fromRGB(100, 10, 10),
        TextColor3 = Color3.fromRGB(255, 0, 0),
        -- Другие свойства стиля Bloody
    }),
    Light = Style.new("Light", {
        BackgroundColor3 = Color3.fromRGB(240, 240, 240),
        TextColor3 = Color3.fromRGB(30, 30, 30),
        -- Другие свойства стиля Light
    }),
    Grey = Style.new("Grey", {
        BackgroundColor3 = Color3.fromRGB(180, 180, 180),
        TextColor3 = Color3.fromRGB(50, 50, 50),
        -- Другие свойства стиля Grey
    })
}

-- Класс меню
local Menu = {}
Menu.__index = Menu

function Menu.new(style)
    local self = setmetatable({}, Menu)
    self.Style = style or Styles.Dark -- По умолчанию используется стиль Dark
    -- Инициализация элементов меню
    self.Background = createInstance("Frame", {
        BackgroundColor3 = self.Style.BackgroundColor3,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = game.Players.LocalPlayer.PlayerGui -- Пример родителя
    })
    -- Добавление других элементов меню (Tab, Button, и т.д.)
    return self
end
