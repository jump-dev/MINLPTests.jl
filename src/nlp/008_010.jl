function nlp_008_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - dual values

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)
    @variable(model, z)

    @NLobjective(model, Min, x + y^2 + z^3)
    c1 = @NLconstraint(model, y >= exp(-x - 2) + exp(-z - 2) - 2)
    c2 = @NLconstraint(model, x^2 <= y^2 + z^2)
    c3 = @NLconstraint(model, y >= x / 2 + z)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -0.3755859312158738, tol = objective_tol)
    check_solution(
        [x, y, z],
        [-0.593158583913523, 0.2440479041672795, 0.5406271556211383],
        tol = primal_tol,
    )
    return check_dual(
        [c1, c2, c3],
        [0.0, -0.8697415278248679, 0.06357861274725801],
        tol = dual_tol,
    )
end
