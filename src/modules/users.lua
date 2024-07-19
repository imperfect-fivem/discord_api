DiscordAPI.Users = {}

MetaTables.Users = {
    __index = function(self, key)
        if key == 'Me' then
            -- TODO: cache
            local status, data = DiscordAPI.Request('GET', '/users/@me')
            local reason
            if status == 200 then
                return data
            elseif status == 401 then
                reason = 'invalid token'
            else
                reason = DiscordAPI.ErrorReasons[status]
            end
            print('\27[30;41m Authorization \27[0;31m Failed, \27[33m' .. reason .. '\27[31m.\27[0m')
        end
    end
}
