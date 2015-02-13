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

local mysql = require ("resty.mysql")
local moon_util = require("moon.util")


function _M.query(str)
    local db, err = mysql:new()
    if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
    end

    db:set_timeout(1000) -- 1 sec

    -- or connect to a unix domain socket file listened by a mysql server:
    --     local ok, err, errno, sqlstate =
    --           db:connect{
    --              path = "/path/to/mysql.sock",
    --              database = "ngx_test",
    --              user = "ngx_test",
    --              password = "ngx_test" }
    local server = moon_util.get_config('mysql');
    local ok, err, errno, sqlstate = db:connect{
    	host = server.mysql_host,
        port = server.mysql_port,
        database = server.mysql_db,
        user = server.mysql_user,
        password = server.mysql_passwd,
        max_packet_size = 1024 * 1024 }

    if not ok then
        ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
        return
    end

    -- local ok, err = db:set_keepalive(10000, 100)
    -- if not ok then
    --     ngx.say("failed to set keepalive: ", err)
    --     return
    -- end

    local res, err, errno, sqlstate =
        db:query(str)
    if not res then
        ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
        return
    end
    return res
end

return _M