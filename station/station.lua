local log = {}
port[1].receive = function(json)
    if not table.contains(spam, json[1]) then
        if type(json) ~= "table" then
            return -- this was originally handled 
        end
        port[1].send(json)
        table.insert(log, json[1])
        print(tostring(log))
    end
end