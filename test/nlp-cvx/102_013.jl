m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, x^2+y^2)
@NLconstraint(m, x^2 + y^2 <= 1.0)
@constraint(m, x + y >= 1.2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.72, atol=opt_tol)
@test isapprox(getvalue(x), 0.6, atol=sol_tol)
@test isapprox(getvalue(y), 0.6, atol=sol_tol)
