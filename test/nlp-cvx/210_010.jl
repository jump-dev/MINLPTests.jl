# Test Goals:
# - convex objective
# - convex quadratic constraint
# Variants
#   010 - no binding constraints
#   011 - binding constraint
#   012 - binding constraint, different starting point

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, (x-0.5)^2 + (y-0.5)^2 + (z-0.5)^2)
@NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.0, atol=opt_tol)
@test isapprox(getvalue(x), 1/2, atol=sol_tol)
@test isapprox(getvalue(y), 1/2, atol=sol_tol)
@test isapprox(getvalue(z), 1/2, atol=sol_tol)
