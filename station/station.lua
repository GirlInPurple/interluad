local log = {}
port[1].receive = function(json)
    if not table.contains(spam, json[1]) then
        port[1].send(json)
        table.insert(log, json[1])
        print(tostring(log))
    end
end