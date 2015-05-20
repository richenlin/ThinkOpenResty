module("Common.extend",package.seeall)

local r_G = _G;
local mt = getmetatable(_G);
if mt then
    r_G = rawget(mt, "__index");
end

function r_G._tableempty(...)
    local tbl = { ... }
    for i = 1, table.maxn(tbl) do
        if tbl[i] ~= "" and tbl[i] ~= nil and tbl[i] ~= null and tbl[i] ~= false then
            return false
        end
    end
    return true
end

--字符串分隔
function r_G._strsplit(szFullString, szSeparator)
    local nFindStartIndex = 1
    local nSplitIndex = 1
    local nSplitArray = {}
    while true do
       local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
       if not nFindLastIndex then
        nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
        break
       end
       nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
       nFindStartIndex = nFindLastIndex + string.len(szSeparator)
       nSplitIndex = nSplitIndex + 1
    end
    return nSplitArray
end