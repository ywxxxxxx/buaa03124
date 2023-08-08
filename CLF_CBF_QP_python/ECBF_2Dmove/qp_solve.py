from qpsolvers import solve_qp
from cal_cbf import *
from cal_clf import *


def qp_solve(x_state, lamb, gam, p, u_ref, u_lim, H):
    u_dim = 2
    n_clf = 2
    p1 = p[0]
    p2 = p[1]
    h, Lfh, Lf2h, LgLfh = cal_cbf(x_state)
    V1, V2, LfV1, LgV1, LfV2, LgV2 = cal_clf(x_state)
    # 约束条件Ax<=b
    G = np.hstack((-LgLfh, [0., 0.]))
    G = np.vstack((G, np.hstack((LgV1, [1., 0.]))))
    G = np.vstack((G, np.hstack((LgV2, [0., 1.]))))

    h = np.vstack((Lf2h + (p1 + p2) * Lfh + p1 * p2 * h, -lamb * V1 - LfV1))
    h = np.vstack((h, -gam * V2 - LfV2))

    # 输入限制
    u_min = u_lim[:, 0]
    u_max = u_lim[:, 1]
    if u_max[0] - u_min[0] > -0.0001:
        G = np.vstack((G, np.hstack((np.eye(u_dim), np.zeros((u_dim, n_clf))))))
        G = np.vstack((G, np.hstack((-1.0 * np.eye(u_dim), np.zeros((u_dim, n_clf))))))
        h = np.vstack((h, [[10.], [10.]]))
        h = np.vstack((h, [[10.], [10.]]))
    q = np.hstack((-u_ref, [0., 0.]))
    # qp求解
    r = solve_qp(H, q, G, h, solver='cvxopt')
    return r
