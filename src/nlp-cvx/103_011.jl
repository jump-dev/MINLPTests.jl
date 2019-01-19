m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, -y)
@NLconstraint(m, x^2 <= y)
@NLconstraint(m, -x^2 + 1 >= y)

status = solve(m)

check_status(status)
check_objective(m, -1)
check_solution([x,y], [0, 1])
