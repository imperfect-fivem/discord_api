function GetPlayerDiscordRoles(player)
    local playerDiscordId, discordMember = GetPlayerDiscordId(player)
    local discordServer = DiscordAPI.Servers.Main
    if not discordServer then return {} end
    if playerDiscordId then discordMember = DiscordAPI.Servers.FetchMember(discordServer, playerDiscordId) end
    if not discordMember then return {} end
    return discordMember.roles
end

if not DiscordDeadFunctionality then
    print("^3discord_api^1 is missing, discord actions won't function.^7")
    DiscordDeadFunctionality = setmetatable({}, { __call = function(_, global, dead) _ENV[global] = dead end })
end

DiscordDeadFunctionality('GetPlayerDiscordRoles', function() return {} end)
