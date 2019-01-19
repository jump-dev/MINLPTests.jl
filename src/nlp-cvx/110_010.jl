# Test Goals:
# - convex e objective
# - binding nonlinear constraint
# Variants
#   010 - binding constraint (one variable non-zero)
#   011 - binding constraint (both variables non-zero)
#   012 - binding constraint (both variables non-zero)

m = Model(optimizer)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Min, exp(x))
@NLconstraint(m, x^2 + y^2 <= 1.0)

optimize!(m)

check_status(m)
check_objective(m, exp(-1))
check_solution([x,y], [-1.0, 0.0])
