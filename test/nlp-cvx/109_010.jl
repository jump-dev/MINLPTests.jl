# Test Goals:
# - convex logarithmic objective
# - binding nonlinear constraint
# Variants
#   010 - binding constraint (inflection point)
#   011 - binding constraint (non-inflection point)
#   012 - binding constraint (non-inflection point)

m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y, start=0.1)

@NLobjective(m, Max, log(x))
@NLconstraint(m, (y-2)^2 <= -x+2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), log(2), atol=opt_tol)
@test isapprox(getvalue(x), 2, atol=sol_tol)
@test isapprox(getvalue(y), 2, atol=sol_tol)
