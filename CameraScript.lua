local plr = game:GetService("Players").LocalPlayer
local Character = plr.Character or plr.CharacterAdded:Wait()
local CameraInst = workspace.Camera 

local CameraPart = workspace:WaitForChild("MenuFolder"):WaitForChild("MenuCamera"):WaitForChild("MenuCameraPart").CFrame

repeat wait()
	CameraInst.CameraType = Enum.CameraType.Scriptable
until CameraInst.CameraType == Enum.CameraType.Scriptable
CameraInst.CFrame = CameraPart
