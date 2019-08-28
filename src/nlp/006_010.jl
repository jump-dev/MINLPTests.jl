function nlp_006_010(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    # Test Goals:
    # - user defined functions
    
    m = Model(optimizer)
    
    function user_function_1d(x)
        if x >= 0
            return max(0.25, exp(x) - 1)
        else
            return log(-x + 3)
        end
    end
    JuMP.register(m, :user_function_1d, 1, user_function_1d, autodiff=true)
    
    function user_function_2d(x,y)
        return x^2 + y^3
    end
    JuMP.register(m, :user_function_2d, 2, user_function_2d, autodiff=true)
    
    @variable(m, x)
    @variable(m, y >= 0)
    
    @objective(m, Max, y + x)
    @NLconstraint(m, y >= user_function_1d(x))
    @NLconstraint(m, user_function_2d(x,y) <= 2)
    
    optimize!(m)
    
    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 1.8813786425753092, tol = objective_tol)
    check_solution([x,y], [0.7546057578960682, 1.1267728846792409], tol = primal_tol)
    
end

