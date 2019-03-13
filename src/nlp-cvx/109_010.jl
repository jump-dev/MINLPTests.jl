function nlp_cvx_109_010(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED,
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    # Test Goals:
    # - convex logarithmic objective
    # - binding nonlinear constraint
    # Variants
    #   010 - binding constraint (inflection point)
    #   011 - binding constraint (non-inflection point)

    m = Model(optimizer)

    @variable(m, x >= 0.00001, start=2)
    @variable(m, y >= 0.00001, start=2)

    @NLobjective(m, Max, log(x))
    @NLconstraint(m, (y-2)^2 <= -x+2)

    optimize!(m)

    check_status(m, termination_target, primal_target)
    check_objective(m, log(2), tol = objective_tol)
    check_solution([x,y], [2, 2], tol = primal_tol)

end
