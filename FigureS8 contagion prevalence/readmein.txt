First, prepare the underlying following networks and put them inside:
Generated delta Lattice Embedded Networks L=500 dg=12
Generated mypoisson Lattice Embedded Networks L=500 lam=12
Generated powerlaw Lattice Embedded Networks L=500 mu=3.6231

Then, execute the inside codes in order：
1. Step0_GenerateSameICs.py

2. Step1_gpucupy_delta12_SimSISModel_many.py
3. Step1_gpucupy_poisson12_SimSISModel_many.py
4. Step1_gpucupy_powerlaw12_SimSISModel_many.py
5. Step2_prepare_2d_Data.py

6. Step3_MultiPatternsDelta12_hOmegaX.m
7. Step3_MultiPatternsPoisson12_hOmegaX.m
8. Step3_MultiPatternsPowerlaw12_hOmegaX.m


