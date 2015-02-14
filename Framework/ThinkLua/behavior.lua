module("ThinkLua.behavior",package.seeall)

local _M = {}

function _M:new( ... )
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function _M:run( param )
	ngx.say('base behavior')
end

return _M