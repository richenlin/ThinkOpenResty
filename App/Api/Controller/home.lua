module("Api.Controller.home",package.seeall)

local _M = {}

function _M:index()
	ngx.say("thinklua")
end

return _M