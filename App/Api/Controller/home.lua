module("Api.Controller.home",package.seeall)
-- local _M = app.extend("Api.Controller.CommonController")
local _M = app.extend("Api.Controller.CommonController")
function _M:_before_index(  )
	self.outputClass = "Home"
	self.mo = {}
	self.mo['inituserid'] = thinkRequest:get_args("inituserid")
	--测试行为扩展类
	-- think_common.tags("test")
end

-- function _M:index(req, resp)
-- 	ngx.say("index")
-- end

function _M:_after_index( req, resp )
	-- ngx.say(type(req:get_args()))
	-- ngx.say("_after_index")
	-- thinkResponse:writeln(thinkRequest:get_args("inituserid"))
end

return _M