import numpy as np


def cal_system(x_state):
    x = x_state[0]
    y = x_state[1]
    v = x_state[2]
    theta = x_state[3]

    f = np.array([v * np.cos(theta), v * np.sin(theta), 0, 0]).T
    g = np.array([[0, 0], [0, 0], [1, 0], [0, 1]])
    return f, g
