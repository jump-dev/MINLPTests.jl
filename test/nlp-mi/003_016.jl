# Test Goals:
# - objective with offset

m = Model(solver=solver)

@variable(m, x, Int)
@variable(m, y, Int)

@objective(m, Max, x + pi)
@NLconstraint(m, y >= exp(x-2) - 2)
@NLconstraint(m, y <= sin(x)^2 + 2)

status = solve(m)

check_status(status)
check_objective(m, 6.141592682680717)
check_solution([x,y], [3, 2])
