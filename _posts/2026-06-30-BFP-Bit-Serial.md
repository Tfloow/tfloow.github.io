---
layout: post
title: Block-Floating Point and Bit-Serial Architectures
subtitle: Flipping the problem by 90 degrees
tags: [projects, academic,GPU,NPU,chips,Python,Tensorflow,GenAI,AI]
comments: true
mathjax: true
thumbnail-img: /assets/img/M2/cover.png
author: Thomas Debelle
---

Through my Master Thesis, SANDA, I explored two interesting topics in the field of Chip Design and AI accelerators: **Block-Floating Point (BFP)** and **Bit-Serial Architectures**. These two concepts, while seemingly distinct, share a common goal of optimizing computational efficiency and resource utilization in hardware design.

- [Block-Floating Point (BFP)](#block-floating-point-bfp)
- [Bit-serial Processing](#bit-serial-processing)


As I often say, the simplest ideas are often the best. In this post, I will present and explain the concepts of BFP and Bit-Serial Architectures, highlighting their significance in modern computing. 

This blog post is a good appetizer for the upcoming post about SANDA, a self-Adaptive Variable-Precision Accelerator for Efficient LLM Inference based on [ANDA](https://arxiv.org/abs/2411.15982). SANDA is my master thesis project at KU Leuven in [Chip Design and electronics master](https://www.kuleuven.be/opleidingen/programmes/master-electrical-engineering).

## Block-Floating Point (BFP)

![BFP explained animation](/assets/img/BFP-Bit/bfp.gif)

## Bit-serial Processing