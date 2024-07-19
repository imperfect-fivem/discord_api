---@type MetaTableMap
MetaTables = {
    _ = {
        __index = function (self, key)
            if key == 'Token' then
                return GetConvar('discord_bot_token', 'unset')
            elseif key == 'ServerId' then
                return GetConvar('discord_server_id', 'unset')
            end
        end
    },
    ErrorReasons = {
        __index = function (self, status)
            return 'unhandled situation [' .. tostring(status) .. ']'
        end
    }
}

DiscordAPI = {}

DiscordAPI.ErrorReasons = setmetatable({
    [400] = "request was malformed",
    [401] = 'unauthorized',
    [403] = 'missing permissions',
    [429] = 'reached limit (https://discord.com/developers/docs/topics/rate-limits)'
}, MetaTables.ErrorReasons)

---@type DiscordAPIRequest
function DiscordAPI.Request(method, endpoint, content, reason)
    local result = promise:new()
    local headers = { ["Content-Type"] = "application/json", ["Authorization"] = 'Bot ' .. DiscordAPI.Token }
    if type(content) == 'string' then headers["X-Audit-Log-Reason"] = reason end
    local body = type(content) == 'table' and json.encode(content) or ""
    PerformHttpRequest("https://discord.com/api/v10" .. endpoint, function(...)
        local results = { ... }
        results[2] = json.decode(results[2])
        result:resolve(results)
    end, method, body, headers)
    return table.unpack(Citizen.Await(result))
end

exports('initials', function ()
    return DiscordAPI, MetaTables
end)
