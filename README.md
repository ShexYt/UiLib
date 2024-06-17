# Roblox UI Library

This is a simple UI library for Roblox that allows you to create customizable UI elements with a consistent theme.

## Features

- **Windows**: Create draggable windows with customizable titles.
- **Tabs**: Add tabs to organize different UI sections.
- **Buttons**: Create buttons with click callbacks.
- **Sliders**: Add sliders with min/max values and change callbacks.
- **Textboxes**: Add textboxes with input callbacks.
- **Switches**: Create toggle switches with state change callbacks.
- **Selectors**: Create dropdown selectors with options and selection callbacks.

## Installation

1. **Enable `HttpService` in your Roblox game settings**:
   - Go to `Home` > `Game Settings` > `Security` and enable `Allow HTTP Requests`.

2. **Use the following code in your Roblox project to load the UI library from the raw GitHub link**:
    ```lua
    local http = game:GetService("HttpService")

    local function LoadUILibrary()
        local url = "https://raw.githubusercontent.com/ShexYt/UiLib/main/UiLib.lua"
        local response = http:GetAsync(url)
        local UILibrary = loadstring(response)()
        return UILibrary
    end

    local UI = LoadUILibrary()

    -- Example usage of the UI library
    local mainWindow = UI.AddWindow("Main Title", Color3.new(1, 1, 1), "Subtitle", Color3.new(0, 0, 1))
    local tabs = UI.AddTabs(mainWindow)

    UI.AddButton(tabs, "Click Me", function()
        print("Button clicked!")
    end)

    UI.AddSlider(tabs, 0, 100, function(value)
        print("Slider value:", value)
    end)

    UI.AddTextbox(tabs, function(text)
        print("Textbox value:", text)
    end)

    UI.AddSwitch(tabs, function(state)
        print("Switch state:", state)
    end)

    UI.AddSelector(tabs, {"Option 1", "Option 2", "Option 3"}, function(selected)
        print("Selected option:", selected)
    end)
    ```

Replace `"https://raw.githubusercontent.com/ShexYt/UiLib/main/UiLib.lua"` with the actual path to your script on GitHub.
