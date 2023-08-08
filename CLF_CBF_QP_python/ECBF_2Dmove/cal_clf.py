import numpy as np


def cal_clf(x_state):
    x = x_state[0]
    y = x_state[1]
    v = x_state[2]
    theta = x_state[3]

    D = (45., 0.)
    vd = 2
    V1 = (theta - np.arctan((D[1] - y) / (D[0] - x))) ** 2
    LfV1 = 2 * (np.arctan((D[1] - y) / (D[0] - x)) - theta) * (D[1] - y) / (
            (D[0] - x) ** 2 * (((D[1] - y) / (D[0] - x)) ** 2 + 1)) * v * np.cos(theta) + \
        2 * (np.arctan((D[1] - y) / (D[0] - x)) - theta) * (D[1] - y) / (
            (x - D[0]) * (((D[1] - y) / (D[0] - x)) ** 2 + 1)) * v * np.sin(theta)
    LgV1 = np.array([0, 2 * (theta - np.arctan((D[1] - y) / (D[0] - x)))])

    V2 = (v - vd) ** 2
    LfV2 = 0
    LgV2 = np.array([2 * (v - vd), 0])
    return V1, V2, LfV1, LgV1, LfV2, LgV2
