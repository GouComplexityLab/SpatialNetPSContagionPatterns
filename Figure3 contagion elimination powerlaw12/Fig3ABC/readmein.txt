First, prepare the underlying following networks and put them inside:
Generated powerlaw Lattice Embedded Networks L=500 mu=3.6231

Second, prepare the control states and put them inside:
Step1 Cupy Powerlaw12 Data N=250000 Omega=13.36 beta=0.01 nu=0.2


Then, execute the inside codes in order：
1. Step2_gpucupy_powerlaw12_SimSISModel_IsolateIQ1_KeepDs.py
2. Step2_gpucupy_powerlaw12_SimSISModel_IsolateIQ1_DecreaseDs.py
3. Step3_gpucupy_powerlaw12_SimSISModel_DecreaseBeta_KeepDs.py
4. Step3_gpucupy_powerlaw12_SimSISModel_DecreaseBeta_DecreaseDs.py
5. Step4_gpucupy_powerlaw12_SimSISModel_DecreaseNu_KeepDs.py
6. Step4_gpucupy_powerlaw12_SimSISModel_DecreaseNu_DecreaseDs.py

7. Fig3A_topbottom_PlotStep2_powerlaw12.py
8. Fig3B_topbottom_PlotStep3_powerlaw12.py
9. Fig3C_topbottom_PlotStep4_powerlaw12.py

