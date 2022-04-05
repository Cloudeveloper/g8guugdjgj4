-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/lib.lua"))() 
local venyx = library.new("SPTS", 5013109572)
local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

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
local page = venyx:addPage("Autofarm", 5012544693)
local section1 = page:addSection("Autofarm Fist Strength")
local section2 = page:addSection("Autofarm Body Toughness")
local section3 = page:addSection("Autofarm Psychic Power")
local section4 = page:addSection("Autofarm Movement Speed")
local section5 = page:addSection("Autofarm Jump Force")

section1:addButton("Autofarm Fist Strength", function()
	while true do
wait()
local A_1 = 
{
[1] = "+MS1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section1:addButton("Autofarm Fist Strength (Rock)", function()
	while true do
wait()
local A_1 = 
{
[1] = "+MS1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section1:addButton("Autofarm Fist Strength (Crystal)", function()
		while true do
wait()
local A_1 = 
{
[1] = "+FS3"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section2:addButton("Autofarm Body Toughness", function()
			while true do
wait()
local A_1 = 
{
[1] = "+BT1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section3:addButton("Autofarm Psychic Power", function()
		while true do
wait()
local A_1 = 
{
[1] = "+PP1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section3:addButton("Autofarm Psychic Power (10x)", function()
			while true do
wait()
local A_1 = 
{
[1] = "+PP2"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section4:addButton("Autofarm Movement Speed", function()
	while true do
wait()
local A_1 = 
{
[1] = "+MS1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section4:addButton("Autofarm Movement Speed (2x)", function()
	while true do
wait()
local A_1 = 
{
[1] = "+MS5"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end
end)

section5:addButton("Autofarm Jump Force", function()
	while true do
wait()
local A_1 = 
{
[1] = "+JF1"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

section5:addButton("Autofarm Jump Force (2x)", function()
	while true do
wait()
local A_1 = 
{
[1] = "+JF5"
}
local Event = game.ReplicatedStorage.RemoteEvent
Event:FireServer(A_1)
end 
end)

-- second page
local theme = venyx:addPage("Teleport", 5012543246)
local tools = theme:addSection("Teleports")

tools:addButton("Teleport to City Port", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(341.4534, 263.432434, -408.41333)
end)

tools:addButton("Teleport to Safe Zone", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459.3638, 248.993805, 892.707764)
end)

tools:addButton("Teleport to Tornado", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2301.5061, 1003.84021, 1069.53088)
end)

tools:addButton("Teleport to Ice Mountain", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1577.74976, 256.837982, 2232.5354)
end)

tools:addButton("Teleport to Volcano", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1971.78845, 749.285645, -1904.39258)
end)

tools:addButton("Teleport to Crystal", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2278.21411, 1941.96082, 1017.19659)
end)

tools:addButton("Teleport to Zen Island ", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2653.83228, 5570.65332, -428.37854 )
end) 

tools:addButton("Teleport to Red Star", function()
print(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
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

other:addKeybind("Toggle Keybind", Enum.KeyCode.RightAlt, function()
	venyx:toggle()
end, function()
end)

other:addButton("Delete Gui", function()
game.CoreGui["SPTS"]:Destroy()	
end)

-- load
venyx:SelectPage(venyx.pages[1], true)