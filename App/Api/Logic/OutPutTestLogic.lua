module("Api.Logic.OutPutTestLogic",package.seeall)

local _M = Class()

function _M:outPut( mo,map )
	local res = D(""):query("select * from enlink_activity")
	
	ngx.say(json_encode(res[1]))
	-- -- 测试mogon
	-- local res = D(""):query("{hour=1,_id=0}","daystatic")
	-- ngx.say(json_encode(res))
	return mo
end

return _M