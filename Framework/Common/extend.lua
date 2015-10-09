module("Common.extend",package.seeall)

local r_G = _G;
local mt = getmetatable(_G);
if mt then
    r_G = rawget(mt, "__index");
end

--计算表中元素个数
function r_G._tablelen( table )
  if table == nil then return 0 end
  local count = 0
  for i, j in pairs( table ) do 
    count = count + 1
  end
  return count
end

--判断是否为空
function r_G._isEmpty( value )
  if var == nil then return true end
  local varType = type(value)
  if varType == "number" and value == 0 then
    return true
  elseif varType == "string" and #value == 0 then
    return true
  elseif varType == "table" and _tablelen(value) == 0 then
    return true
  end
  return false
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


--首字母大写
function r_G._ucfirst(string,separator) 
    if separator then --如果存在分隔符，则将分隔符后的第一个字母大写
       local splittable = _strsplit( string,separator )
       if not empty( splittable ) then 
            for k, v in pairs(splittable) do 
                firstLetteryUpper = string.upper(string.sub( v,1, 2 ))
                newstring = newstring .. firstLetteryUpper..string.sub(v,2,-1)
            end
            return newstring
       end
    end
    return string.sub(string,2,-1)
end

--首字母小写
function r_G._lowfirst(string,separator) 
    if separator then --如果存在分隔符，则将分隔符后的第一个字母大写
       local splittable = _strsplit( string,separator )
       if not empty( splittable ) then 
            for k, v in pairs(splittable) do 
                firstLetteryUpper = string.lower(string.sub( v,1, 2 ))
                newstring = newstring .. firstLetteryUpper..string.lower(v,2,-1)
            end
            return newstring
       end
    end
    return string.lower(string,2,-1)
end