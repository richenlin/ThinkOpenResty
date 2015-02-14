module("Api.Controller.CommonController",package.seeall)

local _M = app.extend("ThinkLua.controller")

function _M:index()
	ngx.say("CommonController")

end

return _M