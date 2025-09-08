-- Infinite Jump Advanced LocalScript

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local jumpEnabled = false  -- Toggle for infinite jump

-- Optional: You can set a keybind for toggling infinite jump
local toggleKey = Enum.KeyCode.J -- Change as needed

-- To handle character respawn
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
end)

-- Listen for key press to toggle infinite jump
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == toggleKey then
        jumpEnabled = not jumpEnabled
        if jumpEnabled then
            print("Infinite Jump Enabled")
        else
            print("Infinite Jump Disabled")
        end
    end
end)

-- Prevent fall damage or other issues if needed
-- Make sure the humanoid is not set to "Jump" normally
-- but we'll override jump behavior here

-- Use RunService to constantly reset humanoid's JumpPower or State
RunService.Stepped:Connect(function()
    if jumpEnabled then
        -- Force humanoid to be in jumping state if key is pressed
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            -- This ensures the humanoid can jump repeatedly
            humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
            humanoid.Jump = true
        end
    end
end)