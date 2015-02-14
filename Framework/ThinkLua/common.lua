--通用方法类，类似Thinphp中的common下通用方法
module("ThinkLua.common",package.seeall)

local Json = require("cjson")

--json加密
function json_encode( encodetable )
	return Json.encode(encodetable)
end
--json解密
function json_decode( decodestr )
	return Json.decode( decodestr )
end
--行为扩展
function tags( tagsname,param )
	local hook = app.new("ThinkLua.hook")
	return hook:listen( tagsname,param )
end

