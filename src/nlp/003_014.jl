# Test Goals:
# - quadratic objective and non-linear constraints

m = Model(optimizer)

@variable(m, x)
@variable(m, y)

@objective(m, Max, x^2 + y)
@NLconstraint(m, y >= exp(x-2) - 2)
@NLconstraint(m, y <= sin(x)^2 + 2)

optimize!(m)

check_status(m)
check_objective(m, 13.645987504086483)
check_solution([x,y], [3.4028339561149266, 2.0667085252601867])
