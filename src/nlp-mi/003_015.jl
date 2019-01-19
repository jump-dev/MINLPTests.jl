# Test Goals:
# - quadratic objective as NLobjective and non-linear constraints

m = Model(optimizer)

@variable(m, x, Int)
@variable(m, y, Int)

@NLobjective(m, Max, x^2 + y)
@NLconstraint(m, y >= exp(x-2) - 2)
@NLconstraint(m, y <= sin(x)^2 + 2)

optimize!(m)

check_status(m)
check_objective(m, 11.000000198181866)
check_solution([x,y], [3, 2])
