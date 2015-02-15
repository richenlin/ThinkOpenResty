module("ThinkLua.model",package.seeall)

local server = think_util.get_config('mysql');
local Model = {}
Model['db'] = nil -- 数据连接
Model['tablename'] = '' -- 表名
Model['fields'] = ' ' -- 字段
Model['options'] = ' ' -- 查询表达式
Model['lastsql'] = ' ' -- 上一sql语句

function Model:new( tablename )
	self.tablename = tablename
	--初始化数据连接
	connection()
	local o={}
    setmetatable(o,self)
    self.__index=self
    return o
end

function connection()
	Model.db = require("Library.mysql")
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
	self.lastsql = self.lastsql.." FROM "..server.mysql_prefix..self.tablename
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
	self.lastsql = self.lastsql.." FROM "..server.mysql_prefix..self.tablename
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