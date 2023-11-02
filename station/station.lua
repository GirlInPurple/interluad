local log = {}
local spam = {}
port[1].receive = function(json)
    if not table.contains(spam, json[1]) then
        port[2].send(json)
        table.insert(log, json[1])
    end
    if countOccurrences(log, json[1]) > 4 then
        table.insert(spam, {value = json[1], time = os.time()})
    end
end

function countOccurrences(tbl, value)
    local count = 0
    for _, v in ipairs(tbl) do
        if v == value then
            count = count + 1
        end
    end
    return count
end
