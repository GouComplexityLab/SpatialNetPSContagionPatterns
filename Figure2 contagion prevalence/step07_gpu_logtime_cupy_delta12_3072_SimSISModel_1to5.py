# -*- coding: utf-8 -*-
"""
Created on Thursday, 30 May 2019

"""
import os
import time
from datetime import datetime
import numpy as np
import scipy.io as scio
import scipy.sparse as sp
import cupy as cp
from scipy.sparse import csr_matrix

if __name__ == '__main__':

    ####################################################################################################################
    Network_path = './Generated delta Lattice Embedded Networks L=3072 dg=12'
    if not os.path.exists(Network_path):
        raise ('There is not the path of data')
    laplacian_name_npz = '/laplacian_matrix_deltaLEN_L=3072_dg=12_number=1.npz'
    laplacian_matrix = sp.load_npz(Network_path + laplacian_name_npz)
    laplacian_matrix = csr_matrix(laplacian_matrix)

    node_number = np.array(laplacian_matrix.shape[0], dtype=np.int_)
    ####################################################################################################################
    # set the parameters
    beta = 0.01;
    nu = 0.2;
    gamma = 1/7;
    Omega = 13.36;

    DS = 16.0;
    DI = 1.0;

    nnns = [5]
    Omegas = [13.36]
    for Omega in np.asarray(Omegas):
        ####################################################################################################################

        Data_path = './Step1 logtime Cupy Delta12 Data N={} Omega={} beta={} nu={}/'.format(node_number, Omega, beta, nu)
        if not os.path.exists(Data_path):
            os.makedirs(Data_path)

        for nnn in np.asarray(nnns):

            Data_path_nnn = Data_path + '/nnn=' + str(nnn) + ' data'
            if not os.path.exists(Data_path_nnn):
                os.makedirs(Data_path_nnn)


            # prepare the initial conditions path with executing setting_initial_conditions.py
            ICData_path = './The same initial conditions for logtime sim/'
            isExists = os.path.exists(ICData_path)
            if not isExists:
                raise Exception("The expected Intial Conditions Path does not exist. Please execute setting_initial_conditions.py")

            mat_name = ('initialconditionsOmega=' + "{:.6f}".format(Omega).replace('.', 'dot')
                        + 'NetSize=' + "{:.0f}".format(node_number).replace('.', 'dot')
                        + 'nnn=' + "{:.0f}".format(nnn).replace('.', 'dot') + '.mat')
            # load initial conditions
            S0 = scio.loadmat(ICData_path + mat_name)['S_host'][0]
            I0 = scio.loadmat(ICData_path + mat_name)['I_host'][0]
            print('mean I0:', np.mean(I0), ', mean S0:', np.mean(S0))
            print('shape of S_host:', S0.shape)
            print('shape of I_host:', I0.shape)
            ####################################################################################################################
            # T = 4000
            # delta_T = 0.001
            # interval_time = 10
            # step = np.fix(interval_time/delta_T)

            # # test
            # delta_T = 0.001
            # T = delta_T * 10
            # interval_time = delta_T
            # step = np.fix(interval_time/delta_T)

            endtime = 10000.0  # end time
            delta_T = 0.001  # 0.02     #calculate time step
            nplot = 500
            # nsteps    = np.ceil(endtime/nplot/delta_T).astype(int)    #number of time steps
            LogTimeImages = np.logspace(np.log10(10), np.log10(endtime), nplot)
            first_LogTimeImages = LogTimeImages[0]
            print('first_LogTimeImages:', first_LogTimeImages)

            diff_LogTimeImages = np.diff(LogTimeImages)
            diff_LogTimeImages = np.hstack((first_LogTimeImages, diff_LogTimeImages))

            nstepsARRAY = diff_LogTimeImages / delta_T
            nstepsARRAY = nstepsARRAY.astype(int)

            print('LogTimeImages:', LogTimeImages[0:10])
            print('LogTimeImages:', LogTimeImages[-10:])
            # nplot_pos = np.cumsum(np.diff(LogTimeImages)) / delta_T
            # print('nplot_pos:', (nplot_pos[-10:]))

            nplot_time = np.cumsum(nstepsARRAY[0:nplot]) * delta_T
            print('nplot_time:', (nplot_time[0:10]))
            print('nplot_time:', (nplot_time[-10:]))

            # # Plotting
            # plt.plot(nplot_time, label='nplot_time')
            # plt.xlabel('Index')
            # plt.ylabel('nplot_time')
            # plt.title('Plot of nplot_time')
            # plt.legend()
            # plt.show()

            nplot_pos = nplot_time / delta_T
            print('nplot_pos:', (nplot_pos[0:10]))
            print('nplot_pos:', (nplot_pos[-10:]))

            print('nstepsARRAY:', (nstepsARRAY[0:10]))
            print('nstepsARRAY:', (nstepsARRAY[-10:]))



            '''simulation loop'''

            beta_gpu = cp.array(beta)
            nu_gpu = cp.array(nu)
            gamma_gpu = cp.array(gamma)
            Omega_gpu = cp.array(Omega)

            DS_gpu = cp.array(DS)
            DI_gpu = cp.array(DI)

            S0_gpu = cp.array(S0)  # S
            I0_gpu = cp.array(I0)  # I

            delta_T_gpu = cp.array(delta_T, dtype=cp.float64)

            laplacian_matrix_gpu = cp.sparse.csr_matrix(laplacian_matrix)


            time_start = time.time()
            starting_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            sim_T = 0
            for ii in range(1, nplot + 1):
                # The simulation
                sim_time = np.round(nplot_time[ii - 1], 3)
                # print('simulation loop: ii = ', ii, '/', nplot, ', sim time=',sim_time)
                sim_T = np.round(sim_T + len(range(1, nstepsARRAY[ii - 1] + 1)) * delta_T, 3)
                inloop_times1 = len(range(1, nstepsARRAY[ii - 1] + 1))
                inloop_times2 = nstepsARRAY[ii - 1]

                for jj in range(1, nstepsARRAY[ii - 1] + 1):

                    F_gpu = - cp.multiply(cp.multiply(beta_gpu * (1 + nu_gpu * I0_gpu), I0_gpu), S0_gpu) + gamma_gpu * I0_gpu
                    S0_gpu = S0_gpu + ( F_gpu + DS_gpu * laplacian_matrix_gpu.dot(S0_gpu)) * delta_T_gpu
                    I0_gpu = I0_gpu + (-F_gpu + DI_gpu * laplacian_matrix_gpu.dot(I0_gpu)) * delta_T_gpu


                # Get the data from the GPU
                S0 = cp.asnumpy(S0_gpu)
                I0 = cp.asnumpy(I0_gpu)

                if np.array(np.where(S0 < 0)).size > 0 or np.array(np.where(I0 < 0)).size > 0:
                    print(np.array(np.where(S0 < 0)).size)
                    print(np.array(np.where(I0 < 0)).size)
                    raise Exception("Appearing negative values.")
                if np.array(np.argwhere(np.isnan(S0))).size > 0 or np.array(np.argwhere(np.isnan(I0))).size > 0:
                    print(np.array(np.argwhere(np.isnan(S0))).size)
                    print(np.array(np.argwhere(np.isnan(I0))).size)
                    raise Exception("Appearing nan values.")
                if np.array(np.argwhere(np.isinf(S0))).size > 0 or np.array(np.argwhere(np.isinf(I0))).size > 0:
                    print(np.array(np.argwhere(np.isinf(S0))).size)
                    print(np.array(np.argwhere(np.isinf(I0))).size)
                    raise Exception("Appearing inf values.")

                print('simulation loop: nnn = ', nnn, ',  ii = ', ii, '-->', nplot,
                      inloop_times1, '===', inloop_times2, sim_time, '===', sim_T)
                savemat_name = '/SpatialConfigurationPattern T=' + "{:.4f}".format(sim_time) + '.mat'
                scio.savemat(Data_path_nnn+savemat_name, {'S0': S0, 'I0': I0, 'sim_time': sim_time})
            # ==============================================================================================================

            time_end = time.time()
            elapsed_time = time_end - time_start
            print("Simulation took      : %1.10f (s)" % (elapsed_time))

            ending_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            print("starting datetime: ", starting_datetime, "\nending datetime: ", ending_datetime)