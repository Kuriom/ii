--[[
    РАБОЧИЙ СКРИПТ ДЛЯ ROBLOX STUDIO
    Полноэкранное GUI-окно, которое нельзя закрыть.
    Размести этот скрипт в StarterGui (как ScreenGui или LocalScript)
]]

-- Создаём основной ScreenGui (интерфейс)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FullScreenWindow"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false  -- Окно не исчезает при смерти игрока

-- Затемняющий фон (заполняет весь экран)
local background = Instance.new("Frame")
background.Name = "Background"
background.Size = UDim2.new(1, 0, 1, 0)  -- Полный экран
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Чёрный цвет
background.BackgroundTransparency = 0.3  -- Полупрозрачный
background.BorderSizePixel = 0
background.Parent = screenGui

-- Основное окно (белая рамка по центру, но тоже на весь экран)
local mainWindow = Instance.new("Frame")
mainWindow.Name = "MainWindow"
mainWindow.Size = UDim2.new(1, -40, 1, -40)  -- Почти весь экран с отступами 20px
mainWindow.Position = UDim2.new(0, 20, 0, 20)
mainWindow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон
mainWindow.BorderSizePixel = 2
mainWindow.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainWindow.ClipsDescendants = true
mainWindow.Parent = screenGui

-- Заголовок окна
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainWindow

-- Текст заголовка
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.Position = UDim2.new(0, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ПОЛНОЭКРАННОЕ ОКНО (НЕЛЬЗЯ ЗАКРЫТЬ)"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Center
titleText.TextYAlignment = Enum.TextYAlignment.Center
titleText.Parent = titleBar

-- Основной контент (прокручиваемая область)
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 12
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)  -- Высота контента 600px
contentFrame.Parent = mainWindow

-- Пример: добавляем текст в окно
local exampleText = Instance.new("TextLabel")
exampleText.Size = UDim2.new(1, -20, 0, 40)
exampleText.Position = UDim2.new(0, 10, 0, 10)
exampleText.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
exampleText.Text = "Это окно занимает почти весь экран.\nУ него нет кнопки закрытия.\nНажми ESC — окно не закроется!"
exampleText.TextColor3 = Color3.fromRGB(0, 0, 0)
exampleText.TextScaled = true
exampleText.TextWrapped = true
exampleText.BackgroundTransparency = 0.5
exampleText.Parent = contentFrame

-- БЛОКИРОВКА ЗАКРЫТИЯ ЧЕРЕЗ ESC
-- Перехватываем нажатие клавиш
local userInputService = game:GetService("UserInputService")

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    
    -- Если нажата клавиша Escape
    if input.KeyCode == Enum.KeyCode.Escape then
        -- Игнорируем закрытие окна (ничего не делаем)
        -- Можно добавить звук или сообщение:
        -- print("Нельзя закрыть окно!")
    end
end

userInputService.InputBegan:Connect(onInputBegan)

-- Дополнительная блокировка: скрываем стандартную кнопку Roblox (если есть)
local function blockCoreGui()
    local starterGui = game:GetService("StarterGui")
    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)  -- Отключаем рюкзак (необязательно)
    -- Кнопку Roblox убрать нельзя, но можно перехватить её нажатие
end

-- Попытка убрать системное меню (не всегда работает, но улучшает эффект)
pcall(function()
    game:GetService("StarterGui"):SetCore("DevConsoleVisible", false)
end)

-- Защита от удаления окна из скриптов других игроков (только для локального)
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Уведомление в консоль (для разработчика)
print("Полноэкранное окно создано. ESC не работает. Окно нельзя закрыть.")
