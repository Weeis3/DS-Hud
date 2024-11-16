local QBCore = exports['qb-core']:GetCoreObject()
RegisterNetEvent('ds-hud:getJobData')
AddEventHandler('ds-hud:getJobData', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local job = Player.PlayerData.job.label
    local grade = Player.PlayerData.job.grade.name
    TriggerClientEvent('ds-hud:updateJobData', src, job, grade)
end)
