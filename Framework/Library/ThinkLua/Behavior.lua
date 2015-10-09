module("ThinkLua.Behavior",package.seeall)

local _M = Class()


function _M:run( param )
	ngx.say('base behavior')
end

return _M