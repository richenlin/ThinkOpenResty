-- +----------------------------------------------------------------------
-- | MoonLight
-- +----------------------------------------------------------------------
-- | Copyright (c) 2015
-- +----------------------------------------------------------------------
-- | Licensed CC BY-NC-ND
-- +----------------------------------------------------------------------
-- | Author: Richen <ric3000(at)163.com>
-- +----------------------------------------------------------------------

module('ThinkLua.front', package.seeall)

DEBUG_INFO_CSS=[==[
            <style rel="stylesheet" type="text/css">
            #moon-table-of-contents {
                font-size: 9pt;
                position: fixed;
                right: 0em;
                top: 0em;
                background: white;
                -webkit-box-shadow: 0 0 1em #777777;
                -moz-box-shadow: 0 0 1em #777777;
                box-shadow: 0 0 1em #777777;
                -webkit-border-bottom-left-radius: 5px;
                -moz-border-radius-bottomleft: 5px;
                border-radius-bottomleft: 5px;
                text-align: right;
                /* ensure doesn't flow off the screen when expanded */
                max-height: 80%;
                overflow: auto; 
                z-index: 200;
            }
            #moon-table-of-contents h2 {
                font-size: 10pt;
                max-width: 8em;
                font-weight: normal;
                padding-left: 0.5em;
                padding-top: 0.05em;
                padding-bottom: 0.05em; 
            }

            #moon-table-of-contents ul {
                margin-left: 14pt; 
                margin-bottom: 10pt;
                padding: 0
            }

            #moon-table-of-contents li {
                padding: 0;
                margin: 1px;
                list-style: none;
            }

            #moon-table-of-contents #moon-text-table-of-contents {
                display: none;
                text-align: left;
            }

            #moon-table-of-contents:hover #moon-text-table-of-contents {
                display: block;
                padding: 0.5em;
                margin-top: -1.5em; 
            }
            </style>
        ]==]

