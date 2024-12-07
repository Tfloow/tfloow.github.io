---
layout: post
title: Co-Design or the Best of Both Worlds
subtitle: Software or Hardware ? No need to choose !
gh-repo: Tfloow/Montgomery
thumbnail-img: /assets/img/rsa_thumbnail.jpg
gh-badge: [star, fork, follow]
tags: [RSA,cryptography,electronics,FPGA,chips,C,ARM]
comments: true
mathjax: true
author: Thomas Debelle
---

{: .box-note}
This is still a work in progress blog post. The deadline for this project is set to Monday 9th of December. Moreover, I may need some time to clean up the git repo and make it available at the time of this publication.

## Abstract

In this blogpost, we explore the multiple design steps
we went through to design a Co-Design implementation of the
RSA algorithm using the Pynq Z-2 and C code combined with
ARM assembly. We will motivate our design choices and provide
some insights and metrics about the implementation. Finally, we
will explain how we tested our implementation and benchmarked
it.

## The RSA algorithm

[To center stuff {: .mx-auto.d-block :}]: <>

### The paper

You can download the full PDF by clicking here : 

[![Crepe](/assets/img/pdf_RSA.png){: .mx-auto.d-block :}](https://thomas.debelle.be)