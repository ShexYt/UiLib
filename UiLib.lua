-- UI Library
local UI = {}

-- Utility function to create UI elements
local function create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

function UI.AddWindow(title, titleColor, secondTitle, secondTitleColor)
    local gui = create("ScreenGui", { Name = "patrickGui", Parent = game.CoreGui })

    local main = create("Frame", {
        Size = UDim2.new(0.5, 0, 0.7, 0),
        Position = UDim2.new(0.25, 0, 0.15, 0),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 1,
        Active = true,
        Draggable = true,
        Parent = gui
    })

    local syxTitle = create("TextLabel", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.05, 0, -0.1, 0),
        BackgroundTransparency = 1,
        Text = title,
        TextSize = 14,
        TextColor3 = titleColor,
        Font = Enum.Font.Code,
        Parent = main
    })

    local aaTitle = create("TextLabel", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.55, 0, -0.1, 0),
        BackgroundTransparency = 1,
        Text = secondTitle,
        TextSize = 13,
        TextColor3 = secondTitleColor,
        Font = Enum.Font.Code,
        Parent = main
    })

    local lineBar = create("Frame", {
        Size = UDim2.new(1, 0, 0.002, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.new(0, 0, 1),
        BorderSizePixel = 0,
        Parent = main
    })

    return main
end

function UI.AddTabs(parent)
    local tabsContainer = create("Frame", {
        Size = UDim2.new(0.3, 0, 0.9, 0),
        Position = UDim2.new(0, 0, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderColor3 = Color3.new(0, 0, 1),
        BorderSizePixel = 1,
        Parent = parent
    })

    local tabsTitle = create("TextLabel", {
        Size = UDim2.new(1, 0, 0.1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "TABS",
        TextSize = 23,
        TextColor3 = Color3.new(1, 1, 1),
        Font = Enum.Font.Code,
        Parent = tabsContainer
    })

    local tabsScroll = create("ScrollingFrame", {
        Size = UDim2.new(1, 0, 0.9, 0),
        Position = UDim2.new(0, 0, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderColor3 = Color3.new(0, 0, 1),
        BorderSizePixel = 1,
        ScrollBarThickness = 6,
        Parent = tabsContainer
    })

    return tabsScroll
end

function UI.AddTabButton(tabsFrame, title, imageId)
    local tabButton = create("TextButton", {
        Size = UDim2.new(1, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 30 * #tabsFrame:GetChildren()),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.new(1, 1, 1),
        Text = title,
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = tabsFrame
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = tabButton })

    if imageId then
        local icon = create("ImageLabel", {
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(0, 5, 0.5, -10),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. imageId,
            Parent = tabButton
        })
    end

    return tabButton
end

function UI.AddButton(parent, text, callback)
    local button = create("TextButton", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.3, 0, 0.3, 0),
        BackgroundColor3 = Color3.fromRGB(0, 128, 255),
        TextColor3 = Color3.new(1, 1, 1),
        Text = text,
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = button })

    button.MouseButton1Click:Connect(function()
        callback()
    end)

    return button
end

function UI.AddSlider(parent, minValue, maxValue, callback)
    local sliderFrame = create("Frame", {
        Size = UDim2.new(0.4, 0, 0.05, 0),
        Position = UDim2.new(0.3, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local slider = create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 128, 255),
        TextColor3 = Color3.new(1, 1, 1),
        Text = "",
        Parent = sliderFrame
    })

    local sliderValue = create("TextLabel", {
        Position = UDim2.new(1, 5, 0, -7),
        BackgroundTransparency = 1,
        Text = minValue,
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = sliderFrame
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = slider })

    local dragging = false
    slider.MouseButton1Down:Connect(function()
        dragging = true
    end)

    parent.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    parent.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local percent = (mousePos - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
            percent = math.clamp(percent, 0, 1)
            local value = minValue + percent * (maxValue - minValue)
            value = math.floor(value)
            sliderValue.Text = value
            callback(value)
        end
    end)

    return sliderFrame
end

function UI.AddTextbox(parent, callback)
    local textBox = create("TextBox", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.3, 0, 0.7, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = textBox })

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textBox.Text)
        end
    end)

    return textBox
end

function UI.AddSwitch(parent, callback)
    local switchFrame = create("Frame", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.3, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local switchButton = create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        TextColor3 = Color3.new(1, 1, 1),
        Text = "",
        Font = Enum.Font.SourceSans,
        Parent = switchFrame
    })

    local switchToggle = false

    switchButton.MouseButton1Click:Connect(function()
        switchToggle = not switchToggle
        if switchToggle then
            switchButton.BackgroundColor3 = Color3.fromRGB(0, 128, 255)
        else
            switchButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
        callback(switchToggle)
    end)

    return switchFrame
end

-- Start of the UI.AddSelector function

function UI.AddSelector(parent, options, callback)
    local selectorFrame = create("Frame", {
        Size = UDim2.new(0.4, 0, 0.1, 0),
        Position = UDim2.new(0.3, 0, 0.7, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local selectorButton = create("TextButton", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
        TextColor3 = Color3.new(1, 1, 1),
        Text = options[1],  -- Default to first option
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = selectorFrame
    })

    local selectorDropdown = create("Frame", {
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 100),
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderColor3 = Color3.new(0, 0, 0),
        BorderSizePixel = 1,
        Visible = false,
        Parent = selectorButton
    })

    local uiListLayout = create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = selectorDropdown
    })

    for i, optionText in ipairs(options) do
        local optionButton = create("TextButton", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            TextColor3 = Color3.new(1, 1, 1),
            Text = optionText,
            TextSize = 14,
            Font = Enum.Font.Code,
            Parent = selectorDropdown
        })

        optionButton.MouseButton1Click:Connect(function()
            selectorButton.Text = optionText
            callback(optionText, i)
            selectorDropdown.Visible = false
        end)
    end

    selectorButton.MouseButton1Click:Connect(function()
        selectorDropdown.Visible = not selectorDropdown.Visible
    end)

    return selectorFrame
end

return UI
