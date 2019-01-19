m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, (x-0.65)^2+(y-0.65)^2)
@NLconstraint(m, x^2 + y^2 <= 1.0)
@constraint(m, x + y >= 1.2)

status = solve(m)

check_status(status)
check_objective(m, 0)
check_solution([x,y], [0.65, 0.65])
