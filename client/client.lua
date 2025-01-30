local QBCore = nil
local ESX = nil
local cash = nil
local bank = nil
CreateThread(function()
    if GetResourceState('qb-core') == 'started' then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif GetResourceState('es_extended') == 'started' then
        ESX = exports['es_extended']:getSharedObject()
    else
        print("Error: ESX or QB is not running please check framework!")
        return
    end

    while true do
        Wait(1000)
        local playerData = nil
        if QBCore then
            playerData = QBCore.Functions.GetPlayerData()
        elseif ESX then
            ESX.TriggerServerCallback('esx:getPlayerData', function(data)
                playerData = data
            end)
            Wait(500)
        end

        if playerData and QBCore then
            cash = playerData.money["cash"] or 0
            bank = playerData.money["bank"] or 0
            SendNUIMessage({
                action = "updateMoney",
                cash = cash,
                bank = bank
            })
        elseif playerData and ESX then
            TriggerServerEvent('ds-hud:getPlayerMoney', "bank")
            TriggerServerEvent('ds-hud:getPlayerMoney', "money")
            
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
RegisterNetEvent('ds-hud:receiveMoney')
AddEventHandler('ds-hud:receiveMoney', function(account, money)

    if account == "bank" then
        bank = money
    elseif account == "money" then
        cash = money
    else
        print("Not a valid account")
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
