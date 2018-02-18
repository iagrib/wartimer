-- This file contains serverside code for the addon
-- This includes serverside functions associated with events,
-- which can also be defined directly in the config file.

-- Networking

util.AddNetworkString("WarTimer")

-- Send current phase and its end time to client
local function sendWarTime(plr, msg)
	net.Start("WarTimer")
	net.WriteUInt(WarTimer.Phase, 8)
	net.WriteUInt(WarTimer.PhaseEnd, 32)
	net.WriteBool(msg)
	if plr then net.Send(plr)
	else net.Broadcast() end
end

-- Respond to client's request to send data
local function sendWarTimeToClient(_, plr)
	sendWarTime(plr)
end

net.Receive("WarTimer", sendWarTimeToClient)



-- Phases

local log = WarTimer.Config.Log ~= ""

local function setPhase(phase)
	local pid = WarTimer.Config.Phases[phase] and phase or 1
	local dur = WarTimer.Config.Phases[pid].duration

	WarTimer.Phase = pid
	WarTimer.PhaseEnd = CurTime() + dur

	local function nextPhase()
		setPhase(pid + 1)
	end
	timer.Remove("WarTimer")
	timer.Create("WarTimer", dur, 1, nextPhase)

	sendWarTime(nil, true)

	if log then print((WarTimer.Config.Log:gsub("{name}", WarTimer.Config.Phases[pid].name))) end
end

if not WarTimer.Phase then setPhase(1) end