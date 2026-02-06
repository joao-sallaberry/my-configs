-- Hammerspoon init file: ~/.hammerspoon/init.lua

-- Move Chrome to screen (cycles through all screens)
local currentScreenIndex = 0 -- Track current screen index for cycling
hs.hotkey.bind({"cmd", "shift"}, "D", function()
    -- Init logger
    local log = hs.logger.new('move-chrome','debug')
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

    -- Move all Chrome windows to the target screen
    local chrome = hs.application.get("Google Chrome")
    -- log.i("bundle: " .. chrome:bundleID())
    if chrome then
        log.i("window count: " .. #chrome:visibleWindows())
        -- log.i(ipairs(chrome:visibleWindows()))
        for _, win in ipairs(chrome:visibleWindows()) do
            -- if no windows are found, go to System Settings → Privacy & Security → Accessibility
            -- and check HHammerspoon
            -- log.i("win: " .. win:title())
            win:moveToScreen(targetScreen)
        end
        hs.alert.show("Moved Chrome to " .. targetScreen:name())
    else
        hs.alert.show("Google Chrome is not running")
    end
end)
