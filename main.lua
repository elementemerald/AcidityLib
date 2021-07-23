local library = {};
local CoreGui = game:GetService("CoreGui");

if CoreGui:FindFirstChild("ACIDITYLIB") then
    CoreGui.ACIDITYLIB:Destroy();
end;

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");

local Players = game:GetService("Players");
local LocalPlayer = Players.LocalPlayer;

local LibUI = Instance.new("ScreenGui");
LibUI.Name = "ACIDITYLIB";

if syn and syn.protect_gui then
    syn.protect_gui(LibUI);
end;

LibUI.Parent = CoreGui;

function library:Destroy()
    LibUI:Destroy();
end;

function library:Window(name)
    local LibUIWindow = Instance.new("Frame");
    LibUIWindow.Name = "ACIDITYLIB_WINDOW_" ..name;
    LibUIWindow.AnchorPoint = Vector2.new(0.5, 0.5);
    LibUIWindow.BackgroundColor3 = Color3.fromRGB(45, 45, 45);
    LibUIWindow.Position = UDim2.fromScale(0.5, 0.5);
    LibUIWindow.Size = UDim2.fromOffset(700, 400);
    LibUIWindow.Active = true;
    LibUIWindow.Parent = LibUI;
    
    local LibUIWindowCorner = Instance.new("UICorner");
    LibUIWindowCorner.CornerRadius = UDim.new(0, 7);
    LibUIWindowCorner.Parent = LibUIWindow;
    
    local LibUIWindowLabel = Instance.new("TextLabel");
    LibUIWindowLabel.Name = "ACIDITYLIB_WINDOW_" ..name .."_LABEL";
    LibUIWindowLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    LibUIWindowLabel.Position = UDim2.fromScale(0.5, 0.5);
    LibUIWindowLabel.Font = Enum.Font.RobotoCondensed;
    LibUIWindowLabel.TextSize = 15;
    LibUIWindowLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    LibUIWindowLabel.Text = name;
    LibUIWindowLabel.Parent = LibUIWindow;
    
    local LibUIWindowShowHide = Instance.new("TextButton");
    LibUIWindowShowHide.Name = "ACIDITYLIB_WINDOW_" ..name .."_SHOWHIDE";
    LibUIWindowShowHide.TextSize = 12;
    LibUIWindowShowHide.TextColor3 = Color3.fromRGB(255, 255, 255);
    LibUIWindowShowHide.Text = "▼";
    LibUIWindowShowHide.Position = UDim2.fromOffset(10, 10);
    LibUIWindowShowHide.Parent = LibUIWindow;
    
    LibUIWindowShowHide.MouseButton1Click:Connect(function()
        print("ok");
        if LibUIWindow.Size.X.Offset == 700 and LibUIWindow.Size.Y.Offset == 400 then
            TweenService:Create(LibUIWindow, TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(0, 0)
            }):Play();
        else
            TweenService:Create(LibUIWindow, TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(700, 400)
            }):Play();
        end;
    end);

    coroutine.resume(coroutine.create(function()
        local dragging = false;
        local dragInput;
        local dragStart;
        local startPos;
    
        LibUIWindow.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true;
                dragStart = input.Position;
                startPos = LibUIWindow.Position;

                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false;
                    end;
                end);
            end;
        end);

        LibUIWindow.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input;
            end;
        end);

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local Delta = input.Position - dragStart;
                LibUIWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y);
            end;
        end);
    end));

    local WindowFields = {};
    WindowFields.Instance = LibUIWindow;

    function WindowFields:Open()
        TweenService:Create(LibUIWindow, TweenInfo.new(), {
            Size = UDim2.fromOffset(700, 400)
        }):Play();
    end;

    function WindowFields:Close()
        TweenService:Create(LibUIWindow, TweenInfo.new(1.0, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Size = UDim2.fromOffset(0, 0)
        }):Play();
    end;

    function WindowFields:Tab(name)
        local LibUIWindowTab = Instance.new("Frame");
        LibUIWindowTab.Name = "ACIDITYLIB_TAB_" ..name;
        LibUIWindowTab.BorderSizePixel = 0;
    end;

    return WindowFields;
end;

return library;