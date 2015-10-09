module("ThinkLua.DB",package.seeall)

local DB = Class()

function DB:getInstance( config )
	if not _dbinstance or _dbinstance == nil then 
		local r_G = _G;
		local mt = getmetatable(_G);
		if mt then
		    r_G = rawget(mt, "__index");
		end
		r_G._dbinstance = {}		
	end
	local gid = md5(config)	
	local gdb = _dbinstance[gid]
	if not gdb or gdb == nil or gdb == '' then 
		gdb = self:factory( config )
		_dbinstance[gid] = gdb
		return gdb
	end

	return gdb
end

function DB:factory( config )
	--加载对应数据库驱动
	local dbtype = string.upper(string.sub(config.DB_TYPE,1,1))..string.lower(string.sub(config.DB_TYPE,2))
	local db = _load_module("ThinkLua.DBDriver."..dbtype..'Driver')
	return db:new( config )
end

return DB