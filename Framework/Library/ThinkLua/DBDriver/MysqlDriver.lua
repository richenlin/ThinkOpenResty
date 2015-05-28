module("ThinkLua.DBDriver.MysqlDriver",package.seeall)

local _driver = extend("ThinkLua.DB")
_driver.config = {}
_driver.db = ''

local mysql = _load_module("resty.mysql")
function _driver:__construction(config)
	self.config = config
	connect(config)
end

function connect( config )
	local db, err = mysql:new()
	if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
    end
    db:set_timeout(1000) -- 1 sec
 --    local server = C("")
 	local ok, err, errno, sqlstate = db:connect{
    	host = "127.0.0.1",
        port = 3306,
        database = "test_ticket_activity",
        user = "root",
        password = "richenlin",
        max_packet_size = 1024 * 1024 }

    if not ok then
        ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
        return
    end
   	MysqlDriver.db = db

end

function _driver:query( query )
	local res, err, errno, sqlstate =
        self.db:query(query)
    if not res then
        ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
        return
    end
    local ok, err = self.db:set_keepalive(10000, 100)
    if not ok then
        ngx.say("failed to set keepalive: ", err)
        return
    end
    return res
end

return MysqlDriver