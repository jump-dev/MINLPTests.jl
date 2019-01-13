m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, x+y)
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1.0, atol=opt_tol)
@test isapprox(getvalue(x), -1/2, atol=sol_tol)
@test isapprox(getvalue(y), -1/2, atol=sol_tol)
@test isapprox(getvalue(z), 1/2, atol=sol_tol)
