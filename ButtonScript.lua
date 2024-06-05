local tweenService = game:GetService("TweenService")
local tweenInfoButtons = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

for i, v in pairs(script.Parent:GetChildren()) do
	if v:IsA("Frame") then
		v.MouseEnter:Connect(function()
			tweenService:Create(v, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(32, 255, 28)}):Play()
				
		end)
		v.MouseLeave:Connect(function()
			tweenService:Create(v, tweenInfoButtons, {BackgroundColor3 = Color3.fromRGB(76, 186, 69)}):Play()
				
		end)
	end
end

--Button Script

local tweenInfoPopups = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Popup = {
	
	Setting = "Settings",
	Credits = "Credits"
}

for buttonName, frameName in pairs(Popup) do 
	local button = script.Parent:FindFirstChild(buttonName)
	local popupframe = script.Parent.Parent.Popups:FindFirstChild(frameName)
	
	button:WaitForChild("TextButton").MouseButton1Click:Connect(function()
		for i, v in pairs(script.Parent:GetDescendants()) do
			if v:IsA("TextButton") then
				v.Visible = false
				
			end
		end
		
		tweenService:Create(script.Parent, tweenInfoPopups, {Position = UDim2.new(0.5,0,1.25,0)}):Play()
		tweenService:Create(script.Parent.Parent.Title, tweenInfoPopups, {Position = UDim2.new(0.5,0,1.25,0)}):Play()

		for i, x in pairs(script.Parent.Parent.Popups:GetChildren()) do
			if x IsA("Frame") then
				x.Visible = false
				x.Position = UDim2.new(0.5,0,1.5,0)
			end
		end
		
		popupframe.Visible = true
		tweenService:Create(popupframe, tweenInfoPopups, {Position = UDim2.new(.5,0,.5,0)}):Play()
	end)
end
--{0.5, 0},{0.719, 0} Button Position
--{0.5, 0},{0.297, 0} Title Position

--Play Script 

script.Parent.Play.TextButton.MouseButton1Click:Connect(function()
	script.Enabled = false 
	
	for i, v in pairs(script.Parent:GetDescendants()) do 
		if v:IsA("TextButton") then
			v.Visible = false
		end
	end
	tweenService:Create(script.Parent, tweenInfoPopups, {Position = UDim2.new(0.5,0,1.25,0)}):Play()
	tweenService:Create(script.Parent.Parent.Title, tweenInfoPopups, {Position = UDim2.new(0.5,0,-1.25,0)}):Play()

	tweenService:Create(script.Parent, tweenInfoPopups, {Position = UDim2.new(0,0,0.5,0)}):Play()

	wait(1)
	
	script.Parent.Parent.Parent.CameraScript.Enabled = false 
	game.Workspace.Camera.CameraType = Enum.CameraType.Custom
	
	tweenService:Create(script.Parent.Parent.Parent.Transition, tweenInfoPopups, {Position = UDim2.new(-1,0,0.5,0)}):Play()
	
	wait(1)
	script.Parent.Parent.Parent:Destroy()

end)
