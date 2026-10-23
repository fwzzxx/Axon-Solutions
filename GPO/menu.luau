-- local config = {
--     place_id = 1730877806,
--     private_server_code = "C5zkfmLgEv",
--     mode = true, -- Regular: true; others: "tradeHub", "fishHub", "universeHub".
--     sea = "Second Sea", -- "First Sea" or "Second Sea".
-- };
local config = getfenv().config or {};
if game.PlaceId ~= config.place_id then
    return;
end;

if not game:IsLoaded() then
    game.Loaded:Wait();
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local player = Players.LocalPlayer;
local gui = player:WaitForChild("PlayerGui");
local reserved = ReplicatedStorage:WaitForChild("Events"):WaitForChild("reserved");

task.spawn(reserved.InvokeServer, reserved, config.private_server_code);

local selection = gui:WaitForChild("chooseType"):WaitForChild("Frame"):WaitForChild("RemoteEvent");
selection:FireServer(config.mode);

if config.mode == true then
    local confirmation = gui:WaitForChild("ConfirmationPrompt"):WaitForChild("RemoteEvent");
    confirmation:FireServer(config.sea);
end;
