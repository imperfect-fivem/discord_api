DiscordAPI.Servers = {}

MetaTables.Servers = {
    __index = function(self, key)
        if key == 'Main' then
            local status, data = DiscordAPI.Request('GET', '/guilds/' .. DiscordAPI.ServerId)
            local reason
            if status == 200 then
                return data
            elseif status == 404 then
                reason = 'invalid id'
            else
                reason = DiscordAPI.ErrorReasons[status]
            end
            print('\27[30;41m Main Server \27[0;31m Not found, \27[33m' .. reason .. '\27[31m.\27[0m')
        end
    end
}

---@type DiscordAPIFetchGuildMember
function DiscordAPI.Servers.FetchMember(raw, memberId)
    local status, data = DiscordAPI.Request('GET', '/guilds/' .. raw.id .. '/members/' .. memberId)
    local reason
    if status == 200 then
        return data
    elseif status == 404 then
        reason = 'not joined to the server'
    else
        reason = DiscordAPI.ErrorReasons[status]
    end
    print('\27[30;41m Member \27[0;31m Not found, \27[33m' .. reason .. '\27[31m.\27[0m')
end
