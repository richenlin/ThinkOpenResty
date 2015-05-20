module("Api.Logic.OutPutTestLogic",package.seeall)

local _M = {}
function _M:new()
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function _M:outPut( mo,map )
	
	ngx.say(THINKF.C('mysql_prefix'))
	-- local model = THINKF.D("Activity",'activity')
	-- local res = model:fields('*'):select()
	-- ngx.say(model:getLastSql())
	return mo
end

return _M