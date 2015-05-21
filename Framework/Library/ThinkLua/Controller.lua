module("ThinkLua.Controller",package.seeall)

local Controller = Class()


-- 模板输出
function Controller:display( displayname )
		
end

-- 
function Controller:echo( content ,outtype )
	if outtype == nil then 
		ngx.print(content)
	elseif string.lower(outtype) == 'json' or outtype == '' then 
		ngx.print(content)
	elseif string.lower(outtype) == 'html' then 
		ngx.header['Content-Type'] = 'text/html'
		ngx.print(content)
	end
	--ngx.eof()表示response结束
	local ok, ret = pcall(ngx.eof)
	if not ok then
        ngx.log(ngx.ERR, "ngx.eof() error:", ret);
    end
end


return Controller