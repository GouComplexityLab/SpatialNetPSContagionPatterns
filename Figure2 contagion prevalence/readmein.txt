First, prepare the underlying following networks and put them inside:
Generated delta Lattice Embedded Networks L=500 dg=4
Generated delta Lattice Embedded Networks L=500 dg=12
Generated mypoisson Lattice Embedded Networks L=500 lam=12
Generated powerlaw Lattice Embedded Networks L=500 mu=3.6231

Then, execute the inside codes in order：
1. Step01_GenerateSameICs.py

2. Step02_gpucupy_delta4_SimSISModel_many.py
3. Step02_gpucupy_delta12_SimSISModel_many.py
4. Step02_gpucupy_poisson12_SimSISModel_many.py
5. Step02_gpucupy_powerlaw12_SimSISModel_many.py

6. Step03_prepare_2d_Data.py

7. Step04_MultiPatternsDelta4_hOmega13dot36_with_CircularityCalc.m
8. Step04_MultiPatternsDelta12_hOmega13dot36_with_CircularityCalc.m
9. Step04_MultiPatternsPoisson12_hOmega13dot36_with_CircularityCalc.m
10. Step04_MultiPatternsPowerlaw12_hOmega13dot36_withCircularityCalc.m

11. Step04_MultiPatternsDelta4_hOmegaX.m
12. Step04_MultiPatternsDelta12_hOmegaX.m
13. Step04_MultiPatternsPoisson12_hOmegaX.m
14. Step04_MultiPatternsPowerlaw12_hOmegaX.m

step05_generate_lattice_embedded_networks_3072_delta12.py
step05_generate_lattice_embedded_networks_3072_poisson12.py
step05_generate_lattice_embedded_networks_3072_powerlaw12.py
Step06_GenerateSameICs_LogtimeSim_3072.py

step07_gpu_logtime_cupy_delta12_3072_SimSISModel_1to5.py
step07_gpu_logtime_cupy_poisson12_3072_SimSISModel_1to5.py
step07_gpu_logtime_cupy_powerlaw12_3072_SimSISModel_1to5.py

step08_Delta12_3072_calc_Sim_sk.m
step08_Delta12_3072_calc_wavelength.m
step08_Delta12_3072_fit_scaling_exponent_wavelength.m
step08_Delta12_3072_fit_scaling_exponent_wavenumber.m
step08_Poisson12_3072_calc_Sim_sk.m
step08_Poisson12_3072_calc_wavelength.m
step08_Poisson12_3072_fit_scaling_exponent_wavelength.m
step08_Poisson12_3072_fit_scaling_exponent_wavenumber.m
step08_Powerlaw12_3072_calc_Sim_sk.m
step08_Powerlaw12_3072_calc_wavelength.m
step08_Powerlaw12_3072_fit_scaling_exponent_wavelength.m
step08_Powerlaw12_3072_fit_scaling_exponent_wavenumber.m

Fig2C_plot_4wavelength_timespan1.m
Fig2D_plot_4wavenumber_timespan1.m
