-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

module('ThinkLua.vars', package.seeall);

require 'ThinkLua.functional';

function _setup()
    local think_global={};
    
    local function _set(app_name,k,v)
        if not think_global[app_name] then
            think_global[app_name]={};
        end
        think_global[app_name][k]=v;
        return v;
    end
    
    local function _get(app_name, k)
        if not think_global[app_name] then
            think_global[app_name]={};
        end
        return think_global[app_name][k];
    end

    local function _vars(app_name)
        if not think_global[app_name] then
            think_global[app_name]={};
        end
        return think_global[app_name];
    end
   
    return _set, _get, _vars;
end

set, get, vars = _setup();


function make_table_perapp(tbl)
    if type(tbl) ~= "table" then return end;
    
    local function _perapp_data(t)
        local data = rawget(t, ngx.ctx.APP_NAME);
        if not data then
            data = {};
            rawset(t, ngx.ctx.APP_NAME, data);
        end
        return data;
    end
            
    local function _get(t, k)
        local data = _perapp_data(t);
        if k == "__table" then return data end;
        return data[k];
    end

    local function _set(t, k, v)
        local data = _perapp_data(t);
        data[k]=v;
    end

    setmetatable(tbl, {__index = _get, __newindex = _set});
end

function clear_table_perapp(tbl)
    if type(tbl) ~= "table" then return end;
    rawset(tbl, ngx.ctx.APP_NAME, {});
end

function apairs(tbl)
    if type(tbl) ~= "table" then return end;
    if tbl.__table then return pairs(tbl.__table) end;
    return pairs(tbl);
end
