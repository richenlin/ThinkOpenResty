module("ThinkLua.DBDriver.MongoDriver",package.seeall)

local _driver = extend("ThinkLua.DB")
_driver.config = {}
_driver.db = ''

local mongo = _load_module("resty.mongol")
function _driver:__construction(config)
	self.config = config
	connect(config)
end

function connect( config )
    local conn = mongo:new()
    conn:set_timeout(1000)
    conn:set_keepalive(100, 100)
    local ok, err = conn:connect(config.MONGO_HOST,config.MONGO_PORT)
    if not ok then  
        ngx.say("connect failed: "..err)  
    end 
    local db = conn:new_db_handle ( config.MONGO_NAME )
    if config.MONGO_USER ~= nil and config.MONGO_USER ~='' and config.MONGO_PASSWORD ~=nil and config.MONGO_PASSWORD ~= '' then 
        local ok, err = db:auth(config.MONGO_USER,config.MONGO_PASSWORD)
        if not ok then 
            ngx.say("auth fail :"..err)
        end
    end
    _driver.db = db
    
end

   -- function _driver:query( sql,collection )
   --     -- return self.db:find(collection,{},{b=true})
   -- end

-- function _driver:query( query,collection,returnfields,numberToSkip,numberToReturn,options)
--     local col = self.db:get_col('click')
--     return local res = col:find_one({_id=0})
--     -- return self.db:query(collection , query , returnfields , numberToSkip , numberToReturn , options )
-- end

return _driver