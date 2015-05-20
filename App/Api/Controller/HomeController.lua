module("Api.Controller.HomeController",package.seeall)
-- local _M = app.extend("Api.Controller.CommonController")
local _M = THINKAPP.controller("Common")
function _M:_before_index()
	
	self.outputClass = "Home"
	self.mo = {}
	self.mo['inituserid'] = THINKREQ:get_args("inituserid")
	--测试行为扩展类
	-- think_common.tags("test")
end

function _M:index(req, resp)
	local RSA_PUBLIC_KEY = [[-----BEGIN RSA PUBLIC KEY-----
MIGJAoGBAJavb+2Rr6n6+aSu0RwEeuSO2REOphLoM8TBG1pCLSqfZu3ZK6qkrGWe
fgrRdnDm2oLcnZ9JmzOWhHok9kdO/kmDFPOWwE8CSiW5pmvybnR7SfYRJ0gM7Kfo
soChxEOmStIP02wm0MKp3BD5EdzpPjLOt7CmYg+2c5/7VFUdvtX7AgMBAAE=
-----END RSA PUBLIC KEY-----]]
	
	local RSA_PRIV_KEY = [[-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQCWr2/tka+p+vmkrtEcBHrkjtkRDqYS6DPEwRtaQi0qn2bt2Suq
pKxlnn4K0XZw5tqC3J2fSZszloR6JPZHTv5JgxTzlsBPAkoluaZr8m50e0n2ESdI
DOyn6LKAocRDpkrSD9NsJtDCqdwQ+RHc6T4yzrewpmIPtnOf+1RVHb7V+wIDAQAB
AoGAXQqCX/w+rQQstQTEVTpm701Mtn2HCdGadXiO/RIzdUfrdB1OGxWG5VARn3hq
W5gPgBHcuYfnbtkXf5vm/WzHEYT/OXm7RfSklZrIpYcAWKBvTM7QLZl7ct9klQVn
VYJmFlyUOWbL+RB28hAyjHai/O9nIM3IDUiX+XyPDCm/g3ECQQDbKMGwf2w2FJn2
NUwUyj2p/1jrJqJ9uvxv9nzk7eS0qOqdeyxPffc8v6XpteOo0pKX6W8C8gA+inWP
KY4KG+EFAkEAsAP90LbI6TfY31Od3NHhNIN6u5AJNp6EknxlDIIv92rPU5ucp3Mv
qEZFCB48yKEMPU8IgZYtC8yOxFO3hYmK/wJATJ5zGMFzk3SgXvNDJgGOjWA4Nf3L
0SkOGBaUk3SYAJENdQEa/K+NQC/AUXTFor/7gCCcLutsKnE9qE9e2SnmAQJATsy6
qOHr+F0EPpcUqXNcu0HRhH7rYQR+nYYLRxpRlxa+UtPrwhuTTmaHKSdAVyGidSAY
0ssEx6+Aiuxf0OzOyQJAKwdxVRp/OxXCnvKpio6TJf3QqhePijRhgHeMTGjCC0U+
FSyYL4IklqJ4KvefQgSwIJR+oeJOzQXMFOtmOOrQ1w==
-----END RSA PRIVATE KEY-----]]
	
	local Rsa = require ("Util.rsa_encrypt")

	local uri = THINKF.json_encode(THINKREQ.uri_args);
	THINKRES:writeln("uri :" .. uri);
	local encrypt = Rsa:encrypt(RSA_PUBLIC_KEY,uri)
	THINKRES:writeln("encrypt :" .. encrypt);
	local decrypt = Rsa:decrypt(RSA_PRIV_KEY,encrypt)
	THINKRES:writeln("decrypt :" .. decrypt);
end

function _M:_after_index()
	-- ngx.say(type(req:get_args()))
	-- ngx.say("_after_index")
	-- thinkResponse:writeln(thinkRequest:get_args("inituserid"))
end

return _M