# Test Goals:
# - convex e objective
# - binding nonlinear constraint
# Variants
#   010 - binding constraint (one variable non-zero)
#   011 - binding constraint (both variables non-zero)
#   012 - binding constraint (both variables non-zero)

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Min, exp(x))
@NLconstraint(m, x^2 + y^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), exp(-1), atol=opt_tol)
@test isapprox(getvalue(x), -1.0, atol=sol_tol)
@test isapprox(getvalue(y),  0.0, atol=sol_tol)
