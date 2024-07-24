# FiveM Discord API

Lua based [Discord API](https://discord.com/developers/docs) for [FiveM development environment](https://docs.fivem.net/docs/).  
**Note:** This is a server-side script, use events for any client interactions.  
**Note:** This script is under development and not fully functional, star and watch the repo for updates.  
[Download Link](https://github.com/imperfect-fivem/discord_api/releases/latest/download/discord_api.zip)

## 📥 Dependencies
[ox_lib](https://github.com/overextended/ox_lib) is required.

## 🔃 Variables (Convar)

For initializing two variables need to be set in [server.cfg](https://docs.fivem.net/docs/server-manual/setting-up-a-server-vanilla/#servercfg).

- `discord_bot_token` found in [discord's developers portal](https://discord.com/developers/applications).
- `discord_server_id` for the main server, [finding guide](https://support-dev.discord.com/hc/en-us/articles/360028717192-Where-can-I-find-my-Application-Team-Server-ID).

Example:

```cfg
set discord_bot_token "XYZ123XYZ123XYZ123XYZ123.AB1C2D.XYZ1234_XYZ123XYZ123XYZ1_XYZ123XYZ1234"
set discord_server_id "000000000000000000"
```

## 📖 Guide

To be able to use the API you have to load a file in your script [manifest](https://docs.fivem.net/docs/scripting-reference/resource-manifest/resource-manifest/).

```lua
server_script '@discord_api/init.lua'
```

Check some [examples](./examples/simple.lua).

### 🔌 Alive/Dead API Switch

There is a built-in Alive/Dead API switch which takes place when `discord_api` resource is not started, the bot reached it's [limit](https://discord.com/developers/docs/topics/rate-limits), etc...  
What it does is pretty simple, just redefines some functions that we choose to be empty (dead) ones, so that we get empty results without have to go through a request that (we know for sure) will fail.  
When the API is ready (`discord_api` resource is started again), it will automatically redefine those function to the Alive version again.  
Check this live [example](./examples/functionality.lua).

## 🤖 Language Server

- Install [Sumneko Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) Language Server on [Visual Studio Code](https://code.visualstudio.com/).
- Check [`diagnostic.meta.lua`](./diagnostic.meta.lua) for definitions.
