


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local zombiePreFab = ServerStorage:WaitForChild("Zombie")
local bossPreFab = ServerStorage:WaitForChild("Boss")
local spawnPoints = workspace:WaitForChild("SpawnPoints"):GetChildren()

local currentWave = 0
local zombiesPerWave = 10
local zombiesRemaining = 0

local player = {
    hp = 100,
    coins = 0,
    kills = 0,
    speed = 10,
    damage = 10,
    jumph = 10
}

local function spawnZombie()
    local spawnPoint = spawnPoints[math.random(1, #spawnPoints)]
    local zombie = zombiePreFab:Clone()
     zombie.Parent = workspace

     zombie:SetPrimaryPartCFrame(spawnPoint.CFrame)
     zombiesRemaining = zombiesRemaining + 1

     zombie.Humanoid.Died:Connect(function()
        zombiesRemaining = zombiesRemaining - 1

        local killer = zombie.Humanoid:FindFirstChild("creator")
        if killer and killer.Value then
            local player = killer.Value
            player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 10 
        end 
        end)
    end

    local function spawnBoss() 
        local spawnPoint = spawnPoints[math.random(1, #spawnPoints)] 
        local boss = bossPrefab:Clone() 
        boss.Parent = workspace

        boss:SetPrimaryPartCFrame(spawnPoint.CFrame)
        zombiesRemaining = zombiesRemaining + 1 

        boss.Humanoid.Died:Connect(function()
            zombiesRemaining = zombiesRemaining - 1 
            local killer = boss.Humanoid:FindFirstChild("creator") 
            if killer and killer.Value then 
                local player = killer.Value
                player.leaderstats.Coins.Value = player.leaderstats.Coins.Value + 100 
            end 
            end) 
        end

        local function startWave()
            currentWave = currentWave + 1
            for i = 1, zombiesPerWave do
                spawnZombie()
            end 
            
            if currentWave % 20 == 0 then
                spawnBoss()
            end
        end

        game:GetService("RunService").Stepped:Connect(function()
            if zombiesRemaining == 0 then
                startWave()
            end
        end)

        Players.PlayerAdded:Connect(function(player)
            local leaderstats = Instance.new("Folder")
            leaderstats.Name = "leaderstats"
            leaderstats.Parent = player

            local coins = Instance.new("IntValue")
            coins.Name = "Coins"
            coins.Value = 0
            coins.Parent = leaderstats 
        end)


-- Zombie Script
local humanoid = script.Parent:WaitForChild("Humanoid") 
local target = nil
while true do wait(1)
    if target == nil or target.Parent == nil then
        target = game.Players:GetPlayers()[math.random(1, #game.Players)].Character 
    end
    humanoid:MoveTo(target.PrimaryPart.Position) 
end

-- Boss Script
local humanoid = script.Parent:WaitForChild("Humanoid") 
local target = nil 

while true do 
    wait(1)
    if target == nil or target.Parent == nil then
        target = game.Players:GetPlayers()[math.random(1, #game.Players)].Character 
    end
    humanoid:MoveTo(target.PrimaryPart.Position)
    if math.random(1, 5) == 1 then
        -- Boss special ability
        local fireball = Instance.new("Part") 
        fireball.Size = Vector3.new(2, 2, 2)
        fireball.Position = script.Parent.PrimaryPart.Position
        fireball.Velocity = (target.PrimaryPart.Position - fireball.Position).unit * 50
        fireball.Parent = workspace 

        fireball.Touched:Connect(function(hit)
            if hit.Parent:FindFirstChild("Humanoid") then 
                hit.Parent.Humanoid:TakeDamage(50)
                fireball:Destroy() 
            end 
        end) 
    end 
end

--Upgrade Script
local player = game.Players.LocalPlayer
local coins = player:WaitForChild("leaderstats"):WaitForChild("Coins") 
local upgradeButtons = { attackButton = script.Parent:WaitForChild("AttackUpgradeButton"), speedButton = script.Parent:WaitForChild("SpeedUpgradeButton"), } 

upgradeButtons.attackButton.MouseButton1Click:Connect(function()
    if coins.Value >= 50 then 
        coins.Value = coins.Value - 50
        player.Character.Humanoid.WalkSpeed = player.Character.Humanoid.WalkSpeed + 1 
    end 
end) 

upgradeButtons.speedButton.MouseButton1Click:Connect(function()
    if coins.Value >= 100 then 
        coins.Value = coins.Value - 100
        player.Character.Humanoid.MaxHealth = player.Character.Humanoid.MaxHealth + 10
        
        player.Character.Humanoid.Health = player.Character.Humanoid.MaxHealth
     end
     end)