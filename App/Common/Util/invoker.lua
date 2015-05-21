module("Common.Util.Invoker", package.seeall);

local _M = Class()

local instance = nil


function _M:getInvoker( commond )
	instance = new( commond )
	return instance
end

function _M:executeCommand( mo,map )
	local res = instance:outPut( mo, map )
	return res 
end

return _M