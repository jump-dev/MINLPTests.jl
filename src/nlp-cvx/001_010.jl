# Test Goals:
# - linear objective
# - quadratic objective
# - linear constraints forming a closed set
# Variants
#   010 - binding constraints
#   011 - non-binding constraints 

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, x)
@constraint(m, x+y <= 5)
@constraint(m, 2*x-y <= 3)
@constraint(m, 3*x+9*y >= -10)
@constraint(m, 10*x-y >= -20)
@constraint(m, -x+2*y <= 8)

status = solve(m)

check_status(status)
check_objective(m, -2.0430107680954848)
check_solution([x,y], [-2.0430107680954848, -0.4301075068564087])
