# Test Goals:
# - infeasible model

m = Model(solver=solver)

@variable(m, x)
@variable(m, y)

@NLconstraint(m, y == exp(x))
@constraint(m, x == y^2)

status = solve(m)

check_status(status, target=:Infeasible)
