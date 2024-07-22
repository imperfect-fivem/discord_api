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

---@alias FunctionsMap table<string, function>
---@type { Alive: FunctionsMap, Dead: FunctionsMap }
DiscordFunctionality = {
    Alive = setmetatable({}, {
        __add = function(self, name)
            self[name] = _G[name]
        end
    }),
    Dead = setmetatable({}, {
        __newindex = function(self, name, functionality)
            rawset(self, name, functionality)
            if not DiscordAPI then
                _G[name] = functionality
            end
        end
    })
}

if
    GetResourceState('discord_api') == 'started' or
    GetCurrentResourceName() == 'discord_api'
then
    init()
end

---@param bool boolean
local function toggleFunctionality(bool)
    local state = bool and 'Alive' or 'Dead'
    if DiscordFunctionality and DiscordFunctionality[state] then
        for name, functionality in pairs(DiscordFunctionality[state]) do
            _G[name] = functionality
        end
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

---@param playerSrc string
---@return string?
function GetPlayerDiscordId(playerSrc)
    local identifier = GetPlayerIdentifierByType(playerSrc, 'discord')
    if identifier then
        return identifier:match('discord:(.+)')
    end
end
