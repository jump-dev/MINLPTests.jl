m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, x+y)
@NLconstraint(m, x^2 + y^2 <= 1.0)
@constraint(m, x + y >= 1.2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 1.2, atol=opt_tol)
### can't test solution point, here are multiple solutions
#@test isapprox(getvalue(x), 0.974165743715913, atol=sol_tol)
#@test isapprox(getvalue(y), 0.2258342542139504, atol=sol_tol)
