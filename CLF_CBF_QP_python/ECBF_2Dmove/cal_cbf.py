import numpy as np


def cal_cbf(x_state):
    x = x_state[0]
    y = x_state[1]
    v = x_state[2]
    theta = x_state[3]

    X = [20, 1]
    Xr = 4
    h = (x - X[0]) ** 2 + (y - X[1]) ** 2 - Xr ** 2
    Lfh = 2 * (x - X[0]) * v * np.cos(theta) + 2 * (y - X[1]) * v * np.sin(theta)
    Lf2h = 2 * v ** 2
    LgLfh = np.array([2 * (x - X[0]) * np.cos(theta) + 2 * (y - X[1]) * np.sin(theta),
             2 * (y - X[1]) * v * np.cos(theta) - 2 * (x - X[0]) * v * np.sin(theta)])
    return h, Lfh, Lf2h, LgLfh
