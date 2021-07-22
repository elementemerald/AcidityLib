local library = {};
local CoreGui = game:GetService("CoreGui");

if CoreGui:FindFirstChild("ACIDITYLIB") then
    CoreGui.ACIDITYLIB:Destroy();
end;

local UserInputService = game:GetService("UserInputService");

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
    LibUIWindow.BorderSizePixel = 0;
    LibUIWindow.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
    LibUIWindow.Position = UDim2.fromOffset(100, 20);
    LibUIWindow.Size = UDim2.fromOffset(207, 33);
    LibUIWindow.Active = true;
    LibUIWindow.Parent = LibUI;

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
end;

return library;