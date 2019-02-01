function nlp_cvx_102_011(optimizer, objective_tol, primal_tol, dual_tol)
    m = Model(optimizer)
    
    @variable(m, x)
    @variable(m, y)
    
    @objective(m, Min, x+y)
    @NLconstraint(m, x^2 + y^2 <= 1.0)
    @constraint(m, x + y >= 1.2)
    
    optimize!(m)
    
    check_status(m)
    check_objective(m, 1.2, tol = objective_tol)
    ### can't test solution point, here are multiple solutions
    check_solution([x,y], [0.974165743715913, 0.2258342542139504], tol = primal_tol)
    
end

