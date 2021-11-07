-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/lib.lua"))() 
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/Cloudeveloper/g8guugdjgj4/main/invlocals.lua", true))()
TurnInvisible()
end)

section2:addButton("Turn Visible", function()
TurnVisible()
end)

section2:addButton("Grab Tool", function()
--[[
    Grab Tool made by Crokuran
    slightly edited by cloudeveloper
    
    Thanks for using!
    
    Inspired by Quenty's Physics Gun
]]
 
-- Player
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character
 
-- Services
local debris = game:GetService("Debris")
local uis = game:GetService("UserInputService")
local tween = game:GetService("TweenService")
 
-- Variables
local equipped = false
local enabled = false
local helddown = false
local showtrail = false
local lookingat = nil
local holding = nil
local distance = 0
local retracting = 0
local rotation = {X=0,Y=0,Z=0}
local anchored = {}
local spinning = {}
 
-- Default User Settings
if not _G.maincolor then _G.maincolor = BrickColor.new("Bright blue") end
if not _G.colors then _G.colors = {BrickColor.new("Bright blue"),BrickColor.new("Medium blue"),BrickColor.new("Teal")} end
if not _G.highlightcolors then _G.highlightcolors = {Anchored = Color3.new(1,0.3,0.3), Unanchored = Color3.new(1,0.5,0.3), Owned = Color3.new(0.3,0.6,1), OwnedJoint = Color3.new(0.5,0.8,1)} end
if not _G.scrollspeed then _G.scrollspeed = 1 end
if not _G.rotspeed then _G.rotspeed = 5 end
 
-- Tool
local tool = Instance.new("Tool",player.Backpack)
tool.Name = "Grab Tool"
tool.CanBeDropped = false
local handle = Instance.new("Part")
handle.BrickColor = _G.maincolor
handle.Material = Enum.Material.Neon
handle.Size = Vector3.new(0.8,0.8,0.8)
handle.Name = "Handle"
handle.Shape = Enum.PartType.Ball
handle.Parent = tool
 
-- FX Functions
local function EquipEffect()
    handle.Transparency = 1
    wait(.2)
    tween:Create(handle,TweenInfo.new(0.3,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{Transparency=0}):Play()
    for i=1,3 do
        for _=1,5 do
            local spark = Instance.new("Part")
            spark.Shape = Enum.PartType.Ball
            spark.Material = Enum.Material.Neon
            spark.BrickColor = _G.colors[Random.new():NextInteger(1,#_G.colors)]
            spark.Size = Vector3.new(0.1,0.1,0.1)
            spark.CFrame = handle.CFrame
            spark.Anchored = true
            spark.CanCollide = false
            spark.Parent = workspace.CurrentCamera
            tween:Create(spark,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=1,CFrame = handle.CFrame * CFrame.Angles(Random.new():NextNumber(-math.pi,math.pi),Random.new():NextNumber(-math.pi,math.pi),Random.new():NextNumber(-math.pi,math.pi)) * CFrame.new(0,0,Random.new():NextNumber(0.5,2))}):Play()
            debris:AddItem(spark,0.5)
        end
        wait(.05)
    end
end
 
-- Equipping
local selection = Instance.new("SelectionBox")
selection.Parent = workspace
tool.Equipped:Connect(function()
    coroutine.wrap(function() EquipEffect() end)()
    equipped = true
    repeat
        game:GetService("RunService").RenderStepped:Wait()
        if mouse.Target then
            lookingat = mouse.Target
        else
            lookingat = nil
        end
        if lookingat and not enabled and equipped and lookingat.Name ~= "Terrain" then
            selection.Adornee = lookingat
            if lookingat.Anchored then
                selection.Color3 = _G.highlightcolors.Anchored
            else
                if isnetworkowner(lookingat) then
                    selection.Color3 = _G.highlightcolors.Owned
                else
                    if lookingat.Parent:IsA("Accessory") then
                        local hatroot = lookingat.Parent.Parent:FindFirstChild("HumanoidRootPart")
                        if hatroot and isnetworkowner(hatroot) then
                            selection.Color3 = _G.highlightcolors.OwnedJoint
                        end
                    else
                        local function FindMain(part)
                            local mainpart
                            local average = {}
                            if part:IsA("BasePart") then
                                local welds = part:GetJoints()
                                if #welds > 0 then
                                    for i,v in pairs(welds) do
                                        if v.Part1 == part and v.Name~="AccessoryWeld" then
                                            average[v.Part0] = (average[v.Part0] and average[v.Part0]+1) or 1
                                        end
                                    end
                                    
                                    for i,v in pairs(average) do
                                        if not mainpart or (average[mainpart] and v > average[mainpart]) then
                                            mainpart = i
                                        end
                                    end
                                end
                            end
                            return mainpart
                        end
                        local rootpart = FindMain(lookingat)
                        if rootpart and not isnetworkowner(rootpart) then
                            local tries = 0
                            repeat
                                rootpart = FindMain(rootpart)
                                tries = tries + 1
                            until tries >= 40 or not rootpart or (rootpart and isnetworkowner(rootpart))
                        end
                        
                        if rootpart and isnetworkowner(rootpart) then
                            selection.Color3 = _G.highlightcolors.OwnedJoint
                        else
                            selection.Color3 = _G.highlightcolors.Unanchored
                        end
                    end
                end
            end
        else
            selection.Adornee = nil
        end
    until not equipped
end)
tool.Unequipped:Connect(function()
    enabled = false
    equipped = false
end)
 
-- Grabbing
local function Grab(object)
    holding = object
    
    local bodpos = Instance.new("BodyPosition")
    bodpos.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
    bodpos.P = 100000
    bodpos.Position = holding.Position
    bodpos.Parent = holding
    
    local folder = Instance.new("Folder",holding)
    folder.Name = "BeamFolder"
    
    local beam = Instance.new("Part")
    beam.Material = Enum.Material.Neon
    beam.Anchored = true
    beam.CanCollide = false
    beam.Transparency = 1
    beam.BrickColor = BrickColor.new("Bright blue")
    local mesh = Instance.new("SpecialMesh",beam)
    mesh.MeshType = Enum.MeshType.Cylinder
    beam.Parent = folder
    
    local trail = Instance.new("Part")
    trail.Material = Enum.Material.Neon
    trail.Anchored = true
    trail.CanCollide = false
    trail.Transparency = 1
    trail.BrickColor = BrickColor.new("Bright red")
    local meshT2 = Instance.new("SpecialMesh",trail)
    meshT2.MeshType = Enum.MeshType.Cylinder
    trail.Parent = folder
    
    tween:Create(beam,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Transparency=0}):Play()
    if showtrail then
        tween:Create(trail,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Transparency=0.8}):Play()
    end
    
    mouse.TargetFilter = holding
    
    distance = (character.HumanoidRootPart.Position - holding.Position).magnitude
    repeat
        game:GetService("RunService").RenderStepped:Wait()
        if holding then
            local width = (1-beam.Transparency)/5
            local upd = (handle.Position - holding.Position).magnitude
            local tmp = character.HumanoidRootPart.Position + (character.HumanoidRootPart.Position - mouse.Hit.p).unit * -distance
            beam.CFrame = CFrame.new(handle.Position,holding.Position) * CFrame.new(0,0,-upd/2) * CFrame.Angles(0,math.pi/2,0)
            beam.Size = Vector3.new(upd,width,width)
            trail.CFrame = CFrame.new(handle.Position,tmp) * CFrame.new(0,0,-(handle.Position-tmp).magnitude/2) * CFrame.Angles(0,math.pi/2,0)
            trail.Size = Vector3.new((handle.Position-tmp).magnitude,width,width)
            bodpos.Position = character.HumanoidRootPart.Position + (character.HumanoidRootPart.Position - mouse.Hit.p).unit * -distance
            distance = math.clamp(distance + (_G.scrollspeed*retracting),1,10000)
            holding.RotVelocity = Vector3.new(rotation.X,rotation.Y,rotation.Z)
            if showtrail and trail.Transparency == 1 then
                trail.Transparency = 0.8
            elseif not showtrail then
                trail.Transparency = 1
            end
        end
    until not enabled or not holding or (holding.Parent == nil)
    holding = nil
    offset = nil
    mouse.TargetFilter = nil
    bodpos:Destroy()
    beam:Destroy()
    trail:Destroy()
end
 
holdcon = mouse.Button1Down:Connect(function()
    if equipped then
        helddown = true
        repeat
            wait()
        until lookingat and not lookingat.Anchored or not helddown
        
        if lookingat and not lookingat.Anchored then
            enabled = true
            
            Grab(lookingat)
        end
    end
end)
endcon = mouse.Button1Up:Connect(function()
    enabled = false
    helddown = false
end)
 
-- Keybinds
inpstartcon = uis.InputBegan:Connect(function(inpute, gse)
    if equipped and not gse then
        local keycode = inpute.KeyCode
        if keycode == Enum.KeyCode.Q then
            retracting -= 1
        elseif keycode == Enum.KeyCode.E then
            retracting += 1
        elseif keycode == Enum.KeyCode.R then
            rotation.X = _G.rotspeed
        elseif keycode == Enum.KeyCode.T then
            rotation.Y = _G.rotspeed
        elseif keycode == Enum.KeyCode.Y then
            rotation.Z = _G.rotspeed
        elseif keycode == Enum.KeyCode.U then
            rotation.X *= -1
            rotation.Y *= -1
            rotation.Z *= -1
        elseif keycode == Enum.KeyCode.G then
            if holding then
                if not anchored[holding] then
                    local washolding = holding
                    enabled = false
                    
                    game:GetService("RunService").Heartbeat:Wait()
                    
                    local anch = Instance.new("BodyPosition")
                    anch.P = 1000000
                    anch.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    anch.Position = washolding.Position
                    local vel = Instance.new("BodyVelocity",washolding)
                    vel.Velocity = Vector3.new()
                    vel.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    local rot = Instance.new("BodyGyro",washolding)
                    rot.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                    rot.P = 1000000
                    rot.CFrame = washolding.CFrame
                    local box = Instance.new("SelectionBox",washolding)
                    box.Adornee = washolding
                    box.Color3 = Color3.new(1,0,1)
                    
                    anchored[washolding] = {anch,rot,vel,box}
                    anch.Parent = washolding
                else
                    local washolding = holding
                    enabled = false
                    
                    game:GetService("RunService").Heartbeat:Wait()
                    
                    for i,v in pairs(anchored[washolding]) do
                        v:Destroy()
                    end
                    
                    game:GetService("RunService").Heartbeat:Wait()
                    
                    enabled = true
                    anchored[washolding] = nil
                    Grab(washolding)
                end
            end
        elseif keycode == Enum.KeyCode.H then
            if holding then
                if not spinning[holding] then
                    local rotate = Instance.new("BodyAngularVelocity",holding)
                    rotate.AngularVelocity = Vector3.new(0,100,0)
                    rotate.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
                    spinning[holding] = rotate
                else
                    spinning[holding]:Destroy()
                    holding.RotVelocity = Vector3.new()
                    spinning[holding] = nil
                end
            end
        elseif keycode == Enum.KeyCode.F then
            local expl = Instance.new("Explosion")
            expl.BlastRadius = 20
            expl.BlastPressure = 0
            expl.DestroyJointRadiusPercent = 0
            expl.Position = mouse.Hit.p
            expl.Parent = workspace
            debris:AddItem(expl,1)
            
            expl.Hit:Connect(function(what)
                if not what:IsDescendantOf(character) and isnetworkowner(what) then
                    local force = Instance.new("BodyVelocity")
                    force.Velocity = (expl.Position-what.Position).unit * -200
                    force.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    force.Parent = what
                    debris:AddItem(force,0.1)
                end
            end)
        elseif keycode == Enum.KeyCode.X then
            if holding then
                local grabhum = holding.Parent:FindFirstChildOfClass("Humanoid")
                if holding.Parent:IsA("Accessory") then
                    grabhum = holding.Parent.Parent:FindFirstChildOfClass("Humanoid")
                end
                if grabhum and not game:GetService("Players"):GetPlayerFromCharacter(grabhum.Parent) then
                    grabhum.Health = 0
                end
            end
        elseif keycode == Enum.KeyCode.Z then
            if showtrail then
                showtrail = false
            else
                showtrail = true
            end
        end
    end
end)
 
inpendcon = uis.InputEnded:Connect(function(inpute)
    local keycode = inpute.KeyCode
    if keycode == Enum.KeyCode.Q then
        retracting = 0
    elseif keycode== Enum.KeyCode.E then
        retracting = 0
    elseif keycode == Enum.KeyCode.R then
        rotation.X = 0
    elseif keycode == Enum.KeyCode.T then
        rotation.Y = 0
    elseif keycode == Enum.KeyCode.Y then
        rotation.Z = 0
    end
end)
 
-- Cleanup
character.Humanoid.Died:Wait()
enabled = false
holding = nil
lookingat = nil
equipped = false
for i,v in pairs(anchored) do
    for o,b in pairs(v) do
        b:Destroy()
    end
end
for i,v in pairs(spinning) do
    v:Destroy()
end
selection:Destroy()
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
