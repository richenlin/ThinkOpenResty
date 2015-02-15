-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

local _M = { _VERSION = '0.01' }

local Redis = require("resty.redis")
local think_util = require("ThinkLua.util")
local server = think_util.get_config('redis');

local red = Redis:new()



function _M.get(k)
    local ok, err = red:connect(server.redis_host, server.redis_port,{})
    if not ok then
        error({"failed to connect: ", err})
        return
    end
    return red:get(k)
end

function _M.set(k,v,ex)
    local ok, err = red:connect(server.redis_host, server.redis_port)
    if not ok then
        error({"failed to connect: ", err})
        return
    end

    if ex == '' or ex == nil then
        ex = 3600
    end
    
    return red:setex(k, ex, v)
end

function _M.hGet( hashkey,key )
    local ok, err = red:connect(server.redis_host, server.redis_port)
    if not ok then
        error({"failed to connect: ", err})
        return
    end
    return red:hget( hashkey,key)
end

function _M.hSet( hashkey,key,value )
    local ok, err = red:connect(server.redis_host, server.redis_port)
    if not ok then
        error({"failed to connect: ", err})
        return
    end
    return red:hset( hashkey,key,value )
end

function _M.hValue( k )
    local ok, err = red:connect(server.redis_host, server.redis_port)
    if not ok then
        error({"failed to connect: ", err})
        return
    end

    if ex == '' or ex == nil then
        ex = 3600
    end

    return red:hvals( k )
end

return _M