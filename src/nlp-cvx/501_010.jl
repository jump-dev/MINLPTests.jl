function nlp_cvx_501_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - n dimentional nlp
    # Variants
    #   010 - binding constraint (all variables non-zero)
    #   011 - extra sqrt
    
    function nd_shpere(n=2)
        m = Model(solver = optimizer)
    
        @variable(m, vars[1:n])
    
        @objective(m, Min, sum(-x for x in vars))
        @NLconstraint(m, sum(x^2 for x in vars) <= 1.0)
    
        status = solve(m)
    
        #println(getobjectivevalue(m))
    
        check_status(status)
        check_objective(m, -n/sqrt(n), tol = objective_tol)
        check_solution(vars, [1/sqrt(n) for i in vars], tol = primal_tol)
    end
    
    for n in 1:20
        nd_shpere(n)
    end
    
end

