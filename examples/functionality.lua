IsDiscordAPIAvailable = GetResourceState('discord_api') ~= 'missing'

function GetPlayerDiscordRoles(player)
    local playerDiscordId, discordMember = GetPlayerDiscordId(player)
    local discordServer = DiscordAPI.Servers.Main
    if not discordServer then return {} end
    if playerDiscordId then discordMember = DiscordAPI.Servers.FetchMember(discordServer, playerDiscordId) end
    if not discordMember then return {} end
    return discordMember.roles
end

if IsDiscordAPIAvailable then
    _ = DiscordAliveFunctionality + 'GetPlayerDiscordRoles'
    DiscordDeadFunctionality.GetPlayerDiscordRoles = function() return {} end
else
    GetPlayerDiscordRoles = function() return {} end
    print("discord_api is missing, discord actions won't function.")
end
