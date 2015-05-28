module("Api.Controller.TestController",package.seeall)

local _M = extend("Api.Controller.CommonController")

function _M:__construction( ... )
	self.outputClass = "Test"
end

return _M