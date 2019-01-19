m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y, start=0.1)

@NLobjective(m, Max, log(x) + log(y))
@NLconstraint(m, (y-2)^2 <= -x+2)

status = solve(m)

check_status(status)
check_objective(m, 1.4853479762665618)
check_solution([x,y], [1.8499011869994715, 2.387425887570236])
