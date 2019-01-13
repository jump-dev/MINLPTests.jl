# Test Goals:
# - linear objective
# - intersection convex quadratic constraints
# Variants
#   010 - one binding constraint (inflection point)
#   011 - one binding constraint (inflection point)
#   012 - one binding constraint (non-inflection point)
#   013 - one binding constraint (non-inflection point)
#   014 - intersection set

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, -z)
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1, atol=opt_tol)
@test isapprox(getvalue(x), 0.0, atol=sol_tol)
@test isapprox(getvalue(y), 0.0, atol=sol_tol)
@test isapprox(getvalue(z), 1.0, atol=sol_tol)
