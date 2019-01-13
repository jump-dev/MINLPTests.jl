# Test Goals:
# - convex objective
# - intersection of constraints
# - convex constraint, only in positive domain
# Variants
#   010 - no binding constraints
#   011 - intersection point
#   012 - intersection point
#   013 - one binding constraint

m = Model(solver=solver)

@variable(m, x >= 0)
@variable(m, y >= 0)

@objective(m, Min, (x-1.0)^2 + (y-0.75)^2)
@NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
@NLconstraint(m, y^2 <= -x+2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.0, atol=opt_tol)
@test isapprox(getvalue(x), 1.00, atol=sol_tol)
@test isapprox(getvalue(y), 0.75, atol=sol_tol)
