RegisterNetEvent('ds-hud:getPlayerMoney')
AddEventHandler('ds-hud:getPlayerMoney', function(account)
    local src = source
    if GetResourceState('qb-core') == 'started' then
        print("This is not a QBCore function please dont use this")
        return
    elseif GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            local amount = xPlayer.getAccount(account).money
            TriggerClientEvent('ds-hud:receiveMoney', src, account, amount)
        end
    else
        print("No valid framework detected please use ESX or QBCORE")
    end
end)
RegisterNetEvent('ds-hud:getJobData')
AddEventHandler('ds-hud:getJobData', function()
    local src = source
    local job, grade
    if GetResourceState('qb-core') == 'started' then
        local QBCore = exports['qb-core']:GetCoreObject()
        local Player = QBCore.Functions.GetPlayer(src)
        job = Player.PlayerData.job.label
        grade = Player.PlayerData.job.grade.name
    elseif GetResourceState('es_extended') == 'started' then
        local ESX = exports['es_extended']:getSharedObject()
        local xPlayer = ESX.GetPlayerFromId(src)
        job = xPlayer.job.label
        grade = xPlayer.job.grade_name
    end

    TriggerClientEvent('ds-hud:updateJobData', src, job, grade)
end)
