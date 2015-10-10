module("ThinkLua.DBDriver.MysqlDriver",package.seeall)

local _driver = extend("ThinkLua.DBDriver.Driver")
_driver.config = {}
_driver.db = ''
local mysql = _load_module("resty.mysql")
function _driver:__construction(config)
	self.config = config
	connect(config)
end

function connect( config )
    --[[
       mysql数据连接池
    ]]--
	local db, err = mysql:new()
	if not db then
        ngx.say("failed to instantiate mysql: ", err)
        return
    end
    db:set_timeout(1000) -- 1 sec
 --    local server = C("")
 	local ok, err, errno, sqlstate = db:connect{
    	host = config.MYSQL_HOST,
        port = config.MYSQL_PORT,
        database = config.MYSQL_NAME,
        user = config.MYSQL_USER,
        password = config.MYSQL_PASSWORD,
        max_packet_size = 1024 * 1024 }

    if not ok then
        ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
        return
    end
    db:query("SET NAMES 'utf8'")
   	_driver.db = db

end

function _driver:query( query )
	local res, err, errno, sqlstate =
        self.db:query(query)
    if not res then
        ngx.say("bad result: ", err, ": ", errno, ": ", sqlstate, ".")
        return
    end
    return res
end
return _driver