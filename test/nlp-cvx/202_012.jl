m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, -(x+y+2*z))
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -9/4, atol=opt_tol)
@test isapprox(getvalue(x), 1/4, atol=sol_tol)
@test isapprox(getvalue(y), 1/4, atol=sol_tol)
@test isapprox(getvalue(z), 7/8, atol=sol_tol)
