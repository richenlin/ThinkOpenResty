-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

module('ThinkLua.loader',package.seeall);

local filehelper = require ("Library.file");

local setmetatable = setmetatable;
local pcall = pcall;
local assert = assert;
local loadfile = loadfile;
local type = type;
local setfenv = setfenv;
local concat = table.concat;
local fexists = filehelper.exists;
local fread_all = filehelper.read_all;

local _G = _G;

local cache_module = {};


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

local function _load_module(name)
    local loadmodule = _get_cache(name)
    if loadmodule == nil then 
        loadmodule = require(name)
        _set_cache(name,loadmodule)
    end

    return loadmodule

    -- local pathname = APP_PATH .. dir .. '/';
    -- package.path = pathname .. '?.lua;'.. package.path;
    -- local filename = _get_cache(name);

    -- if filename == nil then
    --     filename = pathname .. name .. ".lua";
    --     _set_cache(name, filename);
    -- end
    -- if fexists(filename) then
    --     requirename = string.gsub(dir..'/'..name,"/",".")
    --     ngx.say(requirename)
    --     return require (requirename);
    -- end
end

--继承
function extend( classname )
    local parentClass = _load_module( classname )
    return parentClass:new()
end

--
function new( classname, package, ... )
    local parentClass = _load_module( package,classname )
    if not parentClass then
        return 
    end

    if type( parentClass:new()) == 'function' then 
        return parentClass:new( ... )
    end
    return
end

function thinklua(filename)
    return _load_module("Framework/ThinkLua", filename);
end

function controller(filename,groupname)
    if not groupname then 
        groupname = 'Common'
    end
    -- return _load_module(filename);
    return _load_module(groupname..".Controller."..filename)
end

function model(mod, ...)
    local m = _load_module("app/model", mod)
    return m and type(m.new) == "function" and m:new(...) or m;
end

function service( servicename ,... )
    local service = _load_module('app/service',servicename..'Service')
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
    return _load_module("framework/library", lib);
end

return _M;
