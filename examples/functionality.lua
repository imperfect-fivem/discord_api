function GetPlayerDiscordRoles(playerSrc)
    local playerDiscordId, discordMember = GetPlayerDiscordId(playerSrc)
    local discordServer = DiscordAPI.Servers.Main
    if not discordServer then return {} end
    if playerDiscordId then discordMember = DiscordAPI.Servers.FetchMember(discordServer, playerDiscordId) end
    if not discordMember then return {} end
    return discordMember.roles
end

_ = DiscordFunctionality.Alive + 'GetPlayerDiscordRoles'
DiscordFunctionality.Dead.GetPlayerDiscordRoles = function() return {} end
