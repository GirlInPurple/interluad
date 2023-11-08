local adrs = [
    0, -- null address
    9999, -- dns
    4269 -- testing site
]
port[1].receive = function(json)
    local rand = math.random(9998) 
    -- math.random doesnt support chars and it would be too much work to add them
    -- we wont even need latin chars tbh, 9997 possible addresses should be enough
    if not table.contains(adrs, rand) then
        port[1].send(
            {
                "adrs":"0", -- no / null address
                "from":"9999", -- dns server address
                "encrypt":{
                  -- empty / not sent
                },
                "content":{
                  "sends":rand
                }
              }
        )
        table.insert(adrs, rand)
        print(tostring(adrs))
    end
end