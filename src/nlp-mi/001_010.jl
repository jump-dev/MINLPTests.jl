# Test Goals:
# - mix of variable start values
# - non-linear objective without constraints
# - minimization objective
# - functions ^, exp, cos
# - integer variable
# - mix of discrete and continuous variables

m = Model(optimizer)

@variable(m, x, start=1)
@variable(m, y >= 0.1, start=3.12, Int)
@variable(m, z >= 1)

@NLobjective(m, Min, x*exp(x) + cos(y) + z^3 - z^2)

optimize!(m)

check_status(m)
check_objective(m, -1.35787195018718)
check_solution([x,y,z], [-1, 3, 1])
