# Test Goals:
# - cos and sin expressions
# - convex constraint, only in given domains
# Variants
#   010 - intersection point
#   011 - intersection point

m = Model(optimizer)

@variable(m, -3 <= x <= 3)
@variable(m, -1 <= y <= 1)

@objective(m, Min, -x-y)
@NLconstraint(m, sin(-x-1.0) + x/2 + 0.5 <= y)
@NLconstraint(m, cos(x-0.5)+ x/4 - 0.5 >= y)

optimize!(m)

check_status(m)
check_objective(m, -1.8572155128552428)
check_solution([x,y], [1.369771397576555, 0.4874441152786876])