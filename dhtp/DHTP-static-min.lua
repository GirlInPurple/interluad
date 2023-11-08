local a="6942"
local p=rand(20)
local b=rand(20)
local m=rand(20)
local k=genKeys(b,m,p)
port[1].receive=function(j)port[2].send(j)end
port[2].receive=function(j)if j[1]==a then port[1].send(j)end end
function modExp(b,e,m)if m==1 then return 0 end local r=1 b=b%m while e>0 do if e%2==1 then r=(r*b)%m end e=e>>1 b=(b*b)%m end return r end
function genKeys(g,p,pv)return modExp(g,pv,p)end
function genSecret(pu,pv,p)return modExp(pu,pv,p)end
function rand(i)return math.random(i)end