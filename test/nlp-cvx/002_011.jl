m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@objective(m, Min, (x-3)^2+(y-2)^2)
@constraint(m, 1*x-3*y <= 3)
@constraint(m, 1*x-5*y <= 0)
@constraint(m, 3*x+5*y >= 15)
@constraint(m, 7*x+2*y >= 20)
@constraint(m, 9*x+1*y >= 20)
@constraint(m, 3*x+7*y >= 17)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.0, atol=opt_tol)
@test isapprox(getvalue(x), 3.0, atol=sol_tol)
@test isapprox(getvalue(y), 2.0, atol=sol_tol)
