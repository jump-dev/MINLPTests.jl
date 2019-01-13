m = Model(solver=solver)

@variable(m, x >= 0)
@variable(m, y >= 0)

@objective(m, Min, (x-3.0)^2 + y^2)
@NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
@NLconstraint(m, y^2 <= -x+2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 1.5240966871955863, atol=opt_tol)
@test isapprox(getvalue(x), 1.8344380292075626, atol=sol_tol)
@test isapprox(getvalue(y), 0.40689308108892147, atol=sol_tol)
