---@class DiscordAPI.Webhooks.ExecuteParams
---@field content? string
---@field username? string
---@field avatar_url? string
---@field tts? boolean
---@field embeds? DiscordAPI.Embeds.Structure[]
---@field allowed_mentions? table
---@field flags? integer
---@field thread_name? string
---@field applied_tags? string[]
---@field poll? table
---@source https://discord.com/developers/docs/resources/webhook#execute-webhook-jsonform-params -- TODO: complete

---@class DiscordAPI.Webhooks
DiscordAPI.Webhooks = {}

---@param url string
---@param params DiscordAPI.Webhooks.ExecuteParams
function DiscordAPI.Webhooks.Execute(url, params)
    PerformHttpRequest(url, function() end, 'POST', json.encode(params), { ['Content-Type'] = 'application/json' })
end
