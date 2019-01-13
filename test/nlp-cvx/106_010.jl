# Test Goals:
# - cos and sin expressions
# - convex constraint, only in given domains
# Variants
#   010 - intersection point
#   011 - intersection point

m = Model(solver=solver)

@variable(m, -3 <= x <= 3)
@variable(m, -1 <= y <= 1)

@objective(m, Min, -x-y)
@NLconstraint(m, sin(-x-1.0) + x/2 + 0.5 <= y)
@NLconstraint(m, cos(x-0.5)+ x/4 - 0.5 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1.8572155128552428, atol=opt_tol)
@test isapprox(getvalue(x), 1.369771397576555, atol=sol_tol)
@test isapprox(getvalue(y), 0.4874441152786876, atol=sol_tol)
