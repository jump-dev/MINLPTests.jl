# Test Goals:
# - none have start values
# - non-linear objective and non-linear constraints
# - maximization objective

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Max, sqrt(x+0.1))
@NLconstraint(m, y >= exp(x-2) - 2)
@NLconstraint(m, y <= sin(x)^2 + 2)

status = solve(m)

check_status(status)
check_objective(m, 1.8715859432160853)
check_solution([x,y], [3.4028339561149266, 2.0667085252601867])
