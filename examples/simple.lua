local bot = DiscordAPI.Users.Me
if not bot then return end
print("Bot's Username: ", bot.username)

local server = DiscordAPI.Servers.Main
if not server then return end
print("Main Server Name: ", server.name)

local botMember = DiscordAPI.Servers.FetchMember(server, bot.id)
if not botMember then return end
print("Bot Roles:- ")
for _, role in ipairs(botMember.roles) do
    print(role)
end
