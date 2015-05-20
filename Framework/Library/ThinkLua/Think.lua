--核心运行类
module("Think", package.seeall);

local Think = {}

--程序初始化
function Think:start()
	--设定lua加载目录
	package.path = THINK_PATH .. '?.lua;'..APP_PATH..'?.lua;'..LIB_PATH..'?.lua;'.. package.path;
	--加载通用工具类
	require("Common.extend")
	--加载项目通用方法类
	require("Common.functions")
	--加载类加载器
	require("Common.Loader")
	--加载核心类
	_load_module("ThinkLua.Controller")
	_load_module("ThinkLua.Model")
	
	_load_module("ThinkLua.Behavior")
	_load_module("ThinkLua.Hook")
	local App = require("ThinkLua.App")
	App:run()
	
end



return Think