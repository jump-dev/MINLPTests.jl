function nlp_001_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - mix of variable start values
    # - non-linear objective without constraints
    # - minimization objective
    # - functions ^, exp, cos
    
    m = Model(solver = optimizer)
    
    @variable(m, x, start=1)
    @variable(m, y, start=2.12)
    @variable(m, z >= 1)
    
    @NLobjective(m, Min, x*exp(x) + cos(y) + z^3 - z^2)
    
    status = solve(m)
    
    check_status(status)
    check_objective(m, -1.3678794486503105, tol = objective_tol)
    check_solution([x,y,z], [-1, pi, 1], tol = primal_tol)
    
end

