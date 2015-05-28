-- +----------------------------------------------------------------------
-- | ThinkLua
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Lee
-- +----------------------------------------------------------------------

-- 设置环境变量
ngx.header.content_type = "text/plain";
local r_G = _G;
local mt = getmetatable(_G);
if mt then
    r_G = rawget(mt, "__index");
end
--设置网站当前目录
SITE_PATH = '/www/web/openresty/ThinkLua/'
--设置APP_NAME
APP_NAME = 'ThinkLua'
-- 定义框架路径
THINK_PATH = SITE_PATH .. 'Framework/'
-- 定义项目路径
APP_PATH = SITE_PATH .. 'App/'
-- 定义缓存存放路径
RUNTIME_PATH = SITE_PATH ..'Runtime/'
-- 开启调试模式
APP_DEBUG = true
-- 加载框架
local ThinkLua = require( THINK_PATH ..'ThinkLua')
ThinkLua:run()



-- local app = require("/www/web/openresty/ThinkLua/Framework.ThinkLua.App");
-- -- 运行
-- app:run();