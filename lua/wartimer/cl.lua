-- Clientside code

local function updatePhase()
	WarTimer.Phase = net.ReadUInt(8)
	WarTimer.PhaseEnd = net.ReadUInt(32)

	local msg = WarTimer.Config.Phases[WarTimer.Phase].message
	if net.ReadBool() and msg then chat.AddText(WarTimer.Config.ChatMsgColor, msg) end
end
net.Receive("WarTimer", updatePhase)

local function requestInfo()
	net.Start("WarTimer")
	net.SendToServer()
end
hook.Add("InitPostEntity", "WarTimer_RequestInfo", requestInfo)



local enableInfoCommand = WarTimer.Config.InfoChatCmd ~= ""
local infoCmd = "^[!/]"..WarTimer.Config.InfoChatCmd:lower().."$"

local function info(plr, msg)
	if msg:lower():match(infoCmd) then
		if plr == LocalPlayer() then
			local time = CurTime()
			chat.AddText(WarTimer.Config.ChatMsgColor, WarTimer.Config.InfoChatResponse:gsub("{current}", WarTimer.Config.Phases[WarTimer.Phase].name):gsub("{next}", WarTimer.Config.Phases[(WarTimer.Phase < #WarTimer.Config.Phases and WarTimer.Phase + 1 or 1)].name):gsub("{time}", string.ToMinutesSeconds((WarTimer.PhaseEnd or time) - time)))
		end
		return true
	end
end
if enableInfoCommand then hook.Add("OnPlayerChat", "WarTimer_InfoChadCmd", info) end