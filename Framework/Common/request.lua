module('Common.request',package.seeall);

local r_G = _G;
local mt = getmetatable(_G);
if mt then
    r_G = rawget(mt, "__index");
end

r_G._Request = {
	method          = ngx.var.request_method,
    schema          = ngx.var.schema,
    host            = ngx.var.host,
    hostname        = ngx.var.hostname,
    uri             = ngx.var.request_uri,
    path            = ngx.var.uri,
    filename        = ngx.var.request_filename,
    query_string    = ngx.var.query_string,
    headers         = ngx.req.get_headers(),
    user_agent      = ngx.var.http_user_agent,
    remote_addr     = ngx.var.remote_addr,
    remote_port     = ngx.var.remote_port,
    remote_user     = ngx.var.remote_user,
    remote_passwd   = ngx.var.remote_passwd,
    content_type    = ngx.var.content_type,
    content_length  = ngx.var.content_length,
    uri_args        = ngx.req.get_uri_args(),
    socket          = ngx.req.socket
}

function _Request:_GET(arg_name)
	if self.uri_args == nil then 
		local res = {}
		return res
	end
	if arg_name==nil then 
        local args = self.uri_args;
        local res = {}
        for key, val in pairs(args) do

            if type(val) == "table" then
                --重复key值，现只取第一个
                res[key] = val[1]
            else
                res[key] =val
                -- res.key = val
            end
        end
        return res 
    end
    local arg = self.uri_args[arg_name]
    return arg

end

function _Request:_POST( arg_name )
	ngx.req.read_body()
	local args ,err= ngx.req.get_post_args()
	local post_res = {}
    if not args then 
        return err
    end
	if name == nil then 
        for key, val in pairs(args) do 
            if type(val) == "table" then
                --重复key值，现只取第一个
                post_res[key] = val[1]
            else
                post_res[key] =val
            end
        end
        return post_res
    end 
    local arg = args[arg_name]
    return arg
end

function _Request:_REQUEST( arg_name )
	if "GET" == self.method then 
		return self:_GET( arg_name )
	end

	if "POST" == self.method then 
		return self:_POST( arg_name )
	end
end

