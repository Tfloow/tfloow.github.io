---
layout: post
title: Bitbanging like it's 1870
subtitle: a CSCBE 2025 write up
tags: [write-up, CTF, CSCBE2025]
thumbnail-img: /assets/img/CTF/CSCBE2025/bitbanging/cover.png
comments: true
mathjax: true
author: Thomas Debelle
---

This post is a write-up of a challenge from the final of the [CSCBE2025](https://www.cybersecuritychallenge.be/). In this *programming challenge* we were given the following:

> We've done it, the first quantum teleportation of an object via our 5D multiverse time travel machine.
>
>...But we have no clue what it is. It clearly looks like it has the pins for a serial port, and it's really... old school looking? Like it's straight out of the 1870s or something.
> It appears to work but it makes NO sense to us! Our computers just cannot decode whatever it spews out!
>
> We've hired you, the world's foremost alien technology expert, to try to break into this machine.
> We've attached this machine's serial port to a socket, since we don't know the format, except that it appears to be binary, we send ascii "1" and "0" over the network.

We could connect to the server using:

```
$ nc bitbanging_like_its_1870.challenges.cybersecuritychallenge.be 1338
```

When running this we would get a stream of 1's and 0's appearing quickly 5 by 5. Then nothing, just some 1's and 0's.

## Table of content

- [Table of content](#table-of-content)
- [Initial thought](#initial-thought)
- [And the programming ?](#and-the-programming-)
  - [Then what ?](#then-what-)
  - [Getting higher](#getting-higher)
  - [The key](#the-key)
- [Conclusion](#conclusion)
- [Full Code](#full-code)
- [Credits](#credits)




## Initial thought

When seeing those odds packet size and the clues of *1870 and serials*, I knew I would have to dig dip into my memory and in my knowledge of the genesis of computers.

Luckily, I am an electrical engineering student and love watching niche video about some old, poorly documented and useless computers and electronics protocol. 

I quickly create a simple python script with a socket to connect and listen to the port. Now, this 5 bits protocol would appear much clearer:

```python
import socket

socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
socket.settimeout(1)
socket.connect(('bitbanging_like_its_1870.challenges.cybersecuritychallenge.be', 1338))

while True:
    print(socket.recv(1024).decode())
```

```
$ python main.py
10100
00001
10010
10010
11000
...
``` 

After seeing this, it made me think of a video made by [Usagi Electric](https://www.youtube.com/watch?v=o0ZmcvvznTY&t=1226s) where he was debugging a vacuum tube computer. Then I scratch my brain a lil harder and tried linking old punch card with serial. What do we usually connect on a serial port ? Mouse, keyboard, ... meh but a printer ? Yes that's more like it.

After a quick [google query](https://www.google.com/search?q=old+5+bits+printer+serial), I would get an article about **Teleprinter** where they mentioned the **Baudot Code** which was developed in **1874** by Émile Baudot. Everything is matching !

![By User:Huestones with derivative work by User:TedColes - Old version of File:International Telegraph Alphabet 2.jpg, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=82195717](/assets/img/CTF/CSCBE2025/bitbanging/image.png)

## And the programming ?

Of course, I will not bother translating and typing every bits on my keyboard that would be stupid. But most importantly I need to decode this stream. So I made a simple lookup table like this:

```
dec_teleprinter = {
    "11000": ["A","-"],
    "10011": ["B","?"],
    "01110": ["C",":"],
    "10010": ["D", "WHO ARE YOU"],
    "10000": ["E","3"],
    "10110": ["F","%"],
    "01011": ["G","@"],
    "00101": ["H","£"],
    "01100": ["I","8"],
    "11010": ["J","BELL"],
    "11110": ["K","("],
    "01001": ["L",")"],
    "00111": ["M","."],
    "00110": ["N",","],
    "00011": ["O","9"],
    "01101": ["P","0"],
    "11101": ["Q","1"],
    "01010": ["R","4"],
    "10100": ["S","'"],
    "00001": ["T","5"],
    "11100": ["U","7"],
    "01111": ["V","="],
    "11001": ["W","2"],
    "10111": ["X","/"],
    "10101": ["Y","6"],
    "10001": ["Z", "+"],
    "00010": ["\t","\t"],
    "01000": ["\n","\n"],
    "00100": [" ", " "]
}
```
> *note: I wrote the bits like MSB..LSB, EE habits sorry*

Notice the 2 possibilities for each code ? It matters very much as old writing machine would be having two modes which would physically shift from one set of character to another. So, if we wanted to trigger the numbers (*called figures here*) we would have to engage the teleprinter into **Figures mode**. So to keep track of this mode engaging, I created a simple python class and added a function to decode and print what was being sent by the server.

Then, I finally got something more human friendly:

```
HELLO
        SYSTEM1870 READY
        PROVIDE COMMAND
        ? FOR HELP
        E 
```

### Then what ?

Yes I could decipher it, but now how can I send `?`. I first tried manually without any luck.

Then I resigned to write a nice little python script that would convert my ASCII command into this Baudot code. I thought this would work but no success...

But, did you notice this weird padding and this line feed ? I translated the carriage return by a `\t` and the line feed with a `\n` which gave this odd look. But isn't it logical if we think like we are in the 1870's ? An operator would have to return the carriage and then press enter before sending a new command no ?

So now I sent `?\t\n` which my python script translated and then listened for an answer.

```
?
        HELP:
          ELEVATE - BECOME AN ADMINISTRATOR
          CONTAINS - LIST CONTAINERS IN CURRENT CABINET
          CLEAR - ERASE SCREEN
          TIME - GET CURRENT TIME
          TAPES - LIST AVAILABLE HIGH SPEED TAPES
          REAERROR: USER HST CORRUPTE
```

OMG, I got something the effort paid off !

### Getting higher

First thing first, when you are in a CTF, you always want to gain higher privilege to find a flag. So I did the most simple thing I could think of, logging in  as an admin using "*admin*" as password:

```
ELEVATE ADMIN
        HELLO, ADMINISTRATOR
        SWITCHED TO 0T2 SUCCESSFULY
        E
```

After this, I look around to try and find some keys with:

```
CONTAINS
        1T1 AT :
          ADMIN.PASSW    8
          FLAG.TEXT     36
          NOTES.TEXT  2.2KC
        E 
```

This `FLAG.TEXT` looks really promising. But how to read it ? The listed command have nothing to help us read such file.

So, I ran `?` again after being an admin:

```
?
        HELP:
          ABDICATE - LEAVE ADMINISTRATOR MODE
          CONTAINS - LIST CONTAINERS IN CURRENT CABINET
          CLEAR - ERASE SCREEN
          TIME - GET CURRENT TIME
          TAPES - LIST AVAILABLE HIGH SPEED TAPES
          READ - READ A CONTAINERS CONTENTS
          WRITE - REPLACE A CONTAINERS CONTENT
          CONTAINED - FULLY INTEGRATED CONTAINER EDITOR
          STATUS - SEE SYSTEM STATUS 
        E
```

Finally we had a way to access the file with `READ`.

### The key

Finally I did:

```
READ FLAG.TEXT
        CSC(NOT-REALLY-THAT-ALIEN-NOW-IS-IT)
        E
```


## Conclusion

It sounds simple, but it took me quite some times to create that little Baudot dictionary and write a decent enough python code to easily communicate with the server. The trickiest part was creating a `class` so I could keep track of which mode the keyboard was set in. But afterwards, it was a joy to see this working flawlessly.

## Full Code

```python
# create a socket that connect and listen to nc bitbanging_like_its_1870.challenges.cybersecuritychallenge.be 1338

import socket
import time

dec_teleprinter = {
    "11000": ["A","-"],
    "10011": ["B","?"],
    "01110": ["C",":"],
    "10010": ["D", "WHO ARE YOU"],
    "10000": ["E","3"],
    "10110": ["F","%"],
    "01011": ["G","@"],
    "00101": ["H","£"],
    "01100": ["I","8"],
    "11010": ["J","BELL"],
    "11110": ["K","("],
    "01001": ["L",")"],
    "00111": ["M","."],
    "00110": ["N",","],
    "00011": ["O","9"],
    "01101": ["P","0"],
    "11101": ["Q","1"],
    "01010": ["R","4"],
    "10100": ["S","'"],
    "00001": ["T","5"],
    "11100": ["U","7"],
    "01111": ["V","="],
    "11001": ["W","2"],
    "10111": ["X","/"],
    "10101": ["Y","6"],
    "10001": ["Z", "+"],
    "00010": ["\t","\t"],
    "01000": ["\n","\n"],
    "00100": [" ", " "]
}

class TTY:
    def __init__(self):
        self.mode = 0
        self.stream = []
        self.character = list(dec_teleprinter.values())
        self.codes = list(dec_teleprinter.keys())
        
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.settimeout(1)
        self.socket.connect(('bitbanging_like_its_1870.challenges.cybersecuritychallenge.be', 1338))




    def decode_teleprinter(self, message):
        teleprinter = []
        #mode = 0
        # mode 0: letter
        # mode 1: figure
        
        for i in message:
            if i == "11011":
                self.mode = 1
            elif i == "11111":
                self.mode = 0
            else:
                teleprinter.append(dec_teleprinter[i[::-1]][self.mode])
            
        return "".join(teleprinter)

    def listen_to_message(self):
        res = []
        while True:
            try:
                res.append(self.socket.recv(1024).decode())
            except:
                #print("Timeout")
                break
        
        # parse and make sure it is a list of 5 char only
        res = "".join(res)
        res = [res[i:i+5] for i in range(0, len(res), 5)]
    
            
        # convert to teleprinter
        print(self.decode_teleprinter(res))
                    
        return res

    def raw_message(self,message):
        for i in message:
            message = i
            print(message)
            self.socket.send(message.encode())
            time.sleep(0.1)
        print("Message sent")

    def send_message(self, message):
        #mode = 0
        #print(message)
        LETTER = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        NOMODE = " \t\n"
        stream = []
        character = list(dec_teleprinter.values())
        codes = list(dec_teleprinter.keys())
        
        for i in message:
            if i in LETTER:
                if self.mode == 1:
                    stream.append("11111") # switch to letter mode
                self.mode = 0
            elif i not in NOMODE:
                if self.mode == 0:
                    stream.append("11011")
                self.mode = 1
            
            for count,j in enumerate(character):
                if j[self.mode] == i:
                    stream.append(codes[count][::-1])
                    break
        
        
        # send 5 bits at a time
        
        for i in stream:
            message = i
            self.socket.send(message.encode())
            time.sleep(0.1)
        
        #s.send(message.encode())
        return stream

def main():
    s = TTY()
    
    s.listen_to_message()
    
        
    s.send_message("?\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()
    
    s.send_message("ELEVATE ADMIN\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()
    
    #print(s.raw_message(['01010', '00001', '00011', '01001', '00100', '11011', '10111', '10000', '10111', '11111', '00010', '01000']))# ["11011","11001", "00010", "01000"])
    s.send_message("READ FLAG.TEXT\n\t")
    s.mode = 0
    print("_________________________")
    s.listen_to_message()
    
    s.send_message("?\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()
    s.send_message("TAPES\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()
    s.send_message("TIME\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()
    

    
    s.send_message("CONTAINS\n\t")# ["11011","11001", "00010", "01000"])
    s.listen_to_message()


if __name__ == "__main__":
    main()
```

## Credits

- Cover image: Public Domain, https://commons.wikimedia.org/w/index.php?curid=225986
- Punch card of Baudot code: By User:Huestones with derivative work by User:TedColes - Old version of File:International Telegraph Alphabet 2.jpg, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=82195717
