module("ThinkLua.Class",package.seeall)

local _M = {}

function _M:new( classname )
	local o = o or {}
	setmetatable(o,self)
	self.__index = self	
	self:__construction()
	return o
end

function _M:__construction( ... )

end

return _M