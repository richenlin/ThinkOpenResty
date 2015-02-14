-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

module('ThinkLua.router',package.seeall);

require 'ThinkLua.functional';
require 'ThinkLua.vars';
require 'ThinkLua.util';

local string_match = string.match;
local table_insert = table.insert;
local table_sort   = table.sort;

function route_sorter(luri, ruri)
    if #luri==#ruri then
        return luri < ruri;
    else
        return #luri > #ruri;
    end
end

function _map(route_table, route_order, uri, func_name)
    local mod_name, fn = string_match(func_name, '^(.+)%.([^.]+)$');
    -- local mod = Class.new(mod_name)
    local mod = app.controller(mod_name,'Api');
    -- local mod = require("Api.Controller.home")
    --前置，后置操作
    local beforefn = '_before_'..fn
    local afterfn  = '_after_'..fn

    local func = mod[fn]
    local beforefunc = mod[beforefn]
    local afterfunc = mod[afterfn]
    --前置，后置操作
    if func then
        -- route_table[uri] = func;

        route_table[uri] = {['fn']=func,['before']=beforefunc,['after']=afterfunc}
        table_insert(route_order, uri);
        -- table_sort(route_order, route_sorter) -- sort when merge!
    else
        local error_info = "ThinkLua URL Mapping Error:[" .. uri .. "=>" .. func_name .. "] function or controller not found in module: " .. mod_name;
        ngx.status = 500;
        ngx.say(error_info);
        ngx.log(ngx.ERR, error_info);
    end
end

function map(route_table, route_order, uri, func_name)
    local ret, err = pcall(_map, route_table, route_order, uri, func_name);
    if not ret then
        local error_info = "ThinkLua URL Mapping Error:[" .. uri .. "=>" .. func_name .. "] " .. err;
        ngx.status = 500;
        ngx.say(error_info);
        ngx.log(ngx.ERR, error_info);
    end
end

function setup()
    local app_name = getfenv(2).__CURRENT_APP_NAME__;
    local main_app = getfenv(2).__MAIN_APP_NAME__;
    if app_name ~= main_app then
        app_name = main_app .. ">" .. app_name;
    end
    if not ThinkLua.vars.get(app_name,"ROUTE_INFO") then
        ThinkLua.vars.set(app_name,"ROUTE_INFO",{});
    end
    if not ThinkLua.vars.get(app_name,"ROUTE_INFO")['ROUTE_MAP'] then
        ThinkLua.vars.get(app_name,"ROUTE_INFO")['ROUTE_MAP'] = {};
        ThinkLua.vars.get(app_name,"ROUTE_INFO")['ROUTE_ORDER'] = {};
    end
    ThinkLua.vars.get(app_name, "ROUTE_INFO")['map'] = ThinkLua.functional.curry(
        map,
        ThinkLua.vars.get(app_name,"ROUTE_INFO")['ROUTE_MAP'],
        ThinkLua.vars.get(app_name,"ROUTE_INFO")['ROUTE_ORDER']
    );

    ThinkLua.vars.get(app_name,"ROUTE_INFO")['get_config'] = ThinkLua.util.get_config;
        
    setfenv(2, ThinkLua.vars.get(app_name, "ROUTE_INFO"));
end

function merge_routings(main_app, subapps)
    local main_routings=ThinkLua.vars.get(main_app,"ROUTE_INFO")['ROUTE_MAP'];
    local main_routings_order=ThinkLua.vars.get(main_app,"ROUTE_INFO")['ROUTE_ORDER'];
    for k,_ in pairs(subapps) do
        local expanded_key = main_app .. ">" .. k;
        local sub_routings=ThinkLua.vars.get(expanded_key,"ROUTE_INFO")['ROUTE_MAP'];
        for sk,sv in pairs(sub_routings) do main_routings[sk]=sv end;
        local sub_routings_order=ThinkLua.vars.get(expanded_key,"ROUTE_INFO")['ROUTE_ORDER'];
        for _,sv in ipairs(sub_routings_order) do table_insert(main_routings_order,sv) end;
    end
    table_sort(main_routings_order, route_sorter);
end

