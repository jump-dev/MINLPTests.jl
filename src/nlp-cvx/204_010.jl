function nlp_cvx_204_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective
    # - intersection convex quadratic constraints
    # - rotated second order cone
    # Variants
    #   010 - intersection set

    model = Model(optimizer)

    @variable(model, x)
    @variable(model, y)
    @variable(model, z >= 0, start = 0.1)

    @objective(model, Min, -y - x)
    @NLconstraint(model, x^2 / z <= y)
    @NLconstraint(model, x^2 + y^2 <= -z + 1)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -1.2071067837918394, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [0.353553392657669, 0.8535533911341705, 0.14644661317207716],
        tol = primal_tol,
    )
end
