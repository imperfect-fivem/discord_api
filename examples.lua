local bot = DiscordAPI.Users.Me
print("Bot's Username: ", bot.username)

local server = DiscordAPI.Servers.Main
print("Main Server Name: ", server.name)

local botMember = DiscordAPI.Servers.FetchMember(server, bot.id)
if botMember then
    print("Bot Roles:- ")
    for _, role in ipairs(botMember.roles) do
        print(role)
    end
end
