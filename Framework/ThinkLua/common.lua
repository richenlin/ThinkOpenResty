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
--模型生成
function D( modelname,tablename)
	--判断对应文件是否存在，若不存在则调用ThinkLua下的Model
	local modelPath = APP_PATH..string.gsub(modelname,'%.','/')..'.lua'
	local filehelper = require ("Library.file")
	local fexists = filehelper.exists
	if not fexists(modelPath) then
		modelname = 'ThinkLua.model'
	end
	local model = app.new(modelname,tablename)
	return model
end

