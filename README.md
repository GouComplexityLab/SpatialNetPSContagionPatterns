This repository provides the Python and Matlab codes that simulate the phase-separated contagion patterns on complex spatial configurations from our manuscript titled "Phase separation creates persistent contagion reservoirs on spatial networks" by Jian-Meng Cui, Wei Gou, Quan-Xing Liu and Zhen Jin*, submitted in 2026.
    
![](https://github.com/GouComplexityLab/SpatialNetPSContagionPatterns/blob/main/Fig2.png)
Figure: Phase-separated contagion patterns on complex spatial networks.


# Guide for Code
This folder includes several subfolders for different Figures in main text and Supplementary Information.
## Figure1 model framework:
* Fig1A.m Plot the illustrative small-size lattice embedded networks with power-law degree distribution in Fig.1A (Fig.S1E).
* Fig1C.m Plot the backward bifurcation diagram of the well-mixed model in Fig.1C.
* Fig1D_BinodalSpinodalRegion_calc.m Calculate the spinodal and binodal curves of the full structured model.
* Fig1D_BinodalSpinodalRegion_plot.m Plot the spinodal and binodal curves of the full structured model in Fig.1D.

## Figure2 contagion prevalence:
* Simulate the contagion prevalence behaviors, i.e., phase-separated contagion patterns on the underlying lattice embedded networks with delta, Poisson and power-law degree distribution in Figure2 and FigureS8.
* Fig2C_plot_4wavelength.m Plot the scaling behavior of wavelength on the underlying lattice embedded networks with different degree distribution in Fig.2C
* Fig2D_plot_4wavenumber.m Plot the scaling behavior of wavenumber on the underlying lattice embedded networks with different degree distribution in Fig.2C
* Seel more details in readmein.txt.

## Figure3 contagion elimination powerlaw12:
### in subfolder Fig3ABC：
* Calculate and plot the spinodal curves (regions) of the full structured model defined on the lattice embedded networks with power-law degree distribution under the control measures, namely, isolating infectious individuals and reducing transmission rates.
* Simulate the influence of phase-separated patterns for contagion elimination under the control measures, namely, isolating infectious individuals and reducing transmission rates, on the underlying lattice embedded networks with power-law degree distribution.
* Seel more details in readmein.txt.
  
### in subfolder Fig3DEF：
* Show the effectiveness of the control measures, namely, isolating infectious individuals and reducing transmission rates, for contagion elimination in the well-mixed model.

## Figure5 (contagion patterns on gridded urban landscapes):
* Simulate the phase-separated contagion patterns in gridded urban landscapes, taking Beijing as an example.
* step1_beijingshpfileread.py Generate the gridded urban landscapes for Beijing.
* step2_BeijingNetGenerate_EuclideanPowerlaw12.py Generate the associated networks in the gridded urban landscapes for Beijing.

* Seel more details in readmein.txt.
### in subfolder dataBeijing:
* The subsubfolder beijingshp provides the shp data with population densities of Beijing’s 338 township and street administrative regions.

## FigureS1 underlying spatial networks:
* generate_small_lattice_embedded_networks.py Generate the illustrative small-size lattice embedded networks with the delta, Poisson and power-law degree distribution plotted in Figure1 and FigureS1 through taking $L=100$.
* FigS1AB.m Plot the illustrative small-size lattice embedded networks with delta degree distribution and its part in Fig.S1A and B.
* FigS1CD.m Plot the illustrative small-size lattice embedded networks with Poisson degree distribution and its parts in Fig.S1C and D.
* FigS1EF.m Plot the illustrative small-size lattice embedded networks with power-law degree distribution and its parts in Fig.S1E and F.

## FigureS2 matlab bifurcation diagram:
* FigS2A_backward.m Plot the backward bifurcation diagram of the local model in Fig.S2A.
* FigS2B_forward.m Plot the forward bifurcation diagram of the local model in Fig.S2B.

## FigureS3 matlab spinodal regions on varing networks:
* Calculate and plot the spinodal curves (regions) of the full model defined on different lattice embedded networks with tuned network size and alternated degree distribution.

## FigureS4 matlab intersection cases:
* Plot the intersection points in $I−S$ plane of the line $d_{S}S + d_{I}I = P^{\*}$ and the curve $f(S, I) = 0$ in two different cases.

## FigureS5/FigureS6 matlab potential function:
* Plot the equation $g(P^{\*},Q)$ and potential function $V(P^{\*},Q)$ for different $P^{\*}$ in the variational analysis.

## FigureS7 binodal and spinodal regions:
* Plot the binodal and spinodal curves (regions) of full model in two different cases.


## FigureS8 contagion prevalence:
* Simulate the contagion prevalence behaviors, i.e., phase-separated contagion patterns on the underlying lattice embedded networks with delta, Poisson and power-law degree distribution, reploted in Fig.S10 in another profile.
* Seel more details in readmein.txt.


## FigureS9 FigureS9 contagion elimination delta12:
* Calculate and plot the spinodal curves (regions) of the model (2) defined on the lattice embedded networks with delta degree distribution under the control measures, namely, isolating infectious individuals and reducing transmission rates.
* Simulate the influence of phase-separated patterns for contagion elimination under the control measures, namely, isolating infectious individuals and reducing transmission rates, on the underlying lattice embedded networks with delta degree distribution.
* Seel more details in readmein.txt.


## FigureS10 contagion elimination poisson12:
* Calculate and plot the spinodal curves (regions) of the model (2) defined on the lattice embedded networks with delta Poisson distribution under the control measures, namely, isolating infectious individuals and reducing transmission rates.
* Simulate the influence of phase-separated patterns for contagion elimination under the control measures, namely, isolating infectious individuals and reducing transmission rates, on the underlying lattice embedded networks with Poisson degree distribution.
* Seel more details in readmein.txt.


# Questions:
Please contact Wei Gou, wgou@sxu.edu.cn (or goucomplexitylab@163.com) if you have any questions on the code taste (execution).
