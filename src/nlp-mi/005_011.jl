# Test Goals:
# - function \

m = Model(optimizer)

@variable(m, x >= 0, Int)
@variable(m, y >= 0)

@objective(m, Min, x + y)
@NLconstraint(m, y >= (x+0.1)\1 - 0.5)
@NLconstraint(m, x >= y^(-2) - 0.5)
@NLconstraint(m, (x+y+0.1) \ 4 >= 1)

optimize!(m)

check_status(m)
check_objective(m, 1.8164965727459055)
check_solution([x,y], [1, 0.816496581496872])
