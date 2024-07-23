---@alias MetaTableMap table<string, metatable>
---@type MetaTableMap
MetaTables = {
    _ = {
        __index = function(self, key)
            if key == 'CacheTimeout' then
                return GetConvarInt('discord_bot_token', 6e4)
            elseif key == 'Token' then
                return GetConvar('discord_bot_token', 'unset')
            elseif key == 'ServerId' then
                return GetConvar('discord_server_id', 'unset')
            end
        end
    },
    ErrorReasons = {
        __index = function(self, status)
            return 'unhandled situation [' .. tostring(status) .. ']'
        end
    }
}

---@class DiscordAPI
---@field InitTime integer
---@field ReachedLimit boolean
---@field CacheTimeout integer
---@field Token string
---@field ServerId string
---@field Request function
---@field ErrorReasons table<integer, string>
---@field Users DiscordAPIUsers
---@field Servers DiscordAPIServers
DiscordAPI = { InitTime = GetGameTimer(), ReachedLimit = false }

DiscordAPI.ErrorReasons = setmetatable({
    [400] = "request was malformed",
    [401] = 'unauthorized',
    [403] = 'missing permissions',
    [429] = 'reached limit (https://discord.com/developers/docs/topics/rate-limits)',
    [444] = 'local api is dead'
}, MetaTables.ErrorReasons)

---@type table<promise, string>
local requests = {}

---@param reset boolean
local function killAPI(reset)
    for result in pairs(requests) do
        result:resolve({ 444, {}, {} })
    end
    TriggerEvent('discord_api:dead', reset)
end

---@param method 'DELETE'|'GET'|'HEAD'|'POST'|'PUT'
---@param endpoint string
---@param content? table
---@param reason? string
---@return integer status, table response, table<string, string> headers
function DiscordAPI.Request(method, endpoint, content, reason)
    local result = promise:new()
    local headers = { ["Content-Type"] = "application/json", ["Authorization"] = 'Bot ' .. DiscordAPI.Token }
    if type(content) == 'string' then headers["X-Audit-Log-Reason"] = reason end
    local body = type(content) == 'table' and json.encode(content) or ""
    requests[result] = GetInvokingResource()
    PerformHttpRequest("https://discord.com/api/v10" .. endpoint, function(status, responseBody, responseHeaders)
        requests[result] = nil
        responseBody = json.decode(responseBody)
        result:resolve({ status, responseBody, responseHeaders })
        if (responseHeaders['X-RateLimit-Remaining'] == '0' or status == 429) and not DiscordAPI.ReachedLimit then
            DiscordAPI.ReachedLimit = true
            killAPI(false)
            local resetSeconds = tonumber(responseHeaders['X-RateLimit-Reset-After']) or 30
            print(('\27[30;41m Rete Limit \27[0;31m Reached limited,\27[33m available again in %s minutes\27[31m.\27[0m'):format(math.ceil(resetSeconds / 60)))
            SetTimeout(resetSeconds * 1e3, function()
                DiscordAPI.ReachedLimit = false
                TriggerEvent('discord_api:alive', DiscordAPI.InitTime)
            end)
        end
    end, method, body, headers)
    return table.unpack(Citizen.Await(result))
end

exports('initials', function()
    return DiscordAPI, MetaTables
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= 'discord_api' then return end
    killAPI(true)
end)

CreateThread(function()
    TriggerEvent('discord_api:alive', DiscordAPI.InitTime)
end)
