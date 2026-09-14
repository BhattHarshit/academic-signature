---
layout: page
title: Research
permalink: /research/
nav: true
nav_order: 1
description: Research themes, methods, current directions, and collaborations.
toc:
  sidebar: right
  collapse: auto
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">Research</p>
  <p class="signature-page-deck">My work develops scalable numerical methods for large scientific problems, with emphasis on structure, adaptivity, and efficient use of matrix or operator information.</p>
</div>

## Research themes

<div class="signature-feature-grid">
  <div class="signature-feature-card">
    <span class="signature-feature-icon"><i class="fa-solid fa-layer-group"></i></span>
    <h3>Numerical linear algebra</h3>
    <p>Structure-aware algorithms for large matrices and operators, including low-rank approximation, hierarchical methods, factorization, and fast solvers.</p>
  </div>
  <div class="signature-feature-card">
    <span class="signature-feature-icon"><i class="fa-solid fa-shuffle"></i></span>
    <h3>Randomized algorithms</h3>
    <p>Adaptive randomized sampling and compression methods that discover useful numerical structure with limited operator access.</p>
  </div>
  <div class="signature-feature-card">
    <span class="signature-feature-icon"><i class="fa-solid fa-magnifying-glass-chart"></i></span>
    <h3>Inverse problems</h3>
    <p>Computational methods for inference and optimization in scientific models, including large-scale PDE-constrained settings.</p>
  </div>
</div>

## Current directions

### Structured approximation

Many dense operators arising in scientific computing are expensive to assemble explicitly but can be applied efficiently to vectors. I am interested in adaptive methods that identify low-rank and hierarchical structure directly from these matrix-vector products and use that structure for compression, factorization, and solution.

### Inverse problems and optimization

Regularized inverse problems provide a natural setting in which numerical linear algebra, modeling, and optimization interact. A representative objective is

$$
\min_x \; \frac{1}{2}\lVert Ax-b\rVert_2^2
+ \frac{\lambda}{2}\lVert Lx\rVert_2^2.
$$

The computational challenge is often not the expression itself, but how to exploit structure in the forward model, Hessian, or related operators when dimensions become large.

## Computational toolkit

<div class="signature-chip-row">
  <span>Randomized linear algebra</span><span>Low-rank approximation</span><span>Hierarchical matrices</span><span>PDEs</span><span>Optimization</span><span>MATLAB</span><span>Python</span>
</div>

## Collaboration

I am interested in collaborations at the intersection of numerical linear algebra, inverse problems, scientific computing, and large-scale simulation, especially when mathematical structure can be translated into substantial computational savings.
