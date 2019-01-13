# Test Goals:
# - linear objective
# - intersection convex quadratic constraints
# - sqrt cone
# Variants
#   010 - intersection set

m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y, start=0.1)
@variable(m, z)

@objective(m, Min, x+y)
@NLconstraint(m, sqrt(x^2 + y^2) <= z-0.25)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1/sqrt(2), atol=opt_tol)
@test isapprox(getvalue(x), -sqrt(1/8), atol=sol_tol)
@test isapprox(getvalue(y), -sqrt(1/8), atol=sol_tol)
@test isapprox(getvalue(z), 3/4, atol=sol_tol)
