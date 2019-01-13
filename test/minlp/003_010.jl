# Test Goals:
# - none have start values
# - non-linear objective and non-linear constraints
# - maximization objective
# - integer variables

m = Model(solver=solver)

@variable(m, x, Int)
@variable(m, y, Int)

@NLobjective(m, Max, sqrt(x+0.1))
@NLconstraint(m, y >= exp(x-2) - 2)
@NLconstraint(m, y <= sin(x)^2 + 2)

status = solve(m)

check_status(status)
check_objective(m, 1.7606816937762844)
check_solution([x,y], [3, 2])
