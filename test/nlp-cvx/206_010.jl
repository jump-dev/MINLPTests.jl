# Test Goals:
# - linear objective
# - intersection convex quadratic constraints
# - power cones
# Variants
#   010 - intersection set

m = Model(solver=solver)

# NOTE, starting any of these at 0.0 will segfault libcoinmumps
@variable(m, x >= 0, start=0.1)
@variable(m, y >= 0, start=0.1)
@variable(m, z >= 0, start=0.1)

@objective(m, Max, 2*x+y+z)
@NLconstraint(m, z <= x^(0.3)*y^(0.7))
@NLconstraint(m, x <= z^(0.7)*y^(0.3))
@NLconstraint(m, x^2 + y^2 <= z+1)

status = solve(m)

@test status == :Optimal
# TODO, figure out why ipopt does not ensure 1e-8 on this case
@test isapprox(getobjectivevalue(m), 4.0, atol=1e-7)
@test isapprox(getvalue(x), 1.0, atol=sol_tol)
@test isapprox(getvalue(y), 1.0, atol=1e-7)
@test isapprox(getvalue(z), 1.0, atol=1e-7)
