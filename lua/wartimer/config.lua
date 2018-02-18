-- Config file
local c = WarTimer.Config or {}



-- Event phases, ordered and looped (when the last one ends, the cycle will restart)
-- name = Displayed name
-- duration = Duration in seconds
-- message (Optional) = Message that will be displayed in chat when the phase begins
c.Phases = {
	{
		name = "Pre-War",
		duration = 180
	},

	{
		name = "War in progress",
		duration = 180,
		message = "The war has started!"
	},

	{
		name = "Post-War",
		duration = 120
	}
}

-- This message will be logged to server console when a phase begins,
-- {name} will be replaced with its name. Set to "" to disable.
c.Log = "{name} has started"



-- Chat command to toggle on-screen timer display. Command prefix will be added automatically,
-- so if you type "cmd" here, the actual command in-game will be either "!cmd" or "/cmd".
-- Set to "" to disable.
c.ToggleChatCmd = "wartimer"

-- Chat message displayed when above command is used. Set to "" to disable.
c.ToggleChatResponse = "Toggled war timer display."



-- Chat command to display time left until next phase in chat.
-- Same as the command above, this should not include prefix and can be set to "" to disable.
c.InfoChatCmd = "timeleft"

-- Chat message displayed when above command is used.
-- {current} will be replaced with current phase name.
-- {next} will be replaced with upcoming phase name.
-- {time} will be replaced with time remaining.
c.InfoChatResponse = "{time} remaining until {next}"



-- Color for addon chat messages (both phase messages and above command responses)
-- RGB format: Color(Red, Green, Blue)
c.ChatMsgColor = Color(255, 177, 177)



-- End of config file
WarTimer.Config = c