---@type DiscordAPI, MetaTableMap
local api, metatables = exports['discord_api']:initials()

for key, metatable in pairs(metatables) do
    local target = api
    for subKey in key:gmatch("([^_]+)") do
        target = target[subKey]
        if target == nil then goto skip end
    end
    for key, value in pairs(metatable) do
        if value.__cfx_functionReference then
            metatable[key] = function(...) return value(...) end
        end
    end
    setmetatable(target, metatable)
    ::skip::
end

DiscordAPI = api
