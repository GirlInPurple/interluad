## "Diffie-Hellman Transfer Protocol" Explained

[Diffie-Hellman Key Exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange), from now on called <span title="Diffie-Hellman Transfer Protocol">DHTP</span> on this page, is a relatively simple and widely used form of encryption that uses keys to encrypt data running over the internet. The other files in this folder are usable examples of DHTP running.

For this to work, all DHTP clients need a machine with these 3 functions, [in one of many was](), front facing to the rest of the network;

```lua
-- calculate (base^exp) mod mod
function modExp(base, exp, mod)
    if mod == 1 then
        return 0
    end
    local result = 1
    base = base % mod
    while exp > 0 do
        if exp % 2 == 1 then
           result = (result * base) % mod
        end
        exp = exp >> 1
        base = (base * base) % mod
    end
    return result
end

-- generate keys
function generateKeys(g, p, private)
    local public = modExp(g, private, p)
    return public
end

-- generate shared secret
function generateSharedSecret(public, private, p)
    local sharedSecret = modExp(public, private, p)
    return sharedSecret
end
```

Here is a demontrastion of how it works;

- Client 1 stores these values on startup;
  
  ```lua
  local adrs = "Your Address Here"
  local privKey = "Any Positive Integer"
  local base = "Any Positive Integer"
  local modulo = "Any Positive Integer"
  local pubKey = generateKeys(base, modulo, privKey)
  ```

- Client 1 sends this json to Client 2;
  
  ```json
  {
    "adrs":"2", // target address
    "from":"1", // your address
    "encrypt":{
      "type":"dhtp", // tells Client 2 to use DHTP
      "modulo":"", // specified modulo
      "base":"", // specified base
      "pubKey":"" // Client 1's pubKey
    }
  }
  ```

- Client 2 receives this json and uses its values;
  
  ```lua
  local privKey = "Any Positive Integer"
  local pubKey = generateKeys(json.parse(port[1].receive).encrypt["base"], json.parse(port[1].receive).encrypt["modulo"], privKey)
  local secret = generateSharedSecret(json.parse(port[1].receive).encrypt["pubKey"], privKey, json.parse(port[1].receive).encrypt["modulo"])

  ```
- Then sends its own json back;

  ```json
  {
    "adrs":"1", // target address
    "from":"2", // your address
    "encrypt":{
      "type":"dhtp", // tells Client 1 to use DHTP
      "pubKey":"" // Client 2's pubKey
    }
  }
  ```
- Client 1 then does the same thing Client 2 did, generate the shared secret;

  ```lua
  local secret = generateSharedSecret(json.parse(port[1].receive).encrypt["pubKey"], privKey, p)
  ```

- After all of that is done, the secret should be the same on both clients, and now you can transfer data between clients safely, like this;

  ```json
  {
    "adrs":"2", // target address
    "from":"1", // your address
    "encrypt":{
      "type":"dhtp" // tells the other client to keep using DHTP
    },
    "content":{
      "foo":"what you would normally send, but divided by the secret"
      "bar":"11570" // "69420" divided by 6 (a possible secret)
    }
  }
  ```
Athough, there are 2 issues with it;

- Its slow as hell
- and there is no need for encryption in a Roblox game

Thanks to ThePokemonkey123 on the Bloxel Discord for bringing the idea of Encryption and DNS up.
