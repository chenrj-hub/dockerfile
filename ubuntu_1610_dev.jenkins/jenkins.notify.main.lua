
-- curl -u tongtong:Cc -X POST http://192.168.189.188:8888
-- curl -X GET http://192.168.189.188:8888
-- curl -H "Content-Type: application/json" -X POST -d '{"username":"xyz","password":"xyz"}' http://192.168.189.188:8888
-- curl -H "Content-Type: application/x-www-form-urlencoded" -X POST -d 'name=keesh&mobile=13612345678&mobile=18888888888' http://192.168.189.188:8888

-- wget https://www.kyne.com.au/~mark/software/download/lua-cjson-2.1.0.tar.gz
-- https://www.kyne.com.au/~mark/software/lua-cjson-manual.html
local cjson = require("cjson")

ngx.req.read_body()

local _request_method = ngx.var.request_method

local _query = nil -- ngx.req.get_uri_args()
local _params = ngx.req.get_post_args()
local _json_text = [[ { "foo": "bar", "name": "张春辉2" } ]]    -- [[ [ true, { "foo": "bar" } ] ]]
local _json_value = cjson.decode(_json_text)

ngx.header["Content-type"] = "application/json"

-- ngx.say("Hello, 张春辉 ", _request_method)
-- return ngx.redirect("/site/invalid.html")

local _table = {}

-- _table["query"] = _query
-- _table["body"] = _params

_table["name"] = "some user name"
_table["phone"] = nil

ngx.say(cjson.encode(_table))


