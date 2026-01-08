---
layout: post
title: Final year projects @ KU Leuven
subtitle: From Systolic Arrays to mm-Wave PAs
thumbnail-img: /assets/img/rsa_thumbnail.jpg
tags: [academic projects,Analog,RF,EDA,CAD-IC,GPU,NPU,electronics,chips,Python,Tensorflow,GenAI]
comments: true
mathjax: true
author: Thomas Debelle
---

## Abstract

As I wrap up this academic cycle, I wanted to reflect on three distinct projects that I conducted at KU Leuven and how they managed to make me a better, smarter and more versatile future engineer.

# Fall 2025

### AI Accelerator: Architecting a 4x4x4 GeMM Accelerator

Modern AI workloads demand massive throughput for General Matrix Multiplication (GeMM). My team and I designed a **4x4x4 systolic array accelerator** specifically optimized for data locality and reuse.

**The Architecture:**

* **Systolic Processing:** We chose this to minimize memory bandwidth bottlenecks. By passing inputs (A and B) through the array, each byte is reused multiple times, significantly increasing arithmetic intensity.

* **Output Stationarity:** This choice prevents the inefficient repeated flushing and reloading of partial sums.

* **Precision:** The design uses 8-bit inputs and 32-bit accumulators, balancing precision with hardware area.


**Key Metric:** We achieved a MAC utilization of **83.12%** for  workloads, proving that structured Manhattan connections and deterministic scheduling can drastically reduce interconnect complexity.

![Architecture](/assets/img/M2/architecture-AI-1.png)

![Architecture 2](/assets/img/M2/architecture-AI-2.png)

---

### 2. Sizing Op-Amps with Reinforcement Learning & LLMs

Analog IC design is traditionally a manual, iterative process. In this project, we explored **Computer-Aided Design (CAD)** by automating the sizing of a two-stage OTA (Operational Trans-conductance Amplifier) using a **Twin Delayed Deep Deterministic Policy Gradient (TD3)** RL agent and an LLM-based workflow.

![Two sage OTA](/assets/img/M2/twoStage.png)

#### TD3 agent


The agent was really impressive and our simulated annealing & short roll outs improved the performances without getting lost in suboptimal designs. Seeing the pareto plots, we can see how we explored a vast area of feasible and optimal designs.

![Pareto Plots](/assets/img/M2/pareto.png)

**The Workflow:**
We implemented a multi-agent LLM structure to act as a "Senior Engineer" reviewer:

1. **Descriptive Agent:** Interpreted simulation results and explained design trade-offs.
2. **Expert Sizer Agents:** Proposed parameter updates (W/L ratios, bias currents) targeting specific goals like noise reduction or area optimization.
3. **Aggregation Agent:** Selected the best proposed parameters to maximize the Figure of Merit (FoM).

![Agent structure](/assets/img/M2/agent.png)


**The Verdict:** While the RL agent excelled at exploring the environment, the LLM-based workflow proved vital for **explaining design choices** to human engineers, bridging the gap between "black-box" optimization and actionable insights.

---

### 3. High-Power RF Design: 24 GHz Power Amplifier

Designing at mm-wave frequencies requires a meticulous focus on matching networks and parasitic management. I designed a **Class-A Power Amplifier** targeting a 24 GHz operating frequency.

**The Design Process:**

* **Bypass Technique:** We utilized sp simulations with idealized components to isolate the input and output matching networks before moving to high-accuracy inductor models.
* **Inductor Optimization:** Using ADS, I designed custom square inductors with quality factors ($Q$) between 15 and 23, surpassing standard library components. 
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
