require("hs.ipc")

-- Hello world
-- hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
--   hs.notify.new({title="Hammerspoon", informativeText="Hello World"}):send()
-- end)

-- Backing recursive function to support repeated single image lightroom export
local isLightroomExportRunning = false
local lightroomName = "Adobe Lightroom"
local function lightroomExportLoop()
  if not running then return end
  hs.application.launchOrFocus(lightroomName)
  hs.eventtap.keyStroke({"cmd"}, "E")
  hs.timer.doAfter(50, function()
    if not running then return end
    hs.eventtap.keyStroke({}, "right")
    hs.timer.doAfter(10, function()
      if not running then return end
      lightroomExportLoop()
    end)
  end)
end

-- Adobe drip export
-- hs.hotkey.bind({"cmd", "shift"}, "E", function()
--   local lightroom = hs.appfinder.appFromName(lightroomName)
--   if not lightroom then
--     hs.alert.show("Lightroom is not currently running")
--     return
--   end

--   running = not running
--   if running then
--     hs.alert.show("Lightroom export started")
--     lightroomExportLoop()
--   else
--     hs.alert.show("Lightroom export stopped")
--   end
-- end)

-- Launch fancy terminal
hs.hotkey.bind({"cmd", "shift"}, "T", function()
  hs.application.launchOrFocus("Wezterm")
  local wezterm = hs.appfinder.appFromName("Wezterm")
  hs.eventtap.keyStrokes("neofetch")
  hs.eventtap.keyStroke({}, "return")
end)

-- Focused window movement
hs.hotkey.bind({"cmd", "shift"}, "W", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.y = f.y - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift"}, "A", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x - 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift"}, "S", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.y = f.y + 10
  win:setFrame(f)
end)

hs.hotkey.bind({"cmd", "shift"}, "D", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x + 10
  win:setFrame(f)
end)
