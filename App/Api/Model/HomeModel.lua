module("Api.Model.HomeModel",package.seeall)
local _M = app.extend("ThinkLua.model")

function _M:_after_select( resultSet )
	if type(resultSet) == 'table' then 
		for k,v in pairs( resultSet ) do 
			ngx.say(v.activityname)
		end
	end
end

return _M