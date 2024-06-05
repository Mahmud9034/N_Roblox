local hl=script.Parent

local function weldTogether(x,y)
	local W = Instance.new("Weld")
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end

for _,v in pairs(hl:children()) do
	if v~=script then
		v.Middle.Touched:connect(function(part)
			local chr=part.Parent
			local plr=game:service("Players"):GetPlayerFromCharacter(chr)
			if plr then
				if chr:findFirstChild("Head") then
					if chr:findFirstChild("Helmet") then
						chr:findFirstChild("Helmet"):destroy()
					end
					if plr.PlayerGui:findFirstChild("Gui") then
						plr.PlayerGui:findFirstChild("Gui"):destroy()
					end
					local helmet=v:clone()
					for _,m in pairs(helmet:children()) do
						weldTogether(m,helmet.Middle)
						m.Anchored=false
						m.CanCollide=false
					end
					helmet.Middle.Transparency=1
					local weld=Instance.new("Weld")
					weld.Part0=helmet.Middle
					weld.Part1=chr:findFirstChild("Head")
					weld.Parent=helmet.Middle
					helmet.Parent=chr
					local gui=script.Gui:clone()
					gui.Button.MouseButton1Down:connect(function()
						helmet:destroy()
						gui:destroy()
					end)
					gui.Parent=plr.PlayerGui
				end
			end
		end)
	end
end