# Test Goals:
# - non-linear objective and linear, quadratic constraints
# - functions tan, abs, *

m = Model(solver=solver)

@variable(m, -1 <= x <= 1)
@variable(m, y)
@variable(m, z)

@NLobjective(m, Min, tan(x) + y + x*z + 0.5*abs(y))
@constraint(m, x^2 + y^2 + z^2 <= 10)
@constraint(m, -1.2*x - y <= z/1.35)

status = solve(m)

check_status(status)
check_objective(m, -4.87215904079771)
check_solution([x,y,z], [-1, -0.9160817459806899, 2.8567103830800886])
