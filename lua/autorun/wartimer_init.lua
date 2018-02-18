-- WarTimer by Ia_grib

WarTimer = WarTimer or {}

include("wartimer/config.lua")
if SERVER then
	include("wartimer/sv.lua")
	AddCSLuaFile("wartimer/config.lua")
	AddCSLuaFile("wartimer/cl.lua")
	AddCSLuaFile("wartimer/hud.lua")
else
	include("wartimer/cl.lua")
	include("wartimer/hud.lua")
end