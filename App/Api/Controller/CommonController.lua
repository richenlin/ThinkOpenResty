module("Api.Controller.CommonController",package.seeall)

local _M = app.extend("ThinkLua.controller")
_M["outputClass"] = "common"
_M['mo'] = {}
_M['map'] = {}
--调度类
local invoker = app.new("Common.Util.invoker")
function _M:index()
	-- ngx.say(self.outputClass)
	local logic = "Api.Logic.Output"..self.outputClass..'Logic'
	local instance = invoker:getInvoker( logic )
	local resultData = invoker:executeCommand( self.mo,self.map )
	thinkResponse:writeln(think_common.json_encode(resultData))
end

return _M