m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y)

@objective(m, Min, x+y)
@NLconstraint(m, exp(x-2.0) - 0.5 <= y)
@NLconstraint(m, log(x) + 0.5 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.16878271368156372, atol=opt_tol)
@test isapprox(getvalue(x),  0.45538805755556067, atol=sol_tol)
@test isapprox(getvalue(y), -0.28660534387399694, atol=sol_tol)
