m = Model(solver=solver)

@variable(m, -2 <= x <= 2)
@variable(m, -2 <= y <= 2)

@objective(m, Min, -x)
@NLconstraint(m, x^2 + y^2 <= 1.0)

status = solve(m)

check_status(status)
check_objective(m, -1)
check_solution([x,y], [1, 0])
