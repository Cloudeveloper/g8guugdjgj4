-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/lib.lua"))() 
local venyx = library.new("Developer Tools", 5013109572)
local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid
function sound()
	
click:play()
end

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
local page = venyx:addPage("Local", 5012544693)
local section1 = page:addSection("Player")
local section2 = page:addSection("Section 2")

section1:addSlider("WalkSpeed", 16, 16, 200, function(value)
print(value)
Humanoid.WalkSpeed = value
end)
section1:addSlider("JumpPower", 50, 50, 200, function(value)
print(value)
Humanoid.JumpPower = value
end)

section1:addButton("Turn Invisible", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/invlocals.lua", true))()
TurnInvisible()
venyx:Notify("DevTools", "You are now Invisible")
end)

section1:addButton("Turn Visible", function()
TurnVisible()
venyx:Notify("DevTools", "You are now Visible")
end)

section2:addButton("Grab Tool", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/grabtool.lua", true))()
venyx:Notify("DevTools", "Grab Tool Given")
end)


-- second page
local theme = venyx:addPage("Misc", 5012543246)
local tools = theme:addSection("Tools")

tools:addButton("Fire All Click Detectors", function()
if fireclickdetector then
		for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v)
			end
		end
	else
end
venyx:Notify("DevTools", "Fired All Click Detectors")
end)

tools:addButton("Fire All Proximity Prompts", function()
if fireproximityprompt then
		for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				fireproximityprompt(v)
			end
		end
	else
end
venyx:Notify("DevTools", "Fired All Proximity Prompts")
end)

tools:addButton("Get CFrame", function()
print(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
venyx:Notify("DevTools", "Press F9 To Find CFrame")
end)


-- third page
local FX = venyx:addPage("Composition", 5012544092)
local gfx = FX:addSection("Composition Effects")
local gfxDel = FX:addSection("Remove Composition Effects")

gfx:addButton("Depth Of Field Effect", function()
  DoF = Instance.new("DepthOfFieldEffect")
  DoF.Name = "DoF_Dev"
  DoF.Enabled = true
  DoF.Parent = game.Lighting
  DoF.FarIntensity = 0.2
  DoF.FocusDistance = 0
  DoF.InFocusRadius = 10
  DoF.NearIntensity = 0.75
venyx:Notify("DevTools", "Added Depth Of Field Effect")
end)

gfx:addButton("GodRays Effect", function()
  GR = Instance.new("SunRaysEffect")
  GR.Name = "GodRays_Dev"
  GR.Enabled = true
  GR.Parent = game.Lighting
  GR.Intensity = 0.1
  GR.Spread = 0.5
venyx:Notify("DevTools", "Added GodRays Effect")
end)

gfx:addButton("Realistic Water", function()
  local Ter = game.Workspace.Terrain
  Ter.WaterColor = Color3.new(0.247059, 0.372549, 0.372549)
  Ter.WaterReflectance = 1
  Ter.WaterTransparency = 0.9
venyx:Notify("DevTools", "Added Realistic Water")
end)

gfx:addButton("Atmosphere Effect", function()
  Atmo = Instance.new("Atmosphere")
  Atmo.Name = "Atmo_Dev"
  Atmo.Parent = game.Lighting
  Atmo.Density = 0.3
  Atmo.Offset = 0.25
  Atmo.Color = Color3.new(0.780392, 0.780392, 0.780392)
  Atmo.Decay = Color3.new(0.415686, 0.439216, 0.490196)
  Atmo.Glare = 0
  Atmo.Haze = 0
venyx:Notify("DevTools", "Added Atmosphere Effect")
end)

gfx:addButton("Bloom Effect", function()
  Bloom = Instance.new("BloomEffect")
  Bloom.Name = "Bloom_Dev"
  Bloom.Enabled = true
  Bloom.Parent = game.Lighting
  Bloom.Intensity = 1
  Bloom.Size = 24
  Bloom.Threshold = 2
venyx:Notify("DevTools", "Added Bloom Effect")
end)

gfxDel:addButton("Remove Compositions", function()
game.Lighting.Bloom_Dev:Destroy()
game.Lighting.DoF_Dev:Destroy()
game.Lighting.Atmo_Dev:Destroy()
game.Lighting.Bloom_Dev:Destroy()
venyx:Notify("DevTools", "Removed All Inserted Composition Effects")
end)


-- fourth page
local theme = venyx:addPage("Settings", 5012544372)
local colors = theme:addSection("Colours")
local other = theme:addSection("Other")

for theme, color in pairs(themes) do
	colors:addColorPicker(theme, color, function(color3)
		venyx:setTheme(theme, color3)
	end)
end

other:addKeybind("Toggle Keybind", Enum.KeyCode.RightAlt, function()
	venyx:toggle()
end, function()
venyx:Notify("DevTools", "Keybind Changed")
end)

other:addButton("Delete Gui", function()
game.CoreGui["Developer Tools"]:Destroy()	
end)
-- load
venyx:SelectPage(venyx.pages[1], true)
