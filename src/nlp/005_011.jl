function nlp_005_011(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - function \

    model = Model(optimizer)

    @variable(model, x >= 0)
    @variable(model, y >= 0)

    @objective(model, Min, x + y)
    @NLconstraint(model, y >= (x + 0.1) \ 1 - 0.5)
    @NLconstraint(model, x >= y^(-2) - 0.5)
    @NLconstraint(model, (x + y + 0.1) \ 4 >= 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.5449760741521967, tol = objective_tol)
    return check_solution(
        [x, y],
        [0.5848970571378771, 0.9600790170143196],
        tol = primal_tol,
    )
end
