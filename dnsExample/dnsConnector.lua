save("localAdrs", 0) -- save address as the null address
port[2].send(
{
"adrs":"9999", -- dns server address
"from":"0", -- no / null address
}
)
-- outgoing
port[1].receive = function(json)
port[2].send(json)
print("Sent Outgoing: "..tostring(json))
end
-- incoming
port[2].receive = function(json)
if json["adrs"] == load("localAdrs") then -- if the addresses match
if load("localAdrs") == 0 and json["from"] == 9999 then
save("localAdrs", json["content"]["sends"]) -- changes the address of the connector
elseif load("localAdrs") ~= 0 then -- if not changing address, pass and run normally
port[1].send(json)
print("Accepted Incoming: "..tostring(json))
end
elseif json["adrs"] ~= load("localAdrs") then
print("Denied Incoming: "..tostring(json))
end
end
