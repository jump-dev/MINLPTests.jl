m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@NLobjective(m, Min, exp(x+y))
@NLconstraint(m, x^2 + y^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), exp(-2/sqrt(2)), atol=opt_tol)
@test isapprox(getvalue(x), -1/sqrt(2), atol=sol_tol)
@test isapprox(getvalue(y), -1/sqrt(2), atol=sol_tol)
