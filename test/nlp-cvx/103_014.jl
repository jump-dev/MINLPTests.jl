m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, -x)
@NLconstraint(m, x^2 <= y)
@NLconstraint(m, -x^2 + 1 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1/sqrt(2), atol=opt_tol)
@test isapprox(getvalue(x), 1/sqrt(2), atol=sol_tol)
@test isapprox(getvalue(y), 1/2, atol=sol_tol)
