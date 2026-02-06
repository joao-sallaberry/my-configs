-- Hammerspoon init file: ~/.hammerspoon/init.lua

-- Move current app to screen (cycles through all screens)
local currentScreenIndex = 0 -- Track current screen index for cycling
hs.hotkey.bind({"cmd", "shift"}, "D", function()
    -- Init logger
    local log = hs.logger.new('move-app','debug')
    log.i('Initializing') -- will print "[mymodule] Initializing" to the console```    

    -- Get all connected screens
    local allScreens = hs.screen.allScreens()
    for key, value in pairs(allScreens) do
        log.i(key, value)
    end 

    -- Check if we have any screens
    if #allScreens == 0 then
        hs.alert.show("No screens found")
        return
    end

    -- Cycle to the next screen
    currentScreenIndex = (currentScreenIndex % #allScreens) + 1
    local targetScreen = allScreens[currentScreenIndex]
    log.i("targetScreen: " .. targetScreen:name())

    -- Move all windows of the current app to the target screen
    local currentApp = hs.application.frontmostApplication()
    -- log.i("bundle: " .. currentApp:bundleID())
    if currentApp then
        log.i("window count: " .. #currentApp:visibleWindows())
        -- log.i(ipairs(currentApp:visibleWindows()))
        for _, win in ipairs(currentApp:visibleWindows()) do
            -- if no windows are found, go to System Settings → Privacy & Security → Accessibility
            -- and check Hammerspoon
            -- log.i("win: " .. win:title())
            win:moveToScreen(targetScreen)
        end
        hs.alert.show("Moved " .. currentApp:name() .. " to " .. targetScreen:name())
    else
        hs.alert.show("No application is focused")
    end
end)
