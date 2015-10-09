--通用方法类，类似Thinphp中的common下通用方法
module("Common.functions",package.seeall)

local Json = require("cjson")
local Md5 = require("resty.md5")
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
--md5加密
function r_G.md5( object )
	if type(object) == 'table' then 
		object = json_encode( object )
	end
	return Md5.sumhexa(object)
end
--行为扩展
function r_G.tags( tagsname,param )
	local hook = new("ThinkLua.hook")
	return hook:listen( tagsname,param )
end

--获取Request
function r_G.I( arg_name,method )
	if method == nil then 
		return _Request:_REQUEST(arg_name)
	end
	if string.lower(method) == 'get' then 
		return _Request:_GET(arg_name)
	end
	if string.lower(method) == 'post' then 
		return _Request:_POST(arg_name)
	end
	return nil

end

--模型生成
function r_G.D(modelname)
	local mid = md5(modelname)
	if not _modelinstance or _modelinstance == nil then 
		local r_G = _G;
		local mt = getmetatable(_G);
		if mt then
		    r_G = rawget(mt, "__index");
		end
		r_G._modelinstance = {}		
	end
	local model = _modelinstance[mid]
	if not model or model == nil or model == '' then 
		model = Model(modelname)
		_modelinstance[mid] = model
		return model
	end
	return model
end

--配置文件获取
function r_G.C(name,value)
	if type(name) == nil or name == '' then 
		return _config
	end
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

--行为扩展
function r_G.B( name,data )
	-- if _isEmpty(name) then 
	-- 	return data 
	-- end
	--加载对应Behaiver文件
	local behavior = Behavior(name)
	return behavior:run(data)
end

--行为扩展
function r_G.tags( name,data )
	local tagsmap = ngx.ctx[APP_NAME].CONF.TAGS
	tagsname = tagsmap[name]
	return B(tagsname,data)
end

