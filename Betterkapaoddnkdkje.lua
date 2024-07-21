
 



local G2L = {};
local viewport = workspace.Camera.ViewportSize
local tween = game:GetService("TweenService")
local twinfo = TweenInfo.new
local blur = Instance.new("BlurEffect",game:GetService("Lighting"))
blur.Size = 0.1
local Highlight = Instance.new("Highlight", game.workspace)
Highlight.FillTransparency  = 2
Highlight.OutlineTransparency = 2
Highlight.FillColor = Color3.fromRGB(0, 0, 0)
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
G2L["1"] = Instance.new("ScreenGui", game.CoreGui);
G2L["1"]["Name"] = [[intro]];


G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
G2L["2"] = Instance.new("ImageLabel", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Image"] = [[rbxassetid://11963368259]];


G2L["2"]["Size"] = UDim2.new(0, 140, 0, 140);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[icon]];


G2L["2"]["BackgroundTransparency"] = 2;
G2L["2"]["ImageTransparency"] = 2;
G2L["2"]["Position"] = UDim2.fromOffset((viewport.X/2) - (G2L["2"].Size.X.Offset / 2), (viewport.Y/2) - (G2L["2"].Size.Y.Offset / 2));
wait(1)
Highlight.FillTransparency  = 2
Highlight.OutlineTransparency = 2
tween:Create(Highlight,twinfo(1),{FillTransparency = 0.50}):Play()
tween:Create(Highlight,twinfo(1),{OutlineTransparency = 0}):Play()
tween:Create(blur,twinfo(1),{Size = 25}):Play()
tween:Create(G2L["2"],twinfo(1),{ImageTransparency = 0}):Play()
wait(2)
tween:Create(G2L["2"],twinfo(1),{ImageTransparency = 2}):Play()
tween:Create(blur,twinfo(1),{Size = 0.1}):Play()
tween:Create(Highlight,twinfo(1),{FillTransparency = 2}):Play()
tween:Create(Highlight,twinfo(1),{OutlineTransparency = 2}):Play()
wait(2)
blur:Destroy()
Highlight:Destroy()
G2L["1"]:Destroy()





for _,v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "AtomicUi" or v.Name == "Abyss" or v.Name == "FlyGui" or v.Name  == "OpenButton" then
		v:Destroy()
	end
end

local FlingPlayer = function(s)
    local Targets = {s}
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local AllBool = false
    
    local GetPlayer = function(Name)
        Name = Name:lower()
        if Name == "all" or Name == "others" then
            AllBool = true
            return
        elseif Name == "random" then
            local GetPlayers = Players:GetPlayers()
            if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
            return GetPlayers[math.random(#GetPlayers)]
        elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
            for _,x in next, Players:GetPlayers() do
                if x ~= Player then
                    if x.Name:lower():match("^"..Name) then
                        return x;
                    elseif x.DisplayName:lower():match("^"..Name) then
                        return x;
                    end
                end
            end
        else
            return
        end
    end
        
    local Fling = function(TargetPlayer)
        local Character = Player.Character
        local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
        local RootPart = Humanoid and Humanoid.RootPart
    
        local TCharacter = TargetPlayer.Character
        local THumanoid
        local TRootPart
        local THead
        local Accessory
        local Handle
    
        if TCharacter:FindFirstChildOfClass("Humanoid") then
            THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
        end
        if THumanoid and THumanoid.RootPart then
            TRootPart = THumanoid.RootPart
        end
        if TCharacter:FindFirstChild("Head") then
            THead = TCharacter.Head
        end
        if TCharacter:FindFirstChildOfClass("Accessory") then
            Accessory = TCharacter:FindFirstChildOfClass("Accessory")
        end
        if Accessoy and Accessory:FindFirstChild("Handle") then
            Handle = Accessory.Handle
        end
    
        if Character and Humanoid and RootPart then
            if RootPart.Velocity.Magnitude < 50 then
                getgenv().OldPos = RootPart.CFrame
            end
            if THumanoid and THumanoid.Sit and not AllBool then
                return 
            end
            if THead then
                workspace.CurrentCamera.CameraSubject = THead
            elseif not THead and Handle then
                workspace.CurrentCamera.CameraSubject = Handle
            elseif THumanoid and TRootPart then
                workspace.CurrentCamera.CameraSubject = THumanoid
            end
            if not TCharacter:FindFirstChildWhichIsA("BasePart") then
                return
            end
            
            local FPos = function(BasePart, Pos, Ang)
                RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
                Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
                RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
                RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
            end
            
            local SFBasePart = function(BasePart)
                local TimeToWait = 2
                local Time = tick()
                local Angle = 0
    
                repeat
                    if RootPart and THumanoid then
                        if BasePart.Velocity.Magnitude < 50 then
                            Angle = Angle + 100
    
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
                            task.wait()
                        else
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
                            
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
                            task.wait()
    
                            FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                            task.wait()
                        end
                    else
                        break
                    end
                until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
            end
            
            workspace.FallenPartsDestroyHeight = 0/0
            
            local BV = Instance.new("BodyVelocity")
            BV.Name = "EpixVel"
            BV.Parent = RootPart
            BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
            BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            if TRootPart and THead then
                if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
                    SFBasePart(THead)
                else
                    SFBasePart(TRootPart)
                end
            elseif TRootPart and not THead then
                SFBasePart(TRootPart)
            elseif not TRootPart and THead then
                SFBasePart(THead)
            elseif not TRootPart and not THead and Accessory and Handle then
                SFBasePart(Handle)
            else
                return 
            end
            
            BV:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = Humanoid
            
            repeat
                RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
                Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
                Humanoid:ChangeState("GettingUp")
                table.foreach(Character:GetChildren(), function(_, x)
                    if x:IsA("BasePart") then
                        x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
                    end
                end)
                task.wait()
            until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        else
            return 
        end
    end
    
    getgenv().Welcome = true
    if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
    
    if AllBool then
        for _,x in next, Players:GetPlayers() do
			Fling(x)
		end
	end

    
    for _,x in next, Targets do
        if GetPlayer(x) and GetPlayer(x) ~= Player then
			local TPlayer = GetPlayer(x)
			if TPlayer then
				Fling(TPlayer)
			end
        end
    end
end

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport
local NotificationLibrary = {}
local Lib = {}
local speaker = game.Players.LocalPlayer
local chr = game.Players.LocalPlayer.Character
local hum = chr and chr:FindFirstChildWhichIsA("Humanoid") 
nowe = false
speeds = 1 
local Fly = Instance.new("ScreenGui")
local ImageButton = Instance.new("ImageButton")
local UICorner = Instance.new("UICorner")

--Properties:

Fly.Name = "FlyGui"
Fly.Parent = game.CoreGui
Fly.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

ImageButton.Parent = Fly
ImageButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Position = UDim2.new(0.929370999, 0, 0.510522664, 0)
ImageButton.Size = UDim2.new(0, 40, 0, 40)
ImageButton.Image = "rbxassetid://11419709766" --rbxassetid://11419719540
ImageButton.Visible = false
UICorner.Parent = ImageButton

ImageButton.MouseButton1Down:connect(function() 

	if nowe == true then
		nowe = false 
		ImageButton.Image = "rbxassetid://11419709766"
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
		else 
			nowe = true
			ImageButton.Image = "rbxassetid://11419719540"


			for i = 1, speeds do
				spawn(function() 
				
					local hb = game:GetService("RunService").Heartbeat
				
				
					tpwalking = true
					local chr = game.Players.LocalPlayer.Character
					local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
					while tpwalking and hb:Wait() and chr and hum and hum.Parent do
					if hum.MoveDirection.Magnitude > 0 then
						chr:TranslateBy(hum.MoveDirection)
					end
				end 
				
			end)
		end
		game.Players.LocalPlayer.Character.Animate.Disabled = true
		local Char = game.Players.LocalPlayer.Character
		local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController") 
				
		for i,v in next, Hum:GetPlayingAnimationTracks() do
			v:AdjustSpeed(0)
		end
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
		speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
		speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
	end
				



	if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then



		local plr = game.Players.LocalPlayer
		local torso = plr.Character.Torso
		local flying = true
		local deb = true
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local maxspeed = 50
		local speed = 0
		
		
		local bg = Instance.new("BodyGyro", torso)
		bg.P = 9e4
		bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		bg.cframe = torso.CFrame
		local bv = Instance.new("BodyVelocity", torso)
		bv.velocity = Vector3.new(0,0.1,0)
		bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
		if nowe == true then
			plr.Character.Humanoid.PlatformStand = true
		end
		while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
			game:GetService("RunService").RenderStepped:Wait() 

			if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
				speed = speed+.5+(speed/maxspeed)
				if speed > maxspeed then
					speed = maxspeed
					end
					elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
					speed = speed-1
					if speed < 0 then
						speed = 0
						end
						end
						if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
						lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
						elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
						bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
						else
							bv.velocity = Vector3.new(0,0,0)
						end
						--game.Players.LocalPlayer.Character.Animate.Disabled = true
						bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
					end
					ctrl = {f = 0, b = 0, l = 0, r = 0}
					lastctrl = {f = 0, b = 0, l = 0, r = 0}
					speed = 0
					bg:Destroy()
					bv:Destroy()
					plr.Character.Humanoid.PlatformStand = false
					game.Players.LocalPlayer.Character.Animate.Disabled = false
					tpwalking = false
				else
					local plr = game.Players.LocalPlayer
					local UpperTorso = plr.Character.UpperTorso
					local flying = true
					local deb = true
					local ctrl = {f = 0, b = 0, l = 0, r = 0}
					local lastctrl = {f = 0, b = 0, l = 0, r = 0}
					local maxspeed = 50
					local speed = 0
					

					local bg = Instance.new("BodyGyro", UpperTorso)
					bg.P = 9e4
					bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
					bg.cframe = UpperTorso.CFrame
					local bv = Instance.new("BodyVelocity", UpperTorso)
					bv.velocity = Vector3.new(0,0.1,0)
					bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
					if nowe == true then
						plr.Character.Humanoid.PlatformStand = true
					end
					while nowe == true or game:GetService("Players").LocalPlayer.Character.Humanoid.Health == 0 do
						wait() 

						if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
							speed = speed+.5+(speed/maxspeed)
							if speed > maxspeed then
								speed = maxspeed
							end
						elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
							speed = speed-1
							if speed < 0 then
								speed = 0
							end
						end
						if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
							lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
						elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
							bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
						else
							bv.velocity = Vector3.new(0,0,0)
						end 

						bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
					end
					ctrl = {f = 0, b = 0, l = 0, r = 0}
					lastctrl = {f = 0, b = 0, l = 0, r = 0}
					speed = 0
					bg:Destroy()
					bv:Destroy()
					plr.Character.Humanoid.PlatformStand = false
					game.Players.LocalPlayer.Character.Animate.Disabled = false
					tpwalking = false
				end
			end)

local AbyssGUI = Instance.new("ScreenGui"); AbyssGUI.Name = "Abyss"; AbyssGUI.Parent = game.CoreGui; AbyssGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

function NotificationLibrary:Notify(TitleText, Desc, Delay)
    local Notification = Instance.new("Frame")
	local Line = Instance.new("Frame")
	local Warning = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Description = Instance.new("TextLabel")

	Notification.Name = "Notification"
	Notification.Parent = AbyssGUI
	Notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Notification.BackgroundTransparency = 0.400
	Notification.BorderSizePixel = 0
	Notification.Position = UDim2.new(1, 5, 0, 75)
	Notification.Size = UDim2.new(0, 450, 0, 60)

	Line.Name = "Line"
	Line.Parent = Notification
	Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 0.938461304, 0)
	Line.Size = UDim2.new(0, 0, 0, 4)

	Warning.Name = "Warning"
	Warning.Parent = Notification
	Warning.BackgroundTransparency = 1.000
	Warning.Position = UDim2.new(0.0258302614, 0, 0.0897435844, 0)
	Warning.Size = UDim2.new(0, 44, 0, 49)
	Warning.Image = "rbxassetid://3944668821"
	Warning.ImageColor3 = Color3.fromRGB(255, 255, 255)
	Warning.ScaleType = Enum.ScaleType.Fit

	UICorner.CornerRadius = UDim.new(0, 20)
	UICorner.Parent = Warning

	Title.Name = "Title"
	Title.Parent = Notification
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.161, 0, 0.155, 0)
	Title.Size = UDim2.new(0, 205, 0, 15)
	Title.Text = TitleText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 12.000
	Title.TextStrokeTransparency = 2
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Description.Name = "Description"
	Description.Parent = Notification
	Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Description.BackgroundTransparency = 1.000
	Description.Position = UDim2.new(0.161, 0, 0.483, 0)
	Description.Size = UDim2.new(0, 205, 0, 18)
	Description.Text = Desc
	Description.TextColor3 = Color3.fromRGB(199, 199, 199)
	Description.TextSize = 12.000
	Description.TextStrokeTransparency = 2
	Description.TextXAlignment = Enum.TextXAlignment.Left
	    Notification:TweenPosition(UDim2.new(1, -400, 0, 75), "Out", "Sine", 0.35)
	    wait(0.35)
	    Line:TweenSize(UDim2.new(0, 450, 0, 4), "Out", "Linear", Delay)
	    wait(Delay)
	    Notification:TweenPosition(UDim2.new(1, 5, 0, 75), "Out", "Sine", 0.35)
	    wait(0.35)
	    Notification:Destroy()
end

function Lib:Win(Name,key)
	local AtomicUi = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local FrameCorner = Instance.new("UICorner")
	local FrameStroke = Instance.new("UIStroke")
	local FrameShadow2 = Instance.new("ImageLabel")
	local PagesShadow = Instance.new("ImageLabel")
	
	local Line = Instance.new("Frame")
	local LineCorner = Instance.new("UICorner")
	local LineStroke = Instance.new("UIStroke")
	local CloseButton = Instance.new("ImageButton")
	local Text = Instance.new("TextLabel")
	
	local Pages = Instance.new("Frame")
	local PagesCorner = Instance.new("UICorner")
	local PagesStroke = Instance.new("UIStroke")

	local Tabs = Instance.new("Frame")
	local TabsCorner = Instance.new("UICorner")
	local TabsStroke = Instance.new("UIStroke")
	local TabsShadow = Instance.new("ImageLabel")
	local TabsScrolling = Instance.new("ScrollingFrame")
	local TabsListLayout = Instance.new("UIListLayout")
	local TabsFixFrame = Instance.new("Frame")

	AtomicUi.Name = "AtomicUi"
	AtomicUi.Parent = game.CoreGui
	AtomicUi.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Frame.Parent = AtomicUi
	Frame.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.263157904, 0, 0.298927605, 0)
	Frame.Size = UDim2.new(0, 433, 0, 219)

	FrameCorner.Name = "FrameCorner"
	FrameCorner.Parent = Frame

	FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	FrameStroke.Color = Color3.fromRGB(135, 135, 135)
	FrameStroke.Name = "FrameStroke"
	FrameStroke.Parent = Frame

	FrameShadow2.Name = "FrameShadow2"
	FrameShadow2.Parent = Frame
	FrameShadow2.AnchorPoint = Vector2.new(0.5, 0.5)
	FrameShadow2.BackgroundTransparency = 1.000
	FrameShadow2.BorderSizePixel = 0
	FrameShadow2.Position = UDim2.new(0.5, 0, 0.5, 0)
	FrameShadow2.Size = UDim2.new(1, 47, 1, 47)
	FrameShadow2.ZIndex = 0
	FrameShadow2.Image = "rbxassetid://6015897843"
	FrameShadow2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	FrameShadow2.ImageTransparency = 0.500
	FrameShadow2.ScaleType = Enum.ScaleType.Slice
	FrameShadow2.SliceCenter = Rect.new(49, 49, 450, 450)

	Tabs.Name = "Tabs"
	Tabs.Parent = Frame
	Tabs.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	Tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tabs.BorderSizePixel = 0
	Tabs.Position = UDim2.new(0.0181818176, 0, 0.163333327, 0)
	Tabs.Size = UDim2.new(0, 117, 0, 181)

	TabsCorner.CornerRadius = UDim.new(0, 4)
	TabsCorner.Name = "TabsCorner"
	TabsCorner.Parent = Tabs

	TabsStroke.Color = Color3.fromRGB(74, 74, 74)
	TabsStroke.Name = "TabsStroke"
	TabsStroke.Parent = Tabs

	TabsShadow.Name = "TabsShadow"
	TabsShadow.Parent = Tabs
	TabsShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	TabsShadow.BackgroundTransparency = 1.000
	TabsShadow.BorderSizePixel = 0
	TabsShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	TabsShadow.Size = UDim2.new(1, 47, 1, 47)
	TabsShadow.ZIndex = 0
	TabsShadow.Image = "rbxassetid://6014261993"
	TabsShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	TabsShadow.ImageTransparency = 0.500
	TabsShadow.ScaleType = Enum.ScaleType.Slice
	TabsShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	TabsScrolling.Name = "TabsScrolling"
	TabsScrolling.Parent = Tabs
	TabsScrolling.Active = true
	TabsScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsScrolling.BackgroundTransparency = 2.000
	TabsScrolling.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsScrolling.BorderSizePixel = 0
	TabsScrolling.Size = UDim2.new(0, 116, 0, 238)
    TabsScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsScrolling.ScrollBarThickness = 4

	TabsListLayout.Name = "TabsListLayout"
	TabsListLayout.Parent = TabsScrolling
	TabsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	TabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabsListLayout.Padding = UDim.new(0, 5)

	TabsFixFrame.Name = "TabsFixFrame"
	TabsFixFrame.Parent = TabsScrolling
	TabsFixFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabsFixFrame.BackgroundTransparency = 2.000
	TabsFixFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabsFixFrame.BorderSizePixel = 0
	TabsFixFrame.Position = UDim2.new(0.068965517, 0, 0, 0)
	TabsFixFrame.Size = UDim2.new(0, 100, 0, 6)
	
	PagesShadow.Name = "PagesShadow"
	PagesShadow.Parent = Pages
	PagesShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	PagesShadow.BackgroundTransparency = 1.000
	PagesShadow.BorderSizePixel = 0
	PagesShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	PagesShadow.Size = UDim2.new(1, 47, 1, 47)
	PagesShadow.ZIndex = 0
	PagesShadow.Image = "rbxassetid://6014261993"
	PagesShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	PagesShadow.ImageTransparency = 0.500
	PagesShadow.ScaleType = Enum.ScaleType.Slice
	PagesShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	
	Line.Name = "Line"
	Line.Parent = Frame
	Line.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Size = UDim2.new(0, 433, 0, 32)

	LineCorner.CornerRadius = UDim.new(0, 4)
	LineCorner.Name = "LineCorner"
	LineCorner.Parent = Line

	LineStroke.Color = Color3.fromRGB(74, 74, 74)
	LineStroke.Name = "LineStroke"
	LineStroke.Parent = Line

	local OpenButton = Instance.new("ScreenGui")
	local OpenButtonImage = Instance.new("ImageButton")
    local OpenButtonCorner = Instance.new("UICorner")
	OpenButton.Name = "OpenButton"
	OpenButton.Parent = game.CoreGui
	OpenButton.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	OpenButtonImage.Name = "OpenButtonImage"
	OpenButtonImage.Parent = OpenButton
	OpenButtonImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	OpenButtonImage.BackgroundTransparency = 0.650
	OpenButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	OpenButtonImage.BorderSizePixel = 0
	OpenButtonImage.Position = UDim2.new(0.102097899, 0, 0.0742971897, 0)
	OpenButtonImage.Size = UDim2.new(0, 45, 0, 45)
	OpenButtonImage.Image = "rbxassetid://11963368259"
	OpenButtonImage.Draggable = true
	OpenButtonImage.Selectable = true
	OpenButtonImage.Active = true 

	OpenButtonCorner.CornerRadius = UDim.new(0, 50)
	OpenButtonCorner.Name = "OpenButtonCorner"
	OpenButtonCorner.Parent = OpenButtonImage

	OpenButtonImage.MouseButton1Down:Connect(function()
		Frame.Visible = not Frame.Visible
	end)

	CloseButton.Name = "CloseButton"
	CloseButton.Parent = Line
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CloseButton.BackgroundTransparency = 2.000
	CloseButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CloseButton.BorderSizePixel = 0
	CloseButton.Position = UDim2.new(0.936363637, 0, 0.235294119, 0)
	CloseButton.Size = UDim2.new(0, 17, 0, 17)
	CloseButton.Image = "rbxassetid://11293981586"
	CloseButton.MouseButton1Down:Connect(function()
		Frame.Visible = not Frame.Visible
	end)

	CloseButton.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(CloseButton,TweenInfo.new(0.25),{ImageColor3=Color3.fromRGB(120, 0, 0)}):Play()
	end)

	CloseButton.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(CloseButton,TweenInfo.new(0.25),{ImageColor3=Color3.fromRGB(255, 255, 255)}):Play()
	end)

	Text.Name = "Text"
	Text.Parent = Line
	Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Text.BackgroundTransparency = 2.000
	Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Text.BorderSizePixel = 0
	Text.Position = UDim2.new(0.0181818176, 0, 0, 0)
	Text.Size = UDim2.new(0, 366, 0, 34)
	Text.Font = Enum.Font.RobotoCondensed
	Text.Text = Name
	Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	Text.TextSize = 19.000
	Text.TextXAlignment = Enum.TextXAlignment.Left

	Pages.Name = "Pages"
	Pages.Parent = Frame
	Pages.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	Pages.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Pages.BorderSizePixel = 0
	Pages.Position = UDim2.new(0, 130, 0.16, 0)
	Pages.Size = UDim2.new(0, 303, 0, 183)

	PagesCorner.CornerRadius = UDim.new(0, 4)
	PagesCorner.Name = "PagesCorner"
	PagesCorner.Parent = Pages

	PagesStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	PagesStroke.Color = Color3.fromRGB(74, 74, 74)
	PagesStroke.Name = "PagesStroke"
	PagesStroke.Parent = Pages
	
	local function MakeDraggable() 
		local script = Instance.new('LocalScript', Frame)

		local UIS = game:GetService("UserInputService")
		function dragify(Frame)
			dragToggle = nil
			local dragSpeed = 0
			dragInput = nil
			dragStart = nil
			local dragPos = nil
			function updateInput(input)
				local Delta = input.Position - dragStart
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
				game:GetService("TweenService"):Create(FrameStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(255, 255, 255)}):Play()
				game:GetService("TweenService"):Create(LineStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(155, 155, 155)}):Play()

			end
			Frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
					dragToggle = true
					dragStart = input.Position
					startPos = Frame.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false
							game:GetService("TweenService"):Create(FrameStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(135, 135, 135)}):Play()
							game:GetService("TweenService"):Create(LineStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
						end
					end)
				end
			end)
			Frame.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if input == dragInput and dragToggle then
					updateInput(input)
				end
			end)
		end

		dragify(script.Parent)
	end

	MakeDraggable()

	local UserInputService = game:GetService("UserInputService")
	local Chave = Enum.KeyCode.V
	local uitoggled = false

	function onKeyPress(inputObject, gameProcessedEvent)
		pcall(function()
			if not gameProcessedEvent then
				if inputObject.KeyCode == Chave then
					if uitoggled == false then
						Frame.Visible = false
						uitoggled = true
					else
						if uitoggled == true then
							Frame.Visible = true
							uitoggled = false
						end
					end
				end
			end
		end)
	end
	UserInputService.InputBegan:connect(onKeyPress)


	local Pagsee = {}
	
	function Pagsee:Tab(name,vis)
		local TabButton = Instance.new("TextButton")
		local UICorner = Instance.new("UICorner")
		local UIStroke = Instance.new("UIStroke")
		local PageScrolling = Instance.new("ScrollingFrame")
		local PageListLayout = Instance.new("UIListLayout")
		local Page = Instance.new("Frame")

		TabButton.Name = "TabButton"
		TabButton.Parent = TabsScrolling
		TabButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		TabButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0.116379313, 0, 0.0420168079, 0)
		TabButton.Size = UDim2.new(0, 89, 0, 23)
		TabButton.AutoButtonColor = false
		TabButton.Text = name
		TabButton.Font = Enum.Font.RobotoCondensed
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 14.000
	
		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = TabButton

		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Color = Color3.fromRGB(62, 62, 62)
		UIStroke.Parent = TabButton

		Page.Name = "Page"
		Page.Parent = Pages
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 2.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(0, 303, 0, 170)
		Page.Visible = vis or false

		PageScrolling.Name = "PageScrolling"
		PageScrolling.Parent = Page
		PageScrolling.Active = true
		PageScrolling.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PageScrolling.BackgroundTransparency = 2.000
		PageScrolling.BorderColor3 = Color3.fromRGB(35, 35, 35)
		PageScrolling.BorderSizePixel = 0
		PageScrolling.Size = UDim2.new(0, 303, 0, 170)
		PageScrolling.CanvasPosition = Vector2.new(0, 300)
		PageScrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
		PageScrolling.ScrollBarThickness = 4

		PageListLayout.Name = "PageListLayout"
		PageListLayout.Parent = PageScrolling
		PageListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageListLayout.Padding = UDim.new(0, 10)
		TabsScrolling.CanvasSize = UDim2.new(0, 0, 0, TabsListLayout.AbsoluteContentSize.Y)

		TabButton.MouseButton1Down:Connect(function()
			for i,v in pairs(Pages:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
				Page.Visible = true
			end
			game:GetService("TweenService"):Create(UIStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(100, 100, 100)}):Play()
			wait(0.2)
			game:GetService("TweenService"):Create(UIStroke,TweenInfo.new(0.10),{Color = Color3.fromRGB(62, 62, 62)}):Play()	
			
		end)

		TabButton.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(UIStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(80, 80, 80)}):Play()
		end)
	
		TabButton.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(UIStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(62, 62, 62)}):Play()
		end)

		local InPage = {}

		function InPage:PageFix(s)
			local FixFrame = Instance.new("Frame")
			FixFrame.Name = "FixFrame"
			FixFrame.Parent = s
			FixFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FixFrame.BackgroundTransparency = 2.000
			FixFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FixFrame.BorderSizePixel = 0
			FixFrame.Position = UDim2.new(0.331081092, 0, 0, 0)
			FixFrame.Size = UDim2.new(0, 100, 0, 0)
		end
		function InPage:TabFix()
			local FixFrame2 = Instance.new("Frame")
			FixFrame2.Name = "FixFrame"
			FixFrame2.Parent = PageScrolling
			FixFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			FixFrame2.BackgroundTransparency = 2.000
			FixFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
			FixFrame2.BorderSizePixel = 0
			FixFrame2.Position = UDim2.new(0.331081092, 0, 0, 0)
			FixFrame2.Size = UDim2.new(0, 100, 0, 0)
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)

		end
		InPage:PageFix(PageScrolling)
		InPage:PageFix(TabsScrolling)
		function InPage:ImageLabel(image,txt1,txt2)
			local WlcFrame = Instance.new("Frame")
			local WlcFrameCorner = Instance.new("UICorner")
			local WlcFrameStroke = Instance.new("UIStroke")
			local PlayerImage = Instance.new("ImageLabel")
			local PlayerImageCorner = Instance.new("UICorner")
			local PlayerName = Instance.new("TextLabel")
			local PlayerDisplayName = Instance.new("TextLabel")
			
			WlcFrame.Name = "WlcFrame"
			WlcFrame.Parent = PageScrolling
			WlcFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			WlcFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WlcFrame.BorderSizePixel = 0
			WlcFrame.Position = UDim2.new(-0.256756753, 0, 0.0882352963, 0)
			WlcFrame.Size = UDim2.new(0, 274, 0, 100)
			
			WlcFrameCorner.Name = "WlcFrameCorner"
			WlcFrameCorner.Parent = WlcFrame
			
			WlcFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			WlcFrameStroke.Name = "WlcFrameStroke"
			WlcFrameStroke.Parent = WlcFrame
			
			PlayerImage.Name = "PlayerImage"
			PlayerImage.Parent = WlcFrame
			PlayerImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PlayerImage.BackgroundTransparency = 2.000
			PlayerImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PlayerImage.BorderSizePixel = 0
			PlayerImage.Position = UDim2.new(0.0729926974, 0, 0.150000006, 0)
			PlayerImage.Size = UDim2.new(0, 70, 0, 70)
			PlayerImage.Image = image
			
			PlayerImageCorner.CornerRadius = UDim.new(0, 444)
			PlayerImageCorner.Name = "PlayerImageCorner"
			PlayerImageCorner.Parent = PlayerImage
			
			PlayerName.Name = "PlayerName"
			PlayerName.Parent = WlcFrame
			PlayerName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PlayerName.BackgroundTransparency = 2.000
			PlayerName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PlayerName.BorderSizePixel = 0
			PlayerName.Position = UDim2.new(0.37956205, 0, 0.25999999, 0)
			PlayerName.Size = UDim2.new(0, 164, 0, 27)
			PlayerName.Font = Enum.Font.RobotoCondensed
			PlayerName.Text = txt1
			PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
			PlayerName.TextSize = 20.000
			PlayerName.TextXAlignment = Enum.TextXAlignment.Left
			
			PlayerDisplayName.Name = "PlayerDisplayName"
			PlayerDisplayName.Parent = WlcFrame
			PlayerDisplayName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			PlayerDisplayName.BackgroundTransparency = 2.000
			PlayerDisplayName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			PlayerDisplayName.BorderSizePixel = 0
			PlayerDisplayName.Position = UDim2.new(0.37956205, 0, 0.529999971, 0)
			PlayerDisplayName.Size = UDim2.new(0, 144, 0, 18)
			PlayerDisplayName.Font = Enum.Font.RobotoCondensed
			PlayerDisplayName.Text = txt2
			PlayerDisplayName.TextColor3 = Color3.fromRGB(134, 134, 134)
			PlayerDisplayName.TextSize = 15.000
			PlayerDisplayName.TextXAlignment = Enum.TextXAlignment.Left
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)
		end

		function InPage:Info(versionn,rank,lastupdate)
			local InfoFrame = Instance.new("Frame")
			local WlcFrameCorner_2 = Instance.new("UICorner")
			local WlcFrameStroke_2 = Instance.new("UIStroke")
			
			local VersionFrame = Instance.new("Frame")
			local VersionFrameCorner = Instance.new("UICorner")
			local VersionFrameStroke = Instance.new("UIStroke")
			local VersionLabel = Instance.new("TextLabel")
			local Version = Instance.new("TextLabel")
			
			local RankFrame = Instance.new("Frame")
			local RankFrameCorner = Instance.new("UICorner")
			local RankFrameStroke = Instance.new("UIStroke")
			local RankLabel = Instance.new("TextLabel")
			local Rank = Instance.new("TextLabel")
			
			local StatusFrame = Instance.new("Frame")
			local StatusFrameCorner = Instance.new("UICorner")
			local StatusFrameStroke = Instance.new("UIStroke")
			local StatusLabel = Instance.new("TextLabel")
			local Status = Instance.new("TextLabel")
			
			local CloseFrame = Instance.new("Frame")
			local CloseFrameCorner = Instance.new("UICorner")
			local CloseFrameStroke = Instance.new("UIStroke")
			local Close = Instance.new("TextLabel")
			
			InfoFrame.Name = "InfoFrame"
			InfoFrame.Parent = PageScrolling
			InfoFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			InfoFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InfoFrame.BorderSizePixel = 0
			InfoFrame.Position = UDim2.new(0.0371621624, 0, -0.126050428, 0)
			InfoFrame.Size = UDim2.new(0, 274, 0, 117)
			
			WlcFrameCorner_2.Name = "WlcFrameCorner"
			WlcFrameCorner_2.Parent = InfoFrame
			
			WlcFrameStroke_2.Color = Color3.fromRGB(74, 74, 74)
			WlcFrameStroke_2.Name = "WlcFrameStroke"
			WlcFrameStroke_2.Parent = InfoFrame
			
			VersionFrame.Name = "VersionFrame"
			VersionFrame.Parent = InfoFrame
			VersionFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			VersionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			VersionFrame.BorderSizePixel = 0
			VersionFrame.Position = UDim2.new(0.0437956192, 0, 0.200000003, 0)
			VersionFrame.Size = UDim2.new(0, 78, 0, 34)
			
			VersionFrameCorner.Name = "VersionFrameCorner"
			VersionFrameCorner.Parent = VersionFrame
			
			VersionFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			VersionFrameStroke.Name = "VersionFrameStroke"
			VersionFrameStroke.Parent = VersionFrame
			
			VersionLabel.Name = "VersionLabel"
			VersionLabel.Parent = VersionFrame
			VersionLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			VersionLabel.BackgroundTransparency = 2.000
			VersionLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			VersionLabel.BorderSizePixel = 0
			VersionLabel.Position = UDim2.new(0.051282052, 0, -0.411764711, 0)
			VersionLabel.Size = UDim2.new(0, 74, 0, 8)
			VersionLabel.Font = Enum.Font.RobotoCondensed
			VersionLabel.Text = "التحديث"
			VersionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			VersionLabel.TextSize = 14.000
			VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			Version.Name = "Version"
			Version.Parent = VersionFrame
			Version.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Version.BackgroundTransparency = 2.000
			Version.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Version.BorderSizePixel = 0
			Version.Position = UDim2.new(0.128205135, 0, 0.0882352963, 0)
			Version.Size = UDim2.new(0, 50, 0, 27)
			Version.Font = Enum.Font.RobotoCondensed
			Version.Text = versionn
			Version.TextColor3 = Color3.fromRGB(144, 144, 144)
			Version.TextSize = 14.000
			Version.TextXAlignment = Enum.TextXAlignment.Left
			
			RankFrame.Name = "RankFrame"
			RankFrame.Parent = InfoFrame
			RankFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			RankFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			RankFrame.BorderSizePixel = 0
			RankFrame.Position = UDim2.new(0.357664227, 0, 0.200000003, 0)
			RankFrame.Size = UDim2.new(0, 78, 0, 34)
			
			RankFrameCorner.Name = "RankFrameCorner"
			RankFrameCorner.Parent = RankFrame
			
			RankFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			RankFrameStroke.Name = "RankFrameStroke"
			RankFrameStroke.Parent = RankFrame
			
			RankLabel.Name = "RankLabel"
			RankLabel.Parent = RankFrame
			RankLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			RankLabel.BackgroundTransparency = 2.000
			RankLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			RankLabel.BorderSizePixel = 0
			RankLabel.Position = UDim2.new(0.051282052, 0, -0.411764711, 0)
			RankLabel.Size = UDim2.new(0, 74, 0, 8)
			RankLabel.Font = Enum.Font.RobotoCondensed
			RankLabel.Text = "الرانك"
			RankLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			RankLabel.TextSize = 14.000
			RankLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			Rank.Name = "Rank"
			Rank.Parent = RankFrame
			Rank.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Rank.BackgroundTransparency = 2.000
			Rank.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Rank.BorderSizePixel = 0
			Rank.Position = UDim2.new(0.128205135, 0, 0.0882352963, 0)
			Rank.Size = UDim2.new(0, 50, 0, 27)
			Rank.Font = Enum.Font.RobotoCondensed
			Rank.Text = rank
			Rank.TextColor3 = Color3.fromRGB(144, 144, 144)
			Rank.TextSize = 14.000
			Rank.TextXAlignment = Enum.TextXAlignment.Left
			
			StatusFrame.Name = "StatusFrame"
			StatusFrame.Parent = InfoFrame
			StatusFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			StatusFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			StatusFrame.BorderSizePixel = 0
			StatusFrame.Position = UDim2.new(0.671532869, 0, 0.200000003, 0)
			StatusFrame.Size = UDim2.new(0, 78, 0, 34)
			
			StatusFrameCorner.Name = "StatusFrameCorner"
			StatusFrameCorner.Parent = StatusFrame
			
			StatusFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			StatusFrameStroke.Name = "StatusFrameStroke"
			StatusFrameStroke.Parent = StatusFrame
			
			StatusLabel.Name = "StatusLabel"
			StatusLabel.Parent = StatusFrame
			StatusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			StatusLabel.BackgroundTransparency = 2.000
			StatusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			StatusLabel.BorderSizePixel = 0
			StatusLabel.Position = UDim2.new(0.051282052, 0, -0.411764711, 0)
			StatusLabel.Size = UDim2.new(0, 74, 0, 8)
			StatusLabel.Font = Enum.Font.RobotoCondensed
			StatusLabel.Text = "اخر تحديث"
			StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			StatusLabel.TextSize = 14.000
			StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			Status.Name = "Status"
			Status.Parent = StatusFrame
			Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Status.BackgroundTransparency = 2.000
			Status.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Status.BorderSizePixel = 0
			Status.Position = UDim2.new(0.128205135, 0, 0.0882352963, 0)
			Status.Size = UDim2.new(0, 50, 0, 27)
			Status.Font = Enum.Font.RobotoCondensed
			Status.Text = lastupdate
			Status.TextColor3 = Color3.fromRGB(122, 122, 122)
			Status.TextSize = 14.000
			Status.TextXAlignment = Enum.TextXAlignment.Left
			
			CloseFrame.Name = "CloseFrame"
			CloseFrame.Parent = InfoFrame
			CloseFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			CloseFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CloseFrame.BorderSizePixel = 0
			CloseFrame.Position = UDim2.new(0.0437956192, 0, 0.649999917, 0)
			CloseFrame.Size = UDim2.new(0, 250, 0, 28)
			
			CloseFrameCorner.Name = "CloseFrameCorner"
			CloseFrameCorner.Parent = CloseFrame
			
			CloseFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			CloseFrameStroke.Name = "CloseFrameStroke"
			CloseFrameStroke.Parent = CloseFrame
			
			Close.Name = "Close"
			Close.Parent = CloseFrame
			Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Close.BackgroundTransparency = 2.000
			Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Close.BorderSizePixel = 0
			Close.Position = UDim2.new(0.0399999991, 0, 0.0882327408, 0)
			Close.Size = UDim2.new(0, 226, 0, 26)
			Close.Font = Enum.Font.RobotoCondensed
			Close.Text = "اضغط \"V\" لاغلاق او فتح القائمة"
			Close.TextColor3 = Color3.fromRGB(122, 122, 122)
			Close.TextSize = 14.000
			Close.TextXAlignment = Enum.TextXAlignment.Left
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)
		end

		function InPage:Label(name)
			local txtLabel = Instance.new("TextLabel")
			txtLabel.Name = "ButtonLabel"
			txtLabel.Parent = PageScrolling
			txtLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			txtLabel.BackgroundTransparency = 2.000
			txtLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			txtLabel.BorderSizePixel = 0
			txtLabel.Position = UDim2.new(0.121323526, 0, 0.181818187, 0)
			txtLabel.Size = UDim2.new(0, 272, 0, 33)
			txtLabel.Font = Enum.Font.RobotoCondensed
			txtLabel.Text = name
			txtLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			txtLabel.TextSize = 17.000
		end

		function InPage:BigButton(name,img,callback)
			local BigButton = Instance.new("TextButton")
			local BigButtonCorner = Instance.new("UICorner")
			local BigButtonStroke = Instance.new("UIStroke")
			local BigButtonLabel = Instance.new("TextLabel")
			local BigButtonImage = Instance.new("ImageLabel")
			local callback = callback or function () end
			
			BigButton.Name = "BigButton"
			BigButton.Parent = PageScrolling
			BigButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			BigButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BigButton.BorderSizePixel = 0
			BigButton.Position = UDim2.new(0.0540540554, 0, 0.352941185, 0)
			BigButton.Size = UDim2.new(0, 272, 0, 86)
			BigButton.AutoButtonColor = false
			BigButton.Font = Enum.Font.SourceSans
			BigButton.Text = ""
			BigButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			BigButton.TextSize = 14.000
			
			BigButtonCorner.Name = "BigButtonCorner"
			BigButtonCorner.Parent = BigButton
			
			BigButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			BigButtonStroke.Color = Color3.fromRGB(74, 74, 74)
			BigButtonStroke.Name = "BigButtonStroke"
			BigButtonStroke.Parent = BigButton
			
			BigButtonLabel.Name = "BigButtonLabel"
			BigButtonLabel.Parent = BigButton
			BigButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BigButtonLabel.BackgroundTransparency = 2.000
			BigButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BigButtonLabel.BorderSizePixel = 0
			BigButtonLabel.Position = UDim2.new(0.0551470593, 0, 0.519027352, 0)
			BigButtonLabel.Size = UDim2.new(0, 176, 0, 34)
			BigButtonLabel.Text = name
			BigButtonLabel.Font = Enum.Font.RobotoCondensed
			BigButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			BigButtonLabel.TextSize = 28.000
			BigButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			BigButtonImage.Name = "BigButtonImage"
			BigButtonImage.Parent = BigButton
			BigButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BigButtonImage.BackgroundTransparency = 2.000
			BigButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			BigButtonImage.BorderSizePixel = 0
			BigButtonImage.Position = UDim2.new(0.702205896, 0, 0.0863285512, 0)
			BigButtonImage.Size = UDim2.new(0, 70, 0, 70)
			BigButtonImage.Image = img
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)

            BigButton.MouseButton1Down:Connect(function()
                game:GetService("TweenService"):Create(BigButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(255, 255, 255)}):Play()
                wait(0.01)
                game:GetService("TweenService"):Create(BigButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
                pcall(callback)
            end)

			BigButton.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(BigButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(100, 100, 100)}):Play()
			end)
		
			BigButton.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(BigButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
			end)

		end

		function InPage:Button(name,callback)
			local Button = Instance.new("TextButton")
			local ButtonCorner = Instance.new("UICorner")
			local ButtonStroke = Instance.new("UIStroke")
			local ButtonLabel = Instance.new("TextLabel")
			local ButtonImage = Instance.new("ImageLabel")
			local callback = callback or function () end

			Button.Name = "Button"
			Button.Parent = PageScrolling
			Button.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0.0371621624, 0, 0.70168066, 0)
			Button.Size = UDim2.new(0, 272, 0, 33)
			Button.AutoButtonColor = false
			Button.Font = Enum.Font.SourceSans
			Button.Text = ""
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000
			
			ButtonCorner.Name = "ButtonCorner"
			ButtonCorner.Parent = Button
			
			ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			ButtonStroke.Color = Color3.fromRGB(74, 74, 74)
			ButtonStroke.Name = "ButtonStroke"
			ButtonStroke.Parent = Button
			
			ButtonLabel.Name = "ButtonLabel"
			ButtonLabel.Parent = Button
			ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.BackgroundTransparency = 2.000
			ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonLabel.BorderSizePixel = 0
			ButtonLabel.Position = UDim2.new(0.121323526, 0, 0.181818187, 0)
			ButtonLabel.Size = UDim2.new(0, 228, 0, 20)
			ButtonLabel.Font = Enum.Font.RobotoCondensed
			ButtonLabel.Text = name
			ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonLabel.TextSize = 17.000
			ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			ButtonImage.Name = "ButtonImage"
			ButtonImage.Parent = Button
			ButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonImage.BackgroundTransparency = 2.000
			ButtonImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonImage.BorderSizePixel = 0
			ButtonImage.Position = UDim2.new(0.0073529412, 0, 0.121212125, 0)
			ButtonImage.Size = UDim2.new(0, 25, 0, 25)
			ButtonImage.Image = "rbxassetid://11295279987"
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)

            Button.MouseButton1Down:Connect(function()
                game:GetService("TweenService"):Create(ButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(255, 255, 255)}):Play()
                wait(0.01)
                game:GetService("TweenService"):Create(ButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
                pcall(callback)
            end)

			Button.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(100, 100, 100)}):Play()
			end)
		
			Button.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ButtonStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
			end)
	
		end

		function InPage:Toggle(name,callback)
			local Toggle = Instance.new("TextButton")
			local ToggleCorner = Instance.new("UICorner")
			local ToggleStroke = Instance.new("UIStroke")
			local ToggleLabel = Instance.new("TextLabel")
			local ToggleImage = Instance.new("ImageLabel")
			local callback = callback or function () end
            local ToggleEnabled = false

			Toggle.Name = "Toggle"
			Toggle.Parent = PageScrolling
			Toggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.BorderSizePixel = 0
			Toggle.Position = UDim2.new(0.0371621624, 0, 0.70168066, 0)
			Toggle.Size = UDim2.new(0, 272, 0, 33)
			Toggle.AutoButtonColor = false
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = ""
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000
			
			ToggleCorner.Name = "ToggleCorner"
			ToggleCorner.Parent = Toggle
			
			ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			ToggleStroke.Color = Color3.fromRGB(74, 74, 74)
			ToggleStroke.Name = "ToggleStroke"
			ToggleStroke.Parent = Toggle
			
			ToggleLabel.Name = "ToggleLabel"
			ToggleLabel.Parent = Toggle
			ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleLabel.BackgroundTransparency = 2.000
			ToggleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleLabel.BorderSizePixel = 0
			ToggleLabel.Position = UDim2.new(0.121323526, 0, 0.181818187, 0)
			ToggleLabel.Size = UDim2.new(0, 228, 0, 20)
			ToggleLabel.Font = Enum.Font.RobotoCondensed
			ToggleLabel.Text = name
			ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleLabel.TextSize = 17.000
			ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			ToggleImage.Name = "ToggleImage"
			ToggleImage.Parent = Toggle
			ToggleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleImage.BackgroundTransparency = 2.000
			ToggleImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleImage.BorderSizePixel = 0
			ToggleImage.Position = UDim2.new(0.0149999997, 0, 0.0909999982, 2)
			ToggleImage.Size = UDim2.new(0, 23, 0, 23)
			ToggleImage.Image = "rbxassetid://11293978956"
			ToggleImage.ImageColor3 = Color3.fromRGB(255, 0, 0)
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)
			Toggle.MouseButton1Down:Connect(function()
                ToggleEnabled = not ToggleEnabled
                if ToggleEnabled then 
                    game:GetService("TweenService"):Create(ToggleImage,TweenInfo.new(0.25),{ImageColor3=Color3.fromRGB(0, 211, 0)}):Play()
                else
                    game:GetService("TweenService"):Create(ToggleImage,TweenInfo.new(0.25),{ImageColor3=Color3.fromRGB(211, 0, 0)}):Play()
                end
                pcall(callback,ToggleEnabled)
            end)

			Toggle.MouseEnter:Connect(function()
				game:GetService("TweenService"):Create(ToggleStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(100, 100, 100)}):Play()
			end)
		
			Toggle.MouseLeave:Connect(function()
				game:GetService("TweenService"):Create(ToggleStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
			end)

		end

		function InPage:Slider(name,minvalue,maxvalue,callback)
			local SliderFrame = Instance.new("Frame")
			local SliderFrameCorner = Instance.new("UICorner")
			local SliderFrameStroke = Instance.new("UIStroke")
			local SliderLabel = Instance.new("TextLabel")
			local SliderNumber = Instance.new("TextLabel")
			local SliderButton = Instance.new("TextButton")
			local SliderButtonCorner = Instance.new("UICorner")
			local SliderButtonStroke = Instance.new("UIStroke")
			local SliderLine = Instance.new("Frame")
			local SliderLineCorner = Instance.new("UICorner")
			local callback = callback or function() end
            local mouse = game.Players.LocalPlayer:GetMouse()
            local uis = game:GetService("UserInputService")
            local Value

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = PageScrolling
			SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.0405405387, 0, 0.39915967, 0)
			SliderFrame.Size = UDim2.new(0, 272, 0, 45)
			
			SliderFrameCorner.Name = "SliderFrameCorner"
			SliderFrameCorner.Parent = SliderFrame
			
			SliderFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			SliderFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			SliderFrameStroke.Name = "SliderFrameStroke"
			SliderFrameStroke.Parent = SliderFrame
			
			SliderLabel.Name = "SliderLabel"
			SliderLabel.Parent = SliderFrame
			SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.BackgroundTransparency = 2.000
			SliderLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderLabel.BorderSizePixel = 0
			SliderLabel.Position = UDim2.new(0.0698529407, 0, 0.13333334, 0)
			SliderLabel.Size = UDim2.new(0, 187, 0, 12)
			SliderLabel.Font = Enum.Font.RobotoCondensed
			SliderLabel.Text = name
			SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderLabel.TextSize = 17.000
			SliderLabel.TextWrapped = true
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			
			SliderNumber.Name = "SliderNumber"
			SliderNumber.Parent = SliderFrame
			SliderNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderNumber.BackgroundTransparency = 2.000
			SliderNumber.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderNumber.BorderSizePixel = 0
			SliderNumber.Position = UDim2.new(0.841911793, 0, 0.13333334, 0)
			SliderNumber.Size = UDim2.new(0, 32, 0, 12)
			SliderNumber.Font = Enum.Font.RobotoCondensed
			SliderNumber.Text = "1"
			SliderNumber.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderNumber.TextSize = 13.000
			SliderNumber.TextWrapped = true
			
			SliderButton.Name = "SliderButton"
			SliderButton.Parent = SliderFrame
			SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderButton.BackgroundTransparency = 2.000
			SliderButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderButton.BorderSizePixel = 0
			SliderButton.Position = UDim2.new(0.0661764741, 0, 0.577777803, 0)
			SliderButton.Size = UDim2.new(0, 235, 0, 13)
			SliderButton.Font = Enum.Font.SourceSans
			SliderButton.Text = ""
			SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			SliderButton.TextSize = 14.000
			
			SliderButtonCorner.Name = "SliderButtonCorner"
			SliderButtonCorner.Parent = SliderButton
			
			SliderButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			SliderButtonStroke.Color = Color3.fromRGB(74, 74, 74)
			SliderButtonStroke.Name = "SliderButtonStroke"
			SliderButtonStroke.Parent = SliderButton
			
			SliderLine.Name = "SliderLine"
			SliderLine.Parent = SliderButton
			SliderLine.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
			SliderLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderLine.BorderSizePixel = 0
			SliderLine.Size = UDim2.new(0, 0, 0, 13)
			
			SliderLineCorner.Name = "SliderLineCorner"
			SliderLineCorner.Parent = SliderLine
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)

			SliderButton.MouseButton1Down:Connect(function()
                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 234) * SliderLine.AbsoluteSize.X) + tonumber(minvalue)) or 0
                pcall(function()
                    callback(Value)
                end)
                SliderLine:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 234), 0, 13),"Out","Linear",0.1)
                --SliderLine.Size = UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 200), 0, 7)
                moveconnection = mouse.Move:Connect(function()
                SliderNumber.Text = Value
                game:GetService("TweenService"):Create(SliderButtonStroke,TweenInfo.new(0.1),{Color = Color3.fromRGB(255, 255, 255)}):Play()
                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 234) * SliderLine.AbsoluteSize.X) + tonumber(minvalue))
                pcall(function()
                    callback(Value)
                end)
                SliderLine:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 234), 0, 13),"Out","Linear",0.1)
                --SliderLine.Size = UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 200), 0, 7)
            end)
            releaseconnection = uis.InputEnded:Connect(function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 234) * SliderLine.AbsoluteSize.X) + tonumber(minvalue))
                    pcall(function()
                        callback(Value)
                    end)
                    SliderLine:TweenSize(UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 234), 0, 13),"Out","Linear",0.1)
                    --SliderLine.Size = UDim2.new(0, math.clamp(mouse.X - SliderLine.AbsolutePosition.X, 0, 200), 0, 7)
                    moveconnection:Disconnect()
                    releaseconnection:Disconnect()
                    game:GetService("TweenService"):Create(SliderButtonStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(74, 74, 74)}):Play()
                end
            end)
        end)

		SliderButton.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(SliderFrameStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(100, 100, 100)}):Play()
		end)
	
		SliderButton.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(SliderFrameStroke,TweenInfo.new(0.25),{Color=Color3.fromRGB(74, 74, 74)}):Play()
		end)

		end

		function InPage:Textbox(name,txt,numb,callback)
			local TextBoxFrame = Instance.new("Frame")
			local TextBoxFrameCorner = Instance.new("UICorner")
			local TextBoxFrameStroke = Instance.new("UIStroke")
			local TextBox = Instance.new("TextBox")
			local TargetTextBoxCorner = Instance.new("UICorner")
			local TargetTextBoxStroke = Instance.new("UIStroke")
			local TextBoxLabel = Instance.new("TextLabel")
			local callback = callback or function() end
			local numberOnly = numb or false
			TextBoxFrame.Name = "TextBoxFrame"
			TextBoxFrame.Parent = PageScrolling
			TextBoxFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			TextBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBoxFrame.BorderSizePixel = 0
			TextBoxFrame.Position = UDim2.new(0.0371621624, 0, 0.613445401, 0)
			TextBoxFrame.Size = UDim2.new(0, 272, 0, 45)
			
			TextBoxFrameCorner.Name = "TextBoxFrameCorner"
			TextBoxFrameCorner.Parent = TextBoxFrame
			
			TextBoxFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			TextBoxFrameStroke.Name = "TextBoxFrameStroke"
			TextBoxFrameStroke.Parent = TextBoxFrame
			
			TextBox.Parent = TextBoxFrame
			TextBox.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
			TextBox.BackgroundTransparency = 2.000
			TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.BorderSizePixel = 0
			TextBox.Position = UDim2.new(0.577205896, 0, 0.150000006, 0)
			TextBox.Size = UDim2.new(0, 103, 0, 31)
			TextBox.Font = Enum.Font.RobotoCondensed
			TextBox.Text = txt
			TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBox.TextSize = 14.000
			
			TargetTextBoxCorner.Name = "TargetTextBoxCorner"
			TargetTextBoxCorner.Parent = TextBox
			
			TargetTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			TargetTextBoxStroke.Color = Color3.fromRGB(74, 74, 74)
			TargetTextBoxStroke.Thickness = 0.699999988079071
			TargetTextBoxStroke.Name = "TargetTextBoxStroke"
			TargetTextBoxStroke.Parent = TextBox
			
			TextBoxLabel.Name = "TextBoxLabel"
			TextBoxLabel.Parent = TextBoxFrame
			TextBoxLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBoxLabel.BackgroundTransparency = 2.000
			TextBoxLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TextBoxLabel.BorderSizePixel = 0
			TextBoxLabel.Position = UDim2.new(0.0404411778, 0, 0.244444445, 0)
			TextBoxLabel.Size = UDim2.new(0, 137, 0, 22)
			TextBoxLabel.Text = name
			TextBoxLabel.Font = Enum.Font.RobotoCondensed
			TextBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBoxLabel.TextSize = 17.000
			TextBoxLabel.TextWrapped = true
			TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left

            TextBox.Focused:Connect(function()
                game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(130, 130, 130)}):Play()
            end)
			
			if numberOnly == false then
				TextBox.FocusLost:Connect(function()
					game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(255, 255, 255)}):Play()
					wait(0.2)
					game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(74, 74, 74)}):Play()
					callback(TextBox.Text)
					TextBox.Text = txt
				end)
				
			else

				TextBox.Focused:Connect(function()
					game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(130, 130, 130)}):Play()
				end)
	
				TextBox.FocusLost:Connect(function(Return)
					if not (Return) then
						return
					end
					if (TextBox.Text:match("^%d+$")) then
						game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(255, 255, 255)}):Play()
						wait(0.2)
						game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(74, 74, 74)}):Play()
						callback(TextBox.Text)
						TextBox.Text = txt
					else
						TextBox.Text = "ارقام فقط !"
						game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(255, 0, 0)}):Play()
						wait(0.8)
						TextBox.Text = txt
						game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(74, 74, 74)}):Play()
					end
				end)
			end
		end
		function InPage:TargetTextBox(image,name,id)
			local TargetFrame = Instance.new("Frame")
			local TargetFrameCorner = Instance.new("UICorner")
			local TargetFrameStroke = Instance.new("UIStroke")
			local TargetImage = Instance.new("ImageLabel")
			local PlayerImageCorner_2 = Instance.new("UICorner")
			local TargetName = Instance.new("TextLabel")
			local TargetTextBox = Instance.new("TextBox")
			local TargetTextBoxCorner = Instance.new("UICorner")
			local TargetTextBoxStroke = Instance.new("UIStroke")
			local TargetId = Instance.new("TextLabel")

			TargetFrame.Name = "TargetFrame"
			TargetFrame.Parent = PageScrolling
			TargetFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			TargetFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TargetFrame.BorderSizePixel = 0
			TargetFrame.Position = UDim2.new(0.0540540554, 0, 0.369747907, 0)
			TargetFrame.Size = UDim2.new(0, 274, 0, 100)
			
			TargetFrameCorner.Name = "TargetFrameCorner"
			TargetFrameCorner.Parent = TargetFrame
			
			TargetFrameStroke.Color = Color3.fromRGB(74, 74, 74)
			TargetFrameStroke.Name = "TargetFrameStroke"
			TargetFrameStroke.Parent = TargetFrame
			
			TargetImage.Name = "TargetImage"
			TargetImage.Parent = TargetFrame
			TargetImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TargetImage.BackgroundTransparency = 2.000
			TargetImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TargetImage.BorderSizePixel = 0
			TargetImage.Position = UDim2.new(0.0729926974, 0, 0.150000006, 0)
			TargetImage.Size = UDim2.new(0, 70, 0, 70)
			TargetImage.Image = image
			
			PlayerImageCorner_2.CornerRadius = UDim.new(0, 444)
			PlayerImageCorner_2.Name = "PlayerImageCorner"
			PlayerImageCorner_2.Parent = TargetImage
			
			TargetName.Name = "TargetName"
			TargetName.Parent = TargetFrame
			TargetName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TargetName.BackgroundTransparency = 2.000
			TargetName.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TargetName.BorderSizePixel = 0
			TargetName.Position = UDim2.new(0.394160599, 0, 0.519999981, 0)
			TargetName.Size = UDim2.new(0, 140, 0, 18)
			TargetName.Font = Enum.Font.RobotoCondensed
			TargetName.Text = "Target Name : "..name
			TargetName.TextColor3 = Color3.fromRGB(134, 134, 134)
			TargetName.TextSize = 15.000
			TargetName.TextXAlignment = Enum.TextXAlignment.Left
			
			TargetTextBox.Name = "TargetTextBox"
			TargetTextBox.Parent = TargetFrame
			TargetTextBox.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
			TargetTextBox.BackgroundTransparency = 2.000
			TargetTextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TargetTextBox.BorderSizePixel = 0
			TargetTextBox.Position = UDim2.new(0.394160599, 0, 0.150000006, 0)
			TargetTextBox.Size = UDim2.new(0, 118, 0, 31)
			TargetTextBox.Font = Enum.Font.RobotoCondensed
			TargetTextBox.Text = ""
			TargetTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			TargetTextBox.TextSize = 14.000
			
			TargetTextBoxCorner.Name = "TargetTextBoxCorner"
			TargetTextBoxCorner.Parent = TargetTextBox
			
			TargetTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			TargetTextBoxStroke.Color = Color3.fromRGB(74, 74, 74)
			TargetTextBoxStroke.Thickness = 0.699999988079071
			TargetTextBoxStroke.Name = "TargetTextBoxStroke"
			TargetTextBoxStroke.Parent = TargetTextBox
			
			TargetId.Name = "TargetId"
			TargetId.Parent = TargetFrame
			TargetId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TargetId.BackgroundTransparency = 2.000
			TargetId.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TargetId.BorderSizePixel = 0
			TargetId.Position = UDim2.new(0.394160599, 0, 0.699999988, 0)
			TargetId.Size = UDim2.new(0, 140, 0, 18)
			TargetId.Font = Enum.Font.RobotoCondensed
			TargetId.Text = "ID : "..id
			TargetId.TextColor3 = Color3.fromRGB(134, 134, 134)
			TargetId.TextSize = 15.000
			TargetId.TextXAlignment = Enum.TextXAlignment.Left
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)
			PageScrolling.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y)

			local Player = function(Ev)
				if Ev == "" then
					return nil
				elseif Ev == "random" then
					return game:GetService("Players"):GetPlayers()[math.random(1, #game:GetService("Players"):GetPlayers())]
				else
					for _, v in pairs(game:GetService("Players"):GetPlayers()) do
						if v.Name:lower():sub(1, #Ev) == Ev:lower() or v.DisplayName:lower():sub(1, #Ev) == Ev then
							return v
						end
					end
				end
			end

			game.Workspace.FallenPartsDestroyHeight = -50000
			TargetTextBox.FocusLost:Connect(function()
				game:GetService("TweenService"):Create(TargetTextBoxStroke,TweenInfo.new(0.25),{Color = Color3.fromRGB(74, 74, 74)}):Play()
				local TargetV = Player(TargetTextBox.Text)
				if TargetV ~= game:GetService("Players").LocalPlayer then
					TargetTextBox.Text = TargetV.Name
					TargetName.Text = "Target Name : @"..TargetV.DisplayName
					TargetId.Text = "ID : "..TargetV.UserId
					TargetImage.Image = game:GetService("Players"):GetUserThumbnailAsync(TargetV.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
				end
			end)   

			InPage:TabFix()
			InPage:TabFix()

			InPage:Button("انتقال",function()
				Benx = false
				Bang = false
				Suck = false
				HeadSit = false
				FaceBang = false
				Stand = false

				local TargetV = Player(TargetTextBox.Text)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TargetV.Character.HumanoidRootPart.CFrame
			end)
			
			InPage:Button("فلينق",function()
				Benx = false
				Bang = false
				Suck = false
				HeadSit = false
				FaceBang = false
				Stand = false
				local Target3 = Player(TargetTextBox.Text)
				local charme = {[1] = ";char me"}
				local unchar = {[1] = ";unchar"}
				game:GetService("ReplicatedStorage").HDAdminClient.Signals.RequestCommand:InvokeServer(unpack(charme))
                wait(0.4)		
				FlingPlayer(Target3.Name)
				game:GetService("ReplicatedStorage").HDAdminClient.Signals.RequestCommand:InvokeServer(unpack(unchar))
			end)

			InPage:TabFix()
			InPage:TabFix()

			local function IsTheTargetSitting(player)
				local set = player.Character.Humanoid.Sit == false
				return set
			end
			
			_G.Wait = false
			InPage:Button("قتل",function()
				if _G.Wait == true then
					return
				end
				_G.Wait = true
				local Target3 = Player(TargetTextBox.Text)
				local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
				wait(1)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("ShoppingCart")
				wait(1)					
				game:GetService('RunService'):BindToRenderStep("Teleport", 0 , function()
					game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1.6")
					for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA"Tool" and v.Name == "ShoppingCart" then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end					
					
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame + Target3.Character.Humanoid.MoveDirection * 8
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

					if not IsTheTargetSitting(Target3) then
						game:GetService('RunService'):UnbindFromRenderStep("Teleport")
						
						wait(0.5)
						game:GetService('RunService'):BindToRenderStep("Teleport To Void", 0 , function()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, -1000.51605, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
						end)
						wait(0.4)
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
						wait(3)
						game:GetService('RunService'):UnbindFromRenderStep("Teleport To Void")
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
						game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1")
						_G.Wait = false
					end
				end)
			end)

			InPage:Button("ارساله للفضاء",function()
				if _G.Wait == true then
					return
				end

				_G.Wait = true
				local Target3 = Player(TargetTextBox.Text)
				local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
				wait(1)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("ShoppingCart")
		        wait(1)				
				game:GetService('RunService'):BindToRenderStep("Teleport", 0 , function()
					game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1.6")
					for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA"Tool" and v.Name == "ShoppingCart" then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end					
					
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame + Target3.Character.Humanoid.MoveDirection * 8
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

					if not IsTheTargetSitting(Target3) then
						game:GetService('RunService'):UnbindFromRenderStep("Teleport")
						
						wait(0.5)
						game:GetService('RunService'):BindToRenderStep("Teleport To Void", 0 , function()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
						end)
						wait(0.4)
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
						wait(3)
						game:GetService('RunService'):UnbindFromRenderStep("Teleport To Void")
						
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
						game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1")
						_G.Wait = false
					end
				end)
			end)

			InPage:Button("سحب",function()
				if _G.Wait == true then
					return
				end

				_G.Wait = true
				local Target3 = Player(TargetTextBox.Text)
				local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
				wait(1)
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("ShoppingCart")
		        wait(1)				
				game:GetService('RunService'):BindToRenderStep("Teleport", 0 , function()
					game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1.6")
					for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if v:IsA"Tool" and v.Name == "ShoppingCart" then
							v.Parent = game.Players.LocalPlayer.Character
						end
					end					
					
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame + Target3.Character.Humanoid.MoveDirection * 8
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target3.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)

					if not IsTheTargetSitting(Target3) then
						game:GetService('RunService'):UnbindFromRenderStep("Teleport")
						
						wait(0.5)
						game:GetService('RunService'):BindToRenderStep("Teleport To Void", 0 , function()
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(3265700, 72336392, 17749450))
						end)
						wait(0.4)
						game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")				
						wait(3)
						game:GetService('RunService'):UnbindFromRenderStep("Teleport To Void")
						
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
						game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1")
						_G.Wait = false
					end
				end)
			end)

			InPage:Button("ايقاف القتل / السحب",function()
				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("EquipTool"):FireServer("all")
				game:GetService('RunService'):UnbindFromRenderStep("Teleport")
				game:GetService('RunService'):UnbindFromRenderStep("Teleport To Void")
				local vis = {[1] = ";vis"}
				game:GetService("ReplicatedStorage").HDAdminClient.Signals.RequestCommand:InvokeServer(unpack(vis))	
				game:GetService("ReplicatedStorage").Functions:WaitForChild("ChangeSizeRF"):InvokeServer("1")
				_G.Wait = false
			end)


			InPage:TabFix()
			InPage:TabFix()

			InPage:Toggle("Benx",function(x)
				local TargetV = Player(TargetTextBox.Text)
					Benx = x
					Bang = false
					Suck = false
					HeadSit = false
					FaceBang = false	
					Stand = false			
					repeat task.wait()
						pcall(function()
							local plr = game.Players.LocalPlayer
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.8) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -2.3) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.8) * CFrame.Angles(-1.5,math.rad(0),0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, -1.3) * CFrame.Angles(-1.5,math.rad(0),0)
						end)
					until Benx == false
					if Benx == false then
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
						game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
					end
			end)

			InPage:Toggle("Bang",function(x)
				local TargetV = Player(TargetTextBox.Text)
					bang = x
					Benx = false
					Suck = false
					HeadSit = false
					FaceBang = false	
					Stand = false			
					repeat task.wait()
						pcall(function()
							local plr = game.Players.LocalPlayer
							plr.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 1.3)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 1.8)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 2.3)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 2.8)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 2.3)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 1.8)
							task.wait()
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, 0, 1.3)
						end)
					until bang == false
					if bang == false then
						game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
					end
			end)		

			InPage:Toggle("Face Bang",function(x)
				local TargetV = Player(TargetTextBox.Text)
					bang = false
					Benx = false
					Suck = false
					HeadSit = false
					FaceBang = x	
					Stand = false			
					repeat task.wait()
						pcall(function()
							local plr = game.Players.LocalPlayer
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -1.3) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -1.8) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -2.3) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -2.8) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -2.3) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -1.8) * CFrame.Angles(-0,-3.3,0)
							task.wait()
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 0.5, -1.3) * CFrame.Angles(-0,-3.3,0)
						end)
					until FaceBang == false
					if FaceBang == false then
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
						game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
					end
			end)		

			InPage:Toggle("Suck",function(x)
				local TargetV = Player(TargetTextBox.Text)
					bang = false
					Benx = false
					Suck = x
					HeadSit = false
					FaceBang = false
					Stand = false		
					repeat task.wait()
						pcall(function()
							local plr = game.Players.LocalPlayer
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TargetV.Character.LowerTorso.CFrame * CFrame.new(0, -1, -1.7) * CFrame.Angles(0,-3.3,0)
						end)
					until Suck == false
					if Suck == false then
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
					end
			end)

			InPage:Toggle("Head Sit",function(x)
				local TargetV = Player(TargetTextBox.Text)
					bang = false
					Benx = false
					Suck = false
					HeadSit = x
					FaceBang = false
					Stand = false		
					repeat task.wait()
						pcall(function()
							local plr = game.Players.LocalPlayer
							plr.Character.Humanoid.Sit = true
							plr.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
							plr.Character.HumanoidRootPart.CFrame = TargetV.Character.Head.CFrame * CFrame.new(0, 1.3, 1)
						end)
					until HeadSit == false
					if HeadSit == false then
						game.Players.LocalPlayer.Character.Humanoid.Sit = false
					end
			end)

			InPage:TabFix()
			InPage:TabFix()

		end
		return InPage
	end
	return Pagsee
end


-- بدايه 

local Win = Lib:Win("JanHub - Mm2")
local Home = Win:Tab("الرئيسية",true)
local Game = Win:Tab("الجيم")
local ato = Win:Tab("تلقائي")
local other = Win:Tab("المطورين")







local img = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.UserId .. "&width=420&height=420&format=png"
Home:ImageLabel(img,"مرحباً "..game.Players.LocalPlayer.DisplayName,"@"..game.Players.LocalPlayer.Name)
if game.Players.LocalPlayer.Name == "mjsij1" then
	Home:Info("1.0.2","اونر","تعديل القائمه")
else
	Home:Info("V1","User","nil")
end
Home:TabFix()


Game:Label("- التفعيلات العامة -")


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local isEnabled = false

local function highlightCharacter(player, hasGun, isMurderer)
    if player.Character then
        -- Remove existing highlights and billboards
        for _, child in pairs(player.Character:GetChildren()) do
            if child:IsA("Highlight") or child:IsA("BillboardGui") then
                child:Destroy()
            end
        end

        -- Create Highlight
        local highlight = Instance.new("Highlight")
        highlight.Adornee = player.Character
        if isMurderer then
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 0, 0)
        else
            highlight.FillColor = Color3.new(0, 1, 0)
            highlight.OutlineColor = Color3.new(0, 1, 0)
        end
        highlight.Parent = player.Character

        -- Create BillboardGui
        local billboard = Instance.new("BillboardGui")
        billboard.Adornee = player.Character:FindFirstChild("Head")
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 1, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        if isMurderer then
            nameLabel.TextColor3 = Color3.new(1, 0, 0)
        elseif hasGun then
            nameLabel.TextColor3 = Color3.new(0, 0, 1)
        else
            nameLabel.TextColor3 = Color3.new(0, 1, 0)
        end
        nameLabel.TextScaled = true
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 14
        nameLabel.Parent = billboard
        billboard.Parent = player.Character
    end
end

local function updatePlayerHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local hasGun = player.Backpack:FindFirstChild("Gun") ~= nil
            local isMurderer = player.Backpack:FindFirstChild("Knife") ~= nil
            highlightCharacter(player, hasGun, isMurderer)
        end
    end
end

local function setEnabled(value)
    isEnabled = value
    if isEnabled then
        -- Initial update
        updatePlayerHighlights()

        -- Update periodically
        local updateConnection
        updateConnection = RunService.RenderStepped:Connect(function()
            if not isEnabled then
                updateConnection:Disconnect()
                return
            end
            updatePlayerHighlights()
        end)

        -- Handle new players
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                if isEnabled then
                    local hasGun = player.Backpack:FindFirstChild("Gun") ~= nil
                    local isMurderer = player.Backpack:FindFirstChild("Knife") ~= nil
                    highlightCharacter(player, hasGun, isMurderer)
                end
            end)
        end)
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, child in pairs(player.Character:GetChildren()) do
                    if child:IsA("Highlight") or child:IsA("BillboardGui") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end

Game:Toggle("كشف الاعبين", function(toggle)
    setEnabled(toggle)
end)



Game:Toggle("فلينق للجميع",function(x)
    getgenv().FlingAll = x
    if getgenv().FlingAll == true then
        NotificationLibrary:Notify("تم تفعيل الفلينق", "تم تفعيل الفلينق للجميع بنجاح", 5)  -- العنوان، الوصف، ومدة الإشعار (5 ثواني كمثال)
        local unchar = {[1] = ";unchar"}
        game:GetService("ReplicatedStorage").HDAdminClient.Signals.RequestCommand:InvokeServer(unpack(unchar))
    end
    wait(0.7)
    while getgenv().FlingAll == true do
        wait()
        local players = game:GetService("Players"):GetPlayers()
        if #players > 0 then
            local random = players[math.random(1, #players)]
            FlingPlayer(random.Name)
        end
    end
end)


Game:Toggle("اختراق الجدار",function(x)
	if x == true then
		game:GetService('RunService'):BindToRenderStep("Noclip", 0 , function()
			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA("BasePart") and v.CanCollide == true then
					v.CanCollide = false
				end
			end
		end)
	elseif x == false then
		game:GetService('RunService'):UnbindFromRenderStep("Noclip")
		for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("BasePart") and v.CanCollide == false then
				v.CanCollide = true
			end
		end
	end
end)


Game:Button("قتل لجميع",function()


local Players = game:GetService("Players")
local scriptIdentifier = "ByDevAngel"
local NotificationLibrary = require(game:GetService("ReplicatedStorage"):WaitForChild("NotificationLibrary"))

if scriptIdentifier == "ByDevAngel" then
    for _, player in ipairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local hasKnife = player.Backpack:FindFirstChild("Knife") ~= nil
                    if hasKnife then
                        local currentPosition = humanoidRootPart.CFrame.Position
                        local newPosition = Vector3.new(currentPosition.X, currentPosition.Y + 10, currentPosition.Z)
                        humanoidRootPart.CFrame = CFrame.new(newPosition)
                        NotificationLibrary:Notify("تم تفعيل الموضوع الخاص بنا", "تم تفعيل بنجاح القتل للجميع", 5)
                    else
                        NotificationLibrary:Notify("تنبيه", "لا تملك السكين", 5)
                    end
                else
                    warn("DevAngel: HumanoidRootPart مفقود")
                end
            else
                warn("DevAngel: Humanoid مفقود")
            end
        else
            warn("DevAngel: Character مفقود")
        end
    end
else
    warn("DevAngel: Invalid script identifier")
end

end)

Game:Button("قتل الشرطي", function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local function findPlayersWithGun()
        local playersWithGun = {}

        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                local backpack = player.Backpack
                local gun = backpack and backpack:FindFirstChild("Gun")
                if not gun then
                    gun = character:FindFirstChild("Gun")
                end

                if gun then
                    table.insert(playersWithGun, player)
                end
            end
        end

        return playersWithGun
    end

    local playersWithGun = findPlayersWithGun()

    for _, player in ipairs(playersWithGun) do
        local Target = player
        local humanoidRootPart = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local YEET = Instance.new('BodyThrust')
            YEET.Parent = humanoidRootPart
            YEET.Force = Vector3.new(9999, 9999, 9999)
            YEET.Name = "YEET"
            repeat
                if humanoidRootPart then
                    humanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                    YEET.Location = Target.Character.HumanoidRootPart.Position
                end
                RunService.Heartbeat:Wait()
            until not Target.Character:FindFirstChild("Head")
        end
    end
end)

Game:Button("قتل القاتل", function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local function findPlayersWithKnife()
        local playersWithKnife = {}

        for _, player in pairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                local backpack = player.Backpack
                local knife = backpack and backpack:FindFirstChild("Knife")
                if not knife then
                    knife = character:FindFirstChild("Knife")
                end

                if knife then
                    table.insert(playersWithKnife, player)
                end
            end
        end

        return playersWithKnife
    end

    local playersWithKnife = findPlayersWithKnife()

    for _, player in ipairs(playersWithKnife) do
        local Target = player
        local humanoidRootPart = Target.Character and Target.Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            local YEET = Instance.new('BodyThrust')
            YEET.Parent = humanoidRootPart
            YEET.Force = Vector3.new(9999, 9999, 9999)
            YEET.Name = "YEET"
            repeat
                if humanoidRootPart then
                    humanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
                    YEET.Location = Target.Character.HumanoidRootPart.Position
                end
                RunService.Heartbeat:Wait()
            until not Target.Character:FindFirstChild("Head")
        end
    end
end)


Game:Button("التجسس على المحادثات الخاصة",function()
	Config = {enabled = true,spyOnMyself = true,public = false,publicItalics = true}
	PrivateProperties = {Color = Color3.fromRGB(0,0,0); Font = Enum.Font.SourceSansBold;TextSize = 23;}
	local StarterGui = game:GetService("StarterGui")
	local Players = game:GetService("Players")
	local player = Players.LocalPlayer
	local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
	local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
	local instance = (_G.chatSpyInstance or 0) + 1
	_G.chatSpyInstance = instance

	local function onChatted(p,msg)
		if _G.chatSpyInstance == instance then
			if p==player and msg:lower():sub(1,4)=="/spy" then
				Config.enabled = not Config.enabled
				wait(0.3)
				PrivateProperties.Text = "{SPY "..(Config.enabled and "EN" or "DIS").."ABLED}"
				StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
			elseif Config.enabled and (Config.spyOnMyself==true or p~=player) then
				msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
				local hidden = true
				local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
					if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and Config.public==false and Players[packet.FromSpeaker].Team==player.Team)) then
						hidden = false
					end
				end)
				wait(1)
				conn:Disconnect()
				if hidden and Config.enabled then
					if Config.public then
						saymsg:FireServer((Config.publicItalics and "/me " or '').."{SPY} [".. p.DisplayName .."]: "..msg,"All")
					else
						PrivateProperties.Text = "[".. p.DisplayName .."]: "..msg
						StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
					end
				end
			end
		end
	end
	
	for _,p in ipairs(Players:GetPlayers()) do
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end

	Players.PlayerAdded:Connect(function(p)
		p.Chatted:Connect(function(msg) onChatted(p,msg) end)
	end)

	PrivateProperties.Text = "{SPY "..(Config.enabled and "EN" or "DIS").."ABLED}"
	StarterGui:SetCore("ChatMakeSystemMessage", PrivateProperties)
	local chatFrame = player.PlayerGui.Chat.Frame
	chatFrame.ChatChannelParentFrame.Visible = true
	chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)
end)



Game:Button("دخول سيرفر ثاني",function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end)




Game:Toggle("الليل / النهار",function(x)
	if x == true then
		game:GetService('RunService'):UnbindFromRenderStep("number 14")
		game:GetService('RunService'):BindToRenderStep("number 0", 0 , function()
			game:GetService("Lighting").ClockTime = 0
		end)
	else
		game:GetService('RunService'):UnbindFromRenderStep("number 0")
		game:GetService('RunService'):BindToRenderStep("number 14", 0 , function()
			game:GetService("Lighting").ClockTime = 14
		end)
	end
end)


local teleportEnabled = false
local tweenInProgress = false

local TweenService = game:GetService("TweenService")
local CoinContainer = game:GetService("Workspace").Normal.CoinContainer
local player = game.Players.LocalPlayer

local function getClosestCoin()
    local closestCoin = nil
    local closestDistance = math.huge

    for _, coin in pairs(CoinContainer:GetChildren()) do
        if coin.Name == "Coin_Server" and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - coin.Position).Magnitude
            if distance < closestDistance then
                closestCoin = coin
                closestDistance = distance
            end
        end
    end

    return closestCoin
end

local function teleportToCoin(coin)
    if coin and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = coin.Position
        local tweenInfo = TweenInfo.new(
            0.05,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )

        local goal = {CFrame = CFrame.new(targetPosition)}

        local tween = TweenService:Create(player.Character.HumanoidRootPart, tweenInfo, goal)
        tweenInProgress = true
        tween:Play()
        tween.Completed:Connect(function()
            tweenInProgress = false
        end)
    end
end

-- Function to continuously teleport to the closest coin while teleportEnabled is true
local function loopTeleport()
    while teleportEnabled do
        local closestCoin = getClosestCoin()
        if closestCoin then
            teleportToCoin(closestCoin)
        end
        wait(1) -- Adjust the interval between teleports as needed
    end
end

ato:Toggle("تجميع الكوين",function(state)
    teleportEnabled = state
    if teleportEnabled then
        print("Teleport enabled")
        -- Start the loop when toggle is enabled
        loopTeleport()
    else
        print("Teleport disabled")
    end
end)




other:ImageLabel("https://www.roblox.com/headshot-thumbnail/image?userId=1847542223&width=420&height=420&format=png","N0kia","Scripter / Ui Designer")
other:ImageLabel("https://www.roblox.com/headshot-thumbnail/image?userId=1259903042&width=420&height=420&format=png","Angel","Scripter / Ui Designer")
other:ImageLabel("https://www.roblox.com/headshot-thumbnail/image?userId=5680941698&width=420&height=420&format=png","itznanos","Scripter")

other:TabFix()

local cool = {
    4334994690,
	12982577,
	3933568115,
	5680941698
}

coroutine.resume(coroutine.create(function()
    while wait(6) do
		local success, err = pcall(function()
			for i,v in pairs(game.Players:GetChildren()) do
				if v.Character then
					if table.find(cool,v.UserId) then
						v.Character.Humanoid.DisplayName = "[👑]"..v.DisplayName
					end
				end
			end
		end)
    end
end))




