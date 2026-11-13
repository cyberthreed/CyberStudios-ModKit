-- Color Toggler UI
-- Recolors supported UMG interface widgets and preserves emotion/mood/status semantics.

local function srgbChannelToLinear(value)
    local channel = value / 255
    if channel <= 0.04045 then return channel / 12.92 end
    return ((channel + 0.055) / 1.055) ^ 2.4
end

local function rgb(red, green, blue)
    return {
        R = srgbChannelToLinear(red),
        G = srgbChannelToLinear(green),
        B = srgbChannelToLinear(blue)
    }
end

local MODES = {
    {
        Name = "Pink",
        Main = rgb(232, 93, 158),      -- #E85D9E
        MapIcon = rgb(232, 93, 158),   -- match the selected pink
        Accent = rgb(220, 80, 127),    -- #DC507F
        Hover = rgb(239, 133, 181),    -- #EF85B5
        Pressed = rgb(200, 71, 130),   -- #C84782
        Disabled = rgb(241, 201, 219)  -- #F1C9DB
    },
    {
        Name = "Baby Pink",
        Main = rgb(242, 189, 207),     -- #F2BDCF
        MapIcon = rgb(242, 189, 207),  -- ballet pink
        Accent = rgb(220, 80, 127),    -- #DC507F
        Hover = rgb(232, 143, 175),    -- #E88FAF
        Pressed = rgb(216, 110, 148),  -- #D86E94
        Disabled = rgb(234, 214, 221)  -- #EAD6DD
    },
    {
        Name = "Hot Pink",
        Main = rgb(247, 159, 198),     -- #F79FC6
        MapIcon = rgb(235, 91, 157),   -- #EB5B9D
        Accent = rgb(216, 69, 133),    -- #D84585
        Hover = rgb(244, 134, 183),    -- #F486B7
        Pressed = rgb(231, 111, 163),  -- #E76FA3
        Disabled = rgb(239, 202, 219)  -- #EFCADB
    },
    {
        Name = "Lavender",
        Main = rgb(230, 230, 250), MapIcon = rgb(230, 230, 250),
        Accent = rgb(128, 96, 185), Hover = rgb(198, 180, 231),
        Pressed = rgb(176, 153, 220), Disabled = rgb(235, 231, 245)
    },
    {
        Name = "Black",
        Main = rgb(8, 8, 10), MapIcon = rgb(235, 235, 238),
        Accent = rgb(235, 235, 238), Hover = rgb(42, 42, 46),
        Pressed = rgb(22, 22, 25), Disabled = rgb(58, 58, 62),
        Text = rgb(245, 245, 247)
    },
    {
        Name = "Mint-Choco",
        Main = rgb(191, 232, 208), MapIcon = rgb(107, 66, 38),
        Accent = rgb(107, 66, 38), Button = rgb(137, 91, 65),
        Hover = rgb(157, 111, 82), Pressed = rgb(112, 73, 51),
        Disabled = rgb(191, 159, 138), ButtonText = rgb(255, 245, 229)
    },
    {
        Name = "Neapolitan",
        Main = rgb(255, 241, 214), MapIcon = rgb(242, 189, 207),
        Accent = rgb(107, 66, 38), Hover = rgb(242, 189, 207),
        Pressed = rgb(231, 185, 192), Disabled = rgb(246, 232, 219)
    },
    {
        Name = "Red",
        Main = rgb(255, 190, 190), MapIcon = rgb(255, 190, 190),
        Accent = rgb(210, 48, 48), Hover = rgb(249, 151, 151),
        Pressed = rgb(235, 125, 125), Disabled = rgb(245, 222, 222)
    },
    {
        Name = "Orange",
        Main = rgb(255, 214, 177), MapIcon = rgb(255, 214, 177),
        Accent = rgb(207, 103, 20), Hover = rgb(255, 186, 122),
        Pressed = rgb(242, 163, 84), Disabled = rgb(246, 230, 214)
    },
    {
        Name = "Yellow",
        Main = rgb(255, 244, 176), MapIcon = rgb(255, 244, 176),
        Accent = rgb(157, 121, 0), Hover = rgb(255, 231, 120),
        Pressed = rgb(239, 211, 77), Disabled = rgb(246, 241, 213)
    },
    {
        Name = "Green",
        Main = rgb(196, 232, 199), MapIcon = rgb(196, 232, 199),
        Accent = rgb(44, 126, 72), Hover = rgb(150, 211, 157),
        Pressed = rgb(116, 190, 128), Disabled = rgb(226, 239, 227)
    },
    {
        Name = "Blue",
        Main = rgb(190, 220, 246), MapIcon = rgb(190, 220, 246),
        Accent = rgb(43, 105, 162), Hover = rgb(143, 193, 235),
        Pressed = rgb(108, 169, 222), Disabled = rgb(224, 236, 246)
    },
    {
        Name = "Violet",
        Main = rgb(215, 195, 239), MapIcon = rgb(215, 195, 239),
        Accent = rgb(112, 66, 156), Hover = rgb(183, 151, 222),
        Pressed = rgb(152, 112, 203), Disabled = rgb(235, 229, 243)
    },
    {
        Name = "Pastel Red",
        Main = rgb(255, 170, 181),
        MapIcon = rgb(255, 170, 181),
        Accent = rgb(208, 103, 124),
        Hover = rgb(250, 147, 164),
        Pressed = rgb(234, 125, 146),
        Disabled = rgb(244, 201, 209)
    },
    {
        Name = "Pastel Orange",
        Main = rgb(255, 199, 151),
        MapIcon = rgb(255, 199, 151),
        Accent = rgb(200, 129, 69),
        Hover = rgb(255, 179, 119),
        Pressed = rgb(238, 158, 96),
        Disabled = rgb(246, 218, 193)
    },
    {
        Name = "Pastel Yellow",
        Main = rgb(255, 234, 143),
        MapIcon = rgb(255, 234, 143),
        Accent = rgb(176, 146, 47),
        Hover = rgb(255, 224, 109),
        Pressed = rgb(238, 204, 82),
        Disabled = rgb(245, 234, 188)
    },
    {
        Name = "Pastel Green",
        Main = rgb(169, 222, 169),
        MapIcon = rgb(169, 222, 169),
        Accent = rgb(86, 156, 99),
        Hover = rgb(144, 208, 147),
        Pressed = rgb(118, 188, 126),
        Disabled = rgb(204, 232, 204)
    },
    {
        Name = "Pastel Blue",
        Main = rgb(163, 210, 240),
        MapIcon = rgb(163, 210, 240),
        Accent = rgb(75, 144, 187),
        Hover = rgb(136, 192, 229),
        Pressed = rgb(109, 171, 212),
        Disabled = rgb(201, 225, 240)
    },
    {
        Name = "Pastel Violet",
        Main = rgb(202, 177, 235),
        MapIcon = rgb(202, 177, 235),
        Accent = rgb(139, 103, 185),
        Hover = rgb(183, 151, 223),
        Pressed = rgb(163, 130, 205),
        Disabled = rgb(224, 209, 241)
    },
    {
        Name = "Rainbow",
        Main = rgb(255, 220, 220), MapIcon = rgb(255, 220, 220),
        Accent = rgb(151, 94, 199), Hover = rgb(255, 222, 170),
        Pressed = rgb(179, 230, 173), Disabled = rgb(220, 231, 245),
        Rainbow = "vivid"
    },
    {
        Name = "Pastel Rainbow",
        Main = rgb(255, 218, 222), MapIcon = rgb(237, 227, 248),
        Accent = rgb(177, 153, 207), Hover = rgb(255, 230, 207),
        Pressed = rgb(222, 244, 220), Disabled = rgb(239, 246, 250),
        Rainbow = "pastel"
    },
    { Name = "Off" }
}
local TAG = "[Color Toggler UI] "
local modeIndex = 2
local scriptSource = debug.getinfo(1, "S").source
local scriptDirectory = scriptSource:match("^@(.+[/\\])")
local settingsPath = scriptDirectory and (scriptDirectory .. "theme.txt") or nil

local function loadTheme()
    if not settingsPath then
        print(TAG .. "Cannot locate theme settings file.\n")
        return
    end
    local file = io.open(settingsPath, "r")
    if not file then return end
    local name = file:read("*l")
    file:close()
    if not name then return end
    name = name:gsub("%s+$", "")
    for index, mode in ipairs(MODES) do
        if mode.Name == name then
            modeIndex = index
            return
        end
    end
end

local function saveTheme()
    if not settingsPath then return end
    local file, failure = io.open(settingsPath, "w")
    if not file then
        print(TAG .. "Could not save theme: " .. tostring(failure) .. "\n")
        return
    end
    local written, writeFailure = file:write(MODES[modeIndex].Name .. "\n")
    local closed, closeFailure = file:close()
    if not written or not closed then
        print(TAG .. "Could not save theme: " .. tostring(writeFailure or closeFailure) .. "\n")
    end
end

loadTheme()
local saved = {}
local handled = 0
local skipped = 0
local rainbowSerial = 0

local RAINBOW_VIVID = {
    rgb(255, 140, 140), rgb(255, 181, 112), rgb(255, 235, 112),
    rgb(130, 205, 137), rgb(120, 190, 235), rgb(171, 132, 218)
}
local RAINBOW_PASTEL = {
    rgb(255, 170, 181),
    rgb(255, 199, 151),
    rgb(255, 234, 143),
    rgb(169, 222, 169),
    rgb(163, 210, 240),
    rgb(202, 177, 235)
}

local EXCLUDED = {
    "familyties", "cybercore", "emotion", "mood"
}
local NON_UI_ART = {
    "portrait", "avatar", "zoihead", "worldmap", "citythumbnail",
    "screenshot", "photothumbnail", "landscape"
}
local BACKGROUND_WORDS = {
    "background", "bg_", "_bg", "panel", "frame", "plate", "track", "fill", "bar"
}
local MAP_CONTEXT_WORDS = {
    "map", "minimap", "mini_map", "world_map", "interaction", "waypoint",
    "objective", "worldindicator", "world_marker", "location", "landmark",
    "building", "lotmarker", "poi", "facility", "destination"
}
local MAP_ICON_WORDS = {
    "mapicon", "map_icon", "map-pin", "map_pin", "mappin", "mapmarker", "map_marker",
    "poi", "pin", "marker", "landmark", "location", "icon", "indicator", "target", "quest",
    "symbol", "facility", "destination"
}

local function safe(fn)
    local ok, value = pcall(fn)
    if ok then return value end
    return nil
end

local function lowerName(widget)
    return safe(function() return string.lower(widget:GetFullName()) end) or ""
end

local function containsAny(value, terms)
    for _, term in ipairs(terms) do
        if string.find(value, term, 1, true) then return true end
    end
    return false
end

local function isExcluded(widget)
    local name = lowerName(widget)
    return containsAny(name, EXCLUDED)
end

local function isNonUIArt(widget)
    return containsAny(lowerName(widget), NON_UI_ART)
end

local function isNamedPanelImage(widget)
    local fullName = lowerName(widget)
    local widgetName = fullName:match("[^%.:]+$") or fullName
    return not isNonUIArt(widget) and containsAny(widgetName, BACKGROUND_WORDS)
end

local function isMapIcon(widget)
    local fullName = lowerName(widget)
    local resourceName = safe(function()
        local resource = widget.Brush.ResourceObject
        if resource and resource:IsValid() then return string.lower(resource:GetFullName()) end
        return ""
    end) or ""
    local searchName = fullName .. " " .. resourceName
    return containsAny(searchName, MAP_CONTEXT_WORDS) and containsAny(searchName, MAP_ICON_WORDS)
end

local function isPhoneIcon(widget)
    local name = lowerName(widget)
    local resourceName = safe(function()
        return string.lower(widget.Brush.ResourceObject:GetFullName())
    end) or ""
    local combined = name .. " " .. resourceName
    return containsAny(combined, { "phone", "smartphone", "cellphone" })
        and containsAny(combined, { "icon", "image", "img", "symbol", "sprite" })
        and not isNonUIArt(widget)
end

local function isA(widget, className)
    return safe(function() return widget:IsA(className) end) == true
end

local function getPath(object, path)
    local value = object
    for _, key in ipairs(path) do
        value = value[key]
        if value == nil then return nil end
    end
    return value
end

local function colorStruct(target)
    if target == nil then return nil end
    local specified = safe(function() return target.SpecifiedColor end)
    if specified ~= nil then return specified end
    return target
end

local function readColor(target)
    local c = colorStruct(target)
    if c == nil then return nil end
    local r = safe(function() return c.R end)
    local g = safe(function() return c.G end)
    local b = safe(function() return c.B end)
    local a = safe(function() return c.A end)
    if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then return nil end
    return { R = r, G = g, B = b, A = (type(a) == "number" and a or 1) }
end

local function linearToSrgb(value)
    if value <= 0.0031308 then return value * 12.92 end
    return 1.055 * (value ^ (1 / 2.4)) - 0.055
end

local function hasBlueHue(color)
    if not color then return false end
    local r, g, b = linearToSrgb(color.R), linearToSrgb(color.G), linearToSrgb(color.B)
    local maximum = math.max(r, g, b)
    local minimum = math.min(r, g, b)
    local delta = maximum - minimum
    if delta < 0.08 or maximum <= 0 then return false end
    local saturation = delta / maximum
    if saturation < 0.22 then return false end
    local hue
    if maximum == r then
        hue = 60 * (((g - b) / delta) % 6)
    elseif maximum == g then
        hue = 60 * (((b - r) / delta) + 2)
    else
        hue = 60 * (((r - g) / delta) + 4)
    end
    return hue >= 175 and hue <= 255
end

local function isDarkNeutral(color)
    if not color then return false end
    local maximum = math.max(color.R, color.G, color.B)
    local minimum = math.min(color.R, color.G, color.B)
    local luminance = 0.2126 * color.R + 0.7152 * color.G + 0.0722 * color.B
    return (maximum - minimum) < 0.16 and luminance < 0.34
end

local function writeColor(target, color)
    local c = colorStruct(target)
    if c == nil then return false end
    local alpha = safe(function() return c.A end)
    local ok = pcall(function()
        c.R = color.R
        c.G = color.G
        c.B = color.B
        if type(alpha) == "number" then c.A = color.A or alpha end
    end)
    return ok
end

local function makePath(widget, path)
    local target = safe(function() return getPath(widget, path) end)
    if target == nil then return nil end
    local original = readColor(target)
    if original == nil then return nil end
    return { Path = path, Original = original }
end

local function widgetPlan(widget)
    local plan = {}
    if isA(widget, "/Script/UMG.Border") then
        local item = makePath(widget, { "BrushColor" })
        if item then item.ColorKey = "Main"; plan[#plan + 1] = item end
    end

    if isA(widget, "/Script/UMG.Button") then
        local states = {
            { "Normal", "Button" }, { "Hovered", "Hover" },
            { "Pressed", "Pressed" }, { "Disabled", "Disabled" }
        }
        for _, state in ipairs(states) do
            local item = makePath(widget, { "WidgetStyle", state[1], "TintColor" })
            if item then item.ColorKey = state[2]; plan[#plan + 1] = item end
        end
    end

    if isA(widget, "/Script/UMG.ProgressBar") then
        -- Recolor the track, plus blue/cyan fills (loading bars). Preserve other hues
        -- so red, green, and yellow status meters keep their original meaning.
        local item = makePath(widget, { "WidgetStyle", "BackgroundImage", "TintColor" })
        if item then item.ColorKey = "Main"; plan[#plan + 1] = item end
        local fill = makePath(widget, { "FillColorAndOpacity" })
        local blueFill = fill ~= nil and hasBlueHue(fill.Original)
        if blueFill then fill.ColorKey = "Accent"; plan[#plan + 1] = fill end
        if blueFill then
            local brush = makePath(widget, { "WidgetStyle", "FillImage", "TintColor" })
            if brush then brush.ColorKey = "Accent"; plan[#plan + 1] = brush end
        end
    end

    if isA(widget, "/Script/UMG.Image") and (isMapIcon(widget) or isNamedPanelImage(widget) or isPhoneIcon(widget)) then
        local phoneIcon = isPhoneIcon(widget)
        local mapIcon = isMapIcon(widget) or phoneIcon
        local item = makePath(widget, { "Brush", "TintColor" })
        local opacity = mapIcon and makePath(widget, { "ColorAndOpacity" }) or nil
        if item then
            item.ColorKey = mapIcon and (opacity and "MapBrush" or "MapIcon") or "Main"
            plan[#plan + 1] = item
        end
        if opacity then
            opacity.ColorKey = phoneIcon and "PhoneIcon" or "MapIcon"
            plan[#plan + 1] = opacity
        end
    end

    if isA(widget, "/Script/UMG.TextBlock") then
        local item = makePath(widget, { "ColorAndOpacity" })
        if item and isDarkNeutral(item.Original) then
            item.ColorKey = "Text"
            plan[#plan + 1] = item
        end
    end

    -- inZOI's blur widgets expose a tint field. Access is guarded for game-version differences.
    local className = safe(function() return string.lower(widget:GetClass():GetFullName()) end) or ""
    if string.find(className, "backgroundblur", 1, true) then
        local item = makePath(widget, { "BlurTint" })
        if item then item.ColorKey = "Main"; plan[#plan + 1] = item end
    end
    return plan
end

local function redrawWidget(widget)
    if isA(widget, "/Script/UMG.Border") then
        safe(function() widget:SetBrushColor(widget.BrushColor) end)
    elseif isA(widget, "/Script/UMG.Button") then
        safe(function() widget:SetStyle(widget.WidgetStyle) end)
    elseif isA(widget, "/Script/UMG.Image") then
        safe(function() widget:SetBrush(widget.Brush) end)
        safe(function() widget:SetColorAndOpacity(widget.ColorAndOpacity) end)
    elseif isA(widget, "/Script/UMG.TextBlock") then
        safe(function() widget:SetColorAndOpacity(widget.ColorAndOpacity) end)
    elseif isA(widget, "/Script/UMG.ProgressBar") then
        safe(function() widget:SetWidgetStyle(widget.WidgetStyle) end)
        safe(function() widget:SetFillColorAndOpacity(widget.FillColorAndOpacity) end)
    end
end

local function applyWidget(widget)
    if not widget or safe(function() return widget:IsValid() end) ~= true then return end
    if isExcluded(widget) then skipped = skipped + 1; return end
    local address = safe(function() return widget:GetAddress() end)
    if not address then return end

    local record = saved[address]
    if record and (safe(function() return record.Object:IsValid() end) ~= true or lowerName(record.Object) ~= lowerName(widget)) then
        saved[address] = nil
        record = nil
    end
    if not record then
        rainbowSerial = rainbowSerial + 1
        record = { Object = widget, Paths = widgetPlan(widget), Sequence = rainbowSerial }
        if #record.Paths == 0 then return end
        saved[address] = record
    end

    local mode = MODES[modeIndex]
    if mode.Name ~= "Off" then
        for itemIndex, item in ipairs(record.Paths) do
            local target = safe(function() return getPath(widget, item.Path) end)
            if target then
                local color = mode[item.ColorKey]
                if item.ColorKey == "Button" then color = mode.Button or mode.Main end
                if item.ColorKey == "Text" and mode.ButtonText then
                    local parent = safe(function() return widget:GetParent() end)
                    for depth = 1, 8 do
                        if not parent or safe(function() return parent:IsValid() end) ~= true then break end
                        if isA(parent, "/Script/UMG.Button") then
                            color = mode.ButtonText
                            break
                        end
                        parent = safe(function() return parent:GetParent() end)
                    end
                end
                if item.ColorKey == "PhoneIcon" then
                    color = mode.Name == "Black" and rgb(235, 235, 238) or mode.Accent
                end
                if item.ColorKey == "MapBrush" then color = rgb(255, 255, 255) end
                if item.ColorKey ~= "Text" and item.ColorKey ~= "MapBrush" and mode.Rainbow == "vivid" then
                    color = RAINBOW_VIVID[((record.Sequence + itemIndex - 2) % #RAINBOW_VIVID) + 1]
                elseif item.ColorKey ~= "Text" and item.ColorKey ~= "MapBrush" and mode.Rainbow == "pastel" then
                    color = RAINBOW_PASTEL[((record.Sequence + itemIndex - 2) % #RAINBOW_PASTEL) + 1]
                end
                if color then writeColor(target, color) else writeColor(target, item.Original) end
            end
        end
    else
        for _, item in ipairs(record.Paths) do
            local target = safe(function() return getPath(widget, item.Path) end)
            if target then writeColor(target, item.Original) end
        end
    end
    if isA(widget, "/Script/UMG.ProgressBar") then
        safe(function() widget:SetFillColorAndOpacity(widget.FillColorAndOpacity) end)
    end
    redrawWidget(widget)
    handled = handled + 1
end

local function restoreAll()
    for address, record in pairs(saved) do
        local object = record.Object
        if object and safe(function() return object:IsValid() end) == true then
            for _, item in ipairs(record.Paths) do
                local target = safe(function() return getPath(object, item.Path) end)
                if target then writeColor(target, item.Original) end
            end
            if isA(object, "/Script/UMG.ProgressBar") then
                safe(function() object:SetFillColorAndOpacity(object.FillColorAndOpacity) end)
            end
            redrawWidget(object)
        else
            saved[address] = nil
        end
    end
end

local function watch(className)
    NotifyOnNewObject(className, function(widget)
        if not widget or safe(function() return widget:IsValid() end) ~= true then return end
        if isExcluded(widget) then skipped = skipped + 1; return end
        -- Defer until UMG has initialized its brush/style defaults.
        ExecuteInGameThreadWithDelay(250, function()
            if widget and safe(function() return widget:IsValid() end) == true then
                applyWidget(widget)
            end
        end)
    end)
end

watch("/Script/UMG.Border")
watch("/Script/UMG.Button")
watch("/Script/UMG.ProgressBar")
watch("/Script/UMG.Image")
watch("/Script/UMG.TextBlock")
watch("/Script/UMG.BackgroundBlur")

-- Refresh after world transitions and color changes because gameplay creates new HUDs.
local scanClasses = { "Border", "Button", "ProgressBar", "B1BackgroundBlur", "Image", "TextBlock" }
local scanGeneration = 0
local function refreshWidgets()
    scanGeneration = scanGeneration + 1
    local generation = scanGeneration
    for index, className in ipairs(scanClasses) do
        local scanClass = className
        ExecuteInGameThreadWithDelay((index - 1) * 350, function()
            if generation ~= scanGeneration then return end
            local widgets = safe(function() return FindAllOf(scanClass) end)
            local count = 0
            if type(widgets) == "table" then
                for _, widget in pairs(widgets) do
                    if widget and safe(function() return widget:IsValid() end) == true then
                        applyWidget(widget)
                        count = count + 1
                    end
                end
            end
            print(TAG .. string.format("Refresh %s: %d objects.\n", scanClass, count))
        end)
    end
end

local function refreshAfterLoad()
    for _, delay in ipairs({ 2000, 8000, 20000 }) do
        ExecuteInGameThreadWithDelay(delay, refreshWidgets)
    end
end
RegisterLoadMapPostHook(function() refreshAfterLoad() end)
RegisterHook("/Script/Engine.PlayerController:ClientRestart", function() refreshAfterLoad() end)
refreshAfterLoad()

local function showModeIndicator()
    local controllers = safe(function() return FindAllOf("PlayerController") end)
    if type(controllers) ~= "table" then
        print(TAG .. "Palette indicator: no player controller available.\n")
        return
    end
    for _, controller in pairs(controllers) do
        if safe(function() return controller:IsValid() and controller:IsLocalController() end) then
            local ok, failure = pcall(function()
                controller:ClientMessage("UI color: " .. MODES[modeIndex].Name, FName("ColorTogglerUI"), 2.5)
            end)
            if not ok then print(TAG .. "Palette indicator unavailable: " .. tostring(failure) .. "\n") end
            return
        end
    end
end

local function changeMode(direction)
    modeIndex = ((modeIndex - 1 + direction) % #MODES) + 1
    saveTheme()
    ExecuteInGameThread(function()
        if MODES[modeIndex].Name == "Off" then
            restoreAll()
        else
            for _, record in pairs(saved) do applyWidget(record.Object) end
        end
        refreshWidgets()
        showModeIndicator()
        print(TAG .. "Mode: " .. MODES[modeIndex].Name .. "\n")
    end)
end

RegisterKeyBind(Key.C, { ModifierKey.CONTROL, ModifierKey.ALT, ModifierKey.SHIFT }, function()
    changeMode(1)
end)

print(TAG .. "Loaded theme: " .. MODES[modeIndex].Name .. ". Press CTRL+ALT+SHIFT+C to cycle colors.\n")
