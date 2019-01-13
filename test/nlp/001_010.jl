# Test Goals:
# - mix of variable start values
# - non-linear objective without constraints

m = Model(solver=solver)

@variable(m, x, start=1)
@variable(m, y, start=2.12)
@variable(m, z >= 1)

@NLobjective(m, Min, x*exp(x) + cos(y) + z^3 - z^2)

status = solve(m)

check_status(status)
check_objective(m, -1.3678794486503105)
check_solution([x,y,z], [-1, pi, 1])
