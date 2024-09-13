---@class DiscordAPI.Embeds.Structure.Footer
---@field text string
---@field icon_url? string
---@field proxy_icon_url? string
---@class DiscordAPI.Embeds.Structure.Image
---@field url string
---@field proxy_url? string
---@field height? integer
---@field width? integer
---@class DiscordAPI.Embeds.Structure.Thumbnail
---@field url string
---@field proxy_url? string
---@field height? integer
---@field width? integer
---@class DiscordAPI.Embeds.Structure.Video
---@field url string
---@field proxy_url? string
---@field height? integer
---@field width? integer
---@class DiscordAPI.Embeds.Structure.Provider
---@field name? string
---@field url? string
---@class DiscordAPI.Embeds.Structure.Author
---@field name string
---@field url? string
---@field icon_url? string
---@field proxy_icon_url? string
---@class DiscordAPI.Embeds.Structure.Field
---@field name string
---@field value string
---@field inline? boolean
---@class DiscordAPI.Embeds.Structure
---@field title? string
---@field type? string
---@field description? string
---@field url? string
---@field timestamp? string ISO8601
---@field color? integer
---@field footer? DiscordAPI.Embeds.Structure.Footer
---@field image? DiscordAPI.Embeds.Structure.Image
---@field thumbnail? DiscordAPI.Embeds.Structure.Thumbnail
---@field video? DiscordAPI.Embeds.Structure.Video
---@field provider? DiscordAPI.Embeds.Structure.Provider
---@field author? DiscordAPI.Embeds.Structure.Author
---@field fields? DiscordAPI.Embeds.Structure.Field[]