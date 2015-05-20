--通用方法类，类似Thinphp中的common下通用方法
module("Common.functions",package.seeall)

local Json = require("cjson")
local r_G = _G;
local mt = getmetatable(_G);
if mt then
    r_G = rawget(mt, "__index");
end

--json加密
function r_G.json_encode( encodetable )
	return Json.encode(encodetable)
end
--json解密
function r_G.json_decode( decodestr )
	return Json.decode( decodestr )
end
--行为扩展
function r_G.tags( tagsname,param )
	local hook = app.new("ThinkLua.hook")
	return hook:listen( tagsname,param )
end
--模型生成
function r_G.D( modelname,tablename)
	--判断对应文件是否存在，若不存在则调用ThinkLua下的Model
	local modelPath = APP_PATH..string.gsub(modelname,'%.','/')..'.lua'
	local filehelper = require ("Util.File")
	local fexists = filehelper.exists
	if not fexists(modelPath) then
		modelname = 'ThinkLua.model'
	end
	local model = THINKAPP.new(modelname,tablename)
	return model
end

--配置文件获取
function r_G.C(name,value)
	-- 类型为字符串
	if type(name) == "string" then 
		local confres = nil
		--表示取值
		if _tableempty( value ) then 
			confres = _config[name]
			return confres
		else 
		--表示设值
			_config[name] = value
		end
	--加载全部配置文件
	elseif type(name) == 'table' then
		--TODO合并模块下的配置文件
		r_G._config = {}
		_config = name
	end
	
end

--

