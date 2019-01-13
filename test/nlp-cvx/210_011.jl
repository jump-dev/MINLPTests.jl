m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, (x-1.0)^2 + (y-1.0)^2 + (z-1.0)^2)
@NLconstraint(m, x^2 + y^2 + z^2 <= 1.0)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.535898380052066, atol=opt_tol)
@test isapprox(getvalue(x), 1/sqrt(3), atol=sol_tol)
@test isapprox(getvalue(y), 1/sqrt(3), atol=sol_tol)
@test isapprox(getvalue(z), 1/sqrt(3), atol=sol_tol)
