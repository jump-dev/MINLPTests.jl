m = Model(solver=solver)

@variable(m, x >= 0)
@variable(m, y >= 0)

@objective(m, Min, x^2 + y^2)
@NLconstraint(m, 2*x^2 - 4x*y - 4*x + 4 <= y)
@NLconstraint(m, y^2 <= -x+2)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), 0.8112507770394088, atol=opt_tol)
@test isapprox(getvalue(x), 0.6557120892286371, atol=sol_tol)
@test isapprox(getvalue(y), 0.6174888121082234, atol=sol_tol)
