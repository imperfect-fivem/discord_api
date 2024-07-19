CreateThread(function()
    local bot = DiscordAPI.Users.Me
    if not bot then return end
    print('\27[30;42m Authorization \27[0;32m Username: \27[35m' .. bot.username .. '\27[0m')
    local server = DiscordAPI.Servers.Main
    if not server then return end
    print('\27[30;42m Main Server \27[0;32m Name: \27[35m' .. server.name .. '\27[0m')
end)
