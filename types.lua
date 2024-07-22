---@meta DiscordAPI

---@alias MetaTableMap table<string, metatable>

---@class RawDiscordUser
---@field id string
---@field username string
---@source https://discord.com/developers/docs/resources/user#user-object -- TODO: complete

---@class RawDiscordRole
---@field id string
---@field name string
---@source https://discord.com/developers/docs/topics/permissions#role-object -- TODO: complete

---@class RawDiscordGuildMember
---@field roles string[]
---@field user RawDiscordUser
---@source https://discord.com/developers/docs/resources/guild#guild-member-object -- TODO: complete

---@class DiscordAPIUsers
---@field Me? RawDiscordUser

---@class RawDiscordServer
---@field id string
---@field name string
---@source https://discord.com/developers/docs/resources/guild#guild-object -- TODO: complete

---@alias DiscordAPIFetchGuildMember fun(raw: RawDiscordServer, memberId: string): RawDiscordGuildMember?

---@class DiscordAPIServers
---@field Main? RawDiscordServer
---@field FetchMember DiscordAPIFetchGuildMember

---@alias DiscordRequestMethod 'GET' | 'HEAD' | 'POST' | 'PUT' | 'DELETE'
---@alias DiscordAPIRequest fun(method: DiscordRequestMethod, endpoint: string, content?: table, reason?: string): integer, table, table<string, string>

---@class DiscordAPI
---@field InitTime integer
---@field ReachedLimit boolean
---@field Token string
---@field ServerId string
---@field Request DiscordAPIRequest
---@field Users DiscordAPIUsers
---@field Servers DiscordAPIServers
