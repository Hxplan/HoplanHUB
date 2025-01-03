local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

local GUI = Mercury:Create{
    Name = "Hoplan HUB",
    Size = UDim2.fromOffset(600, 450),
    Theme = Mercury.Themes.Dark,
    Link = "https://github.com/deeeity/mercury-lib"
}

-- Création des Tabs
local Tab = GUI:Tab{
    Name = "Collect All Pets!",
    Icon = "rbxassetid://95664101388537"
}

local Tab2 = GUI:Tab{
    Name = "Collect all Cards",
    Icon = "rbxassetid://103403820212044"
}

local Tab3 = GUI:Tab{
    Name = "Legend of Speed",
    Icon = "rbxassetid://103403820212044"
}

local Tab4 = GUI:Tab{
    Name = "Eat Blob Simu",
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
    
    if not hoopsFolder then
        warn("Le dossier 'Hoops' n'existe pas dans le Workspace.")
        return
    end
    for _, obj in ipairs(hoopsFolder:GetChildren()) do
        if obj:IsA("MeshPart") and obj.Name == "Hoop" then
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(obj.CFrame)
            print("Téléporté à Hoop (MeshPart) : " .. obj:GetFullName())
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
        else
            print("Téléportation automatique vers les Hoops désactivée.")
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
        else
            print("Téléportation automatique vers les Orbs désactivée.")
        end
    end
}

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

local ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 255, 255)  -- Couleur par défaut (blanc)
local ESPThickness = 2  -- Épaisseur par défaut du carré
local ESPFontSize = Enum.FontSize.Size14  -- Taille de police par défaut
local ShowName = true  -- Afficher le nom par défaut
local ShowDistance = true  -- Afficher la distance par défaut
local ShowSkeleton = false  -- Afficher le squelette par défaut

-- Fonction pour afficher l'ESP autour des joueurs
local function createESP(player)
    -- Vérifier si le joueur a un personnage
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local esp = Instance.new("BillboardGui")
        esp.Parent = player.Character
        esp.Adornee = hrp
        esp.Size = UDim2.new(0, 200, 0, 50)
        esp.StudsOffset = Vector3.new(0, 2, 0)
        
        -- Ajouter un cadre autour du joueur
        local frame = Instance.new("Frame")
        frame.Parent = esp
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BorderSizePixel = ESPThickness
        frame.BorderColor3 = ESPColor
        frame.BackgroundTransparency = 1  -- Rendre le fond transparent
        
        -- Afficher le nom du joueur
        if ShowName then
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Parent = esp
            nameLabel.Text = player.Name
            nameLabel.TextColor3 = ESPColor
            nameLabel.TextSize = 16
            nameLabel.Size = UDim2.new(1, 0, 1, 0)
            nameLabel.BackgroundTransparency = 1
            nameLabel.TextAlign = Enum.TextXAlignment.Center
            nameLabel.TextStrokeTransparency = 0.8
        end
        
        -- Afficher la distance du joueur
        if ShowDistance then
            local distLabel = Instance.new("TextLabel")
            distLabel.Parent = esp
            distLabel.Text = math.floor((hrp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m"
            distLabel.TextColor3 = ESPColor
            distLabel.TextSize = 14
            distLabel.Position = UDim2.new(0, 0, 1, 0)
            distLabel.BackgroundTransparency = 1
            distLabel.TextAlign = Enum.TextXAlignment.Center
            distLabel.TextStrokeTransparency = 0.8
        end
        
        -- Afficher le squelette du joueur
        if ShowSkeleton then
            for _, part in pairs(player.Character:GetChildren()) do
                if part:IsA("MeshPart") or part:IsA("Part") then
                    local skeletonPart = Instance.new("Part")
                    skeletonPart.Size = Vector3.new(0.2, 0.2, 0.2)
                    skeletonPart.Shape = Enum.PartType.Ball
                    skeletonPart.Position = part.Position
                    skeletonPart.Anchored = true
                    skeletonPart.CanCollide = false
                    skeletonPart.Color = ESPColor
                    skeletonPart.Parent = workspace
                end
            end
        end
    end
end

-- Fonction pour enlever l'ESP
local function removeESP(player)
    for _, v in pairs(player.Character:GetChildren()) do
        if v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
end

-- Fonction pour activer/désactiver l'ESP pour tous les joueurs
Tab5:Toggle{
    Name = "Enable ESP",
    StartingState = false,
    Description = "Activez l'ESP pour voir les joueurs avec des carrés, des noms et des distances.",
    Callback = function(state)
        ESPEnabled = state
        if ESPEnabled then
            -- Créer l'ESP pour chaque joueur
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    createESP(player)
                end
            end
            -- Écouter les nouveaux joueurs qui entrent dans le jeu
            game.Players.PlayerAdded:Connect(function(player)
                if player ~= game.Players.LocalPlayer then
                    createESP(player)
                end
            end)
            -- Écouter les joueurs qui quittent le jeu
            game.Players.PlayerRemoving:Connect(function(player)
                if player ~= game.Players.LocalPlayer then
                    removeESP(player)
                end
            end)
        else
            -- Retirer l'ESP pour tous les joueurs
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer then
                    removeESP(player)
                end
            end
        end
    end
}

-- Dropdown pour choisir la couleur de l'ESP
Tab5:ColorPicker{
    Name = "ESP Color",
    StartingColor = Color3.fromRGB(255, 255, 255),
    Description = "Sélectionnez la couleur de l'ESP.",
    Callback = function(color)
        ESPColor = color
    end
}

-- Slider pour ajuster l'épaisseur du carré de l'ESP
Tab5:Slider{
    Name = "ESP Border Thickness",
    Min = 1,
    Max = 10,
    Default = 2,
    Description = "Ajustez l'épaisseur du bord du carré ESP.",
    Callback = function(value)
        ESPThickness = value
    end
}

-- Toggle pour afficher le squelette des joueurs
Tab5:Toggle{
    Name = "Show Skeleton",
    StartingState = false,
    Description = "Afficher un squelette autour des joueurs.",
    Callback = function(state)
        ShowSkeleton = state
        -- Appliquer les modifications de squelette
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                removeESP(player)
                if ESPEnabled then
                    createESP(player)
                end
            end
        end
    end
}

-- Toggle pour afficher le nom du joueur
Tab5:Toggle{
    Name = "Show Name",
    StartingState = true,
    Description = "Afficher le nom des joueurs dans l'ESP.",
    Callback = function(state)
        ShowName = state
        -- Appliquer les modifications du nom
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                removeESP(player)
                if ESPEnabled then
                    createESP(player)
                end
            end
        end
    end
}

-- Toggle pour afficher la distance du joueur
Tab5:Toggle{
    Name = "Show Distance",
    StartingState = true,
    Description = "Afficher la distance entre vous et les joueurs.",
    Callback = function(state)
        ShowDistance = state
        -- Appliquer les modifications de la distance
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                removeESP(player)
                if ESPEnabled then
                    createESP(player)
                end
            end
        end
    end
}

-- Dropdown pour ajuster la taille de la police du texte ESP
Tab5:Dropdown{
    Name = "Text Font Size",
    StartingText = "Sélectionnez la taille de la police",
    Items = {"Size8", "Size12", "Size14", "Size18", "Size24", "Size36", "Size48"},
    Callback = function(size)
        ESPFontSize = Enum.FontSize[size]
        -- Appliquer les modifications de taille de police
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                removeESP(player)
                if ESPEnabled then
                    createESP(player)
                end
            end
        end
    end
}

