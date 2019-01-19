# Test Goals:
# - non-linear objective and linear, quadratic constraints as NL

m = Model(optimizer)

@variable(m, -1 <= x <= 1)
@variable(m, y)
@variable(m, z, Int)

@NLobjective(m, Min, tan(x) + y + x*z + 0.5*abs(y))
@NLconstraint(m, x^2 + y^2 + z^2 <= 10)
@NLconstraint(m, -1.2*x - y <= z/1.35)

optimize!(m)

check_status(m)
check_objective(m, -4.5768813091909015)
check_solution([x,y,z], [-0.9969558935432885, -0.07796881265504599, 3])
