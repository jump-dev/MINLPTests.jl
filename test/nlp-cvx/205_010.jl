# Test Goals:
# - linear objective
# - intersection convex quadratic constraints
# - exponential cones
# Variants
#   010 - intersection set

m = Model(solver=solver)

@variable(m, x)
@variable(m, y >= 0, start=0.1)
@variable(m, z)

@objective(m, Max, y)
@NLconstraint(m, y*e^(x/y) <= z)
@NLconstraint(m, y*e^(-x/y) <= z)
@NLconstraint(m, x^2 + y^2 <= -z+5)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 1.7912878443121907, atol=opt_tol)
@test isapprox(getvalue(x), 0.0, atol=sol_tol)
@test isapprox(getvalue(y), 1.7912878443121907, atol=sol_tol)
@test isapprox(getvalue(z), 1.7912878443121907, atol=sol_tol)
