# What connector should I choose?

Well, that depends on your use case:

If you're a making a server, want to modify the code, or want to use DHTP, use a [Static Connector](./staticConnector.lua). With it, you'll have more space to add onto due to the 800 char limit, and you can choose your own address instead of being assigned one.

If you're just using it to contact other servers or do something other than serve data, you should choose the [DNS Connector](dnsConnector.lua).