import matplotlib.pyplot as plt
from cal_system import *
from qp_solve import *

T = 30
dt = 0.2

lamb = 4
gam = 5
p = [0.3, 2]

x = np.array([0., 0., 1.5, 0])
u_ref = np.array([0., 0.])
u_lim = np.array([[-10, 10], [-10, 10]])
H = np.diag([1., 1, 4, 2])
# 存储数组
pos = np.zeros((2, int(T / dt) + 1))
u = np.array([0., 0.])

for t in range(0, int(T/dt+1)):  # int(T/dt+1)
    f, g = cal_system(x)
    h, Lfh, Lf2h, LgLfh = cal_cbf(x)
    V1, V2, LfV1, LgV1, LfV2, LgV2 = cal_clf(x)

    sol = qp_solve(x, lamb, gam, p, u_ref, u_lim, H)
    u = sol[0:2]
    dlt = sol[2:4]
    x += (f + np.matmul(u, g.T)) * dt
    pos[:, t] = x[0:2]

plt.plot(pos[0, :], pos[1, :])
plt.show()
