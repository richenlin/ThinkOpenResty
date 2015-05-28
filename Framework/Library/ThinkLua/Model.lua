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



Model.fields = ' ' -- 字段
Model.options = ' ' -- 查询表达式
Model.lastsql = ' ' -- 上一sql语句

function Model:__construction( tablename )
	self:_initialize()
	if tablenname == nil then 
		--TODO表示一个空的model
	else 
		self.tablename = tablename
		self.tablePrefix = C("DB_PREFIX")
		self.dbName = C('DB_NAME')
		self.tablename = self.tablePrefix..tablename
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
	self.options = options
	return self
end

function Model:fields( fields )
	self.fields = fields
	return self
end

function Model:find()
	self.lastsql = "SELECT "
	if self.fields then
		self.lastsql = self.lastsql..self.fields
	else 
		self.lastsql = self.lastsql..'*'
	end 
	self.lastsql = self.lastsql.." FROM "..THINKF.C('mysql_prefix')..self.tablename
	if self.option then
		self.lastsql = self.lastsql..' WHERE '..self.options
	end 
	self.lastsql = self.lastsql .." LIMIT 0 ,1 "

	local res = execute( self.lastsql )
	self._after_find( res[1] )
	return res
end

function Model:_after_find( result )
	-- body
end

function Model:select(fields)
	self.lastsql = "SELECT "
	if self.fields then
		self.lastsql = self.lastsql..self.fields
	else 
		self.lastsql = self.lastsql..'*'
	end 
	self.lastsql = self.lastsql.." FROM "..THINKF.C('mysql_prefix')..self.tablename
	if self.option then
		self.lastsql = self.lastsql..' WHERE '..self.options
	end 
	local res = execute( self.lastsql )
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

return Model