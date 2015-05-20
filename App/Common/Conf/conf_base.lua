-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------
-- application configuration
--
-- var in this file can be got by "moon.util.get_config(key)"
--
debug={
    on=true,
    to="response", -- "ngx.log"
}

config={
    -- router
	max_level = 2,
	default_ctr = "home",
	default_func = "index",
}

mysql={
	mysql_host = "10.0.2.42",
	mysql_port = "3306",
	mysql_db = "enlinkcms3",
	mysql_user = "root",
	mysql_passwd = "richenlin"
}
	

redis={
	redis_host = "10.0.2.41",
	redis_port = "6379",
}
	

mongodb={
	mongodb_host = "10.0.2.42",
	mongodb_port = "27017",
}
