--通用方法类，类似Thinphp中的common下通用方法
module("Common.functions",package.seeall)

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
	local filehelper = require ("Util.File")
	local fexists = filehelper.exists
	if not fexists(modelPath) then
		modelname = 'ThinkLua.model'
	end
	local model = THINKAPP.new(modelname,tablename)
	return model
end

--配置文件获取
function C(name,value)
	
	-- 类型为字符串
	if type(name) == "string" then 
		local confres = nil
		--表示取值
		if THINKU.empty( value ) then 
			confres = THINKCONFIG[name]
		else 
		--表示设值
			THINKCONFIG[name] = value
		end
	--加载全部配置文件
	elseif type(name) == 'table' then
		local r_G = _G;
		local mt = getmetatable(_G);
		if mt then
		    r_G = rawget(mt, "__index");
		end
		--合并common的conf和当前模块的conf
		
		local filehelper = require ("Util.File")
		local fexists = filehelper.exists
		local configFile = APP_PATH..MODULE_NAME..'/Conf/conf.lua'
		if not fexists(configFile) then
			r_G.THINKCONFIG = {
	mysql_host = "10.0.2.42",
	mysql_port = "3306",
	mysql_db = "enlinkcms3",
	mysql_user = "root",
	mysql_passwd = "richenlin"
}
		else
			local conf = THINKU.loadvars(configFile)	
			r_G.THINKCONFIG = THINKU.table_merge(name,conf)
		end	 
		return;
	end
	return confres

end

