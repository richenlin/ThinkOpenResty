-- TODO记录运行开始时间

-- 版本信息
THINK_VERSION = '1.0.0'

--默认APP_MODE
APP_MODE = APP_MODE or 'Common/'

-- 系统运行目录
RUNTIME_PATH = RUNTIME_PATH or APP_PATH..'Runtime/'
-- 系统核心类库
LIB_PATH = LIB_PATH or THINK_PATH..'Library/'
-- Think类库目录
CORE_PATH = CORE_PATH or LIB_PATH..'ThinkLua/'
-- 行为类库目录
BEHAVIOR_PATH = BEHAVIOR_PATH or LIB_PATH..'Behavior/'
-- 系统应用模式目录
MODE_PATH = MODE_PATH or THINK_PATH..'Mode/'
-- 第三方类库目录
VENDOR_PATH = VENDOR_PATH or LIB_PATH..'Vendor/'
-- 应用公共目录
COMMON_PATH = COMMON_PATH or APP_PATH..'Common/'
-- 应用配置目录
CONF_PATH = CONF_PATH or COMMON_PATH..'Conf/'
-- 应用语言目录
LANG_PATH = LANG_PATH or COMMON_PATH..'Lang/'
-- 应用静态目录
HTML_PATH = HTML_PATH or APP_PATH..'Html/'
-- 应用日志目录
LOG_PATH = LOG_PATH or RUNTIME_PATH..'Logs/'
-- 应用缓存目录
TEMP_PATH = TEMP_PATH or RUNTIME_PATH..'Temp/'
-- 应用数据目录
DATA_PATH = DATA_PATH or RUNTIME_PATH..'Data/'
-- 应用模板缓存目录
CACHE_PATH = CACHE_PATH or RUNTIME_PATH..'Cache/'


-- 加载核心ThinkLua类
local Think = require(CORE_PATH..'Think')
Think:start()
