function nlp_mi_003_015(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    # Test Goals:
    # - quadratic objective as NLobjective and non-linear constraints

    m = Model(optimizer)

    @variable(m, 0 <= x <= 4, Int)
    @variable(m, 0 <= y <= 4, Int)

    @NLobjective(m, Max, x^2 + y)
    @NLconstraint(m, y >= exp(x-2) - 1.5)
    @NLconstraint(m, y <= sin(x)^2 + 2)

    optimize!(m)

    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 11.0, tol = objective_tol)
    check_solution([x,y], [3, 2], tol = primal_tol)

end

