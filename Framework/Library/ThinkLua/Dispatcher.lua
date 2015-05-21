module("ThinkLua.Dispatcher",package.seeall)

local Dispatcher = {}

function Dispatcher:new( ... )
	local o = o or {}
  setmetatable(o,self)
  self.__index = self
  return o
end

function Dispatcher:dispatch()
	local path = _Request.path
	local r_G = _G;
	local mt = getmetatable(_G);
	if mt then
	    r_G = rawget(mt, "__index");
	end
	r_G.MODULE_NAME,r_G.CONTROLLER_NAME,r_G.ACTION_NAME = splitPathName(path)

end

function splitPathName( pathname )
	-- ngx.say(pathname)
	local t = _strsplit(pathname,"/")
	groupname = t[2]
	controllername = t[3]
	actionname = t[4]
	if actionname == nil then
		actionname = 'index'
	end
	
	return groupname ,controllername,actionname
end

return Dispatcher;