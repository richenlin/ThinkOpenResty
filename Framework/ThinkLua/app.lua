-- +----------------------------------------------------------------------
-- | ThinkLua
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | 
-- +----------------------------------------------------------------------

local string_match   = string.match;
local package_loaded = package.loaded;

local _M = { _VERSION = '0.01'};
local Json  = require("cjson")
think_vars = nil;
think_debug = nil;
think_util = nil;
think_common = nil;
--定义类
Class = nil;

function init()
	-- get/set the inited flag for app_name
    local r_G = _G;
    local mt = getmetatable(_G);
    if mt then
        r_G = rawget(mt, "__index");
    end
    --环境变量加载begin
    r_G.APP_NAME = ngx.var.THINKLUA_APP_NAME;

    r_G.THINK_APP_PATH = ngx.var.THINKLUA_APP_PATH;
    r_G.THINK_PATH = THINK_APP_PATH .. 'Framework/';

    r_G.APP_PATH = THINK_APP_PATH .. 'App/';

    package.path = THINK_PATH .. '?.lua;'..APP_PATH..'?.lua;'.. package.path;

    ngx.header.content_type = "text/plain";

    r_G.app = require('ThinkLua.loader');
    
    --环境变量加载end



end


function _M.run()
    -- 初始化
    init();

    think_vars = require("ThinkLua.vars")
    think_util = require("ThinkLua.util")
     --TODO系统通用方法
    think_common = require("ThinkLua.common")

    local request=require("ThinkLua.request");
    local response=require("ThinkLua.response");

    -- 加载配置
    local config = think_util.loadvars(APP_PATH .. 'Common/Conf/conf.lua');
    if not config then config={} end;
    think_vars.set(APP_NAME,"APP_CONFIG",config);

    -- 调试模式
    think_debug = require("ThinkLua.debug");
    if config.debug and config.debug.on and think_debug then
        debug.sethook(think_debug.debug_hook, "cr");
    end

    -- 加载行为扩展
    local tags = think_util.loadvars(APP_PATH .. 'Common/Conf/tags.lua');
    if not tags.map then tags={} end;
    think_vars.set(APP_NAME,"APP_TAGS",tags.map)

    -- 加载路由
    local env = setmetatable({__CURRENT_APP_NAME__ = APP_NAME,
                              __MAIN_APP_NAME__ = APP_NAME},
                             {__index = _G})
    setfenv(assert(loadfile(THINK_APP_PATH .. "routing.lua")), env)();
    
    local uri         = ngx.var.REQUEST_URI;
    local ngx_ctx     = ngx.ctx
    local route_map   = think_vars.get(APP_NAME, "ROUTE_INFO")['ROUTE_MAP'];
    local route_order = think_vars.get(APP_NAME, "ROUTE_INFO")['ROUTE_ORDER'];
    local page_found  = false;
    thinkRequest = request:new()
    thinkResponse = response:new()
    ngx_ctx.request  = thinkRequest;
    ngx_ctx.response = thinkResponse;
    -- 路由映射
    for _, k in ipairs(route_order) do

        local args = {string_match(uri, k)};        
        if args and #args>0 then
            page_found = true;
            local functable = route_map[k];
            --前置方法，正式方法，后置方法
            local beforefunc = functable['before']
            local v = functable['fn']
            local afterfunc = functable['after']
            --前置方法，正式方法，后置方法

            if type(v) == "function" then  
                if type(beforefunc) == "function" then 
                    pcall(beforefunc, thinkRequest, thinkResponse, unpack(args));
                end              
                if think_debug then think_debug.debug_clear() end;
                local ok, ret = pcall(v, thinkRequest, thinkResponse, unpack(args));
                if not ok then thinkResponse:error(ret) end;
                if type(afterfunc) == "function" then 
                    pcall(afterfunc, thinkRequest, thinkResponse, unpack(args));
                end
                thinkResponse:finish();
                thinkResponse:do_defers();
                thinkResponse:do_last_func();
            elseif type(v) == "table" then
                v:_handler(thinkRequest, thinkResponse, unpack(args));
            else
                ngx.exit(500);
            end
            break;
        end
    end

    if not page_found then
        ngx.exit(404);
    end
end

return _M;