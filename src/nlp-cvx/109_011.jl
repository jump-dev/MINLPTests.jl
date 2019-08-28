function nlp_cvx_109_011(optimizer, objective_tol, primal_tol, dual_tol,
        termination_target = TERMINATION_TARGET,
        primal_target = PRIMAL_TARGET)
    m = Model(optimizer)

    @variable(m, x >= 0.00001, start=0.1)
    @variable(m, y >= 0.00001, start=0.1)

    @NLobjective(m, Max, log(x) + log(y))
    @NLconstraint(m, (y-2)^2 <= -x+2)

    optimize!(m)

    check_status(m, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(m, 1.4853479762665618, tol = objective_tol)
    check_solution([x,y], [1.8499011869994715, 2.387425887570236], tol = primal_tol)

end
