local LoadedGui = nil

local CC = {}

function CC.Inject()
	if game:GetService("CoreGui"):FindFirstChild("Commands") then
		game:GetService("CoreGui"):FindFirstChild("Commands"):Destroy()
	end

	local Commands = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local CommandHoldingFrame = Instance.new("ScrollingFrame")
	local UIGridLayout = Instance.new("UIGridLayout")
	local SearchBar = Instance.new("TextBox")
	local Title = Instance.new("TextButton")
	local Demo = Instance.new("TextButton")

	--Properties:

	Commands.Name = "Commands"
	Commands.Parent = game:GetService("CoreGui")
	Commands.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Commands.IgnoreGuiInset = true
	
	LoadedGui = Commands
	
	Frame.Parent = Commands
	Frame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(0.902999997, 0, 0.76744628, 0)
	Frame.Size = UDim2.new(0.0930811316, 0, 0.231968805, 0)

	CommandHoldingFrame.Name = "CommandHoldingFrame"
	CommandHoldingFrame.Parent = Frame
	CommandHoldingFrame.Active = true
	CommandHoldingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	CommandHoldingFrame.BackgroundTransparency = 1.000
	CommandHoldingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	CommandHoldingFrame.BorderSizePixel = 0
	CommandHoldingFrame.Size = UDim2.new(1, 0, 0.970588207, 0)

	UIGridLayout.Parent = CommandHoldingFrame
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0.0149999997, 0)
	UIGridLayout.CellSize = UDim2.new(0.930000007, 0, 0.0590000004, 0)

	SearchBar.Name = "SearchBar"
	SearchBar.Parent = Frame
	SearchBar.BackgroundColor3 = Color3.fromRGB(86, 86, 86)
	SearchBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBar.BorderSizePixel = 0
	SearchBar.Size = UDim2.new(1, 0, -0.0920000002, 0)
	SearchBar.ClearTextOnFocus = false
	SearchBar.Font = Enum.Font.SourceSans
	SearchBar.Text = ""
	SearchBar.TextColor3 = Color3.fromRGB(0, 0, 0)
	SearchBar.TextSize = 14.000

	Title.Name = "Title"
	Title.Parent = Frame
	Title.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
	Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title.BorderSizePixel = 0
	Title.Position = UDim2.new(0, 0, -0.0920000002, 0)
	Title.Size = UDim2.new(1, 0, -0.0920000002, 0)
	Title.Font = Enum.Font.SourceSans
	Title.TextColor3 = Color3.fromRGB(0, 0, 0)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true

	Demo.Name = "Demo"
	Demo.Parent = Commands
	Demo.BackgroundColor3 = Color3.fromRGB(61, 61, 61)
	Demo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Demo.BorderSizePixel = 0
	Demo.Size = UDim2.new(0.930481255, 0, 0.0588235296, 0)
	Demo.Visible = false
	Demo.Font = Enum.Font.SourceSans
	Demo.Text = "{Command Info}"
	Demo.TextColor3 = Color3.fromRGB(0, 0, 0)
	Demo.TextScaled = true
	Demo.TextSize = 14.000
	Demo.TextWrapped = true

	-- Scripts:

	local function AUTFTMN_fake_script() -- SearchBar.SearchScript 
		local script = Instance.new('Script', SearchBar)

		local Holder = script.Parent.Parent.CommandHoldingFrame

		local BlockList = {
			"",
			" ",
			"  "
		}

		local DISABLE = false

		while wait(0.1) do
			for i, cmd in pairs(Holder:GetChildren()) do
				if cmd:IsA("TextButton") then
					DISABLE = false
					local s = cmd.Name
					s = string.lower(s)

					local d = script.Parent.Text
					d = string.lower(d)

					for i, v in pairs(BlockList) do
						if d == v then
							DISABLE = true
						end
					end

					if DISABLE then
						cmd.Visible = true
					else
						if s:find(d) then
							cmd.Visible = true
						else
							cmd.Visible = false
						end
					end
				end
			end
		end
	end
	coroutine.wrap(AUTFTMN_fake_script)()
	local function CFXYT_fake_script() -- Title.Script 
		local script = Instance.new('Script', Title)

		local ts = game:GetService("TweenService")

		local frame = script.Parent.Parent

		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0)

		local function close()
			local tween = ts:Create(frame, tweenInfo, {Position = UDim2.new(0.903, 0, 1.02, 0)})
			tween:Play()
		end

		local function Open()
			local tween = ts:Create(frame, tweenInfo, {Position = UDim2.new(0.903, 0,0.767, 0)})
			tween:Play()
		end

		local opened = false
		local CD = false

		script.Parent.MouseButton1Click:Connect(function()
			if CD then
			else
				opened = not opened
				CD = true

				if opened then
					Open()
				else
					close()
				end

				task.wait(1)

				CD = false
			end
		end)
	end
	coroutine.wrap(CFXYT_fake_script)()

end

function CC.AddCommand(Name, Func)
	if LoadedGui and Name and Func then
		local Clone = LoadedGui.Frame.Demo:Clone()
		Clone.Name = Name
		Clone.Parent = LoadedGui.Frame.CommandHoldingFrame
		Clone.Text = Name
		
		Clone.MouseButton1Click:Connect(function()
			local success, err = pcall(Func)
			if not success then warn("Error in command '" .. Name .. "':", err) end
		end)
	end
end

return CC
