local QBCore = exports['qb-core']:GetCoreObject()
CreateThread(function()
    while true do
        Wait(1000)
        local playerData = QBCore.Functions.GetPlayerData()
        if playerData and playerData.money then
            local cash = playerData.money["cash"] or 0
            local bank = playerData.money["bank"] or 0
            print("Cash: " .. cash .. " Bank: " .. bank)
            SendNUIMessage({
                action = "updateMoney",
                cash = cash,
                bank = bank
            })
        else
            print("Error: Player data not found!")
        end
		TriggerServerEvent('ds-hud:getJobData')
    end
end)
RegisterNetEvent('ds-hud:updateJobData')
AddEventHandler('ds-hud:updateJobData', function(job, grade)
    SendNUIMessage({
        action = "updateJob",
        job = job,
        grade = grade
    })
end)
