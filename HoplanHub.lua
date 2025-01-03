local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "Hoplan HUB",
    Size = UDim2.fromOffset(600, 450),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

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


----------------------------------------------------------------------------------------------------- TAB COLLECT ALL PETS
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

----------------------------------------------------------------------------------------------------- TAB COLLECT ALL CARDS

local function teleportToCardsInWorkspace()
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj.Name == "Card" and obj:IsA("BasePart") then
            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 5, 0)
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

----------------------------------------------------------------------------------------------------- TAB LEGEND OF SPEED

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local function teleportToHoops()
    local hoopsFolder = workspace:FindFirstChild("Hoops")
    
    if not hoopsFolder then
        warn("Le dossier 'Hoops' n'existe pas dans le Workspace.")
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

----------------------------------------------------------------------------------------------------- TAB EAT BLOB SIMULATOR

Tab4:Slider{
    Name = "Vitesse",
    Min = 16,
    Max = 1000,
    Default = 16,
    Description = "Ajustez la vitesse de déplacement",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
}
----------------------------------------------------------------------------------------------------- TAB UNIVERSAL CHEATS

Tab5:Slider{
    Name = "Slider Example",
    Min = 1,
    Max = 100,
    Default = 50,
    Description = "This is an example slider.",
    Callback = function(value)
        print("Slider value:", value)
    end
}

Tab5:ColorPicker{
    Name = "Color Picker Example",
    StartingColor = Color3.fromRGB(255, 0, 0),
    Description = "Pick a color.",
    Callback = function(color)
        print("Color selected:", color)
    end
}

Tab5:Dropdown{
    Name = "Dropdown Example",
    StartingText = "Select an option",
    Items = {"Option 1", "Option 2", "Option 3", "Option 4"},
    Callback = function(selectedItem)
        print("Dropdown selected:", selectedItem)
    end
}

Tab5:Toggle{
    Name = "Toggle Example",
    StartingState = false,
    Description = "Toggle this option.",
    Callback = function(state)
        print("Toggle state:", state)
    end
}

Tab5:TextBox{
    Name = "Text Box Example",
    Default = "Enter some text",
    Description = "This is an example text box.",
    Callback = function(text)
        print("Text entered:", text)
    end
}

Tab5:Button{
    Name = "Button Example",
    Description = "Press this button.",
    Callback = function()
        print("Button pressed!")
    end
}

Tab5:Label{
    Name = "Label Example",
    Text = "This is an example label.",
    Description = "Static label text."
}

Tab5:Slider{
    Name = "Custom Slider",
    Min = 0,
    Max = 500,
    Default = 250,
    Description = "Customizable slider for testing.",
    Callback = function(value)
        print("Custom Slider value:", value)
    end
}

Tab5:TextBox{
    Name = "Name TextBox",
    Default = "Type your name here",
    Description = "Text box for name entry.",
    Callback = function(text)
        print("Name entered:", text)
    end
}

Tab5:Frame{
    Name = "Button Group",
    Layout = Enum.FillDirection.Horizontal,  -- Disposition horizontale
    Size = UDim2.fromScale(1, 0),  -- Taille du frame
    -- Vous pouvez ici ajouter des boutons
}

Tab5:Button{
    Name = "Button 1",
    Description = "First Button",
    Callback = function() print("Button 1 pressed") end,
    Parent = Tab5:Frame -- Ajouter au conteneur horizontal
}

Tab5:Button{
    Name = "Button 2",
    Description = "Second Button",
    Callback = function() print("Button 2 pressed") end,
    Parent = Tab5:Frame -- Ajouter au conteneur horizontal
}

Tab5:Button{
    Name = "Button 3",
    Description = "Third Button",
    Callback = function() print("Button 3 pressed") end,
    Parent = Tab5:Frame -- Ajouter au conteneur horizontal
}

local groupSelected = nil  -- Variable pour suivre le bouton sélectionné

Tab5:Button{
    Name = "Option 1",
    Description = "First Option",
    Callback = function()
        if groupSelected ~= "Option1" then
            print("Option 1 selected")
            groupSelected = "Option1"
        end
    end
}

Tab5:Button{
    Name = "Option 2",
    Description = "Second Option",
    Callback = function()
        if groupSelected ~= "Option2" then
            print("Option 2 selected")
            groupSelected = "Option2"
        end
    end
}

Tab5:Button{
    Name = "Option 3",
    Description = "Third Option",
    Callback = function()
        if groupSelected ~= "Option3" then
            print("Option 3 selected")
            groupSelected = "Option3"
        end
    end
}

Tab5:Frame{
    Name = "Group 1",
    Size = UDim2.fromScale(1, 0),
}

Tab5:Button{
    Name = "Group 1 Button 1",
    Description = "First button in Group 1",
    Callback = function() print("Group 1 Button 1 clicked") end,
    Parent = Tab5:Frame
}

Tab5:Button{
    Name = "Group 1 Button 2",
    Description = "Second button in Group 1",
    Callback = function() print("Group 1 Button 2 clicked") end,
    Parent = Tab5:Frame
}

Tab5:Frame{
    Name = "Group 2",
    Size = UDim2.fromScale(1, 0),
}

Tab5:Button{
    Name = "Group 2 Button 1",
    Description = "First button in Group 2",
    Callback = function() print("Group 2 Button 1 clicked") end,
    Parent = Tab5:Frame
}
