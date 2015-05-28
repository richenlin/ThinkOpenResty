module("Api.Controller.CommonController",package.seeall)

local _M = extend("ThinkLua.Controller")
_M.outputClass = 'Common'
_M.mo = {}
_M.map = {}

--调度类
local invoker = new("Common.Util.invoker")

function _M:index(...)
	local mo = I(nil,'post')
	local logic = "Api.Logic.Output"..self.outputClass..'Logic'
	local instance = invoker:getInvoker( logic )
	local resultData = invoker:executeCommand( self.mo,self.map )
end

return _M