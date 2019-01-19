m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Min, exp(x+y))
@NLconstraint(m, x^2 + y^2 <= 1.0)

status = solve(m)

check_status(status)
check_objective(m, exp(-2/sqrt(2)))
check_solution([x,y], [-1/sqrt(2), -1/sqrt(2)])
