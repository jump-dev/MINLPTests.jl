m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z)

@objective(m, Min, x+y+2*z)
@NLconstraint(m, x^2 + y^2 <= z)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
# TODO, figure out why ipopt does not ensure 1e-8 on this case
@test isapprox(getobjectivevalue(m), -1/4, atol=1e-7)
@test isapprox(getvalue(x), -1/4, atol=sol_tol)
@test isapprox(getvalue(y), -1/4, atol=sol_tol)
@test isapprox(getvalue(z),  1/8, atol=sol_tol)
