-- Loading the Mercury library
local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

-- Creating the GUI
local GUI = Mercury:Create{
    Name = "Hoplan HUB",
    Size = UDim2.fromOffset(600, 450),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local gui = Library:create{
    Theme = Library.Themes.Serika

GUI:Credit{
	Name = "Hoplan",
	Description = "Made the HUB",
	V3rm = "discord.gg/senritsu",
	Discord = "Hoplan_"
}

-- Tabs creation
local Tab = GUI:Tab{
    Name = "Collect All Pets!",
    Icon = "rbxassetid://8982623704"
}

local Tab2 = GUI:Tab{
    Name = "Collect all Cards",
    Icon = "rbxassetid://8982623704"
}

local Tab3 = GUI:Tab{
    Name = "Legend of Speed",
    Icon = "rbxassetid://10491133376"
}

local Tab4 = GUI:Tab{
    Name = "Eat Blob Simu",
    Icon = "rbxassetid://8982623704"
}

local Tab5 = GUI:Tab{
    Name = "Universal Cheats",
    Icon = "rbxassetid://11818627075"
}

-----------------------------------------------------------------------------------------------------
-- TAB COLLECT ALL PETS
local isCollecting = false

local function teleportToAvailableDrops()
    local dropsFolder = workspace:FindFirstChild("Drops")
    if not dropsFolder then
        print("Drops folder not found in workspace!")
        return
    end

    for _, obj in pairs(dropsFolder:GetDescendants()) do
        if obj:IsA("BasePart") then
            local playerPosition = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if playerPosition then
                local objPosition = obj.Position
                local distance = (playerPosition.Position - objPosition).Magnitude
                if distance < 100 then 
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
                    wait(0.1)
                end
            else
                print("HumanoidRootPart not found!")
            end
        end
    end
end

Tab:Toggle{
    Name = "Auto Collect Drops",
    StartingState = false,
    Description = "Auto collect the closest gold drops",
    Callback = function(state)
        isCollecting = state
        
        if isCollecting then
            while isCollecting do
                teleportToAvailableDrops()
                wait(0.1)
            end
        end
    end
}

local isTeleportingToHiddenEggs = false

local function teleportToHiddenEggs()
    local hiddenEggsFolder = workspace:FindFirstChild("HiddenEggs")
    if not hiddenEggsFolder then
        print("HiddenEggs folder not found in workspace!")
        return
    end

    for _, obj in pairs(hiddenEggsFolder:GetDescendants()) do
        if obj:IsA("BasePart") then
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
            wait(0.2)
        end
    end
end

Tab:Toggle{
    Name = "Auto TP HiddenEggs",
    StartingState = false,
    Description = "⚠️Unlock all areas BEFORE otherwise the eggs will not open⚠️",
    Callback = function(state)
        isTeleportingToHiddenEggs = state
        
        if isTeleportingToHiddenEggs then
            while isTeleportingToHiddenEggs do
                teleportToHiddenEggs()
                wait(0.2)  
            end
        end
    end
}

local function teleportToArea(areaName)
    local areasFolder = workspace:FindFirstChild("Areas")
    if not areasFolder then
        print("Areas folder not found in workspace!")
        return
    end
    
    local area = areasFolder:FindFirstChild(areaName)
    if not area then
        print("Area not found: " .. areaName)
        return
    end
    
    if area:IsA("BasePart") then
        local targetPosition = area.CFrame.Position
        targetPosition = Vector3.new(targetPosition.X, targetPosition.Y + 5, targetPosition.Z)
        local ray = workspace:Raycast(targetPosition, Vector3.new(0, -10, 0))
        if ray then
            targetPosition = ray.Position + Vector3.new(0, 2, 0)
        end
        local character = game.Players.LocalPlayer.Character
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = true
        end
        character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
        wait(0.2)
        if humanoid then
            humanoid.PlatformStand = false
        end
    end
end

Tab:Dropdown{
    Name = "Area TP",
    StartingText = "Select Area",
    Description = "TP to selected area",
    Items = {
        "Area1", "Area2", "Area3", "Area4", "Area5", 
        "Area6", "Area7", "Area8", "Area9", "Area10"
    },
    Callback = function(selectedItem)
        teleportToArea(selectedItem)
    end
}

-----------------------------------------------------------------------------------------------------
-- TAB COLLECT ALL CARDS
local function teleportToCardsInWorkspace()
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Card" and obj:IsA("BasePart") then
            local character = game.Players.LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                wait(0.2)
            else
                print("HumanoidRootPart not found for character!")
            end
        end
    end
end

local isTeleportingToCards = false

Tab2:Toggle{
    Name = "Auto Teleport to Cards",
    StartingState = false,
    Description = "Teleport to all Cards in the Workspace",
    Callback = function(state)
        isTeleportingToCards = state

        if isTeleportingToCards then
            while isTeleportingToCards do
                teleportToCardsInWorkspace()
                wait(1)
            end
        end
    end
}

-----------------------------------------------------------------------------------------------------
-- TAB LEGEND OF SPEED
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local function teleportToHoops()
    local hoopsFolder = workspace:FindFirstChild("Hoops")
    if not hoopsFolder then
        print("Hoops folder not found in workspace!")
        return
    end
    
    for _, obj in ipairs(hoopsFolder:GetChildren()) do
        if obj:IsA("MeshPart") and obj.Name == "Hoop" then
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
            wait(0.1)
        end
    end
end

local function teleportToOrbs()
    local orbFolder = workspace:FindFirstChild("orbFolder")
    if orbFolder then
        local cityFolder = orbFolder:FindFirstChild("City")
        if cityFolder then
            for _, obj in ipairs(cityFolder:GetChildren()) do
                if obj:IsA("Model") and obj.PrimaryPart then
                    HumanoidRootPart.CFrame = obj.PrimaryPart.CFrame
                    wait(0.1)
                end
            end
        end
    end
end

local isTeleportingHoops = false
local isTeleportingOrbs = false

Tab3:Toggle{
    Name = "Auto Teleport Hoops",
    StartingState = false,
    Description = "Auto Teleport inside Hoops",
    Callback = function(state)
        isTeleportingHoops = state
        if isTeleportingHoops then
            while isTeleportingHoops do
                teleportToHoops()
                wait(0.1)
            end
        end
    end
}

Tab3:Toggle{
    Name = "Auto Teleport Orbs",
    StartingState = false,
    Description = "Auto Teleport to Orbs",
    Callback = function(state)
        isTeleportingOrbs = state
        if isTeleportingOrbs then
            while isTeleportingOrbs do
                teleportToOrbs()
                wait(0.1)
            end
        end
    end
}

-----------------------------------------------------------------------------------------------------
-- TAB EAT BLOB SIMULATOR
Tab4:Slider{
    Name = "Speed",
    Min = 16,
    Max = 1000,
    Default = 16,
    Description = "Adjust the movement speed",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
}

-----------------------------------------------------------------------------------------------------
-- TAB UNIVERSAL CHEATS
