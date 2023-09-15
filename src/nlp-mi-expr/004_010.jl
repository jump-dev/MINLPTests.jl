function nlp_mi_expr_004_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - non-linear objective and linear, quadratic constraints
    # - functions tan, abs, *

    model = Model(optimizer)

    @variable(model, -1 <= x <= 1)
    @variable(model, y)
    @variable(model, z, Int)

    @objective(model, Min, tan(x) + y + x * z + 0.5 * abs(y))
    @constraint(model, x^2 + y^2 + z^2 <= 10)
    @constraint(model, -1.2 * x - y <= z / 1.35)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, -4.576881309190901, tol = objective_tol)
    return check_solution(
        [x, y, z],
        [-0.9969558935432884, -0.077968812655046, 3],
        tol = primal_tol,
    )
end
