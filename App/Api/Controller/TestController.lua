module("Api.Controller.TestController",package.seeall)

local _M = extend("Api.Controller.CommonController")

-- _M.outputClass = 'Test'
function _M:__construction( ... )
	self.outputClass = "Test"
end

function _M:index( ... )
	--调用父类方法
	self.parent:index()
	ngx.say(self.outputClass)
end


return _M