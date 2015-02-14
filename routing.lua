-- +----------------------------------------------------------------------
-- | ThinkLua
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------
-- | 注意项目根路径: '^/' => 'xxx.xxx' 此规则需要放在所有规则最后
-- +----------------------------------------------------------------------

local router = require('ThinkLua.router');
router.setup();

---------------------------------------------------------------------


-- map('^/testredis','home.testredis');
-- map('^/testmysql','home.testmysql');
-- map('^/testrsa','home.testrsa');

-- map('^/api','api.index');
-- map('^/jsapi','jsapi.index');
-- map('^/getProjectList','getProjectList.index');
-- map('^/getProjectGoodsInfo','getProjectGoodsInfo.index');
-- map('^/ActivityInit','activityInit.index');
-- map('^/ActivityJoin','activityJoin.index');
-- map('^/Test','testcontroller.index');

map('^/','home.index');



---------------------------------------------------------------------
