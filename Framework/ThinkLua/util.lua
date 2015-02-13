-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

local json          = require("cjson");
local fileutil      = require ("library.file");

local math_floor    = math.floor;
local string_char   = string.char;
local string_byte   = string.byte;
local string_rep    = string.rep;
local string_sub    = string.sub;
local debug_getinfo = debug.getinfo;
local null = ngx.null
local type = type
local ipairs = ipairs
local re_match = ngx.re.match
local maxn = table.maxn

local think_util = require("ThinkLua.vars");

module('ThinkLua.util', package.seeall);

function empty(...)
    local tbl = { ... }
    for i = 1, maxn(tbl) do
        if tbl[i] ~= "" and tbl[i] ~= nil and tbl[i] ~= null and tbl[i] ~= false then
            return false
        end
    end
    return true
end

function is_numeric(...)
    local tbl = { ... }
    for i = 1, maxn(tbl) do
        if type(tbl[i]) ~= "number" and
            (type(tbl[i]) ~= "string" or re_match(tbl[i], "^-?\\d+.?\\d*$") == nil ) then
            return false
        end
    end
    return #tbl > 0 and true or false
end

function is_string(...)
    local tbl = {...}
    for i = 1, maxn(tbl) do
        if type(tbl[i]) ~= "string" then
            return false
        end
    end
    return #tbl > 0 and true or false
end

function read_all(filename)
    return fileutil.read_all(filename);
end


function loadvars(file)
    local env = setmetatable({}, {__index=_G});
    assert(pcall(setfenv(assert(loadfile(file)), env)));
    setmetatable(env, nil);
    return env;
end

function get_config(key, default)
    if key == nil then return nil end;
    local issub, subname = is_subapp(3);
    
    if not issub then -- main app
        local ret = ngx.var[key];
        if ret then return ret end
        local app_conf=think_util.get(APP_NAME,"APP_CONFIG");

        local v = app_conf[key];
        if v==nil then v = default end;
        return v;
    end

    -- sub app
    if not subname then return default end;
    local subapps=think_util.get(APP_NAME,"APP_CONFIG").subapps or {};
    local subconfig=subapps[subname].config or {};

    local v = subconfig[key];
    if v==nil then v = default end;
    return v;
end

function _strify(o, tab, act, logged)
    local v = tostring(o);
    if logged[o] then return v end;
    if string_sub(v,0,6) == "table:" then
        logged[o] = true;
        act = "\n" .. string_rep("|    ",tab) .. "{ [".. tostring(o) .. ", ";
        act = act .. table_real_length(o) .." item(s)]";
        for k, v in pairs(o) do
            act = act .."\n" .. string_rep("|    ", tab);
            act = act .. "|   *".. k .. "\t=>\t" .. _strify(v, tab+1, act, logged);
        end
        act = act .. "\n" .. string_rep("|    ",tab) .. "}";
        return act;
    else
        return v;
    end
end

function strify(o) return _strify(o, 1, "", {}) end;

function table_print(t)
    local s1="\n* Table String:";
    local s2="\n* End Table";
    return s1 .. strify(t) .. s2;
end

function table_real_length(t)
    local count = 0;
    for _ in pairs(t) do
        count = count + 1;
    end
    return count;
end

function is_subapp(__call_frame_level)
    if not __call_frame_level then __call_frame_level = 2 end;
    local caller = debug_getinfo(__call_frame_level,'S').source;
    local main_app = ngx.var.THINKLUA_APP_PATH;
    
    local is_mainapp = (main_app == (string_sub(caller, 2, #main_app+1)));
    if is_mainapp then return false, nil end; -- main app
    
    local subapps = think_util.get(APP_NAME, "APP_CONFIG").subapps or {};
    for k, v in pairs(subapps) do
        local spath = v.path;
        local is_this_subapp = (spath == (string_sub(caller, 2, #spath+1)));
        if is_this_subapp then return true, k end; -- sub app
    end
    
    return false, nil; -- not main/sub app, maybe call in MOON!
end

function parseNetInt(bytes)
    local a, b, c, d = string_byte(bytes, 1, 4);
    return a * 256 ^ 3 + b * 256 ^ 2 + c * 256 + d;
end

function toNetInt(n)
    -- NOTE: for little endian moon only!!!
    local d = n % 256;
    n = math_floor(n / 256);
    local c = n % 256;
    n = math_floor(n / 256);
    local b = n % 256;
    n = math_floor(n / 256);
    local a = n;
    return string_char(a) .. string_char(b) .. string_char(c) .. string_char(d);
end

function write_jsonresponse(sock, s)
    if type(s) == 'table' then
        s = json.encode(s);
    end
    local l = toNetInt(#s);
    sock:send(l .. s);
end

function read_jsonresponse(sock)
    local r, err = sock:receive(4);
    if not r then
        local error_info = 'Error when receiving from socket: %s'..err;
        ngx.log(ngx.ERR, error_info);
        return;
    end
    local len = parseNetInt(r);
    local data, err = sock:receive(len);
    if not data then
        local error_info = 'Error when receiving from socket: %s'..err;
        ngx.log(ngx.ERR, error_info);
        return;
    end
    return json.decode(data);
end

--合并table
function table_merge( table1,table2 )

    if not type(table1) or not type(table2) then 
        return false
    end
    for k,v in pairs(table2) do
        table1[k] = v
    end
    return table1
end



