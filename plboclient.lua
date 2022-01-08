-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/lib.lua"))() 
local venyx = library.new("Pablo Client", 5013109572)
local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid

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
local page = venyx:addPage("Misc", 5012544693)
local section1 = page:addSection("Section 1")
local section2 = page:addSection("Section 2")
local section3 = page:addSection("Tools")

section1:addSlider("WalkSpeed", 16, 16, 200, function(value)
print(value)
Humanoid.WalkSpeed = value
end)
section1:addSlider("JumpPower", 50, 50, 200, function(value)
print(value)
Humanoid.JumpPower = value
end)

section2:addButton("Turn Invisible", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/invlocals.lua", true))()
TurnInvisible()
end)

section2:addButton("Turn Visible", function()
TurnVisible()
end)

section2:addButton("Grab Tool", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/grabtool.lua", true))()
end)

section3:addButton("Fire All Click Detectors", function()
if fireclickdetector then
		for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v)
			end
		end
	else
end
end)

-- second page
local theme = venyx:addPage("Settings", 5012544693)
local colors = theme:addSection("Colours")
local other = theme:addSection("Other")

for theme, color in pairs(themes) do
	colors:addColorPicker(theme, color, function(color3)
		venyx:setTheme(theme, color3)
	end)
end

other:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function()
	venyx:toggle()
end, function()
end)

-- load
venyx:SelectPage(venyx.pages[1], true)
