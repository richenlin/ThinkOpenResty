-- +----------------------------------------------------------------------
-- | ThinkLua
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Lihao <ric3000(at)163.com>
-- +----------------------------------------------------------------------

module('Common.loader',package.seeall);

-- local r_G = _G;
-- local mt = getmetatable(_G);
-- if mt then
--     r_G = rawget(mt, "__index");
-- end
local cache_module = {};

local filehelper = require ("Util.file");
local fexists = filehelper.exists;

local function _get_cache(module)
    local appname = APP_NAME;
    return cache_module[appname] and cache_module[appname][module];
end


local function _set_cache(name, val)
    local appname = APP_NAME;
    if not cache_module[appname] then
        cache_module[appname] = {};
    end
    cache_module[appname][name] = val;
end

function r_G._load_module(name)
    local loadmodule = _get_cache(name)
    if loadmodule == nil or _tableempty( loadmodule ) then 
        loadmodule = require(name)
        _set_cache(name,loadmodule)
    end
    return loadmodule
end

--类声明

function r_G.Class()
    return extend("ThinkLua.Class")
end

--继承
function r_G.extend( classname )
    local parent = _load_module( classname )
    local cls = {}  
    for k,v in pairs(parent) do 
        -- if k == 'outputClass' then 
        --     ngx.say(v)
        -- end
        cls[k] = v 
    end  
    cls['parent'] = parent
    return cls
end

--
function r_G.new( classname, param,... )
    local parentClass = _load_module( classname )
    return parentClass:new(param,... )
end


function thinklua(filename)
    return _load_module("ThinkLua."..filename);
end

function r_G.Controller(filename)    
    local controller = MODULE_NAME..".Controller."..filename..'Controller'
    local c = _load_module(controller)
    return c:new()
end

function r_G.Model(mod, path)
    local modelname = ''
    if path == nil or path == '' then 
        --表示当前模块下的model
        modelname = APP_NAME..'.Model.'..mod..'Model'
        if not fexists(modelname) then 
            --若当前模块下无此model，则去查看common下
            modelname = "Common.Model."..mod..'Model'
            if not fexists(modelname) then 
                modelname = "ThinkLua.Model"
            end
        end
    end
    local m = _load_module(modelname)
    return m:new(mod);
end

function r_G.Behavior( behavior,path )
    -- if not fexists(behavior) then 
    --         behavior = 'Common.Behavior.'..behavior..'Behavior'
    -- end
    local m = _load_module(behavior)
    return m:new(behavior);
end

function service( servicename ,... )
    local service = _load_module(servicename..'Service')
    return service;
end

function logic( logicname ,... )
    logicname = logicname..'Logic'
    local logic = _load_module('app/logic',logicname)
    return logic and type(logic.new) == "function" and logic:new(...) or logic;
end

function config(conf)
    return _load_module("app/config", conf);
end

function library(lib)
    return _load_module(lib);
end

return _M;
