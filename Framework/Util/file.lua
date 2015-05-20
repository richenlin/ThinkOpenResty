-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

local find = string.find
local sub = string.sub
local insert = table.insert

local io_open = io.open
local type = type
local concat = table.concat
local rename = os.rename
local remove = os.remove
local time = ngx.time
local ipairs = ipairs
local sub = string.sub


local _M = { _VERSION = '0.01' }

local magics = {
    { "\137PNG", 'png' },
    { "GIF87a", 'gif' },
    { "GIF89a", 'gif' },
    { "\255\216\255\224\0\16\74\70\73\70\0", 'jpg' },
    { "\255\216\255\225\19\133\69\120\105\102\0", 'jpg' },  -- JPEG Exif
}

function _M.detect(str)
    for _i, v in ipairs(magics) do
        if v[1] == sub(str, 1, #v[1]) then
            return v[2]
        end
    end
    return "tmp"
end

function _M.move(source, dest)
    local ok, err = rename(source, dest)
    if not ok then
        local error_info = 'Error when move file: %s'..err;
        ngx.log(ngx.ERR, error_info);
    end
    return ok
end

function _M.exists(f)
    local fh, err = io_open(f)
    if fh then
        fh:close()
        return true
    end
    return nil
end

function _M.remove(f)
    local ok, err = remove(f)
    if not ok then
        local error_info = 'Error when remove file: %s'..err;
        ngx.log(ngx.ERR, error_info);
    end
    return ok
end

function _M.read_all(filename)
    local file, err = io_open(filename, "r")
    local data = file and file:read("*a") or nil
    if file then
        file:close()
    end
    return data
end

return _M
