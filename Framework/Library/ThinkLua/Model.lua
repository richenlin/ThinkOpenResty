module("ThinkLua.Model",package.seeall)

local Model = Class()
-- 当前数据库操作对象
Model.db = nil 
-- 表前缀
Model.tablePrefix = ''
-- 模型名称
Model.name = ''
-- 数据库名称
Model.dbName = ''
-- 表名不含前缀
Model.tablename = '' 
-- 表名含前缀
Model.trueTableName =''

Model.field = '*' -- 字段
Model.options = ' ' -- 查询表达式
Model.lastsql = '' -- 上一sql语句
Model.orderby = ''
Model.group = ''
Model.limit = ''

function Model:__construction( tablename )
	self:_initialize()
	if tablename == nil or tablename == '' then 
		--TODO表示一个空的model
	else
		self.tablePrefix = C("MYSQL_PREFIX")
		self.dbName = C('MYSQL_NAME')
		self.tablename = self.tablePrefix..parseName(tablename)
	end
	local config = C('')

	connection(config)
end

--模型初始化，有具体model实现
function Model:_initialize(...)
	
end

--建立数据库连接
function connection(config)
	local DB = _load_module("ThinkLua.DB")
	Model.db = DB:getInstance(config)
end

function Model:query( sql,...)
	local db = self.db
	return db:query(sql,...)
end

function execute( sql )
	local Mysql = Model.db
	return Mysql.query(sql)
end

function Model:where( options )
	self.option = options
	return self
end

function Model:order( orderby )
	self.orderby = orderby
	return self
end

function Model:limit( limit )
	self.limit = limit
	return self
end

function Model:group( group )
	self.group = group
	return self
end



function Model:fields( fields )
	self.fields = fields
	return self
end

function Model:find()
	self.lastsql = "SELECT "
	if self.field then
		self.lastsql = self.lastsql..self.field
	end 
	self.lastsql = self.lastsql.." FROM "..self.tablename
	if self.option then
		self.lastsql = self.lastsql..' WHERE '..parseOptions(self.option)
	end 
	self.lastsql = self.lastsql .." LIMIT 0 ,1 "
	local res = self:query( self.lastsql )
	self._after_find( res[1] )
	return res[1]
end

function Model:_after_find( result )
	-- body
end

function Model:select()
	self.lastsql = "SELECT "
	self.lastsql = self.lastsql..self.field
	self.lastsql = self.lastsql.." FROM "..self.tablename
	if self.option then
		self.lastsql = self.lastsql..' WHERE '..parseOptions(self.option)
	end 
	local res = self:query( self.lastsql )
	self:_after_select( res )
	return res
end

function Model:_after_select( resultSet )
	-- if type(resultSet) == 'table' then 
	-- 	for k,v in pairs( resultSet ) do 
	-- 		ngx.say(v.activityname)
	-- 	end
	-- end 
end

function Model:getLastSql()
	return self.lastsql
end

function bulidsql() 
	
end


--字符串命名风格转换
function parseName( tablename ) 
	local i = 0;
	local temp = tablename
	for k,v in string.gmatch(tablename,'%u+') do 
		if i == 0 then 
			temp = string.gsub(temp,k,_lowfirst(k))
		else
			temp = string.gsub(temp,k,'_'.._lowfirst(k))
		end 
		i = i + 1
	end
	return temp
end

function parseOptions( options ) 
	if type( options ) == 'string' then
		return options
	end
	local where = ''
	if type( options ) == 'table' then 
		for k,v in pairs( options ) do 
			if type(v) == 'table' then 				
				local option = v[1]
				local value = v[2]
				where = where..k..' '..option..' '..value..' AND '
			end
		end
	end
	where = string.sub(where,0,string.len(where)-4)
	return where
end

return Model