---@meta DiscordAPI

---@alias MetaTableMap table<string, metatable>

---@class DiscordAPI
---@field InitTime integer
---@field ReachedLimit boolean
---@field Token string
---@field ServerId string
---@field Request function
---@field ErrorReasons table<integer, string>
---@field Users DiscordAPIUsers
---@field Servers DiscordAPIServers

---@class DiscordAliveFunctionality
---@field [string] function
---@operator add(string): boolean

---@class DiscordDeadFunctionality
---@field [string] function

---@param method 'DELETE'|'GET'|'HEAD'|'POST'|'PUT'
---@param endpoint string
---@param content? table
---@param reason? string
---@return integer status, table response, table<string, string> headers
function DiscordAPI.Request(method, endpoint, content, reason) end

---@class RawDiscordUser
---@field id string
---@field username string
---@source https://discord.com/developers/docs/resources/user#user-object -- TODO: complete

---@class DiscordAPIUsers
---@field Me? RawDiscordUser

---@class RawDiscordRole
---@field id string
---@field name string
---@source https://discord.com/developers/docs/topics/permissions#role-object -- TODO: complete

---@class RawDiscordGuildMember
---@field roles string[]
---@field user RawDiscordUser
---@source https://discord.com/developers/docs/resources/guild#guild-member-object -- TODO: complete

---@class RawDiscordServer
---@field id string
---@field name string
---@source https://discord.com/developers/docs/resources/guild#guild-object -- TODO: complete

---@class DiscordAPIServers
---@field Main? RawDiscordServer
---@field FetchMember function

---@param raw RawDiscordServer
---@param memberId string
---@return RawDiscordGuildMember?
function DiscordAPI.Servers.FetchMember(raw, memberId) end
