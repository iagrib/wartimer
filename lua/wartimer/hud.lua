-- Alternate timer display
-- (Looks like this: https://imgur.com/I6LOVe6)

-- If you want to use this instead of the
-- default one, swap filenames of this file
-- and 'hud.lua'

local allowTimerToggle = WarTimer.Config.ToggleChatCmd ~= ""
local toggleCmd = "^[!/]"..WarTimer.Config.ToggleChatCmd:lower().."$"
local enableChatResponse = WarTimer.Config.ToggleChatResponse ~= ""

local function drawTime()
	local scrw, scrh = ScrW(), ScrH()
	local scrwh = scrw / 2
	local boxpos = scrwh - 100
	local time = CurTime()
	local timeleft = (WarTimer.PhaseEnd or time) - time

	surface.SetDrawColor(0, 0, 50)
	surface.DrawRect(boxpos, 10, 200, 50)

	surface.SetDrawColor(0, 0, 0)
	surface.DrawOutlinedRect(boxpos, 10, 200, 50)

	surface.DrawRect(boxpos, 60, 200, 20)

	draw.DrawText(string.ToMinutesSeconds(timeleft), "DermaLarge", scrwh, 20, timeleft > 60 and Color(255, 255, 120) or Color(255, 0, 0), TEXT_ALIGN_CENTER)
	draw.DrawText(WarTimer.Config.Phases[WarTimer.Phase].name, "Trebuchet18", scrwh, 60, Color(255, 0, 0), TEXT_ALIGN_CENTER)
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