# InterLuad

An open source project for the Roblox game [Bloxel](https://www.roblox.com/games/1427028360/Bloxel) that partially recreates the internet.

This repo assumes you already have a decent understanding of Bloxel's computer system and some basic programming knowledge. If not, please check the [Bloxel Wiki](https://bloxel.miraheze.org/wiki/Technology_Blocks), read up on it in the [Discord](https://discord.gg/wMfVhfD), or check out [this User's video](https://bloxel.miraheze.org/wiki/Technology_Blocks#Tutorial) on the topic.

Note: this repo is under heavy development, and currently no functioning version has been released yet.

## Branch Specific; Diffie-Hellman Transfer Protocol

[Diffie-Hellman Key Exchange](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange), from now on called <span title="Diffie-Hellman Transfer Protocol">DHTP</span> on this page, is a relatively simple and widely used form of encryption that uses 2 way functions to encrypt data running over the internet.

Here is a demontrastion of how it works;

- Client 1 sends this json;
  ```json
  {
    "adrs":"2"
    "from":"1"
    "encryp":"dhtp_1" // notice it has a "_1" at the end? thats what step its on
    "content":{
      "your content here":"garbled and encrypted mess"
    }
  }
  ```
- Client 2 sends this json back;
  ```json
  {
    "adrs":"1"
    "from":"2"
    "encryp":"dhtp_2"
    "content":{
      "your content here":"even more garbled and encrypted mess"
    }
  }
  ```
- Client 1 decrypts their side of the encryption;
  ```json
  {
    "adrs":"2"
    "from":"1"
    "encryp":"dhtp_3"
    "content":{
      "your content here":"garbled and encrypted mess, but with only client 2's encryption"
    }
  }
  ```
- From there, all Client 2 needs to do is decrypt the packet, and use whatever is inside

Athough, there are 2 issues with it;
- Its slow as hell
- and there is no need for encryption in a Roblox game

Thanks to ThePokemonkey123 on the Bloxel Discord for bringing the idea of encryption up.

## How it works

3 things are needed to get this working:

- Connecting lines 32 blocks apart, the max distance a port can extend. They can be decorated however the builder likes and generally follow the highways built by the [HBA](https://bloxel.miraheze.org/wiki/HBA)
- Repeater Stations to separate and handle all the connections between clients
- Multiple clients connected to Repeater Stations, referred to as Connectors in this project

![A diagram of how InterLuad works. Showing 4 Stations, with 1 Connector each except for the left and right-most, having none and 2 respectively. They have the addresses of "8y4g", "79kn", "37f4" and "01dn" (from left to right). A line is shown going between the Second, Third, and Fourth Stations, stopping at the right-most station. This line depicts the "8y4g" Connector sending a small JSON to the "01dn" server at the far bottom-right corner. The Connector "79kn" is saying "not me, dont care".](example.png "How It Works")

### Repeater Stations

Here is a simplified breakdown of the code;

- The Master Computer of the station gets sent a JSON, the first value of which is a 4 character long string
  - 26 + 26 + 10 + 5 = 67<sup>4</sup> = 20,151,121 unique addresses, we're not going past 100 connected at once, let alone 20 million. We wont get into a IPv6 situation for a *long* time, if ever.
- It then sends the JSON back down all of the wires connected to the station, eventually reaching its destination, even if it is astronomically slow.
  - There is no built-in DDos protection, so the network could encounter an infinite loop if the other station send it back down the original wire.

### Connectors

Anything that gets sent to the Connector with a valid first value will be sent out to the rest of the world. Anything that it receives will be sent to all attached ports.

It is recommended to use a Computer instead of a Laptop to use as a Connector, as the more ports you have the better.

### Limitations

Currently, there are 4 limitations to this project:

- Roblox's censoring system messing with most, if not all, user outputs; although this is just a fact of life on the site
- The 800 character limit but people have worked around it so its not too bad
- The 32 block limit between ports, not much of a limitation but its notable. Maybe make them look like power lines?
- Computer sometimes stop working when out of render distance <sup>(fact check needed)</sup>

## Contributing and License

As of 2/11/23, I have no way of testing these scripts due to not having any computers or laptops on Bloxel. If anyone has any that they would like to give, dm me.

The [Python file](./checkAndCompile.py) is for making sure that there are not immediate errors in your code, like how many ports you are using (this part is under development), and the length of the file. Please make sure you run this before contributing.

MIT license cause no need to lock down the code, any commits will be under MIT as well
