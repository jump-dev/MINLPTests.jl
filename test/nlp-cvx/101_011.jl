m = Model(solver=solver)

@variable(m, -2 <= x <= 2)
@variable(m, -2 <= y <= 2)

@objective(m, Min, -x)
@NLconstraint(m, x^2 + y^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1, atol=opt_tol)
@test isapprox(getvalue(x), 1, atol=sol_tol)
@test isapprox(getvalue(y), 0, atol=sol_tol)
