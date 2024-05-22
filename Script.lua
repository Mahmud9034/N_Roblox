

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

