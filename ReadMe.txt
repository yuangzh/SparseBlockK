SparseBlockK README File
=================================================
1. Run demo.m

2. Directory tree
We demonstrate the directory tree of our code, including the names of some main functions and their descriptions.

-------- solvers
   |        |
   |        |---- APG_Constant.m  : Implementation of Accelerated Proximal Gradient Method for solving convex composite optimization problems using constant stepsize
   |        |---- qpm.m           : Implementation of Quadratic Penality Method
   |        |---- romp.m          : Implementation of Regularized Orthogonal Matching Pursuit,
   |        |---- ssp.m           : Implementation of Subspace Pursuit
   |        |---- PG_l0c.m        : Implementation of Projective Gradient Method for Solving the Sparsity Constrained Problem
   |        |---- OMP.m           : Implementation of OMP
   |        |---- CoSaMP.m        : Implementation of Compressive Sampling Matched Pursuit
   |        |---- DecAlg_c.m      : Implementation of Block Coordinate Decomposition Algorithm for Solving the Sparsity Constrained Optimization Problem
   |        |---- DecAlg_r.m      : Implementation of Block Coordinate Decomposition Algorithm for Solving the Sparse Regularized Optimization Problem
   |
   |
   |
--------- util
            |
            |---- prox_l0.m       : Proximal operator for the L0 norm: min_{x} 0.5||x-a||^2 + lambda*||x||_0
            |---- proj_l0.m       : Projection operator for the L0 norm: min_{x} 0.5||x-a||^2, s.t. ||x||_0 <= k
            |---- combs.m         : Computes all possible combinations

	 
	 
3. REFERENCES:
[1] Ganzhao Yuan, Li Shen, Wei-Shi Zheng. A Block Decomposition Algorithm for Sparse Optimization. ACM International Conference on Knowledge Discovery and Data Mining (SIGKDD), 2020.
[2] Ganzhao Yuan, Li Shen, Wei-Shi Zheng. A Decomposition Algorithm for the Sparse Generalized Eigenvalue Problem. IEEE Conference on Computer Vision and Pattern Recognition (CVPR), 2019.
[2] Ganzhao Yuan. Smoothing Proximal Gradient Methods for Nonsmooth Sparsity Constrained Optimization. Technical Report, 2023.



	 
