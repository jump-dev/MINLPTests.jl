# Test Goals:
# - convex objective
# - single simple constraint
# Variants
#   010 - no binding constraints
#   011 - binding constraint
#   012 - binding constraint, different starting point

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, (x-0.5)^2 + (y-0.5)^2)
@NLconstraint(m, x^2 + y^2 <= 1)

status = solve(m)

check_status(status)
check_objective(m, 0)
check_solution([x,y], [1/2, 1/2])
