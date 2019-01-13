# Test Goals:
# - all have start values
# - non-linear constraints without objective

m = Model(solver=solver)

@variable(m, x, start=  1)
@variable(m, y, start= -1.12)

@NLconstraint(m, y == log(x) - 0.1)
@NLconstraint(m, x == cos(y)^2+1.5)

status = solve(m)

check_status(status)
check_objective(m, 0.0)
check_solution([x,y], [2.1285148443189033, 0.6554244804634232])
