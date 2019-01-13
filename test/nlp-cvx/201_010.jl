# Test Goals:
# - linear objective
# - single convex quadratic constraint
# Variants
#   010 - binding constraint (all variables non-zero)
#   011 - binding constraint (one variable non-zero)

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, -(x+y+z))
@NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -3/sqrt(3), atol=opt_tol)
@test isapprox(getvalue(x), 1/sqrt(3), atol=sol_tol)
@test isapprox(getvalue(y), 1/sqrt(3), atol=sol_tol)
@test isapprox(getvalue(z), 1/sqrt(3), atol=sol_tol)
