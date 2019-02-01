function nlp_mi_007_020(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - infeasible model, due to integrality
    
    m = Model(solver = optimizer)
    
    @variable(m, -2 <= x <= 3, Int)
    @variable(m, y, Bin)
    
    @NLconstraint(m, (x-0.5)^2 + (4*y-2)^2 <= 3)
    
    status = solve(m)
    
    check_status(status, target=:Infeasible)
    
end

