--[[
*****************************************************************
  ____                       _          
 / ___| _ __   ___  ___  ___| |_ ___   
 \___ \| '_ \ / _ \/ _ \/ __| __/ __|  
  ___) | |_) |  __/  __/ (__| |_\__ \_ 
 |____/| .__/ \___|\___|\___|\__|___(_)
       |_|                              
                                                  
*****************************************************************
WARNING: This script is protected by Sytex Obfuscator V1.09473.28 to safeguard proprietary algorithms and intellectual property.

Unauthorized access, modification, or reverse-engineering of this script
is strictly prohibited and may result in legal action.

This script includes intricate design patterns and proprietary secrets critical 
to the operation of the associated game or application.

Access to this script is restricted to authorized developers only.
Any attempt to tamper with or misuse this script will result in immediate consequences.

By accessing or using this script, you acknowledge and agree to comply with these terms.

Obfuscation Details:
- Obfuscator: Sytex Obfuscator V1.09473.28
- Techniques Used: Anti-tamper mechanisms, string encryption, control flow obfuscation.

Anti-tamper measures have been implemented to prevent unauthorized modification 
of this script's functionality. Decrypting or modifying protected portions of the script 
may trigger security protocols leading to account termination or legal action.

For inquiries regarding access or permissions, contact the script owner or administrator.

*****************************************************************
]]


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
    local tabs = create("ScrollingFrame", {
        Size = UDim2.new(0.3, 0, 0.9, 0),
        Position = UDim2.new(0, 0, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderColor3 = Color3.new(0, 0, 1),
        BorderSizePixel = 1,
        Active = true,
        CanvasSize = UDim2.new(0, 0, 5, 0),
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Color3.new(0, 0, 1),
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
        Parent = tabs
    })

    return tabs
end

function UI.AddButton(parent, text, callback)
    local button = create("TextButton", {
        Size = UDim2.new(0.8, 0, 0.05, 0),
        Position = UDim2.new(0.1, 0, 0.1, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.new(1, 1, 1),
        Text = text,
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = parent
    })
    
    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = button })

    button.MouseButton1Click:Connect(callback)
    return button
end

function UI.AddSlider(parent, min, max, callback)
    local sliderFrame = create("Frame", {
        Size = UDim2.new(0.8, 0, 0.05, 0),
        Position = UDim2.new(0.1, 0, 0.2, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = sliderFrame })

    local slider = create("TextButton", {
        Size = UDim2.new(0, 10, 1, 0),
        BackgroundColor3 = Color3.new(0, 0, 1),
        Parent = sliderFrame
    })

    local uiCornerSlider = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = slider })

    local textBox = create("TextBox", {
        Size = UDim2.new(0.2, 0, 1, 0),
        Position = UDim2.new(1, 10, 0, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.new(1, 1, 1),
        Text = tostring(min),
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = sliderFrame
    })

    local uiCornerTextBox = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = textBox })

    local dragging = false
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    sliderFrame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp(input.Position.X - sliderFrame.AbsolutePosition.X, 0, sliderFrame.AbsoluteSize.X)
            slider.Position = UDim2.new(x / sliderFrame.AbsoluteSize.X, 0, 0, 0)
            local value = math.floor((x / sliderFrame.AbsoluteSize.X) * (max - min) + min)
            textBox.Text = tostring(value)
            callback(value)
        end
    end)

    textBox.FocusLost:Connect(function()
        local value = tonumber(textBox.Text)
        if value then
            value = math.clamp(value, min, max)
            local x = (value - min) / (max - min) * sliderFrame.AbsoluteSize.X
            slider.Position = UDim2.new(x / sliderFrame.AbsoluteSize.X, 0, 0, 0)
            callback(value)
        else
            textBox.Text = tostring(min)
        end
    end)

    return sliderFrame
end

function UI.AddTextbox(parent, callback)
    local textBox = create("TextBox", {
        Size = UDim2.new(0.8, 0, 0.05, 0),
        Position = UDim2.new(0.1, 0, 0.3, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        TextColor3 = Color3.new(1, 1, 1),
        Text = "",
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = textBox })

    textBox.FocusLost:Connect(function()
        callback(textBox.Text)
    end)

    return textBox
end

function UI.AddSwitch(parent, callback)
    local switchFrame = create("Frame", {
        Size = UDim2.new(0.8, 0, 0.05, 0),
        Position = UDim2.new(0.1, 0, 0.4, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = switchFrame })

    local switchButton = create("TextButton", {
        Size = UDim2.new(0.5, -1, 1, -1),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Color3.fromRGB(255, 0, 0),
        Text = "OFF",
        TextColor3 = Color3.new(1, 1, 1),
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = switchFrame
    })

    local uiCornerSwitch = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = switchButton })

    local on = false
    switchButton.MouseButton1Click:Connect(function()
        on = not on
        if on then
            switchButton.Text = "ON"
            switchButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            switchButton.Text = "OFF"
            switchButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
        callback(on)
    end)

    return switchFrame
end

function UI.AddSelector(parent, options, callback)
    local selectorFrame = create("Frame", {
        Size = UDim2.new(0.8, 0, 0.05, 0),
        Position = UDim2.new(0.1, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Parent = parent
    })

    local uiCorner = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = selectorFrame })

    local selectorButton = create("TextButton", {
        Size = UDim2.new(1, -1, 1, -1),
        Position = UDim2.new(0, 1, 0, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 255),
        TextColor3 = Color3.new(1, 1, 1),
        Text = options[1],
        TextSize = 14,
        Font = Enum.Font.Code,
        Parent = selectorFrame
    })

    local uiCornerSelector = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = selectorButton })

    local open = false
    local optionFrames = {}

    selectorButton.MouseButton1Click:Connect(function()
        open = not open
        for _, frame in pairs(optionFrames) do
            frame.Visible = open
        end
    end)

    for i, option in ipairs(options) do
        local optionFrame = create("TextButton", {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, i, 0),
            BackgroundColor3 = Color3.fromRGB(40, 40, 40),
            TextColor3 = Color3.new(1, 1, 1),
            Text = option,
            TextSize = 14,
            Font = Enum.Font.Code,
            Visible = false,
            Parent = selectorFrame
        })

        local uiCornerOption = create("UICorner", { CornerRadius = UDim.new(0, 5), Parent = optionFrame })

        optionFrame.MouseButton1Click:Connect(function()
            selectorButton.Text = option
            open = false
            for _, frame in pairs(optionFrames) {
                frame.Visible = false
            end
            callback(option)
        end)

        table.insert(optionFrames, optionFrame)
    end

    return selectorFrame
end

return UI
