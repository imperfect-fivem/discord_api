local function init()
    ---@type DiscordAPI, MetaTableMap
    local api, metatables = exports['discord_api']:initials()
    for key, metatable in pairs(metatables) do
        local target = api
        for subKey in key:gmatch("([^_]+)") do
            target = target[subKey]
            if target == nil then goto skip end
        end
        for key, value in pairs(metatable) do
            if value.__cfx_functionReference then
                metatable[key] = function(...) return value(...) end
            end
        end
        setmetatable(target, metatable)
        ::skip::
    end
    DiscordAPI = api
end

local functionalities = { alive = {}, dead = {} }

---@param global string
---@param dead function
function DiscordDeadFunctionality(global, dead)
    functionalities.alive[global] = _ENV[global]
    functionalities.dead[global] = dead
end

if
    GetResourceState('discord_api') == 'started' or
    GetCurrentResourceName() == 'discord_api'
then
    init()
end

---@param bool boolean
local function toggleFunctionality(bool)
    for name, functionality in pairs(functionalities[bool and 'alive' or 'dead']) do
        _ENV[name] = functionality
    end
end

AddEventHandler('discord_api:alive', function(initTime)
    if DiscordAPI and DiscordAPI.InitTime == initTime then return end
    init()
    toggleFunctionality(true)
end)

AddEventHandler('discord_api:dead', function(reset)
    if reset then DiscordAPI = nil end
    toggleFunctionality(false)
end)

---@param player number
---@return string?
function GetPlayerDiscordId(player)
    local identifier = GetPlayerIdentifierByType(player --[[@as string]], 'discord')
    if identifier then
        return identifier:match('discord:(.+)')
    end
end
