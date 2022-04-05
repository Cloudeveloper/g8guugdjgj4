-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("SS", 5013109572)

-- themes
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page
local page = venyx:addPage("LocalPlayer", 5012544693)
local section1 = page:addSection("Section 1")
local section2 = page:addSection("Section 2")


local teleport = venyx:addPage("Teleport", 5012543246)
local planets = teleport:addSection("Planets")

planets:addButton("Teleport to Earth", function()
game:GetService("TeleportService"):Teleport(5000143962)
end)

planets:addButton("Teleport to ISS", function()
game:GetService("TeleportService"):Teleport(5977563976)
end)

planets:addButton("Teleport to Moon", function()
game:GetService("TeleportService"):Teleport(5534753074)
end)

planets:addButton("Teleport to Mars", function()
game:GetService("TeleportService"):Teleport(6119982580)
end)

planets:addButton("Teleport to Ceres", function()
game:GetService("TeleportService"):Teleport(6669650377)
end)

-- third page
local Settings = venyx:addPage("Settings", 5012544693)
local colors = Settings:addSection("Colors")
local other = Settings:addSection("Other")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
	colors:addColorPicker(theme, color, function(color3)
		venyx:setTheme(theme, color3)
	end)
end

other:addKeybind("Toggle Keybind", Enum.KeyCode.RightAlt, function()
	venyx:toggle()
end, function()
end)

other:addButton("Delete Gui", function()
game.CoreGui["SS"]:Destroy()	
end)

-- load
venyx:SelectPage(venyx.pages[1], true)