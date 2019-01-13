m = Model(solver=solver)

@variable(m, x, start=0.1)
@variable(m, y, start=0.1)

@NLobjective(m, Max, log(x+y))
@NLconstraint(m, (y-2)^2 <= -x+2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), log(7/4 + 5/2), atol=opt_tol)
@test isapprox(getvalue(x), 7/4, atol=sol_tol)
@test isapprox(getvalue(y), 5/2, atol=sol_tol)
