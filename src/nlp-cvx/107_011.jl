m = Model(optimizer)

@variable(m, x)
@variable(m, y)

@objective(m, Min, (x-1.0)^2 + (y-1.0)^2)
@NLconstraint(m, x^2 + y^2 <= 1)

optimize!(m)

check_status(m)
check_objective(m, 0.17157287363083387)
check_solution([x,y], [1/sqrt(2), 1/sqrt(2)])
