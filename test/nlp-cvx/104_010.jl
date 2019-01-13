# Test Goals:
# - redundant nonlinear constraint (feasible set is inside the circle constraint)
# Variants
#   010 - redundant constraint

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, -x)
@NLconstraint(m, x^2 <= y)
@NLconstraint(m, -x^2 + 1 >= y)
@NLconstraint(m, x^2 + (y-0.5)^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1/sqrt(2), atol=opt_tol)
@test isapprox(getvalue(x), 1/sqrt(2), atol=sol_tol)
@test isapprox(getvalue(y), 1/2, atol=sol_tol)
