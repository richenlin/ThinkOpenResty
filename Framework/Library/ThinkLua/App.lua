-- +----------------------------------------------------------------------
-- | ThinkLua
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | 
-- +----------------------------------------------------------------------

module("ThinkLua.App", package.seeall);
local App = {}

function App:run()
    --加载项目初始化
    -- local Hook = require("ThinkLua.Hook")
    -- Hook:listen("app_init")
    tags('test')
    init()
    exce()
    -- Hook:listen("app_end")

end

function init( ... )
	--加载配置文件
	C(require('Common/Conf/conf'))
	local Dispatcher = _load_module("ThinkLua.Dispatcher")
	Dispatcher:dispatch()
end

function exce( ... )
	-- 调用对应控制器方法
	local controllername = CONTROLLER_NAME
	local actionname = ACTION_NAME
	local beforeactionname = '_before_'..ACTION_NAME
	local afteractionname = '_after_'..ACTION_NAME
	local controller = Controller(controllername)
	if not controller then 
		ngx.exit(400)
	end



	if type(controller[actionname]) == "function" then 
	 	if type(controller[beforeactionname]) == "function" then 
            pcall(controller[beforeactionname],controller)
        end
        local ok, ret = pcall(controller[actionname], controller); 
        if not ok then 
        	
        end
        if type(controller[afteractionname]) == "function" then 
            pcall(controller[afteractionname],controller);
        end
	end
	


end

return App