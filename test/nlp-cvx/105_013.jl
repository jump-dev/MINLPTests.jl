m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y)

@objective(m, Min, -x+y)
@NLconstraint(m, exp(x-2.0) - 0.5 <= y)
@NLconstraint(m, log(x) + 0.5 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -3/2, atol=opt_tol)
@test isapprox(getvalue(x), 2, atol=sol_tol)
@test isapprox(getvalue(y), 1/2, atol=sol_tol)
