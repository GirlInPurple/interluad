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
function generateKeys(g, p, private)
return modExp(g, private, p)
end
function generateSharedSecret(public, private, p)
return modExp(public, private, p)
end