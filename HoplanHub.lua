local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "Hoplan HUB",
    Size = UDim2.fromOffset(600, 450),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

local Tab = GUI:Tab{
    Name = "Collect All Pets!",
    Icon = "rbxassetid://95664101388537"
}

local Tab2 = GUI:Tab{
    Name = "Collect all Cards",
    Icon = "rbxassetid://103403820212044"

local LegendOfSpeedTab = GUI:Tab{
    Name = "Legend of Speed",
    Icon = "rbxassetid://103403820212044"
}

local isCollecting = false 

local function teleportToAvailableDrops()
    local dropsFolder = workspace:FindFirstChild("Drops")
    
    if dropsFolder then
        for _, obj in pairs(dropsFolder:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent and obj.Parent.Parent then
                local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local objPosition = obj.Position
                local distance = (playerPosition - objPosition).Magnitude
                if distance < 100 then 
                    game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
                    wait(0.1)
                end
            end
        end
    else
        print("Le dossier 'Drops' n'existe pas dans le Workspace.")
    end
end

Tab:Toggle{
    Name = "Auto Collect Drops",
    StartingState = false,
    Description = "auto collect the closest gold drops",
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
    
    if hiddenEggsFolder then
        for _, obj in pairs(hiddenEggsFolder:GetDescendants()) do
            if obj:IsA("BasePart") then
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
                wait(0.2)
            end
        end
    else
        print("Le dossier 'HiddenEggs' n'existe pas dans le Workspace.")
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
    
    if areasFolder then
        local area = areasFolder:FindFirstChild(areaName)
        
        if area and area:IsA("BasePart") then
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
            print("Téléportation vers " .. areaName .. " réussie.")
        else
            print("L'area " .. areaName .. " n'est pas une brique valide.")
        end
    else
        print("Le dossier 'Areas' n'existe pas dans le Workspace.")
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

local function teleportToCardsInWorkspace()
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Card" and obj:IsA("BasePart") then
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
                print("Téléporté à une carte : " .. obj:GetFullName())
                wait(0.2)
            else
                warn("HumanoidRootPart introuvable pour le personnage.")
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

local isTeleportingToCoins = false

local function teleportToCoinsInWorkspace() 
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Coin" and obj:IsA("BasePart") then 
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                wait(0.1)
            else
                warn("HumanoidRootPart introuvable pour le personnage.")
            end
        end
    end
end

Tab2:Toggle{
    Name = "Auto Collect Coins",
    StartingState = false,
    Description = "Automatically collect all coins in the workspace",
    Callback = function(state)
        isTeleportingToCoins = state

        if isTeleportingToCoins then
            while isTeleportingToCoins do
                teleportToCoinsInWorkspace()
                wait(0.2)
            end
        end
    end
}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local function teleportToHoops()
    local hoopsFolder = workspace:FindFirstChild("Hoops")
    if hoopsFolder then
        for _, obj in ipairs(hoopsFolder:GetChildren()) do
            if obj:IsA("Model") and obj.PrimaryPart then
                HumanoidRootPart.CFrame = obj.PrimaryPart.CFrame
                print("Téléporté à Hoop : " .. obj:GetFullName())
                wait(0.1)
            end
        end
    else
        warn("Le dossier 'Hoops' n'existe pas dans le Workspace.")
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
                    print("Téléporté à Orb : " .. obj:GetFullName())
                    wait(0.1)
                end
            end
        else
            warn("Le dossier 'City' n'existe pas dans 'orbFolder' dans le Workspace.")
        end
    else
        warn("Le dossier 'orbFolder' n'existe pas dans le Workspace.")
    end
end

local isTeleportingHoops = false
local isTeleportingOrbs = false

LegendOfSpeedTab:Toggle{
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
        else
            print("Téléportation automatique vers les Hoops désactivée.")
        end
    end
}

LegendOfSpeedTab:Toggle{
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
        else
            print("Téléportation automatique vers les Orbs désactivée.")
        end
    end
}
