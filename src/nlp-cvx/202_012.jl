m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, -(x+y+2*z))
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

check_status(status)
check_objective(m, -9/4)
check_solution([x,y,z], [1/4, 1/4, 7/8])
