m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, (x-1)^2 + (y-2)^2)
@constraint(m, x+y <= 5)
@constraint(m, 2*x-y <= 3)
@constraint(m, 3*x+9*y >= -10)
@constraint(m, 10*x-y >= -20)
@constraint(m, -x+2*y <= 8)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.0, atol=opt_tol)
@test isapprox(getvalue(x), 1.0, atol=sol_tol)
@test isapprox(getvalue(y), 2.0, atol=sol_tol)
