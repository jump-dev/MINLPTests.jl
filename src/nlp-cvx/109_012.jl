function nlp_cvx_109_012(optimizer, objective_tol, primal_tol, dual_tol;
        termination_target = JuMP.MOI.LOCALLY_SOLVED,
        primal_target = JuMP.MOI.FEASIBLE_POINT)
    m = Model(optimizer)

    @variable(m, x >= 0.00001, start=0.1)
    @variable(m, y >= 0.00001, start=0.1)

    @NLobjective(m, Max, log(x+y))
    @NLconstraint(m, (y-2)^2 <= -x+2)

    optimize!(m)

    check_status(m, termination_target, primal_target)
    check_objective(m, log(7/4 + 5/2), tol = objective_tol)
    check_solution([x,y], [7/4, 5/2], tol = primal_tol)

end
