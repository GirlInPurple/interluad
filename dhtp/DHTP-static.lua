-- setup
local address = "6942"
local privKey = rand(20)
local base = rand(20)
local modulo = rand(20)
local pubKey = genKeys(base, modulo, privKey)
local connections = {}
-- outgoing
port[1].receive = function(json)
    if table.contains(connections, json["adrs"]) then
        port[2].send(json)
        return
    end
    for i in json["content"] then
        
    end
end
-- incoming
port[2].receive = function(json)
    if json[1] == address then
        port[1].send(json)
    elseif json[1] ~= address then
    end
end
-- functions
function modExp(base, exp, mod)
    if mod == 1 then return 0 end
    local result = 1
    base = base % mod
    while exp > 0 do
        if exp % 2 == 1 then result = (result * base) % mod end
        exp = exp >> 1
        base = (base * base) % mod
    end
    return result
end

function genKeys(g, p, private)
    return modExp(g, private, p)
end

function genSecret(public, private, p)
    return modExp(public, private, p)
end

function rand(i)
    return math.random(i)
end
