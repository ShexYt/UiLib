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

function UI.AddWindow(title, titleColor, secondTitle, secondTitleColor)
    local gui = Instance.new("ScreenGui")
    gui.Name = "UiLibGui"
    gui.Parent = game.CoreGui

    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0.5, 0, 0.7, 0)
    Main.Position = UDim2.new(0.25, 0, 0.15, 0)
    Main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Main.BorderColor3 = Color3.new(0, 0, 0)
    Main.BorderSizePixel = 1
    Main.Active = true
    Main.BackgroundTransparency = 0
    Main.Draggable = true
    Main.Parent = gui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 0, 0.2, 0)
    Title.Position = UDim2.new(0.5, 0, -0.08, 0)
    Title.BackgroundColor3 = Color3.new(0, 0, 0)
    Title.BorderColor3 = Color3.new(0, 0, 0)
    Title.BorderSizePixel = 1
    Title.Text = title
    Title.TextSize = 14
    Title.BackgroundTransparency = 1
    Title.TextColor3 = titleColor
    Title.Font = Enum.Font.Code
    Title.Parent = Main

    local SecondTitle = Instance.new("TextLabel")
    SecondTitle.Size = UDim2.new(0, 0, 0.2, 0)
    SecondTitle.Position = UDim2.new(0.55, 0, -0.08, 0)
    SecondTitle.BackgroundColor3 = Color3.new(0, 0, 0)
    SecondTitle.BorderColor3 = Color3.new(0, 0, 0)
    SecondTitle.BorderSizePixel = 1
    SecondTitle.Text = secondTitle
    SecondTitle.TextSize = 13
    SecondTitle.BackgroundTransparency = 1
    SecondTitle.TextColor3 = secondTitleColor
    SecondTitle.Font = Enum.Font.Code
    SecondTitle.Parent = Main

    return Main
end

function UI.AddTabs(parent)
    local Tabs = Instance.new("Frame")
    Tabs.Size = UDim2.new(0.3, 0, 0.9, 0)
    Tabs.Position = UDim2.new(0, 0, 0.1, 0)
    Tabs.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    Tabs.BorderColor3 = Color3.new(0, 0, 1)
    Tabs.BorderSizePixel = 1
    Tabs.Active = true
    Tabs.BackgroundTransparency = 0
    Tabs.Parent = parent

    return Tabs
end

function UI.AddButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.8, 0, 0.1, 0)
    Button.Position = UDim2.new(0.1, 0, 0.1, 0)
    Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Font = Enum.Font.Code
    Button.TextSize = 14
    Button.MouseButton1Click:Connect(callback)
    Button.Parent = parent

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Button

    return Button
end

function UI.AddSlider(parent, min, max, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.8, 0, 0.1, 0)
    SliderFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
    SliderFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    SliderFrame.Parent = parent

    local Slider = Instance.new("TextButton")
    Slider.Size = UDim2.new(0, 10, 1, 0)
    Slider.BackgroundColor3 = Color3.new(1, 1, 1)
    Slider.Position = UDim2.new(0, 0, 0, 0)
    Slider.Draggable = true
    Slider.Parent = SliderFrame

    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.2, 0, 1, 0)
    TextBox.Position = UDim2.new(0.8, 0, 0, 0)
    TextBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.Text = tostring(min)
    TextBox.Parent = SliderFrame

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = SliderFrame

    Slider.Changed:Connect(function()
        local scale = Slider.Position.X.Scale
        local value = min + (max - min) * scale
        TextBox.Text = tostring(math.floor(value))
        callback(value)
    end)

    TextBox.FocusLost:Connect(function()
        local value = tonumber(TextBox.Text)
        if value then
            value = math.clamp(value, min, max)
            Slider.Position = UDim2.new((value - min) / (max - min), 0, 0, 0)
            callback(value)
        end
    end)

    return SliderFrame
end

function UI.AddTextbox(parent, callback)
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(0.8, 0, 0.1, 0)
    TextBox.Position = UDim2.new(0.1, 0, 0.5, 0)
    TextBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    TextBox.TextColor3 = Color3.new(1, 1, 1)
    TextBox.PlaceholderText = "Enter text..."
    TextBox.TextSize = 14
    TextBox.Font = Enum.Font.Code
    TextBox.Parent = parent

    TextBox.FocusLost:Connect(function()
        callback(TextBox.Text)
    end)

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = TextBox

    return TextBox
end

function UI.AddSwitch(parent, callback)
    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.new(0.2, 0, 0.1, 0)
    Switch.Position = UDim2.new(0.1, 0, 0.7, 0)
    Switch.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Switch.Parent = parent

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0.5, 0, 1, 0)
    Toggle.BackgroundColor3 = Color3.new(1, 1, 1)
    Toggle.Text = ""
    Toggle.Parent = Switch

    local UICorner = Instance.new("UICorner")
    UICorner.Parent = Switch

    local state = false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.Position = state and UDim2.new(0.5, 0, 0, 0) or UDim2.new(0, 0, 0, 0)
        callback(state)
    end)

    return Switch
end

function UI.AddSelector(parent, options, callback)
    local SelectorFrame = Instance.new("Frame")
    SelectorFrame.Size = UDim2.new(0.8, 0, 0.1, 0)
    SelectorFrame.Position = UDim2.new(0.1, 0, 0.9, 0)
    SelectorFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    SelectorFrame.Parent = parent

    local SelectedText = Instance.new("TextLabel")
    SelectedText.Size = UDim2.new(0.8, 0, 1, 0)
    SelectedText.Position = UDim2.new(0, 0, 0, 0)
    SelectedText.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    SelectedText.TextColor3 = Color3.new(1, 1, 1)
    SelectedText.Text = options[1]
    SelectedText.TextSize = 14
    SelectedText.Font = Enum.Font.Code
    SelectedText.Parent = SelectorFrame

    local OpenClose = Instance.new("TextButton")
    OpenClose.Size = UDim2.new(0.2, 0, 1, 0)    OpenClose.Position = UDim2.new(0.8, 0, 0, 0)
    OpenClose.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    OpenClose.TextColor3 = Color3.new(1, 1, 1)
    OpenClose.Text = "▼"
    OpenClose.TextSize = 14
    OpenClose.Font = Enum.Font.Code
    OpenClose.Parent = SelectorFrame

    local OptionFrame = Instance.new("Frame")
    OptionFrame.Size = UDim2.new(0.8, 0, #options * 0.1, 0)
    OptionFrame.Position = UDim2.new(0.1, 0, 1, 0)
    OptionFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    OptionFrame.Visible = false
    OptionFrame.Parent = parent

    for i, option in ipairs(options) do
        local Option = Instance.new("TextButton")
        Option.Size = UDim2.new(1, 0, 1 / #options, 0)
        Option.Position = UDim2.new(0, 0, (i - 1) / #options, 0)
        Option.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        Option.TextColor3 = Color3.new(1, 1, 1)
        Option.Text = option
        Option.TextSize = 14
        Option.Font = Enum.Font.Code
        Option.MouseButton1Click:Connect(function()
            SelectedText.Text = option
            OptionFrame.Visible = false
            callback(option)
        end)
        Option.Parent = OptionFrame
    end

    OpenClose.MouseButton1Click:Connect(function()
        OptionFrame.Visible = not OptionFrame.Visible
    end)

    return SelectorFrame
end

return UI
