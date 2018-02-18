-- Alternate timer theme

-- If you want to use this instead of the
-- default one, swap filenames of this file
-- and 'hud.lua'

local allowTimerToggle = WarTimer.Config.ToggleChatCmd ~= ""
local toggleCmd = "^[!/]"..WarTimer.Config.ToggleChatCmd:lower().."$"
local enableChatResponse = WarTimer.Config.ToggleChatResponse ~= ""

local function drawTime()
	local time = CurTime()
	local timeleft = (WarTimer.PhaseEnd or time) - time

	draw.RoundedBox(5, 10, 10, 180, 65, Color(200, 200, 255, 177))

	draw.DrawText(WarTimer.Config.Phases[WarTimer.Phase].name, "Trebuchet24", 95, 15, color_white, TEXT_ALIGN_CENTER)
	draw.DrawText(string.ToMinutesSeconds(timeleft), "DermaLarge", 95, 40, timeleft > 60 and color_white or Color(255, 100, 100), TEXT_ALIGN_CENTER)
end

if allowTimerToggle and not cookie.GetString("WarTimer_Disabled") then hook.Add("HUDPaint", "WarTimer_HUD", drawTime) end

local function toggleTimer(plr, msg)
	if msg:lower():match(toggleCmd) then
		if plr == LocalPlayer() then
			if cookie.GetString("WarTimer_Disabled") then
				cookie.Delete("WarTimer_Disabled")
				hook.Add("HUDPaint", "WarTimer_HUD", drawTime)
			else
				cookie.Set("WarTimer_Disabled", "1")
				hook.Remove("HUDPaint", "WarTimer_HUD")
			end
			if enableChatResponse then chat.AddText(WarTimer.Config.ChatMsgColor, WarTimer.Config.ToggleChatResponse) end
		end
		return true
	end
end
if allowTimerToggle then hook.Add("OnPlayerChat", "WarTimer_ToggleChatCmd", toggleTimer) end