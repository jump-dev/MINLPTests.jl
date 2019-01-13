# Test Goals:
# - e and log expressions
# - convex constraint, only in given domains
# Variants
#   010 - intersection point
#   011 - intersection point
#   012 - one binding constraint
#   013 - one binding constraint


m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y)

@objective(m, Min, -x-y)
@NLconstraint(m, exp(x-2.0) - 0.5 <= y)
@NLconstraint(m, log(x) + 0.5 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -4.176004405036646, atol=opt_tol)
@test isapprox(getvalue(x), 2.687422019398147, atol=sol_tol)
@test isapprox(getvalue(y), 1.488582385638499, atol=sol_tol)
