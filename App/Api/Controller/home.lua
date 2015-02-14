module("Api.Controller.home",package.seeall)

local _M = {}

function _M:_before_index()
	ngx.say("before_index")
end

function _M:index()
	ngx.say("index")
end

function _M:_after_index()
	ngx.say("_after_index")
end

return _M