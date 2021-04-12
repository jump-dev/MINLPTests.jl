function nlp_mi_007_020(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - infeasible model, due to integrality

    model = Model(optimizer)

    @variable(model, -2 <= x <= 3, Int)
    @variable(model, y, Bin)

    @NLconstraint(model, (x - 0.5)^2 + (4 * y - 2)^2 <= 3)

    optimize!(model)

    return check_status(
        model,
        INFEASIBLE_PROBLEM,
        termination_target,
        primal_target,
    )
end
