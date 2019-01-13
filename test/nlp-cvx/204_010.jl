# Test Goals:
# - linear objective
# - intersection convex quadratic constraints
# - rotated second order cone
# Variants
#   010 - intersection set

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)
@variable(m, z >= 0, start=0.1)

@objective(m, Min, -y-x)
@NLconstraint(m, x^2/z <= y)
@NLconstraint(m, x^2 + y^2 <= -z+1)

status = solve(m)

@test status == :Optimal
@test isapprox(getobjectivevalue(m), -1.2071067837918394, atol=opt_tol)
@test isapprox(getvalue(x), 0.353553392657669, atol=sol_tol)
@test isapprox(getvalue(y), 0.8535533911341705, atol=sol_tol)
@test isapprox(getvalue(z), 0.14644661317207716, atol=sol_tol)
