function nlp_cvx_110_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @NLobjective(m, Min, exp(x) + exp(y))
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 2*exp(-1/sqrt(2)), tol = objective_tol)
    check_solution([x,y], [-1/sqrt(2), -1/sqrt(2)], tol = primal_tol)
    
end

