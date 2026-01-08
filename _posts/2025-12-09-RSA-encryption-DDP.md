---
layout: post
title: Co-Design or the Best of Both Worlds
subtitle: Software or Hardware ? No need to choose !
gh-repo: Tfloow/Montgomery
thumbnail-img: /assets/img/rsa_thumbnail.jpg
gh-badge: [star, fork, follow]
tags: [academic projects,RSA,cryptography,electronics,FPGA,chips,C,ARM]
comments: true
mathjax: true
author: Thomas Debelle
---


In this blogpost, we explore the multiple design steps
we went through to design a Co-Design implementation of the
RSA algorithm using the Pynq Z-2 and C code combined with
ARM assembly. We will motivate our design choices and provide
some insights and metrics about the implementation. Finally, we
will explain how we tested our implementation and benchmarked
it.

- [The RSA algorithm](#the-rsa-algorithm)
  - [Going Beyond](#going-beyond)
  - [The paper](#the-paper)


## The RSA algorithm

The RSA algorithm is at the core of many telecommunications systems and is extensively use. Asymetric key encryption is pretty straight forward on paper but implementing it in Hardware is not as easy as one may think.

In this project, we explored how we can design faster modulo multiplication by using the **Montgomery representation** which really comes handy in Hardware.

After building this Montgomery multiplier, we used a bit of C code to interface with the FPGA board and running the power ladder in software but deallocating the power hungry modulo multiplication to the board.

![Speed up using co-design](/assets/img/rsa_speedup.png){: .mx-auto.d-block :}

Here is a little sneak peek of our results.

### Going Beyond

We also push the project a bit further by implementing a small library of functions to make this project useful on a daily basis. We added the possibility to encrypt actual string of texts.

Making it convenient is one thing but making it faster is even better ! This is what motivates me and pushed me to dig some ancient Chinese math. On a more serious note, many RSA implementation use the [Chinese Remainder Theorem](https://en.wikipedia.org/wiki/RSA_(cryptosystem)#Using_the_Chinese_remainder_algorithm).

The most expensive part of the algorithm is the decryption and the asymmetric encryption/decryption power consumption is a major flaw in RSA. For instance, we mostly encrypt using 16 bits key, but so most decryption can use up to 1024 bits key ! That's why the Chinese Remainder Theorem is so useful as it speeds up the process by roughly 40%. But keep in mind the extra amount of informations that need to be transmitted to let the receiver use this technique.

![RSA using CRT](/assets/img/RSA_CRT.png){: .mx-auto.d-block :}

This is the algorithm for decrypting a message using the CRT and we measured some significant speed up. Here is another figure from the paper. If you are curious to learn more about it I highly suggest you to read the paper ;).

![RSA using CRT compared with vanilla RSA](/assets/img/RSA_CRT_RSA.png){: .mx-auto.d-block :}

[To center stuff {: .mx-auto.d-block :}]: <>

### The paper

You can download the full PDF by clicking here : 

[![PDF of the paper](/assets/img/pdf_RSA.png){: .mx-auto.d-block :}](/assets/docs/DDP_Final_Report.pdf)