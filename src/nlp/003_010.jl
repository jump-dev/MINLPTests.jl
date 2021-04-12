function nlp_003_010(
    optimizer,
    objective_tol,
    primal_tol,
    dual_tol,
    termination_target = TERMINATION_TARGET_LOCAL,
    primal_target = PRIMAL_TARGET_LOCAL,
)
    # Test Goals:
    # - none have start values
    # - non-linear objective and non-linear constraints
    # - maximization objective
    # - variable bounds
    # - functions sqrt, sin

    model = Model(optimizer)

    @variable(model, 0 <= x <= 4)
    @variable(model, 0 <= y <= 4)

    @NLobjective(model, Max, sqrt(x + 0.1))
    @NLconstraint(model, y >= exp(x - 2) - 1.5)
    @NLconstraint(model, y <= sin(x)^2 + 2)

    optimize!(model)

    check_status(model, FEASIBLE_PROBLEM, termination_target, primal_target)
    check_objective(model, 1.8320787790166984, tol = objective_tol)
    return check_solution(
        [x, y],
        [3.2565126525233166, 2.013148549981813],
        tol = primal_tol,
    )
end
