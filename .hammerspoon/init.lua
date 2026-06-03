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
local exportProcessDelay = 50    -- wait for the (slow) export to finish before advancing (default; can be set via dialog)
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

-- Ask the user how long to wait between exports, then start the loop.
-- Returns true if export was started, false if the user cancelled or gave bad input.
local function promptForDelayThenStart()
  local buttonText, inputText = hs.dialog.textPrompt(
    "Lightroom Export",
    "Seconds to wait for each export to finish before advancing to the next image:",
    tostring(exportProcessDelay),  -- prefill with the current value
    "Start Export",
    "Cancel"
  )

  if buttonText ~= "Start Export" then
    return false  -- user cancelled
  end

  local seconds = tonumber(inputText)
  if not seconds or seconds <= 0 then
    hs.alert.show("Please enter a positive number of seconds")
    return false
  end

  exportProcessDelay = seconds
  return true
end

hs.hotkey.bind({"cmd", "shift"}, "E", function()
  local lightroom = hs.appfinder.appFromName(lightroomName)
  if not lightroom then
    hs.alert.show("Lightroom is not currently running")
    return
  end

  if lightroomExportRunning then
    -- Already running → this press stops it.
    lightroomExportRunning = false
    hs.alert.show("Lightroom export stopped")
    return
  end

  -- Not running → ask for the delay, then start.
  if promptForDelayThenStart() then
    lightroomExportRunning = true
    hs.alert.show(string.format("Lightroom export started (%gs per export)", exportProcessDelay))
    lightroomExportLoop()
  end
end)
-- ───────────────────────────────────────────────────────────────────────
