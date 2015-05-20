module("Api.Controller.CommonController",package.seeall)

local _M = extend("ThinkLua.Controller")
_M.outputClass = 'Common'

--调度类
local invoker = new("Common.Util.invoker")

function _M:index(...)
	-- local logic = "Api.Logic.Output"..self.outputClass..'Logic'
	ngx.say(self.outputClass)
	-- local instance = invoker:getInvoker( logic )
	-- local resultData = invoker:executeCommand( self.mo,self.map )
	-- thinkResponse:writeln(think_common.json_encode(resultData))
end

return _M