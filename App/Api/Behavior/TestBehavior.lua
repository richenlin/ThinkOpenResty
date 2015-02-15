module("Api.Behavior.TestBehavior",package.seeall)
local _M = app.extend("ThinkLua.behavior")

function _M:run( param )
	-- ngx.say(param.inituserid)
	ngx.say('test behavior')
end

return _M