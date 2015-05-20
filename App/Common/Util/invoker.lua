module("Common.Util.Invoker", package.seeall);

local _M = {}

local instance = nil
function _M:new()
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function _M:getInvoker( commond )
	instance = THINKAPP.new( commond )
	return instance
end

function _M:executeCommand( mo,map )
	local res = instance:outPut( mo, map )
	return res 
end

return _M