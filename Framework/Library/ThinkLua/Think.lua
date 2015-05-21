--核心运行类
module("Think", package.seeall);

local Think = {}

--程序初始化
function Think:start()
	--设定lua加载目录
	package.path = THINK_PATH .. '?.lua;'..APP_PATH..'?.lua;'..LIB_PATH..'?.lua;'.. package.path;
	--加载类加载器
	require("Common.loader")
	--加载通用工具类
	_load_module("Common.extend")
	--加载项目通用方法类
	_load_module("Common.functions")
	
	-- 加载Request
	_load_module("Common.request")
	--加载核心类
	_load_module("ThinkLua.Controller")
	_load_module("ThinkLua.Model")
	
	_load_module("ThinkLua.Behavior")
	_load_module("ThinkLua.Hook")

	local App = require("ThinkLua.App")
	App:run()
	
end



return Think