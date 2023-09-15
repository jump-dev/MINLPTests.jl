function nlp_expr_003_012(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - linear objective and non-linear constraints

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4)
    @variable(model, 0 <= y <= 4)

    @objective(model, Max, x)
    @constraint(model, y >= exp(x - 2) - 1.5)
    @constraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 3.256512665824449, tol = objective_tol)
    return check_solution(
        [x, y],
        [3.2565126525233166, 2.013148549981813],
        tol = primal_tol,
    )
end
