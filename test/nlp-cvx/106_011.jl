m = Model(solver=solver)

@variable(m, -3 <= x <= 3)
@variable(m, -1 <= y <= 1)

@objective(m, Min, x+y)
@NLconstraint(m, sin(-x-1.0) + x/2 + 0.5 <= y)
@NLconstraint(m, cos(x-0.5)+ x/4 - 0.5 >= y)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -0.7868226265935826, atol=opt_tol)
@test isapprox(getvalue(x), -0.5955231764562057, atol=sol_tol)
@test isapprox(getvalue(y), -0.1912994501373769, atol=sol_tol)
