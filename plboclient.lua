-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/lib"))()
local venyx = library.new("Pablo Client", 5013109572)

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

section1:addSlider("WalkSpeed", 16, 16, 200, function()
player.Character.Humanoid.WalkSpeed = value
end)
section1:addSlider("JumpPower", 16, 16, 200, function()
player.Character.Humanoid.JumpPower = value
end)

section2:addButton("Turn Invisible", function()
loadstring(game:HttpGet(""))
TurnInvisible()
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

section2:addKeybind("Toggle Keybind", Enum.KeyCode.Rshift, function()
	venyx:toggle()
end, function()
end)

-- load
venyx:SelectPage(venyx.pages[1], true)
