local address = "6942" -- replace with 4 char long string
port[1].receive = function(json)
    port[2].send(json)
end
port[2].receive = function(json)
    if json[1] == address then
        port[1].send(json)
    end
end