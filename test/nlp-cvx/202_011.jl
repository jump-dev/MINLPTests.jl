m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, z)
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.0, atol=opt_tol)
@test isapprox(getvalue(x), 0.0, atol=sol_tol)
@test isapprox(getvalue(y), 0.0, atol=sol_tol)
@test isapprox(getvalue(z), 0.0, atol=sol_tol)
