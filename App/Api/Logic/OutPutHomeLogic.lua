module("Api.Logic.OutPutHomeLogic",package.seeall)

local _M = {}
function _M:new()
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function _M:outPut( mo,map )
	return mo
end

return _M