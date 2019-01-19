m = Model(optimizer)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Min, exp(x) + exp(y))
@NLconstraint(m, x^2 + y^2 <= 1.0)

optimize!(m)

check_status(m)
check_objective(m, 2*exp(-1/sqrt(2)))
check_solution([x,y], [-1/sqrt(2), -1/sqrt(2)])
