---
layout: post
title: Final year projects @ KU Leuven
subtitle: From Systolic Arrays to mm-Wave PAs
tags: [projects, academic,Analog,RF,EDA,CAD-IC,GPU,NPU,electronics,chips,Python,Tensorflow,GenAI]
comments: true
mathjax: true
thumbnail-img: /assets/img/M2/cover.png
author: Thomas Debelle
---

As I wrap up this academic cycle, I wanted to reflect on three distinct projects that I conducted at KU Leuven and how they managed to make me a better, smarter and more versatile future engineer. I conducted many projects this last year, Let's dive in!

**Table of content:**

- [Fall 2025](#fall-2025)
    - [1. AI Accelerator: a 4x4x4 GeMM Accelerator](#1-ai-accelerator-a-4x4x4-gemm-accelerator)
    - [2. Sizing Op-Amps with Reinforcement Learning \& LLMs](#2-sizing-op-amps-with-reinforcement-learning--llms)
    - [3. High-Power RF Design @ 24 GHz](#3-high-power-rf-design--24-ghz)
    - [Conclusion](#conclusion)
- [Spring 2026](#spring-2026)


# Fall 2025

### 1. AI Accelerator: a 4x4x4 GeMM Accelerator

Modern AI workflow relies on General Matrix Multiplication (GeMM). For this reason, we have seen a rapid uptake of AI accelerators, which are just a fancy name for GeMM accelerators. Sahil Nain, my teammate, and I designed a **4x4x4 systolic array accelerator** specifically optimized for data locality and reuse.

**Architecture:**

* **Systolic array:** We chose this to minimize memory bandwidth bottlenecks. By passing inputs (A and B) through the array, each byte is reused multiple times, significantly increasing arithmetic intensity.

* **Output Stationarity:** We keep the result local and sationary as they represent a significant amount of data compared to the inputs (often a factor 4 or more). Hence, keeping the output stationary reduces memory traffic.

* **Precision:** We use an 8-bit inputs and 32-bit accumulators, for outputs, balancing precision with hardware area.


**Key Metric:** We achieved a MAC utilization of **83.12%** for workloads, proving that structured Manhattan connections, systolic approach, and deterministic scheduling can drastically reduce interconnect complexity.

![Architecture](/assets/img/M2/architecture-AI-1.png)

![Architecture 2](/assets/img/M2/architecture-AI-2.png)

---

### 2. Sizing Op-Amps with Reinforcement Learning & LLMs

Analog IC design is traditionally a manual, iterative process. In this project, we explored **Computer-Aided Design (CAD)** by automating the sizing of a two-stage OTA (Operational Trans-conductance Amplifier) using a **Twin Delayed Deep Deterministic Policy Gradient (TD3)** RL agent and an LLM-based workflow.

![Two sage OTA](/assets/img/M2/twoStage.png)

#### TD3 agent


The agent was really impressive and our simulated annealing & short roll outs improved the performances without getting lost in suboptimal designs. Seeing the pareto plots, we can see how we explored a vast area of feasible and optimal designs.

![Pareto Plots of our agents](/assets/img/M2/pareto.png)

We implemented a multi-agent LLM with one "orchestrator", btw we did that before the rapid uptake of [clawcode](https://github.com/ultraworkers/claw-code) which released in April 2026.

1. **Descriptive** Use simulation results and explained design trade-offs.
2. **Expert** Tweaks the W/L ratios, bias currents, ... targeting specific goals like noise reduction, area optimization, ...
3. **Aggregation** Its role is to summarize the best proposition from each of the expert agents.

![Agent structure](/assets/img/M2/agent.png)


**Result:** While the RL agent was fast and excellent for finding the correct sizing, the LLM approach was extremely good at explaining the design trade-offs and potential problems to an human designer.

However, the Expert agents were not the best and would take a long time to execute compared to the TD3 workflow. Moreover, their result would be quite variable and never truly consistant. In this current state, it was not really viable which highlight the lack of analog training data for LLMs.

---

### 3. High-Power RF Design @ 24 GHz

Designing at mm-wave frequencies requires a meticulous focus on matching networks and parasitic management. I designed a **Class-A Power Amplifier** targeting a 24 GHz operating frequency.

**The Design Process:**

* **Bypass Technique:** We utilized SP simulations with idealized components to isolate the input and output matching networks.
* **Inductor Optimization:** Using ADS, a fem program for electromagnetic simulation, I designed custom square inductors with quality factors ($$Q$$) between 15 and 23. 
  * > Fun fact: Q didn't initially stand for Quality factor but it was just the only letter not taken at that time. Later on, it was named quality factor as it showcased some sort of "quality" of a component or system.
* **Linearity:** By slightly over-designing the PA, we achieved a gain variation of only **0.08 dB** in the operating region, ensuring stable performance at high input powers.



**Results:** The final PA reached a **Psat of 22.51 dBm** and a maximum **Power Added Efficiency (PAE) of 43.66%**, meeting all critical specifications for 24 GHz transmission. Moreover, the gain variation in the linear region was 0.08 dB making this PA a highly linear amplifier!

![PA results](/assets/img/M2/pa.png)

---

### Conclusion

Whether it's managing data flow in a systolic array, training an RL agent to understand  relationships, or tuning a Smith chart for 24 GHz matching, the core of electrical engineering remains the same: **managing trade-offs.** 

This is why I think my education at KU Leuven gives me a strong advantage. It is a highly vertical degree that challenges me throughout many problems of an EE. This gives me a deeper understanding of issues at all level. I am not a simple RTL engineer that do not understand the fundamental limit of Friis equation of high-speed communication, No, I am becoming an engineer with multiple "hat" that gives me a better outlook on problem solving.

# Spring 2026


{: .box-note}
Not yet started, come back soon for more :p !

---

If you liked this blogpost or would like to work with me, feel free to email me at [thomasdebelle [at] skynet.be](mailto:thomasdebelle@skynet.be) !

---

Cover of this blog: "Electrical Engineering students in the 1940s." from https://ee.calpoly.edu/about/ee-history