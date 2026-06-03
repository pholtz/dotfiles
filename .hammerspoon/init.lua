require("hs.ipc")

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


-- ── Lightroom drip export ──────────────────────────────────────────────
local lightroomName = "Adobe Lightroom"

-- Tunable delays (seconds)
local focusSettleDelay   = 0.5   -- wait for Lightroom to actually come to the front
local exportProcessDelay = 50    -- wait for the (slow) export to finish before advancing
local imageAdvanceDelay  = 10    -- wait after advancing to the next image before looping

local lightroomExportRunning = false

-- Bring Lightroom to the front, then run fn once it's genuinely frontmost.
local function focusLightroomThen(fn)
  local app = hs.application.get(lightroomName)
  if app and app:isFrontmost() then
    fn()
    return
  end
  hs.application.launchOrFocus(lightroomName)
  hs.timer.waitUntil(
    function()
      local a = hs.application.get(lightroomName)
      return a and a:isFrontmost()
    end,
    fn,
    0.1
  )
end

local function lightroomExportLoop()
  if not lightroomExportRunning then return end
  focusLightroomThen(function()
    if not lightroomExportRunning then return end
    hs.eventtap.keyStroke({"cmd"}, "E")
    hs.timer.doAfter(exportProcessDelay, function()
      if not lightroomExportRunning then return end
      hs.eventtap.keyStroke({}, "right")
      hs.timer.doAfter(imageAdvanceDelay, function()
        if not lightroomExportRunning then return end
        lightroomExportLoop()
      end)
    end)
  end)
end

hs.hotkey.bind({"cmd", "shift"}, "E", function()
  local lightroom = hs.appfinder.appFromName(lightroomName)
  if not lightroom then
    hs.alert.show("Lightroom is not currently running")
    return
  end

  lightroomExportRunning = not lightroomExportRunning
  if lightroomExportRunning then
    hs.alert.show("Lightroom export started")
    lightroomExportLoop()
  else
    hs.alert.show("Lightroom export stopped")
  end
end)
-- ───────────────────────────────────────────────────────────────────────
