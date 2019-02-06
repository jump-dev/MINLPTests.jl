function nlp_mi_003_014(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED,
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - quadratic objective and non-linear constraints

    m = Model(optimizer)

    @variable(m, x, Int)
    @variable(m, y, Int)

    @objective(m, Max, x^2 + y)
    @NLconstraint(m, y >= exp(x-2) - 2)
    @NLconstraint(m, y <= sin(x)^2 + 2)

    optimize!(m)

    check_status(m, termination_target, primal_target)
    check_objective(m, 11.0, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)

end

