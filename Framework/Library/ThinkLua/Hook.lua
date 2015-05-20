module("ThinkLua.Hook",package.seeall)

local _M = {}

function _M:new( ... )
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function _M:listen( tagsname,param )
	--加载tags配置文件
	local tagstable = think_vars.get(APP_NAME, "APP_TAGS")
	tagsclass = tagstable[tagsname]
	--不存在的tag，直接返回
	-- if not tagsclass then
	-- 	return 
	-- end
	--调用方法
	-- ngx.say('hook 20:'..tagsclass)
	local tag = app.new(tagsclass)
	return tag:run(param)
end

return _M