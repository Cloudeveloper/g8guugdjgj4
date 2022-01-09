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
end)

section1:addButton("Turn Visible", function()
TurnVisible()
end)

section2:addButton("Grab Tool", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/grabtool.lua", true))()
end)


-- second page
local theme = venyx:addPage("Misc", 5012543246)
local tools = theme:addSection("Tools")
local gfx = theme:addSection("Shaders")

tools:addButton("Fire All Click Detectors", function()
if fireclickdetector then
		for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v)
			end
		end
	else
end
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
end)

gfx:addButton("Fps Boost", function()
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
	workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
	workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		elseif v:IsA("Explosion") then
			v.BlastPressure = 1
			v.BlastRadius = 1
		end
	end
	for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
		if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
			v.Enabled = false
		end
	end
	workspace.DescendantAdded:Connect(function(child)
		coroutine.wrap(function()
			if child:IsA('ForceField') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Sparkles') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			elseif child:IsA('Smoke') or child:IsA('Fire') then
				game:GetService('RunService').Heartbeat:Wait()
				child:Destroy()
			end
		end)()
	end)	
end)

gfx:addButton("wait", function()
print("yes")
end)

-- third page
local theme = venyx:addPage("Settings", 5012544372)
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

other:addButton("Delete Gui", function()
game.CoreGui["Pablo Client"]:Destroy()	
end)
-- load
venyx:SelectPage(venyx.pages[1], true)
