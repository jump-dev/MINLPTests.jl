# Test Goals:
# - linear and nonlinear constraints
# Variants
#   010 - constraint intersection
#   011 - one binding constraint (linear)
#   012 - one binding constraint (nonlienar)
#   013 - one binding constraint (quadratic objective)
#   014 - no binding constraints (quadratic objective)

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, -x)
@NLconstraint(m, x^2 + y^2 <= 1.0)
@constraint(m, x + y >= 1.2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -0.974165743715913, atol=opt_tol)
@test isapprox(getvalue(x), 0.974165743715913, atol=sol_tol)
@test isapprox(getvalue(y), 0.2258342542139504, atol=sol_tol)
