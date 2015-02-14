module("Api.Controller.home",package.seeall)
-- local _M = app.extend("Api.Controller.CommonController")
local _M = app.extend("Api.Controller.CommonController")
function _M:_before_index()
	ngx.say("before_index")
	--测试行为扩展类
	think_common.tags("test")
end

-- function _M:index()
-- 	ngx.say("index")
-- end

function _M:_after_index()
	ngx.say("_after_index")
end

return _M