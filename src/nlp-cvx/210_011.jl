m = Model(optimizer)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, (x-1.0)^2 + (y-1.0)^2 + (z-1.0)^2)
@NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)

optimize!(m)

check_status(m)
check_objective(m, 0.535898380052066)
check_solution([x,y,z], [1/sqrt(3), 1/sqrt(3), 1/sqrt(3)])
