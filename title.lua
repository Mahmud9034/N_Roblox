local Music = game.Workspace.Music
local play = false

script.Parent.MouseButton1Click:Connect(function()
	if play then
		Music.Volume = 0.2                --volume from the music when it's on
		play = false
		script.Parent.Text = "Mute music" else  
		Music.Volume = 0
		play = true         
		script.Parent.Text = "Play music"
	end
end)
