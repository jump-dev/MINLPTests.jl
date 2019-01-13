m = Model(solver=solver)

@variable(m, x, start = 1.5)
@variable(m, y, start = 0.5)

@objective(m, Min, (x-1.0)^2 + (y-1.0)^2)
@NLconstraint(m, x^2 + y^2 <= 1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.17157287363083387, atol=opt_tol)
@test isapprox(getvalue(x), 1/sqrt(2), atol=sol_tol)
@test isapprox(getvalue(y), 1/sqrt(2), atol=sol_tol)
