function nlp_mi_006_010(optimizer, objective_tol, primal_tol, dual_tol)
    # Test Goals:
    # - user defined functions

    m = Model(solver = optimizer)

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
    @variable(m, y, Bin)

    @objective(m, Max, y + x)
    @NLconstraint(m, y >= user_function_1d(x))
    @NLconstraint(m, user_function_2d(x,y) <= 2)

    status = solve(m)

    check_status(status)
    check_objective(m, 1.8813786425753092, tol = objective_tol)
    check_solution([x,y], [0.7546057578960682, 1.1267728846792409], tol = primal_tol)

end
