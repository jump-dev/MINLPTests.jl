m = Model(optimizer)

@variable(m, x, start=0.1)
@variable(m, y, start=0.1)

@NLobjective(m, Max, log(x+y))
@NLconstraint(m, (y-2)^2 <= -x+2)

optimize!(m)

check_status(m)
check_objective(m, log(7/4 + 5/2))
check_solution([x,y], [7/4, 5/2])
