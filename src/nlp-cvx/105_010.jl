# Test Goals:
# - e and log expressions
# - convex constraint, only in given domains
# Variants
#   010 - intersection point
#   011 - intersection point
#   012 - one binding constraint
#   013 - one binding constraint


m = Model(optimizer)

@variable(m, x, start=0.1)
@variable(m, y)

@objective(m, Min, -x-y)
@NLconstraint(m, exp(x-2.0) - 0.5 <= y)
@NLconstraint(m, log(x) + 0.5 >= y)

optimize!(m)

check_status(m)
check_objective(m, -4.176004405036646)
check_solution([x,y], [2.687422019398147, 1.488582385638499])
