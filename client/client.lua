

local npcModel = "s_m_m_strpreach_01"  -- NPC model (you can replace it with another valid model)
local npcPosition = vector3(-123.45, 678.90, 45.67)  -- NPC spawn position

-- Create the NPC
local npcPed = nil

local isPedSpawned = false
local interacting = false

Citizen.CreateThread(function()
    while isPedSpawned == false do
        RequestModel(npcModel)
        while not HasModelLoaded(npcModel) do
            Wait(500)
        end
    
        npcPed = CreatePed(4, npcModel, npcPosition.x, npcPosition.y, npcPosition.z, 0.0, false, false)
        TaskStandStill(npcPed, -1)

        isPedSpawned = true
        Wait(5000)
    end
end)

RegisterKeyMapping("interact", "Browse the General Store", "keyboard", "e")

RegisterCommand("interact", function()
    while true do
        Citizen.Wait(0)
        if not interacting then
            local playerPos = GetEntityCoords(PlayerPedId(), false)
            local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, npcPosition.x, npcPosition.y, npcPosition.z)

            if distance < 2.0 then
                -- Perform your interaction logic here

                -- For example, you can print a message to the console
                print("Player interacted with the NPC.")

                -- Reset the interaction state
                interacting = false
            end
        end
    end
end, false)
